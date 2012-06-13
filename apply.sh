#!/usr/bin/env bash

rsync -rvz --delete  ./modules $1:/srv/puppet
rsync -rvz --delete  ./manifests $1:/srv/puppet
ssh -t $1 'sudo puppet apply -v --modulepath=/srv/puppet/modules --manifestdir=/srv/puppet/manifests /srv/puppet/manifests/servers.pp && sudo puppet apply -v --modulepath=/srv/puppet/modules --manifestdir=/srv/puppet/manifests /srv/puppet/manifests/site.pp'