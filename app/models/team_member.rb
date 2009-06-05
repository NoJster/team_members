class TeamMember < ActiveRecord::Base
	validates_presence_of :first_name	
	validates_presence_of :last_name	
	validates_presence_of :number

	validates_uniqueness_of :number
	validates_uniqueness_of :icq, :allow_blank => true
	validates_uniqueness_of :phone, :allow_blank => true
	validates_uniqueness_of :email, :allow_blank => true
	validates_uniqueness_of :picture_file, :if => Proc.new { |tm| tm.picture_file != 'dummy.png' }

	validates_length_of :number, :is => 2 

	validates_inclusion_of :position_id, :in => 1..4

	def initialize( attributes = {} )
		super( attributes )

		#
		# need to check here, otherwise the uploaded :picture_file gets overwritten during 'create'
		#
		if self[ 'picture_file' ].nil?
			write_attribute( :picture_file, "dummy.png" )
		end
	end

	def before_validation
		#
		# if a new file is uploaded, use it
		#
		if self[ 'picture_file'].class == ActionController::UploadedStringIO
			set_picture
		else
			#
			# if no file has been entered, keep on using the current one
			#
			unless self.picture_file.nil? || self.id.nil?
				self[ 'picture_file' ] = TeamMember.find( self.id ).picture_file
			else
				self[ 'picture_file' ] = "dummy.png"
			end
		end
	end

	def before_destroy
		#
		# delete the uploaded picture along with the team member
		#

		my_pic = "#{RAILS_ROOT}/public/images/team_memberz/" + self.picture_file
		if !File.exists?( my_pic )
			File.delete( my_pic )
		end
	end

	private 
	def set_picture
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
