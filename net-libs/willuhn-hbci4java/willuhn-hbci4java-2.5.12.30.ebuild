# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc source"

WANT_ANT_TASKS="ant-nodeps"
inherit eutils java-pkg-2 java-ant-2

PATCH_VERSION="$(get_version_component_range 4)"

DESCRIPTION="A Java Library for HBCI/FinTS (Hibiscus Branch)"
HOMEPAGE="https://github.com/willuhn/hbci4java"
SRC_URI="https://github.com/willuhn/hbci4java/tarball/PATCH_${PATCH_VERSION} -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+smartcard"

COMMON_DEP="
	dev-java/xerces:2
	>=dev-java/log4j-1.2.8:0
	!net-libs/hbci4java
	smartcard? ( sys-libs/pcsc-ctapi-wrapper )"

RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"

DEPEND=">=virtual/jdk-1.6
	app-arch/unzip
	${COMMON_DEP}"

# JNI libraries don't need SONAME
QA_SONAME="usr/$(get_libdir)/lib${PN}-chipcard-linux.so"

EANT_BUILD_TARGET="package"

#pkg_setup() {
#	use smartcard && EANT_BUILD_TARGET="compile-chipcard ${EANT_BUILD_TARGET}"
#}

src_unpack() {
	unpack ${A}
	mv ${PN}-* "${S}"
}

java_prepare() {
	eant clean
}

src_install() {
	java-pkg_newjar dist/jar/hbci4java.jar

	if use smartcard; then
		dolib chipcard/lib/libhbci4java-card-linux.so || "dolib failed"
		use amd64 && dosym libhbci4java-card-linux.so /usr/$(get_libdir)/libhbci4java-card-linux-64.so
	fi

	dodoc readme.txt || die "dodoc failed"

	use doc && java-pkg_dojavadoc doc/javadoc
	use source && java-pkg_dosrc src/org
}
