//
//  EXPSqlCenter.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-1.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "HDSqlCenter.h"

@implementation HDSQLCenter
//数据库初始化
-(BOOL)SQLCreatTable:(FMDatabase *)db{
    NSArray *sqlAry= [NSArray arrayWithObjects:@"CREATE TABLE IF NOT EXISTS DataPool ( id INTEGER PRIMARY KEY AUTOINCREMENT, localId INTEGER, sourceSystemName TEXT, item1 TEXT, item2 TEXT, item3 TEXT, item4 TEXT,	status TEXT, comment TEXT, submitAction TEXT,submitActionType TEXT,serverMessage TEXT,deliveree TEXT,screenName TEXT);",@"CREATE TABLE IF NOT EXISTS ACTION ( id INTEGER PRIMARY KEY AUTOINCREMENT,localId TEXT,sourceSystemName TEXT,action TEXT,actionTitle TEXT,actionType TEXT);",
        @"create table if not EXISTS MOBILE_EXP_REPORT_LINE (id INTEGER PRIMARY KEY AUTOINCREMENT ,expense_class_id INTEGER,expense_class_desc TEXT,expense_type_id INTEGER,expense_type_desc TEXT,expense_amount INTEGER,expense_number INTEGER,expense_date TEXT,expense_date_to TEXT,expense_place Text ,description TEXT,local_status TEXT,service_id INTEGER, CREATION_DATE  TEXT ,CREATED_BY TEXT,item1 BLOB, item2 BLOB, item3 BLOB, item4 BLOB, item5 BLOB, segment_1 TEXT,segment_2 TEXT, segment_3 TEXT,segment_4 TEXT,segment_5 TEXT,segment_6 TEXT, segment_7 TEXT,segment_8 TEXT ,segment_9 TEXT)",
                      
        nil];
    BOOL state = YES;
    state = [self execBatchInTransaction:db sqlArray:sqlAry];
    return state;
}

//清除数据库
-(BOOL)SQLCleanTable:(FMDatabase *)db{
    NSArray *sqlAry= [NSArray arrayWithObjects:[self creatCRUDSqlWithTableName:@"DataPool" params:nil keys:nil action:@"DELETE"],[self creatCRUDSqlWithTableName:@"ACTION" params:nil keys:nil action:@"DELETE"],nil];
    BOOL state = YES;
    state = [self execBatchInTransaction:db sqlArray:sqlAry];
    return state;
}

//查询ToDoList操作
-(FMResultSet *)SQLQueryToDoList:(FMDatabase *)db{
    NSString * tableName = @"DataPool";
    NSArray * params = [NSArray arrayWithObjects:@"id",@"localId",@"sourceSystemName",@"item1",@"item2",@"item3",@"item4",@"status",@"comment",@"submitAction",@"submitActionType",@"deliveree",@"screenName",nil];
    
    NSString *currentSql = [self creatCRUDSqlWithTableName:tableName params:params keys:nil action:@"SELECT"];
    
    return [db executeQuery:currentSql];
}


//查询ToDoList摘要操作
-(FMResultSet *)SQLQueryToDoListDigest:(FMDatabase *)db{
    
    NSString *currentSql = @"SELECT localId, sourceSystemName FROM DataPool";// WHERE STATUS != 'WAITING'
    
    return [db executeQuery:currentSql];
}

