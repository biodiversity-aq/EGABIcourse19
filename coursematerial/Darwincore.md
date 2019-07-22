# Darwin Core

* [Introduction](## Introduction)
* [Darwincore Structure](## Darwincore Structure)
* [Types of Darwincore Archives] (## Types of Darwincore Archives)

## Introduction

The Darwin Core (DwC) is a body of standards maintained by[TDWG](https://www.tdwg.org)  (Biodiversity Information Standards, formerly The International Working Group on Taxonomic Databases).
It includes a glossary of terms intended to facilitate the sharing of information about biological diversity by providing reference definitions, examples, and commentaries. The Darwin Core is primarily based on taxa, their occurrence in nature as documented by observations, specimens, and samples, and related information.

Darwin Core revolves around a standard file format, the Darwin Core Archive (DwC-A). This compact package (a ZIP file) contains interconnected text files and enables data publishers to share their data using a common terminology. DwC is used both by [GBIF] (www.gbif.org) and [OBIS] (www.obis.org) for publishing data.
 
This standardization not only simplifies the process of publishing biodiversity datasets, it also makes it easy for users to discover, search, evaluate and compare datasets as they seek answers to today’s data-intensive research and policy questions.


## Darwincore Componets
A DWC-A can contains 4 types of components. These files can include:

* eml.xml
* core file
* extension files (optional)
* meta.xml

eml stands for [Ecological Metadata Language] (https://en.wikipedia.org/wiki/Ecological_Metadata_Language), This files contains the dataset metadata in an xml format.

Core and extension files contain data records, arranged one per line. Each row in the extension file or extension record points to a single record in the core file; For each single core record many extension records. This is sometimes referred to as a “star schema”.

the meta.xml describes how the files i the archive are organised. It describes the linkage between the core and extension files and maps non-standards column names to darwin Core terms.

To publish the data as a DwC-A, We recommend to upload the core and extension files to the IPT (e.g. [IPT.biodiversity.aq] (http://IPT.biodiversity.aq)). Use the IPT's built-in metadata editor to enter dataset metadata. The IPT will compile th eml on the data you provided As wel as the meta.xml. If you want to 

## Types of Darwincore Archives
* Metadata
* Checklist
* Occurence
* Event

Used to share information about a specific instance of a taxon such as a specimen or observation.

Used to share annotated species checklists, taxonomic catalogues, and other information about taxa

Used to share information about ecological investigations 

