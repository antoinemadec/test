#!/usr/bin/env lua

a = "one string"
b = string.gsub(a, "one", "another")
print(a)
print(b)
print('one line\nnext line')
print("one line\nnext line")
print("\"in quotes\", 'in quotes'")

-- Literals in this bracketed form may run for several lines, CANNOT nest, and
-- do not interpret escape sequences. Moreover, this form ignores the first
-- character of the string when this character is a newline
page = [[
<HTML>
<HEAD>
<TITLE>An HTML Page</TITLE>
</HEAD>
<BODY>
<A HREF="http://www.lua.org">Lua</A>
</HTML>
]]
print(page)

-- Lua provides automatic conversions between numbers and strings at run time.
-- Any numeric operation applied to a string tries to convert the string to a
-- number:
print("10" + 1)           --> 11
print("10 + 1")           --> 10 + 1
print("-5.3e-10"*"2")     --> -1.06e-09
-- print("hello" + 1)        -- ERROR (cannot convert "hello")

-- Lua converts the number to a string: (The .. is the string concatenation
-- operator in Lua. When you write it right after a numeral, you must separate
-- them with a space; otherwise, Lua thinks that the first dot is a decimal
-- point.)
print(10 .. 20)        --> 1020

-- Despite those automatic conversions, strings and numbers are different
-- things. A comparison like 10 == "10" is always false, because 10 is a number
-- and "10" is a string.
print("Enter number:")
line = io.read()     -- read a line
n = tonumber(line)   -- try to convert it to a number
if n == nil then
  error(line .. " is not a valid number")
else
  print(n*2)
end

-- To convert a number to a string, you can call the function tostring or
-- concatenate the number with the empty string:
print(tostring(10) == "10")   --> true
print(10 .. "" == "10")       --> true

