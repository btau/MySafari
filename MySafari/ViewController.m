//
//  ViewController.m
//  MySafari
//
//  Created by Brett Tau on 1/12/16.
//  Copyright © 2016 Brett Tau. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeURLRequestWithString:@"http://www.cnn.com"];
}

-(BOOL)textFieldShouldReturn:(UITextField *)urlTextField{
    [self makeURLRequestWithString:urlTextField.text];
    return true;
}

-(void)makeURLRequestWithString:(NSString *)string {
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [self.spinner startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.spinner stopAnimating];
}

- (IBAction)onBackButtonPressed:(id)sender {
    [self.webView goBack];
}


@end
