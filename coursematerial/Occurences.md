# Occurences
In general the more information you provide the more knowledge can be gained from them.

The first user of this data is future **yourself**. Taking the time to be as detailed in providing and descrbing your data is time you will gain in the future when you want to reanalyse your data or integrate it in a broader study.

The best way is to save the data in some tabular format, something like a csv-file ot Tab delimted txt. It is not recomended to use excel. As this software has the habbit of giving you unwanted help, resulting in messed up data...

Here we start with a description of the minimal data you should provide in order to analyse your data, including developping a species distribution modeling.

Each row in your dataset should corespong to and observation.
The names of the columns in the dataset should correspond to DwC terms.

You can find a full description of the Darwincore Terms in the [Darwin Core quick reference guide] (https://dwc.tdwg.org/terms/). 

your data should allow you or anybody else to determine

- What
- Where
- When
- Who
- How


The Darwincore Standards has 8 absolutely required terms. **occurrenceID, eventDate, decimalLongitude, decimalLatitude, scientificName, scientificNameID, occurrenceStatus, basisOfRecord**

But as said it is better to use a couple more.







## What
### occurrenceID

Additonal Terms

*institutionCode*, *collectionCode*, *catalogNumber*

**occurrenceID** is an identifier for the occurrence record and should be globally unique and persistent. 

### scientificName and scientificNameID

Additional Terms

*scientificNameAuthorship*, *IdentificationQualifier*, *taxonrank*

*identifiedBy*, *dateIdentified*, *typeStatus*


### occurrenceStatus

Additional Terms

*organismQuantity*, *organismQuantityType*

### basisOfRecord


## Where
### decimalLatitude and decimalLongitude

Additional Terms

*geodeticDatum*, *coordinateUncertaintyInMeters*, *locality*, *locationID*, *footprintWKT*


##When

**eventDate**
Additional Terms

*year*, 
*month*,
*Day*,
*Time*,
*Timezone*



##Who


Ship/colection

*identifiedBy*, *dateIdentified*


if from literature
citation

##How
Gear




