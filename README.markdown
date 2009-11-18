WubMail
=======

WubMail is a tiny wrapper to send emails with an erb template.

By Sunny Ripert <http://sunfox.org>, under the WTFPL <http://sam.zoy.org/wtfpl/>

Example
-------

welcome.txt:

    From: Sunny <sunny@sunfox.org>
    To: <%= name %> <<%= email %>>
    Subject: HAY <%= name %>!1
    
    Hello <%= name %>,
    You are one hell of a cute <%= sex == "female" ? "girl" : "boy" %>!

users.csv:

    email,name,sex
    jack@example.com,Jack,male
    ianto@example.com,Ianto,male

Then typing:

    $ wubmail -s welcome.txt users.csv

Will send to all users something like this:

    From: Sunny <sunny@sunfox.org>
    To: Jack <jack@example.com>
    Subject: HAY Jack!1
    
    Hello Jack,
    You are one hell of a cute guy!

