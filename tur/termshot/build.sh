TERMUX_PKG_HOMEPAGE="https://github.com/homeport/termshot"
TERMUX_PKG_DESCRIPTION="Creates screenshots based on terminal command output"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@Veha0001"
TERMUX_PKG_VERSION=0.6.0
TERMUX_PKG_SRCURL=git+https://github.com/homeport/termshot
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_DEPENDS="imagemagick"

termux_step_pre_configure() {
	termux_setup_golang

	go mod init || :
	go mod tidy
}

termux_step_make() {
	CGO_ENABLED=0 go build \
		-ldflags="-s -w -X github.com/homeport/termshot/internal/cmd.version=$TERMUX_PKG_VERSION" -trimpath \
		-o $TERMUX_PKG_SRCDIR/termshot \
		$TERMUX_PKG_SRCDIR/cmd/termshot/main.go
}
termux_step_make_install() {
	install -Dm700 -t "${TERMUX_PREFIX}"/bin "$TERMUX_PKG_SRCDIR"/termshot
}
