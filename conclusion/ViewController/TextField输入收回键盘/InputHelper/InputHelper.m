//
//  InputHelper.m
//  InputHelper
//
//  Created by MaSong on 13-11-11.
//  Copyright (c) 2013年 MaSong. All rights reserved.
//

#import "InputHelper.h"
#import <objc/objc.h>
#import <objc/runtime.h>

static NSString *kInputHelperTapGusture= @"kInputHelperTapGusture";
static NSString *kInputHelperDismissType= @"kInputHelperDismissType";
static NSInteger tapTag = 2014;

static NSString *kInputHelperRootViewOriginalOriginY = @"kInputHelperRootViewOriginalOriginY";
static NSString *kInputHelperRootViewAllInputFieldOriginYDictionary = @"kInputHelperRootViewAllInputFieldOriginYDictionary";
static NSString *kInputHelperRootViewSortedInputFieldArray = @"kInputHelperRootViewSortedInputFieldArray";

static void setAssociatedObjectForKey(UIView *view ,NSString *key,id value){
    objc_setAssociatedObject(view, (__bridge  const void *)(key), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static id getAssociatedObjectForKey(UIView *view ,NSString *key) {
   return  objc_getAssociatedObject(view, (__bridge  const void *)(key));
}



@interface InputHelperTapGusture: UITapGestureRecognizer
@property (assign, nonatomic) NSInteger tag;
@end
@implementation InputHelperTapGusture
@end


@interface InputHelper ()

@property (strong, nonatomic) UIView *cleanMaskView;
@property (strong, nonatomic) UIToolbar *toolBarForCleanMaskView;


@property (strong, nonatomic) UIToolbar *toolBar;

@property (assign, nonatomic) CGSize keyboardSize;
@property (assign, nonatomic) CGFloat perMoveDistanceForInputField;

@property (assign, nonatomic) CGRect defaultToolBarFrame;
@property (assign, nonatomic) CGRect defaultMaskViewFrame;
@property (assign, nonatomic) CGRect toolBarFrameInMaskView;

//current root view
@property (weak, nonatomic) UIView *currentRootView;

@end


@implementation InputHelper

- (UIToolbar *)createInputHelperToolBar{
    
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:_defaultToolBarFrame];
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *btnPrevious = [[UIBarButtonItem alloc]initWithTitle:@"上一项" style:UIBarButtonItemStyleDone target:self action:@selector(didClickButtonPrevious)];
    UIBarButtonItem *btnNext = [[UIBarButtonItem alloc]initWithTitle:@"下一项" style:UIBarButtonItemStyleDone target:self action:@selector(didClickButtonNext)];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *btnDown = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(didClickButtonDone)];
    [toolBar setItems:[[NSArray alloc]initWithObjects:btnPrevious,btnNext,spaceItem,btnDown, nil]];
    return toolBar;
}


- (void)initilize
{
    
    _defaultToolBarFrame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 40);
    _defaultMaskViewFrame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    _toolBarFrameInMaskView = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 40, [[UIScreen mainScreen] bounds].size.width, 40);
    
    _perMoveDistanceForInputField = 40;
    
    _keyboardSize = CGSizeMake(320, 256);
    
    
    //tool bar
    self.toolBar = [self createInputHelperToolBar];
    
    self.toolBarForCleanMaskView = [self createInputHelperToolBar];
    _toolBarForCleanMaskView.frame = _toolBarFrameInMaskView;
    
    //tap mask view
    _cleanMaskView = [[UIView alloc]initWithFrame:_defaultMaskViewFrame];
    _cleanMaskView.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickButtonDone)];
    [_cleanMaskView addGestureRecognizer:tap];
    [_cleanMaskView addSubview:_toolBarForCleanMaskView];
    
    
    NSNotificationCenter *notifCenter = [NSNotificationCenter defaultCenter];
    
    [notifCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [notifCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    [notifCenter addObserver:self selector:@selector(updateFirstResponder:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [notifCenter addObserver:self selector:@selector(updateFirstResponder:) name:UITextFieldTextDidEndEditingNotification object:nil];
    [notifCenter addObserver:self selector:@selector(updateFirstResponder:) name:UITextViewTextDidBeginEditingNotification object:nil];
    [notifCenter addObserver:self selector:@selector(updateFirstResponder:) name:UITextViewTextDidEndEditingNotification object:nil];
    
    
    
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
        [self initilize];
    }
    return self;
}
+ (InputHelper *)sharedInputHelper{
    static InputHelper *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[InputHelper alloc]init];
    });
    return instance;
}

