# frozen_string_literal: true

Project.destroy_all
Executor.destroy_all
Task.destroy_all

project1 = Project.create!(name: 'MyProject', description: 'description about', status: 'Not finished')
project2 = Project.create!(name: 'MyProject', description: 'description about', status: 'Not finished')
project3 = Project.create!(name: 'MyProject', description: 'description about', status: 'Not finished')
project4 = Project.create!(name: 'MyProject', description: 'description about', status: 'Not finished')
project5 = Project.create!(name: 'MyProject', description: 'description about', status: 'Not finished')

executor1 = Executor.create!(name: 'Semyon1')
executor2 = Executor.create!(name: 'Semyon2')
executor3 = Executor.create!(name: 'Semyon3')
executor4 = Executor.create!(name: 'Semyon4')
executor5 = Executor.create!(name: 'Semyon5')

task1 = Task.create!(name: 'MyTask', description: 'descr', status: 'unfinished', project: project1, executor: executor1)
task2 = Task.create!(name: 'MyTask', description: 'descr', status: 'unfinished', project: project2, executor: executor2)
task3 = Task.create!(name: 'MyTask', description: 'descr', status: 'unfinished', project: project3, executor: executor3)
task4 = Task.create!(name: 'MyTask', description: 'descr', status: 'unfinished', project: project4, executor: executor4)
