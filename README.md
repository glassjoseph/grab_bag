# GRAB BAG
## The hottest new way to store and share your files

View it live at: https://grab-bag-1701.herokuapp.com/

### Setup

To set up a local copy of this project, perform the following:

* Clone the repository: `git clone https://github.com/glassjoseph/grab_bag.git`
* `cd` into the project's directory
* Run `bundle install`
* Run `bundle exec rake db:{create,migrate,seed}` to set up the database locally and seed it with files, folders, users, and comments.
* To login as an admin (locally), use these credentials - email: admin@admin.com, password: password
* Run the application in the dev environment with `rails s`
* Visit http://localhost:3000/ and enjoy

### Schema

A visual representation of the schema is here:
![schema pic](http://i.dailymail.co.uk/i/pix/2010/04/28/article-0-09562375000005DC-283_964x699.jpg)


### Features

User

 * A user can authenticate via Facebook or manually
 * She must provide a username and phone number for Two Factor Authentication purposes
 * A user can view and edit her details
 * A user can be an admin, at which point she can deactivate users, delete folders, files, and comments


Folder

 * Every user is created with a home folder
 * When a new folder is created, its entire path is stored in the database
 * Folders can be made public (or private, if already public)
 * Folders can be shared by entering another user's username


File (in the schema, Binary)

 * Files can be uploaded or downloaded if they belong to that user, or if they are in a folder shared with that user
 * Files can be previewed on the page


Comment

 * A user can leave comments on any file that is owned or shared with her

### Design
### Contributors
