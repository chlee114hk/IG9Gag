IG9Gag
======

A web application showing a list of posts from a specific (eg. 9gag) instagram account. 

Each post display

­­- Media with both image and video support

­­- Support play video inline

­­- Caption with clickable @user/#hashtag to open corresponding instagram official web page

­­- Creation time relative from now (ex. 4 Hours age , 3 days ago), click to open instagram official post page

­­- Like and comment count

Frameworks
==========

- Ruby on Rails (Backend)

- AngularJS (Frontend)

- Redis

Setup
=====

Create a .ENV file with the following content in root directory (Note that your instagram client may need permisssion of Scope: public_content)

    IG_CLIENT_ID=<YOUR INSTRGRAM CLIENT ID>
    IG_ACCESS_TOKEN=<YOUR INSTRGRAM ACCESS TOKEN>

Change this line of code in app.js to the User ID of the Instragram you want to display 

    $rootScope.demoIGid = '<USER'S INSTRAGRAM ID>'

Install Ruby on Rails 4 and Redis

First install the gems using Bundler:

    bundle install

Precompile asset

    rake assets:precompile RAILS_ENV=development

Start Redis server at at 127.0.0.1 port 6379 (Default)

    redis-server

Start Rails server

    rails s

Now visit [http://127.0.0.1:3000]

Data structure
==============

There is two models in this project: User and Media

User:

- key user:{id}:username
- key user:{id}:full_name
- key user:{id}:profile_picture
- list user:{id}:medias

Media:

- key media:{id}:media_url
- key media:{id}:type
- key media:{id}:likes
- key media:{id}:comments
- key media:{id}:created_time
- key media:{id}:link
- key media:{id}:caption
- key media:{id}:video_poster
- list media:{id}:tags

A key user{id}_page{page}_by_{sort_by}_{order} is used to cache search result of a page for 5 minutes

P.S. I can use HSET or MHSET command of redis to set the fields to user or media key to avoid lots of key generated, and use Set instead of list to store medias of user to take advantage of uniqueness handling of redia. But I may need extra low level implementation with Redis, since I am now using ruby to implementation a high level ORM for my model and it is quite easy to check for uniqueness in ruby.