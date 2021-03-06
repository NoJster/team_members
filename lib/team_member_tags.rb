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

		TeamMember.all( :conditions => [ "is_active = ?", true ] , :order => 'position_id ASC' ).each do |member|

			pos = ""
			case member.position_id
			when 0
				pos = "Goalie"
			when 1
				pos = "Attack"
			when 2
				pos = "Midfield"
			when 3
				pos = "Defense"
			end
			
			plays_since = member.plays_since.nil? ? "" : member.plays_since.to_formatted_s( :month_and_year )

			result += %{
			<p>
			<table style="width: 80%">
			<tr>
				<td rowspan="7" class="team_members" style="width: 40%">
					<img src="/images/playerz/#{member.picture_file}" style="width: 100%"/>
				</td>
				<td class="team_members" style="width: 60%">
					<b>Name:</b> #{member.first_name} #{member.last_name}
				</td>
			</tr>
			}

			[ [ "Nummer", member.number ],
				[ "Position", pos ],
				[ "Lacrosse seit", plays_since ],
				[ "Spiele", member.matches_played ],
		 		[ "Bemerkungen", member.notes ]	].each do |row|
				result += %{<tr>
					<td colspan=2 class="team_members">
						<b>#{row[ 0 ]}:</b> #{row[ 1 ]}
					</td>
				</tr>
				}
			end

			result += %{
				</table>
				</p>
			}
		end

		result
	end

end
