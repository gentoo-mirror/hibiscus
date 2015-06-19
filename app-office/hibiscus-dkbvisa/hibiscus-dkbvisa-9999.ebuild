EAPI="4"

inherit eutils java-pkg-2

DESCRIPTION="Script for Hibiscus to retrieve VISA bookings from DKB bank"
HOMEPAGE="http://www.wiedenhoeft.net/hibiscus-scripting/dkbvisa"
SRC_URI="http://www.wiedenhoeft.net/download/dkbvisa.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-java/jameica-scripting-2.3.0
		>=app-office/hibiscus-2.3.0
		>=dev-java/htmlunit-2.7"

S=${WORKDIR}

src_install() {

	local plugin_dir=/usr/share/jameica/plugins/jameica.scripting

	dodir ${plugin_dir}/scripts
	insinto ${plugin_dir}/scripts
	doins dkbvisa.js
	
	dodir ${plugin_dir}/lib

	#dosym "$(java-pkg_getjars --with-dependencies htmlunit)" ${plugin_dir}/lib/
	IFS=':' ; 
	for jar in $(java-pkg_getjars --with-dependencies htmlunit);
		do dosym $jar ${plugin_dir}/lib/
	done
	#java-pkg_jar-from --with-dependencies --into ${plugin_dir}/lib/ "htmlunit"
}
