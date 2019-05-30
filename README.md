# Stable coin

## Setup

Prerequisite on both macOS and Linux:
- [Nix 2.0](https://nixos.org/nix/) package manager

```bash
nix-shell
pnpm recursive install
cd chain/
pnpm test --watch
```

You can create a `chain/config/local.json` file if you want to specify a custom
blockchain node or you want to use a different mnemonic which has accounts with
enough ETH balance for example. This file is ignored by version control.
Example content might look like:

```
{
  "mnemonic": "your 12 words ...",
  "remoteNode": "http://localhost:8900",
  "_other_remoteNode": "http://localhost:8900"
}

```

Since you can't use comments in JSON files, you can just use some prefixed
keys, in case you want to switch between different values of an option, as
shown with the `_other_remoteNode` example demonstrates it.

## Common Issues 

MacOs Issue while running nix-shell command: 
```
dyld: Library not loaded: /usr/lib/system/libsystem_network.dylib
  Referenced from: /nix/store/q819d3vjz7vswpvkrfa9gck3ys8rmvcj-Libsystem-osx-10.11.6/lib/libSystem.B.dylib
```
Solution 
```
rm -rf /nix/store/{hash}-Libsystem-osx-10.11.6
```

## Docker - Set-up 

The previous set-up doesn't seem to work on mac's anymore due to updates with Mojave. Thus here are instructions to run a docker image with this project. 

1. Clone the repo locally 
2. Cd into the repo 
3. Run ```docker build .``` This will create the docker container and after sdome time return the container id, note this down. 
4. Now run ```docker run -it CONTAINER_ID sh ``` Where CONTAINER_ID is the container id returned by the docker build command. 
5. Activate the nix-shell by running ```nix-shell``` 
6. Now you can change directory into the chain folder of the project inside the docker container ```cd chain``` 
7. Run tests ```pnpm test --watch``` 