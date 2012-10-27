EAPI="2"
JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2

DESCRIPTION="A Java Library for HBCI (Homebanking Computer Interface) / FinTS (Financial Transaction Services)"
HOMEPAGE="http://obantoo.berlios.de/"
SRC_URI="http://download.berlios.de/${PN}/${P}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

COMMON_DEP="dev-java/itext"

RDEPEND=">=virtual/jre-1.4
        ${COMMON_DEP}"

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
        ${COMMON_DEP}"

S=${WORKDIR}

java_prepare() {
	epatch ${FILESDIR}/${PV}-hibiscus-encoding.patch
	rm -rv bin/* doc/api || die
}

src_compile() {

	local classpath="$(java-pkg_getjars itext)"

	find src -name '*.java' > sources.list
	ejavac -encoding latin1 -cp "${classpath}" -d bin @sources.list
	jar cf ${PN}.jar -C bin/ .
	# TODO: javadoc
}


src_install() {
        java-pkg_newjar ${PN}.jar

	use doc && dodoc doc/*
        use doc && java-pkg_dojavadoc javadoc

        use source && java-pkg_dosrc src/de
}
