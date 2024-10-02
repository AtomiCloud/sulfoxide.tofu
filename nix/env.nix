{ pkgs, packages }:
with packages;
{
  system = [
    coreutils
    sd
    bash
    jq
    yq-go
    gawk
  ];

  dev = [
    pls
    git
    doctl
  ];

  main = [
    opentofu
    terraform
  ];

  lint = [
    # core
    treefmt

    # additional linters
    infisical
    terraform-docs
    tfsec
    tflint
  ];
}
