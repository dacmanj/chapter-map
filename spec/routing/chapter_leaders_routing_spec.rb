require "spec_helper"

describe ChapterLeadersController do
  describe "routing" do

    it "routes to #index" do
      get("/chapter_leaders").should route_to("chapter_leaders#index")
    end

    it "routes to #new" do
      get("/chapter_leaders/new").should route_to("chapter_leaders#new")
    end

    it "routes to #show" do
      get("/chapter_leaders/1").should route_to("chapter_leaders#show", :id => "1")
    end

    it "routes to #edit" do
      get("/chapter_leaders/1/edit").should route_to("chapter_leaders#edit", :id => "1")
    end

    it "routes to #create" do
      post("/chapter_leaders").should route_to("chapter_leaders#create")
    end

    it "routes to #update" do
      put("/chapter_leaders/1").should route_to("chapter_leaders#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/chapter_leaders/1").should route_to("chapter_leaders#destroy", :id => "1")
    end

  end
end
