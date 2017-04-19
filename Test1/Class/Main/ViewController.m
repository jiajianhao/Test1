//
//  ViewController.m
//  Test1
//
//  Created by 小雨科技 on 2017/3/29.
//  Copyright © 2017年 小雨科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "JiaSearchBar.h"
#import "YFLStandardTime.h"
#import "ViewController1.h"
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>
#import "ViewController2.h"
#import "NSString+Extensions.h"
#import "ViewController3.h"

#define _WIDTH [UIScreen mainScreen].bounds.size.width
#define _HEIGHT [UIScreen mainScreen].bounds.size.height
#define _USERDEFAULT [NSUserDefaults                    standardUserDefaults]

@interface ViewController ()<UITextViewDelegate,UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>{
    CGFloat heightForDes;
    NSMutableArray *dataArray;
}
@property(nonatomic,strong)UILabel *label1;
@property(nonatomic,strong) UITextView*  contentTextView;
@property(nonatomic,assign)CGPoint touchPoint;
@property(nonatomic,strong)UITableView *mineTableView;

@end

@implementation ViewController
#pragma mark
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigation];
    [self mineDataInit];
    [self mineTableView];
    
 
}

#pragma mark - Initial DATA && UI
-(void)mineDataInit{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    dataArray =[[NSMutableArray alloc]initWithObjects:@"scroll",@"table",@"save photo",nil];
    self.navigationItem.title = @"Test1";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"繁体" style:UIBarButtonItemStylePlain target:self action:@selector(ChangeChineseOnClick:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"帮助" style:UIBarButtonItemStylePlain target:self action:@selector(helpButtonOnClick:)];

}
- (void)setupNavigation {
    //    self.navigationController.navigationBar.hidden=NO;
    //    [self.navigationController.navigationBar setHidden:NO];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.barTintColor = RGBA(180, 212,208, 1.0);
    self.navigationController.navigationBar.translucent = NO;
    NSDictionary * dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}
#pragma mark - 长按弹出菜单
-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture{
    
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        CGPoint point = [gesture locationInView:_label1];
        _touchPoint =point;
        
        //这里要获取到你点击时候的位置
        [self addMenuController];
    }
}


