WubMail
=======

WubMail is a small tool to send emails using a template and a CSV file.

By Sunny Ripert <http://sunfox.org>, under the WTFPL <http://sam.zoy.org/wtfpl/>

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

You see, it knows about `email`, `name` and `sex` as they are the names of the columns of your csv file.

Then type in a terminal:

    $ wubmail welcome.txt users.csv

And it will print out an example, which you can send to everybody if you call `wubmail` again with the `-s` argument. file. That's it!
