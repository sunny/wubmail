WubMail
=======

WubMail is a small command line tool to send emails to using a template and a list of emails.

Install
-------

```sh
$ gem install wubmail
```

Example
-------

users.txt:

```csv
email,name,sex
jack@example.com,Jack,male
gwen@example.com,Gwen,female
ianto@example.com,Ianto,male
```

welcome.txt:

```erb
From: Sunny <sunny@sunfox.org>
To: <%= name %> <<%= email %>>
Subject: Hello <%= name %>!

Hello <%= name %>,
You are one hell of a cute <%= sex == "female" ? "girl" : "boy" %>!
```

Then type in a terminal:

```sh
$ wubmail welcome.txt users.csv
```

And it will print out an example. Send it to everybody by adding the `-s` argument. That's it!


Answers
-------

### How do I add variables in the message?

Just create new columns in your csv. You may use any column name you want as long as it can be a Ruby variable name.

### What can I put in my email?

The message is parsed using erb, which means you can put any amount of Ruby you'd like in it, between `<%` and `%>`.

### How do I add headers?

Just add lines under From, To and Subject.


Another example
---------------

friends.csv:

```csv
email,arrival_time,ps
naps@example.com,18
srzt@example.com,16
phil@example.com,16
webs@example.com,18,PS: Don't be late this time!
gamo@example.com,18,PS: Don't forget to bring one of your favorite recipes.
```

party-email.txt.erb:

```erb
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
```

Credits
-------

By Sunny Ripert <http://sunfox.org>, under the WTFPL <http://sam.zoy.org/wtfpl/>.