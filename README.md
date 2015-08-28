# TechPopList
pop chooselist to window
###show list 
```objc
TePopList *pop = [[TePopList alloc]initWithListDataSource:@[@"123",@"321",@"test",@"456",@"789"] withSelectedBlock:^(NSInteger select) {
NSLog( @"%li" ,(long)select);
selected = select;
}];
[pop show];
[pop selectIndex:selected];
```