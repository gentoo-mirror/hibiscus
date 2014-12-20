# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

JAVA_PKG_IUSE="doc source test"

inherit eutils java-pkg-2 java-pkg-simple

DESCRIPTION="A collection of often used helper methods and utility classes used in industry"
HOMEPAGE="http://spiffyframework.sourceforge.net/"
SRC_URI="mirror://sourceforge/spiffyframework/spiffyframework/v0.xx/${PN}-all-${PV}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPS="dev-java/log4j"

DEPEND="${COMMON_DEPS}
	app-arch/unzip
	test? (
		dev-java/junit:4
	)
	dev-java/struts:1.2
	>=virtual/jdk-1.5"
RDEPEND="${COMMON_DEPS}
	>=virtual/jre-1.5"

JAVA_SRC_DIR="src"
JAVA_GENTOO_CLASSPATH="log4j,struts-1.2,junit-4"

src_unpack() {
	unpack ${A}
	rm -v ${PN}-all-${PV}.jar ${PN}-with_source-all-${PV}.jar ${PN}-all-${PV}-javadoc.zip || die
	unpack ./${PN}-all-${PV}-source.zip
	rm -v ${PN}-all-${PV}-source.zip || die
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
