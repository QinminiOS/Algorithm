//
//  main.m
//  Demo
//
//  Created by Qinmin on 17/1/20.
//  Copyright © 2017年 Qinmin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject
@property (nonatomic, weak) NSArray *pArr;
@property (nonatomic, assign) NSInteger index;
- (instancetype)initWithArray:(NSArray *)arr Index:(NSInteger)index;
@end

@implementation Node
- (instancetype)initWithArray:(NSArray *)arr Index:(NSInteger)index
{
    if (self = [super init]) {
        _pArr = arr;
        _index = index;
    }
    return self;
}
@end


static NSMutableArray<Node *> *arrLink = nil;
NSNumber* next(NSArray *arr)
{
    if (arrLink == nil) {
        arrLink = [NSMutableArray array];
        [arrLink addObject:[[Node alloc] initWithArray:arr Index:-1]];
    }
    
    Node *node = nil;
    while (arrLink.count > 0) {
        node = [arrLink lastObject];
        node.index = node.index + 1;
        
        //NSLog(@"%ld = %ld", [[node pArr] count], node.index);
        
        if (node.index >= [[node pArr] count]) {
            [arrLink removeLastObject];
        }else if ([[[node pArr] objectAtIndex:node.index] isKindOfClass:[NSArray class]]) {
            [arrLink addObject:[[Node alloc] initWithArray:[[node pArr] objectAtIndex:node.index] Index:-1]];
        }else {
            return [[node pArr] objectAtIndex:node.index];
        }
    }
    return nil;
}

static NSMutableArray<NSNumber *> *indexLink = nil;
NSNumber* next2(NSArray *arr)
{
    if (indexLink == nil) {
        indexLink = [NSMutableArray array];
        [indexLink addObject:@(-1)];
    }
    
    while (indexLink.count > 0) {
        // 下标加1
        NSInteger last = [[indexLink lastObject] intValue];
        [indexLink removeLastObject];
        [indexLink addObject:@(last+1)];
        
        // 当前位置数组
        NSArray *tmpArr = arr;
        for (int i = 0; i < indexLink.count-1; i++) {
             tmpArr = [tmpArr objectAtIndex:[indexLink[i] intValue]];
        }
        
        if (tmpArr && (last+1 >= tmpArr.count)) {
            [indexLink removeLastObject];
        }else {
            id current = arr;
            for (int i = 0; i < indexLink.count; i++) {
                current = [current objectAtIndex:[indexLink[i] intValue]];
            }
            
            if ([current isKindOfClass:[NSArray class]]) {
                [indexLink addObject:@(-1)];
            }else {
                return current;
            }
        }
    }
    return nil;
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // [[1,2,3],4,5,[6,[7,8,[9,10,[[[[[11]]]]]]]],12,[13]];
        NSArray *arr = @[@[@1,@[@2],@3],@4,@5,@[@6,@[@7,@8,@[@9,@10,@[@[@[@[@[@11]]]]]]]],@12,@[@13]];
        
        NSNumber *number;
        while ((number = next2(arr))) {
            NSLog(@"%i", [number intValue]);
        }
        
    }
    return 0;
}
