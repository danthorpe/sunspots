//
//  DNTSunSpotViewController.m
//  Sun Spot Analyser
//
//  Created by Daniel Thorpe on 05/02/2013.
//  Copyright (c) 2013 Daniel Thorpe. All rights reserved.
//

#import "DNTSunSpotViewController.h"
#import "DNTSunSpotAnalyser.h"
#import "DNTSunSpot.h"

static NSString * const CellIdentifier = @"CellIdentifier";

@interface DNTSunSpotViewController (/* Private */)

@end

@implementation DNTSunSpotViewController

- (id)init {

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(60.f, 60.f);
    layout.minimumInteritemSpacing = 0.f;
    layout.minimumLineSpacing = 0.f;
    
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.analyser = [[DNTSunSpotAnalyser alloc] initWithInputData:TestDataOne()];
        [self.analyser analyse];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.analyser.size.height;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.analyser.size.width;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    // Get the sun spot at this index

    NSUInteger i = (indexPath.section * self.analyser.size.width) + indexPath.item;
    DNTSunSpot *sunspot = [self.analyser.spots objectAtIndex:i];

    // Set the background color
    cell.backgroundColor = [sunspot representativeColor];
    return cell;
}

@end
