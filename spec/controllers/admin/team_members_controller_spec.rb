require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::TeamMembersController do
	dataset :team_members
	dataset :users

	integrate_views

	before( :each ) do
		login_as :existing
	end

	context 'index' do
		before( :each ) do
			@team_memberz = TeamMember.find( :all )
		end

		it 'should render the index template' do
			get 'index'
			response.should be_success
			response.should render_template 'index'
		end
	end

	context 'new' do
		it 'should render the edit template' do
			get 'new'
			response.should be_success
			response.should render_template 'edit'
		end
	end

	context 'create' do
		before( :each ) do
			get_tm( :new )
		end

		it 'should create a new team member and redirect' do
			@team_member.should_receive( :save ).and_return( true )
			post 'create', :team_member => { :first_name => 'Test', :last_name => 'Player', :number => '00' }
			response.should be_redirect
			response.should redirect_to( admin_team_members_path )
			flash[ :notice ].should_not be_nil
		end

		it 'should re-render the edit template if save fails' do
			@team_member.should_receive( :save ).and_return( false )
			post 'create', :team_member => { :first_name => 'Test', :last_name => 'Player', :number => '00' }
			response.should be_success
			response.should render_template 'edit'
			flash[ :warning ].should_not be_nil
		end
	end

	context 'edit' do
		before( :each ) do
			get_tm( :find )
		end

		it 'should render the edit template' do
			get 'edit', :id => 1
			response.should be_success
			response.should render_template :edit
		end
	end

	context 'update' do
		before( :each ) do
			get_tm( :find )
		end

		it 'should update the team member and redirect' do
			@team_member.should_receive( :update_attributes ).and_return( true )
			put 'update', :id => 1, :team_member => { :first_name => 'bla' }
			response.should be_redirect
			response.should redirect_to admin_team_members_path
		end

		it 'should re-render the template if update fails' do
			@team_member.should_receive( :update_attributes ).and_return( false )
			put 'update', :id => 1, :team_member => { :first_name => 'bla' }
			response.should be_success
			response.should render_template( 'edit' )
			flash[ :warning ].should_not be_nil
		end
	end

	context 'destroy' do
		before( :each ) do
			get_tm( :find )
		end

		it 'should destroy the team member and redirect' do
			@team_member.should_receive( :destroy ).and_return( true )
			put 'destroy', :id => 1
			response.should be_redirect
			response.should redirect_to admin_team_members_path 
		end
	end

	private

	def get_tm( arg )
			TeamMember.stub!( arg ).and_return( 
															 @team_member = mock_model( 
																								TeamMember, 
																								:first_name => 'Test', 
																								:last_name => 'Name', 
																								:number => '00', 
																								:birthday => Date.new( 1999,9,9 ), 
																								:matches_played => 0, 
																								:goals => 0, 
																								:position_id => 1, 
																								:picture_file => 'dummy.png',
																							 	:phone => '01234234',
																							 	:email => 'bla@bla.de',
																							 	:icq => '1231212312',
																								:forum_nick => 'Test0r',
																								:skype => 'blabla',
																								:plays_since => Date.new( 2000, 1, 1 ),
																								:mvp => 0	) )
	end
end
