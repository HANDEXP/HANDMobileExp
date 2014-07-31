//
//  CompositeXmlParser.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-29.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "CompositeXmlParser.h"
#import "CompositeDictionary.h"
#import "EXPApplicationContext.h"

@implementation CompositeXmlParser{
    
    CompositeDictionary * currentNode;
    NSMutableArray * nodestack;
    
     NSString *xmlPath;
}


-(id)initWithXmlPath:(NSString *)xmlpath{
    self = [super init];
    if (self) {
         xmlPath = xmlpath;
        nodestack  = [[NSMutableArray alloc] init];
    }
    return self;
}
#pragma public
-(BOOL)parse{

    NSData * data = [NSData dataWithContentsOfFile:TTPathForDocumentsResource(xmlPath)];
    NSXMLParser *parser = [[NSXMLParser alloc]initWithData:data]; //设置XML数据
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
    [parser setDelegate:self];
    [parser parse];
    
    return true;
}

#pragma private
-(void)push:(CompositeDictionary *)node{
    [nodestack insertObject:node atIndex:0];
}

-(CompositeDictionary *)pop{
    CompositeDictionary * node = nodestack[0];
    [nodestack removeObjectAtIndex:0];
    
    return node;
}


#pragma mark - NSXMLParserDelegate
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    
    currentNode = nil;
    [nodestack removeAllObjects];
}


//发现元素开始符的处理函数  （即报告元素的开始以及元素的属性）
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    NSLog(@"elementName is %@, attributes is %@",elementName,attributeDict);
    
    CompositeDictionary * node = [[CompositeDictionary alloc] init:elementName];
    [node.attr addEntriesFromDictionary:attributeDict];
    
    if(currentNode == nil){
        currentNode = node;

    }else{
        [currentNode.childs addObject:node];
        [self push:currentNode];
        currentNode = node;
    }

}

//处理标签包含内容字符 （报告元素的所有或部分内容）
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
}
//发现元素结束符的处理函数，保存元素各项目数据（即报告元素的结束标记）
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    
    if (nodestack.count > 0)
        currentNode = [self pop];
    
    
}
//报告解析的结束
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    
    currentNode;
    //NSLog(@"%@",currentNode);
}
//报告不可恢复的解析错误
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"paraseFaild");

}
@end
