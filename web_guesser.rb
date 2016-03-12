require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)
def check_guess(guess)
  if guess - SECRET_NUMBER > 5
    ["Way too high!", "#FF5F3B"]
  elsif SECRET_NUMBER < guess
    ["Too High!", "#F7AB99"]
  elsif SECRET_NUMBER - guess > 5
    ["Way too low!", "#FF5F3B"]
  elsif guess < SECRET_NUMBER
    ["Too Low!", "#F7AB99"]
  else
    ["<p>You got it right!</p>
     <p>The SECRET NUMBER is #{SECRET_NUMBER}</p>", "#b0e0e6"]
  end
end
get '/' do
  guess = params['guess'].to_i
  result = check_guess(guess)
  message = result[0]
  hex = result[1]
  erb :index, :locals => {:message => message, :hex => hex}
end
