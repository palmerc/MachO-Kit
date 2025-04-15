//----------------------------------------------------------------------------//
//|
//|             MachOKit - A Lightweight Mach-O Parsing Library
//|             MKMachO+SplitSegment.m
//|
//|             D.V.
//|             Copyright (c) 2014-2015 D.V. All rights reserved.
//|
//| Permission is hereby granted, free of charge, to any person obtaining a
//| copy of this software and associated documentation files (the "Software"),
//| to deal in the Software without restriction, including without limitation
//| the rights to use, copy, modify, merge, publish, distribute, sublicense,
//| and/or sell copies of the Software, and to permit persons to whom the
//| Software is furnished to do so, subject to the following conditions:
//|
//| The above copyright notice and this permission notice shall be included
//| in all copies or substantial portions of the Software.
//|
//| THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
//| OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//| MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//| IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
//| CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
//| TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
//| SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//----------------------------------------------------------------------------//

#import "MKMachO+SplitSegment.h"
#import "MKInternal.h"

#import "MKSplitSegmentInfo.h"

//----------------------------------------------------------------------------//
@implementation MKMachOImage (SplitSegment)

//◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦//
#pragma mark -  Split Segment Information
//◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦//

//|++++++++++++++++++++++++++++++++++++|//
- (MKResult*)splitSegmentInfo
{
    if (_splitSegment == nil)
    {
        NSError *splitSegmentInfoError = nil;
        
        MKSplitSegmentInfo *splitSegmentInfo = [[MKSplitSegmentInfo alloc] initWithParent:self error:&splitSegmentInfoError];
        if (splitSegmentInfo)
            _splitSegment = [[MKResult alloc] initWithValue:splitSegmentInfo];
        else if (splitSegmentInfoError /* Only failed if we have an error */)
            _splitSegment = [[MKResult alloc] initWithError:splitSegmentInfoError];
        else
            _splitSegment = [MKResult new];
        
        [splitSegmentInfo release];
    }
    
    return _splitSegment;
}

//◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦//
#pragma mark -  MKNode
//◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦//

//|++++++++++++++++++++++++++++++++++++|//
+ (MKNodeFieldBuilder*)_splitSegmentInfoFieldBuilder
{
    MKNodeFieldBuilder *splitSegmentInfo = [MKNodeFieldBuilder
        builderWithProperty:MK_PROPERTY(splitSegmentInfo)
        type:[MKNodeFieldTypeNode typeWithNodeType:MKSplitSegmentInfo.class]
    ];
    splitSegmentInfo.description = @"Split Segment Info";
    splitSegmentInfo.options = MKNodeFieldOptionDisplayAsChild;
    
    return splitSegmentInfo;
}

@end
