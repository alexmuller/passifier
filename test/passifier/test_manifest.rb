require 'helper'

class TestManifest < Test::Unit::TestCase

  def test_to_hash
    manifest = Helper.new_manifest

    assert_not_nil manifest
    assert_not_nil manifest.to_hash
    assert_not_empty manifest.to_hash.values
    assert_equal Helper.new_image_files.size + 1, manifest.to_hash.values.size # remember pass.json!
  end

  def test_content
    manifest = Helper.new_manifest

    assert_not_nil manifest
    assert_not_nil manifest.content
    assert manifest.to_hash.size > 0
  end

end



