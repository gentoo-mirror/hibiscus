# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/itext/itext-5.2.0.ebuild,v 1.1 2012/03/26 07:21:27 sera Exp $

EAPI="4"
JAVA_PKG_IUSE=""
GROUP_ID="net.sourceforge.htmlunit"

inherit java-pkg-2 java-mvn-src 

DESCRIPTION="A java GUI-Less browser, supporting JavaScript, to run againsweb pages"
HOMEPAGE="http://htmlunit.sourceforge.net/"

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

JAVA_GENTOO_CLASSPATH="commons-io-1,commons-codec,commons-logging,commons-lang-2.1,commons-httpclient-3,cssparser,xerces-2,commons-collections,nekohtml,htmlunit-core-js,xalan,sac"

# src_compile() {
#    local classpath="$(java-pkg_getjars \
	 #commons-io-1,commons-codec,commons-logging,commons-lang-2.1,commons-httpclient-3,cssparser,xerces-2,commons-collections,nekohtml)"
# 
#     mkdir build
#     find src -name '*.java' > sources.list
#     ejavac -d build -cp "${classpath}" @sources.list
#     jar cf ${PN}.jar -C build/ .
# 
#     # TODO javadoc
# }

