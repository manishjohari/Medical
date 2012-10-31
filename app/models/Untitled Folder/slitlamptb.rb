class Slitlamptb < ActiveRecord::Base
belongs_to :patienttbs
after_create :thumbnail
has_attached_file :pimage, styles: {thumbnail: { :geometry => "160x120#"}},
:default_url => '/images/missing.png',
:url => "/images/:attachment/:id/:style/:basename.:extension",
:path => ":rails_root/public/images/:attachment/:id/:style/:basename.:extension"
  before_post_process :skip_for_video
  before_post_process :skip_for_pdf
  def skip_for_video
  !pimage_content_type.include?("video")
  end

  def skip_for_pdf
  !pimage_content_type.include?("pdf")
  end

def thumbnail
    if self.pimage?
      if !self.pimage_content_type.match("video").nil?
        path=self.pimage.path
        current_path=File.expand_path(path,  __FILE__)
        self.update_attributes(:id=>self.id)
       
        directory=File.dirname(current_path)
        td=File.dirname(directory)
        `mkdir #{td}/thumbnail`
        tmpfile = File.join( directory, "tmpfile" )
        FileUtils.mv current_path, tmpfile
        file = ::FFMPEG::Movie.new(tmpfile)
        file.transcode(current_path, "-itsoffset -4 -vcodec mjpeg -vframes 1 -s 160x120 -an -f rawvideo #{td}/thumbnail/#{self.pimage_file_name}")
        FileUtils.mv tmpfile, current_path
        FileUtils.rm tmpfile, :force => true
      else
     
      end
    end
end


end
