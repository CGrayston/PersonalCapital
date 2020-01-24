//
//  ArticleParser.m
//  PersonalCapitalBlog
//
//  Created by Chris Grayston on 1/17/20.
//  Copyright © 2020 Chris Grayston. All rights reserved.
//

#import "ArticleParser.h"
#import "Article.h"

@implementation ArticleParser
@synthesize articles;

- (void) parser:(NSXMLParser *)paser didStartElement:(nonnull NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(nonnull NSDictionary<NSString *,NSString *> *)attributeDict {
    // Allocate memeory for new Article when we see <item> tag
    if ([elementName isEqualToString:@"item"]) {
        currentArticle = [Article alloc];
    }
    if ([elementName isEqualToString:@"enclosure"]) {
        currentArticle.mediaContent = attributeDict[@"url"];
        currentNodeContent = nil;
    }
}

- (void) parser:(NSXMLParser *)parser didEndElement:(nonnull NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName {
    if ([elementName isEqualToString:@"title"]) {
        currentArticle.title = currentNodeContent;
    }
    if ([elementName isEqualToString:@"pubDate"]) {
        currentArticle.pubDate = currentNodeContent;
    }
    if ([elementName isEqualToString:@"enclosure url"]) {
        currentArticle.mediaContent = currentNodeContent;
    }
    if ([elementName isEqualToString:@"link"]) {
        currentArticle.link = currentNodeContent;
    }
    if ([elementName isEqualToString:@"description"]) {
        currentArticle.articleDescription = currentNodeContent;
    }
    
    if ([elementName isEqualToString:@"item"]) {
        
        [articles addObject:currentArticle];
        
        currentArticle = nil;
        
        
    }
    currentNodeContent = nil;

}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ([string isEqualToString:@"–"] || [string isEqualToString:@"‘"] || [string isEqualToString:@"’"] || [string isEqualToString:@"™"]) {
        currentNodeContent = [currentNodeContent stringByAppendingString:string];
    } else if ([currentNodeContent containsString:@"–"] || [currentNodeContent containsString:@"‘"] || [currentNodeContent containsString:@"’"] || [currentNodeContent containsString:@"™"] || [currentNodeContent containsString:@"“"] || [string containsString:@"“"] ||[string containsString:@"–"] || [string containsString:@"‘"] || [string containsString:@"’"] || [string containsString:@"™"]) {
        currentNodeContent = [currentNodeContent stringByAppendingString:string];
    } else {
        currentNodeContent = (NSMutableString*) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        //currentNodeContent = (NSMutableString*) string;
    }
    
}

/*
* Loads XML from URL prameter
*
* @param urlString Personal Capital RSS url
* @return id
*/
- (id)loadXMLByURL:(NSString *)urlString {
    // Initilize articles
    articles = [[NSMutableArray alloc] init];
    
    // Create url from urlString
    NSURL *url = [NSURL URLWithString:urlString];
    NSError *error;
    
    // Get contents
    NSString* contents = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    
    // Get encoded data
    NSData* data = [contents dataUsingEncoding:NSUTF8StringEncoding];
    
    // Initilize paser
    parser = [[NSXMLParser alloc] initWithData:data];
    
    // Set delgate
    parser.delegate = self;
    
    // Start the event-driven parsing operation.
    [parser parse];
    
    return self;
}

@end
