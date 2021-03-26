# frozen_string_literal: true

Project.destroy_all
User.destroy_all
Task.destroy_all

user1 = User.create!(name: 'Semyon1', email: 'myemail1@gmail.com', password: '123456')
user2 = User.create!(name: 'Semyon2', email: 'myemail2@gmail.com', password: '123456')
user3 = User.create!(name: 'Semyon3', email: 'myemail3@gmail.com', password: '123456')
user4 = User.create!(name: 'Semyon4', email: 'myemail4@gmail.com', password: '123456')
user5 = User.create!(name: 'Semyon5', email: 'myemail5@gmail.com', password: '123456')

project1 = Project.create!(name: 'MyProject1', description: 'description about', status: 'Not finished', owner: user1)
project2 = Project.create!(name: 'MyProject2', description: 'description about', status: 'Not finished', owner: user2)
project3 = Project.create!(name: 'MyProject3', description: 'description about', status: 'Not finished', owner: user3)
project4 = Project.create!(name: 'MyProject4', description: 'description about', status: 'Not finished', owner: user2)
project5 = Project.create!(name: 'MyProject5', description: 'description about', status: 'Not finished', owner: user5)

task1 = Task.create!(name: 'MyTask1', description: 'descr', status: 'unfinished', project_id: project1, assignee: user1)
task2 = Task.create!(name: 'MyTask2', description: 'descr', status: 'unfinished', project_id: project2, assignee: user2)
task3 = Task.create!(name: 'MyTask3', description: 'descr', status: 'unfinished', project_id: project3, assignee: user3)
task4 = Task.create!(name: 'MyTask4', description: 'descr', status: 'unfinished', project_id: project4, assignee: user4)
