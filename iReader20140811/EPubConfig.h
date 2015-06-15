//
//  EPubConfig.h
//  TestFootTrace
//
//  Created by lcl on 18/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#define kAPPName    [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define kDocuments  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

//数据库地址，用于保存书签等
#define kEPubDBPath     [NSString stringWithFormat:@"%@/%@", kDocuments, @"EPub.db"]