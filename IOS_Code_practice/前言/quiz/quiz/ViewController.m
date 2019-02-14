//
//  ViewController.m
//  quiz
//
//  Created by admin on 2019/2/12.
//  Copyright © 2019年 sk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
// IBOutlet : 插座变量：指向一个对象的指针 ： 用于一个对象可以知道另一个对象在内存中的位置，从而使这两个对象可以协同工作
// IBOutlet 关键字告诉 Xcode之后会使用 Interface Builder关联该插座变量
@property (nonatomic,weak) IBOutlet UILabel *questionLabel;
@property (nonatomic,weak) IBOutlet UILabel *answerLabel;

// model object
@property (nonatomic,copy) NSArray *questions;
@property (nonatomic,copy) NSArray *answers;

@property (nonatomic) int currentQuestionIndex;
@end

@implementation ViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    // 调用父类实现的初始化方法
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.questions = @[@"What is 1+1?",@"What is 2+2?",@"What is 3+3?"];
        self.answers = @[@"2",@"4",@"6"];
    }
    // 返回新对象的地址
    return self;
}


- (IBAction)showQuestion:(id)sender {
    self.currentQuestionIndex++;
    if (self.currentQuestionIndex == [self.questions count]) {
        self.currentQuestionIndex = 0;
    }
    
    NSString *question = self.questions[self.currentQuestionIndex];
    self.questionLabel.text = question;
    
    // 重置答案字符串
    self.answerLabel.text = @"???";
}

- (IBAction)showAnswer:(id)sender {
    NSString *answer = self.answers[self.currentQuestionIndex];
    self.answerLabel.text = answer;
}

/*- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
*/

@end
