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

/*
 * Parser to gather article information from Personal Capital RSS Feed.
 */
@interface ArticleParser : NSObject <NSXMLParserDelegate> {
    /* The current node */
    NSString *currentNodeContent;
    
    /* Parser object */
    NSXMLParser *parser;
    
    /* Current article we are on */
    Article *currentArticle;
}

/* Holds articles from RSS Feed */
@property(readonly, retain) NSMutableArray *articles;

/*
 * Loads XML from URL prameter
 *
 * @param urlString Personal Capital RSS url
 * @return id
 */
- (id)loadXMLByURL:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END
