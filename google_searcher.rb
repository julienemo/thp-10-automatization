require "launchy"

def search_on_google

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

search_on_google
