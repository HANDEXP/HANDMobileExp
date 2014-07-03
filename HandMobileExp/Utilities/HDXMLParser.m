//
//  HDXMLParser.m
//  HDMobileBusiness
//
//  Created by MHJ on 8/23/12.
//  Copyright (c) 2012 hand. All rights reserved.
//
#import "HDXMLParser.h"
@interface HDXMLParser(){
    //xmlPath
    NSString *xmlPath;
    //当前bean的ID
    NSString *beanId;
    //当前Bean的Refbeans
    NSMutableDictionary *propertyRefbeans;
    //当前Bean的Values
    NSMutableDictionary *propertyValues;
    //当前的property
    NSString *currentProperty;
    //当前的数组
    NSMutableArray *currentArray;
    //当前的map
    NSMutableDictionary *currentDict;
    //是否继续解析
    BOOL isContinue;
}
@end
@implementation HDXMLParser
@synthesize patternes = _patternes;
@synthesize parseError = _parseError;

-(id)initWithXmlPath:(NSString *)xmlpath{
    self = [super init];
    if (self) {
        _patternes = [[NSMutableDictionary alloc]init];
        xmlPath = xmlpath;
    }
    return self;
}


-(BOOL)parse{
//    NSData * data = [NSData dataWithContentsOfFile:@"Users/Leo/Projects/xcode/Hand/HDMobileBusiness/HDMobileBusiness/Documents/ConfigFiles/backend-config-mocha.xml"];
    NSData * data = [NSData dataWithContentsOfFile:TTPathForDocumentsResource(xmlPath)];
    NSXMLParser *parser = [[NSXMLParser alloc]initWithData:data]; //设置XML数据
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
    [parser setDelegate:self];
    [parser parse];
    if(![self parseError]){
        return YES;
    }else{
        return NO;
    }
}

#pragma mark - NSXMLParserDelegate
//发现元素开始符的处理函数  （即报告元素的开始以及元素的属性）
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    //解析到BEAN标签则初始化数据
    if ([[elementName uppercaseString] isEqualToString:@"URL"] ) {
        [_patternes setObject:[attributeDict objectForKey:@"value"] forKey:[attributeDict objectForKey:@"name"]];

    }
}
//处理标签包含内容字符 （报告元素的所有或部分内容）
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
}
//发现元素结束符的处理函数，保存元素各项目数据（即报告元素的结束标记）
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    //解析完bean

    
}
//报告解析的结束
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"paraseDidEnd");
}
//报告不可恢复的解析错误
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"paraseFaild");
    [self setParseError:parseError];
    [self setPatternes:nil];
}
@end

