namespace :radiant do
  namespace :extensions do
    namespace :team_members do
      
      desc "Runs the migration of the Team Members extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          TeamMembersExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          TeamMembersExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Team Members to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        puts "Copying assets from TeamMembersExtension"
        Dir[TeamMembersExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(TeamMembersExtension.root, '')
          directory = File.dirname(path)
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
