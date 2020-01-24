//
//  ArticleCollectionViewCell.m
//  PersonalCapitalBlog
//
//  Created by Chris Grayston on 1/19/20.
//  Copyright © 2020 Chris Grayston. All rights reserved.
//

#import "ArticleCollectionViewCell.h"

/*
* A custom collectionView cell used to model
* article from Personal Capital
*/
@implementation ArticleCollectionViewCell
@synthesize cellArticle = _cellArticle;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Set Up View
        view = self.contentView;
        view.backgroundColor = [UIColor whiteColor];
        view.layer.borderWidth = 1.0f;
        view.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        // Set up article image
        articleCellImageView = [[UIImageView alloc] init];
        [view addSubview:articleCellImageView];

        // Set Up Indicator
        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
        
        // Set Up article title label
        articleCellTitleLabel = [[UILabel alloc] init];
        articleCellTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        articleCellTitleLabel.textColor = [UIColor darkTextColor];
        [articleCellTitleLabel setNumberOfLines:2];
        [articleCellTitleLabel setFont:[UIFont systemFontOfSize:12]];
        [view addSubview:articleCellTitleLabel];
    }
    return self;
}

/*
* Setter for the cell's article object
*
* @param cellArticle A article to populate the cell
*/
- (void)setCellArticle:(Article *)cellArticle {
    // If cell was set to nil, return
    if (cellArticle == nil) return;
    
    // Set cellArticle
    _cellArticle = cellArticle;
    
    // Call update view
    [self updateView];
}

/*
* Sets the image and title for the cell using the
* cell's set article object.
*/
-(void)updateView {
    // set cells title label
    articleCellTitleLabel.text = self.cellArticle.title;
    
    // Submits a block for priority asynchronous execution
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Initilize image url and  data
        NSURL *imageURL = [NSURL URLWithString:self.cellArticle.mediaContent];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];

        // Set cell image and remove indicator
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self->indicator removeFromSuperview];
            self->articleCellImageView.image = [UIImage imageWithData:imageData];
             // Set to put on main thread
            self->articleCellImageView.image = self->articleCellImageView.image;
         });
     });
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // Set up articleImageView
    articleCellImageView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height * 0.8);
    
    // Set up indicator
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    [indicator startAnimating];
    [indicator setCenter:articleCellImageView.center];
    [view addSubview:indicator];
    
    // Set title label constraints
    [articleCellTitleLabel.topAnchor constraintEqualToAnchor:articleCellImageView.bottomAnchor constant:0].active = true;
    [articleCellTitleLabel.bottomAnchor constraintEqualToAnchor:view.bottomAnchor constant:0].active = true;
    [articleCellTitleLabel.centerXAnchor constraintEqualToAnchor:view.centerXAnchor].active = true;
    [articleCellTitleLabel.widthAnchor constraintEqualToAnchor:view.widthAnchor multiplier:0.95].active = true;
}

@end
