#import <UIKit/UIKit.h>

#include <unistd.h>
#include <stdlib.h>
#include <ctype.h>
#include <notify.h>

BOOL isCapable() {
	return YES;
}

BOOL isEnabled()
{
	NSDictionary *settingsDict = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.legendcoders.awaytext.plist"];
	BOOL autoReply = [[settingsDict objectForKey:@"OnOff"] boolValue];
	
	return autoReply;
}

BOOL getStateFast() {
	return isEnabled();
}

// Pass in state to set. YES for enable, NO to disable.
void setState(BOOL Enable) {
	NSMutableDictionary *plistDict = [NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.legendcoders.awaytext.plist"];
	if (Enable == YES)  {
		[plistDict setValue:[NSNumber numberWithBool:YES] forKey:@"OnOff"];
		[plistDict writeToFile:@"/var/mobile/Library/Preferences/com.legendcoders.awaytext.plist" atomically: YES];
	}
	else if (Enable == NO) {
		[plistDict setValue:[NSNumber numberWithBool:NO] forKey:@"OnOff"];
		[plistDict writeToFile:@"/var/mobile/Library/Preferences/com.legendcoders.awaytext.plist" atomically: YES];
	}
	notify_post("com.legendcoders.awaytext.reloadprefs");
}

float getDelayTime() {
	return 0.1f;
}

__attribute__((constructor)) 
static void toggle_initializer() 
{ 
	NSLog(@"Toggled that bitch"); 
}