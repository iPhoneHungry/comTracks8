//
//  MacStreamingPlayerController.m
//  MacStreamingPlayer
//
//  Created by Matt Gallagher on 28/10/08.
//  Copyright Matt Gallagher 2008. All rights reserved.
//
//  This software is provided 'as-is', without any express or implied
//  warranty. In no event will the authors be held liable for any damages
//  arising from the use of this software. Permission is granted to anyone to
//  use this software for any purpose, including commercial applications, and to
//  alter it and redistribute it freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//     claim that you wrote the original software. If you use this software
//     in a product, an acknowledgment in the product documentation would be
//     appreciated but is not required.
//  2. Altered source versions must be plainly marked as such, and must not be
//     misrepresented as being the original software.
//  3. This notice may not be removed or altered from any source
//     distribution.
//

#import "MixPlayerController.h"
#import "MixStreamer.h"
#import <QuartzCore/CoreAnimation.h>

@implementation MixPlayerController
@synthesize mixAudioUrl;

- (void)awakeFromNib
{
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(createStreamer:)
                                                 name:@"Play Mix"
                                               object:nil];
}


-(void)setButtonImage:(NSImage *)image
{/*
	[button.layer removeAllAnimations];
	if (!image)
	{
		[button setImage:[NSImage imageNamed:@"playbutton"]];
	}
	else
	{
		[button setImage:image];
		
		if ([button.image isEqual:[NSImage imageNamed:@"loadingbutton"]])
		{
			[self spinButton];
		}
	}
  */
}


- (void)destroyStreamer
{
	if (streamer)
	{
		[[NSNotificationCenter defaultCenter]
			removeObserver:self
			name:ASStatusChangedNotification
			object:streamer];
		[progressUpdateTimer invalidate];
		progressUpdateTimer = nil;
		
		[streamer stop];
		
		streamer = nil;
	}
}


- (void)createStreamer:(NSNotification *)urlNotify
{
    
    NSLog(@"creating streamer");
    mixAudioUrl = [[urlNotify userInfo] objectForKey:@"urlString"];
    
	if (streamer)
	{
		[self destroyStreamer];
	}

	
	
	NSString *escapedValue = mixAudioUrl;
    NSLog(@"play url is %@",escapedValue);
	NSURL *url = [NSURL URLWithString:escapedValue];
	streamer = [[MixStreamer alloc] initWithURL:url];
	[streamer start];
	progressUpdateTimer =
		[NSTimer
			scheduledTimerWithTimeInterval:0.1
			target:self
			selector:@selector(updateProgress:)
			userInfo:nil
			repeats:YES];
	[[NSNotificationCenter defaultCenter]
		addObserver:self
		selector:@selector(playbackStateChanged:)
		name:ASStatusChangedNotification
		object:streamer];
}


- (void)spinButton
{
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
	//CGRect frame = NSRectToCGRect([button frame]);
	//button.layer.anchorPoint = CGPointMake(0.5, 0.5);
//	button.layer.position = CGPointMake(frame.origin.x + 0.5 * frame.size.width, frame.origin.y + 0.5 * frame.size.height);
	[CATransaction commit];

	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
	[CATransaction setValue:[NSNumber numberWithFloat:2.0] forKey:kCATransactionAnimationDuration];

	CABasicAnimation *animation;
	animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	animation.fromValue = [NSNumber numberWithFloat:0.0];
	animation.toValue = [NSNumber numberWithFloat:-2 * M_PI];
	animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
	animation.delegate = self;
	//rezand [button.layer addAnimation:animation forKey:@"rotationAnimation"];

	[CATransaction commit];
}

//
// animationDidStop:finished:
//
// Restarts the spin animation on the button when it ends. Again, this is
// largely irrelevant now that the audio is loaded from a local file.
//
// Parameters:
//    theAnimation - the animation that rotated the button.
//    finished - is the animation finised?
//
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)finished
{
	if (finished)
	{
		[self spinButton];
	}
}

//
// buttonPressed:
//
// Handles the play/stop button. Creates, observes and starts the
// audio streamer when it is a play button. Stops the audio streamer when
// it isn't.
//
// Parameters:
//    sender - normally, the play/stop button.
//
- (IBAction)buttonPressed:(id)sender
{
    /*
	if ([button.image isEqual:[NSImage imageNamed:@"playbutton"]])
	{
		
		
		[self createStreamer];
		[self setButtonImage:[NSImage imageNamed:@"loadingbutton"]];
		[streamer start];
	}
	else
	{
		[streamer stop];
	}
     */
}

//
// playbackStateChanged:
//
// Invoked when the AudioStreamer
// reports that its playback status has changed.
//
- (void)playbackStateChanged:(NSNotification *)aNotification
{
	if ([streamer isWaiting])
	{
		[self setButtonImage:[NSImage imageNamed:@"loadingbutton"]];
	}
	else if ([streamer isPlaying])
	{
		[self setButtonImage:[NSImage imageNamed:@"stopbutton"]];
	}
	else if ([streamer isIdle])
	{
		[self destroyStreamer];
		[self setButtonImage:[NSImage imageNamed:@"playbutton"]];
	}
}

//
// sliderMoved:
//
// Invoked when the user moves the slider
//
// Parameters:
//    aSlider - the slider (assumed to be the progress slider)
//
- (IBAction)sliderMoved:(NSSlider *)aSlider
{
	if (streamer.duration)
	{
		double newSeekTime = ([aSlider doubleValue] / 100.0) * streamer.duration;
		[streamer seekToTime:newSeekTime];
	}
}

//
// updateProgress:
//
// Invoked when the AudioStreamer
// reports that its playback progress has changed.
//
- (void)updateProgress:(NSTimer *)updatedTimer
{
	if (streamer.bitRate != 0.0)
	{
		double progress = streamer.progress;
		double duration = streamer.duration;
		
		if (duration > 0)
		{
			/* rezand [positionLabel setStringValue:
				[NSString stringWithFormat:@"Time Played: %.1f/%.1f seconds",
					progress,
					duration]];
			[progressSlider setEnabled:YES];
			[progressSlider setDoubleValue:100 * progress / duration];
		}
		else
		{
			[progressSlider setEnabled:NO];
		}
	}
	else
	{
		[positionLabel setStringValue:@"Time Played:"];
             */
	}
             
}


}

@end

