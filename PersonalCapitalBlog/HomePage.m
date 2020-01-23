//
//  ViewController.m
//  PersonalCapitalBlog
//
//  Created by Chris Grayston on 1/17/20.
//  Copyright © 2020 Chris Grayston. All rights reserved.
//

#import "HomePage.h"
#import "ArticleCollectionViewCell.h"

@interface HomePage ()

@end

@implementation HomePage



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    articleParser = [[ArticleParser alloc] loadXMLByURL:@"https://www.personalcapital.com/blog/feed/"];
    
    for (Article *article in articleParser.articles) {
        NSLog(@"Title: %@", article.title);
        //        NSLog(@"Publication Date: %@", article.pubDate);
        //        NSLog(@"Media Content: %@", article.mediaContent);
        //        NSLog(@"Link: %@", article.link);
        //        NSLog(@"");
    }
    
    navBar = [[UINavigationBar alloc] init];
    //navBar.translatesAutoresizingMaskIntoConstraints = YES;
    navItem = [[UINavigationItem alloc] initWithTitle:@"Personal Capital Blog"];
    refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButtonTapped:)];
    navItem.rightBarButtonItem = refreshButton;
    
    [navBar setItems:@[navItem]];
    [self.view addSubview:navBar];
    
    
    layout = [[UICollectionViewFlowLayout alloc] init];
    
    
    collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    
    collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    //collectionView = [[UICollectionView alloc] init];
    //collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height - 150) collectionViewLayout:layout];
    
    [collectionView setDataSource:self];
    [collectionView setDelegate:self];
    
    [collectionView registerClass:[ArticleCollectionViewCell class] forCellWithReuseIdentifier:@"articleCell"];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    [collectionView setBackgroundColor:[UIColor purpleColor]];
    
    [self.view addSubview:collectionView];
    
}

//- (void)viewDidLayoutSubviews {
//
//}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    CGRect safeArea = self.view.safeAreaLayoutGuide.layoutFrame;
    
    CGFloat safeAreaTopY = self.view.safeAreaLayoutGuide.layoutFrame.origin.y;
    CGFloat screenWidth = self.view.frame.size.width;
    CGFloat navBarHeight = ([UIApplication sharedApplication].statusBarFrame.size.height +
                            (self.navigationController.navigationBar.frame.size.height ?: 0.0));
    //CGFloat navBarHeight = self.view.frame.size.height * 0.5;
    //UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, height, width, 50)];
    navBar.frame = CGRectMake(self.view.safeAreaLayoutGuide.layoutFrame.origin.x, safeAreaTopY, safeArea.size.width, 44);
    
    //navBar.translatesAutoresizingMaskIntoConstraints = false;
    
    
    //collectionView.frame = CGRectMake(0, navBarHeight + safeAreaTopY, screenWidth, 100);
    
    // Constraints for CollectionView
    NSLayoutConstraint *collectionViewTopConstraint = [NSLayoutConstraint
                                                       constraintWithItem:collectionView
                                                       attribute:NSLayoutAttributeTop
                                                       relatedBy:NSLayoutRelationEqual
                                                       toItem:navBar
                                                       attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0
                                                       constant:0];
    
    NSLayoutConstraint *collectionViewBottomConstraint = [NSLayoutConstraint
                                                       constraintWithItem:collectionView
                                                       attribute:NSLayoutAttributeBottom
                                                       relatedBy:NSLayoutRelationEqual
                                                       toItem:self.view
                                                       attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0
                                                       constant:0];
    
    NSLayoutConstraint *collectionViewLeadingConstraint = [NSLayoutConstraint
                                                           constraintWithItem:collectionView
                                                           attribute:NSLayoutAttributeLeading
                                                           relatedBy:NSLayoutRelationEqual
                                                           toItem:self.view.safeAreaLayoutGuide
                                                           attribute:NSLayoutAttributeLeading
                                                           multiplier:1.0
                                                           constant:0];
    
    NSLayoutConstraint *collectionViewTrailingConstraint = [NSLayoutConstraint
                                                           constraintWithItem:collectionView
                                                           attribute:NSLayoutAttributeTrailing
                                                           relatedBy:NSLayoutRelationEqual
                                                           toItem:self.view.safeAreaLayoutGuide
                                                           attribute:NSLayoutAttributeTrailing
                                                           multiplier:1.0
                                                           constant:0];
    
    
    
    [self.view addConstraints:@[collectionViewTopConstraint, collectionViewBottomConstraint, collectionViewLeadingConstraint, collectionViewTrailingConstraint]];
    
    //[layout invalidateLayout];
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ArticleCollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"%@%", cell.cellArticle.mediaContent);
    //[_webView loadRequest:[NSURLRequest requestWithURL:cell.cellArticle.mediaContent]];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    webView = [[UIWebView alloc]
        initWithFrame:CGRectMake(0, 0, 320, 480)];

    NSString *urlAddress = @"http://www.google.com";
    NSURL *url = [[NSURL alloc] initWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];

    [webView loadRequest:requestObj];

    [self.view addSubview:webView];
}

-(void)refreshButtonTapped:(UIBarButtonItem*)item {
    NSLog(@"Refresh");
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[articleParser articles] count] - 1;
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ArticleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"articleCell" forIndexPath:indexPath];
    
    
    //cell.backgroundColor = [UIColor greenColor];
    Article *article = articleParser.articles[[indexPath row]];
    //[cell setUpCellWith:[article title] cellImageURL:[article mediaContent]];
    [cell setUpCellWithArticle:article];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    CGFloat width;
    CGFloat height;
//    if (UIDeviceOrientationIsLandscape(orientation)) {
//
//        width = self.view.frame.size.width * 0.3;
//        height = self.view.frame.size.height * 0.15;
//    } else {
//
//        width = (self.view.safeAreaLayoutGuide.layoutFrame.size.width - 31)/3;
//        height = width * 0.75;
//        //width = self.view.frame.size.width * 0.45;
//        //height = self.view.frame.size.height * 0.15;
//    }
    width = (self.view.safeAreaLayoutGuide.layoutFrame.size.width - 21)/2;
    height = width * 0.75;
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    //UIEdgeInsets insets= UIEdgeInsetsMake(0, 0, 10, 10);
    return UIEdgeInsetsMake(0, 5, 0, 5);
}



//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    CGSize headerSize = CGSizeMake(320, 44);
//    return headerSize;
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize headerSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 0.20);
    return headerSize;
}


//-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
//                               duration:(NSTimeInterval)duration{
//
//    [collectionView.collectionViewLayout invalidateLayout];
//}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    CGFloat width;
    CGFloat height;
    if (UIDeviceOrientationIsPortrait(orientation)) {
        width = (self.view.safeAreaLayoutGuide.layoutFrame.size.width - 21)/2;
        height = width * 0.75;
        layout.itemSize = CGSizeMake(width, height);
        //[layout invalidateLayout];
    } else {
        width = (self.view.safeAreaLayoutGuide.layoutFrame.size.width - 21)/2;
        height = width * 0.75;
        layout.itemSize = CGSizeMake(width, height);
        layout.itemSize = CGSizeMake(width, height);
        //[layout invalidateLayout];
    }
}




@end
