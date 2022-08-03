#Return the path as a String object
File.path("/dev/null")  #=> "/dev/null"

#Create a new File Object, with given path
my_file = File.new("/dev/null") #=> "#<File:/dev/null>"
my_file.path  #=> "/dev/null"