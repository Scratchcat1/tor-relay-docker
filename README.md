<h1 align="center">
<b>Tor Relay Docker</b>
</h1>

<p align="center">
    <a href="https://www.buymeacoffee.com/brunneis" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="35px"></a>
</p>
<br>

<a href="https://github.com/scratchcat1/tor-relay-docker/blob/master/LICENSE"><img alt="License" src="https://img.shields.io/github/license/brunneis/tor-relay-docker.svg?style=flat-square&color=blue"></a>

Tor relay Docker images for x86-64, armhf &amp; arm64 (from source).

There are pre-built alpine-based images hosted in
[hub.docker.com](https://hub.docker.com/r/brunneis) that can be easily executed with the `launch.sh` script.

<!-- __Tor__ (Tor built from source)
- [brunneis/tor-relay:x86-64](https://hub.docker.com/r/brunneis/tor-relay/tags/) (latest stable)
- [brunneis/tor-relay:armhf](https://hub.docker.com/r/brunneis/tor-relay/tags/) (latest stable)
- [brunneis/tor-relay:arm64](https://hub.docker.com/r/brunneis/tor-relay/tags/) (latest stable)
- [brunneis/tor-relay:0.4.2.5_x86-64](https://hub.docker.com/r/brunneis/tor-relay/tags/)
- [brunneis/tor-relay:0.4.2.5_armhf](https://hub.docker.com/r/brunneis/tor-relay/tags/)
- [brunneis/tor-relay:0.4.2.5_arm64](https://hub.docker.com/r/brunneis/tor-relay/tags/)

__Tor with ARM (Anonymizing Relay Monitor)__ (based on tor-relay images)
- [brunneis/tor-relay-arm:x86-64](https://hub.docker.com/r/brunneis/tor-relay-arm/tags/) (latest stable)
- [brunneis/tor-relay-arm:armhf](https://hub.docker.com/r/brunneis/tor-relay-arm/tags/) (latest stable)
- [brunneis/tor-relay-arm:arm64](https://hub.docker.com/r/brunneis/tor-relay-arm/tags/) (latest stable)
- [brunneis/tor-relay-arm:0.4.2.5_x86-64](https://hub.docker.com/r/brunneis/tor-relay-arm/tags/)
- [brunneis/tor-relay-arm:0.4.2.5_armhf](https://hub.docker.com/r/brunneis/tor-relay-arm/tags/)
- [brunneis/tor-relay-arm:0.4.2.5_arm64](https://hub.docker.com/r/brunneis/tor-relay-arm/tags/) -->


## How it works
The common entrypoint for all the tor-relay images is the `entrypoint.sh` script. Before launching Tor, it will create the user `tor` and run `tor` with the `torrc` file mounted at `/home/tor/torrc`. The Tor data directory will be mounted in the folder `tor-data` within the directory from which the script is executed. The docker image will run with the user `tor` with the same `UID` as the user who runs the container (or the `UID` passed as a parameter to the script). The identity of the executed relay is kept under the `tor-data` folder, so the container can be destroyed and relaunched while the relay identity is preserved.

## How to launch a Tor relay
You can modify the basic environment variables of the `launch.sh` script
(NICKNAME and CONTACT_INFO) and just launch it as follows, where the first argument
is the tor-relay image and the second one, the relay type:

- __Bridge relay__: `./launch.sh brunneis/tor-relay:x86-64 bridge`
- __Middle relay__: `./launch.sh brunneis/tor-relay:x86-64 middle`
- __Exit relay__: `./launch.sh brunneis/tor-relay:x86-64 exit`

## How to update a running Tor relay to the latest stable version
When launching a Tor relay with the `launch.sh` script, you can update the Tor software with the last stable version directly running the `update-relay.sh` script. For manual updates, you can just kill the running container, pull or build the new Docker image and rerun the container binding the same data directory.

## How to build the images
The `build-arch-images.sh` script will build all the Docker images for the given architectures as parameters. The images can be manually built with the `docker build` command within every generated Docker context.
