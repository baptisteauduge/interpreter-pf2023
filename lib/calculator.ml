let calc (s: Stack.stack) (p: Elements.program): Stack.stack = 
  List.fold_left Stack.step s p