//将动作保存到动作表
-(BOOL)SQLActionInsertRecords:(FMDatabase *)db recordList:(NSArray *) recordList{
    if (!recordList) return NO;
    NSArray * params = [NSArray arrayWithObjects:@"localId",@"sourceSystemName",@"action",@"actionTitle",@"actionType",nil];
    NSString *currentSql = @"insert into ACTION VALUES (NULL,:localId,:sourceSystemName,:action,:actionTitle,:actionType);";
    BOOL state = YES;
    state = [self execLineInTransaction:db params:params recordList:recordList currentSql:currentSql];
    return state;
}
//将动作提交到本地(单条)
-(BOOL)SQLActionSubmitLocal:(FMDatabase *)db recordList:(NSArray *) recordList{
    if (!recordList) return NO;
    NSString * tableName = @"DataPool";
    NSArray * params = [NSArray arrayWithObjects:@"submitAction",@"submitActionType",@"comment",nil];
    NSArray * keys = [NSArray arrayWithObjects:@"localId",@"sourceSystemName",nil];
    
    NSString *currentSql = [self creatCRUDSqlWithTableName:tableName params:params keys:keys action:@"UPDATE"];
    
    BOOL state = YES;
    state = [self execLineInTransaction:db params:[params arrayByAddingObjectsFromArray:keys] recordList:recordList currentSql:currentSql];
    return state;
}

//删除记录
-(BOOL)SQLRemoveRecords:(FMDatabase *)db recordList:(NSArray *) recordList{
    NSString * tableName = @"DataPool";
    NSArray * keys = [NSArray arrayWithObjects:@"localId",@"sourceSystemName",nil];
    NSString *currentSql = [self creatCRUDSqlWithTableName:tableName params:nil keys:keys action:@"DELETE"];
    BOOL state = YES;
    state = [self execLineInTransaction:db params:keys recordList:recordList currentSql:currentSql];
    return state;
}

//更新操作
-(BOOL)SQLUpdateRecords:(FMDatabase *)db recordList:(NSArray *) recordList{
    if (!recordList) return NO;
    NSString * tableName = @"DataPool";
    NSArray * params = [NSArray arrayWithObjects:@"status",@"submitAction",@"submitActionType",@"comment",nil];
    NSArray * keys = [NSArray arrayWithObjects:@"localId",@"sourceSystemName",nil];
    
    NSString *currentSql = [self creatCRUDSqlWithTableName:tableName params:params keys:keys action:@"UPDATE"];
    
    BOOL state = YES;
    state = [self execLineInTransaction:db params:[params arrayByAddingObjectsFromArray:keys] recordList:recordList currentSql:currentSql];
    return state;
}


//转交更新操作
-(BOOL)SQLUpdateDeliverRecords:(FMDatabase *)db recordList:(NSArray *) recordList{
    if (!recordList) return NO;
    NSString * tableName = @"DataPool";
    NSArray * params = [NSArray arrayWithObjects:@"status",@"submitAction",@"submitActionType",@"comment",@"deliveree",nil];
    NSArray * keys = [NSArray arrayWithObjects:@"localId",@"sourceSystemName",nil];
    
    NSString *currentSql = [self creatCRUDSqlWithTableName:tableName params:params keys:keys action:@"UPDATE"];
    
    BOOL state = YES;
    state = [self execLineInTransaction:db params:[params arrayByAddingObjectsFromArray:keys] recordList:recordList currentSql:currentSql];
    return state;
}
//DataPool表插入
-(BOOL)SQLInsertRecords:(FMDatabase *)db recordList:(NSArray *) recordList{
    if (!recordList) return NO;
    NSString *currentSql = @"INSERT INTO DataPool ( localId, sourceSystemName, item1, item2, item3, item4, status,screenName ) VALUES (:localId, :sourceSystemName, :item1, :item2, :item3, :item4, \"NEW\" ,:screenName)";
    BOOL state = YES;
    state = [self execLineInTransaction:db recordList:recordList currentSql:currentSql];
    return state;
}

