//
//  ViewController3.m
//  Test1
//
//  Created by 小雨科技 on 2017/4/18.
//  Copyright © 2017年 小雨科技有限公司. All rights reserved.
//

#import "ViewController3.h"
#import <Photos/Photos.h>
#import "UIColor+AddColor.h"
#define _WIDTH [UIScreen mainScreen].bounds.size.width
#define _HEIGHT [UIScreen mainScreen].bounds.size.height
#define _BACKGROUND_COLOR [UIColor colorFromHexCode:@"#F5F5F5"]
#define _Line_common [UIColor colorFromHexCode:@"#e5e5e5"]

@interface ViewController3 (){
    UIImageView *image1 ;
    NSString *strName;
}
@property(nonatomic,strong)UIView* mineActionSheet;
@property(nonatomic,strong)UIView*bottomview;


@end

@implementation ViewController3
#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigation];
    [self mineDataInit];
  }
#pragma mark - Initial DATA && UI
-(void)mineDataInit{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    strName=@"tupian2.png";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"首页" style:UIBarButtonItemStylePlain target:self action:@selector(backBtnOnCLick:)];
    image1= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _WIDTH, _HEIGHT-64-44)];
    [image1 setImage:[UIImage imageNamed:@"tupian.png"]];
    [image1 setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:image1];
    
    UIButton *buttonAdd = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonAdd setBackgroundColor:[UIColor clearColor]];
    [buttonAdd setFrame:CGRectMake(0, _HEIGHT-64-44, _WIDTH, 44)];
    [buttonAdd setTitle:@"保存图片" forState:UIControlStateNormal];
    [buttonAdd setTintColor:[UIColor blackColor]];
    [buttonAdd setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonAdd addTarget:self action:@selector(buttonOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonAdd];

}
- (void)setupNavigation {
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.barTintColor = RGBA(180, 212,208, 1.0);
    self.navigationController.navigationBar.translucent = NO;
    NSDictionary * dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

#pragma mark - Button Event
-(void)backBtnOnCLick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)buttonOnClick{
    [self mineActionSheet];
    [self showMineActionSheet];
}

-(void)saveButtonOnClick{
    [self hideMineActionSheet];

    if (![self getPhotoAuth]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请授权访问相册" message:@"" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
        return ;
    }
    if ([strName isEqualToString:@"tupian2.png"]) {
        strName=@"tupian.png";
        
    }
    else{
        strName=@"tupian2.png";
    }
    [self loadImageFinished:[UIImage imageNamed:strName]];
}
-(void)cancelOnClick:(id)sender{
    [self hideMineActionSheet];
}
#pragma mark - Private Methods
- (void)loadImageFinished:(UIImage *)image
{
    NSMutableArray *imageIds = [NSMutableArray array];
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        //写入图片到相册
        PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        //记录本地标识，等待完成后取到相册中的图片对象
        [imageIds addObject:req.placeholderForCreatedAsset.localIdentifier];
        
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
        NSLog(@"success = %d, error = %@", success, error);
        
        if (success)
        {
            dispatch_async(dispatch_get_main_queue(), ^{

            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"保存成功" message:@"" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
            });
            //成功后取相册中的图片对象
            __block PHAsset *imageAsset = nil;
            PHFetchResult *result = [PHAsset fetchAssetsWithLocalIdentifiers:imageIds options:nil];
            [result enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                imageAsset = obj;
                *stop = YES;
                
            }];
            
            if (imageAsset)
            {
                //加载图片数据
                [[PHImageManager defaultManager] requestImageDataForAsset:imageAsset
                                                                  options:nil
                                                            resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                                                                
                                                                NSLog(@"imageData = %@", imageData);
 
                                                                [image1 setImage:[UIImage imageWithData: imageData]];
                                                                
                                                            }];
            }
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"保存失败" message:@"" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alert show];
            });
        }
        
    }];
}
-(BOOL)getPhotoAuth{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted ||
        status == PHAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}

