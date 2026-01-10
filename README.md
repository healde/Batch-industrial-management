# Batch-industrial-management
Short standalone script for managing files and folders within an industrial process

I mean by industrial process a system built on structured folders, themself are based on models and containing some reference files for the different services.
It provide specification supervision all along fabrication process, but is also a simple way to present modular development. 

So I made three main functions, to manipulate on all over similar files or folders into project parent. those are :


- copy once to all matching sub-directories
  - (eg: commonUserNotice for each model)

- copy several time into a directory
  - (eg: instruction_Template -> instruction_1, instruction_2, ...)

- extract every matching element from sub-directories
  - (eg: report from each produce)

- set compliant name to matching element
  - (eg1: produce(1) -> produce_1, produce2 -> produce_2)
  - (eg2: produce(1A) -> produce_1A, produce(1B) -> produce_1B)


