class AddPlaysLaxSinceAndSkype < ActiveRecord::Migration

	def self.up
		add_column :team_members, :plays_since, :date
		add_column :team_members, :skype, :string
	end

	def self.down
		remove_column :team_members, :plays_since
		remove_column :team_members, :skype
	end
end
