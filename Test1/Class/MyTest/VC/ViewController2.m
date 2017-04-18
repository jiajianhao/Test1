//
//  ViewController2.m
//  Test1
//
//  Created by 小雨科技 on 2017/4/12.
//  Copyright © 2017年 小雨科技有限公司. All rights reserved.
//

#import "ViewController2.h"
#define _WIDTH [UIScreen mainScreen].bounds.size.width
#define _HEIGHT [UIScreen mainScreen].bounds.size.height
#define UIColorFromRGB(rgbValue) [UIColor  colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0  green:((float)((rgbValue & 0xFF00) >> 8))/255.0  blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController2 ()<UITableViewDelegate,UITableViewDataSource>{
    UITableViewCellEditingStyle _editingStyle;
}
@property(nonatomic,strong)UITableView*tableView;
@property (nonatomic, retain) NSMutableArray *data;
@property (assign, nonatomic) NSIndexPath *selIndex;//单选，当前选中的行

@end

@implementation ViewController2

#pragma mark - 生命周期方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.data = [NSMutableArray array];
    
    for (int i = 0; i<20; i++) {
        NSString *text = [NSString stringWithFormat:@"mj-%i", i];
        [self.data addObject:text];
    }
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, _WIDTH, _HEIGHT-64) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    // 设置tableView可不可以选中
    //self.tableView.allowsSelection = NO;
    
    // 允许tableview多选
//    self.tableView.allowsMultipleSelection = YES;
    
    // 编辑模式下是否可以选中
//    self.tableView.allowsSelectionDuringEditing = NO;
    
    // 编辑模式下是否可以多选
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    
    // 获取被选中的所有行
    // [self.tableView indexPathsForSelectedRows]
    
    // 获取当前可见的行
    // [self.tableView indexPathsForVisibleRows];
    
    self.tableView.editing=YES;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.data = nil;
}



#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.detailTextLabel.text = @"详细描述";
    }
    
    cell.textLabel.text = [self.data objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - 代理方法
#pragma mark 设置Cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectRowAtIndexPath");
    UITableViewCell *celled = [tableView cellForRowAtIndexPath:_selIndex];
    celled.accessoryType = UITableViewCellAccessoryNone;
    //记录当前选中的位置索引
    _selIndex = indexPath;
    //当前选择的打勾
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
}

#pragma mark 提交编辑操作时会调用这个方法(删除，添加)
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.data removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
}
#pragma mark 决定tableview的编辑模式
//选择你要对表进行处理的方式  默认是删除方式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    return  UITableViewCellEditingStyleDelete ;
    if (!tableView.editing)
        return UITableViewCellEditingStyleNone;
    else {
        return UITableViewCellEditingStyleDelete;
    }
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    self.tableView.tintColor=UIColorFromRGB(0x06C1AE);
    return YES;
}

- (NSString *)transformToPinyin:(NSString *)str {
    NSMutableString *mutableString = [NSMutableString stringWithString:str];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    return [mutableString stringByReplacingOccurrencesOfString:@"'" withString:@""];
}

#pragma mark - 公共方法
 // Dispose of any resources that can be recreated.

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
