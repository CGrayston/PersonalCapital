//
//  WebWiewDisplayViewController.h
//  PersonalCapitalBlog
//
//  Created by Chris Grayston on 1/23/20.
//  Copyright © 2020 Chris Grayston. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "Article.h"

NS_ASSUME_NONNULL_BEGIN

/*
* WebViewDisplayViewController displays the selected
* article's web page using WKWebView.
*/
@interface WebViewDisplayViewController : UIViewController<UIWebViewDelegate> {
    /* The WKWebView to display the web page */
    WKWebView *webView;
    
    /* The Navigation bar to dsiplay title and return to HomePage */
    UINavigationBar *navBar;
    UINavigationItem *navItem;
}

@property (nonatomic, strong) Article *article;

@end

NS_ASSUME_NONNULL_END
