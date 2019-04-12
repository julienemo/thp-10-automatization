#-----THIS METHODE GETS USER ARGUMENT
#-----WHERE TO CREATE THE DIR AND HOW TO NAME IT
def get_dir_address
  # as observed, ARGV always returns an array
  # of words that user types in
  # if only one word, it is an array with on string item
  a = ARGV

  # data validation
  # if no argument at all, stop the prog
  if a.empty?
    abort('Explicit directory name.')

  # if entered more than one word separated by space
  elsif a.length > 1
    abort('Not space in argument.')

  # if normal input, get the arg as address
  else
    address = a[0]
  end

  return address

end

#-----THESE ARE THE SET UPS
#-----IT WRITES THE COMMUN GEM SETTING INTO THE FILE
#-----IT CREATES A EMPTY .ENV
#-----IT CREATES A .GITIGNORE AND WRITES IN .ENV
def gemfile_set
  default_gems = ['source "https://rubygems.org"',"ruby '2.5.1'", "gem 'rubocop', '~> 0.57.2'", "gem 'rspec'","gem 'dotenv'", "gem 'pry'","gem 'launchy'", "gem 'nokogiri'"]
  gemfile = File.open("Gemfile","w")

  # putting every line into the Gemfile
  default_gems.each do |line|
    gemfile.puts(line)
  end

  gemfile.close
end

def dotenv_set
  dotenv_file = File.open(".env","w")
  dotenv_file.close
end

def gitignore_set
  gitignore_file = File.open(".gitignore","w")
  gitignore_file.puts(".env")
  gitignore_file.close
end


#-----BUNDLE INSTALL AND RSPEC INIT
def bundle_and_rspec
  system('bundle install')
  system('rspec --init')
end


#-----THESE ARE TO CREATE THE PROJECTS AND ITS TEST
#-----THE FIRST LINES SUCH AS REQUIRE GEM/ REQUIRE_RELATIVE
#-----AND METHOD STRUCTURES ARE GIVEN
def init_rb

  first_project = File.new("00_first.rb","w")
  first_projetc =
  first_project.puts('# require ""')
  3.times do first_project.puts('')
  end
  first_project.puts('# def methode(arg)')
  3.times do first_project.puts('')
  end
  first_project.puts('# end')
end

def init_spect
  first_project = File.open("00_first_spec.rb","w")
  first_project.puts('# require_relative "../lib/00_first"')
  3.times do first_project.puts('')
  end
  first_project.puts('# describe "" do')
  first_project.puts('')
  first_project.puts('# it "" do')
  3.times do first_project.puts('')
  end
  first_project.puts('# end')
  first_project.puts('')
  first_project.puts('# end')
end


#-----SETUP COMMIT
def git_set
  system('git init')
  system('git add .')
  system('git commit -m"basic env settings before getting serious"')
end

def mkdir_and_go_to
  info = get_dir_address
  # stock stuff into a variable so that I don't call the func too ofter
  if info.include?('/')
    address = info
    name = info.split('/')[-1]
  else
    address = info
    name = address
  end

  # creating the file and other file/docs inside
  puts "> Creating dir #{address}..."
  Dir.mkdir(address)
  puts "> Switching wd ..."
  Dir.chdir(address)
  puts "> wd switched to #{Dir.pwd}"

  puts "> Creating dir #{address}/lib..."
  Dir.mkdir("lib")
  puts "> Setting up Gemfile, .env and .gitignore"
  gemfile_set
  dotenv_set
  gitignore_set

  # bundle gems and init rspec
  puts "> Bundling gems and initiating rspec..."
  bundle_and_rspec

  Dir.chdir("lib")
  puts "> Switching to #{Dir.pwd} to initate 00_first.rb..."
  init_rb
  Dir.chdir("../spec")
  puts "> Switching to #{Dir.pwd} to initate 00_first_spec.rb..."
  init_spect
  puts "> First project-test skeleton created"
  Dir.chdir("../")
  puts "> Switched to #{Dir.pwd}. Intiating git and first commit "
  git_set
  puts "*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*"
  puts "*--*--*--                                                *--*--*--*"
  puts "*--*--*-- #{address} folder successfully created! *--*--*--*"
  puts "*--*--*--                                                *--*--*--*"
  puts "*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*"
  puts "> Basic env setting finished and git-commited"
  puts "> Currently in this folder are:"
  Dir.entries(".").sort.each do |entry|
    puts "-- #{entry}"
  end
  puts "> Next step : cd #{address}/lib to write first project ! "
end

mkdir_and_go_to
=begin
unless address.empty?
  system("cd #{address}")
else
  system("mkdir #{name}")
end





=end
