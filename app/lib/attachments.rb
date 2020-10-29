# frozen_string_literal: true

module Attachments
  # CarrierWave image uploader
  class ImageUploader < CarrierWave::Uploader::Base
    storage :file

    CarrierWave::SanitizedFile.sanitize_regexp = /[^[[:alnum:]]\\.\\-\\+_]/

    def filename
      "#{model.id}-#{original_filename}" if original_filename.present?
    end

    def store_dir
      "#{File.dirname(__FILE__)}/../../public/uploads" # TODO: good dir path
    end

    def extension_whitelist
      %w[jpg jpeg gif png]
    end

    def content_type_whitelist
      %r{image\\/}
    end
  end
end
