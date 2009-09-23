class AddIsActive < ActiveRecord::Migration
	def self.up
		add_column :team_members, :is_active, :boolean, :default => true
	end

	def self.down
		remove_column :team_members, :is_active
	end
end
