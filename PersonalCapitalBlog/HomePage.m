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
//        NSLog(@"Title: %@", article.title);
//        NSLog(@"Publication Date: %@", article.pubDate);
//        NSLog(@"Media Content: %@", article.mediaContent);
//        NSLog(@"Link: %@", article.link);
//        NSLog(@"");
    }
    
    // Set up HomePage
    self.view = [[UIView alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [collectionView setDataSource:self];
    [collectionView setDelegate:self];
    
    [collectionView setDataSource:self];
    [collectionView setDelegate:self];
    
    [collectionView registerClass:[ArticleCollectionViewCell class] forCellWithReuseIdentifier:@"articleCell"];
    
    [collectionView setBackgroundColor:[UIColor redColor]];

    [self.view addSubview:collectionView];
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //NSInteger numberOfArticles = [[articleParser articles] count] - 1; //articleParser.articles.count;
    
    //
    // First story is all by itself up top
    // iPhone gets rows of 2
    // tablet gets rows of 3
    //
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        return 3
//    } else {
//        return 2
//    }
    return [[articleParser articles] count] - 1;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ArticleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"articleCell" forIndexPath:indexPath];

    
    //cell.backgroundColor = [UIColor greenColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(125, 125);
}


//-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
//                               duration:(NSTimeInterval)duration{
//
//    [collectionView.collectionViewLayout invalidateLayout];
//}



@end
