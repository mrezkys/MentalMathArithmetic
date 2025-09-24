#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GameSessionProgressView : UIView

- (void)configureWithStatuses:(NSArray<NSNumber *> *)statuses currentIndex:(NSInteger)currentIndex;

@end

NS_ASSUME_NONNULL_END
