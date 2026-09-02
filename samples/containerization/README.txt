Containerization of extend products
-----------------------------------

This directory provides example files for:

- Creating Windows and Linux images with some of the extend products using
Docker for Windows and podman for Linux.

- Running AcuRCL and AcuToWeb in a Windows and Linux container from the images.

Note: The bld scripts get version specific information from the .env files.

Note: For Windows, the extend products are supported for use with Docker on
Windows 10 (Pro or Enterprise editions) with Hyper-V enabled. Docker cannot
be used on a PC that has VirtualBox or VMware installed. The Windows example
is based on Windows 10 Enterprise.

Below is a brief summary of how to run the example programs. If something does
not work or if you want more details on containerization of the extend products
and these examples see the extend documentation.

================================================================================

Windows
-------

Install Docker on the Windows machine you want to build your image on if it
is not installed already.

Make sure the directory for docker.exe is in your PATH.

Copy the .msi to the sample\containerization\windows directory. For example,
with 10.5.0 you would copy:
    extend(R) Version 10.5.0 x64.msi

Copy the following 64-bit license files to the aculic_win_x64 directory:
    acurcl.alc          AcuRCL
    acurcl.wlc          AcuToWeb
    wrun32.alc or .3lc  Runtime
The purpose of the SharedContainerDirectory is described in our online
documentation.

Create the base image by running:
    bld.bat IacceptEULA win_x64

Create the application image from the base image by running:
    bld.bat IacceptEULA win_x64 app

Start AcuRCL in a container from the application image by running:
    run_container_AcuRCL.bat

Test the application container by running the tour sample program
using AcuThin:
    acuthin <container-host or IP>:5632 tour

Get the application container id:
    docker ps -a

Stop the application container:
    docker stop <container-id>

Start AcuToWeb in a container from the application image by running:
    run_container_AcuToWeb

Test using AcuToWeb by going to a browser and navigating to the AcuToWeb
startup page, set Alias to tour, and click on Connect:
    <container-host or IP>:3000

Get the application container id:
    docker ps -a

Stop the application container:
    docker stop <container-id>

Here are some useful commands:

If you want to get a list of the containers and their id:
    docker ps -a

If you want to stop a running container:
    docker stop <container-id>

If you want to remove a container:
    docker rm <container-id>

If you want to get a list of the images and their id:
    docker images

If you want to remove an image:
    docker rmi <image-id>

================================================================================

Linux
-----

This example is based on using Ubuntu 20.04 as your Linux machine.

Install podman on the Linux machine you want to run your container on.

Make sure the directory for podman is in your PATH.

Set execute permission on the setup and script files if it is not set already:
    chmod +x setup*
    chmod +x *.sh
Make sure ASCII file line terminators are Unix style
    dos2unix --quiet *

Copy the extend 64-bit shared setup program, setup_acucob1050pmk59shACU, to:
    sample/containerization/linux

Copy the following license files to the aculic_pmk59 directory:
    acurcl.alc          AcuRCL
    acurcl.wlc          AcuToWeb
    runcbl.alc or .3lc  Runtime
The purpose of the SharedContainerDirectory is described in our online
documentation.

Create the base image by running:
    ./bld.sh IacceptEULA

Set execute permission on the script files if it is not set already:
    chmod +x AppContainerDirectory/*.sh
Make sure ASCII file line terminators are Unix style
    dos2unix --quiet *
    dos2unix --quiet AppContainerDirectory/*

Create the application image from the base image by running:
    ./bld.sh IacceptEULA app

Start AcuRCL in a container from the application image by running:
    ./run_container_AcuRCL.sh

Test the application container by running the tour sample program
using AcuThin:
    acuthin <container-host or IP>:5632 tour

Get the application container id:
    podman ps -a

Stop the application container:
    podman stop <container-id>

Start AcuToWeb in a container from the application image by running:
    ./run_container_AcuToWeb.sh

Test using AcuToWeb by going to a browser and navigating to the AcuToWeb
startup page, set Alias to tour, and click on Connect:
    <container-host or IP>:3000

Get the application container id:
    podman ps -a

Stop the application container:
    podman stop <container-id>

Here are some useful commands:

If you want to get a list of the containers and their id:
    podman ps -a

If you want to stop a running container:
    podman stop <container-id>

If you want to remove a container:
    podman rm <container-id>

If you want to get a list of the images and their id:
    podman images

If you want to remove an image:
    podman rmi <image-id>
================================================================================
