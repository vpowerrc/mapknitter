class ExportController < ApplicationController
  protect_from_forgery :except => [:formats]

  # http://mapknitter.org/warps/yale-farm/yale-farm.jpg
  def jpg
    send_file 'public/warps/'+params[:id]+'/'+params[:id]+'.jpg'
  end

  # http://mapknitter.org/warps/yale-farm/yale-farm-geo.tif
  def geotiff
    send_file 'public/warps/'+params[:id]+'/'+params[:id]+'-geo.tif'
  end

  def mbtiles
    send_file 'public/warps/'+params[:id]+'/'+params[:id]+'.mbtiles'
  end

  def list
    @exports = Export.find :all, :conditions => ['status != "failed" AND status != "complete" AND status != "none" AND updated_at > ?',(DateTime.now-24.hours).to_s(:db)]
    render :layout => "map"
  end

  def formats
    @map = Map.find params[:id] 
    @export = @map.get_export(params[:type])
    render :layout => false
  end

  def cancel
    map = Map.find params[:id] 
    export = map.get_export(params[:type])
    export.status = 'none'
    export.save
    render :text => 'cancelled'
  end

  def progress
    map = Map.find params[:id] 
    if export = map.get_export(params[:type])
      if  export.status == 'complete'
        output = 'complete (<a href="/map/view/'+map.name+'">view</a>)'
      elsif export.status == 'none'
        output = 'export has not been run'
      elsif export.status == 'failed'
        output = 'export failed'
      else
        output = ' <img class="export_status" src="/images/spinner-small.gif">'+ export.status
      end
    else
      output = 'export has not been run'
    end
    render :text => output, :layout => false 
  end

end
