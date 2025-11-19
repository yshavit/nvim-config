-- Feature detection system for local_enables
-- Reads a simple text file with one feature per line
-- Lines starting with # (with optional leading whitespace) are ignored

local M = {}

local features_cache = nil
local feature_config_cache = nil

--- Load and parse the feature configuration JSON
---@return table<string, table>
local function load_feature_config()
  local config_path = vim.fn.stdpath("config")
  local config_file = config_path .. "/local-feature-config.json"

  local file = io.open(config_file, "r")
  if not file then
    return {}
  end

  local content = file:read("*all")
  file:close()

  local ok, decoded = pcall(vim.json.decode, content)
  if not ok then
    vim.notify("Failed to parse local-feature-config.json: " .. decoded, vim.log.levels.ERROR)
    return {}
  end

  return decoded
end

--- Parse the local_enables file and return a set of enabled features
---@return table<string, boolean>
local function parse_features()
  local config_path = vim.fn.stdpath("config")
  local features_file = config_path .. "/local_enables"

  local features = {}

  -- Check if file exists
  local file = io.open(features_file, "r")
  if not file then
    -- File doesn't exist, return empty features
    return features
  end

  -- Read and parse each line
  for line in file:lines() do
    -- Trim whitespace
    local trimmed = line:match("^%s*(.-)%s*$")

    -- Skip empty lines and comments
    if trimmed ~= "" and not trimmed:match("^#") then
      features[trimmed] = true
    end
  end

  file:close()
  return features
end

--- Check if a feature is enabled
---@param feature string The feature name to check
---@return boolean
function M.is_enabled(feature)
  if features_cache == nil then
    features_cache = parse_features()
  end
  return features_cache[feature] == true
end

--- Get all enabled features (mainly for debugging)
---@return string[]
function M.get_enabled()
  if features_cache == nil then
    features_cache = parse_features()
  end

  local result = {}
  for feature, _ in pairs(features_cache) do
    table.insert(result, feature)
  end
  table.sort(result)
  return result
end

--- Get list of LazyVim extras to load based on enabled features
---@return string[]
function M.get_lazy_extras()
  if features_cache == nil then
    features_cache = parse_features()
  end
  if feature_config_cache == nil then
    feature_config_cache = load_feature_config()
  end

  local extras = {}
  for feature, config in pairs(feature_config_cache) do
    if M.is_enabled(feature) and config["lazy-extra"] then
      table.insert(extras, config["lazy-extra"])
    end
  end

  return extras
end

return M
