//
//  ViewController.h
//  PersonalCapitalBlog
//
//  Created by Chris Grayston on 1/17/20.
//  Copyright © 2020 Chris Grayston. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleParser.h"
#import "HeaderArticleCollectionReusableView.h"
#import "ArticleCollectionViewCell.h"
#import "WebViewDisplayViewController.h"
#import "HeaderArticleCollectionReusableView.h"

/*
* HomePageViewController displays articles parsed from the Personal Capital RSS Feed.
* Tapping an article will render the article’s link in an embedded webview on another
* screen with the title of the article displayed in the navigation bar.
*/
@interface HomePageViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    /* The object to read and hold articles from PC RSS Feed*/
    ArticleParser *articleParser;
    
    /* The view that will hold articles from PC RSS Feed*/
    UICollectionViewFlowLayout *layout;
    UICollectionView *collectionView;
    
    /* The retained navigation bar elements */
    UINavigationBar *navBar;
    UINavigationItem *navItem;
    UIBarButtonItem *refreshButton;
    
    /* Holds first article from PC RSS Feed */
    Article *firstArticle;
    
    /* */
    CGFloat collumns;
}

@end
