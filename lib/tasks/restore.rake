task :restore => :environment do

           database_config = Rails.configuration.database_configuration[Rails.env]
           path=File.expand_path('public/restore/my_backup.tar')
           if File.exist?(path)##if on windows then upload my_backup.tar only
            dir=File.dirname(path)
            FileUtils.cd dir
            `tar -xf my_backup.tar`
            FileUtils.rm_rf(path)
           else ## on linux *.tar
           pat = `find #{RAILS_ROOT}/public/restore -name *.tar`
           path=pat.gsub("\n","")
           `tar xf "#{path}" -C #{RAILS_ROOT}/public/restore`
           #FileUtils.rm_rf(path)
           path=File.dirname(path)
           end
            path = path.to_s
            path = path.gsub(".tar","")
            FileUtils.cd path
            path=File.expand_path('../databases/PostgreSQL', __FILE__)
            path=FileUtils.pwd 
            sql_path=`find -name *.sql`
            sql=sql_path.gsub("\n",'')
            path=File.expand_path(sql)
            system "psql --username=#{database_config['username']} -no-password #{database_config['database']} < #{path}"
              ##for images
            pimage_tar_pat = `find #{RAILS_ROOT}/public/restore -name pimages.tar`
            pimage_tar_path = pimage_tar_pat.gsub("\n","")
            `tar xf #{pimage_tar_path} -C #{RAILS_ROOT}/public/restore`
            pimage_source_pat=`find #{RAILS_ROOT}/public/restore -name pimages -type d`
            pimage_source_path=pimage_source_pat.gsub("\n","")
            pimage_d_pat=`find #{RAILS_ROOT}/public/images -name pimages -type d`
            pimage_d_path=pimage_d_pat.gsub("\n","")
            if !File.exist?(pimage_d_path)
            FileUtils.mkdir_p("#{RAILS_ROOT}/public/images/pimages")
            pimage_d_pat=`find #{RAILS_ROOT}/public/images -name pimages -type d`
            pimage_d_path=pimage_d_pat.gsub("\n","")
            end
            d_image_dir=File.dirname(pimage_d_path)
            `mv --force #{pimage_source_path}/* #{pimage_d_path}`
            #`mv #{pimage_source_path}/ #{d_image_dir}/`
            ##for images

            
#           FileUtils.rm_rf(dir)
            
        end
