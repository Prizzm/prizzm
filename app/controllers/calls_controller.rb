class CallsController < ApplicationController
  
  include CachedMongoDBConnection
  
  # GET /calls
  # GET /calls.json
  def index
    @calls = Call.all
    @call = Call.new
    @account_sid = ACCOUNT_SID
    @auth_token = AUTH_TOKEN

    @appsid = APP_SID
    
    # Pass case_id to node.js
    @case = "12345"
    puts "CASE!!"
    puts @case
    

    @cap = Twilio::Util::Capability.new(@account_sid, @auth_token)
    @cap.allow_client_outgoing(@appsid)
    @cap_name = @cap.generate()
      
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @calls }
    end
  end

  # GET /calls/1
  # GET /calls/1.json
  def show
    @call = Call.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @call }
    end
  end

  # GET /calls/new
  # GET /calls/new.json
  def new
    @call = Call.new
  

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @call }
    end
  end

  # GET /calls/1/edit
  def edit
    @call = Call.find(params[:id])
  end

  # POST /calls
  # POST /calls.json
  def create
    
    db = mongodb_connection 
    coll = db.collection("calls")
    
    coll.find({"callSid" => "12345"}).each { |row| puts row }

    # doc = {"name" => "MongoDB", "type" => "database", "count" => 1,
    #            "info" => {"x" => 203, "y" => '102'}}
    #     
    #     coll.insert(doc)
    
    #@from = params[:call][:from]
    #@to = params[:call][:to]
    @account_sid = ACCOUNT_SID
    @auth_token = AUTH_TOKEN
    # 
    # # set up a client to talk to the Twilio REST API

    ####### ####### ####### ####### ####### ####### 
    ####### Connects 2 Phone Numbers!!!!!!  ####### 
    ####### ####### ####### ####### ####### ####### 
    
    begin
      @client = Twilio::REST::Client.new(@account_sid, @auth_token)
      @account = @client.accounts.get(@account_sid)
    rescue StandardError => bang
      redirect_to :action => '.', 'msg' => "Error #{bang}"
      return
    end
    
    @from = params[:from] #"(415) 630-5047"
    @to = params[:to] #"+351214456811"
    @case_id = "case_id234" # @case
    @call_id = "call_id12345"
    
    # @to must be retrieved from user.phone_number
    data = {
      :from => BASE_PHONE,
      :to => @from,
      :url => "http://prizzm-central.herokuapp.com" + '/request?to=' + @to + '&case_id=' + @case_id + '&call_id=' + @call_id
    }
    
    
    @client.account.calls.create data
    
    respond_to do |format|
        format.js {render :content_type => 'text/javascript'}
    end

    #redirect_to calls_path
  end
  
  def callback
    @to = "+1"+params[:to]
    @call = Call.new(:from => params[:To], :callsid => params[:CallSid], :to => @to)
    @call.save
    render :action => "xmls/call.xml.builder", :layout => false, :collection => @to
  end
  
  def record
    @call = Call.find_by_callsid(params[:CallSid])
    @call.update_attributes(:record => params[:RecordingUrl])
    @call.save
    render :nothing => true
  end

  # PUT /calls/1
  # PUT /calls/1.json
  def update
    @call = Call.find(params[:id])

    respond_to do |format|
      if @call.update_attributes(params[:call])
        format.html { redirect_to @call, notice: 'Call was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @call.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calls/1
  # DELETE /calls/1.json
  def destroy
    @call = Call.find(params[:id])
    @call.destroy

    respond_to do |format|
      format.html { redirect_to calls_url }
      format.json { head :ok }
    end
  end
  
  
  def central_req
    response = Typhoeus::Request.post("http://4bcf.localtunnel.com/request/ola/ole/oli")
    result = JSON.parse(response.body)
  end
end
