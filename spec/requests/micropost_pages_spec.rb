require 'spec_helper'

describe "Micropost pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit root_path }
    
    describe "with invalid information" do
      
      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end
      
      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') } 
      end
    end
    
    describe "with valid information" do
    
      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end
  end

  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }
    
    describe "as correct user" do
      before { visit root_path }
      
      it "should delete a micropost" do
        expect { click_link "delete" }.to change(Micropost, :count).by(-1)
      end
    end
  end

  describe "micropost count" do 
    before { FactoryGirl.create(:micropost, user: user) }
    before { visit root_path }
    
    describe "with one micropost" do
      it { should have_content('1 micropost') }
    end
    describe "with 2 microposts" do
      before do
        FactoryGirl.create(:micropost, user: user, content: "2nd Lorem ipsum.. but more")  
        visit root_path #need this after creating new user to reload page and see second post
      end
      it { should have_content('2 microposts') }
    end
  end


end
