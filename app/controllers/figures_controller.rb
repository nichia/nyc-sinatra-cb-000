class FiguresController < ApplicationController
  # add controller methods
  # Index page
  get '/figures' do
    @figures = Figure.all

    erb :'/figures/index'
  end

  # New figure page
  get '/figures/new' do
    @titles = Title.all.sort_by do |title|
      title.name
    end
    @landmarks = Landmark.all.sort_by do |landmark|
      landmark.name
    end

    erb :'/figures/new'
  end

  # Show figure detail page
  get '/figures/:id' do
    @figure = Figure.find(params[:id])

    erb :'/figures/show'
  end

  # Post: Create figure
  post '/figures' do
    #binding.pry
    if !Figure.find_by(name: params[:figure][:name])
      figure = Figure.create(params[:figure])
    end

    # Not necessary... already updated in Figure.create
    #if params[:figure][:title_ids]
    #  figure.titles = params[:figure][:title_ids].collect {|id| Title.find(id)}
    #end

    if !params[:title][:name].empty?
      # create title
      if !Title.find_by(name: params[:title][:name])
        figure.titles << Title.create(params[:title])
      else
        figure.titles << Title.find_by(name: params[:title][:name])
      end
    end

    # Not necessary... already updated in Figure.create
    #if params[:figure][:landmark_ids]
    #  figure.landmarks = params[:figure][:landmark_ids].collect {|id| Landmark.find(id)}
    #end
    if !params[:landmark][:name].empty?
      # create landmark
      if !Landmark.find_by(name: params[:landmark][:name])
        figure.landmarks << Landmark.create(params[:landmark])
      else
        figure.landmarks << Landmark.find_by(name: params[:landmark][:name])
      end
    end

    #figure.titles.build(params["title"]) unless params["title"]["name"].empty?
    #figure.landmarks.build(params["landmark"]) unless params["landmark"]["name"].empty?

    figure.save

    redirect :"/figures/#{figure.id}"
  end

  # Edit a figure
  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])

    @titles = Title.all.sort_by do |title|
      title.name
    end
    @landmarks = Landmark.all.sort_by do |landmark|
      landmark.name
    end

    erb :'/figures/edit'
  end

  # Patch: Update figure
  patch '/figures/:id' do
    #binding.pry
    figure = Figure.find(params[:id])
    figure.update(params[:figure])

    #figure.titles.build(params["title"]) unless params["title"]["name"].empty?
    if !params[:title][:name].empty?
      # create title
      if !Title.find_by(name: params[:title][:name])
        figure.titles << Title.create(params[:title])
      else
        figure.titles << Title.find_by(name: params[:title][:name])
      end
    end

    #figure.landmarks.build(params["landmark"]) unless params["landmark"]["name"].empty?
    if !params[:landmark][:name].empty?
      # create landmark
      if !Landmark.find_by(name: params[:landmark][:name])
        figure.landmarks << Landmark.create(params[:landmark])
      else
        figure.landmarks << Landmark.find_by(name: params[:landmark][:name])
      end
    end

    figure.save

    redirect :"/figures/#{figure.id}"
  end

end
