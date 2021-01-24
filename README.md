# GEMINI 2.2 schema plugin for GeoNetwork 3.8.x and 3.10x alongside GEMINI 2.3

This is the GEMINI 2.2 schema plugin for GeoNetwork 3.8.x and 3.10x, where GEMINI 2.3 is also installed. Switch to the appropriate branch in this repository for versions that work with Geonetwork 3.0, 3.2 and 3.4, or that do not require GEMINI 2.3.

### GeoNetwork version to use with this plugin

Use GeoNetwork 3.8.0+ or 3.10x.

**This will not work in earlier or later versions of the software.**

## Installing the plugin in GeoNetwork 3.10.x (recommended version)

### Adding to an existing installation

* Download or clone this repository, ensuring you choose the correct branch (3.8.x).
* Copy `src/main/plugin/iso19139.gemini22` to `INSTALL_DIR/geonetwork/WEB_INF/data/config/schema_plugins/iso19139.gemini22` in your installation.
* Copy `target/schema-iso19139.gemini22-3.7.jar` to `INSTALL_DIR/geonetwork/WEB_INF/lib`
* Restart GeoNetwork
* Check that the schema is registered by visiting Admin Console -> Metadata and Templates -> Standards in GeoNetwork. If you do not see iso19139.gemini22 then it is not correctly deployed.  Check your GeoNetwork log files for errors.
* Adding the plugin to the source code prior to compiling GeoNetwork

### The best approach is to add the plugin as a submodule. Use https://github.com/geonetwork/core-geonetwork/blob/3.8.x/add-schema.sh for automatic deployment:

```
.\add-schema.sh iso19139.gemini22 http://github.com/metadata101/iso19139.gemini22 3.8.x
```

## Installing the plugin in GeoNetwork 3.8.x (deprecated)

### Adding to an existing installation

* Download and extract https://github.com/AstunTechnology/geonetwork-pr4039-pr3569/blob/master/geonetwork_38x_310x_patches.zip and overwrite the xslt and WEB_INF folders with the ones from the zip file.
* Download or clone this repository, ensuring you choose the correct branch. Copy `src/main/plugin/iso19139.gemini22` to `INSTALL_DIR/geonetwork/WEB_INF/data/config/schema_plugins/iso19139.gemini22` in your installation and restart GeoNetwork
* Check that the schema is registered by visiting Admin Console -> Metadata and Templates -> Standards in GeoNetwork. If you do not see iso19139.gemini22 then it is not correctly deployed. Check your GeoNetwork log files for errors.

### Adding the plugin to the source code prior to compiling GeoNetwork

The best approach is to add the plugin as a submodule. Use https://github.com/geonetwork/core-geonetwork/blob/3.8.x/add-schema.sh for automatic deployment:

.\add-schema.sh iso19139.gemini22 http://github.com/metadata101/iso19139.gemini22 3.8.x