# README #
*Insert short description of the application here.*

## Features ##

Check the [API's features](./openapi/FEATURES.MD).

## Security ##
Always keep following security rules in mind when using credentials (apiKeys, passwords, tenantId's, secrets, ...). By asking and using Digipolis credentials you agree to and respect these security rules. Share there rules among all developers.

Direct all your security questions and problems to security [dot] officer [at] digipolis [dot] gent

### Do's ###

* Store credentials in a password manager. Use by example the Digipolis Passwordstate.
* Use environment variables to make credentials available to your applications.
* If this is not possible check for secure alternatives for your technology
* Share credentials using point-to-point communication and only to the people that need the credentials.  (email, im, ...) (not: ticketing systems, group chats, reply all email, ...).
* Avoid sharing credentials after initial exchange

### Don'ts ###

* Don't hard code credentials
* Don't communicate credentials with clients
* client side storage, client side code, ...)
* Don't store credentials in public or private repositories (Github, Bitbucket, ...)
*  Don't store credentials in documentation (Confluence, Jira, ...)

## Source code ##
* Add all source code to the [src](./src) folder.

## API Contract ##
* [OpenAPI & asyncAPI](./openapi/README.md)

## Running locally ##
Read the [documentation](./dev-utils/README.md) provided in the dev-utils folder to build and run the application locally.

## Dependencies

Check out the available dependency and package managers in the [documentation](./dev-utils/README.md) under Digipolis Package Repositories. 

## Testing the application ##
We run integration tests on our applications in CICD using the [Karate framework](https://github.com/intuit/karate). See the [testing documentation](./karate/README.md) on how to run the tests locally and more information. 

## Build environment variables ##
Here you will find all environment variables used in an s2i build to docker or openshift. Feed these envars to your local s2i build or openshift build config.

Envar | Required | Default | Description
:---|:---:|:---:|:---
MAVEN_ARGS | if maven build | see openshift configmap | The Maven arguments used in a s2i build
ARTIFACT_DIR | if maven build | target | The artifact dir that s2i get its compiled binary's from
NEXUS_PASSWORD | if using digipolis nexus | in openshift secret | Pasword to connect to the Digipolis Nexus
NEXUS_USER | if using digipolis nexus | in openshift secret | User to connect to the Digipolis Nexus
NEXUS_CREDENTIALS | if using digipolis nexus for **nodejs builds** | in openshift secret | Base64 Username and password for http authentication
DOTNET_RESTORE_SOURCES | if using digipolis myget / nuget repositories | in openshift secret | Authorization URI that points to the nuget repositories
DOTNET_STARTUP_PROJECT | if dotnet build | in openshift config map | The location of the dotnet csproj file that contains the startup project

## Deployment environment variables ##
Here you will find all environment variables used to deploy the application to docker or openshift. Feed these envars to your local deployment or openshift deployment config.

#### component-name ####
Envar | Required | Default | Description
:---|:---:|:---:|:---
1 | **yes** | default | 2
2 | no | no-default | 3

#### List of required envars ####
##### Database #####
* DB_USER (Secret)
* DB_PASSWORD (Secret)
* DB_HOST
* DB_PORT
* DB_PROTOCOL
* DB_DRIVER
* DB_CONNECTION_STRING
* DB_DEFAULT_TTL
* DB_MAX_TTL

##### Event broker #####
* AMQ_USER/AMQ_USER_XXX (Secret)
* AMQ_PASSWORD/AMQ_PASSWORD_XXX (Secret)
* AMQ_HOST
* AMQ_PORT
* AMQ_PROTOCOL
* AMQ_DRIVER
* AMQ_QUEUE_PREFIX
* AMQ_DLQ
* AMQ_EVENT_XXX
* AMQ_QUEUE_XXX
* AMQ_TOPIC_XXX
* AMQ_POOL

##### Application specifics #####
* APP_ENVIRONMENT
* APP_LOG_LEVEL
* APP_MOCKING
* APP_SERVE_SWAGGER
* APP_SERVE_ASYNCAPI
* APP_PORT
* APP_SCHEME
* APP_NAMESPACE_PREFIX
* APP_VERSION*

##### Healthcheck speficis #####
* HEALTH_MAX_QUEUE_SIZES_XXX
* HEALTH_MAX_REPOSITORY_ENTRIES_XXX

##### About application info #####
* INFO_ID
* INFO_NAME
* INFO_DESCRIPTION
* INFO_PROTOCOL
* INFO_OWNERS
* INFO_VERSION
* INFO_HOST
* INFO_PROJECT_REPO
* INFO_PROJECT_HOME

##### For connections with other API's #####
* API_KEY_XXX (S)
* API_URL_XXX
* IDP_OIDC_CLIENTKEY

## Monitoring & Logging ##
#### APM ####
We provide 4 variables in a Openshift secret (apm-secrets) to connect to our Elastic APM. This secret is available in all our Openshift projects.  
* SECRETTOKEN 
* SERVERURL
* SERVERCERT
* CENTRALCONFIG

You MUST add 2 specific variables in the templates so APM knows what it is monitoring
* Service name
* Service environment (DV, QA or PR)

All 6 variables MUST be added to the deployment configurations!

To find out what specific environment variabels to map in your code see the [APM Agents documentation](https://www.elastic.co/guide/en/apm/agent/index.html).

## CICD ##
Mainly [Jenkins](https://jenkins.io/) in combination with [Openshift Container Platform](https://www.openshift.com/) and other cloud based platforms are used for builds and deployments onto the Digipolis Service Factory.

See the [Jenkinsfile](./Jenkinsfile) to define the CICD pipiline. 

See the [openshift](./openshift/README.md) folder to define the Openshift configuration. 

## Issues ##
Log and track issues in our [Jira](https://digipolisgent.atlassian.net/)

### Architecture ###
*Insert Architecture Design here.*

## API Documentation ##
* [Digipolis API Guidelines](https://github.com/digipolisgent/api-guidelines)
* [Service Factory Confluence](https://digipolisgent.atlassian.net/wiki/spaces/SF/overview)
* [Developer Portal DV](https://developerdv.gent.be/)
* [Developer Portal DV](https://developerqa.gent.be/)
* [Developer Portal DV](https://developer.gent.be/)

## Documentation Version ##

Find the latest version of this template repository [here](https://github.com/digipolisgent/github_template_servicefactory) on Github. 

Version | Date | Description | Author
:---:|:---:|:---:|:---:
0.1 | 2020/02/05 | Initial version | Digipolis
0.2 | 2020/04/03 | Add API Features | Digipolis
0.3 | 2020/06/04 | Added additional karate test documentation | Digipolis
0.4 | 2020/08/14 | Added parameters to Openshift templates & APM | Digipolis
