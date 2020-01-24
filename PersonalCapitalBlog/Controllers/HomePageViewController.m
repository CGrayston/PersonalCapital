//
//  ViewController.m
//  PersonalCapitalBlog
//
//  Created by Chris Grayston on 1/17/20.
//  Copyright © 2020 Chris Grayston. All rights reserved.
//

#import "HomePageViewController.h"
#import "ArticleCollectionViewCell.h"

/*
 * HomePageViewController displays articles parsed from the Personal Capital RSS Feed.
 * Tapping an article will render the article’s link in an embedded webview on another
 * screen with the title of the article displayed in the navigation bar.
 */
@interface HomePageViewController ()

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // Parse RSS
    [self parseRSS];
    
    // Set collumns based on device
    if ( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad )
    {
        collumns = 3;
    } else {
        collumns = 2;
    }
    
    // Set Up Nav Bar
    navBar = [[UINavigationBar alloc] init];
    navBar.barStyle = UIBarStyleDefault;
    navItem = [[UINavigationItem alloc] initWithTitle:@"Personal Capital Blog"];
    refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButtonTapped:)];
    navItem.rightBarButtonItem = refreshButton;
    
    [navBar setItems:@[navItem]];
    [self.view addSubview:navBar];
    
    // Set Up CollectionView with FlowLayout
    layout = [[UICollectionViewFlowLayout alloc] init];
    collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [collectionView setBackgroundColor:[UIColor whiteColor]];
    collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Set DataSource and Delegate
    [collectionView setDataSource:self];
    [collectionView setDelegate:self];
    
    // Register Classes for custom CollectionViewCell and HeaderView
    [collectionView registerClass:[ArticleCollectionViewCell class] forCellWithReuseIdentifier:@"articleCell"];
    [collectionView registerClass:[HeaderArticleCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    
    // Add collectionView to superView
    [self.view addSubview:collectionView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // Variables to shorten code
    UILayoutGuide *safeArea = self.view.safeAreaLayoutGuide;
    CGFloat safeAreaTopY = self.view.safeAreaLayoutGuide.layoutFrame.origin.y;
    
    // Set navBar frame
    navBar.frame = CGRectMake(safeArea.layoutFrame.origin.x, safeAreaTopY, safeArea.layoutFrame.size.width, 44);
    
    // Set collectionView constraints
    [collectionView.leadingAnchor constraintEqualToAnchor:safeArea.leadingAnchor].active = true;
    [collectionView.trailingAnchor constraintEqualToAnchor:safeArea.trailingAnchor].active = true;
    [collectionView.topAnchor constraintEqualToAnchor:navBar.bottomAnchor].active = true;
    [collectionView.bottomAnchor constraintEqualToAnchor:safeArea.bottomAnchor].active = true;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // Get selected cell
    ArticleCollectionViewCell *cell = (ArticleCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    // Initilize WebViewDisplayViewController
    WebViewDisplayViewController *webViewVC = [[WebViewDisplayViewController alloc] init];
    webViewVC.modalPresentationStyle = UIModalPresentationFullScreen;
    
    // Present WebViewDisplayViewController
    [self presentViewController:webViewVC animated:YES completion:nil];
    
    // Pass selected cell's article to WebViewDisplayViewController
    // Will set the title and set the url to navigate to
    webViewVC.article = cell.cellArticle;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // Return number of articles to be displayed in contentView
    return [[articleParser articles] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // Set up custom article cell
    ArticleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"articleCell" forIndexPath:indexPath];
    
    // Get cell at desired index
    Article *article = articleParser.articles[[indexPath row]];
    
    // Set article in custom cell
    cell.cellArticle = article;
    
    // Return custom configured cell
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    // Create custom header
    HeaderArticleCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
    
    // Add gestur recognizer to header
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerTapped:)];
    [header addGestureRecognizer:tapGestureRecognizer];
    
    // Pass article to be displayed to header
    header.article = firstArticle;
    
    // Return custom configure header
    return header;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    // Create width and height to set cells in collectionView to
    CGFloat width = (self.view.safeAreaLayoutGuide.layoutFrame.size.width - ((collumns * 10) + 1))/collumns;;
    CGFloat height = width * 0.75;;
    
    // Return custom cell size
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(5, 5, 0, 5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    // Create width and height to set cells in collectionView to
    CGFloat width = self.view.safeAreaLayoutGuide.layoutFrame.size.width;
    CGFloat height = width * 0.6;
    
    // Prevent height from being greater than screen height
    if (height > self.view.frame.size.height * 0.8) {
        height = self.view.frame.size.height * 0.65;
    }
    return CGSizeMake(width, height);
}

/*
 * Will parse Personal Capital RSS feed and set the article array
 * source of truth and firstArticle for the custom header.
 */
-(void)parseRSS {
    // Parse Personal Capital RSS Feed and set source of truth
    articleParser = [[ArticleParser alloc] loadXMLByURL:@"https://www.personalcapital.com/blog/feed/"];
    
    // Set firstArticle from the first articel in the array
    firstArticle = articleParser.articles.firstObject;
    [articleParser.articles removeObjectAtIndex:0];
}

/*
 * When the refresh barButtonItem is tapped we parse the
 * Personal Capital RSS Feed and refreshes the collectionView.
 *
 * @param item
 */
-(void)refreshButtonTapped:(UIBarButtonItem*)item {
    // Querry RSS Feed
    [self parseRSS];
    
    // Refresh collectionView
    [collectionView reloadData];
}

/*
 * When the header view is tapped querry the
 * Personal Capital RSS Feed and refreshes the collectionView.
 *
 * @param item
 */
-(void)headerTapped:(HeaderArticleCollectionReusableView*)headerView {
    // Initilize WebViewDisplayViewController
    WebViewDisplayViewController *webViewVC = [[WebViewDisplayViewController alloc] init];
    webViewVC.modalPresentationStyle = UIModalPresentationFullScreen;
    
    // Present WebViewDisplayViewController
    [self presentViewController:webViewVC animated:YES completion:nil];
    
    // Pass first article to WebViewDisplayViewController
    webViewVC.article = firstArticle;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    // Reload collection view
    [collectionView reloadData];
}

@end
