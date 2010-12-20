class NotificationsController < ApplicationController
  # GET /notifications
  def index
    @notifications_unread = Notification.find(:all, :conditions => {:read => false})
    @notifications_read = Notification.find(:all, :conditions => {:read => true})

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /notifications/new
  def new
    @notification = Notification.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @notification }
    end
  end

  # PUT /notifications/1
  def update
    @notification = Notification.find(params[:id])

    respond_to do |format|
      if @notification.update_attributes(params[:notification])
        format.html { redirect_to(notifications_url, :notice => 'Notification was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end
end

