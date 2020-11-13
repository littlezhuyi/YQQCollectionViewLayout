//
//  YQQCollectionViewAlignmentFlowLayout.h
//  YQQFlowLayout
//
//  Created by zhuyi on 2020/11/13.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YQQCollectionViewFlowLayoutAlignment) {
    YQQCollectionViewFlowLayoutAlignmentNormal,
    YQQCollectionViewFlowLayoutAlignmentLeft,
    YQQCollectionViewFlowLayoutAlignmentCenter,
    YQQCollectionViewFlowLayoutAlignmentRight
};

NS_ASSUME_NONNULL_BEGIN

@interface YQQCollectionViewAlignmentFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) YQQCollectionViewFlowLayoutAlignment alignment;

@end

NS_ASSUME_NONNULL_END
