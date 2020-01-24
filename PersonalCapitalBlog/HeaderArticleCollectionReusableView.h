//
//  HeaderArticleCollectionReusableView.h
//  PersonalCapitalBlog
//
//  Created by Chris Grayston on 1/21/20.
//  Copyright © 2020 Chris Grayston. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

NS_ASSUME_NONNULL_BEGIN

/*
* Custom view to reperesnt the first article parsed from Personal Capital's RSS Feed.
* View is dispalyed in the header portion of the collection view.
*/
@interface HeaderArticleCollectionReusableView : UICollectionReusableView {
    /* The article image */
    UIImageView *articleImageView;
    
    /* The article title */
    UILabel *articleTitleLabel;
    
    /* The article description */
    UILabel *articleDescriptionLabel;
    
    /* The activity indicator when images are loading */
    UIActivityIndicatorView *indicator;
    
    /* View where objects will be palced*/
    UIView *contentView;
}

/* Article object to represent the cell */
@property (nonatomic, strong) Article *article;

@end

NS_ASSUME_NONNULL_END
