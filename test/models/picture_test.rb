require 'test_helper'

class PictureTest < ActiveSupport::TestCase
  def teardown
    @picture.destroy rescue nil
  end

  test "Set file content_type and size" do
    @picture = create_picture

    assert_equal "image/png", @picture.image_content_type
    assert_equal "rails.png", @picture.image_file_name
    assert_equal 6646, @picture.image_file_size
    assert @picture.url_thumb.include?('thumb_rails.png')

    if @picture.has_dimensions?
      assert_equal 50, @picture.width
      assert_equal 64, @picture.height
    end
  end
end
