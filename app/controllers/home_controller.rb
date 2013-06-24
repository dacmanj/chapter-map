class HomeController < ApplicationController
  def index
    if params[:zip].nil?
       @chapters = Chapter.active.order("state ASC").all
       @chapters_by_state = @chapters.group_by { |t| t.state }
    else
      distance = params[:distance] unless params[:distance].nil? || params[:distance].to_f == 0 
       @chapters = Chapter.active.near(params[:zip], distance || 50)
    end
     @json = @chapters.to_gmaps4rails do |chapter, marker|
        marker.infowindow render_to_string(:partial => "/chapters/infowindow", :locals => { :chapter => chapter})
        marker.title   "#{chapter.name}"
        marker.json({ :id => chapter.id })
        case chapter.category
        when "Chapter"
          marker.picture({
                    :picture => "http://maps.google.com/intl/en_us/mapfiles/ms/micons/red-dot.png",
                    :width   => 32,
                    :height  => 32
                   });
        when "Representative"
          marker.picture({
                    :picture => "http://maps.google.com/intl/en_us/mapfiles/ms/micons/purple-dot.png",
                    :width   => 32,
                    :height  => 32
                   });
        end

    end

    #@circles_json = @chapters.map {|c| {:lat => c.latitude, :lng => c.longitude, :radius => c.radius || 100000 }}.to_json

  end

  def embed
    if params[:zip].nil?
       @chapters = Chapter.active.order("state ASC").all
       @chapters_by_state = @chapters.group_by { |t| t.state }
    else
      distance = params[:distance] unless params[:distance].nil? || params[:distance].to_f == 0 
       @chapters = Chapter.active.near(params[:zip], distance || 50)
    end
     @json = @chapters.to_gmaps4rails do |chapter, marker|
        marker.infowindow render_to_string(:partial => "/chapters/infowindow", :locals => { :chapter => chapter})
        marker.title   "#{chapter.name}"
        marker.json({ :id => chapter.id })
        case chapter.category
        when "Chapter"
          marker.picture({
                    :picture => "http://maps.google.com/intl/en_us/mapfiles/ms/micons/red-dot.png",
                    :width   => 32,
                    :height  => 32
                   });
        when "Representative"
          marker.picture({
                    :picture => "http://maps.google.com/intl/en_us/mapfiles/ms/micons/purple-dot.png",
                    :width   => 32,
                    :height  => 32
                   });
        end

    end

    #@circles_json = @chapters.map {|c| {:lat => c.latitude, :lng => c.longitude, :radius => c.radius || 100000 }}.to_json

    render 'index', :layout => 'embed'    

  end

end
