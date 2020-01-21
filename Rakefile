desc 'Create a database dump'
task :dump, [:db_name] do |t, args|
  system("pg_dump #{args.db_name} > database_backup.sql")
end
