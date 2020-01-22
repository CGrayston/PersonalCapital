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
        [self setup];
        //[self updateView];
    }
    return self;
    
    
    //[self.contentView addSubview:cellTitleLabel];
//    [[self contentView] addSubview:cellTitleLabel];
}

-(void)setup {
    self.backgroundColor = [UIColor purpleColor];
        articleCellTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    articleCellImageView = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, 5, 5)];
    
    [self.contentView addSubview:articleCellImageView];
    [self.contentView addSubview:articleCellTitleLabel];
    
}

-(void)updateView {
    [articleCellTitleLabel setText:@"Hello"];
    [articleCellTitleLabel setTextColor:[UIColor blackColor]];
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

-(void)setUpCellWith:(NSString *)articleTitle cellImageURL:(NSString *)articleImageURL {
    [articleCellTitleLabel setText:articleTitle];
    [articleCellTitleLabel setTextColor:[UIColor blackColor]];
    //self.backgroundColor = [UIColor orangeColor];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
     ^{
        NSURL *imageURL = [NSURL URLWithString:articleImageURL];
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







@end
