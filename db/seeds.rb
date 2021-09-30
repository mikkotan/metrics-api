# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Clearing DB'
MetricValue.destroy_all
Metric.destroy_all
puts 'Cleared'

cpu_utilization = Metric.create({ name: 'CPU Utilization (%)' })

20.times do |i|
  MetricValue.create({
    metric_id: cpu_utilization.id,
    timestamp: DateTime.now - (20 - i).minute,
    value: rand(1..5)
  })
end

status_checks = Metric.create({ name: 'Status Checks (count)' })

10.times do |i|
  MetricValue.create({
    metric_id: status_checks.id,
    timestamp: DateTime.now - (10 - i).hour,
    value: rand(0..2)
  })
end

player_retention = Metric.create({ name: 'Player Retention Rate (%)' })

5.times do |i|
  MetricValue.create({
    metric_id: player_retention.id,
    timestamp: DateTime.now - (5 - i).day,
    value: rand(70..90)
  })
end

daily_sales = Metric.create({ name: 'Daily Sales (K)' })

7.times do |i|
  MetricValue.create({
    metric_id: daily_sales.id,
    timestamp: DateTime.now - (7 - i).day,
    value: rand(1..10)
  })
end
