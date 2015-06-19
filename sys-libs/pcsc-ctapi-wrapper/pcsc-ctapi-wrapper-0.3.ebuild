# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils multilib

DESCRIPTION="Wrapper library for using applications which use CTAPI with PCSC smartcard readers"
HOMEPAGE="http://pcsc-ctapi.sourceforge.net/"
SRC_URI="mirror://sourceforge/pcsc-ctapi/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=sys-apps/pcsc-lite-1.6.2"
DEPEND="${RDEPEND}"

src_install() {
	dolib.so lib${PN}.so.${PV} || die "dolib.so failed"
	dosym lib${PN}.so.${PV} /usr/$(get_libdir)/lib${PN}.so.0 || die
	dosym lib${PN}.so.${PV} /usr/$(get_libdir)/lib${PN}.so || die

	dodoc README || die "dodoc failed"
}
