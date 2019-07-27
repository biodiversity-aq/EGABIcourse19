# Occurences
In general the more information you provide the more knowledge can be gained from them.

The first user of this data is future **yourself**. Taking the time to be as detailed in providing and describing your data is time you will gain in the future when you want to reanalyse your data or integrate it in a broader study.

The best way is to save the data in some tabular format, something like a csv-file ot Tab delimted txt. It is not recomended to use excel. As this software has the habit of giving you unwanted help, resulting in messed up data...

Here we start with a description of the minimal data you should provide in order to analyse your data, including developing a species distribution modeling.

Each row in your dataset should corresponding to an observation.
The names of the columns in the dataset should correspond to DwC terms.

You can find a full description of the Darwincore Terms in the [Darwin Core quick reference guide](https://dwc.tdwg.org/terms/). 

your data should allow you or anybody else to determine What, Where, When, Who and How


The Darwincore Standards has 8 absolutely required terms. **basisOfRecord, occurrenceID, scientificName, scientificNameID, occurrenceStatus, decimalLongitude, decimalLatitude, eventDate**


Besides those we recommend a number of other ones as well. In eneral it is better to provide as many as you can.


**basisOfRecord**

- *type*
- *associatedReferences*

**occurrenceID**

- *institutionCode*
- *collectionCode*
- *catalogNumber*

**scientificName, scientificNameID**

- *scientificNameAuthorship*
- *IdentificationQualifier*
- *taxonrank*

**occurrenceStatus**

- *organismQuantity*
- *organismQuantityType*
- *sex*
- *lifeStage*
- *behavior*
- *occurrenceRemarks*
- *identifiedBy*
- *dateIdentified*


## What

### basisOfRecord

Additional term

*[type](https://dwc.tdwg.org/terms/#dwc:type)*, 
*[associatedReferences](https://dwc.tdwg.org/terms/#dwc:associatedReferences)*

[basisOfRecord](https://dwc.tdwg.org/terms/#dwc:basisOfRecord) describes the nature of record. It has a to follow a specific vocabulary. Some of these might overlap sometimes. That is why it is usefull to use *[type](https://dwc.tdwg.org/terms/#dwc:type)* as well.


- **PreservedSpecimen** A specimen that has been preserved. This can be a museum specimen, a plant on an herbarium sheet, fish in a bag in a freezer.
- **FossilSpecimen** A resource describing a fossilized specimen.
- **LivingSpecimen** A resource describing a living specimen. For instance an animal in a zoo.
- **MaterialSample** A resource describing a material sample. For instance Material sample from an organism in the wild and sample put into a collection (blood sample, biopsy).
- **HumanObservation** A resource describing an observation made by one or more people. For instance an organism observed in the wild and written in field notes. Samples that were collected during an expedition but thrown back into the sea.
- **MachineObservation** An output of a machine observation 
process. Any kid of automated sensor like camera traps, anipi
- **Occurence** A resource describing an instance of the Occurrence class. NOTE: this value is ambiguous and hence should only be used when the when the resource type is unknown.


*[type](https://dwc.tdwg.org/terms/#dwc:type)* 

The nature or genre of the resource. Must be populated with a value from the [DCMI type vocabulary](http://dublincore.org/documents/2010/10/11/dcmi-type-vocabulary/).

Options include
Image, StillImage, MovingImage, Interactive Resource, PhysicalObject, Sound, Text, PhysicalObject, Collection, Dataset, Event, Service, Software

*[associatedReferences](https://dwc.tdwg.org/terms/#dwc:associatedReferences)* 
A list (concatenated and separated) of identifiers (publication, bibliographic reference, global unique identifier, URI) of literature associated with the Occurrence.


Example: If you want to add a record from literature you should use *basisOfRecord:*HumanObservation with *type:*Text in combination with *associatedReferences:*Bibiographic reference



### [occurrenceID](https://dwc.tdwg.org/terms/#dwc:occurrenceID)

Additonal Terms

*[institutionCode](https://dwc.tdwg.org/terms/#dwc:institutionCode)*, *[collectionCode](https://dwc.tdwg.org/terms/#dwc:collectionCode)*, *[catalogNumber](https://dwc.tdwg.org/terms/#dwc:catalogNumber)*

**[occurrenceID](https://dwc.tdwg.org/terms/#dwc:occurrenceID)** is an identifier for the occurrence record and should be globally unique and persistent. 
In the absence of a persistent global unique identifier, construct one from a combination of identifiers in the record that will most closely make the occurrenceID globally unique. It is recommende to use. Something like the combination of institutionCode, collectionCode, and catalogNumber is a generally used format.

There are a number of other terms that you could use as well like datasetName and datasetID

**[institutionCode](https://dwc.tdwg.org/terms/#dwc:institutionCode)**
The name (or acronym) in use by the institution having custody of the object(s) or information referred to in the record.

**[institutionID](https://dwc.tdwg.org/terms/#dwc:institutionID)**
An identifier for the institution having custody of the object(s) or information referred to in the record.

For physical specimens, the recommended best practice is to use a code and identifier from a collections registry such as the Global Registry of Biodiversity Repositories [(http://grbio.org/)](http://grbio.org/).

Institution code| Institution name
---|---
AAS|British Antarctic Survey
BRM|Alfred-Wegener-Institut für Polar- und Meeresforschung
MNA|The Museo Nazionale dell'Antartide (Italian National Antarctic Museum in Genoa)
RBINS|Royal Belgian Institute of Natural Sciences

**[collectionCode](https://dwc.tdwg.org/terms/#dwc:collectionCode)**
The name, acronym, coden, or initialism identifying the collection or data set from which the record was derived.

**[datasetName](https://dwc.tdwg.org/terms/#dwc:datasetName)** 
The name identifying the data set from which the record was derived.

**[datasetID](https://dwc.tdwg.org/terms/#dwc:datasetID)**
An identifier for the set of data. May be a global unique identifier or an identifier specific to a collection or institution.


**[catalogNumber](https://dwc.tdwg.org/terms/#dwc:catalogNumber)**
An identifier (preferably unique) for the record within the data set or collection.

**[recordNumber](https://dwc.tdwg.org/terms/#dwc:recordNumber)**
An identifier given to the Occurrence at the time it was recorded. Often serves as a link between field notes and an Occurrence record, such as a specimen collector's number.

occurrenceID|institutionCode | collectionCode|catalogNumber
---|---|---|---|--
http://arctos.database.museum/guid/MSB:Mamm:233627|MSB|Mamm|233627
 PS89\_FF\_000023|PS89|FF|000023
 
 It is a good practice to keep your catalogue/record numbers of equal length throughout your dataset.

To keep it persistent just don't change it. If you reference another source, keep the number.
For example if you have samples that were collected during an marine expedition usually all sampling events get ther own ID. Don't invent a new ID for the event. This will help you to find any information related to that event at a later stage.




### [scientificName](https://dwc.tdwg.org/terms/#taxon) and [scientificNameID](https://dwc.tdwg.org/terms/#taxon)

Additional Terms

*scientificNameAuthorship*, *IdentificationQualifier*, *taxonrank*

Additional Additional Terms

*identifiedBy*, *dateIdentified*, *typeStatus*

[scientificName](https://dwc.tdwg.org/terms/#taxon) In the spirit of keeping things persistent this should always contain the originally recorded scientific name, even if the name is currently a synomym (If the sample is reidentified this is of course a different case). The scientific name should always be to the lowest possible taxonomic rank of which you are certain. In case of uncertain identifications, and the scientific name contains qualifiers such as cf., ? or aff., then this name should go in identificationQualifier.


The use of **confer** meaning compare and abbeviated to *cf.* in a scientific name means that the person using the name is saying the animal should be compared to a given species, as it might not be exactly the same species. It’s a way of applying a provisional name to a species and is most frequently used when new fish are discovered that look slightly different to the form normally encountered. It indicates that the fish might be a variant of the same species, but could also turn out to be something completely different.

**Species affinis** (commonly abbreviated to: sp. aff., aff., or affin.) indicates that available material or evidence suggests that the proposed species is related to, has an affinity to, but is not identical to, the species with the binomial name that follows. 

**Species** abbreviated as sp. is commonly occurs when authors are confident that some individuals belong to a particular genus but are not sure to which exact species they belong.

Authors may also use "spp." (**Species pliralis**) as a short way of saying that something applies to many species within a genus, but not to all.



nr|scientificName | scientificNameID | scientificNameAuthorship | IdentificationQualifier| taxonrank
---|---|---|---|---|---|---
1|Electrona|urn:lsid:marinespecies.org:taxname:125821|Goode & Bean, 1896|aff. risso|genus
2|Electrona antarctica|urn:lsid:marinespecies.org:taxname:217697|(Günther, 1878) | |Species|
3|Electrona|urn:lsid:marinespecies.org:taxname:125821|Goode & Bean, 1896|sp.|genus
4|Electrona|urn:lsid:marinespecies.org:taxname:125821|Goode & Bean, 1896|spp.|genus

What are you saying with that?

- Case 1:  "I collected something that looks like Electrona risso but I'm not sure."
- Case 2:  "I'm 100% sure this is Electrona antarctica)
- Case 3: "I'm sure about the genus, but it could be any one of multiple species"
- Case 4: "I have this bag with fish sure about the genus but it could be a variety of species within the genus"

### occurrenceStatus

Additional Terms

*organismQuantity*, *organismQuantityType*


occurrenceStatus is a statement about the presence or absence of a taxon at a location. It is an important term, because it allows us to distinguish between presence and absence records. It is an OBIS required term and should be filled in with either present or absent.

*organismQuantity*, *organismQuantityType*
These two always go together. organismQuantity is a number for the quantity of animals and organismQuantityType defines the type of quantification system used for the quantity of organisms.

organismQuantity | organismQuantityType
---|---
27|individuals
12.5|%biomass
r | BraunBlanquetScale

There are a few other terms as well that we want to mention. The old term that was used was individualCount but that wasn't really versatile. Still in some cases it can be usefull to mention it.

Please take note that OBIS recommends all quantitative measurements and sampling facts to be treated in the ExtendedMeasurementOrFact extension and not in the Darwin Core files. OBIS recomends using ExtendedMeasurementOrFact in combination with Darwin Core Event Core, which is a little more advanced.

*sex*
The sex of the biological individual(s) represented in the Occurrence.. The OBIS recommended vocabulary for sex see [BODC vocab : S10](http://vocab.nerc.ac.uk/collection/S10/current/)

*lifeStage*
The age class or life stage of the biological individual(s) at the time the Occurrence was recorded. The OBIS recommended vocabulary for lifestage is [BODC vocab: S11](http://vocab.nerc.ac.uk/collection/S10/current/)

*behavior*
The behavior shown by the subject at the time the Occurrence was recorded. behavior (no OBIS recomended vocab available)

*occurrenceRemarks* can hold any comments or notes about the Occurrence.


## Where
### decimalLatitude, decimalLongitude and geodeticDatum

Additional Terms

*coordinateUncertaintyInMeters*, *locality*, *locationID*, *footprintWKT*

To determine the location of a point on a globe you need at least the decimalLatitude and decimalLongitude and and a definition of the spatial reference system that was used. The Spatial reference System defines the model of the earts shape that us used.   

The System currently used by GPS is WGS 84 (also known as WGS 1984, EPSG:4326). Quite often the geodeticDatum is not provided but it is actually essential.

decimalLatitude defines the position relative to the equator an ranges from 90° (Norh Pole) to -90 (South Pole)

decimalLongitude defines the position relative to the Greenwich Meridian and ranges from 180 to -180.

Mak sure not to swith those around. The standard notation has them as Lattitude followed by Longitude. In the decimal notations they are sometimes switched around as this corresponds more to a cartesian notation. Especially for samples collected in the area of the Antarctic peninsula these switches can be hard to spot.

*coordinateUncertaintyInMeters*
The horizontal distance (in meters) from the given decimalLatitude and decimalLongitude describing the smallest circle containing the whole of the Location. Leave the value empty if the uncertainty is unknown, cannot be estimated, or is not applicable (because there are no coordinates). Zero is not a valid value for this term.
This one is actually closely linked to the number of decimals in your decimalLatitude, decimalLongitude

In cases where decimal latitude are calcullated they often get to much digits. If you have more than five it doesn't real make sense anymore.

To explain it, you can cheeos this XKCD commic or the table below.

<img src="/images/coordinate_precision_XKCD.png" alt="coordinate precisionXKCD"
	title="coordinate precision XKCD" width="400"  align="center"/>



decimal places	| decimal degrees	|DMS|	Object that can be unambiguously recognized at this scale|	N/S or E/W at equator		|E/W at 67N/S|
---|---|---|---|---|---
0|1.0|1° 00′ 0″|country or large region|111.32 km|43.496 km
1|	0.1|	0° 06′ 0″	|large city or district |11.132 km |4.3496 km
2|	0.01|	0° 00′ 36″	|town or village	|1.1132 km |434.96 m
3|	0.001|	0° 00′ 3.6″	|neighborhood, street |111.32 m |43.496 m
4|	0.0001|	0° 00′ 0.36″	|individual street, land parcel |11.132 m |4.3496 m
5|	0.00001|	0° 00′ 0.036″	|individual trees, door entrance |1.1132 m |434.96 mm
6|	0.000001|	0° 00′ 0.0036″|	individual humans |111.32 mm |43.496 mm
7|	0.0000001|	0° 00′ 0.00036″	|practical limit of commercial surveying |11.132 mm |4.3496 mm|
8|	0.00000001|	0° 00′ 0.000036″	|specialized surveying (e.g. tectonic plate mapping) |1.1132 mm	|434.96 µm



##When

**eventDate**
Additional Terms

*year*, 
*month*,
*Day*,
*Time*,
*Timezone*



**eventDate**  The date-time when the occurence/event was recorded. Can be the date-time or interval during which an Event. This term uses the ISO 8601 standard. OBIS recommends using the extended ISO 8601 format with hyphens.

<img src="/images/iso_8601_time_XKCD.png" alt="iso 8601 time XKCD"
	title="iso 8601 time XKCD" width="400"  align="center"/>

For time intervals ISO 8601 uses / as a separator. 
Date and time are separated by T. 
Times can have a time zone indicator at the end, if this is not the case then the time is assumed to be local time. 
When a time is UTC, a Z is added. Some examples of ISO 8601 dates are:

1973-02-28T15:25:00
2005-08-31T12:11+12
1993-01-26T04:39+12/1993-01-26T05:48+12
2008-04-25T09:53
1948-09-13
1993-01/02
1993-01
1993

It is an option to split out the eventDate into its seperate components. This can be a goood safeguard against software lie excel reformatin your dates and times.

*year*, 
*month*,
*Day*,
*Time*,
*Timezone*

*verbatimEventDate* You can put the original date format here, not really needed but might be usefull. 


##Who

*identifiedBy*, *dateIdentified*

*identifiedBy*
A list (concatenated and separated) of names of people, groups, or organizations who assigned the Taxon to the subject. Recommended best practice is to separate the values in a list with space vertical bar space ( | )

This one is very seldom filled out but it is actually an import one and it should be specific, it should be the person that did the actual odentification not the suprvisor.

In case of a reindetification at some point it is usefull to contact the person that did the initial identification.

##How
samplingProtocol
For describing a specific gear we recomend using [BODC vocab : L22](https://www.bodc.ac.uk/resources/vocabularies/vocabulary_search/L22/)







