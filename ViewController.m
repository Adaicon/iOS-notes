//
//  ViewController.m
//  test
//
//  Created by Jieqiong on 2021/2/19.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "EDGPerson.h"
#import <malloc/malloc.h>

@interface ViewController ()

@property (nonatomic) NSString *string;
@property (strong,nonatomic) UIView *testView;
@property (strong,nonatomic) EDGPerson *person;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.testView = [UIView new];
    [self.view addSubview:self.testView];
    self.testView.frame = CGRectMake(200, 0, 100, 200);
    self.testView.backgroundColor = UIColor.greenColor;
    self.string = @"";

    
    [self changeValue];
    [self memoryTest];
    [self memoryTest2];
    
    // 此条是为了验证condition 是否生效
    self.view.layer.borderWidth = 10;
    [self symbolicBreakPoint];
    
    if ([self isRightAnswer]) {
        NSLog(@"djq---right");
    } else {
        NSLog(@"djq---wrong");
    }
    
    [self watchPoint];
    
    [self changeColor];
    [self findAction];
}

- (void)changeValue {
    // 修改和打印变量值
    NSUInteger count = 10;
    NSString *objects =  @"balloons";
    NSLog(@"djq---%lu  %@.",count,objects);
}

- (void)changeColor {
    UIButton *button = [UIButton new];
    [self.view addSubview:button];
    button.frame = CGRectMake(200, 400, 100, 60);
    button.backgroundColor = UIColor.blueColor;
    NSLog(@"djq---changeColor");
    
}

- (void)memoryTest {
    // temp、array、multableArray 首地址一样么？
    NSArray *temp = @[@"a",@"a",@"c",@"d",@"e"];
    NSArray *array = temp.copy;
    NSMutableArray *multableArray = temp.mutableCopy;
    NSLog(@"array count = %lu,multableArray count = %lu",(unsigned long)array.count,(unsigned long)multableArray.count);
    
    // 二进制输出到文件 /Users/bytedance/test.txt
    // memory read 0x10d7a8190 0x10d7a81a0 -outfile /Users/bytedance/test.txt
}

- (void)memoryTest2 {
    self.person = [EDGPerson new];
    self.person.age = 18;
    self.person.name = @"LiJie";
    self.person.nickName = @"jiejie";
    self.person.firstCharacter = NO;
    self.person.height = 60;
    self.person.role = YES;
    NSLog(@"p对象类型占用的内存大小：%lu",sizeof(self.person));
    NSLog(@"p对象实际占用的内存大小：%lu",class_getInstanceSize([self.person class]));
    NSLog(@"p对象实际分配的内存大小：%lu",malloc_size((__bridge const void*)(self.person)));
}

// thread return NO
- (BOOL)isRightAnswer {
    return YES;
}

- (void)crash {
    NSArray *array = @[@"a",@"b",@"c"];
    NSString *str = [NSString stringWithFormat:@"%@",array[3]];
    NSLog(@"djq---%@",str);
    
}

- (void)loop {
    while (1) {
        NSString *str = @"123";
    }
}

- (void)threads {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self task];
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self task];
    });

}

- (void)task {
    for (int i = 0; i < 10; i++) {
        NSLog(@"----%d",i);
    }
}

- (void)watchPoint {
    self.string = @"real";
}


- (void)findAction {
    UIButton *button  = [UIButton new];
    button.frame = CGRectMake(0, 600, 100, 100);
    button.backgroundColor = UIColor.yellowColor;
    [self.view addSubview:button];
    [button addTarget:self action:@selector(action) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)action {
    NSLog(@"黄色按钮被点击了");
}

- (void)symbolicBreakPoint {
}

+ (void)load {
    Class class = [self class];
    SEL originalSEL = @selector(symbolicBreakPoint);
    SEL swizzledSEL = @selector(swizzled_symbolicBreakPoint);
    
    Method originalMethod = class_getInstanceMethod(class, originalSEL);
    Method swizzleMethod = class_getInstanceMethod(class, swizzledSEL);
    
    BOOL didAddMethod = class_addMethod(class, originalSEL, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzleMethod);
    }
}

- (void)swizzled_symbolicBreakPoint {
    self.testView.layer.borderColor = UIColor.blackColor.CGColor;
    self.testView.layer.borderWidth = 10;
}


@end
