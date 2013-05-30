class Ckeditor::Picture < Ckeditor::Asset
  mount_uploader :data, CkeditorPictureUploader, :mount_on => :image_file_name

  def url_content
    url(:content)
  end
end
