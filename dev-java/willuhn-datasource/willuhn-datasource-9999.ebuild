# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"
JAVA_PKG_IUSE="doc source"

WANT_ANT_TASKS="ant-nodeps"
inherit eutils java-pkg-2 java-ant-2

if [[ ${PV} != 9999 ]]; then
	SRC_URI="https://github.com/willuhn/datasource/archive/${COMMIT}.zip -> ${P}.zip"
	KEYWORDS="~amd64 ~x86"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/willuhn/datasource.git"
fi

DESCRIPTION="An object relational mapper with RMI support"
HOMEPAGE="http://www.willuhn.de/products/jameica/"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

COMMON_DEP="=dev-java/willuhn-util-$PV"

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

DEPEND=">=virtual/jdk-1.5
	app-arch/unzip
	${COMMON_DEP}"

java_prepare() {

	java-ant_rewrite-classpath build/build.xml
	eant -f build/build.xml clean
}

src_compile() {

	EANT_GENTOO_CLASSPATH="willuhn-util" eant -f build/build.xml jar $(use_doc javadoc)
}

src_install() {

	java-pkg_dojar releases/*/de_willuhn_ds.jar

	use doc && java-pkg_dojavadoc dist/api
	use source && java-pkg_dosrc src/de
}
