//
//  EGORefreshTableHeaderView.m
//  Demo
//
//  Created by Devin Doty on 10/14/09October14.
//  Copyright 2009 enormego. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "EGORefreshTableHeaderView.h"
#import "NSUserDefaults+Addition.h"

#define SHADOW_OFFSET CGSizeMake(0, 1)
#define TEXT_FONT   [UIFont boldSystemFontOfSize:14.0f]
#define CONTENT_INSET_TOP 60.0f
#define LABEL_HEIGHT (CONTENT_INSET_TOP + 15.0f)

@interface EGORefreshTableHeaderView()

@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) UILabel *statusLabel;

- (void)setState:(EGOPullRefreshState)aState;

@end

@implementation EGORefreshTableHeaderView

@synthesize delegate = _delegate;
@synthesize activityView = _activityView;
@synthesize statusLabel = _statusLabel;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		self.backgroundColor = [UIColor clearColor];
		
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - CONTENT_INSET_TOP, self.frame.size.width, LABEL_HEIGHT)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = TEXT_FONT;
        label.shadowOffset = SHADOW_OFFSET;
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = UITextAlignmentCenter;
		[self addSubview:label];
		self.statusLabel = label;
        
		UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        view.center = CGPointMake(35.0f, label.center.y);
		[self addSubview:view];
		self.activityView = view;
		
		[self setState:EGOOPullRefreshNormal];
		
        [self configureLableUIStyle];
    }
    return self;
}

- (void)configureLableUIStyle {
    UIStyle style = [NSUserDefaults getCurrentUIStyle];
    if(style == UIStyleBlackChocolate){
        self.statusLabel.textColor = [UIColor whiteColor];
        self.statusLabel.shadowColor = [UIColor blackColor];
        self.activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    } else if(style == UIStyleWhiteChocolate) {
        self.statusLabel.textColor = [UIColor darkGrayColor];
        self.statusLabel.shadowColor = [UIColor whiteColor];
        self.activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    }
}

#pragma mark -
#pragma mark Setters

- (void)setState:(EGOPullRefreshState)aState{
	
	switch (aState) {
		case EGOOPullRefreshPulling:
			
			self.statusLabel.text = NSLocalizedString(@"松开即刷新...", @"松开以刷新状态");
			break;
		case EGOOPullRefreshNormal:			
			self.statusLabel.text = NSLocalizedString(@"下拉以刷新...", @"下拉以刷新状态");
			[self.activityView stopAnimating];
			
			break;
		case EGOOPullRefreshLoading:
			
			self.statusLabel.text = NSLocalizedString(@"请稍等...", @"载入状态");
			[self.activityView startAnimating];
			break;
		default:
			break;
	}
	
	_state = aState;
}


#pragma mark -
#pragma mark ScrollView Methods

- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView {	
	
	if (_state == EGOOPullRefreshLoading) {
		
		//CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
		//offset = MIN(offset, 60.0f);
		//scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
		
	} else if (scrollView.isDragging) {
		
		BOOL _loadingFlag = NO;
		if ([self.delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)]) {
			_loadingFlag = [self.delegate egoRefreshTableHeaderDataSourceIsLoading:self];
		}
		
		if (_state == EGOOPullRefreshPulling && scrollView.contentOffset.y > -70.0f && scrollView.contentOffset.y < 0.0f && !_loadingFlag) {
			[self setState:EGOOPullRefreshNormal];
		} else if (_state == EGOOPullRefreshNormal && scrollView.contentOffset.y < -90.0f && !_loadingFlag) {
			[self setState:EGOOPullRefreshPulling];
		}
		
		if (scrollView.contentInset.top != 0) {
			scrollView.contentInset = UIEdgeInsetsZero;
		}
		
	}
	
}

- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
	
	BOOL _loadingFlag = NO;
	if ([self.delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)]) {
		_loadingFlag = [self.delegate egoRefreshTableHeaderDataSourceIsLoading:self];
	}
	if (_state == EGOOPullRefreshPulling && !_loadingFlag) {
		if ([self.delegate respondsToSelector:@selector(egoRefreshTableHeaderDidTriggerRefresh:)]) {
			[self.delegate egoRefreshTableHeaderDidTriggerRefresh:self];
		}
        [self setState:EGOOPullRefreshLoading];
        [UIView animateWithDuration:.2 animations:^(void) {
                             scrollView.contentInset = UIEdgeInsetsMake(CONTENT_INSET_TOP, 0.0f, 0.0f, 0.0f);}];		
	}
}

- (void)egoRefreshScrollViewDataSourceDidFinishedLoading {	
	[self setState:EGOOPullRefreshNormal];
}

@end
