$(HOME)/%: %
	mkdir -p $(@D)
	ln -sf $(realpath $<) $@

.PHONY: install
all: git tmux zsh vim

.PHONY: uninstall
clean:
	$(RM) $(HOME)/.gitconfig
	$(RM) $(HOME)/.tmux.conf
	$(RM) $(HOME)/.zshrc $(addprefix $(HOME)/,$(shell find .oh-my-zsh -type f))
	$(RM) $(HOME)/.vimrc $(addprefix $(HOME)/,$(shell find .vim -type f))

.PHONY: git tmux zsh vim
git: $(HOME)/.gitconfig
tmux: $(HOME)/.tmux.conf
zsh: $(HOME)/.zshrc $(addprefix $(HOME)/,$(shell find .oh-my-zsh -type f))
vim: $(HOME)/.vimrc $(addprefix $(HOME)/,$(shell find .vim -type f))
