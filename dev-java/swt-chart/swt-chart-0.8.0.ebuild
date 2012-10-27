# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

JAVA_PKG_IUSE="doc source"

MY_PN="net.sf.paperclips"

inherit java-pkg-2 eutils

DESCRIPTION="Simplified Java Printing Support for SWT"
HOMEPAGE="http://code.google.com/p/swt-paperclips"
SRC_URI="mirror://sourceforge/${PN}/SWTChart/org.swtchart_${PV}.zip"

LICENSE="EPL-1.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

COMMON_DEP="dev-java/swt:3.7"

DEPEND="${COMMON_DEP}
	>=virtual/jdk-1.5"

RDEPEND="${COMMON_DEP}
	>=virtual/jre-1.5"

S="${WORKDIR}"

src_unpack() {
        default
	cd "${S}"
	unzip plugins/org.swtchart_*.jar -d swtchart
	unzip plugins/org.swtchart.ext_*.jar -d swtchart-ext
}

src_compile() {

        local classpath="$(java-pkg_getjars swt-3.7)"

	mkdir -p bin/swtchart bin/swtchart-ext

        find swtchart/src -name '*.java' > sources.list
        ejavac -cp "${classpath}" -d bin/swtchart @sources.list
        jar cf org.swtchart_${PV}.jar -C bin/swtchart .

	find swtchart-ext/src -name '*.java' > sources.list
        ejavac -cp "${classpath}:org.swtchart_${PV}.jar" -d bin/swtchart-ext @sources.list
        jar cf org.swtchart.ext_${PV}.jar -C bin/swtchart-ext .

        # TODO: javadoc
}


src_install() {
        java-pkg_newjar org.swtchart_${PV}.jar
	java-pkg_newjar org.swtchart.ext_${PV}.jar

        use doc && dodoc doc/*
        use doc && java-pkg_dojavadoc javadoc

        use source && java-pkg_dosrc src/de
}
