require 'rails_helper'

RSpec.describe ExpensesController, type: :controller do
  let(:user) { create(:user) }
  let(:expense) { create(:expense, user: user) }

  before do
    sign_in user
  end

  describe "GET #show_report" do
    it "assigns @q" do
      get :show_report
      expect(assigns(:q)).to be_a Ransack::Search
    end

    it "assigns @expenses" do
      get :show_report
      expect(assigns(:expenses)).to include(expense)
    end

    it "renders the show_report template" do
      get :show_report
      expect(response).to render_template :show_report
    end
  end

  describe "POST #send_report" do
    let(:recipient_email) { "test@example.com" }

    it "sends an email" do
      expect {
        post :send_report, params: { email: recipient_email }
      }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it "renders the report_email template" do
      post :send_report, params: { email: recipient_email }
      expect(response).to render_template :report_email
    end
  end
end

