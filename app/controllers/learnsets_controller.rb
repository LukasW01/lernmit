class LearnsetsController < ApplicationController
  # GET /learnsets or /learnsets.json
  def index
    @learnsets = Learnset.all
  end

  # GET /learnsets/1 or /learnsets/1.json
  def show
    load_learnset
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
      if @learnset.update(learnset_attributes)
        format.html { redirect_to learnset_url(@learnset), notice: 'Learnset was successfully updated.' }
        format.json { render :show, status: :ok, location: @learnset }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @learnset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /learnsets/1 or /learnsets/1.json
  def destroy
    @learnset.destroy!

    respond_to do |format|
      format.html { redirect_to learnsets_url, notice: 'Learnset was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def load_learnset
    @learnset = Learnset.find_by(user_id: current_user.id)
  end

  def build_learnset
    @learnset ||= Learnset.where(user_id: current_user.id).build
    @learnset.attributes = learnset_attributes
  end

  def save_learnset(form:, event: nil)
    if up.validate?
      @learnset.valid?
      render form
    elsif @learnset.save
      up.layer.emit(event) if event
      redirect_to @learnset
    else
      render form, status: :bad_request
    end
  end

  def learnset_attributes
    if (attrs = params[:learnset])
      attrs.permit(:title, :desc)
    else
      {}
    end
  end
end
