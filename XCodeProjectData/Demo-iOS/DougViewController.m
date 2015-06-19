//
//  DougViewController.m
//  Demo-iOS
//
//  Created by Douglas Voss on 6/18/15.
//  Copyright (c) 2015 na. All rights reserved.
//

#import "DougViewController.h"
#import "SVGKFastImageView.h"
#import "SVGKLayeredImageView.h"
#import "SVGKFastImageView.h"
#import "SVGKLayeredImageView.h"
#import "PaletteViewController.h"


@interface DougViewController () <UIScrollViewDelegate, PaletteViewControllerDelegate>

@property (nonatomic, strong) SVGKLayeredImageView *svgImageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIColor *selColor;

@end

@implementation DougViewController

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.svgImageView;
}

- (void)tapMethod:(UITapGestureRecognizer *)sender
{
    CGPoint p = [sender locationInView:self.scrollView];
    NSLog(@"tap happen @x:%f y:%f", p.x, p.y);
    CALayer* layerForHitTesting;
    layerForHitTesting = self.svgImageView.layer;
    CALayer* hitLayer = [layerForHitTesting hitTest:p];
    
    if( [hitLayer isKindOfClass:[CAShapeLayer class]]){
        CAShapeLayer* shapeLayer = (CAShapeLayer*)hitLayer;
        shapeLayer.fillColor = self.selColor.CGColor;
    }
}

- (void)paletteSelMethod
{
    PaletteViewController *pvc = [PaletteViewController new];
    pvc.delegate = self;
    [self.navigationController pushViewController:pvc animated:NO];
}

