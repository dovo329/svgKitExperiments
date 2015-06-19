//
//  PaletteViewController.m
//  Demo-iOS
//
//  Created by Douglas Voss on 6/19/15.
//  Copyright (c) 2015 na. All rights reserved.
//

#import "PaletteViewController.h"

#define kMinMargin 15.0
#define kReuseId @"palette.view.controller.collection.view.cell.reuse.id"
#define kNumColumns 5

@interface PaletteViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *colView;
@property (nonatomic, strong) NSArray *colorArr;

@end

@implementation PaletteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor greenColor];
    //[UIColor colorWithRed:100.0 green:131.0 blue:144.0 alpha:1.0];
    
    self.colorArr =
  @[
        [UIColor blackColor],
        [UIColor darkGrayColor],
        [UIColor lightGrayColor],
        [UIColor whiteColor],
        [UIColor grayColor],
        [UIColor redColor],
        [UIColor greenColor],
        [UIColor blueColor],
        [UIColor cyanColor],
        [UIColor yellowColor],
        [UIColor magentaColor],
        [UIColor orangeColor],
        [UIColor purpleColor],
        [UIColor brownColor]
    ];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(kMinMargin, kMinMargin, kMinMargin, kMinMargin);
    
    CGFloat width = (self.view.frame.size.width-(kMinMargin*(kNumColumns+1)))/kNumColumns;
    layout.itemSize = CGSizeMake(width, width);
    layout.minimumInteritemSpacing = kMinMargin;
    layout.minimumLineSpacing = kMinMargin;
    
    self.colView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    self.colView.dataSource = self;
    self.colView.delegate = self;
    [self.colView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kReuseId];
    
    self.colView.backgroundColor = [UIColor colorWithRed:0.3 green:0.4 blue:0.5 alpha:1.0];
    self.colView.scrollEnabled = true;
    
    [self.view addSubview:self.colView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return ceil(((float)[self.colorArr count])/((float)kNumColumns));
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return kNumColumns;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    int colorArrInd = ((indexPath.section*kNumColumns) + indexPath.row) % [self.colorArr count];
    [self.delegate updatePaintColor:self.colorArr[colorArrInd]];
    [self.navigationController popViewControllerAnimated:NO];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseId forIndexPath:indexPath];
    if (!cell) {
        cell = [[UICollectionViewCell alloc] init];
    }
    
    int colorArrInd = ((indexPath.section*kNumColumns) + indexPath.row) % [self.colorArr count];
    cell.backgroundColor = self.colorArr[colorArrInd];
    
    return cell;
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
