class ExercismApp < Sinatra::Base

  get '/' do
    if current_user.guest?
      erb :index
    else
      dashboard = Gallery.new(current_user, Submission.nitless)

      locals = {
        submissions: dashboard.submissions,
        language: nil,
        exercise: nil
      }
      erb :dashboard, locals: locals
    end
  end

  get '/account' do
    please_login("/account")

    erb :account
  end

  put '/account/email' do
    if current_user.guest?
      halt 403, "You must be logged in to edit your email settings"
    end

    current_user.email = params[:email]
    current_user.save
    redirect '/account'
  end

end
