EAPI="5"
JAVA_PKG_IUSE="doc source"
WANT_ANT_TASKS="ant-nodeps"

inherit eutils java-pkg-2 java-ant-2 versionator

if [[ ${PV} != 9999 ]]; then
        SRC_URI="http://www.willuhn.de/products/hibiscus/releases/${MY_PV}/hibiscus.src.zip -> ${P}.zip"
        KEYWORDS="~amd64 ~x86"
				MY_PV="$(get_version_component_range 1-2)"
else
        inherit git-r3
        EGIT_REPO_URI="https://github.com/willuhn/hibiscus.git"
				MY_PV="9999"
fi

DESCRIPTION="A HBCI homebanking application based on hbci4java"
HOMEPAGE="http://www.willuhn.de/products/hibiscus/"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

COMMON_DEP="=dev-java/jameica-${MY_PV}*
            >=net-libs/willuhn-hbci4java-$PV
	          >=dev-java/obantoo-2.1.12
	          dev-java/super-csv
	          >=dev-java/swt-chart-0.7.0"

RDEPEND=">=virtual/jre-1.5
        ${COMMON_DEP}"

DEPEND=">=virtual/jdk-1.5
        ${COMMON_DEP}"

java_prepare() {
	epatch "${FILESDIR}/2.4.2-hbci4java-so-filename.patch"
	epatch "${FILESDIR}/super-csv-api.patch"

	rm -rv -v ${S}/lib/*

  java-pkg_jar-from --with-dependencies --into ${S}/lib/ willuhn-hbci4java,obantoo,jameica,super-csv,swt-chart
}

src_compile() {
	eant -f build/build.xml jar $(use_doc javadoc)
}

src_install() {

	local plugin_dir=/usr/share/jameica/plugins/hibiscus

	dodir ${plugin_dir}
	insinto ${plugin_dir}

	doins plugin.xml
	doins releases/*/${PN}/${PN}.jar

	cp -R "${S}/updates" "${D}${plugin_dir}" || die "Install failed!"
	cp -R "${S}/sql" "${D}${plugin_dir}" || die "Install failed!"

	dodir ${plugin_dir}/lib

	dosym "$(java-pkg_getjars willuhn-hbci4java)" ${plugin_dir}/lib/
	dosym "$(java-pkg_getjars obantoo)" ${plugin_dir}/lib/
	dosym "$(java-pkg_getjars super-csv)" ${plugin_dir}/lib/
	dosym "$(java-pkg_getjars itext-5)" ${plugin_dir}/lib/

	dosym "$(java-pkg_getjar swt-chart org.swtchart.jar)" ${plugin_dir}/lib/
	dosym "$(java-pkg_getjar swt-chart org.swtchart.ext.jar)" ${plugin_dir}/lib/

	newicon icons/${PN}-icon-16x16.png ${PN}-icon-16x16.png || die "newicon failed"
  newicon icons/${PN}-icon-32x32.png ${PN}-icon-32x32.png || die "newicon failed"
	newicon icons/${PN}-icon-64x64.png ${PN}-icon-64x64.png || die "newicon failed"

  use doc && java-pkg_dojavadoc releases/${PV}-0/javadoc
  use source && java-pkg_dosrc src/de
}
