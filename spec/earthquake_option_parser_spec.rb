# encoding: UTF-8
require 'spec_helper'
require 'earthquake/option_parser'

describe Earthquake::OptionParser do
  describe '#parse' do
    it 'should return an hash' do
      options = Earthquake::OptionParser.new([]).parse
    end

    it 'parses debug option' do
      %w{-d --debug}.each do |opt|
        options = Earthquake::OptionParser.new([opt]).parse
        expect(options[:debug]).to be true
      end
    end

    it 'parses no-logo option' do
      %w{-n --no-logo}.each do |opt|
        options = Earthquake::OptionParser.new([opt]).parse
        expect(options[:'no-logo']).to be true
      end
    end

    it 'parses command option' do
      %w{-c --command}.each do |opt|
        command = 'dummy'
        options = Earthquake::OptionParser.new([opt, command]).parse
        expect(options[:command]).to eq(command)
      end
    end

    it 'parses no-stream option' do
      options = Earthquake::OptionParser.new(['--no-stream']).parse
      expect(options[:'no-stream']).to be true
    end

    it 'parses help option' do
      old_stdout = $stdout
      $stdout = out = StringIO.new
      begin
        Earthquake::OptionParser.new(['--help']).parse
      rescue SystemExit
        # do nothing
      ensure
        $stdout = old_stdout
      end
      out.close
      expect(out.string).to match(/^Usage: /)
    end

    it 'raises exception for invalid option' do
      expect {
        Earthquake::OptionParser.new(['--foo']).parse
      }.to raise_exception
    end

    it 'removes help option' do
      options= Earthquake::OptionParser.new([]).parse
      expect(options).to_not be_key(:help)
    end

    it 'adds rest of arguments as :dir' do
      dir = 'foo'
      options= Earthquake::OptionParser.new([dir]).parse
      expect(options[:dir]).to eq(dir)
    end
  end
end
