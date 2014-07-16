class VidsController < ApplicationController
  before_action :set_vid, only: [:show, :edit, :update, :destroy]

  # GET /vids
  # GET /vids.json
  def index
    @vids = Vid.all
  end

  # GET /vids/1
  # GET /vids/1.json
  def show
  end

  # GET /vids/new
  def new
    @vid = Vid.new
  end

  # GET /vids/1/edit
  def edit
  end

  # POST /vids
  # POST /vids.json
  def create
    @vid = Vid.new(vid_params)

    respond_to do |format|
      if @vid.save
        format.html { redirect_to @vid, notice: 'Vid was successfully created.' }
        format.json { render :show, status: :created, location: @vid }
      else
        format.html { render :new }
        format.json { render json: @vid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vids/1
  # PATCH/PUT /vids/1.json
  def update
    respond_to do |format|
      if @vid.update(vid_params)
        format.html { redirect_to @vid, notice: 'Vid was successfully updated.' }
        format.json { render :show, status: :ok, location: @vid }
      else
        format.html { render :edit }
        format.json { render json: @vid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vids/1
  # DELETE /vids/1.json
  def destroy
    @vid.destroy
    respond_to do |format|
      format.html { redirect_to vids_url, notice: 'Vid was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vid
      @vid = Vid.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vid_params
      params.require(:vid).permit(:eat_t)
    end
end
