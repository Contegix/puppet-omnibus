class PuppetOmnibus < FPM::Cookery::Recipe
  homepage 'https://github.com/andytinycat/puppet-omnibus'

  section 'Utilities'
  name 'contegix-puppet-omnibus'
  version '3.3.1'
  description 'Puppet Omnibus package'
  revision 0
  vendor 'contegix'
  maintainer 'Contegix Operations <operations@contegix.com>'
  license 'Apache 2.0 License'

  source '', :with => :noop

  omnibus_package true
  omnibus_dir     "/opt/contegix"
  omnibus_recipes 'libyaml',
                  'ruby',
                  'puppet'

  # Set up paths to initscript and config files per platform
  platforms [:ubuntu, :debian] do
    config_files '/opt/contegix/etc/puppet/puppet.conf',
                 '/opt/contegix/etc/init.d/puppet',
                 '/opt/contegix/etc/default/puppet'
  end
  platforms [:fedora, :redhat, :centos] do
    config_files '/opt/contegix/etc/puppet/puppet.conf',
                 '/opt/contegix/etc/init.d/puppet',
                 '/opt/contegix/etc/sysconfig/puppet'
  end
  omnibus_additional_paths config_files

  def build
    # Nothing
  end

  def install
    # Set paths to package scripts
    self.class.post_install builddir('post-install')
    self.class.pre_uninstall builddir('pre-uninstall')
  end

end

