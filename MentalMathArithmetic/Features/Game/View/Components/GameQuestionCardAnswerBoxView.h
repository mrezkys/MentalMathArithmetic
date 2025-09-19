#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GameQuestionCardAnswerBoxView : UIView

@property (nullable, nonatomic, copy) void (^tapHandler)(void);
@property (nonatomic, readonly, getter=isExpanded) BOOL expanded;

- (void)setExpanded:(BOOL)expanded animated:(BOOL)animated;
- (void)setQuestionText:(NSString *)text;
- (void)setAnswerText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
