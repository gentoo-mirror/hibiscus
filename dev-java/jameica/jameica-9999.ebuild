EAPI="5"
JAVA_PKG_IUSE="doc source"

WANT_ANT_TASKS="ant-nodeps"
inherit eutils java-pkg-2 java-ant-2 versionator


if [[ ${PV} != 9999 ]]; then
        SRC_URI="http://www.willuhn.de/products/${PN}/releases/${MY_PV}/${PN}/${PN}.src.zip -> ${P}.zip"
        KEYWORDS="~amd64 ~x86"
				MY_PV="$(get_version_component_range 1-2)"
else
        inherit git-r3
        EGIT_REPO_URI="https://github.com/willuhn/jameica.git"
				MY_PV="9999"
fi

DESCRIPTION="A Java Framework and Runtime Environment"
HOMEPAGE="http://www.willuhn.de/products/jameica/"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

COMMON_DEP="~dev-java/willuhn-util-${MY_PV}
	~dev-java/willuhn-datasource-${MY_PV}
	>=dev-java/nanoxml-2.2.3
	>=dev-java/velocity-1.7
	>=dev-java/xmlrpc-3.1.3
	>=dev-java/commons-cli-1.2
	>=dev-java/commons-collections-3.2.1
	>=dev-java/commons-lang-2.6
	>=dev-java/commons-logging-1.2
	dev-java/swtcalendar
	dev-java/bcprov:1.45
	>=dev-java/h2-1.2.145
	>=dev-java/swt-paperclips-1.0.4
	dev-java/swt:4.2
	dev-java/eclipse-jface:3.1
	dev-java/eclipse-core-runtime:3.1
	dev-java/eclipse-osgi:3.1
	dev-java/eclipse-ui-forms:3.1"

RDEPEND=">=virtual/jre-1.6
    ${COMMON_DEP}"

DEPEND=">=virtual/jdk-1.6
	app-arch/unzip
	${COMMON_DEP}"

java_prepare() {
	rm -vr ${S}/lib/*
	cd ${S}/lib

	mkdir gentoo
	local xmlrpc
	xmlrpc="xmlrpc"
	if has_version ">=dev-java/xmlrpc-3"; then
		#TODO: How to reference slot instead of version ?
		xmlrpc="xmlrpc-3"
	fi

	EANT_GENTOO_CLASSPATH="swt-4.2,willuhn-util,willuhn-datasource,nanoxml,velocity,${xmlrpc},commons-cli-1,commons-collections,commons-lang-2.1,commons-logging,swtcalendar,bcprov-1.45,h2,swt-paperclips,eclipse-jface-3.1,eclipse-osgi-3.1,eclipse-ui-forms-3.1,eclipse-core-runtime-3.1"

	java-pkg_jar-from --with-dependencies --into gentoo "${EANT_GENTOO_CLASSPATH}"
}

src_compile() {
	eant -f build/build.xml jar $(use_doc javadoc)
}

src_install() {
    java-pkg_newjar releases/*/jameica/jameica.jar

	insinto /usr/share/${PN}
	doins plugin.xml
	dodir /usr/share/${PN}/plugins

	java-pkg_dolauncher ${PN} --main de.willuhn.jameica.Main --pwd /usr/share/jameica/

	newicon	build/${PN}-icon.png ${PN}-icon.png || die "newicon failed"
	make_desktop_entry jameica "Jameica" ${PN}-icon "Office;Finance"

    use doc && java-pkg_dojavadoc releases/${PV}-0/javadoc
    use source && java-pkg_dosrc src/de
}
