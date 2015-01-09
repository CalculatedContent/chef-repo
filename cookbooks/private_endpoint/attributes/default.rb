default['sinatra_app']['name'] = 'private_endpoint'

default['sinatra_app']['docroot'] = '/home/ubuntu/apps'
default['sinatra_app']['deploy_dir'] = '/home/ubuntu/apps/private_endpoint'
default['sinatra_app']['port'] = 3456

default['sinatra_app']['repository'] = 'git@github.com:charlesmartin14/private_endpoint.git'
default['sinatra_app']['branch'] = 'master'
# points to path of rsa private key. which can be passed in databags or you can put in files(highly unsecured)
default['sinatra_app']['deploy_key'] = '/home/ubuntu/git_deploy_key_rsa'
