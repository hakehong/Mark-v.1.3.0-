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
@interface DetailViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.webView];
    // Do any additional setup after loading the view.
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
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, Kwidth, Kheight -64)];
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
    }];
    
    
}
-(void)setMovieDetail:(CycleMovie *)movieDetail
{
    
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
