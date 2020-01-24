//
//  HeaderArticleCollectionReusableView.m
//  PersonalCapitalBlog
//
//  Created by Chris Grayston on 1/21/20.
//  Copyright © 2020 Chris Grayston. All rights reserved.
//

#import "HeaderArticleCollectionReusableView.h"

/*
 * Custom view to reperesnt the first article parsed from Personal Capital's RSS Feed.
 * View is dispalyed in the header portion of the collection view.
 */
@implementation HeaderArticleCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Set Up content view
        contentView = [[UIView alloc] initWithFrame:frame];
        contentView.layer.borderWidth = 1.0f;
        contentView.layer.borderColor = [UIColor grayColor].CGColor;
        [self addSubview:contentView];
        
        // Set Up article image view
        articleImageView = [[UIImageView alloc] init];
        articleImageView.translatesAutoresizingMaskIntoConstraints = NO;
        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
        
        [contentView addSubview:articleImageView];
        
        // Set Up articleTitleLabel
        articleTitleLabel = [[UILabel alloc] init];
        articleTitleLabel.textColor = [UIColor darkTextColor];
        
        [contentView addSubview:articleTitleLabel];
        
        
        // Set Up articleDescriptionLabel
        articleDescriptionLabel = [[UILabel alloc] init];
        articleDescriptionLabel.textColor = [UIColor darkTextColor];
        [articleDescriptionLabel setNumberOfLines:2];
        [articleDescriptionLabel setFont:[UIFont systemFontOfSize:14]];
        
        [contentView addSubview:articleDescriptionLabel];
        
        // Stack View
        UIStackView *stackView = [[UIStackView alloc] init];
        
        stackView.axis = UILayoutConstraintAxisVertical;
        stackView.distribution = UIStackViewDistributionFillProportionally;
        stackView.alignment = UIStackViewAlignmentFill;
        stackView.spacing = 0;
        
        [stackView addArrangedSubview:articleTitleLabel];
        [stackView addArrangedSubview:articleDescriptionLabel];
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        
        [contentView addSubview:stackView];
        
        // Constraint stackView
        [stackView.topAnchor constraintEqualToAnchor:articleImageView.bottomAnchor constant:4].active = true;
        [stackView.bottomAnchor constraintEqualToAnchor:contentView.bottomAnchor constant:-4].active = true;
        [stackView.centerXAnchor constraintEqualToAnchor:contentView.centerXAnchor].active = true;
        [stackView.widthAnchor constraintEqualToAnchor:contentView.widthAnchor multiplier:0.9].active = true;
        
    }
    return self;
}

- (void)layoutSubviews {
    // Constrain imageView
    [articleImageView.heightAnchor constraintEqualToAnchor:contentView.heightAnchor multiplier:0.7].active = true;
    [articleImageView.widthAnchor constraintEqualToAnchor:articleImageView.heightAnchor multiplier:2.0].active = true;
    [articleImageView.centerXAnchor constraintEqualToAnchor:contentView.centerXAnchor].active = true;
    [articleImageView.topAnchor constraintEqualToAnchor:contentView.topAnchor].active = true;
    
    // Start animating indicator
    [indicator startAnimating];
    [indicator setCenter:articleImageView.center];
    
    
}

/*
 * Setter for the article object
 *
 * @param article A article to populate the cell
 */
- (void)setArticle:(Article *)article {
    // If cell was set to nil, return
    if (article == nil) return;
    
    // Set cellArticle
    _article = article;
    
    // Set the image and title
    [self updateViews];
}

/*
 * Sets the image and title for the view using the
 * cell's set article object.
 */
-(void)updateViews {
    // Submits a block for priority asynchronous execution
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Initilize image url and  data
        NSURL *imageURL = [NSURL URLWithString:self.article.mediaContent];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        
        //This is your completion handler
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            // Set image view and label texts, remove indicator
            self->articleImageView.image = [UIImage imageWithData:imageData];
            self->articleTitleLabel.text = self.article.title;
            self->articleDescriptionLabel.text = self.article.articleDescription;
            [self->indicator removeFromSuperview];
            
            // Set to put on main thread
            self->articleImageView.image = self->articleImageView.image;
            
        });
    });
}

@end
