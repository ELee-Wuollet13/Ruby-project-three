class Volunteer
  attr_reader :id
  attr_accessor :title, :project_id

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @project_id = attributes.fetch(:project_id)
    @id = attributes.fetch(:id)
  end

  def ==(volunteer_to_compare)
    (self.title() == volunteer_to_compare.title()) && (self.project_id() == volunteer_to_compare.project_id())
  end

  def self.all
    returned_volunteers = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    returned_volunteers.each() do |volunteer|
      title = volunteer.fetch("title")
      project_id = volunteer.fetch("project_id").to_i
      id = volunteer.fetch("id").to_i
      volunteers.push(Volunteer.new({:title => title, :project_id => project_id, :id => id}))
    end
    volunteers
  end

  def save
    result = DB.exec("INSERT INTO volunteers (title, project_id) VALUES ('#{@title}', #{@project_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def self.find(id)
    volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{id};").first
    title = volunteer.fetch("title")
    project_id = volunteer.fetch("project_id").to_i
    id = volunteer.fetch("id").to_i
    Volunteer.new({:title => title, :project_id => project_id, :id => id})
  end

  def update(title, project_id)
    @title = title
    @project_id = project_id
    DB.exec("UPDATE volunteers SET title = '#{@title}', project_id = #{@project_id} WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM volunteers WHERE id = #{@id};")
  end

  def self.clear
    DB.exec("DELETE FROM volunteers *;")
  end

  def self.find_by_project(alb_id)
    volunteers = []
    returned_volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{alb_id};")
    returned_volunteers.each() do |volunteer|
      title = volunteer.fetch("title")
      id = volunteer.fetch("id").to_i
      volunteers.push(Volunteer.new({:title => title, :project_id => alb_id, :id => id}))
    end
    volunteers
  end

  def project
    Project.find(@project_id)
  end
end
