//
//  SecondViewController.m
//  Lifx-ObjC
//
//  Created by Jordan Zucker on 2/1/14.
//  Copyright (c) 2014 Jordan Zucker. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _lightWebView.delegate = self;
//    NSString *address = @"http://www.google.com";
//    NSURL *urlWithAddress = [NSURL URLWithString:address];
//    NSURL *internalWebsite = [NSURL ]
//    NSURLRequest *request = [NSURLRequest requestWithURL:urlWithAddress];
//    [_lightWebView loadRequest:request];
    // Load the html as a string from the file system
    
    
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
//    NSString *html = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    
//    // Tell the web view to load it
//    [_lightWebView loadHTMLString:html baseURL:[[NSBundle mainBundle] bundleURL]];
    
//    NSLog(@"%@", [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"www"]);
//    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"www"]];
    [_lightWebView loadRequest:[NSURLRequest requestWithURL:url]];
    _lightWebView.scrollView.scrollEnabled = NO;
    _lightWebView.scrollView.bounces = NO;
    
    
    //[_lightWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://10.0.1.63:8000"]]];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"did start load");
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"did finish");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"did fail");
}


@end
