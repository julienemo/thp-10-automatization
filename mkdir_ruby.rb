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
    abort('No space in argument.')

  # if normal input, get the arg as address
  else
    address = a[0]
  end

  return address

end

#-----THESE ARE THE SET UP DOCS
#-----IT CREATES A GEMFILE AND WRITES THE COMMON GEM SETTING INTO THE FILE
#-----IT CREATES AN EMPTY .ENV
#-----IT CREATES A .GITIGNORE AND WRITES IN .ENV
#-----IT CREATES A README WITH SIGNITURE
def create_set_up_docs
  # Gemfile
  gemfile = File.open("Gemfile","w")
  gemfile.puts("""source 'https://rubygems.org'\nruby '2.5.1'\ngem 'rubocop', '~> 0.57.2'\ngem 'rspec'\ngem 'dotenv'\ngem 'pry'\ngem 'launchy'\ngem 'nokogiri'""")
  gemfile.close
  puts "> Gemfile created"

  # .env

  dotenv_file = File.open(".env","w")
  dotenv_file.close
  puts '> .env created'

  # .gitignore
  gitignore_file = File.open(".gitignore","w")
  gitignore_file.puts(".env")
  gitignore_file.close
  puts "> .gitignore with .env created"

  # README.de
  read_me = File.open("README.md","w")
  read_me.puts("A ruby-generated folder\n\n\n\-Julie Kwok @julienemo")
  read_me.close
  puts '> README.de created'
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

  # put some regular lines that I never write myselfAaA
  first_project.puts("""# require ''\n\n\n# def method(arg)\n\n# end""")

  first_project.close
end

def init_spect
  first_project = File.open("00_first_spec.rb","w")
  first_project.puts("""# require_relative '../lib/00_first'\n\n\n# describe '' do\n\n# it '' do\nexpect().to eq()\n# end\n\n#end")
  first_project.close
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
  puts "> Creating basic setting files..."
  create_set_up_docs

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
