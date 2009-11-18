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
    X-Mailer: Wubmail
     
    Hello <%= name %>,
    You are one hell of a cute <%= sex == "female" ? "girl" : "boy" %>!

users.csv:

    email,name,sex
    sunny@example.com,Sunny,male
    audrey@example.com,Audrey,female

Then typing:

    $ wubmail -s welcome.txt users.csv

Will send:

    From: Sunny <sunny@sunfox.org>
    To: Sunny <negatif@gmail.com>
    Subject: HAY Sunny!1
    X-Mailer Wubmail
    
    Hello Sunny,
    You are one hell of a cute guy!


