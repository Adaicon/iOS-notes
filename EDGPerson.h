//
//  EDGPerson.h
//  test
//
//  Created by Jieqiong on 2021/11/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EDGPerson : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, assign) int age;
@property (nonatomic, assign) long height;

@property (nonatomic) BOOL role;
@property (nonatomic) BOOL firstCharacter;

@end

NS_ASSUME_NONNULL_END
