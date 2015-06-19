# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc source"

WANT_ANT_TASKS="ant-nodeps"
inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="A Java Library for HBCI (Homebanking Computer Interface) / FinTS (Financial Transaction Services)"
HOMEPAGE="http://hbci4java.kapott.org/"
SRC_URI="http://hbci4java.kapott.org/${P}-src.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="+chipcard"

COMMON_DEP="
	dev-java/xerces:2
	>=dev-java/log4j-1.2.8:0
	!net-libs/willuhn-hbci4java"

RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	${COMMON_DEP}"

S=${WORKDIR}/${P}-src

# JNI libraries don't need SONAME
QA_SONAME="usr/$(get_libdir)/lib${PN}-chipcard-linux.so"

EANT_BUILD_TARGET="package"

pkg_setup() {
	use chipcard && EANT_BUILD_TARGET="compile-chipcard ${EANT_BUILD_TARGET}"
}

java_prepare() {
	epatch "${FILESDIR}/${PV}-makefile.patch"
	epatch "${FILESDIR}/${PV}-build.patch"
	eant clean
}

src_install() {
	java-pkg_newjar dist/jar/${PN}.jar

	if use chipcard; then
		dolib chipcard/lib/libhbci4java-card-linux.so || "dolib failed"
	fi

	dodoc README* FEATURES BUGS ChangeLog || die "dodoc failed"

	use doc && java-pkg_dojavadoc doc/javadoc
	use source && java-pkg_dosrc src/org
}
