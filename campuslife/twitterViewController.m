//
//  twitterViewController.m
//  LCSC
//
//  Created by Computer Science on 3/10/16.
//  Copyright © 2016 LCSC. All rights reserved.
//

#import "twitterViewController.h"
#import <TwitterKit/TwitterKit.h>
#define IDIOM UI_USER_INTERFACE_IDIOM()
#define IPAD UIUserInterfaceIdiomPad

@implementation twitterViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    if( IDIOM == IPAD) {
  //      _imageView.image = [UIImage imageNamed:@"RCH_Resized"];
        self.imageView.contentMode = UIViewContentModeRedraw;
    }else {
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    // Do view setup here.
    TWTRAPIClient *client = [[TWTRAPIClient alloc] init];
    self.dataSource = [[TWTRUserTimelineDataSource alloc] initWithScreenName:@"LCSC" APIClient:client];
}



@end
