//
//  DFURLRegularExpression.h
//  DFURLRegularExpression
//
//  Created by David E. Wheeler on 12/16/10.
//  Regular expresions by John Gruber and released to the public domain.
//  http://daringfireball.net/2010/07/improved_regex_for_matching_urls
//

#import <Foundation/Foundation.h>

@interface DFURLRegularExpression : NSObject {

}

+ (NSRegularExpression *)URLRegex;
+ (NSRegularExpression *)webURLRegex;

@end
