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

@interface ArticleCollectionViewCell : UICollectionViewCell {
    UIImageView *articleCellImageView;
    UILabel *articleCellTitleLabel;
    
    Article *article;
}

-(void)setup;

-(void)updateView;

-(void)setUpCellWith:(NSString *)articleTitle cellImageURL:(NSString *)articleImageURL;

@end

NS_ASSUME_NONNULL_END
