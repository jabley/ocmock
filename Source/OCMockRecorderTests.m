//---------------------------------------------------------------------------------------
//  $Id: MKConsoleWindow.h,v 1.4 2004/02/15 18:55:05 erik Exp $
//  Copyright (c) 2004 by Mulle Kybernetik. See License file for details.
//---------------------------------------------------------------------------------------

#import "OCMockRecorderTests.h"
#import "OCMockRecorder.h"


@implementation OCMockRecorderTests

- (void)setUp
{
	NSMethodSignature *signature;

	signature = [NSString instanceMethodSignatureForSelector:@selector(initWithString:)];
	testInvocation = [NSInvocation invocationWithMethodSignature:signature];
	[testInvocation setSelector:@selector(initWithString:)];
}


- (void)testStoresAndMatchesInvocation
{
	OCMockRecorder *recorder;
	NSString				 *arg;
	
	arg = @"I love mocks.";
	[testInvocation setArgument:&arg atIndex:2];
	
	recorder = [[[OCMockRecorder alloc] initWithClass:[NSString class]] autorelease];
	[(id)recorder initWithString:arg];

	STAssertTrue([recorder matchesInvocation:testInvocation], @"Should match.");
}


- (void)testOnlyMatchesInvocationWithRightArguments
{
	OCMockRecorder *recorder;
	NSString				 *arg;
	
	arg = @"I love mocks.";
	[testInvocation setArgument:&arg atIndex:2];
	
	recorder = [[[OCMockRecorder alloc] initWithClass:[NSString class]] autorelease];
	[(id)recorder initWithString:@"whatever"];
	
	STAssertFalse([recorder matchesInvocation:testInvocation], @"Should not match.");
}


- (void)testSetsUpReturnValueInInvocation
{
	OCMockRecorder *recorder;
	NSString				 *result;

	recorder = [[[OCMockRecorder alloc] initWithClass:[NSString class]] autorelease];
	[recorder andReturn:@"foo"];
	[recorder setUpReturnValue:testInvocation];
	[testInvocation getReturnValue:&result];
	
	STAssertEqualObjects(result, @"foo", @"Should have set up right return value.");
}


@end