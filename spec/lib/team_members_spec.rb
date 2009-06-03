require File.dirname(__FILE__) + '/../spec_helper'

describe 'TeamMembers' do
	dataset :pages

	describe '<r:member>' do
		it 'this renders the full stats page of a member' do
			tag = '<r:member name="Nils o. Janus"/>'

			expected = 
				%{<div class="member">
					<h2>Nils o. Janus</h2>
				
					<table>
						<tr>
							<td>Career stats:</td>
						</tr>
					</table>
				</div>}

			pages(:home).should render(tag).as(expected)
		end
	end
end						
