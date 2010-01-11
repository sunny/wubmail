WubMail
=======

WubMail is a small tool to send emails using a template and a CSV file.

By Sunny Ripert <http://sunfox.org>, under the WTFPL <http://sam.zoy.org/wtfpl/>

Install
-------

    $ gem install wubmail -s http://gemcutter.org

Example
-------

users.csv:

    email,name,sex
    jack@example.com,Jack,male
    gwen@example.com,Gwen,female
    ianto@example.com,Ianto,male

welcome.txt:

    From: Sunny <sunny@sunfox.org>
    To: <%= name %> <<%= email %>>
    Subject: Hello <%= name %>!

    Hello <%= name %>,
    You are one hell of a cute <%= sex == "female" ? "girl" : "boy" %>!

Then type in a terminal:

    $ wubmail welcome.txt users.csv

And it will print out an example. You can then end send it to everybody if you call wubmail again with the `-s` argument. That's it!


Answers
-------

### How do I add variables in the message?

Just create new columns in your csv like I did in the example with `email`, `name` and `sex`. You may use any column name you want as long as it fits a Ruby variable name.

### What can I put in my email?

The message is parsed using Erb, which means you can put any amount of Ruby you'd like in it, between `<%` and `%>`.

### How do I add headers?

You can add as many headers as you like by adding them next to From, To and Subject like in the example.


Another example
---------------

friends.txt:

  email,arrival_time,ps
  naps@example.com,18
  webs@example.com,18,PS: Don't be late this time!
  srzt@example.com,16
  ook?@example.com,16

winners_message.html.erb:

  From: Sunny <sunny@sunfox.org>
  To: <%= email %>
  Subject: Great Party
  X-Mailer: Wubmail/1.0

  Hello,
  Just a quick note to tell you that for the great party
  you should arrive at <%= arrival_time %> o'clock.

  Thanks,
  Sunny

  <%= ps %>

