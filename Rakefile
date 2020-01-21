desc 'Create a database dump'
task :dump, [:db_title] do |t, args|
  system("pg_dump #{args.db_title} > database_backup.sql")
end
