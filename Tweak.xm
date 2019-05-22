%group tweak // creates a group with the name "tweak" so we can later init
%hook SpringBoard
-(void)someMethod {
  //Very productive code here
}

-(void)anotherMethod {
  //100% functional code
}
%end

%hook VolumeControl //You can have as many hooks inside the tweak
-(void)otherMethod {
  //100% functional code
}

%end
%end

%ctor {
  //Creates the due date
  NSDateComponents *dueDateComponents = [[NSDateComponents alloc] init];
  [dueDateComponents setYear:2019]; //the year
  [dueDateComponents setMonth:5]; //the month
  [dueDateComponents setDay:21]; // the day
  [dueDateComponents setHour:0]; // the hour (24 hours)
  [dueDateComponents setMinute:0]; // the minute

  NSCalendar *calendar = [[NSCalendar alloc]  initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  NSDate *dueDate = [calendar dateFromComponents:dueDateComponents]; //generates the NSDate so it can be used later


//Checks if the date is before the due date
//Note: creating a file is not neccesary but it is the to improve the chances from being bypassed
//If you are going to create and check for the file i would recommend naming it something suttle
//and putting it in a random folder with alot of files
//you can also create multiple file in diffrent folder and check for all of them to increase the chanses of it not being found
//this can be bypassed, but it will be inconveint to use the device.

  if ([[NSDate date] compare:dueDate] == NSOrderedAscending) {
    if (![[NSFileManager defaultManager] fileExistsAtPath: @"/var/mobile/Library/hidden"]) {
      NSLog(@"Current date is before dueDate && the file doesnt exist");
      %init(tweak); //init the group we created
    }
  } else {
    //
    [[NSFileManager defaultManager] createFileAtPath: @"/var/mobile/Library/hidden" contents:nil attributes: nil];
  }
}
