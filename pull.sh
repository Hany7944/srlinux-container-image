#!/bin/bash
SRLREL=24.10.6
SRLBUILD=209

# make sure to set the mtu of the mgmt interface to 1500, otherwise
# artifactory is not happy

sudo ip l set dev ens3 mtu 1500

# pull amd64 image
engctl srlinux build download --files docker --version $SRLREL --number $SRLBUILD --arch amd64
sudo -E docker load -i srldocker_$SRLREL-$SRLBUILD.tar.xz
rm -f srldocker_$SRLREL-$SRLBUILD.tar.xz

# pull arm64 image
engctl srlinux build download --files docker --version $SRLREL --number $SRLBUILD --arch arm64
sudo -E docker load -i srldocker_$SRLREL-$SRLBUILD.tar.xz
rm -f srldocker_$SRLREL-$SRLBUILD.tar.xz

sudo ip l set dev ens3 mtu 8142