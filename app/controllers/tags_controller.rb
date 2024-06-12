class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  def index
    @tags = Tag.all
  end

  def show
  end

  def new
    @tag = Tag.new
  end

  def edit
  end

  def create
    @tag = Tag.new tag_params

    respond_to do |format|
      if @tag.save
        format.html { redirect_to tag_url(@tag), notice: I18n.t('shared.messages.successfuly.created', resource: I18n.t('activerecord.models.tag')) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @tag.update tag_params
        format.html { redirect_to tag_url(@tag), notice: I18n.t('shared.messages.successfuly.updated', resource: I18n.t('activerecord.models.tag')) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to tags_url, notice: I18n.t('shared.messages.successfuly.destroyed', resource: I18n.t('activerecord.models.tag')) }
    end
  end

  private
  def set_tag
    @tag = Tag.find params[:id]
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end