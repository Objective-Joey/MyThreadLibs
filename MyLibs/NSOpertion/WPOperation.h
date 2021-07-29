//
//  WPOperation.h
//  MyLibs
//
//  Created by Joey on 2021/7/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WPOperation : NSOperation


@property(nonatomic,assign) BOOL hasNewData;

-(void)setForceEnd;
@end

NS_ASSUME_NONNULL_END
