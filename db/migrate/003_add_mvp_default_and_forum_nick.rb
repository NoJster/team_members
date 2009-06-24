class AddMvpDefaultAndForumNick< ActiveRecord::Migration

	def self.up
		change_column :team_members, :mvp, :integer, :default => 0
		add_column :team_members, :forum_nick, :string
	end

	def self.down
		change_column :team_members, :mvp, :integer
		remove_column :team_members, :forum_nick
	end
end
