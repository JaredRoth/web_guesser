require 'sinatra'
require 'sinatra/reloader'

@@number  = rand(100)
@@guesses = 5
@@close   = "#F7AB99"
@@far     = "#FF5F3B"
@@correct = "#B0E0E6"

def make_guess(guess)
  @@guesses -= 1
  if @@guesses < 0
    @@number = rand(100)
    @@guesses = 5
    ["You have lost, a new number has been generated", @@far]
  else
    check_guess(guess)
  end
end

def check_guess(guess)
  if guess - @@number > 5
    ["Way too high!", @@far]
  elsif guess > @@number
    ["Too High!", @@close]
  elsif @@number - guess > 5
    ["Way too low!", @@far]
  elsif @@number > guess
    ["Too Low!", @@close]
  else
    @@number = rand(100)
    @@guesses = 5
    ["You got it right!</p>
<p>The SECRET NUMBER is #{guess}", @@correct]
  end
end

get '/' do
  guess = params['guess'].to_i
  if params['cheat']
    cheat = "<p>The SECRET NUMBER is #{@@number}</p>"
  end
  result = make_guess(guess)
  message = result[0]
  hex = result[1]
  erb :index, :locals => {:message => message, :hex => hex, :cheat => cheat}
end
