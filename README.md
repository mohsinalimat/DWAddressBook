# DWAddressBook
- pod 'DWAddressBook'


-   #import "DWAddressBook.h"


        [DWAddressBook requestAddressBookAuthorization];

        DWAddressBook *addressbook = [[DWAddressBook alloc] initWithResultBlock:^(NSString *name, NSString *mobNumber) {
        self.label.text = [NSString stringWithFormat:@"%@\n%@", name, mobNumber];
        } failure:^{
        NSLog(@"授权失败");
        }];
        [self presentViewController:addressbook animated:YES completion:nil];

![gif](https://github.com/CoderDwang/DWAddressBook/blob/master/demo.gif)
