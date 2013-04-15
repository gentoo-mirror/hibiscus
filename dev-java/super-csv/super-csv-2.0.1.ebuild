# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="doc source"
GROUP_ID="net.sf.supercsv"

inherit eutils java-pkg-2 java-mvn-src

DESCRIPTION="CSV processing library for Java"
HOMEPAGE="http://supercsv.sourceforge.net/"
LICENSE="Apache-2.0"

SLOT="2"
KEYWORDS="~amd64"

IUSE=""

DEPEND=">=virtual/jdk-1.5"
RDEPEND=">=virtual/jre-1.5"
