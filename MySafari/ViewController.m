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
@property (weak, nonatomic) IBOutlet UIButton *onBackButtonPressed;
@property (weak, nonatomic) IBOutlet UIButton *onForwardButtonPressed;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeURLRequestWithString:@"http://www.google.com"];
}

-(BOOL)textFieldShouldReturn:(UITextField *)urlTextField{
    NSString *urlString = urlTextField.text;
    
    BOOL hasPrefix = ([urlString hasPrefix:@"http://"]) || ([urlString hasPrefix:@"https://"]);
    
    if (hasPrefix == YES) {
        [self makeURLRequestWithString:urlString];
        
    } else {
        NSString *newURLString = [NSString stringWithFormat:@"http://%@", urlString];
        [self makeURLRequestWithString:newURLString];
    }
    return self;
}

//method we created
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
    if ([webView canGoBack]){
        [self.onBackButtonPressed setEnabled:YES];
    } else{
        
        [self.onBackButtonPressed setEnabled:NO];
    }
    if ([webView canGoForward]){
        [self.onForwardButtonPressed setEnabled:YES];
    } else{
        
        [self.onForwardButtonPressed setEnabled:NO];
    }
}

- (IBAction)onBackButtonPressed:(UIButton *)sender {
    [self.webView goBack];
}

- (IBAction)onForwardButtonPressed:(UIButton *)sender {
    [self.webView goForward];
}

- (IBAction)onStopLoadingButtonPressed:(UIButton *)sender {
    [self.webView stopLoading];
}
- (IBAction)onReloadButtonPressed:(UIButton *)sender {
    [self.webView reload];
}

- (IBAction)comingSoonWhenPressed:(UIButton *)sender {
   
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Coming Soon" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:cancelButton];
    
    [self presentViewController:alertController animated:TRUE completion:nil];
}



@end
