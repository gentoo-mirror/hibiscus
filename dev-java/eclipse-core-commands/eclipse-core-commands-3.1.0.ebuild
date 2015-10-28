# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="2"

inherit eutils java-pkg-2 versionator

S="${WORKDIR}/"
MY_PV="$(get_version_component_range 1-2)"

DESCRIPTION="Eclipse SDK"
HOMEPAGE="http://www.eclipse.org/eclipse-rcp/"
SRC_URI="http://eclipse.ialto.com/eclipse/updates/${MY_PV}/plugins/org.eclipse.core.commands_${PV}.jar"

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

	java-pkg_newjar "${DISTDIR}/${A}" org.eclipse.core.commands.jar
}
