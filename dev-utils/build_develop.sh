 #!/bin/bash
#####
#
# Build all docker images we need for testing the service, this included all of its dependencies
#
# Usage: 
#   ./build.sh - build images and start dockers
#   ./build.sh skip-start - just build, do not start dockers from local repo
#   ./build.sh skip-build - dont build, just start dockers from local repo
#
####

set -e

echo "Cleaning up previous run"
docker-compose down || true
echo ""

if [ "$1" != "skip-build" ]; then
  export PATH=$PATH:/usr/local/bin
  echo "Cleaning up dangling docker resources"
  docker system prune -f || true
  echo ""
  echo "Building docker images from source"
  echo ""
  echo "$COMPONENT_NAME"
  s2i build $GIT_REPO_REF -r 'develop' $REDHAT_BASE_IMAGE $COMPONENT_NAME \
    -e "ARTIFACT_DIR=$COMPONENT1_SRC/target" \
    -e "NEXUS_USER=$NEXUS_USER" \
    -e "NEXUS_PASSWORD=$NEXUS_PASSWORD" \
    -e "DOTNET_RESTORE_SOURCES=$DOTNET_RESTORE_SOURCES" \
    -e "DOTNET_STARTUP_PROJECT=$DOTNET_STARTUP_PROJECT"
  echo "$COMPONENT_NAME docker image built succesfully"
  echo ""
  echo "$COMPONENT2_NAME"
  s2i build $GIT_REPO_REF -r 'develop' $REDHAT_BASE_IMAGE $COMPONENT2_NAME \
    -e "ARTIFACT_DIR=$COMPONENT2_SRC/target" \
    -e "NEXUS_USER=$NEXUS_USER" \
    -e "NEXUS_PASSWORD=$NEXUS_PASSWORD" \
    -e "DOTNET_RESTORE_SOURCES=$DOTNET_RESTORE_SOURCES" \
    -e "DOTNET_STARTUP_PROJECT=$DOTNET_STARTUP_PROJECT"
  echo "$COMPONENT2_NAME docker image built succesfully"
  echo ""
  echo "Database"
  pushd ./dockers/mssql/
  ./build.sh
  popd
  echo "Database docker image built succesfully"
  echo ""
  echo "Message broker"
  pushd ./dockers/amq/
  ./build.sh
  popd
  echo "Message broker docker image built succesfully"
  echo ""
fi

if [ "$1" != "skip-start" ]; then
  echo "Starting service"
  docker-compose up
fi
