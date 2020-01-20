require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
require('pry')
require('pg')

DB = PG.connect({:dbname => "volunteer_tracker"})

also_reload('lib/**/*.rb')

get('/') do
  @projects = Project.all
  erb(:projects)
end

get('/projects') do
  @projects = Project.all
  erb(:projects)
end

get('/projects/new') do
  erb(:new_project)
end

get('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  erb(:project)
end

post('/projects') do
  title = params[:project_title]
  id = params[:project_id]
  new_project = Project.new({:title => title, :id => nil, :genre => genre, :isbn => isbn})
  @projects = Project.all
  @projects.each do |project|
    if new_project == project
      new_search = project.add_search
      project = Project.new(title, nil, new_search)
      new_project.save()
      erb(:projects)
    end
  end
end


  get('/projects/:id/edit') do
    @project = Project.find(params[:id].to_i())
    erb(:edit_project)
  end

  patch('/projects/:id') do
    if !params[:title] && !params[:genre] && !params[:volunteer] && !params[:isbn]
      @project = Project.find(params[:id].to_i())
      @project.sold()
      @projects = Project.all
      erb(:projects)
    else
      @project = Project.find(params[:id].to_i())
      @project.update({:title => params[:title], :genre => params[:genre], :isbn => params[:isbn]})
      # @project = Project.add_search
      @projects = Project.all
      erb(:project)
    end

  end

  patch('/projects/:id/edit') do
    @project = Project.find(params[:id].to_i)
    volunteer = Volunteer.new({:title => params[:volunteer_title], :bio => params[:volunteer_bio], :id => nil})
    volunteer.save
    @project.addVolunteer(volunteer.id)
    erb(:project)
  end



  delete('/projects/:id') do
    @project = Project.find(params[:id].to_i())
    @project.delete()
    @projects = Project.all
    erb(:projects)
  end

  get('/projects/search/') do
    @project = Project.search(params[:searched])
    erb(:search)
  end

  get('/volunteers/:volunteer_id') do
    @volunteer = Volunteer.find(params[:volunteer_id].to_i())
    erb(:volunteer)
  end

  get('/volunteers') do
    @volunteers = Volunteer.all
    erb(:volunteers)
  end


  post('/volunteers') do
    @project = Project.find(params[:id].to_i())
    volunteer = Volunteer.new(params[:volunteer_title], @project.id, nil)
    volunteer.save()
    erb(:project)
  end


  patch('volunteers/:volunteer_id') do
    @project = Project.find(params[:id].to_i())
    volunteer = Volunteer.find(params[:volunteer_id].to_i())
    volunteer.update(params[:title], @project.id)
    erb(:project)
  end

  delete('/projects/:id/volunteers/:volunteer_id') do
    volunteer = Volunteer.find(params[:volunteer_id].to_i())
    volunteer.delete
    @project = Project.find(params[:id].to_i())
    erb(:project)
  end
