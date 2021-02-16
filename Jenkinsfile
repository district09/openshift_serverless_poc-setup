#!/usr/bin/env groovy

/**

Set following parameters that will be passed to the shared Jenkins pipeline. 

kind: The type of Jenkins slave that will conduct the CICD build. 
- maven
- netcore21
- netcore22 (DEPRECATED)
- netcore31
- node8

namespace: Openshift namespace without environment suffix, i.e.:
- "services" 
- "dossier"

service: Array with names of the components to be build and deployed by CICD, i.e.:
- ["jobsheduler-api"]
- ["email-api","email-worker"]

dotnetFolder: base path of source code
dotnetSlnFile: path from base path to csproj file. Use sln file in netcore31 and up!
dotnetTestFolder: folder that contains csproj file for tests. We prefix the dotnetFolder in the background!
dotnetTestFile: name of the test csproj file

**/

dgPipeline  kind: "$kind", 
            namespace: "$namespace", 
            service: ["$component1","$component2"],
            buildScript: "", 
            templatepath: "", 
            dotnetFolder: "",
            dotnetSlnFile: "", 
            dotnetTestFolder: "",
            dotnetTestFile: ""
