require File.dirname(__FILE__) + '/../spec_helper'

describe TeamMember do
	before( :each ) do
		@team_member = TeamMember.new( valid_data )
	end

	it "should be valid" do
		@team_member.should be_valid
	end

	context "validations" do
		it "should require a first_name" do 
			@team_member.first_name = nil
			@team_member.should_not be_valid
			@team_member.errors.on( :first_name ).should == "can't be blank"
		end
		it "should require a last_name" do 
			@team_member.last_name = nil
			@team_member.should_not be_valid
			@team_member.errors.on( :last_name ).should == "can't be blank"
		end

		it "should require a number" do 
			@team_member.number = nil
			@team_member.should_not be_valid
			@team_member.errors.on( :number ).should == [ "can't be blank", "is the wrong length (should be 2 characters)" ]
		end

		it "should require a unique number" do
			@team_member.save
			@team_member = TeamMember.new( valid_data )
			@team_member.should_not be_valid
			@team_member.errors.on( :number ).should == "has already been taken"
		end

		it "should get a dummy picture set if none uploaded" do
			@team_member.picture_file = nil
			@team_member.save
			@team_member.picture_file.should == "dummy.png"
		end

		it "should require a length of 2 for a number" do
			@team_member.number = "1"
			@team_member.should_not be_valid
			@team_member.errors.on( :number ).should == "is the wrong length (should be 2 characters)"
		end

		it "should require position_id to be one of 0,1,2,3" do
			@team_member.position_id = 4
			@team_member.should_not be_valid
			@team_member.errors.on( :position_id ).should == "is not included in the list"
		end
	end

	private 

	def valid_data
		{
			:first_name => 'Nils o.',
			:last_name => 'Janus',
			:birthday => '17/10/1981',
			:number => '03',
			:matches_played => '5',
			:goals => '2',
			:position_id => 1,
			:plays_since => '17/10/2006'
		}
	end
end
