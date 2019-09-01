library(ncdf4)
library(raster)
library(dismo)
library(gbm)

#### Open occurrence records ####
#---------------------------------
occ.sterechinus <- read.csv("data/occurrences_sterechinus.csv", header=T, sep=";")
# head(occ.sterechinus)

#### Open Environmental descriptors layers and stack them together ####
#-----------------------------------------------------------------------
depth <- raster("data/environmental_layers/depth.nc")
sediments <- raster("data/environmental_layers/sediments.nc")
seafloor_temp_2005_2012_max <- raster("data/environmental_layers/seafloor_temp_2005_2012_max.nc")
POC_2005_2012_max <- raster("data/environmental_layers/POC_2005_2012_max.nc")
seafloor_current_speed <- raster("data/environmental_layers/seafloor_current_speed.nc")

predictors_stack <- stack(depth,sediments,seafloor_temp_2005_2012_max,POC_2005_2012_max,seafloor_current_speed)

## have a look at your descriptors properties 
#..............................................
#predictors_stack
#plot(predictors_stack)

# have a look at the distribution of occurrences 
#.................................................
#plot(depth)
#points(occ.sterechinus[,c(2,1)], pch=20) # longitude first, latitude second

#--------------------------------------------------------------------------------------------------------------
# Open the KDE layer of sampling effort, on which the background data will be sampled (by weighting) 
# The KDE (Kernel Density Estimation) is a statistical tool that helps to measure the probability of finding
# an occurrencce on each pixel, according to the set of benthic records sampled in the entire Southern Ocean 
# (update from the Biogeographic Atlas of the Southern Ocean)
#--------------------------------------------------------------------------------------------------------------
KDE <- raster("data/KDE.asc")
# on this layer, the continents are defined by pixels containing NA values
# it enables R to recognise later on the areas where the background data shoud 
# not be sampled 
#-----------------------------------------------------------------------------------------

#### Set up 
#-------------
cv.boot <- 2 # number of replicates (# of times models are launched/replicated)
source("scripts/Function_gbm.R")

#### Stack of empty data and matrices to fill
#----------------------------------------------------------

stack.pred<-subset(predictors_stack,1);values(stack.pred)<-NA
#testvaluesp<-rep(NA,nrow(fichier_data)) ; testvaluesa <- testvaluesp

model_stats <- matrix(NA, 6, cv.boot*4,dimnames = list(c("AUC", "COR", "TSS", "maxSSS", "valid_test_data","prop_test"), NULL))

# Stores the contribution
contTr <- matrix(NA, dim(predictors_stack)[3], cv.boot, dimnames = list(names(predictors_stack), NULL))
n.seed <- seq(1,60,1)[-c(4,5,17,28,32,41,45,46,48,53)] # controls and fixes the random sampling (to compare results more accurately) 

for (j in 1:cv.boot){

  #------------------------------------------------------------
  #### create the matrix of occurrence-environment 
  #------------------------------------------------
  envi.presences <- unique(extract (predictors_stack,occ.sterechinus[,c(2,1)]))
  presence.data <- occ.sterechinus[-which(duplicated(extract(predictors_stack,occ.sterechinus[,c(2,1)]))),c(2,1)]; colnames(presence.data)<- c("longitude","latitude")
  # the function 'unique' enables to remove the duplicates that may be contained in the dataset (occurrences found in a same pixel); 'duplicated' aims at spotting which of these rows are similar 
  #head(envi.presences)
  # the presence data will be associated to ID=1
  
  set.seed(n.seed[j])
  # sampling of background data : in the loop, changes at each replicate 
  # 1000 background data are randomly sampled in the environment, according to the weighting scheme of the KDE layer 
  background_data <- xyFromCell(KDE, sample(which(!is.na(values(KDE))), 200, prob=values(KDE)[!is.na(values(KDE))]))

  colnames(background_data) <- colnames(presence.data)
  # extract environmental conditions where the background data are sampled 
  envi.background <- extract(predictors_stack,background_data)
  # the background data will be associated to ID=0

  # Initialise the matrix containing presence, background data and the environmental values associated 
  id<-0;sdmdata.unique<-0;  id<-c(rep(1,nrow(envi.presences)),rep(0,nrow(envi.background))) 
  MATRIX_OCC_ENVI<-data.frame(cbind(id,rbind(envi.presences,envi.background)))
  #head(MATRIX_OCC_ENVI)

  # Split of the occurrence-background dataset into folds of test/training data (spatially segregated)
  dat1 <- rbind(cbind(background_data, Isp=rep(0,nrow(background_data))), cbind(presence.data,Isp=rep(1,nrow(presence.data)))); colnames(dat1)<- c("longitude","latitude","Isp")
  #tail(dat1)
  idP <- which(dat1$Isp == 1) #  id of presence data to split them 
  MyFold <- rep(NA, nrow(dat1)) # an empty box to store the group of the data (1 to 4 afterwards)
  
  source("scripts/clock4_crossValidation.R")
  clock4F <- clock4(dat1[idP, c("longitude", "latitude")], dat1[-idP, c("longitude", "latitude")])
  
  # Extracts the folds
  MyFold[idP] <- clock4F$occ.grp
  MyFold[-idP] <- clock4F$bg.coords.grp
  plot(dat1[,c("longitude", "latitude")], pch = 20, col = c("red", "blue","black","purple")[as.factor(MyFold)])
  
  #--------------------------
  #### launch the model  ! 
  #--------------------------
  model.res<- gbm.step_v2 (data=MATRIX_OCC_ENVI, 
                         gbm.x = 2:ncol(MATRIX_OCC_ENVI),
                         gbm.y = 1,
                         family = "bernoulli",
                         n.folds=4,
                         fold.vector = MyFold, 
                         tree.complexity = 3,
                         learning.rate = 0.015,
                         bag.fraction =0.5)

  #------------------------------------------------------------
  #### Extract data and model outputs 
  #------------------------------------------------------------
  # Predictions 
  p<-predict(predictors_stack,model.res,n.trees=model.res$gbm.call$best.trees,type="response", na.rm=F)
  stack.pred<-stack(stack.pred,p) # stack all the maps replicates 
  
  ########
  ## CV ## (= on CV folds)
  ########
    j_cv <- ((j-1) * 4+1):(j*4) # to count the folds 
  
  model_stats["AUC", j_cv] <- model.res$cv.roc.matrix
  model_stats["COR", j_cv] <- model.res$cv.cor.matrix
  model_stats["TSS", j_cv] <- model.res$tss.cv
  model_stats["maxSSS", j_cv] <- model.res$cv.th.matrix

  ## correctly classified test data 
  model_stats["valid_test_data", j_cv] <- model.res$cv.corr.class*100
  model_stats["prop_test", j_cv] <- model.res$cv.length*100
  
  # Get contributions 
  RI <- summary(model.res, plotit = F) # extract the contribution
  contTr[match(RI$var, rownames(contTr)), j] <- RI[,"rel.inf"]

}

