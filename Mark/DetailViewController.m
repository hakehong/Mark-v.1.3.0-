//
//  DetailViewController.m
//  Mark
//
//  Created by hongqing on 16/4/29.
//  Copyright © 2016年 hongqing. All rights reserved.
//

#import "DetailViewController.h"
#import "WebImgScrollView.h"
#import "DetailViewTool.h"
#import "CycleMovie.h"
#import "UIView+Extension.h"
@interface DetailViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIView *tabBarView;
@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UILabel *likeLab;
@property (nonatomic, strong) UILabel *shareLab;
@end

@implementation DetailViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _likeBtn.frame =_tabBarView.bounds;
//    _likeBtn.x = 0;
    _likeBtn.width =_tabBarView.width *0.5;
    _likeBtn.height =_tabBarView.height;
    _shareBtn.x =_likeBtn.width;
    _shareBtn.width =_tabBarView.width *0.5;
    _shareBtn.height =_tabBarView.height;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.hidesBottomBarWhenPushed = YES;
//    self.tabBarController.tabBar.hidden =YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title =[NSString stringWithFormat:@"影单详情"];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"goBackIcon"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.tabBarView];
    [self.tabBarView addSubview:self.shareBtn];
    [self.tabBarView addSubview:self.likeBtn];
    // Do any additional setup after loading the view.
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    //调整字号
    NSString *str = @"document.getElementsByTagName('content')[0].style.webkitTextSizeAdjust= '100%'";
    [webView stringByEvaluatingJavaScriptFromString:str];
    
    //js方法遍历图片添加点击事件 返回图片个数
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var objs = document.getElementsByTagName(\"img\");\
    for(var i=0;i<objs.length;i++){\
    objs[i].onclick=function(){\
    document.location=\"myweb:imageClick:\"+this.src;\
    };\
    };\
    return objs.length;\
    };";
    
    [webView stringByEvaluatingJavaScriptFromString:jsGetImages];//注入js方法
    [webView stringByEvaluatingJavaScriptFromString:@"getImages()"];
    
//    //    上拉加载
//    NSString *height_str= [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];

    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *str = request.URL.absoluteString;
    
    if ([str hasPrefix:@"myweb:imageClick:"]) {
        str = [str stringByReplacingOccurrencesOfString:@"myweb:imageClick:"
                                             withString:@""];
        [WebImgScrollView showImageWithStr:str];
        return YES;
    }
//    }else  ([str isEqualToString:@"about:blank"]){
//        
//    }
//    else{
//        WebViewController *webVC = [[WebViewController alloc] initWithNSString:str];
//        [self.navigationController pushViewController:webVC animated:YES];
//        return NO;
//    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    return YES;
}
- (UIWebView *)webView{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, Kwidth, Kheight -124)];
        _webView.delegate = self;
        _webView.opaque = NO;
    }
    return _webView;
}
-(void)setMovieId:(NSNumber *)movieId
{
    _movieId =movieId;
    [DetailViewTool getDetailStoryWithStoryId:movieId Callback:^(id obj) {
        self.movieDetail =obj;
       [_webView loadHTMLString:self.movieDetail.contentInfo baseURL:nil];
    }];
    
    
}
-(void)setMovieDetail:(CycleMovie *)movieDetail
{
    _movieDetail = movieDetail;
  
}

#pragma mark- 如果多如此类的按钮的初始化，是不是可以使用一种方法如工厂方法批量生产
 
//分享按钮
- (UIButton *)shareBtn{
    if (_shareBtn == nil) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn addTarget:self
                      action:@selector(share)
            forControlEvents:UIControlEventTouchUpInside];
        [_shareBtn setImage:[UIImage imageNamed:@"batchShareIcon"]
                   forState:UIControlStateNormal];
    }
    return _shareBtn;
}
//喜欢按钮
- (UIButton *)likeBtn{
    if (_likeBtn == nil) {
        _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeBtn addTarget:self
                      action:@selector(like)
            forControlEvents:UIControlEventTouchUpInside];
        [_likeBtn setImage:[UIImage imageNamed:@"voteAloneDownIcon"]
                   forState:UIControlStateNormal];
    }
    return _likeBtn;
}
//喜欢人数
- (UILabel *)likeLab{
    if (_likeLab == nil) {
//        _likeLab = [[UILabel alloc] initWithFrame:CGRectMake(40, 23, kScreenWidth - 80, 30)];
        _likeLab.font = [UIFont systemFontOfSize:18];
        _likeLab.textColor = [UIColor whiteColor];
        _likeLab.textAlignment = NSTextAlignmentCenter;
    }
    return _likeLab;
}
//分享人数
- (UILabel *)shareLab{
    if (_shareLab == nil) {
        //        _likeLab = [[UILabel alloc] initWithFrame:CGRectMake(40, 23, kScreenWidth - 80, 30)];
        _shareLab.font = [UIFont systemFontOfSize:18];
        _shareLab.textColor = [UIColor whiteColor];
        _shareLab.textAlignment = NSTextAlignmentCenter;
    }
    return _shareLab;
}

-(UIView *)tabBarView
{
    if (_tabBarView ==nil) {
        _tabBarView =[[UIView alloc]initWithFrame:CGRectMake(0, Kheight-60, Kwidth, 60)];
        _tabBarView.backgroundColor =[UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];
    }
    return _tabBarView;
}
-(void)share
{
    NSLog(@"share button is click");
}
-(void)like
{
    NSLog(@"like button is click");
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
