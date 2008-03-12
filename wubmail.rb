#!/usr/bin/ruby
#
# WubMail is a small wrapper to send quick emails with an erb template.
# by Sunny Ripert
#
# Example
# --------
# welcome.txt:
#    From: Sunny <sunny@sunfox.org>
#    To: <%= to %>
#    Subject: HAY <%= name %>!1
#    X-Mailer: LOLMAILOR
#    <%= headers %>
#    
#    Hello <%= name %>,
#    You are one hell of a smart <%= sex == :female ? "woman" : "guy" %>!
#
# send_these_mails_already.rb:
#    WubMail.new(:welcome, :to => "negatif@gmail.com", :name => "Negatif", :sex => :male).send!
#    WubMail.new(:welcome, :to => "srzt@hotchicks.com", :name => "Susy Rozet", :sex => :female).send!
#
# Licence
# -------
# Ermm. GPL? I Guess?

require 'erb'
require 'net/smtp'

class WubMail
  attr_accessor :options

  def initialize(template_name, options = {})
    @template_name = template_name
    @options = options
  end

  # allows template to use "name" instead of "options[:name]"
  def method_missing(method, *args)
    @options[method]
  end

  # sets attributes smtp_message, headers, from and to
  def parse
    return unless @smtp_message.nil?
    
    # fetch contents from erb template
    contents = open("#{@template_name}.txt").read
    @smtp_message = ERB.new(contents).result(binding)

    # build a headers hash
    header_lines = @smtp_message.split("\n\n", 2).first.split("\n")
    headers_options = header_lines.map { |l| opt = l.split(/: ?/, 2) }
    @headers = Hash[*header_options.flatten]

    # guess emails from headers
    @from = @headers['From'].gsub(/[<>]/, '').gsub(/^.* /, '').chomp
    @to = @headers['To'].gsub(/[<>]/, '').gsub(/^.* /, '').chomp
  end

  def send!
    parse
    Net::SMTP.start('localhost') do |smtp|
      smtp.send_message @smtp_message, @from, @to
    end
    true
  end
end
