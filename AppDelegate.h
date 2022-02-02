//
//  AppDelegate.h
//  test
//
//  Created by Jieqiong on 2021/2/19.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (nonatomic, strong) UIWindow *window;

- (void)saveContext;


@end

