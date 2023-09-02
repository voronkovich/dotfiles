local function basename()
  return vim.fn.expand("%:t:r")
end

local function path_to_fqn(path)
  local fqn = path:gsub(".php$", ""):gsub("/", "\\")

  local i = fqn:find("\\%u")
  if i == nil then
    return "App"
  end

  fqn = fqn:sub(i + 1, -1)

  return "App\\" .. fqn
end

local function namespace()
  local fqn = path_to_fqn(vim.fn.expand("%:p"))

  return fqn:gsub("\\[^\\]+$", "")
end

return {
  s(
    "class",
    fmt(
      [[
    <?php

    namespace @#;

    class @#
    {
        @#
    }
    ]],
      { f(namespace), f(basename), i(0) },
      { delimiters = "@#" }
    )
  ),
}
