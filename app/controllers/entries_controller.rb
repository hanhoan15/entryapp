class EntriesController < ApplicationController
  def index
    @entries = ActiveModel::ArraySerializer.new(
      Entry.all,
      each_serializer: Entries::EntrySerializer,
      root: false).
      as_json
  end

  def new
    @entries = Entry.new
  end

  def create
    @entries = Entry.new(entry_service.parse_timesheet_entry_info(entry_params))
    respond_to do |format|
      if @entries.save
        format.html  { redirect_to action: "index" }
      else
        format.html  { render :action => "new" }
      end
    end
  rescue ArgumentError => e
    render json: { error: e.message }, status: :bad_request
  end

  private
  def entry_params
    params.require(:entry).permit(:date, :start_time, :finish_time)
  end

  def entry_service
    return @entry_service if defined? @entry_service
    @entry_service = Entries::EntryService.new
  end
end