#pragma mark - Setter / Getter
-(UIView *)mineActionSheet{
    if (!_mineActionSheet) {
        _mineActionSheet = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _WIDTH, _HEIGHT)];
        _mineActionSheet.backgroundColor=[UIColor clearColor];
        _mineActionSheet.hidden=YES;
        [self.view addSubview:_mineActionSheet];
        
        UIView*maskview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _WIDTH, _HEIGHT)];
        maskview.backgroundColor=[UIColor colorFromHexCode:@"#000000"];
        maskview.alpha=0.4;
        [_mineActionSheet addSubview:maskview];
        
        _bottomview=[[UIView alloc]initWithFrame:CGRectMake(0, _HEIGHT, _WIDTH, 156-50)];
        _bottomview.backgroundColor=[UIColor whiteColor];
        [_mineActionSheet addSubview:_bottomview];
        
        UIButton *button1 =[UIButton buttonWithType:UIButtonTypeCustom];
        [button1 setFrame:CGRectMake(0, 0, _WIDTH, 50)];
        [button1 addTarget:self action:@selector(saveButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
        button1.backgroundColor=[UIColor clearColor];
        button1.tag=1;
        [button1 setTitle:@"保存图片" forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor colorFromHexCode:@"#000000"] forState:UIControlStateNormal];
        button1.titleLabel.font=[UIFont systemFontOfSize:16];
        [_bottomview addSubview:button1];
        
        UIView*lineView = [[UIView alloc] init];
        lineView.frame = CGRectMake(0, 50-0.5, _WIDTH, 0.5);
        lineView.backgroundColor = _Line_common;
        [_bottomview addSubview:lineView];
        
//        UIButton *button2 =[UIButton buttonWithType:UIButtonTypeCustom];
//        [button2 setFrame:CGRectMake(0, 50, _WIDTH, 50)];
//        [button2 addTarget:self action:@selector(cameraButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
//        button2.backgroundColor=[UIColor clearColor];
//        button2.tag=2;
//        [button2 setTitle:@"从相册选择" forState:UIControlStateNormal];
//        [button2 setTitleColor:[UIColor colorFromHexCode:@"#000000"] forState:UIControlStateNormal];
//        button2.titleLabel.font=[UIFont systemFontOfSize:16];
//        [_bottomview addSubview:button2];
//        
//        
//        UIView*backview=[[UIView alloc]initWithFrame:CGRectMake(0, 100, _WIDTH,6)];
//        backview.backgroundColor=_BACKGROUND_COLOR;
//        [_bottomview addSubview:backview];
        
        
        UIButton *buttonCancel =[UIButton buttonWithType:UIButtonTypeCustom];
        [buttonCancel setFrame:CGRectMake(0, 106-50, _WIDTH, 50)];
        [buttonCancel addTarget:self action:@selector(cancelOnClick:) forControlEvents:UIControlEventTouchUpInside];
        buttonCancel.backgroundColor=[UIColor clearColor];
        buttonCancel.tag=0;
        [buttonCancel setTitle:@"取消" forState:UIControlStateNormal];
        [buttonCancel setTitleColor:[UIColor colorFromHexCode:@"#000000"] forState:UIControlStateNormal];
        buttonCancel.titleLabel.font=[UIFont systemFontOfSize:16];
        [_bottomview addSubview:buttonCancel];
        
    }
    
    return _mineActionSheet;
}
#pragma mark - 遮罩菜单弹框
-(void)showMineActionSheet{
    _mineActionSheet.hidden=NO;
    [UIView animateWithDuration:0.2 animations:^{
        [_bottomview setFrame:CGRectMake(0, _HEIGHT-64-156+50, _WIDTH, 156-50)];
    }completion:nil];
}
-(void)hideMineActionSheet{
    [UIView animateWithDuration:0.2 animations:^{
        [_bottomview setFrame:CGRectMake(0, _HEIGHT-64 , _WIDTH, 156-50)];
    }completion:^(BOOL isOk){
        _mineActionSheet.hidden=YES;
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
