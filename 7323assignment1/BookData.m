#import <Foundation/Foundation.h>
@implementation BookData : NSObject 

+ (NSArray *)getBooks {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"books" ofType:@"json"];
    
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    
    NSError *error;
    NSArray *booksArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (error) {
        NSLog(@"Error reading JSON file: %@", error.localizedDescription);
        return @[];
    }
    
    return booksArray;
}


@end
