module TeamMemberTags
	include Radiant::Taggable

	desc "Creates a full stats page for a team member"
	tag "member" do |tag|
		%{<div class="member">
					<h2>#{tag.attr['name']}</h2>
				
					<table>
						<tr>
							<td>Career stats:</td>
						</tr>
					</table>
				</div>}
	end

	desc "Creates a listing of all team members"
	tag "team" do |tag|
		result = ""

		TeamMember.find( :all, :order => 'position_id ASC' ).each do |member|

			pos = ""
			case member.position_id
			when 1
				pos = "Attack"
			when 2
				pos = "Midfield"
			when 3
				pos = "Defense"
			end

			result += %{
			<p>
			<table style="width: 80%">
			<tr>
				<td rowspan="6" class="team_members" style="width: 40%">
					<img src="/images/playerz/#{member.picture_file}" style="width: 100%"/>
				</td>
				<td class="team_members" style="width: 60%">
					<b>Name:</b> #{member.first_name} #{member.last_name}
				</td>
			</tr>
			<tr>
				<td colspan=2 class="team_members">
					<b>Number:</b> #{member.number}
				</td>
			</tr>
			<tr>
				<td colspan=2 class="team_members">
					<b>Position:</b> #{pos}
				</td>
			</tr>
			<tr>
				<td colspan=2 class="team_members">
					<b>Matches played:</b> #{member.matches_played}
				</td>
			</tr>
			<tr>
				<td colspan=2 class="team_members">
					<b>Goals:</b> #{member.goals}
				</td>
			</tr>
			<tr>
				<td colspan=2 class="team_members">
					<b>MVP elections:</b> #{member.mvp}
				</td>
			</tr>
		</table>
		</p>
		}
		end

		result
	end

end
