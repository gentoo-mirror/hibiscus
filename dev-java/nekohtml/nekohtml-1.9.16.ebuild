# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/nekohtml/nekohtml-1.9.6.ebuild,v 1.6 2012/07/05 19:50:21 sera Exp $

EAPI="4"

JAVA_PKG_IUSE="doc examples source"

inherit java-pkg-2 java-ant-2 eutils

DESCRIPTION="A simple HTML scanner and tag balancer using standard XML interfaces."

HOMEPAGE="http://nekohtml.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="Apache-2.0"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

COMMON_DEP=">=dev-java/xerces-2.7"
DEPEND=">=virtual/jdk-1.4
	test? ( =dev-java/junit-3.8* )
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

JAVA_ANT_REWRITE_CLASSPATH="yes"
EANT_GENTOO_CLASSPATH="xerces-2"

#do not generate docs, use bundled
EANT_DOC_TARGET=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-remove-obsolete-xerces-bridges.patch
	find . -iname '*.jar' -delete
}

src_test() {
	ANT_TASKS="ant-junit" \
		EANT_GENTOO_CLASSPATH="xerces-2 junit" \
		eant test
}

src_install() {
	java-pkg_dojar build/lib/${PN}.jar

	if use doc; then
		java-pkg_dojavadoc --symlink javadoc doc/javadoc
		dohtml doc/*
	fi

	use source && java-pkg_dosrc ./src/org
	use examples && java-pkg_doexamples src/sample
}
