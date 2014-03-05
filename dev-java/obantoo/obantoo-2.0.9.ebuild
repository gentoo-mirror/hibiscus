EAPI="2"
JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2 cvs

ECVS_SERVER="obantoo.cvs.sourceforge.net:/cvsroot/${PN}"
ECVS_MODULE="${PN}"
ECVS_DATE="\"2013-11-12 21:34:46 UTC\""

DESCRIPTION="A Java Library for HBCI (Homebanking Computer Interface) / FinTS (Financial Transaction Services)"
HOMEPAGE="http://obantoo.sourceforge.net/"
#SRC_URI="mirror://sourceforge/${PN}/${P}.zip"
#SRC_URI="http://${PN}.cvs.sourceforge.net/viewvc/${PN}/${PN}/?view=tar&revision=${CVS_REV} -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

COMMON_DEP="dev-java/itext:5"

RDEPEND=">=virtual/jre-1.6
        ${COMMON_DEP}"

DEPEND=">=virtual/jdk-1.6
	app-arch/unzip
	dev-java/junit:4
    ${COMMON_DEP}"

S=${WORKDIR}/${PN}

java_prepare() {
#	epatch ${FILESDIR}/${PV}-hibiscus-encoding.patch
	rm -rv lib/* || die
	eant clean
	java-pkg_jar-from itext-5 itext.jar ${S}/lib/itextpdf-5.3.3.jar
	java-pkg_jar-from junit-4 junit.jar ${S}/lib/junit-4.11.jar
}

#src_compile() {
#
#	local classpath="$(java-pkg_getjars itext-5)"
#
#	find src -name '*.java' > sources.list
#	ejavac -encoding latin1 -cp "${classpath}" -d bin @sources.list
#	jar cf ${PN}.jar -C bin/ .
#	# TODO: javadoc
#}

src_compile() {
	eant jar $(use_doc javadoc)
}

src_install() {
    java-pkg_newjar build/${PN}-bin-${PV}.jar

	use doc && dodoc doc/*
    use doc && java-pkg_dojavadoc javadoc

    use source && java-pkg_dosrc src/de
}
