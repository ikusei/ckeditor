require 'test_helper'

class AttachmentFileTest < ActiveSupport::TestCase
  def teardown
    @attachment.destroy rescue nil
  end

  test "Set file content_type and size" do
    @attachment = create_attachment

    # TODO: fix filename parameterization
    if CKEDITOR_BACKEND == :paperclip
      assert_equal "rails_tar.gz", @attachment.image_file_name
    else
      assert_equal "rails.tar.gz", @attachment.image_file_name
    end

    assert_equal "application/x-gzip", @attachment.image_content_type
    assert_equal 6823, @attachment.image_file_size
    assert_equal "/assets/ckeditor/filebrowser/images/thumbs/gz.gif", @attachment.url_thumb
  end
end
