class AddPicture < ActiveRecord::Migration

	def self.up
		add_column :team_members, :picture_file, :string
	end

	def self.down
		remove_column :team_members, :picture_file
	end
end
