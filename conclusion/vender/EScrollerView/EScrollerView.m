//
//  EScrollerView.m
//  icoiniPad
//
//  Created by Ethan on 12-11-24.
//
//

#import "EScrollerView.h"
#import "UIImageView+WebCache.h"
#import "Consts.h"
#import "NSString+Helper.h"

@implementation EScrollerView
@synthesize delegate;

-(id)initWithFrameRect:(CGRect)rect ImageArray:(NSArray *)imgArr TitleArray:(NSArray *)titArr
{
    
	if ((self=[super initWithFrame:rect])) {
        self.userInteractionEnabled=YES;
        titleArray=titArr;
        NSMutableArray *tempArray=[NSMutableArray arrayWithArray:imgArr];
        [tempArray insertObject:[imgArr objectAtIndex:([imgArr count]-1)] atIndex:0];
        [tempArray addObject:[imgArr objectAtIndex:0]];
		imageArray=[NSArray arrayWithArray:tempArray];
		viewSize=rect;
        
        [self loadMainView];
	}
	return self;
}
-(void)loadMainView
{
    NSUInteger pageCount=[imageArray count];
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, viewSize.size.width, viewSize.size.height)];
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(viewSize.size.width * pageCount, viewSize.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    for (int i=0; i<pageCount; i++) {
        NSString *imgURL=[imageArray objectAtIndex:i];
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(viewSize.size.width*i, 0,viewSize.size.width, viewSize.size.height)];
        if ([imgURL hasPrefix:@"http://"]) {
            [imgView setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:PLACEHOLDER_IMAGE]];
        }
        else
        {
            
            UIImage *img=[UIImage imageNamed:[imageArray objectAtIndex:i]];
            [imgView setImage:img];
        }
        
        imgView.tag=i;
        UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)];
        [Tap setNumberOfTapsRequired:1];
        [Tap setNumberOfTouchesRequired:1];
        imgView.userInteractionEnabled=YES;
        [imgView addGestureRecognizer:Tap];
        [scrollView addSubview:imgView];
    }
    [scrollView setContentOffset:CGPointMake(viewSize.size.width, 0)];
    [self addSubview:scrollView];
    
    
    
    //说明文字层
    UIView *noteView=[[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-33,self.bounds.size.width,33)];
    [noteView setBackgroundColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.5]];
    
    float pageControlWidth=(pageCount-2)*10.0f+40.f;
    float pagecontrolHeight=20.0f;
    pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake((self.frame.size.width-pageControlWidth),6, pageControlWidth, pagecontrolHeight)];
    pageControl.currentPage=0;
    pageControl.numberOfPages=(pageCount-2);
    [noteView addSubview:pageControl];
    
//    noteTitle=[[UILabel alloc] initWithFrame:CGRectMake(5, 6, self.frame.size.width-pageControlWidth-15, 20)];
//    [noteTitle setText:[titleArray objectAtIndex:0]];
//    [noteTitle setBackgroundColor:[UIColor clearColor]];
//    [noteTitle setFont:[UIFont systemFontOfSize:13]];
//    [noteView addSubview:noteTitle];
//    
    [self addSubview:noteView];
}

- (void)startScrolling
{
    [self stopScrolling];
    _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(updateScroll) userInfo:nil repeats:YES];
}

- (void)stopScrolling
{
    [_scrollTimer invalidate];
    _scrollTimer = nil;
    
    
}
- (void)updateScroll
{
    CGFloat pointChange = viewSize.size.width;
    CGPoint newOffset = scrollView.contentOffset;
    
    if (currentPageIndex==([imageArray count]-2)) {
        newOffset.x = pointChange;
        scrollView.contentOffset = newOffset;
    }
    else
    {
        newOffset.x = newOffset.x + pointChange;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        scrollView.contentOffset = newOffset;
        [UIView commitAnimations];
    }
    
}
- (void)willMoveToWindow:(UIWindow *)newWindow
{
    scrollView.pagingEnabled = YES;
    [super willMoveToWindow:newWindow];
    if(newWindow)
    {
        [scrollView.panGestureRecognizer addTarget:self action:@selector(gestureDidChange:)];
        [scrollView.pinchGestureRecognizer addTarget:self action:@selector(gestureDidChange:)];
    }
    else
    {
        [self stopScrolling];
        [scrollView.panGestureRecognizer removeTarget:self action:@selector(gestureDidChange:)];
        [scrollView.pinchGestureRecognizer removeTarget:self action:@selector(gestureDidChange:)];
    }
}
- (void)gestureDidChange:(UIGestureRecognizer *)gesture
{
    switch (gesture.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            [self stopScrolling];
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            [self startScrolling];
            if (currentPageIndex==([imageArray count]-1)) {
                [scrollView setContentOffset:CGPointMake(viewSize.size.width, 0)];
            }
            
        }
        default:
            break;
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    currentPageIndex=page;
       
    pageControl.currentPage=(page-1);
    int titleIndex=page-1;
    if (titleIndex==[titleArray count]) {
        titleIndex=0;
    }
    if (titleIndex<0) {
        titleIndex=[titleArray count]-1;
    }
    [noteTitle setText:[titleArray objectAtIndex:titleIndex]];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView
{
    if (currentPageIndex==0) {
      
        [_scrollView setContentOffset:CGPointMake(([imageArray count]-2)*viewSize.size.width, 0)];
    }
    if (currentPageIndex==([imageArray count]-1)) {
       
        [_scrollView setContentOffset:CGPointMake(viewSize.size.width, 0)];
        
    }

}
- (void)imagePressed:(UITapGestureRecognizer *)sender
{

    if ([delegate respondsToSelector:@selector(EScrollerViewDidClicked:)]) {
        [delegate EScrollerViewDidClicked:sender.view.tag];
    }
}

@end
