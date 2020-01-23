//
//  ArticleCollectionViewCell.m
//  PersonalCapitalBlog
//
//  Created by Chris Grayston on 1/19/20.
//  Copyright © 2020 Chris Grayston. All rights reserved.
//

#import "ArticleCollectionViewCell.h"

@implementation ArticleCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //[self setup];
        //[self updateView];
        //self.cellArticle =
        view = self.contentView;
        view.backgroundColor = [UIColor redColor];
        //view.translatesAutoresizingMaskIntoConstraints = false;
        
        articleCellImageView = [[UIImageView alloc] init];
        //articleCellImageView.translatesAutoresizingMaskIntoConstraints = false;
        [view addSubview:articleCellImageView];
        
        //[[[articleCellImageView centerXAnchor ] constraintEqualToAnchor:view.centerXAnchor] isActive ] = true;
        //[[[articleCellImageView centerXAnchor] constraintEqualToAnchor: [view centerXAnchor]] setActive:true];
        
    }
    return self;
    
    
    //[self.contentView addSubview:cellTitleLabel];
//    [[self contentView] addSubview:cellTitleLabel];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    

}

-(void)setup {
//    self.backgroundColor = [UIColor purpleColor];
//    articleCellTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
//    articleCellImageView = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, 5, 5)];
//
//    [self.contentView addSubview:articleCellImageView];
//    [self.contentView addSubview:articleCellTitleLabel];
    UIView *view = self.contentView;
    view.backgroundColor = [UIColor redColor];
    
    // Set Up articleImageView
    articleCellImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height * 0.8)];
    //articleCellImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)];
    [view addSubview:articleCellImageView];
    //articleCellImageView.contentMode = UIViewContentModeScaleAspectFit;
    //articleCellImageView.translatesAutoresizingMaskIntoConstraints = false;
    
    
    
    
    // Constraints for articleImageView
    NSLayoutConstraint *imageViewTopConstraint = [NSLayoutConstraint
                                                  constraintWithItem:articleCellImageView
                                                  attribute:NSLayoutAttributeTopMargin
                                                  relatedBy:NSLayoutRelationEqual
                                                  toItem:view
                                                  attribute:NSLayoutAttributeTopMargin
                                                  multiplier:1.0
                                                  constant:0];
    
//    NSLayoutConstraint *imageViewLeadingConstraint = [NSLayoutConstraint
//                                                  constraintWithItem:articleCellImageView
//                                                  attribute:NSLayoutAttributeLeading
//                                                  relatedBy:NSLayoutRelationEqual
//                                                  toItem:view
//                                                  attribute:NSLayoutAttributeLeading
//                                                  multiplier:1.0
//                                                  constant:0];
    
    NSLayoutConstraint *imageViewCenterXConstraint = [NSLayoutConstraint
                                                  constraintWithItem:articleCellImageView
                                                  attribute:NSLayoutAttributeCenterX
                                                  relatedBy:NSLayoutRelationEqual
                                                  toItem:view
                                                  attribute:NSLayoutAttributeCenterX
                                                  multiplier:1.0
                                                  constant:0];
    
    NSLayoutConstraint *imageViewCenterYConstraint = [NSLayoutConstraint
                                                  constraintWithItem:articleCellImageView
                                                  attribute:NSLayoutAttributeCenterY
                                                  relatedBy:NSLayoutRelationEqual
                                                  toItem:view
                                                  attribute:NSLayoutAttributeCenterY
                                                  multiplier:1.0
                                                  constant:0];
    
    NSLayoutConstraint *imageViewWidthConstraint = [NSLayoutConstraint
                                                    constraintWithItem:articleCellImageView
                                                    attribute:NSLayoutAttributeWidth
                                                    relatedBy:NSLayoutRelationEqual
                                                    toItem:view
                                                    attribute:NSLayoutAttributeWidth
                                                    multiplier:0.6
                                                    constant:0];
    
    NSLayoutConstraint *imageViewAspectRatioConstraint = [NSLayoutConstraint
                                                    constraintWithItem:articleCellImageView
                                                    attribute:NSLayoutAttributeWidth
                                                    relatedBy:NSLayoutRelationEqual
                                                    toItem:articleCellImageView
                                                    attribute:NSLayoutAttributeHeight
                                                    multiplier:2.0
                                                    constant:0];
    
    //[view addConstraints:@[imageViewTopConstraint,imageViewWidthConstraint, imageViewCenterXConstraint, ]];
    //[NSLayoutConstraint activateConstraints:@[imageViewTopConstraint]];
    
    //[articleCellImageView addConstraint:imageViewAspectRatioConstraint];
    
    
    
    
    
    articleCellTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    
    [view addSubview:articleCellTitleLabel];
    
}



-(void)updateView {
    //[articleCellTitleLabel setText:@"Hello"];
    //[articleCellTitleLabel setTextColor:[UIColor blackColor]];
    //self.backgroundColor = [UIColor orangeColor];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
     ^{
        NSURL *imageURL = [NSURL URLWithString:@"https://www.personalcapital.com/blog/wp-content/uploads/2019/05/401k-rollover-2.jpg"];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];

        //This is your completion handler
        dispatch_sync(dispatch_get_main_queue(), ^{
             //If self.image is atomic (not declared with nonatomic)
             // you could have set it directly above
            self->articleCellImageView.image = [UIImage imageWithData:imageData];

             //This needs to be set here now that the image is downloaded
             // and you are back on the main thread
            self->articleCellImageView.image = articleCellImageView.image;

         });
     });
}

-(void)setUpCellWithArticle:(Article *)article {
    //[articleCellTitleLabel setText:articleTitle];
    //[articleCellTitleLabel setTextColor:[UIColor blackColor]];
    //self.backgroundColor = [UIColor orangeColor];
    self.cellArticle = article;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
     ^{
        NSURL *imageURL = [NSURL URLWithString:article.mediaContent];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];

        //This is your completion handler
        dispatch_sync(dispatch_get_main_queue(), ^{
             //If self.image is atomic (not declared with nonatomic)
             // you could have set it directly above
            self->articleCellImageView.image = [UIImage imageWithData:imageData];
            [indicator removeFromSuperview];
             //This needs to be set here now that the image is downloaded
             // and you are back on the main thread
            self->articleCellImageView.image = articleCellImageView.image;

         });
     });
}

- (void)layoutSubviews {
    
    
    // Set Up articleImageView
    //articleCellImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height * 0.8)];
    
    articleCellImageView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height * 0.8);
    
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    [indicator startAnimating];
    [indicator setCenter:articleCellImageView.center];
    [view addSubview:indicator];
    //articleCellImageView.contentMode = UIViewContentModeScaleAspectFit;
    //articleCellImageView.translatesAutoresizingMaskIntoConstraints = false;
    
}





@end
