//
//  NSData+EHAdd.h
//
//  Created by lixinxing on 16/7/25.
//  Copyright © 2016年 lixinxing All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSData (EnhanceKit)

#pragma mark - Hash
///=============================================================================
/// @name Hash
///==========
/**
 Returns a lowercase NSString for md5 hash.
 */
- (NSString *)md5String;

/**
 Returns an NSData for md5 hash.
 */
- (NSData *)md5Data;

/**
Returns a lowercase NSString for sha256 hash.
*/
- (NSString *)sha256String;

/**
 Returns a lowercase NSString for sha1 hash.
 */
- (NSString *)sha1String;

/**
 Returns an NSData for sha256 hash.
 */
- (NSData *)sha256Data;

#pragma mark - Encode and decode
///=============================================================================
/// @name Encode and decode
///=============================================================================

/**
 Returns string decoded in UTF8.
 */
- (nullable NSString *)utf8String;

/**
 Returns an NSString for base64 encoded.
 */
- (nullable NSString *)base64EncodedString;

/**
 Returns an NSData from base64 encoded string.
 
 @warning This method has been implemented in iOS7.
 
 @param base64EncodedString  The encoded string.
 */
+ (nullable NSData *)dataWithBase64EncodedString:(NSString *)base64EncodedString;

/**
 Returns an NSDictionary or NSArray for decoded self.
 Returns nil if an error occurs.
 */
- (nullable id)jsonValueDecoded;

#pragma mark - Encrypt and Decrypt
///=============================================================================
/// @name Encrypt and Decrypt
///=============================================================================

/**
 Returns an encrypted NSData using AES.
 
 @param key   A key length of 16, 24 or 32 (128, 192 or 256bits).
 
 @param iv    An initialization vector length of 16(128bits).
 Pass nil when you don't want to use iv.
 
 @return      An NSData encrypted, or nil if an error occurs.
 */
- (nullable NSData *)aesEncryptWithKey:(NSData *)key iv:(nullable NSData *)iv;

/**
 Returns an decrypted NSData using AES.
 
 @param key   A key length of 16, 24 or 32 (128, 192 or 256bits).
 
 @param iv    An initialization vector length of 16(128bits).
 Pass nil when you don't want to use iv.
 
 @return      An NSData decrypted, or nil if an error occurs.
 */
- (nullable NSData *)aesDecryptWithkey:(NSData *)key iv:(nullable NSData *)iv;

#pragma mark - gzip
///=============================================================================
/// @name Encrypt and Decrypt
///=============================================================================

/**
 使用gzip压缩数据

 @param level 压缩系数，-1表示最快压缩方法（低压缩比），-9最慢压缩方法（高压缩比）
 @return 压缩后的数据
 */
- (nullable NSData *)gzippedDataWithCompressionLevel:(float)level;


/**
 使用gzip压缩数据，压缩系数默认为-1

 @return 压缩后的数据
 */
- (nullable NSData *)gzippedData;

/**
 解压缩gzip数据

 @return 解压后的数据
 */
- (nullable NSData *)gunzippedData;

/**
 判断是否是gzip数据

 @return YES，表示为gzip压缩数据；NO,表示为非gzip缩数据
 */
- (BOOL)isGzippedData;

@end

NS_ASSUME_NONNULL_END
