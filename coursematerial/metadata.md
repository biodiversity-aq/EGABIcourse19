# Metadata DWC-A

In general metadata eml  will accompany some data core in a DwC-A. 
It provides a description and details on the resource.

It is also  possible to initially only publish your metadata and add your data at a later stage.

This allows researchers to discover resources that or not yet available online.
It is best to consider your abstract as the material and methods section of your paper but then for just your data.
Try to provide as much detail as possible.

Actually if you fill out your metadat extensively you have a first very good draft for a datapaper (if that is something you would like to make). you'll just have to add some maps sumarry statitics and your are good to go.

If you do are in a hurry below is an overview of what currently are the required fields.


If you use the IPT to create your Darwincore archive. you will have to choose a shortname for your dataset. Choose this wisely because it can't be changed. The short name serves as an identifier within the IPT installation, and will be used as a parameter in the URL to access the resource via the Internet.

For the short name you can only alphanumeric characters, hyphens, or underscores.



##Required metadata fields:

###Basic Metadata

#### title
> This will be the long title of your dataset, and how the dataset will be cited

#### publishing organisation
>Please select the organisation responsible for publishing (producing, releasing, holding) this resource. It will be used as the resource's publishing organisation when registering this resource with GBIF and when submitting metadata during DOI registrations. It will also be used to auto-generate the citation for the resource (if auto-generation is turned on), so consider the prominence of the role. Please be aware your selection cannot be changed after the resource has been either registered with GBIF or assigned a DOI.

On our IPT you can choose

* Antarctic Biodiversity Information Facility (AntaBIF) for terrestrial datasets
* SCAR - AntOBIS for marine datasets
* SCAR - Microbial Antarctic Resource System for microbial datasets

We can also publish on behalf of others. Currently we have agreements with

* British Antarctic Survey
* Itanian Antarctic National Museum (MNA, section Genua)
 

#### type
>The type of resource. The value of this field depends on the core mapping of the resource and is no longer editable if the Darwin Core mapping has already been made.

This can be

* Metadata-only
* Checklist
* Occurence
* Event-Core

#### metadata language
>The language in which the metadata document is written.

#### data language
>The primary language in which the described data (not the metadata document) is written.

#### Update Frequency
>The frequency with which changes are made to the resource after the initial resource has been published. For convenience, its value will default to the auto-publishing interval (if auto-publishing has been turned on), however, it can always be overridden later. Please note a description of the maintenance frequency of the resource can also be entered on the Additional Metadata page.

#### data license
>The licence that you apply to a dataset provides a standardized way to define appropriate uses of your work. GBIF encourages publishers to adopt the least restrictive licence possible from among three machine-readable options (CC0 1.0, CC-BY 4.0 or CC-BY-NC 4.0) to encourage the widest possible use and application of data. Learn more here. If you are unable to choose one of the three options, and your dataset contains occurrence data, you will not be able to register your dataset with GBIF or make it globally discoverable through GBIF.org. If you feel unable to select one of the three options, please contact the GBIF Secretariat at participation@gbif.org.


#### description
>A brief overview of the resource that is being documented broken into paragraphs.

Think of it as an abstract for a (data) paper

#### Resource contact(s)
#### Resource creator(s)
#### metadata provider(s)
* Last name
* Position
* Organisation
	
###Geographic coverage
#### description



Citation auto generation

Creator 1 R, Creator 2 R, Creator 3 R (2019): How to create a metadata record. v1. Publishing roganisation. Dataset/Type. https://ipt.biodiversity.aq/resource?r=shortname&amp;v=1.0

example
Griffiths H J, Linse K, Crame J (2017): SOMBASE – Southern Ocean mollusc database: a tool for biogeographic analysis in diversity and evolution. v1.6. British Antarctic Survey. Dataset/Occurrence. https://ipt.biodiversity.aq/resource?r=sombase_southern_ocean_mollusc_database&amp;v=1.6


