# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

JAVA_PKG_IUSE="doc source"

MY_PN="SuperCSV"
MY_P="${MY_PN}-${PV}"

inherit java-pkg-2 eutils

DESCRIPTION="A collection of often used helper methods and utility classes used in industry"
HOMEPAGE="http://spiffyframework.sourceforge.net/"
SRC_URI="mirror://sourceforge/spiffyframework/spiffyframework/v0.xx/${PN}-all-${PV}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86"
IUSE=""


COMMON_DEPS="dev-java/log4j"

DEPEND="${COMMON_DEPS}
	app-arch/unzip
	dev-java/junit:0
	dev-java/struts
        >=virtual/jdk-1.5"
RDEPEND="${COMMON_DEPS}
        >=virtual/jre-1.5"

S="${WORKDIR}"

src_prepare() {
	unzip -o ${PN}-all-${PV}-source.zip 
        rm -v *.jar *.zip || die
}

src_compile() {
	local classpath="$(java-pkg_getjars junit,log4j,struts-1.2)"

	mkdir build
	find src -name '*.java' > sources.list
        ejavac -d build -cp "${classpath}" @sources.list
        jar cf ${PN}.jar -C build/ .

	# TODO javadoc
}

src_install() {
        java-pkg_newjar ${PN}.jar

        #use doc && java-pkg_dohtml -r docs/*
        use source && java-pkg_dosrc src/org
}

