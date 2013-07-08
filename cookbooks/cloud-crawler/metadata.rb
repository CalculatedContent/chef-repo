name             'cloud-crawler'
maintainer       'Calculated Content'
maintainer_email 'charlesmartin14@gmail.com'
license          'All rights reserved'
description      'Installs/Configures cloud-crawler master node and monitor'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
depends          "git"
depends          "ruby_193"
depends          "redisio"
depends          "s3cmd"
depends          "sinatra_app"
