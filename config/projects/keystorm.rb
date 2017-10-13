name 'keystorm'
maintainer 'Boris Parak <parak@cesnet.cz>'
homepage 'https://github.com/the-rocci-project/keystorm'
description 'Federated authentication component for rOCCI-server'

# Defaults to C:/keystorm on Windows
# and /opt/keystorm on all other platforms
install_dir "#{default_root}/#{name}"
build_version '1.0.1'
build_iteration 5

override :rubygems, :version => '2.6.8'
override :ruby, :version => '2.4.1'

# Creates required build directories
dependency 'preparation'

# keystorm dependencies/components
dependency 'keystorm'

# Version manifest file
dependency 'version-manifest'

# add external (runtime) dependencies/services
runtime_dependency 'memcached'

distro_deps = if File.exists? '/etc/redhat-release'
                %w[httpd mod_auth_openidc mod_ssl gridsite]
              else
                %w[apache2 libapache2-mod-auth-openidc gridsite]
              end
distro_deps.each { |dep| runtime_dependency(dep) }

# tweaking package-specific options
package :deb do
  vendor 'CESNET, Grid Department <cloud@metacentrum.cz>'
  license 'Apache 2.0'
  priority 'extra'
  section 'net'
end

package :rpm do
  vendor 'CESNET, Grid Department <cloud@metacentrum.cz>'
  license 'Apache 2.0'
  category 'Applications/System'
end

exclude '**/.git'
exclude '**/bundler/git'
