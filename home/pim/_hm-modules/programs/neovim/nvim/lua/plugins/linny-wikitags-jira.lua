return {
  "linden-project/linny-wikitag-jira",
  dependencies = {
    "linden-project/linny.vim",
  },
  config = function()
  -- Uncomment if your Jira instance has it's own subdomain...
  --   be sure to add a trailing slash
    vim.g.linny_wikitag_jira_baseurl = "https://technative.atlassian.net/browse/"
  end
}
