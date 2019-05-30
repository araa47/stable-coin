# start from base nixos 
FROM nixos/nix:latest
# Set the maintainer of image 
MAINTAINER Akshay <akshay@oax.org>
# Copy project to docker
COPY . /usr/src/app 
# Change workdir 
WORKDIR /usr/src/app 
# Run nix-shell to install dep
RUN nix-shell 
# Run pnpm recursive isntall 
RUN nix-shell --command "pnpm recursive install"
