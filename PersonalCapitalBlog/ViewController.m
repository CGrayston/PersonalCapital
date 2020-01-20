//
//  ViewController.m
//  PersonalCapitalBlog
//
//  Created by Chris Grayston on 1/17/20.
//  Copyright © 2020 Chris Grayston. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    articleParser = [[ArticleParser alloc] loadXMLByURL:@"https://www.personalcapital.com/blog/feed/"];
    
    for (Article *article in articleParser.articles) {
        NSLog(@"Title: %@", article.title);
        NSLog(@"Publication Date: %@", article.pubDate);
        NSLog(@"Media Content: %@", article.mediaContent);
        NSLog(@"Link: %@", article.link);
        NSLog(@"");
    }
    
}


@end
