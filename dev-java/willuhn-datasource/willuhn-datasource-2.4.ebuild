EAPI="2"
JAVA_PKG_IUSE="doc source"

WANT_ANT_TASKS="ant-nodeps"
inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="An object relational mapper with RMI support"
HOMEPAGE="http://www.willuhn.de/products/jameica/"
SRC_URI="http://www.willuhn.de/products/jameica/releases/${PV}/datasource/de_willuhn_ds.src.zip -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

COMMON_DEP="~dev-java/willuhn-util-${PV}
	dev-java/mckoi"

RDEPEND=">=virtual/jre-1.5
        ${COMMON_DEP}"

DEPEND=">=virtual/jdk-1.5
	app-arch/unzip
        ${COMMON_DEP}"

S=${WORKDIR}

java_prepare() {

	#epatch "${FILESDIR}/${PV}-java7-api.patch"
	java-ant_rewrite-classpath build/build.xml
	eant -f build/build.xml clean
}

src_compile() {

	EANT_GENTOO_CLASSPATH="willuhn-util,mckoi-1" eant -f build/build.xml jar $(use_doc javadoc) 
#		-Dgentoo.classpath="$(java-pkg_getjars willuhn-util,mckoi-1)"
}

src_install() {
        java-pkg_dojar releases/${PV}-0/de_willuhn_ds.jar

        use doc && java-pkg_dojavadoc dist/api
        use source && java-pkg_dosrc src/de
}
