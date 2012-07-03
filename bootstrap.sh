# To use (as root): wget -qO- http://git.io/6axOow | sh
apt-get update
apt-get -y install git puppet
git clone https://github.com/tomafro/gepeto.git /srv/puppet
puppet apply --modulepath=/srv/puppet/modules --manifestdir=/srv/puppet/manifests /srv/puppet/manifests/servers.pp
puppet apply --modulepath=/srv/puppet/modules --manifestdir=/srv/puppet/manifests /srv/puppet/manifests/site.pp
