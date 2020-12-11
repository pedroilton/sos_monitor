# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

puts 'Destroying ClassesStudent'
ClassesStudent.destroy_all
puts 'Destroying MonitoringsStudent'
MonitoringsStudent.destroy_all
puts 'Destroying Monitoring'
Monitoring.destroy_all
puts 'Destroying ClassMonitor'
ClassMonitor.destroy_all
puts 'Destroying UniversityClass'
UniversityClass.destroy_all
puts 'Destroying AcademicYear'
AcademicYear.destroy_all
puts 'Destroying User'
User.destroy_all
puts 'Destroying Discipline'
Discipline.destroy_all

puts 'Creating AcademicYear'
academic_year = AcademicYear.create(title: '2020/1', start_date: Date.parse('01-01-2020'),
                                    end_date: Date.parse('30-06-2020'))
puts academic_year.title
academic_year = AcademicYear.create(title: '2020/2', start_date: Date.parse('01-07-2020'),
                                    end_date: Date.parse('31-12-2020'))
puts academic_year.title
academic_year = AcademicYear.create(title: '2021/1', start_date: Date.parse('01-01-2021'),
                                    end_date: Date.parse('30-06-2021'))
puts academic_year.title

csv_options = { col_sep: ';', headers: :first_row }

puts 'Creating Discipline'
CSV.foreach('storage/seeds/disciplines.csv', csv_options) do |row|
  discipline = Discipline.create(title: row['title'], code: row['code'], course: Course.find_by(code: row['course']))
  puts discipline.title
end

puts 'Creating Demilson'
User.create(name: 'Demilson Nascimento',
            registration: '111',
            email: 'demilson@email.com',
            password: '123456',
            student: true,
            nickname: 'Demilson',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}",
            course: Course.find_by(code: 306))
User.create(name: 'Demilson Nascimento',
            registration: '211',
            email: 'demilson@email.com',
            password: '123456',
            professor: true,
            nickname: 'Demilson',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}",
            department: Department.find_by(code: 304))
User.create(name: 'Demilson Nascimento',
            registration: '311',
            email: 'demilson@email.com',
            password: '123456',
            coordinator: true,
            nickname: 'Demilson',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}",
            course: Course.find_by(code: 306))
User.create(name: 'Demilson Nascimento',
            registration: '411',
            email: 'demilson@email.com',
            password: '123456',
            coordinator: true,
            nickname: 'Demilson',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}",
            department: Department.find_by(code: 304))
User.create(name: 'Demilson Nascimento',
            registration: '511',
            email: 'demilson@email.com',
            password: '123456',
            admin: true,
            nickname: 'Demilson',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}")

puts 'Creating Eduardo'
User.create(name: 'Eduardo Ritter',
            registration: '122',
            email: 'eduardo@email.com',
            password: '123456',
            student: true,
            nickname: 'Eduardo',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}",
            course: Course.find_by(code: 306))
User.create(name: 'Eduardo Ritter',
            registration: '222',
            email: 'eduardo@email.com',
            password: '123456',
            professor: true,
            nickname: 'Eduardo',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}",
            department: Department.find_by(code: 304))
User.create(name: 'Eduardo Ritter',
            registration: '322',
            email: 'eduardo@email.com',
            password: '123456',
            coordinator: true,
            nickname: 'Eduardo',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}",
            course: Course.find_by(code: 306))
User.create(name: 'Eduardo Ritter',
            registration: '422',
            email: 'eduardo@email.com',
            password: '123456',
            coordinator: true,
            nickname: 'Eduardo',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}",
            department: Department.find_by(code: 304))
User.create(name: 'Eduardo Ritter',
            registration: '522',
            email: 'eduardo@email.com',
            password: '123456',
            admin: true,
            nickname: 'Eduardo',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}")

puts 'Creating Uellington'
User.create(name: 'Uellington Cortes',
            registration: '133',
            email: 'uellington@email.com',
            password: '123456',
            student: true,
            nickname: 'Uellington',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}",
            course: Course.find_by(code: 306))
User.create(name: 'Uellington Cortes',
            registration: '233',
            email: 'uellington@email.com',
            password: '123456',
            professor: true,
            nickname: 'Uellington',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}",
            department: Department.find_by(code: 304))
User.create(name: 'Uellington Cortes',
            registration: '333',
            email: 'uellington@email.com',
            password: '123456',
            coordinator: true,
            nickname: 'Uellington',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}",
            course: Course.find_by(code: 306))
User.create(name: 'Uellington Cortes',
            registration: '433',
            email: 'uellington@email.com',
            password: '123456',
            coordinator: true,
            nickname: 'Uellington',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}",
            department: Department.find_by(code: 304))
User.create(name: 'Uellington Cortes',
            registration: '533',
            email: 'uellington@email.com',
            password: '123456',
            admin: true,
            nickname: 'Uellington',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}")

puts 'Creating Pedro'
User.create(name: 'Pedro Ilton',
            registration: '144',
            email: 'pedro@email.com',
            password: '123456',
            student: true,
            nickname: 'Pedro',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}",
            course: Course.find_by(code: 306))
User.create(name: 'Pedro Ilton',
            registration: '244',
            email: 'pedro@email.com',
            password: '123456',
            professor: true,
            nickname: 'Pedro',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}",
            department: Department.find_by(code: 304))
User.create(name: 'Pedro Ilton',
            registration: '344',
            email: 'pedro@email.com',
            password: '123456',
            coordinator: true,
            nickname: 'Pedro',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}",
            course: Course.find_by(code: 306))
User.create(name: 'Pedro Ilton',
            registration: '444',
            email: 'pedro@email.com',
            password: '123456',
            coordinator: true,
            nickname: 'Pedro',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}",
            department: Department.find_by(code: 304))
User.create(name: 'Pedro Ilton',
            registration: '544',
            email: 'pedro@email.com',
            password: '123456',
            admin: true,
            nickname: 'Pedro',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}")
