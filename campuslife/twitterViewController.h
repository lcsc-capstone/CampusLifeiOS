//
//  twitterViewController.h
//  LCSC
//
//  Created by Computer Science on 3/10/16.
//  Copyright © 2016 LCSC. All rights reserved.
//
//
#import "LCSC-swift.h"
#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
//#import <TwitterKit/TwitterKit.h>
@import TwitterKit;

@interface twitterViewController : TWTRTimelineViewController
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@end
