//
//  ViewController.h
//  PersonalCapitalBlog
//
//  Created by Chris Grayston on 1/17/20.
//  Copyright © 2020 Chris Grayston. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleParser.h"

@interface HomePage : UIViewController<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    ArticleParser *articleParser;
    
    UICollectionViewFlowLayout *layout;
    UICollectionView *collectionView;
    UINavigationBar *navBar;
    UINavigationItem *navItem;
    UIBarButtonItem *refreshButton;
    
}
//@property (nonatomic, strong) UIView *contentView;
//@property (nonatomic, strong) UICollectionReusableView *articleHeaderView;

//@property (nonatomic, strong) UINavigationBar *navBar;
//@property (nonatomic, strong) UINavigationItem *navItem;
//@property (nonatomic, strong) UIBarButtonItem *refreshButton;


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect;
@end

