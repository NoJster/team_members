class Admin::TeamMembersController < ApplicationController
	def index
		unless params[ :order ].nil?
			if params[ :order ] == "name_desc"
				@team_memberz = TeamMember.find( :all, :order => "last_name DESC" )
			elsif params[ :order ] == "name_asc"
				@team_memberz = TeamMember.find( :all, :order => "last_name ASC" )
			elsif params[ :order ] == "number_desc"
				@team_memberz = TeamMember.find( :all, :order => "number DESC" )
			elsif params[ :order ] == "number_asc"
				@team_memberz = TeamMember.find( :all, :order => "number ASC" )
			else
				@team_memberz = TeamMember.find( :all, :order => "number ASC" )
			end
		else
			@team_memberz = TeamMember.find( :all, :order => "number ASC" )
		end
	end

	def new
		@team_member = TeamMember.new
		render :action => 'edit'
	end

	def edit
		@team_member = TeamMember.find( params[ :id ] )
	end

	def create
		@team_member = TeamMember.new( params[ :team_member ] )

		if @team_member.save
			flash[ :notice ] = "New Team Member added."
			redirect_to admin_team_members_path
		else
			flash[ :warning ] = "Validation errors occurred while processing this form. Please take a moment to review the form and correct any input errors before continuing."
			render :action => 'edit'
		end
	end

	def update
		@team_member = TeamMember.find( params[ :id ] )

		if @team_member.update_attributes( params[ :team_member ] ) 
			flash[ :notice ] = "Team Member updated."
			redirect_to admin_team_members_path
		else
			flash[ :warning ] = "Validation errors occurred while processing this form. Please take a moment to review the form and correct any input errors before continuing."
			render :action => 'edit'
		end
	end

	def destroy
		@team_member = TeamMember.find( params[ :id ] )

		@team_member.destroy
		flash[ :warning ] = "Team Member deleted."
		redirect_to admin_team_members_path
	end

	def delete_picture
		@team_member = TeamMember.find( params[ :id ] )

		@team_member.update_attributes( { :picture_file => "dummy.png" } )
	end
end
