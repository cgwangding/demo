//
//  NSString+AES.h
//  MyCategoriesCollection
//
//  Created by AD-iOS on 16/3/9.
//  Copyright © 2016年 DW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AES)

- (NSString *)AES128EncryptWithKey:(NSString*)key andIvector:(NSString*)iv;
- (NSString *)AES128DecryptWithKey:(NSString*)key andIvector:(NSString*)iv;


- (NSString *)AES256EncryptWithKey:(NSString *)key withECBMode:(BOOL)ecbMode;
- (NSString*)AES256DecryptWithKey:(NSString *)key withECBMode:(BOOL)ecbMode;

@end


@interface NSData (AES)

- (NSData *)aes256_decrypt:(NSString *)key  withECBMode:(BOOL)ecbMode;
- (NSData *)aes256_encrypt:(NSString *)key  withECBMode:(BOOL)ecbMode;

@end