# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

JAVA_PKG_IUSE="doc source"

MY_PN="org.swtchart"

inherit java-pkg-2 eutils java-ant-2

DESCRIPTION="Lightweight chart component for SWT"
HOMEPAGE="http://www.swtchart.org/"
SRC_URI="mirror://sourceforge/${PN}/SWTChart/${MY_PN}_${PV}.zip"

LICENSE="EPL-1.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

COMMON_DEP="dev-java/swt:3.7
			dev-java/eclipse-jface:3.8
			dev-java/eclipse-core-commands:3.6"

# Remove jameica dep which is only needed for jface
DEPEND="${COMMON_DEP}
	>=virtual/jdk-1.5"

RDEPEND="${COMMON_DEP}
	>=virtual/jre-1.5"

S="${WORKDIR}"

src_unpack() {
    default
	cd "${WORKDIR}"
	unzip plugins/org.swtchart_*.jar -d org.swtchart
	unzip plugins/org.swtchart.ext_*.jar -d org.swtchart.ext
}

java_prepare() {
	cp "${FILESDIR}/build.xml" "${S}/build.xml" || die "Unable to update build.xml"
	eant clean
}

src_compile() {

#        local classpath="$(java-pkg_getjars swt-3.7)"
	EANT_GENTOO_CLASSPATH="swt-3.7,eclipse-jface-3.8,eclipse-core-commands-3.6" eant build 

#	mkdir -p bin/swtchart bin/swtchart-ext

#        find swtchart/src -name '*.java' > sources.list
#        ejavac -cp "${classpath}" -d bin/swtchart @sources.list
#        jar cf org.swtchart_${PV}.jar -C bin/swtchart .

#	find swtchart-ext/src -name '*.java' > sources.list
#        ejavac -cp "${classpath}:org.swtchart_${PV}.jar" -d bin/swtchart-ext @sources.list
#        jar cf org.swtchart.ext_${PV}.jar -C bin/swtchart-ext .

        # TODO: javadoc
}


src_install() {
        java-pkg_newjar org.swtchart.jar org.swtchart.jar
		java-pkg_newjar org.swtchart.ext.jar org.swtchart.ext.jar

#        use doc && dodoc doc/*
#        use doc && java-pkg_dojavadoc javadoc

 #       use source && java-pkg_dosrc src/de
}
