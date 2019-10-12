# README
## Library Management System
### Software Requirements
* Ubuntu
* Ruby on Rails
* My SQL Server
### Database Setup
* Set username and password in config/database.yml
* Make sure database user can have sufficient permission to read and write to the database
### Default Admin key
* 123456
* This is the default admin key for registration
### Run this command for intial setup
```bash
bundle
yarn
rails db:setup db:migrate
```
### Running the web application
```bash
rails s
```
