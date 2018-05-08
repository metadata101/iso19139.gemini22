# GEMINI 2.2 schema plugin

This is the GEMINI 2.2 schema plugin for GeoNetwork 3.4.x or greater version.

## Installing the plugin

### GeoNetwork version to use with this plugin

Use GeoNetwork 3.4.0+ version.
This will not work in earlier versions of the software.

### Adding the plugin to the source code

The best approach is to add the plugin as a submodule into GeoNetwork schema module.

```
cd schemas
git submodule add -b 3.4.x https://github.com/AstunTechnology/iso19139.gemini22_GN3 iso19139.gemini22
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
  <version>${project.version}</version>
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

Once the application is build, the war file contains the schema plugin:

```
$ mvn clean install -Penv-prod
```

### Deploy the profile in an existing installation

After building the application, it's possible to deploy the schema plugin manually in an existing GeoNetwork installation:

- Copy the content of the folder schemas/iso19139.gemini22/src/main/plugin to INSTALL_DIR/geonetwork/WEB-INF/data/config/schema_plugins/iso19139.gemini22 

- Copy the jar file schemas/iso19139.gemini22/target/schema-iso19139.gemini22-3.2.1-SNAPSHOT.jar to INSTALL_DIR/geonetwork/WEB-INF/lib.

If there's no changes to the profile Java code or the configuration (config-spring-geonetwork.xml), the jar file is not required to be deployed each time.