- (void)updatePaintColor:(UIColor *)color
{
    self.selColor = color;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.selColor = [UIColor blueColor];

    //SVGKFastImageView *svgView = [[SVGKFastImageView alloc] initWithSVGKImage: [SVGKImage imageNamed:@"Monkey.svg"]];
    self.view.backgroundColor = [UIColor whiteColor];
    self.svgImageView = [[SVGKLayeredImageView alloc] initWithSVGKImage: [SVGKImage imageNamed:@"House.svg"]];
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.contentSize = self.svgImageView.frame.size;
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = 1.0;
    self.scrollView.maximumZoomScale = 10.0;
    [self.scrollView addSubview:self.svgImageView];
    [self.scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview: self.scrollView];
    
    NSDictionary *viewsDictionary = @{@"sv": self.scrollView};
    [self.view addConstraints:
     [NSLayoutConstraint
      constraintsWithVisualFormat:@"V:|[sv]|"
      options: NSLayoutFormatAlignAllBaseline
      metrics: nil
      views: viewsDictionary
     ]
     ];
    
    [self.view addConstraints:
     [NSLayoutConstraint
      constraintsWithVisualFormat:@"H:|[sv]|"
      options: NSLayoutFormatAlignAllBaseline
      metrics: nil
      views: viewsDictionary
     ]
     ];
    

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMethod:)];
    [self.view addGestureRecognizer:tapGesture];
    
    UIBarButtonItem *paletteSelButton = [[UIBarButtonItem alloc] initWithTitle:@"Colors" style:UIBarButtonItemStylePlain target:self action:@selector(paletteSelMethod)];
    self.navigationItem.rightBarButtonItem = paletteSelButton;

    /*
    int i = 0;
    CALayer* layer = svgImageView.layer;
    for (CALayer *subLayer in layer.sublayers) {
        NSLog(@"1: %@", [subLayer class]);
        
        for (CALayer *sub2Layer in subLayer.sublayers) {
            NSLog(@"2: %@", [sub2Layer class]);
            
            for (CALayer *sub3Layer in sub2Layer.sublayers) {
                NSLog(@"3: %@", [sub3Layer class]);
                if( [sub3Layer isKindOfClass:[CAShapeLayer class]]){
                    CAShapeLayer* shapeLayer = (CAShapeLayer*)sub3Layer;
                    if (i==0) {
                        shapeLayer.fillColor = [UIColor redColor].CGColor;
                    } else if (i==1) {
                        shapeLayer.fillColor = [UIColor orangeColor].CGColor;
                    } else if (i==2) {
                        shapeLayer.fillColor = [UIColor yellowColor].CGColor;
                    } else if (i==3) {
                        shapeLayer.fillColor = [UIColor greenColor].CGColor;
                    } else if (i==4) {
                        shapeLayer.fillColor = [UIColor blueColor].CGColor;
                    } else if (i==5) {
                        shapeLayer.fillColor = [UIColor purpleColor].CGColor;
                    }
                    i++;
                    if (i > 5) {
                        i = 0;
                    }
                }
                for (CALayer *sub4Layer in sub3Layer.sublayers) {
                    NSLog(@"4: %@", [sub4Layer class]);
                    if( [sub4Layer isKindOfClass:[CAShapeLayer class]])
                    {
                        CAShapeLayer* shapeLayer = (CAShapeLayer*)sub4Layer;
                        if (i==0) {
                            shapeLayer.fillColor = [UIColor redColor].CGColor;
                        } else if (i==1) {
                            shapeLayer.fillColor = [UIColor orangeColor].CGColor;
                        } else if (i==2) {
                            shapeLayer.fillColor = [UIColor yellowColor].CGColor;
                        } else if (i==3) {
                            shapeLayer.fillColor = [UIColor greenColor].CGColor;
                        } else if (i==4) {
                            shapeLayer.fillColor = [UIColor blueColor].CGColor;
                        } else if (i==5) {
                            shapeLayer.fillColor = [UIColor purpleColor].CGColor;
                        }
                        i++;
                        if (i > 5) {
                            i = 0;
                        }
                    }
                    
                    for (CALayer *sub5Layer in sub4Layer.sublayers) {
                        NSLog(@"5: %@", [sub5Layer class]);
                        if( [sub5Layer isKindOfClass:[CAShapeLayer class]]) {
                            CAShapeLayer* shapeLayer = (CAShapeLayer*)sub5Layer;
                            if (i==0) {
                                shapeLayer.fillColor = [UIColor redColor].CGColor;
                            } else if (i==1) {
                                shapeLayer.fillColor = [UIColor orangeColor].CGColor;
                            } else if (i==2) {
                                shapeLayer.fillColor = [UIColor yellowColor].CGColor;
                            } else if (i==3) {
                                shapeLayer.fillColor = [UIColor greenColor].CGColor;
                            } else if (i==4) {
                                shapeLayer.fillColor = [UIColor blueColor].CGColor;
                            } else if (i==5) {
                                shapeLayer.fillColor = [UIColor purpleColor].CGColor;
                            }
                            i++;
                            if (i > 5) {
                            i = 0;
                            }
                        }
                        for (CALayer *sub6Layer in sub5Layer.sublayers) {
                            NSLog(@"6: %@", [sub6Layer class]);
                            if( [sub6Layer isKindOfClass:[CAShapeLayer class]]) {
                                CAShapeLayer* shapeLayer = (CAShapeLayer*)sub6Layer;
                                if (i==0) {
                                    shapeLayer.fillColor = [UIColor redColor].CGColor;
                                } else if (i==1) {
                                    shapeLayer.fillColor = [UIColor orangeColor].CGColor;
                                } else if (i==2) {
                                    shapeLayer.fillColor = [UIColor yellowColor].CGColor;
                                } else if (i==3) {
                                    shapeLayer.fillColor = [UIColor greenColor].CGColor;
                                } else if (i==4) {
                                    shapeLayer.fillColor = [UIColor blueColor].CGColor;
                                } else if (i==5) {
                                    shapeLayer.fillColor = [UIColor purpleColor].CGColor;
                                }
                                i++;
                                if (i > 5) {
                                i = 0;
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }*/
    
    /*SVGKImage *svgImage = [SVGKImage imageNamed:@"Anchor.svg"];
     SVGKLayeredImageView *svgImageView = [[SVGKLayeredImageView alloc] initWithSVGKImage:svgImage];
     [capturedImageView addSubview:svgImageView];
     
     CALayer* layer = svgImageView.layer;
     for (CALayer *subLayer in layer.sublayers) {
     DLog(@"%@", [subLayer class]);
     
     for (CALayer *subSubLayer in subLayer.sublayers) {
     DLog(@"%@", [subSubLayer class]);
     
     for (CALayer *subSubSubLayer in subSubLayer.sublayers) {
     DLog(@"%@", [subSubSubLayer class]);
     
     if( [subSubSubLayer isKindOfClass:[CAShapeLayer class]]){
     CAShapeLayer* shapeLayer = (CAShapeLayer*)subSubSubLayer;
     shapeLayer.fillColor = [UIColor redColor].CGColor;
     }
     }
     }
     }*/
    
    /*NSString* tagToFind = @"g";
    NodeList* result = [svgView.image.DOMDocument getElementsByTagName:tagToFind];
    for( Element* domElement in result )
    {
        // You can use the Element object directly:
        //domElement.tagName;
        NSLog(@"tagname=%@", domElement.tagName);
        // ...or, if it was parsed by the SVG parser, you can convert it to an SVGElement:
        SVGElement* svgElement = (SVGElement*) domElement;
    }*/

/*    CALayer* layerUserClickedOn = ...

    if( [layerUserClickedOn isKindOfClass:[CAShapeLayer class]] ) // should ALWAYS be true, but just in case you write your code wrong...
    {
        CAShapeLayer* shapeLayer = (CAShapeLayer*) layerUserClickedOn;

        shapeLayer.fillColor = [UIColor redColor].CGColor;
    }*/

    /*
    SVGKImage* svgImage = ...

    SVGElement* element = ... // see previous SVGKit recipes

    CALayer* layer = [svgImage layerWithIdentifier:element.identifier];

    ... // do something with it...*/

    /*UIImage* newImage = [SVGKImage imageNamed:@"Monkey"].UIImage;
    UIImageView *imgView = [[UIImageView alloc] initWithImage:newImage];
    imgView.frame = self.view.frame;
    [self.view addSubview:imgView];*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
