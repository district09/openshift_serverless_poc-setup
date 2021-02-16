# Openshift Configuration #

This folder contains the Openshift configuration files required for deployments using our CICD tool and Openshift Application Platform. 

We have a configuration file for each environment. These files contain all necessary templates for a complete Openshift build and deployment.
* [openshift-dv.yml]()
* [openshift-qa.yml]()
* [openshift-pr.yml]()

*Please do not change the names of the files.*

## Openshift template #

An Openshift template consists of at least 4 objects. Each object defines a kubernetes object in Openshift. 
* ImageStream
* BuildConfig
* DeploymentConfig
* Service

Additional objects can be used.
* Route
* ServiceAccount
* ...

## Parameters ##

Sample templates are provided that use parameters which can be used when creating a single-componet repository. 

## Metadata object ##

The metadata object should be consistent among all objects. 
```
  metadata:
    name: $COMPONENT
    namespace: $NAMESPACE
    labels:
      app: $APPLICATION
      component: $COMPONENT
```

## Environment variables ##

All environment variables used by the application are configured in the DeploymentConfig. Secrets and configmaps are added in Openshift. 
```
spec:
  containers:
  - env:
    - name: PASSWORD
      valueFrom:
        secretKeyRef:
          name: COMPONENT-secrets
          key: PASSWORD
    - name: CONFIGMAP
      valueFrom:
        configMapKeyRef:
          name: COMPONENT-configmap
          key: sampleConfig
    - name: ENVAR
      value: update
```

[back](../README.md)