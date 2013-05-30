require 'orm_adapter/adapters/mongoid'
require 'ckeditor/orm/base'

module Ckeditor
  module Orm
    module Mongoid
      module AssetBase
        def self.included(base)
          base.send(:include, ::Mongoid::Document)
          base.send(:include, ::Mongoid::Timestamps)
          base.send(:include, Base::AssetBase::InstanceMethods)
          base.send(:include, InstanceMethods)
          base.send(:extend, ClassMethods)
        end

        module InstanceMethods
          def type
            _type
          end

          def as_json_methods
            [:id, :type] + super
          end
        end

        module ClassMethods
          def self.extended(base)
            base.class_eval do
              field :image_content_type, :type => String
              field :image_file_size, :type => Integer
              field :width, :type => Integer
              field :height, :type => Integer

              belongs_to :assetable, :polymorphic => true
            end
          end
        end
      end
    end
  end
end
