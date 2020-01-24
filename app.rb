require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
require('pry')
require('pg')

DB = PG.connect({:dbname => "volunteer_tracker"})

also_reload('lib/**/*.rb')


get('/test') do
  @something = "this is a variable"
  redirect to('/projects')
end

get('/') do
  @projects = Project.all
  redirect to('/projects')
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
  title = params[:title]
  @project = Project.new({:title => title, :id => @id})
  @project.save()
  redirect to('/projects')
end

get('/projects/:id/edit') do
  @project = Project.find(params[:id].to_i())
  erb(:edit_projects)
end

patch('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  @project.update(:title => params[:title])
  @projects = Project.all
  redirect to('/projects')
end

delete('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  @project.update(:title => params[:title])
  @projects = Project.all
  redirect to('/projects')
end

get('/projects/:id/volunteers/:volunteer_id') do
  @volunteer = Volunteer.find(params[:volunteer_id].to_i())
  erb(:volunteer)
end

post('/projects/:id/volunteers') do
  @project = Project.find(params[:id].to_i())
  @volunteer = Volunteer.new({:title => params[:title], :project_id => @project.id, :id => nil})
  @volunteer.save()
  erb(:project)
end


patch('/projects/:id/volunteers/:volunteer_id') do
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
