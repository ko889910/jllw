//
//  NSString+Path.h
//  02-沙盒目录
//
//  Created by apple on 15/6/2.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Path)

///  追加文档目录
- (NSString *)appendDocumentPath;
///  追加缓存目录
- (NSString *)appendCachePath;
///  追加临时目录
- (NSString *)appendTempPath;

@end
