task :backup => :environment do
`backup perform --trigger my_backup`
end
