class TicketsController < ApplicationController

  before_filter :authenticate_user, :only => [:destroy]
  
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  respond_to :html ,:json

  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Array.new
    if params[:user_id] && params[:next] && params[:prev]
      prev = params[:prev].to_i
      nxt = params[:next].to_i
      usr = User.find(params[:user_id])
      if usr
        @tickets = usr.tickets[prev..nxt]
        if params[:status] == "All"
          @tickets = usr.tickets[prev..nxt]
        else
          @tickets = usr.tickets.where(:status => params[:status])[prev..nxt]
        end
      end
    else
      @tickets = Ticket.all
    end
  end

  def all_tickets
      # dateformat = "mm-dd-yyyy"
      from_date = Date.strptime(params[:from_date], "%d-%m-%Y")
      to_date = Date.strptime(params[:to_date], "%d-%m-%Y")
      status_arr = JSON.parse params[:status_arr]
      prev = params[:prev].to_i
      nxt = params[:next].to_i
      puts ":::::::::::::::::::::::::::: DETAILS"
      puts from_date
      puts to_date
      puts status_arr.inspect
      puts status_arr.size
      puts params[:category]

      if status_arr[0] == "All"
        puts "::::::::::::::: count 1 with All"        
        @tickets = Ticket.all.where("created_at > ? and created_at < ? and category = ?", from_date, to_date, params[:category] )[prev..nxt]
      elsif status_arr.size == 1
        puts "::::::::::::::: count 1 but not All"        
        @tickets = Ticket.all.where("created_at > ? and created_at < ? and category = ? and status = ?", from_date, to_date, params[:category], status_arr[0] )[prev..nxt]
      elsif status_arr.size == 2
        puts "::::::::::::::: count 2"        
        @tickets = Ticket.all.where("created_at > ? and created_at < ? and category = ? and status = ? or status = ?", from_date, to_date, params[:category], status_arr[0], status_arr[0] )[prev..nxt]
      end
      # @tickets = Ticket.all
      respond_with @tickets
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)
    #@ticket.user_id = params[:user_id]
    @ticket.ticket_date = DateTime.now
    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:category, :user_id, :description, :status, :ticket_date)
    end
end
