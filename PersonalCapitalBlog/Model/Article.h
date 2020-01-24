//
//  Article.h
//  PersonalCapitalBlog
//
//  Created by Chris Grayston on 1/17/20.
//  Copyright © 2020 Chris Grayston. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 * Article object from information parsed
 * from Personal Capital RSS feed.
 */
@interface Article : NSObject

/* The article properties to get from the PC RSS Feed */
@property(nonatomic, retain)NSString *item;
@property(nonatomic, retain)NSString *title;
@property(nonatomic, retain)NSString *articleDescription;
@property(nonatomic, retain)NSString *pubDate;
@property(nonatomic, retain)NSString *mediaContent;
@property(nonatomic, retain)NSString *link;

@end

NS_ASSUME_NONNULL_END
