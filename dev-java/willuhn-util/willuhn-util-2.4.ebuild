EAPI="2"
JAVA_PKG_IUSE="doc source"

WANT_ANT_TASKS="ant-nodeps"
inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="A collection of small java helpers"
HOMEPAGE="http://www.willuhn.de/products/jameica/"
SRC_URI="http://www.willuhn.de/products/jameica/releases/${PV}/util/de_willuhn_util.src.zip -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

COMMON_DEP=""

RDEPEND=">=virtual/jre-1.5
        ${COMMON_DEP}"

DEPEND=">=virtual/jdk-1.5
	app-arch/unzip
        ${COMMON_DEP}"

S=${WORKDIR}

java_prepare() {

	eant -f build/build.xml clean
}

src_compile() {

	eant -f build/build.xml jar $(use_doc javadoc) || die "compile problem" 
}

src_install() {
        java-pkg_dojar releases/${PV}-0/de_willuhn_util.jar

        use doc && java-pkg_dojavadoc dist/api
        use source && java-pkg_dosrc src/de
}
