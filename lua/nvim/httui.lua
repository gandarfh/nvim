-- Import the JSON library
local json = vim.json

-- Finds the path of a specific property within a table
local function findProperty(table, property, currentPath)
  currentPath = currentPath or ""

  for key, value in pairs(table) do
    local newPath = currentPath == "" and key or (currentPath .. "." .. key)

    if key == property then
      -- Property found, return its path
      return newPath
    elseif type(value) == "table" then
      -- If value is a table, continue the search recursively
      local foundPath = findProperty(value, property, newPath)
      if foundPath then
        return foundPath
      end
    end
  end

  return nil
end

-- Fetches the selected text in visual mode
local function getVisualText()
  local start_line, start_col = unpack(vim.api.nvim_buf_get_mark(0, '<'))
  local end_line, end_col = unpack(vim.api.nvim_buf_get_mark(0, '>'))

  if start_line == end_line then
    local line = vim.api.nvim_buf_get_lines(0, start_line - 1, start_line, false)[1]
    return string.sub(line, start_col + 1, end_col + 1)
  end

  return nil
end

-- Recursively search for 'request_id' within a node
local function findRequestId(node)
  if type(node) == 'table' then
    for key, value in pairs(node) do
      if key == 'request_id' then
        return value
      elseif type(value) == 'table' then
        local result = findRequestId(value)
        if result then
          return result
        end
      end
    end
  end
end

-- Copies a formatted string to the clipboard based on the JSON content and visual selection
function copyToClipboard()
  local json_data = vim.fn.join(vim.fn.getline(1, '$'), '\n')
  local data, _, err = json.decode(json_data)

  if err then
    print('Error decoding JSON:', err)
    return
  end

  local request_id = findRequestId(data)
  local property = findProperty(data, getVisualText())

  if request_id then
    local result = string.format("{%% response '%s' '%s' %%}", property, request_id)
    vim.fn.setreg('+', result)
    print('Copied to clipboard:', result)
  else
    print("Could not find 'request_id' in the JSON.")
  end
end

-- Command to call the copyToClipboard function
vim.cmd("command! -range HttuiResponse lua copyToClipboard()")
