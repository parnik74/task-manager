# frozen_string_literal: true

Project.destroy_all
User.destroy_all
Task.destroy_all

project1 = Project.create!(name: 'MyProject', description: 'description about', status: 'Not finished', owner: user1)
project2 = Project.create!(name: 'MyProject', description: 'description about', status: 'Not finished', owner: user2)
project3 = Project.create!(name: 'MyProject', description: 'description about', status: 'Not finished', owner: user3)
project4 = Project.create!(name: 'MyProject', description: 'description about', status: 'Not finished', owner: user2)
project5 = Project.create!(name: 'MyProject', description: 'description about', status: 'Not finished', owner: user5)

user1 = User.create!(name: 'Semyon1')
user2 = User.create!(name: 'Semyon2')
user3 = User.create!(name: 'Semyon3')
user4 = User.create!(name: 'Semyon4')
user5 = User.create!(name: 'Semyon5')

task1 = Task.create!(name: 'MyTask', description: 'descr', status: 'unfinished', project: project1, assignee: user1)
task2 = Task.create!(name: 'MyTask', description: 'descr', status: 'unfinished', project: project2, assignee: user2)
task3 = Task.create!(name: 'MyTask', description: 'descr', status: 'unfinished', project: project3, assignee: user3)
task4 = Task.create!(name: 'MyTask', description: 'descr', status: 'unfinished', project: project4, assignee: user4)
