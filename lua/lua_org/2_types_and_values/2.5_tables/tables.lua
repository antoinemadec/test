#!/usr/bin/env lua

a = {}     -- create a table and store its reference in `a'
k = "x"
a[k] = 10        -- new entry, with key="x" and value=10
a[20] = "great"  -- new entry, with key=20 and value="great"
print(a["x"])    --> 10
k = 20
print(a[k])      --> "great"
a["x"] = a["x"] + 1     -- increments entry "x"
print(a["x"])    --> 11

a = {}
a["x"] = 10
b = a      -- `b' refers to the same table as `a'
print(b["x"])  --> 10
b["x"] = 20
print(a["x"])  --> 20
a = nil    -- now only `b' still refers to the table
b = nil    -- now there are no references left to the table

-- we could write the last lines of the previous example in a cleanlier manner
-- as:
a = {}
a.x = 10                    -- same as a["x"] = 10
print(a.x)                  -- same as print(a["x"])
print(a.y)                  -- same as print(a["y"])

-- loop on your array
a = {}
for i=1,10 do
  a[i] = i*2
end
for i,line in ipairs(a) do
  print(line)
end

-- When in doubt about the actual types of your indices, use an explicit
-- conversion to be sure You can introduce subtle bugs in your program if you
-- do not pay attention to this point.
i = 10; j = "10"; k = "+10"
a = {}
a[i] = "one value"
a[j] = "another value"
a[k] = "yet another value"
print(a[j])            --> another value
print(a[k])            --> yet another value
print(a[tonumber(j)])  --> one value
print(a[tonumber(k)])  --> one value
