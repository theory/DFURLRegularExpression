DFURLRegularExpression
======================

Synopsis
--------
    NSTextCheckingResult *res = [[DFURLRegularExpression URLRegex]
        firstMatchInString:someText
        options:0
        range:(NSRange)NSMakeRange(0, someText.length)
    ];
    
    if (res.range.location != NSNotFound) {
        NSLog(@"Found URL %@", [someText substringWithRange:res.range]);
    }

A common programming problem: identify the URLs in an arbitrary string of text, where by “arbitrary” let’s agree we mean something unstructured such as an email message or a tweet. This class preents, as a solution, [John Gruber's liberal URL-matching regular expression](http://daringfireball.net/2010/07/improved_regex_for_matching_urls). It attempts to be practical, above all else. It makes no attempt to parse URLs according to any official specification. It isn’t limited to predefined URL protocols. It should be clever about things like parentheses and trailing punctuation.

It attempts to be particularly clever with regard to parentheses only ever seem to occur in the wild in Wikipedia URLs, and which many URL matching patterns seem to botch. The pattern looks for up to two levels of balanced, nested parentheses — parentheses within parentheses. Thus it correctly omits the trailing parenthesis in the following line:

    (Something like http://foo.com/blah_blah)

The pattern is also liberal about Unicode glyphs within the URL, which allows it, among other things, to match IDN domain names, such as the ✪df.ws domain.

### +URLRegex ###

Returns a regular expression for matching URLs.

\+ ([NSRegularExpression](http://developer.apple.com/library/ios/#documentation/Foundation/Reference/NSRegularExpression_Class/Reference/Reference.html) *)URLRegex

**Return Value**
An NSRegularExpression object. Use its interface to search for URLs in text.

### +webURLRegex ###

Returns a regular expression for matching only web URLs -- http, https, and things like “www.example.com”.

\+ ([NSRegularExpression](http://developer.apple.com/library/ios/#documentation/Foundation/Reference/NSRegularExpression_Class/Reference/Reference.html) *)webURLRegex

**Return Value**
An NSRegularExpression object. Use its interface to search for web URLs in text.

Author
------

* Regular expressions by [John Gruber](http://daringfireball.net/)
* Ported to Objective-C by [David E. Wheeler](http://justatheory.com/)

Copyright and License
---------------------
(c) 2010 by John Gruber. This pattern is free for anyone to use, no strings attached. Consider it public domain.
