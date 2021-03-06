//
//  EGORefreshTableHeaderView.h
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

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "EGOViewCommon.h"

typedef enum {
    EGOPullOrientationDown = 0, /* Pull Down */
    EGOPullOrientationUp,       /* Pull Up */
    EGOPullOrientationRight,    /* Pull Right */
    EGOPullOrientationLeft,     /* Pull Left */
}EGOPullOrientation;

//typedef enum{
//	EGOOPullRefreshPulling = 0,
//	EGOOPullRefreshNormal,
//	EGOOPullRefreshLoading,
//} EGOPullRefreshState;

@protocol EGORefreshTableHeaderDelegate;
@interface EGORefreshTablLeftView : UIView {
	
	id _delegate;
	EGOPullRefreshState _state;
    EGOPullOrientation _orientation;
    
    UIScrollView* _scrollView;
    
    BOOL _pagingEnabled;
    
	UILabel *_lastUpdatedLabel;
//	UILabel *_statusLabel;
	CALayer *_arrowImage;
//	UIActivityIndicatorView *_activityView;
}
@property(nonatomic,assign) id <EGORefreshTableHeaderDelegate> delegate;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
- (id)initWithScrollView:(UIScrollView* )scrollView orientation:(EGOPullOrientation)orientation;
/** 来源于场景样例 */
- (id)initFromSceneWithScrollView:(UIScrollView* )scrollView orientation:(EGOPullOrientation)orientation;
- (void)adjustPosition;

- (void)refreshLastUpdatedDate;
- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end
@protocol EGORefreshTableHeaderDelegate
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTablLeftView*)view;
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTablLeftView*)view;
@optional
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTablLeftView*)view;
@end
