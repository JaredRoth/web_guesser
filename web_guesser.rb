require 'sinatra'
require 'sinatra/reloader'

@@number = rand(100)
@@guesses = 5

def make_guess(guess)
  @@guesses -= 1
  if @@guesses < 0
    @@number = rand(100)
    @@guesses = 5
    ["You have lost, a new number has been generated", "#FF5F3B"]
  else
    check_guess(guess)
  end
end

def check_guess(guess)
  if guess - @@number > 5
    ["Way too high!", "#FF5F3B"]
  elsif @@number < guess
    ["Too High!", "#F7AB99"]
  elsif @@number - guess > 5
    ["Way too low!", "#FF5F3B"]
  elsif guess < @@number
    ["Too Low!", "#F7AB99"]
  else
    @@number = rand(100)
    @@guesses = 5
    ["<p>You got it right!</p>
     <p>The SECRET NUMBER is #{@@number}</p>", "#b0e0e6"]
  end
end
get '/' do
  guess = params['guess'].to_i
  result = make_guess(guess)
  message = result[0]
  hex = result[1]
  erb :index, :locals => {:message => message, :hex => hex}
end
