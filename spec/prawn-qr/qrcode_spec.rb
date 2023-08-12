require_relative '../spec_helper'
require 'prawn-qr/qrcode'
require 'prawn'
require 'fileutils'
require 'mini_magick'
require 'qrio'

module Prawn::Qr
  describe QRCode do
    let(:document){ ::Prawn::Document.new(margin: 0) }

    describe "qrcode" do
      it "will generate a qr code for different sizes" do
        expect(QRCode.new(document, "X").qrcode.length).to eq 21
        expect(QRCode.new(document, "X" * 50).qrcode.length).to eq 37
        expect(QRCode.new(document, "X" * 200).qrcode.length).to eq 61
      end
    end

    describe "draw" do
      it "generates a valid qr code" do
        QRCode.new(document, "BobRoss").draw
        FileUtils.mkdir_p 'tmp'
        tmp_path = File.expand_path('tmp')
        pdf = File.join(tmp_path, 'test.pdf')
        document.render_file(pdf)
        qr = File.join(tmp_path, 'test.png')
        `convert #{pdf} #{qr}`
        data = Qrio::Qr.load(qr)
        expect(data.qr.text).to eq "BobRoss"
      end
    end
  end
end
