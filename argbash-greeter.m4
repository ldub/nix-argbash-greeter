# A cow greets you from an argbash-generated, nix-packaged script.
#
# ARG_OPTIONAL_SINGLE([name], [n], [The name to greet], [Lev])
# ARG_HELP([A cow greets you from an argbash-generated, nix-packaged script..])
# ARGBASH_GO

# [ <-- needed because of Argbash

cowsay "Hello, $_arg_name!"

# ] <-- needed because of Argbash