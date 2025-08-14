//
//  GameViewModel.h
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 14/08/25.
//

#ifndef GameViewModel_h
#define GameViewModel_h

#import <Foundation/Foundation.h>

@class GameViewModel;

@protocol GameViewModelDelegate <NSObject>

- (void)viewModelDidUpdate:(GameViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_BEGIN

@interface GameViewModel : NSObject

@property (nonatomic, weak) id<GameViewModelDelegate> delegate;
@property (nonatomic, readonly) NSInteger repetitionCount;
@property (nonatomic, readonly) NSInteger totalRepetitions;
@property (nonatomic, readonly) NSInteger spelledNumberCount;
@property (nonatomic, readonly) NSInteger totalNumberCount;

- (void)start;

@end

NS_ASSUME_NONNULL_END


#endif /* GameViewModel_h */
