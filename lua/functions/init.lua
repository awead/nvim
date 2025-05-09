function find_file_under_cursor ()
  local currentDir = vim.fn.getcwd()
  local projectType = get_project_type(currentDir)
  local current_word = vim.fn.expand('<cword>')
  local snaked_word = snake(current_word)
  local allPaths

  if projectType == "python" then
    allPaths = vim.fn.systemlist("find .venv -type d -not -name '_*' -depth 4 -not -name '*.dist-info'")
  elseif projectType == "ruby" then
    allPaths = vim.fn.systemlist('bundle show --paths')
  else
    allPaths = {}
  end

  table.insert(allPaths, currentDir)

  local opts = {
    search_file = snake(current_word),
    search_dirs = allPaths,
    no_ignore = true
  }
  print("snaked word: " .. snaked_word)
  require('telescope.builtin').find_files(opts)
end

-- Bug: V2StrategyPolicy becomes v_2_strategy_policy
function snake(s)return s:gsub('%f[^%l]%u','_%1'):gsub('%f[^%a]%d','_%1'):gsub('%f[^%d]%a','_%1'):gsub('(%u)(%u%l)','%1_%2'):lower()end

function grep_string_under_cursor ()
  local currentDir = vim.fn.getcwd()
  local projectType = get_project_type(currentDir)
  local allPaths

  if projectType == "python" then
    allPaths = vim.fn.systemlist("find .venv -type d -not -name '_*' -depth 4 -not -name '*.dist-info'")
  elseif projectType == "ruby" then
    allPaths = vim.fn.systemlist('bundle show --paths')
  else
    allPaths = {}
  end

  table.insert(allPaths, currentDir)

  local opts = {
    search_dirs = allPaths,
    additional_args = {
      "--no-ignore"
    }
  }

  require("telescope.builtin").grep_string(opts)
end

function get_project_type(cwd)
  if vim.fn.filereadable(cwd .. "/pyproject.toml") == 1 then
    return "python"
  elseif vim.fn.filereadable(cwd .. "/Gemfile") == 1 then
    return "ruby"
  else
    return "unknown"
  end
end

