//
//  HeaderArticleCollectionReusableView.h
//  PersonalCapitalBlog
//
//  Created by Chris Grayston on 1/21/20.
//  Copyright © 2020 Chris Grayston. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeaderArticleCollectionReusableView : UICollectionReusableView {
    UIImageView *articleImageView;
    UILabel *articleTitleLabel;
    UILabel *articleDescriptionLabel;
}

@end

NS_ASSUME_NONNULL_END
