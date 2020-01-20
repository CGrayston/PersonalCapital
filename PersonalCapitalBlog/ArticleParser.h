//
//  ArticleParser.h
//  PersonalCapitalBlog
//
//  Created by Chris Grayston on 1/17/20.
//  Copyright © 2020 Chris Grayston. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Article.h"

NS_ASSUME_NONNULL_BEGIN

@interface ArticleParser : NSObject <NSXMLParserDelegate> {
    NSString *currentNodeContent;
    NSMutableArray *articles;
    NSXMLParser *parser;
    Article *currentArticle;
}

// MARK: - Properties
@property(readonly, retain) NSMutableArray *articles;

- (id)loadXMLByURL:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END
