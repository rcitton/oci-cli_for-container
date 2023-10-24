# oci-cli for Docker/Podman container

oci-cli - [Command Line Interface for Oracle Cloud Infrastructure](https://github.com/oracle/oci-cli) Docker/Podman container setup

## How to build

A makefile is available with following entries:

* **oci**: it will setup oci-cli in a container
* **oci-proxy**: it will setup oci-cli in a container through a proxy
* **oci-cleanup**: it will cleanup the environment dropping the oci-cli image

You can specify the usage of docker or podman from **env.mk**. From the same file you can set the proxy if required

## Usage

Run **make oci**, then add following alias on yours **.bashrc**:

if you use podman:

    alias oci='podman run --rm -it -v "$HOME/.oci:$HOME/.oci" oci'

if you use docker:

    alias oci='docker run --rm -it -v "$HOME/.oci:$HOME/.oci" oci'


You can now execute oci-cli commands, example:

    $ oci os ns get
    {
     "data": "mytenancy"
    }

> **_NOTE:_**  the oci-cli configuration is stored on host under  "**$HOME/.oci**"


## Author

Ruggero Citton

## License

MIT License