#pragma mark - APIs
- (void)setupInputHelperForView:(UIView *)view withDismissType:(InputHelperDismissType)dismissType{
    
    self.currentRootView = view;
    
    setAssociatedObjectForKey(view, kInputHelperDismissType, @(dismissType));
    
    NSMutableDictionary *dic= [NSMutableDictionary new];
    setAssociatedObjectForKey(view, kInputHelperRootViewAllInputFieldOriginYDictionary, dic);
    
    NSMutableArray *array = [NSMutableArray new];
    setAssociatedObjectForKey(view, kInputHelperRootViewSortedInputFieldArray, array);
    
    
    [self checkInputFieldInView:view withViewOriginY:view.frame.origin.y];
    
    
    
    NSArray *keys = [getAssociatedObjectForKey(view, kInputHelperRootViewAllInputFieldOriginYDictionary) allKeys];
    if (keys.count == 0) {
        return;
    }
    
    
    NSArray *sortedOriginYArray = [keys sortedArrayUsingComparator:^(id obj1, id obj2){
        if ([obj1 compare:obj2] == NSOrderedDescending){
            return NSOrderedDescending;
        }
        if ([obj1 compare:obj2] == NSOrderedAscending){
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];
    
    
    UIView *inputAccessoryView = _toolBar;
    
    if (dismissType == InputHelperDismissTypeNone) {
        
        _toolBar.frame = _defaultToolBarFrame;
        
    } else if (dismissType == InputHelperDismissTypeCleanMaskView){
        
        inputAccessoryView = _cleanMaskView;
        
    } else if (dismissType == InputHelperDismissTypeTapGusture){
        
        setAssociatedObjectForKey(view, kInputHelperTapGusture, kInputHelperTapGusture);
    }
    
    for (NSNumber *key in sortedOriginYArray){
        
        UIView *inputField = [getAssociatedObjectForKey(view, kInputHelperRootViewAllInputFieldOriginYDictionary) objectForKey:key];
        
        [getAssociatedObjectForKey(view, kInputHelperRootViewSortedInputFieldArray) addObject:inputField];
        
        if ([inputField isKindOfClass:[UITextField class]]) {
            
            ((UITextField *)inputField).inputAccessoryView = inputAccessoryView;
            
        } else if([inputField isKindOfClass:[UITextView class]]){
            
            ((UITextView *)inputField).inputAccessoryView = inputAccessoryView;
            
        } else if([inputField isKindOfClass:[UISearchBar class]]){
            
            ((UISearchBar *)inputField).inputAccessoryView = inputAccessoryView;
        }
        

    }
    
}

- (void)dismissInputHelper{
    [self didClickButtonDone];
}

- (void)updateFirstResponder:(NSNotification *)aNotification {
    
    [self updateButtonEnabledStateForInputField:[self getFirstResponder]];
}
#pragma mark -

- (void)checkInputFieldInView:(UIView *)view
              withViewOriginY:(CGFloat)y
{
    
    for (UIView *subView in view.subviews){
        
        if (subView.hidden == YES) {
            continue;
        }
        
        if ([subView isKindOfClass:[UITextField class]] ||
            [subView isKindOfClass:[UITextView class]] ||
            [subView isKindOfClass:[UISearchBar class]]) {
            
            NSNumber *key = [NSNumber numberWithFloat: y + subView.frame.origin.y];
            
            NSMutableDictionary *dic = getAssociatedObjectForKey(_currentRootView, kInputHelperRootViewAllInputFieldOriginYDictionary);
            [dic setObject:subView forKey:key];
            
        } else {
            [self checkInputFieldInView:subView
                        withViewOriginY:y + subView.frame.origin.y];
        }
    }
}



- (UIView *)getFirstResponder
{
    for (UIView *tf in getAssociatedObjectForKey(_currentRootView, kInputHelperRootViewSortedInputFieldArray)) {
        if ([tf isFirstResponder]) {
            return tf;
        }
    }
    return nil;
}

- (void)didClickButtonPrevious
{
    UIView *firstResponder = [self getFirstResponder];
    UIView *previousInputField = firstResponder;
    NSArray *sortedInputFields = getAssociatedObjectForKey(_currentRootView, kInputHelperRootViewSortedInputFieldArray);
    if (![firstResponder isEqual:[sortedInputFields firstObject]]) {
        previousInputField = [sortedInputFields objectAtIndex:[sortedInputFields indexOfObject:firstResponder] - 1];
        [previousInputField becomeFirstResponder];
    }
    
    [self updateButtonEnabledStateForInputField:previousInputField];
}

- (void)didClickButtonNext
{
    UIView *firstResponder = [self getFirstResponder];
    UIView *nextInputField = firstResponder;
    NSArray *sortedInputFields = getAssociatedObjectForKey(_currentRootView, kInputHelperRootViewSortedInputFieldArray);
    if (![firstResponder isEqual:[sortedInputFields lastObject]]) {
        nextInputField = [sortedInputFields objectAtIndex:[sortedInputFields indexOfObject:firstResponder] + 1];
        [nextInputField becomeFirstResponder];
    }
    
    
    [self updateButtonEnabledStateForInputField:nextInputField];
}

- (void)didClickButtonDone
{
    
    [[self getFirstResponder] resignFirstResponder];
    
    CGRect frame = _currentRootView.frame;
    frame.origin.y = [getAssociatedObjectForKey(_currentRootView, kInputHelperRootViewOriginalOriginY) floatValue];
    [UIView animateWithDuration:0.3f animations:^{
        _currentRootView.frame = frame;
    }];
}

- (void)updateButtonEnabledStateForInputField:(UIView *)inputField
{
    if (inputField) {
        NSInteger dismissType = [getAssociatedObjectForKey(_currentRootView, kInputHelperDismissType) integerValue];
        
        UIToolbar *toolBar = dismissType == InputHelperDismissTypeCleanMaskView ? _toolBarForCleanMaskView : _toolBar;
        UIBarButtonItem *previousBarItem = (UIBarButtonItem *)[[toolBar items] objectAtIndex:0];
        UIBarButtonItem *nextBarItem = (UIBarButtonItem *)[[toolBar items] objectAtIndex:1];
       NSArray *sortedInputFields = getAssociatedObjectForKey(_currentRootView, kInputHelperRootViewSortedInputFieldArray);
        [previousBarItem setEnabled:[inputField isEqual:[sortedInputFields firstObject]] ? NO : YES];
        [nextBarItem setEnabled:[inputField isEqual:[sortedInputFields lastObject]] ? NO : YES];
        [self animatedMoveRootViewForInputField:inputField];
    }
    
}

- (void)animatedMoveRootViewForInputField:(UIView *)inputField
{
    
    CGPoint windowPoint = [inputField.superview convertPoint:inputField.frame.origin toView:[[UIApplication sharedApplication]keyWindow]];
    CGFloat topY = 74.0f;
    CGFloat buttomY = [[UIScreen mainScreen]applicationFrame].size.height - _keyboardSize.height - 80;
    
    CGRect frame = _currentRootView.frame;
    if (windowPoint.y < topY ) {
        
        frame.origin.y +=  (1 + (int)((topY - windowPoint.y) / _perMoveDistanceForInputField)) * _perMoveDistanceForInputField;
        if (frame.origin.y > 0) {
            frame.origin.y = 0;
        }
        
    } else if (windowPoint.y > buttomY) {
        
        frame.origin.y -= ((1 + (int)((windowPoint.y - buttomY) / _perMoveDistanceForInputField)) * _perMoveDistanceForInputField);
    }
    
    [UIView animateWithDuration:0.3f animations:^{
        _currentRootView.frame = frame;
    }];
}

#pragma mark - Notification methods

- (void) keyboardWillShow:(NSNotification *) notif
{

    if (getAssociatedObjectForKey(_currentRootView, kInputHelperRootViewOriginalOriginY) == nil) {
        setAssociatedObjectForKey(_currentRootView, kInputHelperRootViewOriginalOriginY, @(_currentRootView.frame.origin.y));
    }
    
    
    NSString *str = getAssociatedObjectForKey(_currentRootView, kInputHelperTapGusture);
    
    BOOL hasAddGusture = NO;
    for(id gusture in _currentRootView.gestureRecognizers){
        if ([gusture isKindOfClass:[InputHelperTapGusture class]] && ((InputHelperTapGusture *)gusture).tag == tapTag) {
            hasAddGusture = YES;
            break;
        }
    }
    
    if ([str isEqualToString:kInputHelperTapGusture] && !hasAddGusture) {
        InputHelperTapGusture *tap = [[InputHelperTapGusture alloc]initWithTarget:self action:@selector(didClickButtonDone)];
        tap.tag = tapTag;
        [_currentRootView addGestureRecognizer:tap];
    }
   
    [self updateButtonEnabledStateForInputField:[self getFirstResponder]];
}

- (void) keyboardWillHide:(NSNotification *) notif
{
    
    NSString *str = getAssociatedObjectForKey(_currentRootView, kInputHelperTapGusture);
    
    if ([str isEqualToString:kInputHelperTapGusture]) {
        for(id gusture in _currentRootView.gestureRecognizers){
            if ([gusture isKindOfClass:[InputHelperTapGusture class]] && ((InputHelperTapGusture *)gusture).tag == tapTag) {
                [_currentRootView removeGestureRecognizer:gusture];
                break;
            }
        }
    }
    
}

@end


