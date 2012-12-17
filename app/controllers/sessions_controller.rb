class SessionsController < ApplicationController

    def new
    end
    
    def create
      user = User.find_by_email( params[:session][:email].downcase )
      if user && user.authenticate(params[:session][:password])
        #sign the usier in and redirect to the user's show page.
        sign_in user
        redirect_back_or user  #modified redirect described in sesssions_helper
      else 
        #create an error message and re-render the signin form.
         flash.now[:error] = 'Invalid email/password combination' #flash.now fixes problem with showing error several times
         render 'new'
      end 
    end
    
    def destroy
      sign_out
      redirect_to root_url   #? how come this is root_url and not root_path

    end

end
