# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
JAVA_PKG_IUSE="doc source"

WANT_ANT_TASKS="ant-nodeps"
inherit eutils java-pkg-2 java-ant-2

if [[ ${PV} != 9999 ]]; then
        SRC_URI="https://github.com/willuhn/hbci4java/archive/${COMMIT}.zip -> ${P}.zip"
        KEYWORDS="~amd64 ~x86"
else
        inherit git-r3
        EGIT_REPO_URI="https://github.com/willuhn/hbci4java.git"
fi

DESCRIPTION="A Java Library for HBCI/FinTS (Hibiscus Branch)"
HOMEPAGE="https://github.com/willuhn/hbci4java"

LICENSE="GPL-2+"
SLOT="0"
IUSE="ctapi +smartcard"

COMMON_DEP="
	dev-java/xerces:2
	>=dev-java/log4j-1.2.8:0
	!net-libs/hbci4java
	ctapi? ( sys-libs/pcsc-ctapi-wrapper )"

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

DEPEND=">=virtual/jdk-1.5
	app-arch/unzip
	${COMMON_DEP}"

# JNI libraries don't need SONAME
QA_SONAME="usr/$(get_libdir)/lib${PN}-chipcard-linux.so"

EANT_BUILD_TARGET="package"

java_prepare() {
	epatch ${FILESDIR}/java_home.patch
	eant clean
	rm -f chipcard/lib/*
}

src_install() {
	java-pkg_newjar dist/jar/hbci4java.jar

	if use smartcard; then
		dolib.so chipcard/lib/libhbci4java-card-linux.so || "dolib failed"
		use amd64 && dosym libhbci4java-card-linux.so /usr/$(get_libdir)/libhbci4java-card-linux-64.so
	fi

	dodoc readme.md || die "dodoc failed"

	use doc && java-pkg_dojavadoc doc/javadoc
	use source && java-pkg_dosrc src/org
}
