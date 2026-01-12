# Batch-industrial-management
Short standalone script for managing files and folders within an industrial process

I mean by industrial process a system built on folders structured under functional models and containing some reference files for the different services.
It provides supervision over each unit that is produced all along fabrication process, but is also a simple way to present project in modular development. 

So I made three main functions, to manipulate on all over similar files or folders into project parent. which are copy, extract and rename :


- copy once to all matching sub-directories
  - (eg: a commonUserNotice to each kind of produce)

- copy several time into a directory
  - (eg: instruction_Template -> instruction_1, instruction_2, ...)

- extract every matching element from the sub-directories
  - (eg: report from each produce)

- set compliant name for matching elements
  - (eg1: produce(1) -> produce_1, produce2 -> produce_2)
  - (eg2: produce(1A) -> produce_1A, produce(1B) -> produce_1B)


