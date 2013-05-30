require 'mime/types'

module Ckeditor
  module Backend
    module Paperclip
      def self.included(base)
        base.send(:include, InstanceMethods)
        base.send(:extend, ClassMethods)
      end

      module ClassMethods
        def self.extended(base)
          base.class_eval do
            before_validation :extract_content_type
            before_create :read_dimensions, :parameterize_filename

            delegate :url, :path, :styles, :size, :content_type, :to => :image
          end
        end
      end

      module InstanceMethods
        def geometry
          @geometry ||= begin
            file = image.respond_to?(:queued_for_write) ? image.queued_for_write[:original] : image.to_file
            ::Paperclip::Geometry.from_file(file)
          end
        end

        protected

          def parameterize_filename
            unless image_file_name.blank?
              filename = Ckeditor::Utils.parameterize_filename(image_file_name)
              self.image.instance_write(:file_name, filename)
            end
          end

          def read_dimensions
            if image? && has_dimensions?
              self.width = geometry.width
              self.height = geometry.height
            end
          end

          # Extract content_type from filename using mime/types gem
          def extract_content_type
            if image_content_type == "application/octet-stream" && !image_file_name.blank?
              content_types = MIME::Types.type_for(image_file_name)
              self.image_content_type = content_types.first.to_s unless content_types.empty?
            end
          end
      end
    end
  end
end
