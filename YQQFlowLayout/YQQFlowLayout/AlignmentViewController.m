//
//  AlignmentViewController.m
//  YQQFlowLayout
//
//  Created by zhuyi on 2020/11/13.
//

#import "AlignmentViewController.h"
#import "YQQCollectionViewAlignmentFlowLayout.h"

@interface AlignmentViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) YQQCollectionViewAlignmentFlowLayout *layout;

@end

@implementation AlignmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.view.frame.size.width, 40);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(self.view.frame.size.width, 20);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
    if ([kind isEqualToString:@"UICollectionElementKindSectionHeader"]) {
        view.backgroundColor = [UIColor redColor];
    } else {
        view.backgroundColor = [UIColor purpleColor];
    }
    return view;
}

- (IBAction)resetLayout:(UIButton *)sender {
    if (sender.tag == 0) {
        _layout.alignment = YQQCollectionViewFlowLayoutAlignmentNormal;
    } else if (sender.tag == 1) {
        _layout.alignment = YQQCollectionViewFlowLayoutAlignmentLeft;
    } else if (sender.tag == 2) {
        _layout.alignment = YQQCollectionViewFlowLayoutAlignmentCenter;
    } else {
        _layout.alignment = YQQCollectionViewFlowLayoutAlignmentRight;
    }
    [_collectionView.collectionViewLayout invalidateLayout];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _layout = [[YQQCollectionViewAlignmentFlowLayout alloc] init];
        _layout.minimumLineSpacing = 15;
        _layout.minimumInteritemSpacing = 25;
        _layout.itemSize = CGSizeMake(60, 30);
        _layout.sectionInset = UIEdgeInsetsMake(20, 10, 20, 10);
        _layout.alignment = YQQCollectionViewFlowLayoutAlignmentRight;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:_layout];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:@"UICollectionElementKindSectionFooter" withReuseIdentifier:@"UICollectionReusableView"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:@"UICollectionElementKindSectionHeader" withReuseIdentifier:@"UICollectionReusableView"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

@end
