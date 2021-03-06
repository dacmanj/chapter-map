module ApplicationHelper
  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  	def tt(key)
 		controller = params[:controller].singularize
  		t("activerecord.attributes.#{controller}.#{key}")
  	end

	def chapters_by_state_for_select
		Chapter.order(:state).group_by(&:state).map{|k,v| [k,v.map{|l| [l.name,l.id]}]}
	end

	def chapters_for_upload_select(selected = "")
		@chapters =  Chapter.accessible_by(current_ability)
		if current_user.has_role? :admin
			grouped_options_for_select(@chapters.group_by{ |d| d[:state]}.map{|k,v| [k,v.map{|l| [l.name,l.id]}]}.sort_by{|k,v| k || "" })
		else
			options_for_select(@chapters.order(:name).map{|c| [c.name,c.id]}, selected)
		end
	end

	def user_info
	    return '' if not Rails.env.development?
		" #{current_user.authentications.first.provider} #{current_user.email}"
	end

	def us_states
	  [
	    ['AK', 'AK'],
	    ['AL', 'AL'],
	    ['AR', 'AR'],
	    ['AZ', 'AZ'],
	    ['CA', 'CA'],
	    ['CO', 'CO'],
	    ['CT', 'CT'],
	    ['DC', 'DC'],
	    ['DE', 'DE'],
	    ['FL', 'FL'],
	    ['GA', 'GA'],
	    ['HI', 'HI'],
	    ['IA', 'IA'],
	    ['ID', 'ID'],
	    ['IL', 'IL'],
	    ['IN', 'IN'],
	    ['KS', 'KS'],
	    ['KY', 'KY'],
	    ['LA', 'LA'],
	    ['MA', 'MA'],
	    ['MD', 'MD'],
	    ['ME', 'ME'],
	    ['MI', 'MI'],
	    ['MN', 'MN'],
	    ['MO', 'MO'],
	    ['MS', 'MS'],
	    ['MT', 'MT'],
	    ['NC', 'NC'],
	    ['ND', 'ND'],
	    ['NE', 'NE'],
	    ['NH', 'NH'],
	    ['NJ', 'NJ'],
	    ['NM', 'NM'],
	    ['NV', 'NV'],
	    ['NY', 'NY'],
	    ['OH', 'OH'],
	    ['OK', 'OK'],
	    ['OR', 'OR'],
	    ['PA', 'PA'],
	    ['RI', 'RI'],
	    ['SC', 'SC'],
	    ['SD', 'SD'],
	    ['TN', 'TN'],
	    ['TX', 'TX'],
	    ['UT', 'UT'],
	    ['VA', 'VA'],
	    ['VT', 'VT'],
	    ['WA', 'WA'],
	    ['WI', 'WI'],
	    ['WV', 'WV'],
	    ['WY', 'WY']
	  ]
	end

	def us_states_long
    [
      ['Alabama', 'AL'],
      ['Alaska', 'AK'],
      ['Arizona', 'AZ'],
      ['Arkansas', 'AR'],
      ['California', 'CA'],
      ['Colorado', 'CO'],
      ['Connecticut', 'CT'],
      ['Delaware', 'DE'],
      ['District of Columbia', 'DC'],
      ['Florida', 'FL'],
      ['Georgia', 'GA'],
      ['Hawaii', 'HI'],
      ['Idaho', 'ID'],
      ['Illinois', 'IL'],
      ['Indiana', 'IN'],
      ['Iowa', 'IA'],
      ['Kansas', 'KS'],
      ['Kentucky', 'KY'],
      ['Louisiana', 'LA'],
      ['Maine', 'ME'],
      ['Maryland', 'MD'],
      ['Massachusetts', 'MA'],
      ['Michigan', 'MI'],
      ['Minnesota', 'MN'],
      ['Mississippi', 'MS'],
      ['Missouri', 'MO'],
      ['Montana', 'MT'],
      ['Nebraska', 'NE'],
      ['Nevada', 'NV'],
      ['New Hampshire', 'NH'],
      ['New Jersey', 'NJ'],
      ['New Mexico', 'NM'],
      ['New York', 'NY'],
      ['North Carolina', 'NC'],
      ['North Dakota', 'ND'],
      ['Ohio', 'OH'],
      ['Oklahoma', 'OK'],
      ['Oregon', 'OR'],
      ['Pennsylvania', 'PA'],
      ['Puerto Rico', 'PR'],
      ['Rhode Island', 'RI'],
      ['South Carolina', 'SC'],
      ['South Dakota', 'SD'],
      ['Tennessee', 'TN'],
      ['Texas', 'TX'],
      ['Utah', 'UT'],
      ['Vermont', 'VT'],
      ['Virginia', 'VA'],
      ['Washington', 'WA'],
      ['West Virginia', 'WV'],
      ['Wisconsin', 'WI'],
      ['Wyoming', 'WY']
    ]
	end

	def glyph(g)
	  content_tag(:i,"",:class=>"glyphicon glyphicon-"+g)
	end

	def us_states_and_int_long
		us_states_long + [["International PFLAG Groups","IPG"]]
	end

end
