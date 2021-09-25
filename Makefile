$(HOME)/%: %
	mkdir -p $(@D)
	ln -sf $(realpath $<) $@

.PHONY: install
all: git tmux zsh vim

.PHONY: uninstall
clean:
	$(RM) $(GIT) $(TMUX) $(ZSH) $(VIM)

GIT=$(HOME)/.gitconfig $(HOME)/.gitignore
TMUX=$(HOME)/.tmux.conf
ZSH=$(HOME)/.zshrc $(addprefix $(HOME)/,$(shell find .oh-my-zsh -type f))
VIM=$(HOME)/.vimrc $(addprefix $(HOME)/,$(shell find .vim -type f))

.PHONY: git tmux zsh vim
git: $(GIT)
tmux: $(TMUX)
zsh: $(ZSH)
vim: $(VIM)
