class LearnsetsController < ApplicationController
  before_action :authenticate_user!

  # GET /learnsets or /learnsets.json
  def index
    load_learnset
  end

  # GET /learnsets/1 or /learnsets/1.json
  def show
    load_learnset
  end

  # @return a json with all cards
  def card_json
    @card = Learnset.find(params[:id]).cards.all

    render json: @card
  end

  def card
    @card ||= Learnset.find(params[:id]).cards.all.first

    render 'learnsets/flashcards'
  end

  # GET /learnsets/new
  def new
    if can? :create, Learnset
      build_learnset
    else
      head :forbidden
    end
  end

  # GET /learnsets/1/edit
  def edit; end

  # POST /learnsets or /learnsets.json
  def create
    if can? :create, Learnset
      build_learnset
      save_learnset(form: 'new')
    else
      head :forbidden
    end
  end

  # PATCH/PUT /learnsets/1 or /learnsets/1.json
  def update
    respond_to do |format|
      if @load_learnset.update(learnset_attributes)
        format.html { redirect_to learnset_url(@load_learnset), notice: 'Learnset was successfully updated.' }
        format.json { render :show, status: :ok, location: @load_learnset }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @load_learnset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /learnsets/1 or /learnsets/1.json
  def destroy
    @load_learnset.destroy!

    respond_to do |format|
      format.html { redirect_to learnsets_url, notice: 'Learnset was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def load_learnset
    @load_learnset ||= Learnset.all
  end

  def build_learnset
    @load_learnset ||= Learnset.where(user_id: current_user.id).build
    @load_learnset.attributes = learnset_attributes
  end

  def save_learnset(form:, event: nil)
    if up.validate?
      @load_learnset.valid?
      render form
    elsif @load_learnset.save
      up.layer.emit(event) if event
      redirect_to @load_learnset
    else
      render form, status: :bad_request
    end
  end

  def learnset_attributes
    if (attrs = params[:load_learnset])
      attrs.permit(:title, :desc)
    else
      {}
    end
  end
end
