//
//  ViewController.m
//  QRCodeReaderAndGenerator
//
//  Created by Parveen Akter on 7/12/18.
//  Copyright © 2018 Parveen Akter. All rights reserved.
//

#import "ViewController.h"
#import "QRCodeGenerator.h"
#import "QRCodeReaderViewController.h"
#import "QRCodeReader.h"
@interface ViewController (){
 //   UIImageView*imageView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    QRCodeGenerator *qr = [[QRCodeGenerator alloc] initWithString:@"Hello World"];
    qr.size = CGSizeMake(400.0f, 400.0f); // 400x400 size
    qr.color = [CIColor colorWithRGBA:@"#FFFFFF"]; // white QR Code color
    qr.backgroundColor = [CIColor colorWithRGBA:@"#000000"]; // black background color
    
    _imageVIew.image = [qr getImage];
}
- (IBAction)startScanFn:(UIButton *)sender {
    if ([QRCodeReader supportsMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]]) {
        static QRCodeReaderViewController *vc = nil;
        static dispatch_once_t onceToken;
        
        dispatch_once(&onceToken, ^{
            QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
            vc                   = [QRCodeReaderViewController readerWithCancelButtonTitle:@"Cancel" codeReader:reader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];
            vc.modalPresentationStyle = UIModalPresentationFormSheet;
        });
        vc.delegate = self;
        
        [vc setCompletionWithBlock:^(NSString *resultAsString) {
            NSLog(@"Completion with result: %@", resultAsString);
        }];
        
        [self presentViewController:vc animated:YES completion:NULL];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Reader not supported by the current device" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
}

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [reader stopScanning];
    
    [self dismissViewControllerAnimated:YES completion:^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"QRCodeReader" message:result delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
