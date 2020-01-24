//
//  WebWiewDisplayViewController.m
//  PersonalCapitalBlog
//
//  Created by Chris Grayston on 1/23/20.
//  Copyright © 2020 Chris Grayston. All rights reserved.
//

#import "WebViewDisplayViewController.h"

@interface WebViewDisplayViewController ()


@end

/*
* WebViewDisplayViewController displays the selected
* article's web page using WKWebView.
*/
@implementation WebViewDisplayViewController
@synthesize article = _article;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set Up the navigation bar
    navBar = [[UINavigationBar alloc] init];
    navItem = [[UINavigationItem alloc] initWithTitle:@"Personal Capital Blog"];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(backButtonTapped:)];
    navItem.leftBarButtonItem = backButton;
    
    [navBar setItems:@[navItem]];
    [self.view addSubview:navBar];
    
    // Set up WKWebView
    webView = [[WKWebView alloc] init];
    webView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:webView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // Helper variables to shorten code
    UILayoutGuide *safeArea = self.view.safeAreaLayoutGuide;
    CGFloat safeAreaTopY = self.view.safeAreaLayoutGuide.layoutFrame.origin.y;
    
    // Set navigation bar's frame
    navBar.frame = CGRectMake(self.view.safeAreaLayoutGuide.layoutFrame.origin.x, safeAreaTopY, safeArea.layoutFrame.size.width, 44);
    
    // Set constraints for web view
    [webView.topAnchor constraintEqualToAnchor:navBar.bottomAnchor].active = true;
    [webView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = true;
    [webView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = true;
    [webView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = true;
}


- (void)setArticle:(Article *)article {
    // Reuturn is article was set to nil
    if (article == nil) return;
    
    // Set local article
    _article = article;
    
    // Display the web page
    [self displayWebPage];
}



-(void)displayWebPage {
    // Set navigation bar title
    [navItem setTitle:self.article.title];
    
    // Create URL request
    NSURL *url = [NSURL URLWithString:self.article.link];
    [url URLByAppendingPathComponent:@"?displayMobileNavigation=0"];
    NSURLRequest *urlReq = [NSURLRequest requestWithURL:url];
    
    // Load URL request
    [webView loadRequest:urlReq];
    
}

/*
* Dismisses presenting view controller when back button is tapped
*
* @param item
*/
-(void)backButtonTapped:(UIBarButtonItem*)item {
    // Dismiss presenting view controller
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
