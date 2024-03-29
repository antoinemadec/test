#!/usr/bin/env lua

local ins = require('inspect')

local Rectangle = {
  a = 1,
  b = 1,
}

function Rectangle:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Rectangle:get_perimeter()
  return self.a + self.b
end

function Rectangle:get_area()
  return self.a * self.b
end

-- composition
local Square = {
  a = 1,
}

function Square:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  o.rect = Rectangle:new({a=o.a, b=o.a})
  o.get_perimeter = function()
    return o.rect:get_perimeter()
  end
  o.get_area = function()
    return o.rect:get_area()
  end
  return o
end

-- inheritance
local ExtendedRectangle = Rectangle:new(
{
  k = 1
}
)
function ExtendedRectangle:get_area_weighted()
  return self.k * self:get_area()
end


local r0 = Rectangle:new({a=5, b=6})
local r1 = Rectangle:new({a=7, b=8})
print(ins(r0))
print(r0:get_perimeter())
print(r1:get_perimeter())
print(r0:get_area())
print(r1:get_area())

local s0 = Square:new({a=5})
local s1 = Square:new({a=7})
print(ins(s0))
print(s0:get_perimeter())
print(s1:get_perimeter())
print(s0:get_area())
print(s1:get_area())

local er0 = ExtendedRectangle:new({a=5, b=6, k=2})
local er1 = ExtendedRectangle:new({a=2, b=3, k=3})
print(ins(er0))
print(er0:get_area_weighted())
print(er1:get_area_weighted())
