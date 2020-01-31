# GEMINI 2.2 schema plugin for 3.4.x alongside GEMINI 2.3

This is the GEMINI 2.2 schema plugin for GeoNetwork 3.4.x, where GEMINI 2.3 is also installed. Switch to the appropriate branch in this repository for versions that work with Geonetwork 3.0 and 3.2, or that do not require GEMINI 2.3.

## Installing the plugin

### GeoNetwork version to use with this plugin

Use GeoNetwork 3.4.0+.
**This will not work in earlier or later versions of the software.**

### Specific steps for this branch of Gemini 2.2

 - Clone the core-geonetwork repository 3.4.x branch and initialise and update submodules as described in https://github.com/geonetwork/core-geonetwork/tree/3.4.x/software_development
 - Before building the application, apply PR/4039 (https://github.com/geonetwork/core-geonetwork/pull/4039). 
 - Add the schema plugin from this branch as shown below
 - Make the change to `EditorHelperDirective.js` as shown outlined in https://github.com/AstunTechnology/iso19139.gemini23/issues/3#issuecomment-528806426
 - Proceed to the **Build the application** step below (note that the jar file step is not required)

Note that the file changes outlined above can be applied to an existing build or deployed application. Ensure that the javascript cache is cleared, and the service is restarted, to pick up the changes.

### Adding the plugin to the source code

Add the plugin as a submodule into the GeoNetwork schema module ensuring you choose the correct branch:

```
cd schemas
git submodule add -b 3.4.x-Gemini23 https://github.com/AstunTechnology/iso19139.gemini22_GN3 iso19139.gemini22
```

Add the new module to the schema/pom.xml:

```
  <module>iso19139</module>
  <module>iso19139.gemini22</module>
</modules>
```

Add the dependency in the web module in web/pom.xml:

```
<dependency>
  <groupId>${project.groupId}</groupId>
  <artifactId>schema-iso19139.gemini22</artifactId>
  <version>${gn.schemas.version}</version>
</dependency>
```

Add the module to the webapp in web/pom.xml:

```
<execution>
  <id>copy-schemas</id>
  <phase>process-resources</phase>
  ...
  <resource>
    <directory>${project.basedir}/../schemas/iso19139.gemini22/src/main/plugin</directory>
    <targetPath>${basedir}/src/main/webapp/WEB-INF/data/config/schema_plugins</targetPath>
  </resource>
```

### Build the application

Once the application is built, the war file contains the schema plugin:

```
$ mvn clean install -Penv-prod -DskipTests
```

### Deploy the profile in an existing installation

After building the application, it's possible to deploy the schema plugin manually in an existing GeoNetwork installation:

- Copy the content of the folder schemas/iso19139.gemini22/src/main/plugin to INSTALL_DIR/geonetwork/WEB-INF/data/config/schema_plugins/iso19139.gemini22 

- Copy the jar file schemas/iso19139.gemini22/target/schema-iso19139.gemini22-3.2.1-SNAPSHOT.jar to INSTALL_DIR/geonetwork/WEB-INF/lib.

If there's no changes to the profile Java code or the configuration (config-spring-geonetwork.xml), the jar file is not required to be deployed each time.

### Note changes to display of validation panel in Geonetwork 3.4.x

In Geonetwork 3.4.x the display of the validation panel has been removed from the settings panel to the config-editor for the schema. This enables you to enable or disable the validation panel on a per-schema, per-view basis. In this repository the panel has been enabled in both **default** and **advanced** view. To disable it in a particular view in layout/config-editor.xml, comment out the sidepanel directive, which looks like the code below.

    <sidePanel>
        <directive data-gn-onlinesrc-list=""/>
        <directive gn-geo-publisher=""
                   data-ng-if="gnCurrentEdit.geoPublisherConfig"
                   data-config="{{gnCurrentEdit.geoPublisherConfig}}"
                   data-lang="lang"/>
        <directive data-gn-validation-report=""/>
        <directive data-gn-suggestion-list=""/>
        <directive data-gn-need-help="user-guide/describing-information/creating-metadata.html"/>
      </sidePanel>
