require 'searchkick'

class Asset < ActiveRecord::Base
  class NoVersionAvailable < StandardError; end
  validates :name, presence: true
  has_many :asset_versions

  searchkick

  def self.total_with_format
    Asset.count.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1,")
  end

  def optimistic_version( requested = nil)
    version = if requested.blank?
      sorted_versions.last
    elsif requested.upcase.include?(".X")
      best_match(requested)
    else
      version_values.detect { |version| version == requested }
    end

    version ? version : raise(NoVersionAvailable)
  end

  private

  def version_levels
    @version_levels ||= requested.split('.')
  end

  def sorted_versions
    @sorted_versions ||= version_values.sort_by {|version| version }
  end

  def version_values
    @version_values ||= asset_versions.pluck(:value)
  end

  def best_match(requested)
    expected = requested.upcase.split('.X').first
    matching_versions = version_values.keep_if { | version | version.match(expected) }
    matching_versions ? matching_versions.sort.last : nil
  end
end
