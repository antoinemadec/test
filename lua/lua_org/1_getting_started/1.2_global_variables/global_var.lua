#!/usr/bin/env lua

function print_b()
  print(b)
end

-- Global variables do not need declarations. You simply assign a value to a
-- global variable to create it. It is not an error to access a non-initialized
-- variable; you just get the special value nil as the result:
print_b() --> nil
b = 10
print_b() --> 10

-- Usually you do not need to delete global variables; if your variable is
-- going to have a short life, you should use a local variable. But, if you
-- need to delete a global variable, just assign nil to it:
b = nil
print_b() --> nil

-- After that, it is as if the variable had never been used. In other words, a
-- global variable is existent if (and only if) it has a non-nil value.
