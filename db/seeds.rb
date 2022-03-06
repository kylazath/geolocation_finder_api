# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Locatable.create(identifiable_by: '111.111.111.111',
                latitude: '52.199547', longitude: '20.997526')

Locatable.create(identifiable_by: '222.222.222.222',
                latitude: '51.119403', longitude: '20.868495')

Locatable.create(identifiable_by: '333.333.333.333',
                latitude: '50.300256', longitude: '18.682652')
