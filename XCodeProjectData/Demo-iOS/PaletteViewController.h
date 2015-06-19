//
//  PaletteViewController.h
//  Demo-iOS
//
//  Created by Douglas Voss on 6/19/15.
//  Copyright (c) 2015 na. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PaletteViewControllerDelegate;

@interface PaletteViewController : UIViewController

@property (nonatomic, unsafe_unretained) id<PaletteViewControllerDelegate> delegate;

@end

@protocol PaletteViewControllerDelegate <NSObject>

@required
-(void)updatePaintColor:(UIColor *)color;

@end
