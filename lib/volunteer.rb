class Volunteer
  attr_accessor :id, :name, :project_id

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
  end


  def self.all
    returned_volunteers = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    returned_volunteers.each() do |volunteer|
      name = volunteer.fetch("name")
      id = volunteer.fetch("id").to_i
      project_id = volunteer.fetch("project_id")
      volunteers.push(Volunteer.new({:name => name, :id => id, :project_id => project_id}))
    end
    volunteers
  end

  def save
    result = DB.exec("INSERT INTO volunteers (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(volunteer_to_compare)
    self.name().downcase().eql?(volunteer_to_compare.name.downcase())
  end

  def self.clear
    DB.exec("DELETE FROM volunteers *;")
  end

  def self.find(id)
    volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{id};").first
    name = volunteer.fetch("name")
    id = volunteer.fetch("id").to_i
    project_id = volunteer.fetch("project_id")
    Volunteer.new({:name => name, :id => id, :project_id => project_id})
  end

  # def projects
  #   Project.find_by_volunteer(self.id)
  # end <<< NOT SURE WHAT FOR

  def update(attributes)
    if (attributes.has_key?(:name)) && (attributes.fetch(:name) != nil)
      @name = attributes.fetch(:name)
      DB.exec("UPDATE volunteers SET name = '#{@name}' WHERE id = #{@id};")
    end
  end

  def projects
    projects = []
    results = DB.exec("SELECT project_id FROM creators WHERE volunteer_id = #{@id};")
    if results != nil
      results.each() do |result|
        project_id = result.fetch("project_id").to_i()
        project = DB.exec("SELECT * FROM projects WHERE id = #{project_id};")
        name = project.first().fetch("name")
        id = project.first().fetch("id")
        proje
        projects.push(Project.new({:name => name, :id => id, :project_id => project_id}))
      end
      return projects
    else
      return projects
    end
  end

  def delete
    # DB.exec("DELETE FROM creators WHERE volunteer_id = #{@id};")
    DB.exec("DELETE FROM volunteers WHERE id = #{@id};")
  end
end
