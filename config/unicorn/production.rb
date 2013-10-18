# Production specific settings
if env == "production"
  # Help ensure your application will always spawn in the symlinked
  # "current" directory that Capistrano sets up.
  working_directory '/home/deployer/apps/blog/current'

  # feel free to point this anywhere accessible on the filesystem
  user 'deployer', 'users'
  shared_path = '/home/deployer/apps/blog/current'

  stderr_path '/home/deployer/apps/blog/current/log/unicorn.stderr.log'
  stdout_path '/home/deployer/apps/blog/current/log/unicorn.stdout.log'
end