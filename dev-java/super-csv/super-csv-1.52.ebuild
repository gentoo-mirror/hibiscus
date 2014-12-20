# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

JAVA_PKG_IUSE="doc source test"

MY_PN="SuperCSV"
MY_P="${MY_PN}-${PV}"

inherit eutils java-pkg-2 java-pkg-simple

DESCRIPTION="CSV processing library for Java"
HOMEPAGE="http://supercsv.sourceforge.net/"
SRC_URI="mirror://sourceforge/supercsv/v1-branch/v${PV}/${MY_P}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-java/spiffy"

DEPEND="${CDEPEND}
	app-arch/unzip
	>=virtual/jdk-1.5
	test? (
		dev-java/junit:4
		dev-java/hamcrest-core
	)"
RDEPEND="${CDEPEND}
	>=virtual/jre-1.5"

JAVA_SRC_DIR="src"
JAVA_GENTOO_CLASSPATH="spiffy,junit-4,hamcrest-core"

src_unpack() {
	unpack ${A}
	unpack ./${MY_P}-source.zip
	rm -v *.jar *.zip || die
}

src_test() {
	JAVA_SRC_DIR="test" \
	JAVA_CLASSPATH_EXTRA="${PN}.jar" \
	PN="${PN}-test" \
	java-pkg-simple_src_compile

	local tests
	tests=$(find test -name '*.java' | sed -e 's/\//./g;s/^test.//;s/.java$//' || die)
	
	ejunit4 -cp "${PN}.jar:${PN}-test.jar:$(java-pkg_getjars ${JAVA_GENTOO_CLASSPATH})" $tests
}
