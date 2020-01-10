# class Volunteer
#   attr_accessor :id, :name, :bio
#
#   def initialize(attributes)
#     @id = attributes.fetch(:id)
#     @name = attributes.fetch(:name)
#     @bio = attributes.fetch(:bio)
#   end
#
# #
#   def self.all
#     returned_volunteers = DB.exec("SELECT * FROM volunteers;")
#     volunteers = []
#     returned_volunteers.each() do |volunteer|
#       name = volunteer.fetch("name")
#       id = volunteer.fetch("id").to_i
#       bio = volunteer.fetch("bio")
#       volunteers.push(Volunteer.new({:name => name, :id => id, :bio => bio}))
#     end
#     volunteers
#   end
#
#   def save
#       result = DB.exec("INSERT INTO volunteers (name, bio) VALUES ('#{@name}', '#{@bio}') RETURNING id;")
#       @id = result.first().fetch("id").to_i
#     end
# end
#
#   def ==(volunteer_to_compare)
#     self.name().downcase().eql?(volunteer_to_compare.name.downcase())
#   end
#
#   def self.clear
#     DB.exec("DELETE FROM volunteers *;")
#   end
#
#   def self.find(id)
#     volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{id};").first
#     name = volunteer.fetch("name")
#     id = volunteer.fetch("id").to_i
#     bio = volunteer.fetch("bio")
#     Volunteer.new({:name => name, :id => id, :bio => bio})
#   end
#
#   # def projects
#   #   Project.find_by_volunteer(self.id)
#   # end <<< NOT SURE WHAT FOR
#
#   def update(attributes)
#     if (attributes.has_key?(:name)) && (attributes.fetch(:name) != nil)
#       @name = attributes.fetch(:name)
#       DB.exec("UPDATE volunteers SET name = '#{@name}' WHERE id = #{@id};")
#     end
#     if (attributes.has_key?(:bio)) && (attributes.fetch(:bio) != nil)
#       @bio = attributes.fetch(:bio)
#       DB.exec("UPDATE volunteers SET bio = '#{@bio}' WHERE id = #{@id};")
#     end
#   end
#
#   def projects
#     projects = []
#     results = DB.exec("SELECT project_id FROM creators WHERE volunteer_id = #{@id};")
#       if results != nil
#     results.each() do |result|
#       project_id = result.fetch("project_id").to_i()
#       project = DB.exec("SELECT * FROM projects WHERE id = #{project_id};")
#       name = project.first().fetch("name")
#       id = project.first().fetch("id")
#       genre = project.first().fetch("genre")
#       isbn = project.first().fetch("isbn")
#       projects.push(Project.new({:name => name, :id => id, :genre => genre, :isbn => isbn}))
#     end
#     return projects
#     else
#       return projects
#     end
#   end
#
#   def delete
#     DB.exec("DELETE FROM creators WHERE volunteer_id = #{@id};")
#     DB.exec("DELETE FROM volunteers WHERE id = #{@id};")
#   end
# # end
