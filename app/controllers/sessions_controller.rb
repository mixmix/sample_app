class SessionsController < ApplicationController

    def new
    end
    
    def create
      user = User.find_by_email( params[:session][:email].downcase )
      if user && user.authenticate(params[:session][:password])
        #sign the user in and redirect to the user's show page.
        sign_in user
        redirect_back_or root_path #user #rather than return to users/:id, go to users root, which allows posting
                 #modified redirect described in sesssions_helper
      else
        #create an error message and re-render the signin form.
         flash.now[:error] = 'Invalid email/password combination' #flash.now fixes problem with showing error several times
         render 'new'
      end
    end
    
    def destroy
      sign_out
      redirect_to root_url
    end

end
