#
case node['platform']
when 'ubuntu','debian'
  shell = '/bin/false'
  homedir = '/var/lib/bloomd'
when 'centos','redhat','scientific','amazon','suse'
  shell = '/bin/sh'
  homedir = '/var/lib/bloomd' 
when 'fedora'
  shell = '/bin/sh'
  homedir = '/home' #this is necessary because selinux by default prevents the homedir from being managed in /var/lib/ 
else
  shell = '/bin/sh'
  homedir = '/bloomd'
end

#Install related attributes
default['bloomd']['safe_install'] = true

#Tarball and download related defaults
default['bloomd']['version'] = '2.6.10'
default['bloomd']['base_piddir'] = '/var/run/bloomd'

default['bloomd']['user'] = 'bloomd'
default['bloomd']['dir'] = 'bloomd'
default['bloomd']['data_dir'] = '/tmp/bloomd'
default['bloomd']['log_dir'] = '/etc/bloomd'

default['bloomd']['git_repository'] = 'https://armon@github.com/armon/bloomd.git'
default['bloomd']['git_revision'] = 'master'




#Default settings for all bloomd instances, these can be overridden on a per server basis in the 'servers' hash
default['bloomd']['default_settings'] = {
  'user'                   => 'bloomd',
  'group'                  => 'bloomd',
  'homedir'                => homedir,
  'shell'                  => shell,
  'systemuser'             => true,
  'ulimit'                 => 0,
  'configdir'              => '/etc',
  'name'                   => nil,
  'address'                => nil,
  'tcp_port'               => 8673,
 # 'port'                   => 8673,
  'udp_port'               => 8674,
  'datadir'                => '/tmp/bloomd',
  'log_level'              => 'DEBUG',
  'workers'                => 1,
  'flush_interval'         => 60,
  'cold_interval'          => 3600,
  'in_memory'              => 0,
  
  'initial_capacity'       => nil,
  'default_probability'    => nil,
  
  'use_mmap'               => 0,
  'scale_size'             => 4,
  'probability_reduction'    => 0.9
}

# The default for this is set inside of the "install" recipe. This is due to the way deep merge handles arrays
default['bloomd']['servers'] = nil

