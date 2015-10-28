EAPI="5"
JAVA_PKG_IUSE="doc source"

WANT_ANT_TASKS="ant-nodeps"
inherit eutils java-pkg-2 java-ant-2

if [[ ${PV} != 9999 ]]; then
        SRC_URI="http://www.willuhn.de/products/jameica/releases/${PV}/util/de_willuhn_util.src.zip -> ${P}.zip"
        KEYWORDS="~amd64 ~x86"
else
        inherit git-r3
        EGIT_REPO_URI="https://github.com/willuhn/util.git"
fi

DESCRIPTION="A collection of small java helpers"
HOMEPAGE="http://www.willuhn.de/products/jameica/"

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

java_prepare() {

	eant -f build/build.xml clean
}

src_compile() {

	eant -f build/build.xml jar $(use_doc javadoc) || die "compile problem"
}

src_install() {
        java-pkg_dojar releases/*/de_willuhn_util.jar

        use doc && java-pkg_dojavadoc dist/api
        use source && java-pkg_dosrc src/de
}
