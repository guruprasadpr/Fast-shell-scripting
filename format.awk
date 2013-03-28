BEGIN{print "a\n<pre class=\"gpr1\">";}
/^ *$/{
        print "</pre>\n"++i"\n<pre class=\"gpr1\">";
        next;
}1
END{
        print "</pre>";
}

