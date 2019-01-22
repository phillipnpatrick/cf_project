require 'rails_helper'

describe UsersController, type: :controller do
    #build: does not create a record in the database
    #create: creates a user in the database
    
    user_hermione = FactoryBot.create(:user)
    user_ron = FactoryBot.create(:user)
    user_dumbledore = FactoryBot.create(:admin)
    
    describe 'GET #show' do
        context 'when a user is logged in' do
            before do
                sign_in user_hermione
            end
            
            it 'loads correct user details' do
                get :show, params: { id: user_hermione.id }
                expect(response).to be_ok
                expect(assigns(:user)).to eq user_hermione
            end
        end
        
        context 'when a user is not logged in' do
            it 'redirects to login' do
                get :show, params: { id: user_hermione.id }
                expect(response).to redirect_to(new_user_session_path)
            end
        end
        
        context 'when accessing page as user' do
            before do
                sign_in user_ron
            end
            
            it 'redirects when a user tries to access another users info' do
                get :show, params: { id: user_ron.id }
                expect(response).to be_ok
                
                get :show, params: { id: user_hermione.id }
                expect(response).to redirect_to(products_url)
            end
        end
        
        context 'when accessing page as admin' do
            before do
                sign_in user_dumbledore
            end
            
            it 'loads each users details' do
                get :show, params: { id: user_ron.id }
                expect(response).to be_ok
                
                get :show, params: { id: user_hermione.id }
                expect(response).to be_ok
            end
        end
    end
end