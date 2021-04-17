<h1 align="center">
<b>Tor Relay Docker</b>
</h1>
<br>

<a href="https://github.com/scratchcat1/tor-relay-docker/blob/master/LICENSE"><img alt="License" src="https://img.shields.io/github/license/scratchcat1/tor-relay-docker.svg?style=flat-square&color=blue"></a>

Tor relay Docker images for x86-64, armhf (from source).

There are pre-built alpine-based images hosted in
[hub.docker.com](https://hub.docker.com/r/scratchcat1) that can be easily executed with the `launch.sh` script.

Fork from [https://github.com/brunneis/tor-relay-docker](https://github.com/brunneis/tor-relay-docker)

__Tor__ (Tor built from source)
- [scratchcat1/tor-relay:latest](https://hub.docker.com/r/scratchcat1/tor-relay/tags/) (latest stable)
- [scratchcat1/tor-relay:0.4.5.7](https://hub.docker.com/r/scratchcat1/tor-relay/tags/)

## Features
- *Lightweight*: 13MB compressed
- *Multiarch Manifest*: Docker will automatically select the correct architecture image.
- *Semi non-root*: Creates user with correct UID from environment and then downgrades from root.


## How it works
The common entrypoint for all the tor-relay images is the `entrypoint.sh` script. Before launching Tor, it will create the user `tor` and run `tor` with the `torrc` file mounted at `/home/tor/torrc`. The Tor data directory will be mounted in the folder `tor-data` within the directory from which the script is executed. The docker image will run with the user `tor` with the same `UID` as the user who runs the container (or the `UID` passed as a parameter to the script). The identity of the executed relay is kept under the `tor-data` folder, so the container can be destroyed and relaunched while the relay identity is preserved.

## How to launch a Tor relay
The script `launch.sh` will run the image with the OR and DIR ports forwarded by default, you can expose other ports by editing it.  
To launch a basic relay run:  
`# ./launch.sh scratchcat1/tor-relay:0.4.5.7 $PWD/resources/torrc.sample`

If you want to run the container as a non root user pass the UID as a parameter, e.g. for UID=1000:  
`# ./launch.sh scratchcat1/tor-relay:0.4.5.7 $PWD/resources/torrc.sample 9001 9030 1000`

## How to update a running Tor relay to the latest stable version
When launching a Tor relay with the `launch.sh` script, you can update the Tor software with the last stable version directly running the `update-relay.sh` script. For manual updates, you can just kill the running container, pull or build the new Docker image and rerun the container binding the same data directory.

## How to build the images
The `build-image.sh` script will build the Docker image for the current architecture.  
The `push-multiarch-image.sh` will build and push the cross platform Docker image for the platforms defined in `env.sh`. Only pushing is supported for the multiarch image because docker doesn't yet support the loading of manifest lists.
You will need to set up a cross platform build environment with this [guide](https://web.archive.org/web/20201230140648/https://jite.eu/2019/10/3/multi-arch-docker/)