#pragma mark 菜单选项
-(void)addMenuController{
    UIMenuController *menuController =[UIMenuController sharedMenuController];
    UIMenuItem *menuitem1 =[[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(doCopy:)];
    
    //@selset里面的方法是你点击弹出menucontroller其中一个所要执行的方法
    UIMenuItem *menuitem2 =[[UIMenuItem alloc]initWithTitle:@"保存" action:@selector(doSavePhoto:)];
    UIMenuItem *menuitem3 =[[UIMenuItem alloc]initWithTitle:@"转发" action:@selector(doForward:)];
    menuController.menuItems = [NSArray arrayWithObjects:menuitem1, menuitem2, menuitem3, nil];

    [menuController setTargetRect:CGRectMake(_touchPoint.x, _touchPoint.y, 0, 50) inView:self.label1];
    
    [menuController setMenuVisible:YES animated:YES];
    
}
//复制
-(void)doCopy:(id)sender{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    
    //这其实就是一个剪切板  UIPasteboard
//    pboard.string = self.messageVo.body;
//    [MBProgressHUD showSuccess:@"复制成功"];
    
}

//转发
-(void)doForward:(id)sender{
//    DCSAddMessageViewController *add = [[DCSAddMessageViewController alloc]init];
//    add.checkIsForward = YES;
//    add.inMessageVo = self.messageVo;
//    [self.navigationController pushViewController:add animated:YES];
}

//保存图片
-(void)doSavePhoto:(id)sender{
//    NSURL *url = [NSURL URLWithString:self.messageVo.attachmentVo.attachUrl];
//    UIImageView *viw = [[UIImageView alloc]init];
//    [viw sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        if(!error) {
//            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
//        }
//    }];
}

#pragma mark
- (float) heightForTextView: (UITextView *)textView WithText: (NSString *) strText{
    CGSize constraint = CGSizeMake(textView.contentSize.width , CGFLOAT_MAX);
    CGRect size = [strText boundingRectWithSize:constraint
                                        options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                     attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]}
                                        context:nil];
    float textHeight = size.size.height  ;
    if (size.size.height<heightForDes) {
        return heightForDes;
    }
    else{
        return textHeight;

    }
  
    
}
-(void)test1{
    
}
-(void)test{
    JiaSearchBar *sBar = [JiaSearchBar searchBar];
    sBar.frame=CGRectMake(0, 80,_WIDTH, 44);
    [self.view addSubview:sBar];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate *date = [formatter dateFromString:@"1490776298000"];
    NSLog(@"date1:%@",date);
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:1490776298000/1000];
    NSLog(@"confromTimesp:%@",confromTimesp);
    
    NSString *string = [YFLStandardTime changeToStandardTimeByMS:@"1490776298000"];
    NSLog(@"confromTimesp:%@",string);
    NSString *string2 = [YFLStandardTime changeToDayTimeByMS:@"1490776298000"];
    NSLog(@"confromTimesp:%@",string2);
    
    NSString *string3 = [YFLStandardTime changeToMinuteTimeByMS:@"1490776298000"];
    NSLog(@"confromTimesp:%@",string3);
    
    
    _label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 140, 320, 20)];
    
    _label1.text=@"11 2133331211 1";
    
    [self.view addSubview:_label1];
    //    NSMutableAttributedString *richText = [[NSMutableAttributedString alloc] initWithString:_label1.text];
    //
    //    [richText addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];//设置字体颜色
    //    _label1.attributedText=richText;
    
    
    
    //寻找并变色
    NSMutableString *attString = [NSMutableString stringWithString:_label1.text];
    NSMutableArray *rangeArray = [NSMutableArray array];
    NSMutableString *blankWord = [NSMutableString string];
    NSString *keyword =@"1";
    //    for (int i = 0; i < keyword.length; i ++) {
    //
    //        [blankWord appendString:@" "];
    //    }
    //    for (int i = 0; i < attString.length; i++) {
    //
    //        if ([attString rangeOfString:@"" options:1].location != NSNotFound){
    //            NSInteger newLo = [attString rangeOfString:keyword  options:1].location;
    //            NSInteger newLen = [attString rangeOfString:keyword  options:1].length;
    //            NSRange newRange = NSMakeRange(newLo, newLen);
    //            [rangeArray addObject:NSStringFromRange(newRange)];
    //            [attString replaceCharactersInRange:newRange withString:blankWord];
    //
    //        }else{
    //            break;
    //        }
    //    }
    NSMutableArray *arr1  = [self rangeOfSubString:keyword inString:attString];
    
    NSMutableAttributedString *str222 = [[NSMutableAttributedString alloc] initWithString:_label1.text];
    for (int i = 0; i < arr1.count; i ++) {
        NSLog(@"%@",[arr1 objectAtIndex:i]);
        [str222 addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSRangeFromString([arr1 objectAtIndex:i])];
    }
    _label1.attributedText = str222;

}
- (NSMutableArray *)rangeOfSubString:(NSString *)subStr inString:(NSString *)string {
    
    NSMutableArray *rangeArray = [NSMutableArray array];
    
    NSString *string1 = [string stringByAppendingString:subStr];
    
    NSString *temp;
    
    for (int i = 0; i < string.length; i ++) {
        
        temp = [string1 substringWithRange:NSMakeRange(i, subStr.length)];
        
        if ([temp isEqualToString:subStr]) {
            
            NSRange range = {i,subStr.length};
            
            [rangeArray addObject:NSStringFromRange(range)];
            
        }
        
    }
    
    return rangeArray;
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    NSString *regex = @"[a-zA-Z\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]+";
    NSString *regex = @" ^[a-zA-Z0-9_\u4e00-\u9fa5]+$";

    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    
    if(![pred evaluateWithObject:text])
    {
        NSLog(@"出错");
        return NO;
    }
    
    
    NSString *textReplace = [NSString stringWithFormat:@"%@",text];
    NSLog(@"textReplace:%@",textReplace);

    if (textReplace ==nil|| [textReplace isEqualToString:@""]||[textReplace isEqualToString:@"(null)"]) {
        return YES;
    }
//    NSLog(@"%@",[[UIApplication sharedApplication]textInputMode].primaryLanguage );
//    if ([[[UIApplication sharedApplication]textInputMode].primaryLanguage isEqualToString:@"emoji"]||[[[UIApplication sharedApplication]textInputMode].primaryLanguage isEqualToString:@""]||[[UIApplication sharedApplication]textInputMode].primaryLanguage ==nil) {
//        return NO;
//    }
//    return YES;
        NSLog(@"%@",textView.textInputMode.primaryLanguage );
 
    if ([[[textView textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textView textInputMode] primaryLanguage]) {
            return NO;
        }
        return YES;
}
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender

{
    
    if ([UIMenuController sharedMenuController]) {
        
        [UIMenuController sharedMenuController].menuVisible = NO;
        
    }
    
    return NO;
    
}
-(void)textViewDidChange:(UITextView *)textView{
    NSLog(@"textViewDidChange:%@",textView.text);
//    BOOL flag=[NSString isContainsTwoEmoji:textView.text];
//    
//    if (textView == _contentTextView) {
//        
//        if (flag)
//        {
//            
//            _contentTextView.text = [textView.text substringToIndex:textView.text.length -2];
//            
//        }
//    }
//    NSRange textRange = [textView selectedRange];
//    [textView setText:[self disable_emoji:[textView text]]];
//    [textView setSelectedRange:textRange];
// [textView setText:[NSString filterEmoji:[textView text]]];

}
//禁止输入表情
- (NSString *)disable_emoji:(NSString *)text
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    ViewController3 *vc=[[ViewController3 alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//NSString *string = [[[NSString alloc] initWithString:self.text];
//                    [string enumerateSubstringsInRange:NSMakeRange(0, string.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) { //emoji length is 2 replace emoji with emptyString if (substring.length == EmojiCharacterLength) { self.text = [self.text stringByReplacingOccurrencesOfString:substring withString:@""];
//} }];

- (NSString *)transformToPinyin:(NSString *)str {
    NSMutableString *mutableString = [NSMutableString stringWithString:str];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    return [mutableString stringByReplacingOccurrencesOfString:@"'" withString:@""];
}
#pragma mark 列表

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [dataArray count];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    static NSString *identifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.textLabel.textColor=[UIColor orangeColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //

    }
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    

    return cell;
    
 }
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row==0) {
        ViewController1 * vc = [[ViewController1 alloc]init];
        vc.title=[dataArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row==1) {
        ViewController2 * vc = [[ViewController2 alloc]init];
        vc.title=[dataArray objectAtIndex:indexPath.row];

        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row==2) {
        ViewController3 * vc = [[ViewController3 alloc]init];
        vc.title=[dataArray objectAtIndex:indexPath.row];

        [self.navigationController pushViewController:vc animated:YES];
    }

}
#pragma mark Button Event
-(void)ChangeChineseOnClick:(id)sender{
    
}
-(void)helpButtonOnClick:(id)sender{
    
}

#pragma mark - Setter / Getter
-(UITableView *)mineTableView{
    if (!_mineTableView) {
        _mineTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, _WIDTH, _HEIGHT-64) style:UITableViewStylePlain];
        _mineTableView.delegate=self;
        _mineTableView.dataSource=self;
        _mineTableView.backgroundColor=[UIColor clearColor];
        [self.view addSubview:_mineTableView];
    }
    return _mineTableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
