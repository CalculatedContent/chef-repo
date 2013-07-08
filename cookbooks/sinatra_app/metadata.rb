name             'sinatra_app'
maintainer       'Calculated Content'
maintainer_email 'charlesmartin14@gmail.com'
license          'All rights reserved'
description      'Installs/Configures a sinatra app with redis and s3'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
depends          "ruby_193"
depends          "apache2"
depends          "passenger_apache2"
depends          "redisio"
depends          "s3cmd"