#!/bin/bash
# Include version and environment settings
. bld_linux_x64.env

# Defaults
EULAACCEPTREQUIRED=yes
ACCEPTEULA=sorryIDontAcceptEULA
ENV=BASE

function showusage
{
	echo "Build the extend image"
	
	if [ ! "x$*" == "x" ];
	then
		echo $*
		echo ""
	fi
     
	echo "Usage: $0 IacceptEULA [options]"
	echo
	echo "Options:"
	echo " IacceptEULA - indicates the acceptance of the EULA (required)"
	echo " app         - build an image based on the extend image and"
	echo "               include the AppContainerDirectory"
	echo
	echo "Examples:"
	echo " bld.sh IacceptEULA"
	echo " bld.sh IacceptEULA app"
     exit 1
}

# Check container runtime
checkContainerRuntime() {
  CONTAINER_RUNTIME=$(which docker 2>/dev/null) ||
    CONTAINER_RUNTIME=$(which podman 2>/dev/null) ||
    {
      echo "No docker or podman executable found in your PATH"
      exit 1
    }

  if "${CONTAINER_RUNTIME}" info | grep -i -q buildahversion; then
    BUILDAH_FORMAT=docker
	checkPodmanVersion
  else
    checkDockerVersion
  fi
}

# Check Podman version
checkPodmanVersion() {
  # Get Podman version
  PODMAN_VERSION=$("${CONTAINER_RUNTIME}" info --format '{{.host.BuildahVersion}}' 2>/dev/null ||
                   "${CONTAINER_RUNTIME}" info --format '{{.Host.BuildahVersion}}')
  # Remove dot in Podman version
  PODMAN_VERSION=${PODMAN_VERSION//./}

  if [ -z "${PODMAN_VERSION}" ]; then
    exit 1;
  elif [ "${PODMAN_VERSION}" -lt "${MIN_PODMAN_VERSION//./}" ]; then
    echo "Podman version is below the minimum required version ${MIN_PODMAN_VERSION}"
    echo "Please upgrade your Podman installation to proceed."
    exit 1;
  fi
}

# Check Docker version
checkDockerVersion() {
  # Get Docker Server version
  DOCKER_VERSION=$("${CONTAINER_RUNTIME}" version --format '{{.Server.Version | printf "%.5s" }}'|| exit 0)
  # Remove dot in Docker version
  DOCKER_VERSION=${DOCKER_VERSION//./}

  if [ "${DOCKER_VERSION}" -lt "${MIN_DOCKER_VERSION//./}" ]; then
    echo "Docker version is below the minimum required version ${MIN_DOCKER_VERSION}"
    echo "Please upgrade your Docker installation to proceed."
    exit 1;
  fi;
}

##############
#### MAIN ####
##############

# Check that we have a container runtime installed
checkContainerRuntime

# Check for arguments like IacceptEULA
for arg in "$@"
do
        P1=$(echo $arg | cut -d '=' -f1)
        P2=$(echo $arg | cut -d '=' -f2)

        case .$P1 in
        .IacceptEULA)
        	ACCEPTEULA=IacceptEULA
        	;;
        .app)
        	ENV=APP
		;;
        *)
        	showusage $0: invalid argument : $arg
		exit 3
		;;
	esac
done

if [ ! "x$EULAACCEPTREQUIRED" == "x" ];
then
        DOUSAGE=yes
        for arg in "$@"
        do
                if [ "x$arg" == "xIacceptEULA" ];
                then
                        DOUSAGE=no
                fi
        done

        if [ "x$DOUSAGE" == "xyes" ];
        then
                showusage $0: EULA not accepted
                exit 0
        fi
fi

if [ "x$ENV" == "xBASE" ]
then
# Add execute permission on the setup and script files
	chmod +x setup*
	chmod +x *.sh
# Make sure ASCII file line terminators are Unix style
	dos2unix --quiet *
# Create the base image
	"${CONTAINER_RUNTIME}" build --tag $BASEIMAGE \
	--build-arg BASEOSIMAGE=$BASEOSIMAGE \
	--build-arg ACCEPTEULA=$ACCEPTEULA \
	--build-arg SETUPEXE=$SETUPEXE \
	--build-arg LICENSE_DIRECTORY=$LICENSE_DIRECTORY \
	--build-arg INSTALL_DIRECTORY=$INSTALL_DIRECTORY \
	--build-arg EXTEND_VERSION=$EXTEND_VERSION \
	--file $DOCKERFILE .
fi

if [ "x$ENV" == "xAPP" ]
then
# Add execute permission on the script files
	chmod +x *.sh
# Make sure ASCII file line terminators are Unix style
	dos2unix --quiet *
	dos2unix --quiet AppContainerDirectory/*
# Create the application image
	"${CONTAINER_RUNTIME}" build --tag $APPIMAGE \
	--build-arg BASEIMAGE=$BASEIMAGE \
	--build-arg EXTEND_VERSION=$EXTEND_VERSION \
	--build-arg APPCONTAINERDIRECTORY="$PWD/AppContainerDirectory" \
	--file ${DOCKERFILE}_app .
fi


