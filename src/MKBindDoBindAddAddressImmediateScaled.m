//----------------------------------------------------------------------------//
//|
//|             MachOKit - A Lightweight Mach-O Parsing Library
//|             MKBindDoBindAddAddressImmediateScaled.m
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

#import "MKBindDoBindAddAddressImmediateScaled.h"
#import "MKInternal.h"

//----------------------------------------------------------------------------//
@implementation MKBindDoBindAddAddressImmediateScaled

//|++++++++++++++++++++++++++++++++++++|//
+ (uint8_t)opcode
{ return BIND_OPCODE_DO_BIND_ADD_ADDR_IMM_SCALED; }

//|++++++++++++++++++++++++++++++++++++|//
+ (NSString*)name
{ return @"BIND_OPCODE_DO_BIND_ADD_ADDR_IMM_SCALED"; }

//|++++++++++++++++++++++++++++++++++++|//
+ (uint32_t)canInstantiateWithOpcode:(uint8_t)opcode immediate:(uint8_t)immediate
{
#pragma unused (immediate)
    if (self != MKBindDoBindAddAddressImmediateScaled.class)
        return 0;
    
    return opcode == [self opcode] ? 10 : 0;
}

//◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦//
#pragma mark -  Performing Binding
//◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦//

//|++++++++++++++++++++++++++++++++++++|//
- (BOOL)bind:(void (^)(void))binder withContext:(struct MKBindContext*)bindContext error:(NSError**)error
{
    // TODO - Unclear if this command can appear when using threaded binds.
    
    binder();
    
    mk_error_t err;
    if ((err = mk_vm_offset_add(bindContext->derivedOffset, self.derivedOffset, &bindContext->derivedOffset))) {
        MK_ERROR_OUT = MK_MAKE_VM_OFFSET_ADD_ARITHMETIC_ERROR(err, bindContext->derivedOffset, self.derivedOffset);
        return NO;
    }
    
    // Reset
    bindContext->command = nil;
    
    return YES;
}

//|++++++++++++++++++++++++++++++++++++|//
- (BOOL)weakBind:(void (^)(void))binder withContext:(struct MKBindContext*)bindContext error:(NSError**)error
{ return [self bind:binder withContext:bindContext error:error]; }

//|++++++++++++++++++++++++++++++++++++|//
- (BOOL)lazyBind:(void (^)(void))binder withContext:(struct MKBindContext*)bindContext error:(NSError**)error
{
#pragma unused(binder)
#pragma unused(bindContext)
    // Lazy bindings only use BIND_OPCODE_DO_BIND.  This command should
    // never appear in a lazy binding.
    MK_ERROR_OUT = [NSError mk_errorWithDomain:MKErrorDomain code:MK_EINVALID_DATA description:@"Unexpected BIND_OPCODE_DO_BIND_ADD_ADDR_IMM_SCALED opcode in a lazy binding."];
    
    return NO;
}

//◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦//
#pragma mark -  Bind Command Values
//◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦//

//|++++++++++++++++++++++++++++++++++++|//
- (uint8_t)scale
{ return _data & BIND_IMMEDIATE_MASK; }

//|++++++++++++++++++++++++++++++++++++|//
- (uint64_t)derivedOffset
{ return (self.scale * self.dataModel.pointerSize) + self.dataModel.pointerSize; }

//◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦//
#pragma mark -  MKNode
//◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦//

//|++++++++++++++++++++++++++++++++++++|//
- (mk_vm_size_t)nodeSize
{ return 1; }

//|++++++++++++++++++++++++++++++++++++|//
- (MKNodeDescription*)layout
{
    MKNodeFieldBuilder *scale = [MKNodeFieldBuilder
        builderWithProperty:MK_PROPERTY(scale)
        type:[MKNodeFieldTypeBitfield bitfieldWithType:MKNodeFieldTypeUnsignedByte.sharedInstance mask:@((uint8_t)BIND_IMMEDIATE_MASK) name:nil]
        offset:0
        size:sizeof(uint8_t)
    ];
    scale.description = @"Scale";
    scale.options = MKNodeFieldOptionDisplayAsDetail;
    
    return [MKNodeDescription nodeDescriptionWithParentDescription:super.layout fields:@[
        scale.build
    ]];
}

//◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦//
#pragma mark -  NSObject
//◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦◦//

//|++++++++++++++++++++++++++++++++++++|//
- (NSString*)description
{ return [NSString stringWithFormat:@"%@(0x%.8" PRIX64 ")", self.class.name, self.derivedOffset]; }

@end
