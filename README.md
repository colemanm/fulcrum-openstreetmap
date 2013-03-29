# fulcrum2osm

A small converter for making Fulcrum .csv exports into .osm files for OpenStreetMap. It's designed to be used with specifically-designed Fulcrum apps for mapping different point feature types.

Currently there are apps for mapping:

* Buildings
* Power & telecom
* Park & recreational structures
* Surveillance cameras

## Install deps

```shell
bundle install
```

## Usage

To see available tasks for converting:

```shell
./fulcrum2osm.rb help
```

### Example

```shell
./fulcrum2osm.rb surveillance -f exported_file.csv > cameras.osm
```

You can then open your data in JOSM for upload to OpenStreetMap. The converter builds the appropriate tags from your Fulcrum data.