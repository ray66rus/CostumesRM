class CostumesController < ApplicationController
  # GET /costumes
  # GET /costumes.json
  def index
    @costumes = Costume.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @costumes }
    end
  end

  # GET /costumes/1
  # GET /costumes/1.json
  def show
    @costume = Costume.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @costume }
    end
  end

  # GET /costumes/new
  # GET /costumes/new.json
  def new
    @costume = Costume.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @costume }
    end
  end

  # GET /costumes/1/edit
  def edit
    @costume = Costume.find(params[:id])
  end

  # POST /costumes
  # POST /costumes.json
  def create
    @costume = Costume.new(params[:costume])

    respond_to do |format|
      if @costume.save
        format.html { redirect_to @costume, notice: 'Costume was successfully created.' }
        format.json { render json: @costume, status: :created, location: @costume }
      else
        format.html { render action: "new" }
        format.json { render json: @costume.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /costumes/1
  # PUT /costumes/1.json
  def update
    @costume = Costume.find(params[:id])

    respond_to do |format|
      if @costume.update_attributes(params[:costume])
        format.html { redirect_to @costume, notice: 'Costume was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @costume.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /costumes/1
  # DELETE /costumes/1.json
  def destroy
    @costume = Costume.find(params[:id])
    @costume.destroy

    respond_to do |format|
      format.html { redirect_to costumes_url }
      format.json { head :no_content }
    end
  end
end
