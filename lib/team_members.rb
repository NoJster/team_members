module TeamMembers
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
end
