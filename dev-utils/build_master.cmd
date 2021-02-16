REM #####
REM #
REM # Build all docker images we need for testing the service, this included all of its dependencies
REM #
REM # Usage: 
REM #   ./build.sh - build images and start dockers
REM #   ./build.sh skip-start - just build, do not start dockers from local repo
REM #   ./build.sh skip-build - dont build, just start dockers from local repo
REM #
REM ####

@echo off

echo "Cleaning up previous run"
docker-compose down || true
echo ""

IF /I NOT "%1" == "skip-build" (
  echo "Cleaning up dangling docker resources"
  docker system prune -f || true
  echo ""
  echo "Building docker images from source"
  echo ""
  echo "$COMPONENT_NAME"
  s2i build $GIT_REPO_REF -r 'master' $REDHAT_BASE_IMAGE $COMPONENT_NAME ^
    -e ARTIFACT_DIR=$COMPONENT1_SRC/target ^
    -e NEXUS_USER=%NEXUS_USER% ^
    -e NEXUS_PASSWORD=%NEXUS_PASSWORD% ^
    -e DOTNET_RESTORE_SOURCES=%DOTNET_RESTORE_SOURCES% ^
    -e DOTNET_STARTUP_PROJECT=%DOTNET_STARTUP_PROJECT%
  echo "$COMPONENT_NAME docker image built succesfully"
  echo ""
  echo "$COMPONENT2_NAME"
  s2i build $GIT_REPO_REF -r 'master' $REDHAT_BASE_IMAGE $COMPONENT2_NAME ^
    -e ARTIFACT_DIR=$COMPONENT2_SRC/target ^
    -e NEXUS_USER=%NEXUS_USER% ^
    -e NEXUS_PASSWORD=%NEXUS_PASSWORD% ^
    -e DOTNET_RESTORE_SOURCES=%DOTNET_RESTORE_SOURCES% ^
    -e DOTNET_STARTUP_PROJECT=%DOTNET_STARTUP_PROJECT%
  echo "$COMPONENT2_NAME docker image built succesfully"
  echo ""
  echo "Database"
  cd dockers/mssql
  call build.cmd
  cd ../..
  echo "Database docker image built succesfully"
  echo ""
  echo "Message Broker"
  cd dockers/amq
  call build.cmd
  cd ../..
  echo "Message broker docker image built succesfully"
  echo ""
)

IF /I NOT "%1" == "skip-start" (
  echo "Starting service"
  docker-compose up
)
