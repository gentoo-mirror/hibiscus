EAPI="2"
JAVA_PKG_IUSE="doc source"
WANT_ANT_TASKS="ant-nodeps"

inherit eutils java-pkg-2 java-ant-2 versionator

MY_PV="$(get_version_component_range 1-2)"

DESCRIPTION="A HBCI homebanking application based on hbci4java"
HOMEPAGE="http://www.willuhn.de/products/hibiscus/"
SRC_URI="http://www.willuhn.de/products/hibiscus/releases/${MY_PV}/hibiscus.src.zip -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

COMMON_DEP="=dev-java/jameica-${MY_PV}*
        >=net-libs/willuhn-hbci4java-2.5.12_p20131208
	>=dev-java/obantoo-2.0.9
	>=dev-java/super-csv-1.31:0
	>=dev-java/swt-chart-0.7.0"

RDEPEND=">=virtual/jre-1.6
        ${COMMON_DEP}"

DEPEND=">=virtual/jdk-1.6
        ${COMMON_DEP}"

S=${WORKDIR}/${PN}

java_prepare() {
	#epatch "${FILESDIR}/${PV}-hbci4java-api.patch"
	epatch "${FILESDIR}/2.4.2-hbci4java-so-filename.patch"
	
    #rm -v ${S}/lib/*.{jar,so,dll,jnilib} || die
	#rm -rv ${S}/lib/swtchart
	rm -rv -v ${S}/lib/*

	#rm -v ${S}/lib/{itext-2.0.1.jar,obantoo-bin-1.5.1.jar,postgresql-8.3-604.jdbc3.jar,supercsv-1.31.jar,libct.so,libhbci4java-card-freebsd-64.so,libhbci4java-card-linux-32.so,libhbci4java-card-linux-64.so,libhbci4java-sizrdh-linux-gcc2.so,libhbci4java-sizrdh-linux-gcc3.so,libtowitoko-2.0.7-amd64.so,libtowitoko-2.0.7.so,hbci4java-card-win32.dll,hbci4java-card-win32_x86-64.dll,hbci4java-sizrdh-win32.dll,libhbci4java-card-mac-os-x-10.6.jnilib,libhbci4java-card-mac.jnilib} || die

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
    doins releases/${PV}-0/${PN}/${PN}.jar
	
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