-(NSString *)creatCRUDSqlWithTableName:(NSString *)tableName params:(NSArray *)params keys:(NSArray *)keys action:(NSString *)action{
    NSMutableString * values = [[NSMutableString alloc] init];
    NSMutableString * where = [[NSMutableString alloc] init];
    [values appendString:action];
    if (keys != nil) {
        [where appendString:@"WHERE "];
        NSInteger i = [keys count];
        for (NSString * key in keys) {
            [where appendFormat:@"%@ = :%@",key,key];
            if (i>1) {
                [where appendString:@" AND "];
            }
            i--;
        }
    }
    
    if ([action isEqualToString:@"SELECT"]) {
        NSInteger s = 0;
        if (params != nil) {
            for (NSString * param in params) {
                if (s>0) {
                    [values appendString:@","];
                }
                [values appendFormat:@" %@ ",param];
                
                s++;
            }
        }
        [values appendFormat:@" FROM %@ ",tableName];
        
    } else if([action isEqualToString:@"UPDATE"]){
        [values appendFormat:@" %@ SET ",tableName];
        NSInteger u = 0;
        if (params != nil) {
            for (NSString * param in params) {
                if (u>0) {
                    [values appendString:@","];
                }
                [values appendFormat:@"%@ = :%@ ",param,param];
                u++;
            }
        }
        
    } else if ([action isEqualToString:@"DELETE"]){
        [values appendFormat:@" FROM %@ ",tableName];
    }
    NSString * sql = [NSString stringWithFormat:@"%@ %@",values,where];
    return sql;
}
-(BOOL)execLineInTransaction:(FMDatabase *)db recordList:(NSArray *) recordList currentSql:(NSString *)currentSql{
    
    return [self execLineInTransaction:db params:nil recordList:recordList currentSql:currentSql];
}

//单行SQL执行，传入 数据库，记录集参数，SQL语句
-(BOOL)execLineInTransaction:(FMDatabase *)db params:(NSArray *)params recordList:(NSArray *) recordList currentSql:(NSString *)currentSql{
    BOOL state = YES;
    if ([db beginTransaction]) {
        int rCount  = [recordList count];
        for (int n = 0; n<rCount; n++) {
            NSDictionary * record =nil;
            if (params != nil) {
                record = [[NSDictionary dictionaryWithDictionary:[recordList objectAtIndex:n]] dictionaryWithValuesForKeys:params];
            }else{
                record = [NSDictionary dictionaryWithDictionary:[recordList objectAtIndex:n]];
            }
            
            state =  [db executeUpdate:currentSql withParameterDictionary:record];
            if (!state) {
                if (![db rollback]) {
                    NSLog(@"数据库rollback失败");
                }
                return state;
            }
        }
        if (![db commit]) {
            NSLog(@"数据库commit失败");
        };
    }else {
        state=NO;
    }
    return state;
}

//批量SQL执行，传入 数据库，SQL语句数组
-(BOOL)execBatchInTransaction:(FMDatabase *)db sqlArray:(NSArray *)sqlArray{
    BOOL state = YES;
    int sqlCount = [sqlArray count];
    if ([db beginTransaction]) {
        for (int i = 0; i<sqlCount; i++) {
            NSString * currentSql =[sqlArray objectAtIndex:i];
            if (![db executeUpdate:currentSql]) {
                state =NO;
            }
        }
        if (!state) {
            [db rollback];
            return state;
        }
        [db commit];
    }else {
        state=NO;
    }
    return state;
}


#pragma  对移动报销单行进行操作
//MOBILE_EXP_REPORT_LINE插入
-(BOOL)MOBILE_EXP_REPORT_LINE:(FMDatabase * )db recordList:(NSArray *) recordList{
    if(!recordList)
        return  NO;
    NSString *currentSql = @"INSERT INTO MOBILE_EXP_REPORT_LINE (expense_class_id, expense_class_desc,expense_type_id,expense_type_desc, expense_amount, expense_number,expense_date,expense_date_to,expense_place, description,local_status,CREATION_DATE,CREATED_BY,item1) VALUES (:expense_class_id,:expense_class_desc, :expense_type_id, :expense_type_desc, :expense_amount, :expense_number,:expense_date, :expense_date_to,:expense_place,:description,:local_status, :CREATION_DATE,:CREATED_BY,:item1)";
    BOOL state = YES;
    state = [self execLineInTransaction:db recordList:recordList currentSql:currentSql];
    return  state;
}
//通过id查询MOBILE_EXP_REPORT_LINE
-(FMResultSet *)QUERY_MOBILE_EXP_REPORT_LINE:(FMDatabase *)db recordList:(NSDictionary *) conditions{
    NSLog(@"select ,MOBILE_EXP_REPORT_LINE");
    NSNumber * keyId =[conditions valueForKey:@"id"];
    return    [db executeQueryWithFormat:@"SELECT * FROM MOBILE_EXP_REPORT_LINE where id =%@", keyId];
}
//查询MOBILE_EXP_REPORT_LINE
-(FMResultSet *)QUERY_MOBILE_EXP_REPORT_LINE:(FMDatabase *)db{
    
    NSString *currentSql = @"SELECT * FROM MOBILE_EXP_REPORT_LINE  WHERE local_status = 'new' ";// WHERE STATUS != 'WAITING'
    
    return [db executeQuery:currentSql];
}

