#!/usr/bin/env lua

---@diagnostic disable: lowercase-global

-- let's place N queens on a NxN chess board so the cannot attack each other
N=100

-- simplify the problem using diagonal coordinates (diag1, diag2)
--  diag1 goes from the upper-left to the lower-right
--  diag2 goes from the upper-right to the lower-left
--  diag1=0 is the highest diag, diag1=(N-1)*2 is the lowest one ; same for diag2
available_diag2_from_diag1 = {}
mid_diag_val = N-1


---------------------------------------------------------------
-- tools
---------------------------------------------------------------
function math.randomkey(t) --Selects a random key from a table
  local keys = {}
  for key, _ in pairs(t) do
    keys[#keys+1] = key --Store keys in another table
  end
  return keys[math.random(1, #keys)]
end

function math.randomval(t) --Selects a random item from a table
  index = math.randomkey(t)
  return t[index]
end

function deepcopy(orig)
  local orig_type = type(orig)
  local copy
  if orig_type == 'table' then
    copy = {}
    for orig_key, orig_value in next, orig, nil do
      copy[deepcopy(orig_key)] = deepcopy(orig_value)
    end
    setmetatable(copy, deepcopy(getmetatable(orig)))
  else -- number, string, boolean, etc
    copy = orig
  end
  return copy
end


---------------------------------------------------------------
-- functions
---------------------------------------------------------------
function gen_available_diag2_from_diag1()
  for i=0,(N-1)*2 do
    if i <= mid_diag_val then
      local avail_diag2 = {}
      for j=0,i do
        table.insert(avail_diag2, j*2-i + mid_diag_val)
      end
      available_diag2_from_diag1[i] = avail_diag2
    else
      -- t[8]=t[6] t[9]=t[5] etc
      available_diag2_from_diag1[i] = deepcopy(available_diag2_from_diag1[2*mid_diag_val-i])
    end
  end
end

function diag_to_cartesian(d)
  -- y = x + (d1 - 7)
  -- y = -x + d2
  local x = (d[2] - d[1] + mid_diag_val) // 2
  local y = (d[1] + d[2] - mid_diag_val) // 2
  return {x,y}
end

function place_N_queens()
  local d2_from_d1 = deepcopy(available_diag2_from_diag1)
  local queens_coords = {}

  for i=1,N do
    local d = {-1, -1}

    -- find d1
    d[1] = math.randomkey(d2_from_d1)
    -- remove d1 entry from table d2_from_d1
    local available_diag2 = d2_from_d1[d[1]]
    d2_from_d1[d[1]] = nil

    -- find d2
    d[2] = math.randomval(available_diag2)
    -- remove all item matching d2 in table d2_from_d1
    for d1,av_d2 in pairs(d2_from_d1) do
      for k,d2 in pairs(av_d2) do
        if d2 == d[2] then
          av_d2[k] = nil
        end
      end
      if #av_d2 == 0 then
        d2_from_d1[d1] = nil
      end
    end

    -- change coord back to cartesian
    queens_coords[i] = diag_to_cartesian(d)
  end

  return queens_coords
end


---------------------------------------------------------------
-- functions
---------------------------------------------------------------
gen_available_diag2_from_diag1()
coords = place_N_queens()
-- ins = require('inspect')
-- print(ins(coords))
