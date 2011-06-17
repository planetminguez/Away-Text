#import <CoreTelephony/CTMessageCenter.h>
#import <ChatKit/CKSMSMessage.h>
#import <ChatKit/CKSMSEntity.h>
#import <ChatKit/CKSMSService.h>
#import <ChatKit/CKConversation.h>

%hook SBSMSManager
NSString *sendersMessageString;
NSString *senderNumber;
-(id)messageReceived:(NSNotification *)message {
	NSDictionary *settingsDict = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.legendcoders.awaytext.plist"];
	BOOL autoReply = [[settingsDict objectForKey:@"OnOff"] boolValue];
	NSString *replyMessage = [settingsDict objectForKey:@"replyMessage"];
	
	if(autoReply) {
		NSDictionary *userInfo=[message valueForKey:@"userInfo"];
		CKSMSMessage *actualMessage=[userInfo valueForKey:@"CKMessageKey"];
		CKSMSEntity *senderAdress = [actualMessage sender];
		senderNumber = [senderAdress rawAddress];
		sendersMessageString = [actualMessage text];
		
		CKSMSService* service = [objc_getClass("CKSMSService") sharedSMSService];
		CKConversationList* SMSList = service.conversationList;
		CKConversation* SMSConversation = [SMSList existingConversationForAddresses:[NSArray arrayWithObjects:senderNumber, nil]];
		CKSMSMessage* outGoingMessage = [service _newSMSMessageWithText:replyMessage forConversation:SMSConversation];
		[service sendMessage:outGoingMessage];
		}
	
	return %orig;
}

%end