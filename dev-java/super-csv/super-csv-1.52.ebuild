# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

JAVA_PKG_IUSE="doc source"

MY_PN="SuperCSV"
MY_P="${MY_PN}-${PV}"

inherit eutils java-pkg-2 java-pkg-simple

DESCRIPTION="CSV processing library for Java"
HOMEPAGE="http://supercsv.sourceforge.net/"
SRC_URI="mirror://sourceforge/supercsv/v1-branch/v${PV}/${MY_P}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

COMMON_DEPS="dev-java/spiffy"

DEPEND="${COMMON_DEPS}
	app-arch/unzip
	>=virtual/jdk-1.5"
RDEPEND="${COMMON_DEPS}
	>=virtual/jre-1.5"

JAVA_SRC_DIR="src"
JAVA_GENTOO_CLASSPATH="spiffy"

src_unpack() {
	unpack ${A}
	unpack ./${MY_P}-source.zip
	rm -v *.jar *.zip || die
}
