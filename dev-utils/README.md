# Running Locally #

## Prerequisites ##

* [s2i](https://github.com/openshift/source-to-image)
* [docker](https://www.docker.com/)

## Digipolis Package Repositories ##
### .NetCore ###
Add nuget.config to your local setup. Add Digipolis Myget.org credentials to nuget.config. Ask servicefactory [at] digipolis [dot] gent for credentials.
Find more information on nuget.config [here](https://docs.microsoft.com/en-us/nuget/consume-packages/configuring-nuget-behavior). 

### Java ###
All required configuration files are provided in this repository.
Set envars for NEXUS_USER & NEXUS_PASSWORD. Ask servicefactory [at] digipolis [dot] gent for credentials.

### Node ###
Use the `.npmrc` file in the root of your project to connect to the *Digipolis NPM repositry* in the *Sonatype Repository manager*. 

https://nexussfqa.gent.be/repository/npm-public/

Inject `NEXUS_CREDENTIALS` as a environment variable. The value is a base64 representation of your nexus username and nexus passord in the form: `username:password`. See [Build environment variables](#build-environment-variables)

## Environmental variables ##

Set up these envars in your local machine to make the application go. You can find all the neccesary envars [here](../README.md#environment-variables). 

## Build and run ##

We provide 3 scripts you can use to build and run the application on your machine. They are all located in the dev-utils folder. 

You can add additional parameters to each script to skip the build or to skip starting the application. 
```
$ build.sh skip-build
$ build.sh skip-start
```

This script will make local docker images with s2i using the source code from the local current branch
```
$ build.sh
```
This script will make local docker images with s2i using the source code from the remote master branch
```
$ build_master.sh
```
This script will make local docker images with s2i using the source code from the remote develop branch
```
$ build_develop.sh
```

## Run the application ##

If you have run the build scripts previously and just want to start the application you can do so with docker-compose. 

```
$ docker-compose up
```

## If all else fails, i.e. I do not use docker  ##
### Java ###

### dotnet core ###

### node ###

[back](../README.md)