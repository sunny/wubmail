WubMail
=======

WubMail is a tiny wrapper to send emails with an erb template. Also likes CSV files a lot.

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

You see, it knows about `email`, `name` and `sex` as they are the names of the columns of your `users.csv` file.

Then type:

    $ wubmail welcome.txt users.csv

And it will print out an example, like so:

    From: Sunny <sunny@sunfox.org>
    To: Jack <jack@example.com>
    Subject: Hello Jack!
    
    Hello Jack,
    You are one hell of a cute guy!

When you are ready, call wubmail again with the `-s` argument and whizz! it will be sent to everybody in the csv file.
