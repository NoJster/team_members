class AddNotes < ActiveRecord::Migration
	def self.up
		add_column :team_members, :notes, :text
	end

	def self.down
		remove_column :team_members, :notes
	end
end