-(FMResultSet *)QUERYALL_MOBILE_EXP_REPORT_LINE:(FMDatabase *)db{
    
    NSString *currentSql = @"SELECT * FROM MOBILE_EXP_REPORT_LINE ";// WHERE STATUS != 'WAITING'
    
    return [db executeQuery:currentSql];
}

//更新MOBILE_EXP_REPORT_LINE
-(BOOL)UPDATE_MOBILE_EXP_REPORT_LINE:(FMDatabase *)db recordList:(NSArray *) recordList{
    if (!recordList) return NO;
    NSString * tableName = @"MOBILE_EXP_REPORT_LINE";
    NSArray * params = [NSArray arrayWithObjects:@"expense_class_id",@"expense_class_desc",@"expense_type_id",@"expense_type_desc",@"expense_amount",@"expense_number",@"expense_date",@"expense_date_to",@"expense_place",@"description",@"local_status",@"item1",nil];
    NSArray * keys = [NSArray arrayWithObjects:@"id",nil];
    
    NSString *currentSql = [self creatCRUDSqlWithTableName:tableName params:params keys:keys action:@"UPDATE"];
    
    BOOL state = YES;
    state = [self execLineInTransaction:db params:[params arrayByAddingObjectsFromArray:keys] recordList:recordList currentSql:currentSql];
    return state;
}


//更新MOBILE_EXP_REPORT_LINE 状态
-(BOOL)UPDATE_MOBILE_EXP_REPORT_LINE_STATUS:(FMDatabase *)db recordList:(NSArray *) recordList{
    if (!recordList) return NO;
    NSString * tableName = @"MOBILE_EXP_REPORT_LINE";
    NSArray * params = [NSArray arrayWithObjects:@"local_status",nil];
    NSArray * keys = [NSArray arrayWithObjects:@"id",nil];
    
    NSString *currentSql = [self creatCRUDSqlWithTableName:tableName params:params keys:keys action:@"UPDATE"];
    
    BOOL state = YES;
    state = [self execLineInTransaction:db params:[params arrayByAddingObjectsFromArray:keys] recordList:recordList currentSql:currentSql];
    return  state;
}

-(BOOL)DELETE_MOBILE_EXP_REPORT_LINE:(FMDatabase *)db recordList:(NSArray *) recordList{
    if (!recordList) return NO;
    NSString * tableName = @"MOBILE_EXP_REPORT_LINE";
    NSArray * keys = [NSArray arrayWithObjects:@"id",nil];
    
    NSString *currentSql = [self creatCRUDSqlWithTableName:tableName params:nil keys:keys action:@"DELETE"];
    
    BOOL state = YES;
    state = [self execLineInTransaction:db params:nil recordList:recordList currentSql:currentSql];

    return state;
}


-(FMResultSet *)QUERY_MOBILE_EXP_SUM:(FMDatabase *)db{
    
    NSString *currentSql = @"SELECT * FROM MOBILE_EXP_REPORT_LINE ";// WHERE STATUS != 'WAITING'
    
    return [db executeQuery:currentSql];
}



@end