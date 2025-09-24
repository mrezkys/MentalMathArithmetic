#import "GameSessionProgressView.h"
#import "UIColor+Theme.h"
#import "GameQuestionState.h"

@interface GameSessionProgressView ()

@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) NSMutableArray<UIView *> *segmentViews;

@end

@implementation GameSessionProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.segmentViews = [NSMutableArray array];

    self.stackView = [[UIStackView alloc] init];
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    self.stackView.axis = UILayoutConstraintAxisHorizontal;
    self.stackView.spacing = 6.0f;
    self.stackView.alignment = UIStackViewAlignmentFill;
    self.stackView.distribution = UIStackViewDistributionFillEqually;
    [self addSubview:self.stackView];

    [NSLayoutConstraint activateConstraints:@[
        [self.stackView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [self.stackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
    ]];
}

- (void)configureWithStatuses:(NSArray<NSNumber *> *)statuses currentIndex:(NSInteger)currentIndex {
    if (statuses.count == 0) {
        [self clearSegments];
        return;
    }

    if (self.segmentViews.count != statuses.count) {
        [self rebuildSegmentsForCount:statuses.count];
    }

    for (NSUInteger index = 0; index < statuses.count; index++) {
        UIView *segment = self.segmentViews[index];
        GameQuestionAnswerStatus status = (GameQuestionAnswerStatus)statuses[index].unsignedIntegerValue;
        segment.backgroundColor = [self colorForStatus:status atIndex:index currentIndex:currentIndex];
    }
}

#pragma mark - Private helpers

- (void)clearSegments {
    for (UIView *view in self.segmentViews) {
        [view removeFromSuperview];
    }
    [self.segmentViews removeAllObjects];
}

- (void)rebuildSegmentsForCount:(NSUInteger)count {
    [self clearSegments];

    for (NSUInteger index = 0; index < count; index++) {
        UIView *segment = [[UIView alloc] init];
        segment.translatesAutoresizingMaskIntoConstraints = NO;
        segment.backgroundColor = [UIColor lightBlue];
        segment.layer.cornerRadius = 2.0f;
        segment.layer.masksToBounds = YES;

        [segment.heightAnchor constraintEqualToConstant:6.0f].active = YES;

        [self.stackView addArrangedSubview:segment];
        [self.segmentViews addObject:segment];
    }
}

- (UIColor *)colorForStatus:(GameQuestionAnswerStatus)status atIndex:(NSUInteger)index currentIndex:(NSInteger)currentIndex {
    switch (status) {
        case GameQuestionAnswerStatusCorrect:
            return [UIColor primaryGreen];
        case GameQuestionAnswerStatusIncorrect:
            return [UIColor primaryRed];
        case GameQuestionAnswerStatusPending:
        default:
            if ((NSInteger)index == currentIndex) {
                return [UIColor primaryBlue];
            }
            return [UIColor lightBlue];
    }
}

@end
