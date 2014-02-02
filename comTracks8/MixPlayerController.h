

#import <Cocoa/Cocoa.h>

@class MixStreamer;

@interface MixPlayerController : NSObject
{
	MixStreamer *streamer;
	NSTimer *progressUpdateTimer;
}
@property (strong) NSString *mixAudioUrl;
@property (weak) IBOutlet NSTextField *mixTextLabel;

- (IBAction)buttonPressed:(id)sender;
- (void)spinButton;
- (void)updateProgress:(NSTimer *)aNotification;
- (IBAction)sliderMoved:(NSSlider *)aSlider;
-(void)createStreamer:(NSNotification *)urlNotify;


@end

