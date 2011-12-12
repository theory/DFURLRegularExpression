//
//  DFURLRegularExpression.m
//  DFURLRegularExpression
//
//  Created by David E. Wheeler on 12/16/10.
//  Regular expresions by John Gruber and released to the public domain.
//  http://daringfireball.net/2010/07/improved_regex_for_matching_urls
//

#import "DFURLRegularExpression.h"

static NSRegularExpression *URLRegex    = nil;
static NSRegularExpression *WebURLRegex = nil;

@implementation DFURLRegularExpression

+ (void)initialize {
    if (self == [DFURLRegularExpression class]) {
        URLRegex = [NSRegularExpression
            regularExpressionWithPattern:@"\\b((?:[a-z][\\w-]+:(?:/{1,3}|[a-z0-9%])|www\\d{0,3}[.]|[a-z0-9.\\-]+[.][a-z]{2,4}/)(?:[^\\s()<>]+|\\(([^\\s()<>]+|(\\([^\\s()<>]+\\)))*\\))+(?:\\(([^\\s()<>]+|(\\([^\\s()<>]+\\)))*\\)|[^\\s`!()\\[\\]{};:'\".,<>?«»“”‘’]))"
                    options:NSRegularExpressionCaseInsensitive
                    error:nil
        ];

        WebURLRegex = [NSRegularExpression
            regularExpressionWithPattern:@"\\b((?:https?://|www\\d{0,3}[.]|[a-z0-9.\\-]+[.][a-z]{2,4}/)(?:[^\\s()<>]+|\\(([^\\s()<>]+|(\\([^\\s()<>]+\\)))*\\))+(?:\\(([^\\s()<>]+|(\\([^\\s()<>]+\\)))*\\)|[^\\s`!()\\[\\]{};:'\".,<>?«»“”‘’]))"
                       options:NSRegularExpressionCaseInsensitive
                       error:nil
        ];
#if !__has_feature(objc_arc)
        [URLRegex retain];
        [WebURLRegex retain];
#endif
    }
}

+ (NSRegularExpression *)URLRegex {
    return URLRegex;
}

+ (NSRegularExpression *)webURLRegex {
    return WebURLRegex;
}

@end

//(?xi)
//\b
//(                           # Capture 1: entire matched URL
//  (?:
//    [a-z][\w-]+:                # URL protocol and colon
//    (?:
//      /{1,3}                        # 1-3 slashes
//      |                             #   or
//      [a-z0-9%]                     # Single letter or digit or '%'
//                                    # (Trying not to match e.g. "URI::Escape")
//    )
//    |                           #   or
//    www\d{0,3}[.]               # "www.", "www1.", "www2." … "www999."
//    |                           #   or
//    [a-z0-9.\-]+[.][a-z]{2,4}/  # looks like domain name followed by a slash
//  )
//  (?:                           # One or more:
//    [^\s()<>]+                      # Run of non-space, non-()<>
//    |                               #   or
//    \(([^\s()<>]+|(\([^\s()<>]+\)))*\)  # balanced parens, up to 2 levels
//  )+
//  (?:                           # End with:
//    \(([^\s()<>]+|(\([^\s()<>]+\)))*\)  # balanced parens, up to 2 levels
//    |                                   #   or
//    [^\s`!()\[\]{};:'".,<>?«»“”‘’]        # not a space or one of these punct chars
//  )
//)


// Only Web URLs.
//(?xi)
//\b
//(                       # Capture 1: entire matched URL
//  (?:
//    https?://               # http or https protocol
//    |                       #   or
//    www\d{0,3}[.]           # "www.", "www1.", "www2." … "www999."
//    |                           #   or
//    [a-z0-9.\-]+[.][a-z]{2,4}/  # looks like domain name followed by a slash
//  )
//  (?:                       # One or more:
//    [^\s()<>]+                  # Run of non-space, non-()<>
//    |                           #   or
//    \(([^\s()<>]+|(\([^\s()<>]+\)))*\)  # balanced parens, up to 2 levels
//  )+
//  (?:                       # End with:
//    \(([^\s()<>]+|(\([^\s()<>]+\)))*\)  # balanced parens, up to 2 levels
//    |                               #   or
//    [^\s`!()\[\]{};:'".,<>?«»“”‘’]        # not a space or one of these punct chars
//  )
//)