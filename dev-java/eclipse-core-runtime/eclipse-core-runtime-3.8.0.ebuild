# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-sdk/eclipse-sdk-3.5.1-r1.ebuild,v 1.6 2012/05/21 20:05:07 ssuominen Exp $

EAPI="2"

inherit eutils java-pkg-2 versionator

S="${WORKDIR}/"
MY_PV="$(get_version_component_range 1-2)"

DESCRIPTION="Eclipse SDK"
HOMEPAGE="http://www.eclipse.org/eclipse-rcp/"
SRC_URI="http://eclipse.ialto.com/eclipse/updates/4.2/R-4.2-201206081400/plugins/org.eclipse.core.runtime_${PV}.v20120521-2346.jar"

LICENSE="EPL-1.0"
KEYWORDS="~amd64 ~x86"
IUSE=""
SLOT="${MY_PV}"

CDEPEND=""
RDEPEND="${CDEPEND}
	>=virtual/jre-1.5"
DEPEND="${CDEPEND}"

src_unpack() {
	# Do nothing
	echo ""
}

src_install() {

	java-pkg_newjar "${DISTDIR}/${A}" org.eclipse.core.runtime.jar
}
