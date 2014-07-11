//
//  EXPLineDetailHtppModel.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-11.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPLineDetailHtppModel.h"
#import "EXPApplicationContext.h"

@implementation EXPLineDetailHtppModel

-(BOOL)autoLoaded{
    return false;
    
}

- (void)load:(NSDictionary *)param{
    
    NSData *data  = [param valueForKey:@"img_data"];
    
    
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    
//    NSURL *URL = [NSURL URLWithString:@"http://10.211.130.139:8397/mobile_app/atm_upload.svc"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    
//    NSURL *filePath = [NSURL fileURLWithPath:TTPathForDocumentsResource(@"currentImage.png")];
//    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//        if (error) {
//            NSLog(@"Error: %@", error);
//        } else {
//            NSLog(@"Success: %@ %@", response, responseObject);
//        }
//    }];
//    [uploadTask resume];
    
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://10.211.130.139:8397/mobile_app/atm_upload.svc" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:TTPathForDocumentsResource(@"currentImage.png")] name:@"file" fileName:@"filename.jpg" mimeType:@"image/jpeg" error:nil];
    } error:nil];
    [request setValue:@"897118" forHTTPHeaderField:@"Content-Length"];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSProgress *progress = nil;
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
        }
    }];
    
    [uploadTask resume];
    
    
    
    
    
    
    
    
    
//  AFHTTPRequestSerializer * ser =   [AFHTTPRequestSerializer serializer];
//    [ser setValue:[NSString stringWithFormat:@"%d",data.length]  forHTTPHeaderField:@"Content-Length"];
//    NSMutableURLRequest *request = [ser multipartFormRequestWithMethod:@"POST" URLString:@"http://10.211.130.139:8397/mobile_app/atm_upload.svc" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileData:data
//                                   name:@"file"
//                                fileName:@"filename.jpg"
//                                mimeType:@"image/jpeg" ];
//        
//
//    } error:nil];
//    
//
//    
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    NSProgress *progress = nil;
//    
//    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//        if (error) {
//            NSLog(@"Error: %@", error);
//        } else {
//            NSLog(@"%@ %@", response, responseObject);
//        }
//   }];
//    
//    [uploadTask resume];
    
//    [self request:@"GET" param:param url:[[EXPApplicationContext shareObject] keyforUrl:@"mobile_exp_report_line_insert" ]];
    
    
    
}

@end
