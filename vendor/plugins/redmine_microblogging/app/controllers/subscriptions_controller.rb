class SubscriptionsController < ApplicationController
  # GET /subscriptions
  # GET /subscriptions.xml
  def index
    @subscriptions = find_current_user.subscriptions

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # POST /subscriptions
  # POST /subscriptions.xml
  def create
    @subscription = Subscription.new
    page = WikiPage.find(params[:page_id])
    @subscription.page = page
    @subscription.user = find_current_user
    
    respond_to do |format|
      if @subscription.save
        format.html { redirect_to(subscriptions_url, :notice => 'Subscription was successfully created.') }
      else
        format.html { redirect_to(page, :error => 'Unable to subscribe.') }
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.xml
  def destroy
    @subscription = find_current_user.subscriptions.find(params[:id])
    @subscription.destroy

    respond_to do |format|
      format.html { redirect_to(subscriptions_url) }
    end
  end
end
