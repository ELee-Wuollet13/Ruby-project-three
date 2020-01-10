class Project
  attr_reader :id, :title


  def initialize(attributes)
    @id = attributes.fetch(:id)
    @title = attributes.fetch(:title)
  end


  def self.all
    returned_projects = DB.exec("SELECT * FROM projects;")
    projects = []
    returned_projects.each() do |project|
      title = project.fetch("title")
      id = project.fetch("id").to_i
      projects.push(Project.new({:title => title, :id => id}))
    end
    projects
  end

### THIS IS THE PROBLEM!!!
  def addVolunteer(volunteer_id)
      DB.exec("INSERT INTO creators (name, bio, id) VALUES (#{name} #{id}})")
    end

  def save
    result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(project_to_compare)
    self.title.downcase().eql?(project_to_compare.title.downcase())
  end

  def self.clear
    DB.exec("DELETE FROM projects *;")
  end

  def self.find(id)
    project = DB.exec("SELECT * FROM projects WHERE id = #{id};").first
    title = project.fetch("title")
    id = project.fetch("id").to_i
    Project.new({:title => title, :id => id})
  end

  def self.search(title)
    project = DB.exec("SELECT * FROM projects WHERE title = '#{title}'").first
    title = project.fetch("title")
    id = project.fetch("id").to_i
    Project.new({:title => title, :id => id})
  end

  def volunteers
    volunteers = []
    results = DB.exec("SELECT volunteer_id FROM creators WHERE project_id = #{@id};")
    results.each() do |result|
      volunteer_id = result.fetch("volunteer_id").to_i()
      volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{volunteer_id};").first
      name = volunteer.fetch("name")
      bio = volunteer.fetch("bio")
      volunteers.push(Volunteer.new({:name => (volunteer.fetch("name")), :id => volunteer_id, :bio => (volunteer.fetch("bio"))}))
    end
    return volunteers
  end


  def update(attributes)
    @title = attributes.fetch(:title)
    DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{@id};")
    DB.exec("DELETE FROM creators WHERE project_id = #{@id};")
  end
end
