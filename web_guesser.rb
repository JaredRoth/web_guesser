require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)
def check_guess(guess)
  if guess - SECRET_NUMBER > 5
    "Way too high!"
  elsif SECRET_NUMBER < guess
    "Too High!"
  elsif SECRET_NUMBER - guess > 5
    "Way too low!"
  elsif guess < SECRET_NUMBER
    "Too Low!"
  else
    "<p>You got it right!</p>
     <p>The SECRET NUMBER is #{SECRET_NUMBER}</p>"
  end
end
get '/' do
  guess = params['guess'].to_i
  message = check_guess(guess)
  erb :index, :locals => {:message => message}
end
