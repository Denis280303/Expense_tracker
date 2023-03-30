# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExpensesController, type: :controller do
  let(:user) { create(:user) }
  let(:expense) { create(:expense, user:) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns the expenses variable' do
      create_list(:expense, 3, user:)
      get :index
      expect(assigns(:expenses)).to eq(user.expenses.ordered.paginate(page: nil, per_page: 10))
    end
  end

  describe 'GET #show' do
    let(:expense) { create(:expense, user:) }

    it 'renders the show template' do
      get :show, params: { id: expense.id }
      expect(response).to render_template(:show)
    end

    it 'assigns the expense variable' do
      get :show, params: { id: expense.id }
      expect(assigns(:expense)).to eq(expense)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns a new expense variable' do
      get :new
      expect(assigns(:expense)).to be_a_new(Expense)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:expense_attributes) { attributes_for(:expense) }

      it 'creates a new expense' do
        expect do
          post :create, params: { expense: expense_attributes }
        end.to change(Expense, :count).by(1)
      end

      it 'redirects to the expenses index page' do
        post :create, params: { expense: expense_attributes }
        expect(response).to redirect_to(expenses_path)
      end

      it 'sets a flash message' do
        post :create, params: { expense: expense_attributes }
        expect(flash[:notice]).to eq('Expense was successfully created.')
      end
    end

    context 'with invalid attributes' do
      let(:expense_attributes) { attributes_for(:expense, expense_type: nil) }

      it 'does not create a new expense' do
        expect do
          post :create, params: { expense: expense_attributes }
        end.not_to change(Expense, :count)
      end

      it 'renders the new template' do
        post :create, params: { expense: expense_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    let(:expense) { create(:expense, user:) }

    it 'renders the edit template' do
      get :edit, params: { id: expense.id }
      expect(response).to render_template(partial: 'expenses/_expense')
    end

    it 'assigns the expense variable' do
      get :edit, params: { id: expense.id }
      expect(assigns(:expense)).to eq(expense)
    end
  end

  describe 'PATCH #update' do
    let(:user) { create(:user) }
    let(:expense) { create(:expense, user:) }

    context 'with valid params' do
      let(:updated_value) { 50 }

      it 'updates the requested expense' do
        patch :update, params: { id: expense.to_param, expense: { value: updated_value } }
        expense.reload
        expect(expense.value).to eq(updated_value)
      end

      it 'redirects to the expenses index page' do
        patch :update, params: { id: expense.to_param, expense: { value: updated_value } }
        expect(response).to redirect_to(expenses_path)
      end

      it 'sets a flash notice message' do
        patch :update, params: { id: expense.to_param, expense: { value: updated_value } }
        expect(flash[:notice]).to eq('Expense was successfully updated.')
      end
    end

    context 'with invalid params' do
      let(:invalid_value) { -50 }

      it 'renders the edit template' do
        patch :update, params: { id: expense.to_param, expense: { value: invalid_value } }
        expect(response).to render_template(partial: 'expenses/_expense')
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }
    let!(:expense) { create(:expense, user:) }

    it 'destroys the requested expense' do
      expect do
        delete :destroy, params: { id: expense.to_param }
      end.to change(Expense, :count).by(-1)
    end

    it 'redirects to the expenses index page' do
      delete :destroy, params: { id: expense.to_param }
      expect(response).to redirect_to(expenses_path)
    end

    it 'sets a flash notice message' do
      delete :destroy, params: { id: expense.to_param }
      expect(flash[:notice]).to eq('Expense was successfully destroyed.')
    end
  end

  describe 'GET #show_report' do
    it 'assigns @q' do
      get :show_report
      expect(assigns(:q)).to be_a Ransack::Search
    end

    it 'assigns @expenses' do
      get :show_report
      expect(assigns(:expenses)).to include(expense)
    end

    it 'renders the show_report template' do
      get :show_report
      expect(response).to render_template :show_report
    end
  end

  describe 'POST #send_report' do
    let(:recipient_email) { 'test@example.com' }

    it 'sends an email' do
      expect do
        post :send_report, params: { email: recipient_email }
      end.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'renders the report_email template' do
      post :send_report, params: { email: recipient_email }
      expect(response).to render_template :report_email
    end
  end
end
