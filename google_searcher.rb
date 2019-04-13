require "launchy"
require 'watir'

# there are two parallel methods
# they do exactly the same thing
# launchy seems to be more efficient in this case
# coz it goes one step to the url of answers
# watir on the contrary, does exactly as a human
# it goes to the home page, type the question and press the key

def search_watir
  # data validation
  # if no ARGV, print errormessage and shut the prog
  if ARGV.empty?
    abort("Missing input. \nPlease explict your question.")
  else
    question = ARGV.join(' ')
  end

  # open browser
  browser = Watir::Browser.new:chrome

  # equivalence type the address of searching engine
  browser.goto 'google.com'

  # equivalence finding the search bar
  search_bar = browser.text_field(class:'gsfi')

  # equivalence tying the word
  search_bar.set(question)

  # pressing the searching button
  search_bar.send_keys(:enter)
  browser.button(type:"submit").click
end

def search_launchy

  # data validation
  # if no ARGV, print errormessage and shut the prog
  if ARGV.empty?
    abort("Missing input. \nPlease explict your question.")
  else
    question = ARGV.join('+')
  end

  # this is hard written
  prefix = "https://www.google.com/search?q="
  url = "#{prefix}#{question}"
  Launchy.open(url)
end

def perform
  n = rand(0..1)
  if n == 0
    search_launchy
  else
    search_watir
  end
end

perform
