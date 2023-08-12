require_relative 'spec_helper'
require 'prawn-qr'
require 'prawn-qr/qrcode'

describe Prawn::Qr do
  describe "qrcode" do
    it "should be available for prawn documents" do
      expect(Prawn::Document.new.methods).to include(:qrcode)
    end

    it "must generate a qrcode" do
      document = Prawn::Document.new
      expect(Prawn::Qr::QRCode).to receive(:new).with(document, "BobRoss", {}).and_return(double("QRCode", draw: true))
      expect(document.qrcode("BobRoss")).to be_truthy
    end
  end
end
