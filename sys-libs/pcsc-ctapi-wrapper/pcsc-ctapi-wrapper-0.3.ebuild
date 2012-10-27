# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libchipcard/libchipcard-5.0.2.ebuild,v 1.5 2012/04/16 19:39:58 ranger Exp $

EAPI=2

inherit eutils multilib 

DESCRIPTION="Wrapper library for using smartcard readers that support PCSC only (e.g. SCR24x) with any application that supports CTAPI."
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
