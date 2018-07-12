//
//  ViewController.h
//  QRCodeReaderAndGenerator
//
//  Created by Parveen Akter on 7/12/18.
//  Copyright © 2018 Parveen Akter. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "QRCodeReaderDelegate.h"

@interface ViewController : UIViewController <QRCodeReaderDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageVIew;

@property (weak, nonatomic) IBOutlet UIButton *startBtn;

@end

