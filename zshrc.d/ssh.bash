# SSH key management is handled by ~/.ssh/config
#
# The following options are configured there:
#   AddKeysToAgent yes  - Automatically add keys to ssh-agent on first use
#   UseKeychain yes     - Store/retrieve passphrases from macOS Keychain
#   IdentityFile        - Specifies which key(s) to use
#
# This approach replaces the old ssh-add loop that ran on every shell startup.
#
# Here's an example
#
#---
# ~/.ssh/config
#---
# Host *
#     AddKeysToAgent yes
#     UseKeychain yes
#     IdentityFile ~/.ssh/id_ed25519

# Host github.com-personal
#     HostName github.com
#     User git
#     IdentityFile ~/.ssh/id_ed25519_personal