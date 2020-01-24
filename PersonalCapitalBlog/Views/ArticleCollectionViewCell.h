//
//  ArticleCollectionViewCell.h
//  PersonalCapitalBlog
//
//  Created by Chris Grayston on 1/19/20.
//  Copyright © 2020 Chris Grayston. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

NS_ASSUME_NONNULL_BEGIN

/*
 * A custom collectionView cell used to model
 * article from Personal Capital
 */
@interface ArticleCollectionViewCell : UICollectionViewCell {
    /* The article image */
    UIImageView *articleCellImageView;
    
    /* The article title */
    UILabel *articleCellTitleLabel;
    
    /* The view holding content view */
    UIView *view;
    
    /* The activity indicator when images are loading */
    UIActivityIndicatorView *indicator;
    
}

/* Article object to represent the cell */
@property (nonatomic, strong) Article *cellArticle;

@end

NS_ASSUME_NONNULL_END
