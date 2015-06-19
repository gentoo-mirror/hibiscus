EAPI="2"
JAVA_PKG_IUSE="doc source"

WANT_ANT_TASKS="ant-nodeps"
inherit eutils java-pkg-2 java-ant-2 versionator

MY_PV="$(get_version_component_range 1-3)"
MY_PN="jameica.scripting"

DESCRIPTION="Scripting extension for Jameica"
HOMEPAGE="http://www.willuhn.de/products/jameica/extensions.php#${MY_PN}"
SRC_URI="https://github.com/willuhn/jameica.scripting/zipball/2cabf4a4c7db673cfee12e265169b9726d4a09b9 -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

COMMON_DEP=">=dev-java/jameica-1.10.0"
RDEPEND=">=virtual/jre-1.5
        ${COMMON_DEP}"

DEPEND=">=virtual/jdk-1.5
	app-arch/unzip
        ${COMMON_DEP}"

S="${WORKDIR}/${MY_PN}"

src_unpack() {
	default
	mv willuhn-${MY_PN}-* ${MY_PN}
}

java_prepare() {
	cd "${S}"
	rm -v build/BUILD

	EANT_GENTOO_CLASSPATH="jameica"
	mkdir lib
	java-pkg_jar-from --with-dependencies --into lib "${EANT_GENTOO_CLASSPATH}"
}

src_compile() {
        eant -f build/build.xml jar $(use_doc javadoc)
}

src_install() {
	local INST_DIR="/usr/share/jameica/plugins/${MY_PN}"

	dodir "$INST_DIR"
        insinto ${INST_DIR}
        doins releases/${MY_PV}-0/${MY_PN}/${MY_PN}.jar || die "doins failed"
	doins releases/${MY_PV}-0/${MY_PN}/plugin.xml || die "doins failed"

        #use doc && java-pkg_dojavadoc releases/${PV}-0/javadoc
        #use source && java-pkg_dosrc src/de
}
