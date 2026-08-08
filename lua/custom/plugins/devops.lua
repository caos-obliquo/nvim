-- devops plugins: yaml, json, docker, k8s
return {
  -- yaml/json support
  {
    'b0o/schemastore.nvim', -- json schemas for kubernetes, etc
  },

  -- helm support
  {
    'towolf/vim-helm',
    ft = 'helm',
  },

  -- docker/podman
  {
    'ekalinin/Dockerfile.vim',
    ft = 'Dockerfile',
  },

  -- kubernetes
  {
    'andrewstuart/vim-kubernetes',
    ft = { 'yaml', 'yml' },
  },

  -- better yaml folding and view
  {
    'pedrohdz/vim-yaml-folds',
    ft = { 'yaml', 'yml' },
  },

  -- cloudformation/terraform
  {
    'hashivim/vim-terraform',
    ft = 'terraform',
  },
}
