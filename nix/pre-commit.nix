{ packages, formatter, pre-commit-lib }:
pre-commit-lib.run {
  src = ./.;

  # hooks
  hooks = {
    # formatter
    treefmt = {
      enable = true;
      excludes = [ "infra/.*(yaml|yml)" ];
    };

    # linters From https://github.com/cachix/pre-commit-hooks.nix
    shellcheck = {
      enable = false;
    };

    a-sync = {
      enable = true;
      name = "Sync Static and Secrets";
      description = "Sync static and secrets";
      entry = "${packages.bash}/bin/bash ./scripts/local/sync.sh";
    };

    a-infisical = {
      enable = true;
      name = "Secrets Scanning (Past Commits)";
      description = "Scan for possible secrets in past commits";
      entry = "${packages.infisical}/bin/infisical scan . -v";
      language = "system";
      pass_filenames = false;
    };

    a-infisical-staged = {
      enable = true;
      name = "Secrets Scanning (Staged)";
      description = "Scan for possible secrets in staged files";
      entry = "${packages.infisical}/bin/infisical scan git-changes --staged -v";
      language = "system";
      pass_filenames = false;
    };

    a-gitlint = {
      enable = true;
      name = "Gitlint";
      description = "Lints git commit message";
      entry = "${packages.gitlint}/bin/gitlint --staged --msg-filename .git/COMMIT_EDITMSG";
      language = "system";
      pass_filenames = false;
      stages = [ "commit-msg" ];
    };

    a-enforce-gitlint = {
      enable = true;
      name = "Enforce gitlint";
      description = "Enforce atomi_releaser conforms to gitlint";
      entry = "${packages.sg}/bin/sg gitlint";
      files = "(atomi_release\\.yaml|\\.gitlint)";
      language = "system";
      pass_filenames = false;
    };

    a-shellcheck = {
      enable = true;
      name = "Shell Check";
      entry = "${packages.shellcheck}/bin/shellcheck";
      files = ".*sh$";
      language = "system";
      pass_filenames = true;
    };

    a-enforce-exec = {
      enable = true;
      name = "Enforce Shell Script executable";
      entry = "${packages.coreutils}/bin/chmod +x";
      files = ".*sh$";
      language = "system";
      pass_filenames = true;
    };

    a-tfsec = {
      enable = true;
      name = "Terraform Security";
      description = "Static analyzer for terraform security";
      entry = "${packages.tfsec}/bin/tfsec .";
      files = ".*tf";
      language = "system";
      pass_filenames = false;
    };

  };

  settings = {
    treefmt = {
      package = formatter;
    };
  };
}
