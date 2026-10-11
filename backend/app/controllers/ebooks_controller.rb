class EbooksController < ApplicationController
  before_action :set_ebook, only: [:show, :update, :destroy, :download]

  # GET /ebooks
  def index
    @ebooks = filter_ebooks.recent
    render json: @ebooks
  end

  # GET /ebooks/:id
  def show
    render json: @ebook
  end

  # POST /ebooks
  def create
    uploaded_file = params.dig(:ebook, :file)
    
    if uploaded_file.nil?
      return render json: { error: 'No file uploaded' }, status: :bad_request
    end

    # Generate a unique filename to avoid collisions
    extension = File.extname(uploaded_file.original_filename)
    filename = "#{SecureRandom.uuid}#{extension}"
    file_path = Rails.root.join('storage', 'ebooks', filename).to_s

    # Save the file to the storage directory
    File.open(file_path, 'wb') do |file|
      file.write(uploaded_file.read)
    end

    @ebook = Ebook.new(ebook_params)
    @ebook.file_path = file_path
    @ebook.file_size = uploaded_file.size

    if @ebook.save
      render json: @ebook, status: :created, location: @ebook
    else
      # Cleanup file if save fails
      File.delete(file_path) if File.exist?(file_path)
      render json: { errors: @ebook.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ebooks/:id
  def update
    if @ebook.update(ebook_params)
      render json: @ebook
    else
      render json: { errors: @ebook.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /ebooks/:id
  def destroy
    @ebook.destroy
    render json: { message: 'Ebook successfully deleted' }
  end

  # GET /ebooks/search
  def search
    @ebooks = filter_ebooks.recent
    render json: @ebooks
  end

  # GET /ebooks/:id/download
  def download
    if File.exist?(@ebook.file_path)
      send_file @ebook.file_path, filename: "#{@ebook.title}.pdf"
    else
      render json: { error: 'File not found' }, status: :not_found
    end
  end

  private

  def set_ebook
    @ebook = Ebook.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Ebook not found' }, status: :not_found
  end

  def filter_ebooks
    ebooks = Ebook.all
    ebooks = ebooks.by_title(params[:title]) if params[:title].present?
    ebooks = ebooks.by_author(params[:author]) if params[:author].present?
    ebooks
  end

  def ebook_params
    params.require(:ebook).permit(:title, :author, :description, :file_path, :file_size, :uploaded_at)
  end
end
