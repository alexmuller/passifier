#!/usr/bin/env ruby

module Passifier

  class Manifest

    attr_reader :hash
    alias_method :to_hash, :hash

    # @param [Array<Passifier::StaticFile, Passifier::UrlSource>] asset_files The asset files to populate the manifest with
    # @param [Passifier::Spec] spec The spec generated from the hash used to initialise a pass
    def initialize(asset_files, spec)
      @asset_files = asset_files
      @spec = spec
      populate_content
    end

    def filename
      "manifest.json"
    end

    def content
      to_hash.to_json
    end

    private

    # Convert the image files into SHA1 digests for use in the manifest file
    # @return [String] The resulting contents of the manifest file (aka Passifier::Manifest#content)
    def populate_content
      @hash = {}
      @asset_files.each { |file| @hash[file.name] = Digest::SHA1.hexdigest file.content }
      @hash["pass.json"] = Digest::SHA1.hexdigest @spec.to_json
    end

  end

end

