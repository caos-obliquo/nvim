-- DevOps-focused plugins for YAML, JSON, Docker, K8s
return {
  -- YAML/JSON support
  {
    'b0o/schemastore.nvim', -- JSON schemas for Kubernetes, etc
  },

  -- Helm support
  {
    'towolf/vim-helm',
    ft = 'helm',
  },

  -- Docker/Podman
  {
    'ekalinin/Dockerfile.vim',
    ft = 'Dockerfile',
  },

  -- Kubernetes
  {
    'andrewstuart/vim-kubernetes',
    ft = { 'yaml', 'yml' },
  },

  -- Better YAML folding and view
  {
    'pedrohdz/vim-yaml-folds',
    ft = { 'yaml', 'yml' },
  },

  -- CloudFormation/Terraform (bonus for multi-cloud)
  {
    'hashivim/vim-terraform',
    ft = 'terraform',
  },
}
