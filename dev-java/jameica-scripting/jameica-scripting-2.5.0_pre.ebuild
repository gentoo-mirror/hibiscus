EAPI="2"
JAVA_PKG_IUSE="doc source"

WANT_ANT_TASKS="ant-nodeps"
inherit eutils java-pkg-2 java-ant-2 versionator

MY_PV="$(get_version_component_range 1-3)"
MY_PN="jameica.scripting"

DESCRIPTION="Scripting extension for Jameica"
HOMEPAGE="http://www.willuhn.de/products/jameica/extensions.php#${MY_PN}"
SRC_URI="http://www.willuhn.de/products/jameica/releases/nightly/${MY_PN}-${MY_PV}-nightly.src.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

# TODO We a jre with scripting support (USE="javascript"), can we map this via
# virtual/jre ?
COMMON_DEP=">=dev-java/jameica-2.3.0"
RDEPEND=">=virtual/jre-1.5
        ${COMMON_DEP}"

DEPEND=">=virtual/jdk-1.5
	app-arch/unzip
        ${COMMON_DEP}"

S="${WORKDIR}/${MY_PN}"

java_prepare() {
	epatch "${FILESDIR}/disable-examples.patch"
	epatch "${FILESDIR}/jre-missing-scripting.patch"
	
	cd "${S}"

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
