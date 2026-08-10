-- devops plugins: yaml, json, docker, k8s
return {
  -- helm support
  {
    'towolf/vim-helm',
    -- nvim never sets ft='helm' itself; load on yaml so vim-helm's ftdetect can upgrade helmfile/templates files
    ft = { 'helm', 'yaml' },
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
