# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create default student users
User.create!(username: 'student1', password: 'password', email: 'student.1@osu.edu', role: 'student')
User.create!(username: 'student2', password: 'password', email: 'student.2@osu.edu', role: 'student')
User.create!(username: 'student3', password: 'password', email: 'student.3@osu.edu', role: 'student')

# Create a default TA user
User.create!(username: 'ta', password: 'password', email: 'ta.1@osu.edu', role: 'ta')

# Create a default teacher user
User.create!(username: 'teacher', password: 'password', email: 'teacher.1@osu.edu', role: 'teacher')

# Create presentations
Presentation.create!(title: 'Student1\'s first presentation',
                     description: 'This is the first presentation for student 1', date: '2023-12-04')
Presentation.create!(title: 'Student1\'s second presentation',
                     description: 'This is the second presentation for student 1', date: '2023-12-04')
Presentation.create!(title: 'Student2\'s first presentation',
                     description: 'This is the first presentation for student 2', date: '2023-12-04')
Presentation.create!(title: 'Student2\'s second presentation',
                     description: 'This is the second presentation for student 2', date: '2023-12-04')

Enrollment.create!(user_id: 1, presentation_id: 1)
Enrollment.create!(user_id: 1, presentation_id: 2)
Enrollment.create!(user_id: 2, presentation_id: 3)
Enrollment.create!(user_id: 2, presentation_id: 4)
Enrollment.create!(user_id: 3, presentation_id: 1)
Enrollment.create!(user_id: 3, presentation_id: 2)
Enrollment.create!(user_id: 3, presentation_id: 3)
Enrollment.create!(user_id: 3, presentation_id: 4)
