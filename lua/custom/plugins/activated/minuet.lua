return {
  'milanglacier/minuet-ai.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    provider = 'openai',
    provider_options = {
      openai = {
        model = 'gpt-5.2',
        api_key = 'OPENAI_API_KEY',
        optional = {
          max_completion_tokens = 256,
          reasoning_effort = 'medium',
        },
      },
    },
  },
}
