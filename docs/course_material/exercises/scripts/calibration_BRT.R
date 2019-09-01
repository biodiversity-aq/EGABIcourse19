
#### Open environmental data and occurrences (run_yOur_SDM.R file)
#---------------------------------------------------------
# compute there the MATRIX_OCC_ENVI variable (1 set)
# in the run_yOur_SDM.R file, run until the MyFold definition 
# for set.seed(1) (j=1)
# run the model and compare the predictive deviance according to the set of parameters chosen
#=============================================================
source("scripts/Function_gbm.R")
tc=4   # tree complexity
lr=0.011 # learning rate
bf=0.8 # bag fraction

model.res<- gbm.step_v2 (data=MATRIX_OCC_ENVI, 
                         gbm.x = 2:ncol(MATRIX_OCC_ENVI),
                         gbm.y = 1,
                         family = "bernoulli",
                         n.folds=4,
                         fold.vector = MyFold, 
                         tree.complexity = tc,
                         learning.rate = lr,
                         bag.fraction =bf)

model1<-model.res  # tc3 lr0.001 bf=0.8 nbt 10000
model2<-model.res  # tc4 lr0.001 bf=0.8 nbt 10000 
model3<-model.res  # tc4 lr0.005 bf=0.8 nbt 10000 
model4<-model.res  # tc3 lr0.005 bf=0.8 nbt 10000 
model5<-model.res  # tc4 lr0.01 bf=0.8 nbt 10000 
model6<-model.res  # tc4 lr0.008 bf=0.8 nbt 10000 
model7<-model.res  # tc4 lr0.005 bf=0.9 nbt 10000 
model8<-model.res  # tc4 lr0.011 bf=0.8 nbt 10000 


# GENERATE THE PLOTS 
tree.list1 <- seq(100, model1$gbm.call$best.trees, by = 100)
tree.list2 <- seq(100, model2$gbm.call$best.trees, by = 100)
tree.list3 <- seq(100, model3$gbm.call$best.trees, by = 100)
tree.list4 <- seq(100, model4$gbm.call$best.trees, by = 100)
tree.list5 <- seq(100, model5$gbm.call$best.trees, by = 100)
tree.list6 <- seq(100, model6$gbm.call$best.trees, by = 100)
tree.list7 <- seq(100, model7$gbm.call$best.trees, by = 100)
tree.list8 <- seq(100, model8$gbm.call$best.trees, by = 100)

pred1 <- predict.gbm(model1,MATRIX_OCC_ENVI, n.trees = tree.list1, "response")
pred2 <- predict.gbm(model2,MATRIX_OCC_ENVI, n.trees = tree.list2, "response")
pred3 <- predict.gbm(model3,MATRIX_OCC_ENVI, n.trees = tree.list3, "response")
pred4 <- predict.gbm(model4,MATRIX_OCC_ENVI, n.trees = tree.list4, "response")
pred5 <- predict.gbm(model5,MATRIX_OCC_ENVI, n.trees = tree.list5, "response")
pred6 <- predict.gbm(model6,MATRIX_OCC_ENVI, n.trees = tree.list6, "response")
pred7 <- predict.gbm(model7,MATRIX_OCC_ENVI, n.trees = tree.list7, "response")
pred8 <- predict.gbm(model8,MATRIX_OCC_ENVI, n.trees = tree.list8, "response")

graphe.deviance1 <- rep(0,max(tree.list1)/100)
for (i in 1:length(graphe.deviance1)) {
  graphe.deviance1 [i] <- calc.deviance(MATRIX_OCC_ENVI$id, pred1[,i],calc.mean=T)
}
graphe.deviance2 <- rep(0,max(tree.list2)/100)
for (i in 1:length(graphe.deviance2)) {
  graphe.deviance2 [i] <- calc.deviance(MATRIX_OCC_ENVI$id, pred2[,i],calc.mean=T)
}
graphe.deviance3 <- rep(0,max(tree.list3)/100)
for (i in 1:length(graphe.deviance3)) {
  graphe.deviance3 [i] <- calc.deviance(MATRIX_OCC_ENVI$id, pred3[,i],calc.mean=T)
}
graphe.deviance4 <- rep(0,max(tree.list4)/100)
for (i in 1:length(graphe.deviance4)) {
  graphe.deviance4 [i] <- calc.deviance(MATRIX_OCC_ENVI$id, pred4[,i],calc.mean=T)
}
graphe.deviance5 <- rep(0,max(tree.list5)/100)
for (i in 1:length(graphe.deviance5)) {
  graphe.deviance5 [i] <- calc.deviance(MATRIX_OCC_ENVI$id, pred5[,i],calc.mean=T)
}
graphe.deviance6 <- rep(0,max(tree.list6)/100)
for (i in 1:length(graphe.deviance6)) {
  graphe.deviance6 [i] <- calc.deviance(MATRIX_OCC_ENVI$id, pred6[,i],calc.mean=T)
}
graphe.deviance7 <- rep(0,max(tree.list7)/100)
for (i in 1:length(graphe.deviance7)) {
  graphe.deviance7 [i] <- calc.deviance(MATRIX_OCC_ENVI$id, pred7[,i],calc.mean=T)
}
graphe.deviance8 <- rep(0,max(tree.list8)/100)
for (i in 1:length(graphe.deviance8)) {
  graphe.deviance8 [i] <- calc.deviance(MATRIX_OCC_ENVI$id, pred8[,i],calc.mean=T)
}

par(mai=c(0.5,0.5,0.5,0.5))
plot(tree.list1,graphe.deviance1,xlim = c(-100,4000), ylim=c(0,1),type='l', xlab = "number of trees",ylab = "predictive deviance", cex.lab = 1.5) 
lines(tree.list2,graphe.deviance2,col="blue")
lines(tree.list3,graphe.deviance3,col="red")
lines(tree.list4,graphe.deviance4,col="green")
lines(tree.list5,graphe.deviance5,col="orange")
lines(tree.list6,graphe.deviance6,col="pink")
lines(tree.list7,graphe.deviance7,col="deepskyblue")
lines(tree.list8,graphe.deviance8,col="purple")
legend("topright",legend=c("tc3 lr0.001 bf=0.8","tc4 lr0.001 bf=0.8","tc4 lr0.005 bf=0.8 ","tc3 lr0.005 bf=0.8","tc4 lr0.01 bf=0.8","tc4 lr0.008 bf=0.8","tc4 lr0.005 bf=0.9","tc4 lr0.011 bf=0.8"),col=c("black","blue","red","green","orange","pink","deepskyblue","purple"),pch=16,cex=0.7)

