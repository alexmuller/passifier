#!/usr/bin/env ruby

module Passifier

  # Class for Pass signing functionality
  class Signing

    # @param [String] key_pem The key pem file location
    # @param [String] pass_phrase The key pass phrase
    # @param [String] certificate_pem The certificate pem file location
    # @param [String] wwdr_pem The WWDR certificate pem file location
    def initialize(key_pem, pass_phrase, certificate_pem, wwdr_pem)
      @key = File.read(key_pem)
      @pass_phrase = pass_phrase
      @certificate = File.read(certificate_pem)
      @wwdr = File.read(wwdr_pem)
    end

    # Generate a digest of the given content
    # @param [String] content The content to generate a digest from
    # @return [String] The resulting digest
    def sha(content)
      signed_contents = sign(content)
      Digest::SHA1.hexdigest(signed_contents)
    end

    # Sign the given content
    # @param [String] content The content to generate a signing of
    # @return [String] The resulting signing
    def sign(content)
      key = OpenSSL::PKey::RSA.new(@key, @pass_phrase)
      certificate = OpenSSL::X509::Certificate.new(@certificate)
      wwdr = OpenSSL::X509::Certificate.new(@wwdr)
      OpenSSL::PKCS7.sign(certificate, key, content, [wwdr], OpenSSL::PKCS7::BINARY | OpenSSL::PKCS7::NOATTR | OpenSSL::PKCS7::DETACHED).to_der
    end

  end

end
