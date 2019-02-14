#!/usr/bin/env lua

-- Task
-- Given a Divisor and a Bound , Find the largest integer N , Such That ,
-- Conditions :
--     N is divisible by divisor
--     N is less than or equal to bound
--     N is greater than 0.

-- Notes
--     The parameters (divisor, bound) passed to the function are only positve
--     values .  It's guaranteed that a divisor is Found .

-- Input >> Output Examples
-- 1- maxMultiple (2,7) ==> return (6)
-- Explanation:
-- (6) is divisible by (2) , (6) is less than or equal to bound (7) , and (6)
-- is > 0 .

-- 2- maxMultiple (10,50)  ==> return (50)
-- Explanation:
-- (50) is divisible by (10) , (50) is less than or equal to bound (50) , and
-- (50) is > 0 .*
--
-- 3- maxMultiple (37,200) ==> return (185)
-- Explanation:
-- (185) is divisible by (37) , (185) is less than or equal to bound (200) ,
-- and (185) is > 0 .

-- function maxMultiple_fast(divisor, bound)
--   for i=1,bound do
--     if i%divisor == 0 then
--       n = i
--     end
--   end
--   return n
-- end

function maxMultiple_fast(divisor, bound)
  return bound - (bound%divisor)
end

function maxMultiple_medium(divisor, bound)
  n = bound
  while (n>0) do
    if (n%divisor == 0) then
      return n
    end
    n = n - 1
  end
end

function maxMultiple_slow(divisor, bound)
  for i=1,bound do
    if i%divisor == 0 then
      n = i
    end
  end
  return n
end

for i,f in ipairs{maxMultiple_fast, maxMultiple_medium, maxMultiple_slow} do
  print(f(2,7))
  print(f(10,50))
  print(f(37,200))
  print("start = " .. os.clock())
  print(f(60054987,900087987))
  print("end   = " .. os.clock())
end
