# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

JAVA_PKG_IUSE=""
GROUP_ID="net.sourceforge.cssparser"
inherit java-pkg-2 java-mvn-src 

DESCRIPTION="The CSS Parser inputs Cascading Style Sheets Level 2 source text and outputs a Document Object Model Level 2 Style tree."
HOMEPAGE="http://cssparser.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

CDEPEND="dev-java/sac"
DEPEND=">=virtual/jdk-1.5
		$CDEPEND"
RDEPEND=">=virtual/jre-1.5
		$CDEPEND"

JAVA_GENTOO_CLASSPATH="sac"
