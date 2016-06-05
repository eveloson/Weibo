//
//  OAuthViewController.m
//  Weibo
//
//  Created by BinWu on 16/6/5.
//  Copyright © 2016年 c2012y@qq.com. All rights reserved.
//

#import "OAuthViewController.h"
#import <AFNetworking.h>
@interface OAuthViewController () <WeiboSDKDelegate,UIWebViewDelegate>
@end

@implementation OAuthViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    WLog(@"%@",change);
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    webView.delegate = self;
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=4241570953&redirect_uri=http://itebook.cc"];
    [webView addObserver:self forKeyPath:@"request" options:nil context:nil];
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
        WLog(@"find %@",urlStr);
        unsigned long locate = range.location + range.length;
        NSString *code = [urlStr substringFromIndex:locate];
        
    }
    return YES;
}


@end
