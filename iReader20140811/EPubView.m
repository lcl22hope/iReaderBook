//
//  EPubView.m
//
//  Created by line0 on 13-3-4.
//  Copyright (c) 2013年 wsk. All rights reserved.
//

#import "EPubView.h"
#import "EPubChapter.h"
#import <WebKit/WebKit.h>



@interface EPubView () <UIScrollViewDelegate, UIWebViewDelegate>
@property (assign, nonatomic) CGPoint touchBeginPoint;

@end


@implementation EPubView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];//
        _webView = [[UIWebView alloc] initWithFrame:self.bounds];
        _webView.delegate = self;
        _webView.scrollView.alwaysBounceHorizontal = YES;//如果设置为no 就不能进行翻页了，有没有解决方案呢？
//        _webView.scrollView.alwaysBounceVertical = NO;
        _webView.scrollView.bounces = YES;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.scrollView.delegate = self;
        _webView.scrollView.pagingEnabled = YES;//实现分页功能
//        _webView.scrollView.contentOffset = CGPointMake(_webView.scrollView.contentOffset.x, 0);
//        _webView.scrollView.contentSize = CGSizeMake(self.bounds.size.width,self.bounds.size.height);
//        _webView.scrollView.scrollEnabled = NO;
//        _webView.paginationMode = UIWebPaginationModeLeftToRight;
//        _webView.paginationMode = UIWebPaginationModeLeftToRight;
//        _webView.paginationBreakingMode = UIWebPaginationBreakingModePage;
//        _webView.gapBetweenPages = 50;
//        _webView.backgroundColor = [UIColor clearColor];
        _webView.scrollView.backgroundColor = [UIColor clearColor];
        _webView.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:230.0/255.0 blue:195.0/255.0 alpha:1.0];
        _webView.opaque = NO;
        [self addSubview:self.webView];
        
        _fontSize = 100;
        _next = YES;        
    }
    return self;
}

- (void)loadChapter:(EPubChapter *)chapter
{
//    NSLog(@"chapter.spinePath is %@",chapter.spinePath);
	NSURL *url = [NSURL fileURLWithPath:chapter.spinePath];
	[self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)gotoPage:(int)pageIndex
{
    _currentPageIndex = pageIndex;
    float pageOffset = pageIndex * self.webView.bounds.size.width;
    [self.webView.scrollView setContentOffset:CGPointMake(pageOffset, 0) animated:NO];;
}

- (void)setFontSize:(int)fontSize
{
    
    if(_fontSize <= 200 || _fontSize >= 50)
    {
        _fontSize = fontSize;
        [self loadChapter:self.chapter];
    }
}


#pragma mark - WebView Delegate Method


- (void)webViewDidFinishLoad:(UIWebView *)theWebView
{
	NSString *varMySheet = @"var mySheet = document.styleSheets[0];";
	NSString *addCSSRule =  @"function addCSSRule(selector, newRule) {"
	"if (mySheet.addRule) {"
	"mySheet.addRule(selector, newRule);"								// For Internet Explorer
	"} else {"
	"ruleIndex = mySheet.cssRules.length;"
	"mySheet.insertRule(selector + '{' + newRule + ';}', ruleIndex);"   // For Firefox, Chrome, etc.
	"}"
	"}";
	
	NSString *insertRule1 = [NSString stringWithFormat:@"addCSSRule('html', 'padding: 10px; height: %fpx; -webkit-column-gap: 20px; -webkit-column-width: %fpx;')", self.webView.frame.size.height - 20, self.webView.frame.size.width - 20];
	NSString *insertRule2 = [NSString stringWithFormat:@"addCSSRule('p', 'text-align: justify;')"];
	NSString *setTextSizeRule = [NSString stringWithFormat:@"addCSSRule('body', '-webkit-text-size-adjust: %d%%;')", _fontSize];
    
	[self.webView stringByEvaluatingJavaScriptFromString:varMySheet];
	[self.webView stringByEvaluatingJavaScriptFromString:addCSSRule];
	[self.webView stringByEvaluatingJavaScriptFromString:insertRule1];
	[self.webView stringByEvaluatingJavaScriptFromString:insertRule2];
	[self.webView stringByEvaluatingJavaScriptFromString:setTextSizeRule];
    
	int totalWidth = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.scrollWidth"] intValue];
	_pageCount = ceil(totalWidth / self.webView.bounds.size.width);
//    NSLog(@"pageCount is %d",_pageCount);
    _currentPageIndex = 0;
    if ([self.delegate respondsToSelector:@selector(epubViewLoadFinished)])
    {
        [self.delegate epubViewLoadFinished];
    }

}


#pragma mark - ScrollView Delegate Method

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    self.touchBeginPoint = scrollView.contentOffset;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth   = scrollView.frame.size.width;
    _currentPageIndex = ceil(scrollView.contentOffset.x / pageWidth);
    
    CGPoint touchEndPoint = scrollView.contentOffset;
    _next = self.touchBeginPoint.x > touchEndPoint.x + 5;

    if (!self.next)
    {
        if (_currentPageIndex == 0)
        {
            [self.delegate gotoPrevSpine];
        }
    }
    else
    {
        if(_currentPageIndex + 1 == _pageCount)
        {
            [self.delegate gotoNextSpine];
        }
    }        
}

// 禁止scrollView 垂直滚动的代码，水平同理
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
    [aScrollView setContentOffset: CGPointMake(aScrollView.contentOffset.x,0)];
//
}

@end
