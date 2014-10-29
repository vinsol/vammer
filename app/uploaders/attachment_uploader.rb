class AttachmentUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  process :resize_to_fill => [100, 100]

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
