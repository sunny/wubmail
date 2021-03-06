#!/usr/bin/ruby

require 'erb'
require 'net/smtp'
require 'open-uri'

class WubMail
  attr_accessor :options

  def initialize(template, options = {})
    @template = template
    @options = options
    parse
  end

  # allows template to use "name" instead of "options[:name]"
  def method_missing(method, *args)
    @options[method]
  end

  # sets attributes smtp_message, headers, from and to
  def parse
    # fetch contents from erb template
    @smtp_message = ERB.new(@template).result(binding)

    # build a headers hash
    header_lines = @smtp_message.split("\n\n", 2).first.split("\n")
    headers_options = header_lines.collect { |line| line.split(/: ?/, 2) }
    @headers = Hash[*headers_options.flatten]

    # guess emails from headers
    @from = header 'From'
    @to = header 'To'
  end

  def header(name)
    @headers[name].gsub(/[<>]/, '').gsub(/^.* /, '').chomp
  end
  
  def to_s
    @smtp_message
  end

  def send!
    Net::SMTP.start('localhost') do |smtp|
      smtp.send_message @smtp_message, @from, @to
    end
    true
  end
end


class WubMailCSV
  attr_reader :recipients

  def initialize(template, csv)
    @template = open(template).read
    @csv = open(csv).read
    parse
  end
  
  def parse
    # ignore blank lines and comments
    head, *lines = @csv.gsub(/#.*$/, '').grep(/\w/)
    headers = head.split(/,/).collect { |h| h.strip.to_sym }
    
    @recipients = lines.collect do |line|
      values = line.split(/,/).collect { |v| v.strip }
      Hash[*headers.zip(values).flatten]
    end
  end
  
  def example
    recipient = @recipients[rand(@recipients.size)]
    WubMail.new(@template, recipient).to_s
  end
  
  def send!
    @recipients.each do |recipient_hash|
      ok = WubMail.new(@template, recipient_hash).send!
      yield [recipient_hash, ok] if block_given?
    end
  end
end

