EAPI="2"
JAVA_PKG_IUSE="doc source"

WANT_ANT_TASKS="ant-nodeps"
inherit eutils java-pkg-2 java-ant-2 versionator

MY_PV="$(get_version_component_range 1-2)"

DESCRIPTION="A Java Framework and Runtime Environment"
HOMEPAGE="http://www.willuhn.de/products/jameica/"
SRC_URI="http://www.willuhn.de/products/${PN}/releases/${MY_PV}/${PN}/${PN}.src.zip -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

COMMON_DEP="~dev-java/willuhn-util-${MY_PV}
	~dev-java/willuhn-datasource-${MY_PV}
	dev-java/nanoxml
	dev-java/swt:3.5
	dev-java/velocity
        dev-java/xmlrpc
	dev-java/commons-cli
	dev-java/commons-collections
	dev-java/commons-lang
	dev-java/commons-logging
	dev-java/swtcalendar
	dev-java/bcprov
	dev-java/h2"

RDEPEND=">=virtual/jre-1.5
        ${COMMON_DEP}"

DEPEND=">=virtual/jdk-1.5
	app-arch/unzip
        ${COMMON_DEP}"

S=${WORKDIR}/${PN}

java_prepare() {
	cd ${S}/lib

	rm -vr apache_xmlrpc bouncycastle de_willuhn_ds de_willuhn_util h2 jakarta_commons mckoi mysql nanoxml swtcalendar velocity
	rm -vr swt/linux swt/linux64 swt/macos swt/macos64 swt/win32 swt/win64

	mkdir gentoo
	local xmlrpc
	xmlrpc="xmlrpc"
	if has_version ">=dev-java/xmlrpc-3"; then
		#TODO: How to reference slot instead of version ?
		xmlrpc="xmlrpc-3"
	fi
	java-pkg_jar-from --with-dependencies --into gentoo	willuhn-util,willuhn-datasource,nanoxml,swt-3.5,velocity,${xmlrpc},commons-cli-1,commons-collections,commons-lang-2.1,commons-logging,swtcalendar,bcprov,h2
}

src_compile() {
	eant -f build/build.xml jar $(use_doc javadoc)
}

src_install() {
        java-pkg_newjar releases/${PV}-0/jameica/jameica.jar

	java-pkg_newjar lib/swt/org.eclipse.core.runtime*.jar org.eclipse.core.runtime.jar
	java-pkg_newjar lib/swt/org.eclipse.jface*.jar org.eclipse.jface.jar
	java-pkg_newjar lib/swt/org.eclipse.osgi*.jar org.eclipse.osgi.jar
	java-pkg_newjar lib/swt/org.eclipse.ui.forms*.jar org.eclipse.ui.forms.jar

	insinto /usr/lib/${PN}
	doins plugin.xml
	dodir /usr/lib/${PN}/plugins
	
	java-pkg_dolauncher ${PN} --main de.willuhn.jameica.Main --pwd /usr/lib/jameica/

	newicon	build/${PN}-icon-01.png ${PN}-icon-01.png || die "newicon failed"
	newicon build/${PN}-icon-02.png ${PN}-icon-02.png || die "newicon failed"
	make_desktop_entry /usr/bin/jameica "Jameica" ${PN}-icon-01

        use doc && java-pkg_dojavadoc releases/${PV}-0/javadoc
        use source && java-pkg_dosrc src/de
}
