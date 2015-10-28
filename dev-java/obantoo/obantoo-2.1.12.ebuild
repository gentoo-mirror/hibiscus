# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="2"
JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2

DESCRIPTION="A Java Library for HBCI (Homebanking Computer Interface) / FinTS (Financial Transaction Services)"
HOMEPAGE="http://obantoo.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

COMMON_DEP="dev-java/itext:5"

RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"

DEPEND=">=virtual/jdk-1.6
	app-arch/unzip
	dev-java/junit:4
	${COMMON_DEP}"

java_prepare() {
	rm -v *.jar || die
	rm -rv bin/* || die
}

src_compile() {

	local classpath="$(java-pkg_getjars itext-5,junit-4)"

	find src -name '*.java' > sources.list
	ejavac -encoding latin1 -cp "${classpath}" -d bin @sources.list
	jar cf ${PN}.jar -C bin/ .
	# TODO: javadoc
}

src_install() {
	java-pkg_newjar ${PN}.jar

	use doc && dodoc doc/*
	use doc && java-pkg_dojavadoc javadoc

	use source && java-pkg_dosrc src/de
}
