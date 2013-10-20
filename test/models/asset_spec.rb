require_relative "../test_helper"

describe Asset do
  before do
    @asset = Asset.new
  end

  it "works" do
    @asset.class.must_equal Asset
  end

  it "must have a name" do
    refute @asset.valid?
    @asset.name = "Some asset"
    assert @asset.valid?
  end

  describe "optimistic_version" do
    before do
      @asset = Asset.create(:name => "ramen")
      build_versions(@asset, ['1.2.4', '2.0.0', '1.2.5'])
    end

    it "returns the exact version if it matches" do
      @asset.optimistic_version("1.2.4").must_equal "1.2.4"
    end

    it "returns the latest version if no version is requested" do
      @asset.optimistic_version.must_equal "2.0.0"
    end

    it "returns the patch version" do
      @asset.optimistic_version("1.2.X").must_equal "1.2.5"
    end

    it "raises NoVersionAvailable if we can't resolve" do
      assert_raises( Asset::NoVersionAvailable) { @asset.optimistic_version("1.3.X") }
    end
  end

  def build_versions(asset, versions)
    versions.each do |version|
      asset.asset_versions.build(:value => version)
    end
    asset.save!
  end
end