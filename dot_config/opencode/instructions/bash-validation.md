# Bash script validation

When creating or editing Bash scripts, always format and lint before finishing.

- In this dotfiles repository, run:
  - `shfmt -w install.sh .chezmoiscripts/*.sh`
  - `shfmt -d install.sh .chezmoiscripts/*.sh`
  - `shellcheck install.sh .chezmoiscripts/*.sh`
- If working in a different repository, run equivalent checks on the Bash files that were changed.

If either check reports issues, fix them and re-run until clean.
