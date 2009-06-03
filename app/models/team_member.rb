class TeamMember < ActiveRecord::Base
	validates_presence_of :first_name	
	validates_presence_of :last_name	
	validates_presence_of :number
	validates_presence_of :picture_file

	validates_uniqueness_of :number
	validates_uniqueness_of :icq
	validates_uniqueness_of :phone
	validates_uniqueness_of :email

	def initialize( attributes = {} )
		super( attributes )
		write_attribute( :picture_file, "dummy.png" )
	end

	def before_validation
		unless self[ 'picture_file' ] == "dummy.png" || self[ 'picture_file' ].nil?
			file_name = self[ 'picture_file' ].original_filename
			dir = "#{RAILS_ROOT}/public/images/team_memberz/"

			if !File.exists?( File.dirname( dir + file_name ) )
				Dir.mkdir( File.dirname( dir + file_name ) )
			end

			path = File.join( dir, file_name )
			#
			# write the file to disk and save the attribute
			#
			File.open( path, "w" ) { |f|
				f.write( self[ 'picture_file' ].read )
			}
			write_attribute( :picture_file, file_name )
		end
	end
end
