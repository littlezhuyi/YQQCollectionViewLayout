//
//  YQQCollectionViewAlignmentFlowLayout.m
//  YQQFlowLayout
//
//  Created by zhuyi on 2020/11/13.
//

#import "YQQCollectionViewAlignmentFlowLayout.h"

@interface YQQCollectionViewAlignmentFlowLayout ()

@property (nonatomic, assign) CGFloat sameLineItemTotalWidth;

@end

@implementation YQQCollectionViewAlignmentFlowLayout

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *layoutAttributes = [super layoutAttributesForElementsInRect:rect];
    if (self.alignment == YQQCollectionViewFlowLayoutAlignmentNormal) return layoutAttributes;
    NSMutableArray *tempLayoutAttributes = [NSMutableArray array];
    for (NSInteger i = 0; i < layoutAttributes.count; i++) {
        UICollectionViewLayoutAttributes *previousAttributes = i == 0 ? nil : layoutAttributes[i-1];
        UICollectionViewLayoutAttributes *currentAttributes = layoutAttributes[i];
        UICollectionViewLayoutAttributes *nextAttributes = i + 1 == layoutAttributes.count ? nil : layoutAttributes[i+1];
        
        [tempLayoutAttributes addObject:currentAttributes];
        _sameLineItemTotalWidth += currentAttributes.frame.size.width;
        
        if (CGRectGetMaxY(previousAttributes.frame) != CGRectGetMaxY(currentAttributes.frame) && CGRectGetMaxY(nextAttributes.frame) != CGRectGetMaxY(currentAttributes.frame)) {
            if ([currentAttributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader] || [currentAttributes.representedElementKind isEqualToString:UICollectionElementKindSectionFooter]) {
                [tempLayoutAttributes removeAllObjects];
                _sameLineItemTotalWidth = 0;
            } else {
                [self resetLayoutAttributes:tempLayoutAttributes];
                [tempLayoutAttributes removeAllObjects];
                _sameLineItemTotalWidth = 0;
            }
        } else if (CGRectGetMaxY(currentAttributes.frame) != CGRectGetMaxY(nextAttributes.frame)) {
            [self resetLayoutAttributes:tempLayoutAttributes];
            [tempLayoutAttributes removeAllObjects];
            _sameLineItemTotalWidth = 0;
        }
    }
    return layoutAttributes;
}

- (void)resetLayoutAttributes:(NSArray *)layoutAttributes {
    if (self.alignment == YQQCollectionViewFlowLayoutAlignmentLeft) {
        CGFloat startX = self.sectionInset.left;
        for (UICollectionViewLayoutAttributes *attributes in layoutAttributes) {
            CGRect tempRect = attributes.frame;
            tempRect.origin.x = startX;
            attributes.frame = tempRect;
            startX = startX + tempRect.size.width + self.minimumInteritemSpacing;
        }
    } else if (self.alignment == YQQCollectionViewFlowLayoutAlignmentCenter) {
        CGFloat startX = (self.collectionView.frame.size.width - _sameLineItemTotalWidth - self.minimumInteritemSpacing * (layoutAttributes.count - 1)) / 2.0;
        for (UICollectionViewLayoutAttributes *attributes in layoutAttributes) {
            CGRect tempRect = attributes.frame;
            tempRect.origin.x = startX;
            attributes.frame = tempRect;
            startX = startX + tempRect.size.width + self.minimumInteritemSpacing;
        }
    } else if (self.alignment == YQQCollectionViewFlowLayoutAlignmentRight) {
        CGFloat startX = self.collectionView.frame.size.width - _sameLineItemTotalWidth - self.minimumInteritemSpacing * (layoutAttributes.count - 1) - self.sectionInset.right;
        for (UICollectionViewLayoutAttributes *attributes in layoutAttributes) {
            CGRect tempRect = attributes.frame;
            tempRect.origin.x = startX;
            attributes.frame = tempRect;
            startX = startX + tempRect.size.width + self.minimumInteritemSpacing;
        }
    }
}

@end
