{ pkgs, atomi, pkgs-2405, pkgs-240810 }:
let

  all = {
    atomipkgs = (
      with atomi;
      {
        inherit
          sg
          pls;
      }
    );
    pkgs240810 = (
      with pkgs-240810;
      {
        inherit
          coreutils
          sd
          bash
          jq
          yq-go
          gawk

          # fmt
          treefmt

          # dev
          git
          doctl

          # main
          infisical
          opentofu

          # lint
          gitlint
          shellcheck
          terraform-docs
          tfsec
          tflint;
        }
    );
    pkgs2405 = (
      with pkgs-2405;
      {
      }
    );
  };
in
with all;
atomipkgs //
pkgs240810 //
pkgs2405
