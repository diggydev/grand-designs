#!/bin/sh
set -x

KEY=$1
REMOTE=$2
WORLD_FILE=$3

scp -i $KEY $WORLD_FILE $REMOTE:~/world.tar

ssh -i $KEY $REMOTE '
sudo yum --assumeyes install flatpak
sudo flatpak --assumeyes install https://dl.flathub.org/repo/appstream/net.minetest.Minetest.flatpakref
mkdir -p ~/.var/app/net.minetest.Minetest/.minetest/worlds
tar -xf world.tar -C ~/.var/app/net.minetest.Minetest/.minetest/worlds/
flatpak run net.minetest.Minetest --server
'

ssh -i $KEY $REMOTE '
cd ~/.var/app/net.minetest.Minetest/.minetest/worlds
tar -cf world-$(date "+%Y-%m-%dT%H%M").tar world
'

scp -i $KEY $REMOTE:~/.var/app/net.minetest.Minetest/.minetest/worlds/world-*.tar $(dirname $WORLD_FILE)/