#------------------------
#### Maps of predictions 
#------------------------
mean_stack <- raster::calc(stack.pred, mean, na.rm=T); mean_stack <- mask(mean_stack, depth)
#sd_stack <- raster::calc(stack.pred,sd, na.rm=T); sd_stack <- mask(sd_stack, depth)

# you can plot the results 
#continent <- read.csv("data/worldmap.csv") # add continents lines 
#plot(mean_stack) ; points(continent, type="l")

# this is an approximate map, if you want to have a nicer representation, you can 
# export the ascii document and open it on another software such as Qgis or other
# writeRaster(mean_stack, "results/mean_raster.asc")
# writeRaster(sd_stack, "results/sd_raster.asc")

#---------------------
#### Model statistics 
#---------------------
ecM <- apply(model_stats, 1, mean, na.rm=T)
ecSD <- apply(model_stats, 1, sd, na.rm=T)
ecTot <- paste(round(ecM, 3), round(ecSD, 3), sep = " ± ")
names(ecTot) <- names(ecM)

ResF <- data.frame(c(ecTot["AUC"],ecTot["COR"],ecTot["TSS"],ecTot["maxSSS"], ecTot["valid_test_data"], ecTot["prop_test"]))
rownames(ResF) <- c("AUC","COR","TSS", "maxSSS",  "Correctly classified test data", "Test data (% of total dataset)") ; colnames(ResF) <- "Model average statistics"

# matrix of raw results 
#model_stats
# average values 
#ResF

# same, you can export the results 
#write.csv(model_stats,"results/model_stats.csv"))

## Contribution of environmental descriptors 
# raw data 
#contTr

# calculate the average 
CtM <- apply(contTr, 1, mean)
CtSD <- apply(contTr, 1, sd)
CtTot <- paste(round(CtM, 3), round(CtSD, 3), sep = " ± ")
names(CtTot) <- names(CtM)

CtTot <- data.frame(CtTot) ; colnames(CtTot) <- "Contribution (%) of environmental descriptors to the model"
#write.csv(CtTot, "results/avg_contribution.csv")


####---------------------------------------------------------------------------
####---------------------------------------------------------------------------
### CALCULATE EXTRAPOLATION 
# Multivariate Environmental Similarity Surface (Elith et al. 2010) 
# envi.presences <- unique(extract (predictors_stack,occ.sterechinus[,c(2,1)]))
# x <- dismo::mess(predictors_stack, na.omit(envi.presences))
# 
# y <- x; values(y)<- values(x)>0  # refers to Elith et al. (2010): when the calculated MESS values are negative, it means that it is extrapolating (outside of boundaries)
# y <- reclassify(y,cbind(FALSE,0)) # extrapolation area 
# y <- reclassify(y,cbind(TRUE,1))  # non extrapolation, inside the boundaries of calibration
# 
# plot(y)

####---------------------------------------------------------------------------
####---------------------------------------------------------------------------

