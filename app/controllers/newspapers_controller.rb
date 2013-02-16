class NewspapersController < ApplicationController
  # GET /newspapers
  # GET /newspapers.json

  require 'open-uri'

  def index
    session[:return_to] ||= request.referer

    publishers = Publisher.find_all_by_category(params[:category])
    publishers.each do |publisher|
      doc = Nokogiri::XML(open(publisher.link))
      items = doc.xpath("//item")
      items.each do |item|
        news = Newspaper.new
        news.title = item.at_xpath("title").text
        news.pubDate = item.at_xpath("pubDate").text
        news.description = item.at_xpath("description").text.gsub(/<\/?[^>]+>/, '')
        news.link = item.at_xpath("link").text
        news.publisher = publisher.name
        news.category = params[:category]
        news.save
      end 
    end

    array = Newspaper.find_all_by_category(params[:category])
    @newspapers = Kaminari.paginate_array(array).page(params[:page]).per(10) 
 
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @newspapers }
    end
  end

  # GET /newspapers/1
  # GET /newspapers/1.json
  def show
    @newspaper = Newspaper.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @newspaper }
    end
  end

  # GET /newspapers/new
  # GET /newspapers/new.json
  def new
    @newspaper = Newspaper.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @newspaper }
    end
  end

  # GET /newspapers/1/edit
  def edit
    @newspaper = Newspaper.find(params[:id])
  end

  # POST /newspapers
  # POST /newspapers.json
  def create
    @newspaper = Newspaper.new(params[:newspaper])

    respond_to do |format|
      if @newspaper.save
        format.html { redirect_to @newspaper, notice: 'Newspaper was successfully created.' }
        format.json { render json: @newspaper, status: :created, location: @newspaper }
      else
        format.html { render action: "new" }
        format.json { render json: @newspaper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /newspapers/1
  # PUT /newspapers/1.json
  def update
    @newspaper = Newspaper.find(params[:id])

    respond_to do |format|
      if @newspaper.update_attributes(params[:newspaper])
        format.html { redirect_to @newspaper, notice: 'Newspaper was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @newspaper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /newspapers/1
  # DELETE /newspapers/1.json
  def destroy
    @newspaper = Newspaper.find(params[:id])
    @newspaper.destroy

    respond_to do |format|
      format.html { redirect_to newspapers_url }
      format.json { head :no_content }
    end
  end
end
