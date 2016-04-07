set -xe
# Get the develop branch of spacemacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
cd ~/.emacs.d
git checkout develop
# Spacemacs can't find evil when installed in batch mode. Point it in the right
# direction.
ELISP_INSTALL_PATH=install-evil.el
cat > $ELISP_INSTALL_PATH <<EOF
(require 'package)
(add-to-list
 'package-archives
 '("melpa" . "http://melpa.org/packages/")
 t)
(package-initialize)
(package-refresh-contents)
(package-install 'evil)
EOF
# Install with default .spacemacs, for now.
# cp ~/.emacs.d/core/templates/.spacemacs.template ~/.spacemacs
# Install evil, then install spacemacs
emacs -batch -l $ELISP_INSTALL_PATH -l ~/.emacs.d/init.el
