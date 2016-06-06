//
//  OAuthViewController.m
//  Weibo
//
//  Created by BinWu on 16/6/5.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import "OAuthViewController.h"

#import "Account.h"
#import "WeiboTool.h"
#import "AccountTool.h"
#import "MBProgressHUD+WB.h"
@interface OAuthViewController () <WeiboSDKDelegate,UIWebViewDelegate>
@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    webView.delegate = self;
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=4241570953&redirect_uri=http://itebook.cc"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];

}
- (void)SSOAuthorize{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    request.userInfo = @{
                         @"123":@"asda",
                         @"231":@"asd"
                         };
    
    [WeiboSDK sendRequest:request];

}

- (void)OAuthorize{
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare]];
    request.userInfo = @{
                         @"123":@"456"
                         };
    [WeiboSDK sendRequest:request];
}
- (WBMessageObject *)messageToShare{
    WBMessageObject *message = [WBMessageObject message];
    message.text = @"test";
    return message;
}
#pragma mark webView代理
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    WLog(@"%@",response.requestUserInfo);
}

/**
 *  当webView发送任何一个请求之前都会先调用这个方法，询问代理是否加载发送这个请求
 *  @param request        征询要发送的请求
 *  @return
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlStr = request.URL.absoluteString;
    //查找code＝在uslStr中的范围
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length) {
        unsigned long locate = range.location + range.length;
        NSString *code = [urlStr substringFromIndex:locate];
        //发送post请求给新浪，通过code换取一个accessToken
        [self accessTokenWithCode:code];
    }
    return YES;
}
/**
 *  client_id	true	string	申请应用时分配的AppKey。
 client_secret	true	string	申请应用时分配的AppSecret。
 grant_type	true	string	请求的类型，填写authorization_code
 
 grant_type为authorization_code时
 code	true	string	调用authorize获得的code值。
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。

 *
 *  @param code <#code description#>
 */
- (void)accessTokenWithCode:(NSString *)code{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"]     = @"4241570953";
    params[@"client_secret"] = @"fa6b26dcd8caf8eb4f2b057b3fb338dd";
    params[@"grant_type"]    = @"authorization_code";
    params[@"code"]          = code;
    params[@"redirect_uri"]  = @"http://itebook.cc";
    //3.发送请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
    //4.将字典转为模型
        Account *account = [Account accountWithDict:responseObject];
    
    //5.存储模型数据
        [AccountTool saveAccount:account];
    //6.新特性／去首页
        [WeiboTool chooseRootController];
    //7.隐藏HUD
        [MBProgressHUD hideHUD];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
    }];

}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"正在加载中..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUD];
}
//2016-06-05 19:54:01.151 Weibo[50776:2015530] 请求成功:{
//    "access_token" = "2.00htvFTBj3MDdEdb34816d9eR6SlpC";
//    "expires_in" = 157679999;
//    "remind_in" = 157679999;
//    uid = 1346060777;
//}
//返回数据
//{
//    "access_token": "ACCESS_TOKEN",  能让某个应用访问某个用户的数据
//    "expires_in": 1234,
//    "remind_in":"798114",
//    "uid":"12341234"
//}
//
//返回值字段	字段类型	字段说明
//access_token	string	用户授权的唯一票据，用于调用微博的开放接口，同时也是第三方应用验证微博用户登录的唯一票据，第三方应用应该用该票据和自己应用内的用户建立唯一影射关系，来识别登录状态，不能使用本返回值里的UID字段来做登录识别。
//expires_in	string	access_token的生命周期，单位是秒数。
//remind_in	string	access_token的生命周期（该参数即将废弃，开发者请使用expires_in）。
//uid	string	授权用户的UID，本字段只是为了方便开发者，减少一次user/show接口调用而返回的，第三方应用不能用此字段作为用户登录状态的识别，只有access_token才是用户授权的唯一票据。

@end
