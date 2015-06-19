# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

JAVA_PKG_IUSE="doc source"

MY_PN="net.sf.paperclips"

inherit java-pkg-2 eutils

DESCRIPTION="Simplified Java Printing Support for SWT"
HOMEPAGE="http://code.google.com/p/swt-paperclips"
SRC_URI="http://${PN}.googlecode.com/files/${MY_PN}.source_${PV}.jar
	ui? ( http://${PN}.googlecode.com/files/${MY_PN}.ui.source_${PV}.jar )"

LICENSE="EPL-1.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+ui"

COMMON_DEP="dev-java/swt:3.7"

DEPEND="${COMMON_DEP}
	>=virtual/jdk-1.5"

RDEPEND="${COMMON_DEP}
	>=virtual/jre-1.5"

S="${WORKDIR}"

src_compile() {

	mkdir build
	local classpath="$(java-pkg_getjars swt-3.7)"
	find net -name '*.java' > sources.list
        ejavac -d build -cp "${classpath}" @sources.list
        jar cf ${PN}.jar -C build/ .

	# TODO javadoc
}

src_install() {
        java-pkg_newjar ${PN}.jar

        #use doc && java-pkg_dohtml -r docs/*
        use source && java-pkg_dosrc net
}

