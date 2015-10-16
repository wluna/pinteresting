class PinsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  respond_to :html

  def index
    @pins = Pin.all
    respond_with(@pins)
  end

  def show
    respond_with(@pin)
  end

  def new
    #@pin = Pin.new
    # to enable the pin automatically being assigned to the user
   @pin = current_user.pins.build
    respond_with(@pin)
  end

  def edit
  end

  def create

    #@pin = Pin.new(pin_params)
    #to enable pins being automatically assigned to users
    @pin = current_user.pins.build
    @pin.save
    respond_with(@pin)
  end

  def update
    @pin.update(pin_params)
    respond_with(@pin)
  end

  def destroy
    @pin.destroy
    respond_with(@pin)
  end

  private
    def set_pin
      @pin = Pin.find(params[:id])
    end

    def correct_user
      @pin = current_user.pins.find_by(id: params[:id])
      redirect_to pins_path if @pin.nil?
    end

    def pin_params
      params.require(:pin).permit(:description)
    end
end
