# TechPopList
pop chooselist to window
###show list 

###Example
![Screenshot of  Example](TechPopList/blob/master/gif/123.gif)


```objc
TePopList *pop = [[TePopList alloc]initWithListDataSource:@[@"tag1",@"tag2",@"tag3",@"tag4",@"tag5"] withSelectedBlock:^(NSInteger select) {
NSLog( @"%li" ,(long)select);
selected = select;
}];
[pop show];
[pop selectIndex:selected];
```

