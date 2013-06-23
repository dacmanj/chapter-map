class HomeController < ApplicationController
  def index
    if params[:zip].nil?
       @chapters = Chapter.order("state ASC").all
       @chapters_by_state = @chapters.group_by { |t| t.state }.sort
    else
        @chapters = Chapter.near(params[:zip],params[:distance] || 50)
    end
     @json = @chapters.to_gmaps4rails do |chapter, marker|
        marker.infowindow render_to_string(:partial => "/chapters/infowindow", :locals => { :chapter => chapter})
  #     marker.picture({
  #                  :picture => "http://www.blankdots.com/img/github-32x32.png",
  #                  :width   => 32,
  #                  :height  => 32
  #                 })
        marker.json({ :id => chapter.id, :foo => "bar" })
    end
  end

  def embed
    if params[:zip].nil?
       @chapters = Chapter.all
    else
        @chapters = Chapter.near(params[:zip],params[:distance] || 50)
    end
     @json = @chapters.to_gmaps4rails do |chapter, marker|
        marker.infowindow render_to_string(:partial => "/chapters/infowindow", :locals => { :chapter => chapter})
  #     marker.picture({
  #                  :picture => "http://www.blankdots.com/img/github-32x32.png",
  #                  :width   => 32,
  #                  :height  => 32
  #                 })
        marker.json({ :id => chapter.id, :foo => "bar" })
    end

    render :layout => 'embed'    

  end

end
