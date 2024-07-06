local s = {
  0xFFFF0000,
  0xFF000000,
  0xFFF00000
}
local gm = require("tab")

local d = gm.shift(s)
gm.shuffle(d)
