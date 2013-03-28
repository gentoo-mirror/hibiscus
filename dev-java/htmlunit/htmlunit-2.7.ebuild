# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/itext/itext-5.2.0.ebuild,v 1.1 2012/03/26 07:21:27 sera Exp $

EAPI="4"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A java GUI-Less browser, supporting JavaScript, to run againsweb pages"
HOMEPAGE="http://htmlunit.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP="dev-java/commons-io
			dev-java/commons-codec
			dev-java/commons-logging
			dev-java/commons-collections
			dev-java/commons-httpclient
			dev-java/xalan
			>=dev-java/cssparser-0.9.5
			dev-java/xerces
			>=dev-java/nekohtml-1.9.14
			dev-java/htmlunit-core-js
			dev-java/sac"

RDEPEND="${COMMON_DEP}
	>=virtual/jre-1.5"
DEPEND="${COMMON_DEP}
	>=virtual/jdk-1.5
	app-arch/unzip"

S="${WORKDIR}/${P}"

EANT_GENTOO_CLASSPATH="commons-io-1,commons-codec,commons-logging,commons-lang-2.1,commons-httpclient-3,cssparser,xerces-2,commons-collections,nekohtml,htmlunit-core-js,xalan,sac"

java_prepare() {
	cp ${FILESDIR}/build.xml ${S}/
	java-ant_rewrite-classpath build.xml
    eant -f build.xml clean
}

src_compile() {
	eant -f build.xml build $(use_doc javadoc)
}

src_install() {
	java-pkg_dojar htmlunit.jar
}
