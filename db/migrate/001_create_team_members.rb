class CreateTeamMembers < ActiveRecord::Migration
	
	def self.up
		create_table :team_members do |t|
			t.string :first_name
			t.string :last_name
			t.date :birthday
			t.string :number
			t.integer :matches_played
			t.integer :goals
			t.integer :mvp
			t.integer :position_id
			t.string :icq
			t.string :phone
			t.string :email
			t.timestamps
		end
	end

	def self.down
		drop_table :team_members
	end
end
