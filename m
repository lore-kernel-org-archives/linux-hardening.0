Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794669801;
	b=1BBGSqEnS9LFyYufN6EDMoNWWXK9SkKXE8ySrf3NQxp1/QAE1JfvuY4keDfIUxbKucZ/
	 rWIzjCh+2rGUasFYKvyURw1KljgE5oOudgQI0PwCufY+W/SpxyAi4DcocPRH4TzOFZknH
	 GYFbbw+zoYN0SJjzOmHuNk1iw+/FLPvKhYCui1YGE9XU3sQPlfZcXOBLJtcyvC3TxRLLP
	 ShRBsZjfrdCf81XGLH1g1g+UZ2YmMwioOzGqO8FJQSCP1ah1tlCc89HCEHDOZiDsHlJKj
	 qW5DIvY5kUpRFnsUlb9K3Y3gkWsody5C+6Ia+VKp4tZeolMyMNb2lrTYIcqJifWClzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669801;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KeoomdtgPmYL5462b5ICWAQ3wlzZJexuxoX/y2dxuCY=;
	b=RnhBV+uUGL1Tnkkl9Cl+ElcP8rbN5Hk1yndpdhBBLdYkGOZX5YzjakSoHvhHBz3/q4OG
	 R3tXxFVK7LV0GqfP6+8e6ZV22/B2Jnt2CdpSGcqmJvSdWJaATq0sibvxTqWMVyH/bHF7t
	 V6XLSaQbxXjthbFX5iKPVjqfIFJEzSSeBm9vQ/3HPEigY8w09R51DCH8gZ8agam/d1fNa
	 KuaDiN5OcCoZZK3UoMxaZnjFO0fxUyrP6V6JLCYVTQ1X+M0EFGxDy9UPIPSNuJQ/6r+JM
	 xuh6LVBUOZmaLmxspv+LS6Olkz1ukgfehx7zIuH/YG1KUQmPAL14MCUWDSnPsrN0EXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QeLU9qLW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0782606A323;
	Sat, 14 Nov 2026 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QeLU9qLW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD8B1F000C4;
	Sat, 14 Nov 2026 15:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794669800;
	bh=KeoomdtgPmYL5462b5ICWAQ3wlzZJexuxoX/y2dxuCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QeLU9qLWusuj+dxl9v4nrmHiNOIaIi7VNz7b4gS8U7licxfWFUK/3riZQKLe2slpM
	 C6koYvUU8OSw8jN0buNInglSoEjUGW9NLgIcVU2k3oEyhNOX3rLiZJbSKtjHONd4dF
	 rGNCbpRg8DUfyvjFTTrNcNj9O0AbkLTqlDh+Vx893G6dSm1U+ZnwdiTJZiDyGYAent
	 cG3LaGdnL8NL7Di9hE18i/ahSGEKvsmNFyE2Ul65RdikAIhJqHICXYjiX6UfOR0C/a
	 Sxq3PeCRVww+oQFxpbxEOCoJw2x8Ilbn69LPWfyufsmgHPaKY9a1WY5tom3c8r4UEF
	 i5a/sh4H64XIg==
Date: Sat, 14 Nov 2026 16:23:13 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, 
	Kees Cook <kees@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Linus Walleij <linusw@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: [PATCH v6 11/19] treewide: s/strstarts/strprefix/g
Message-ID: <782e2941d0f1be93c0dc1bcbe9b84993be0d1194.1794667407.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
References: <cover.1794667407.git.alx@kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i3cutcpsnd4nesfw"
Content-Disposition: inline
In-Reply-To: <cover.1794667407.git.alx@kernel.org>


--i3cutcpsnd4nesfw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, 
	Kees Cook <kees@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Linus Walleij <linusw@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: [PATCH v6 11/19] treewide: s/strstarts/strprefix/g
Message-ID: <782e2941d0f1be93c0dc1bcbe9b84993be0d1194.1794667407.git.alx@kernel.org>
References: <cover.1794667407.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794667407.git.alx@kernel.org>

This was a scripted change:

	$ git ls-files \
	| grep '\.[ch]$' \
	| grep -v -e ^tools/ -e ^scripts/ -e ^include/ \
	| xargs grep -l strstarts \
	| xargs sed -i 's/strstarts/strprefix/g';

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 arch/arm/kernel/module.c                      | 12 ++---
 arch/mips/bcm47xx/board.c                     |  4 +-
 arch/mips/bcm63xx/boards/board_bcm963xx.c     |  2 +-
 arch/powerpc/perf/imc-pmu.c                   |  2 +-
 crypto/essiv.c                                |  2 +-
 .../firmware/efi/libstub/efi-stub-helper.c    |  2 +-
 drivers/firmware/efi/libstub/gop.c            | 10 ++--
 drivers/gpu/drm/omapdrm/dss/base.c            |  2 +-
 .../gpu/drm/renesas/rcar-du/rcar_du_crtc.c    |  2 +-
 drivers/hid/hid-uclogic-params.c              |  2 +-
 drivers/input/mouse/psmouse-base.c            |  2 +-
 drivers/input/mouse/trackpoint.c              |  2 +-
 drivers/md/dm-crypt.c                         |  4 +-
 drivers/memory/tegra/tegra20.c                |  4 +-
 drivers/mtd/spi-nor/issi.c                    |  2 +-
 drivers/net/ethernet/intel/ice/ice_parser.c   | 10 ++--
 drivers/of/property.c                         |  2 +-
 drivers/pci/pwrctrl/core.c                    |  2 +-
 drivers/platform/x86/acerhdf.c                |  6 +--
 drivers/platform/x86/dell/dell-lis3lv02d.c    |  2 +-
 .../x86/hp/hp-bioscfg/spmobj-attributes.c     |  4 +-
 drivers/platform/x86/lenovo/thinkpad_acpi.c   | 54 +++++++++----------
 drivers/platform/x86/touchscreen_dmi.c        |  2 +-
 drivers/remoteproc/imx_dsp_rproc.c            |  2 +-
 drivers/remoteproc/imx_rproc.c                |  8 +--
 drivers/remoteproc/st_remoteproc.c            |  2 +-
 drivers/remoteproc/stm32_rproc.c              |  2 +-
 drivers/remoteproc/xlnx_r5_remoteproc.c       |  2 +-
 drivers/usb/dwc3/dwc3-pci.c                   |  2 +-
 drivers/usb/musb/musb_cppi41.c                |  4 +-
 drivers/usb/musb/musb_debugfs.c               | 20 +++----
 fs/smb/client/reparse.c                       | 14 ++---
 init/main.c                                   |  2 +-
 kernel/module/kallsyms.c                      |  2 +-
 kernel/module/main.c                          |  8 +--
 .../hda/codecs/side-codecs/tas2781_hda_i2c.c  |  6 +--
 36 files changed, 105 insertions(+), 105 deletions(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 55ca3fcd37e8..91af37789ecb 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -22,16 +22,16 @@
=20
 bool module_init_section(const char *name)
 {
-	return strstarts(name, ".init") ||
-		strstarts(name, ".ARM.extab.init") ||
-		strstarts(name, ".ARM.exidx.init");
+	return strprefix(name, ".init") ||
+		strprefix(name, ".ARM.extab.init") ||
+		strprefix(name, ".ARM.exidx.init");
 }
=20
 bool module_exit_section(const char *name)
 {
-	return strstarts(name, ".exit") ||
-		strstarts(name, ".ARM.extab.exit") ||
-		strstarts(name, ".ARM.exidx.exit");
+	return strprefix(name, ".exit") ||
+		strprefix(name, ".ARM.extab.exit") ||
+		strprefix(name, ".ARM.exidx.exit");
 }
=20
 #ifdef CONFIG_ARM_HAS_GROUP_RELOCS
diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
index b487f687f62d..25fa1ef36ce8 100644
--- a/arch/mips/bcm47xx/board.c
+++ b/arch/mips/bcm47xx/board.c
@@ -251,7 +251,7 @@ static __init const struct bcm47xx_board_type *bcm47xx_=
board_get_nvram(void)
=20
 	if (bcm47xx_nvram_getenv("hardware_version", buf1, sizeof(buf1)) >=3D 0) {
 		for (e1 =3D bcm47xx_board_list_hardware_version; e1->value1; e1++) {
-			if (strstarts(buf1, e1->value1))
+			if (strprefix(buf1, e1->value1))
 				return &e1->board;
 		}
 	}
@@ -259,7 +259,7 @@ static __init const struct bcm47xx_board_type *bcm47xx_=
board_get_nvram(void)
 	if (bcm47xx_nvram_getenv("hardware_version", buf1, sizeof(buf1)) >=3D 0 &&
 	    bcm47xx_nvram_getenv("boardnum", buf2, sizeof(buf2)) >=3D 0) {
 		for (e2 =3D bcm47xx_board_list_hw_version_num; e2->value1; e2++) {
-			if (!strstarts(buf1, e2->value1) &&
+			if (!strprefix(buf1, e2->value1) &&
 			    !strcmp(buf2, e2->value2))
 				return &e2->board;
 		}
diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/=
boards/board_bcm963xx.c
index 71628dac6c26..8083aeaab5b5 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -748,7 +748,7 @@ void __init board_prom_init(void)
=20
 	/* dump cfe version */
 	cfe =3D boot_addr + BCM963XX_CFE_VERSION_OFFSET;
-	if (strstarts(cfe, "cfe-")) {
+	if (strprefix(cfe, "cfe-")) {
 		if(cfe[4] =3D=3D 'v') {
 			if(cfe[5] =3D=3D 'd')
 				snprintf(cfe_version, 11, "%s",
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index a9f8464997a2..aff88b1fd3cf 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -1023,7 +1023,7 @@ static int thread_imc_event_init(struct perf_event *e=
vent)
=20
 static bool is_thread_imc_pmu(struct perf_event *event)
 {
-	return strstarts(event->pmu->name, "thread_imc");
+	return strprefix(event->pmu->name, "thread_imc");
 }
=20
 static __be64 *get_event_base_addr(struct perf_event *event)
diff --git a/crypto/essiv.c b/crypto/essiv.c
index a47a3eab6935..ee1bba6a48ce 100644
--- a/crypto/essiv.c
+++ b/crypto/essiv.c
@@ -508,7 +508,7 @@ static int essiv_create(struct crypto_template *tmpl, s=
truct rtattr **tb)
 			goto out_free_inst;
 		aead_alg =3D crypto_spawn_aead_alg(&ictx->u.aead_spawn);
 		block_base =3D &aead_alg->base;
-		if (!strstarts(block_base->cra_name, "authenc(")) {
+		if (!strprefix(block_base->cra_name, "authenc(")) {
 			pr_warn("Only authenc() type AEADs are supported by ESSIV\n");
 			err =3D -EINVAL;
 			goto out_drop_skcipher;
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmw=
are/efi/libstub/efi-stub-helper.c
index 8e43eb3f418b..fbd0dda856b8 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -104,7 +104,7 @@ efi_status_t efi_parse_options(char const *cmdline)
 			if (parse_option_str(val, "debug"))
 				efi_loglevel =3D CONSOLE_LOGLEVEL_DEBUG;
 		} else if (!strcmp(param, "video") &&
-			   val && strstarts(val, "efifb:")) {
+			   val && strprefix(val, "efifb:")) {
 			efi_parse_option_graphics(val + strlen("efifb:"));
 		}
 	}
diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libs=
tub/gop.c
index b800a6c2290c..c1cbf2b91867 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -42,7 +42,7 @@ static bool parse_modenum(char *option, char **next)
 {
 	u32 m;
=20
-	if (!strstarts(option, "mode=3D"))
+	if (!strprefix(option, "mode=3D"))
 		return false;
 	option +=3D strlen("mode=3D");
 	m =3D simple_strtoull(option, &option, 0);
@@ -68,10 +68,10 @@ static bool parse_res(char *option, char **next)
 	h =3D simple_strtoull(option, &option, 10);
 	if (*option =3D=3D '-') {
 		option++;
-		if (strstarts(option, "rgb")) {
+		if (strprefix(option, "rgb")) {
 			option +=3D strlen("rgb");
 			pf =3D PIXEL_RGB_RESERVED_8BIT_PER_COLOR;
-		} else if (strstarts(option, "bgr")) {
+		} else if (strprefix(option, "bgr")) {
 			option +=3D strlen("bgr");
 			pf =3D PIXEL_BGR_RESERVED_8BIT_PER_COLOR;
 		} else if (isdigit(*option))
@@ -93,7 +93,7 @@ static bool parse_res(char *option, char **next)
=20
 static bool parse_auto(char *option, char **next)
 {
-	if (!strstarts(option, "auto"))
+	if (!strprefix(option, "auto"))
 		return false;
 	option +=3D strlen("auto");
 	if (*option && *option++ !=3D ',')
@@ -106,7 +106,7 @@ static bool parse_auto(char *option, char **next)
=20
 static bool parse_list(char *option, char **next)
 {
-	if (!strstarts(option, "list"))
+	if (!strprefix(option, "list"))
 		return false;
 	option +=3D strlen("list");
 	if (*option && *option++ !=3D ',')
diff --git a/drivers/gpu/drm/omapdrm/dss/base.c b/drivers/gpu/drm/omapdrm/d=
ss/base.c
index a4ac113e1690..4179a89a4395 100644
--- a/drivers/gpu/drm/omapdrm/dss/base.c
+++ b/drivers/gpu/drm/omapdrm/dss/base.c
@@ -260,7 +260,7 @@ static bool omapdss_component_is_loaded(struct omapdss_=
comp_node *comp)
 {
 	if (comp->dss_core_component)
 		return true;
-	if (!strstarts(comp->compat, "omapdss,"))
+	if (!strprefix(comp->compat, "omapdss,"))
 		return true;
 	if (omapdss_device_is_registered(comp->node))
 		return true;
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c b/drivers/gpu/d=
rm/renesas/rcar-du/rcar_du_crtc.c
index 59c2a4b76137..60aa8720f622 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
@@ -1051,7 +1051,7 @@ static int rcar_du_crtc_parse_crc_source(struct rcar_=
du_crtc *rcrtc,
 	} else if (!strcmp(source_name, "auto")) {
 		*source =3D VSP1_DU_CRC_OUTPUT;
 		return 0;
-	} else if (strstarts(source_name, "plane")) {
+	} else if (strprefix(source_name, "plane")) {
 		unsigned int i;
=20
 		*source =3D VSP1_DU_CRC_PLANE;
diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-par=
ams.c
index ed16f50f21ed..fc8297d76a3c 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -1270,7 +1270,7 @@ static bool uclogic_params_ugee_v2_has_battery(struct=
 hid_device *hdev)
 	    hdev->product =3D=3D USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L) {
 		struct usb_device *udev =3D hid_to_usb_dev(hdev);
=20
-		if (strstarts(udev->product, "Deco LW"))
+		if (strprefix(udev->product, "Deco LW"))
 			return true;
 	}
=20
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmou=
se-base.c
index 23164688210d..3f5556227acb 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -513,7 +513,7 @@ bool psmouse_matches_pnp_id(struct psmouse *psmouse, co=
nst char * const ids[])
 	struct serio *serio =3D psmouse->ps2dev.serio;
 	const char *p =3D serio->firmware_id;
=20
-	if (!strstarts(p, "PNP: "))
+	if (!strprefix(p, "PNP: "))
 		return false;
=20
 	p +=3D 5;
diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpo=
int.c
index 3bd8fdf56cd3..b7fc22ffd174 100644
--- a/drivers/input/mouse/trackpoint.c
+++ b/drivers/input/mouse/trackpoint.c
@@ -418,7 +418,7 @@ static bool trackpoint_is_dt_capable(const char *pnp_id)
 		return false;
=20
 	/* Must start with "PNP: LEN03" */
-	if (!strstarts(pnp_id, "PNP: LEN03"))
+	if (!strprefix(pnp_id, "PNP: LEN03"))
 		return false;
=20
 	/* Ensure enough length before comparing */
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index a7655bba7ce3..e3ce3880f3f1 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -2847,7 +2847,7 @@ static int crypt_ctr_auth_cipher(struct crypt_config =
*cc, char *cipher_api)
 	char *start, *end, *mac_alg =3D NULL;
 	struct crypto_ahash *mac;
=20
-	if (!strstarts(cipher_api, "authenc("))
+	if (!strprefix(cipher_api, "authenc("))
 		return 0;
=20
 	start =3D strchr(cipher_api, '(');
@@ -3051,7 +3051,7 @@ static int crypt_ctr_cipher(struct dm_target *ti, cha=
r *cipher_in, char *key)
 		return -ENOMEM;
 	}
=20
-	if (strstarts(cipher_in, "capi:"))
+	if (strprefix(cipher_in, "capi:"))
 		ret =3D crypt_ctr_cipher_new(ti, cipher_in, key, &ivmode, &ivopts);
 	else
 		ret =3D crypt_ctr_cipher_old(ti, cipher_in, key, &ivmode, &ivopts);
diff --git a/drivers/memory/tegra/tegra20.c b/drivers/memory/tegra/tegra20.c
index 27dd6886f86e..edb4d10ae36d 100644
--- a/drivers/memory/tegra/tegra20.c
+++ b/drivers/memory/tegra/tegra20.c
@@ -408,8 +408,8 @@ tegra20_mc_of_icc_xlate_extended(const struct of_phandl=
e_args *spec, void *data)
 		ndata->node =3D node;
=20
 		/* these clients are isochronous by default */
-		if (strstarts(node->name, "display") ||
-		    strstarts(node->name, "vi"))
+		if (strprefix(node->name, "display") ||
+		    strprefix(node->name, "vi"))
 			ndata->tag =3D TEGRA_MC_ICC_TAG_ISO;
 		else
 			ndata->tag =3D TEGRA_MC_ICC_TAG_DEFAULT;
diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index 2f057d731df2..7fb8fc7b6b8f 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -138,7 +138,7 @@ static bool issi_pm25lv_match(const struct spi_nor *nor)
 {
 	const char *name =3D nor->info ? nor->info->name : NULL;
=20
-	return name && strstarts(name, "pm25lv");
+	return name && strprefix(name, "pm25lv");
 }
=20
 static const struct spi_nor_fixup issi_fixup_list[] =3D {
diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethe=
rnet/intel/ice/ice_parser.c
index d239102c52ff..0db6407d7453 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.c
+++ b/drivers/net/ethernet/intel/ice/ice_parser.c
@@ -1375,15 +1375,15 @@ static void ice_parse_lbl_item(struct ice_hw *hw, u=
16 idx, void *item,
 	lbl_item->idx =3D lbl_data->idx;
 	memcpy(lbl_item->label, lbl_data->label, sizeof(lbl_item->label));
=20
-	if (strstarts(lbl_item->label, ICE_LBL_BST_DVM))
+	if (strprefix(lbl_item->label, ICE_LBL_BST_DVM))
 		lbl_item->type =3D ICE_LBL_BST_TYPE_DVM;
-	else if (strstarts(lbl_item->label, ICE_LBL_BST_SVM))
+	else if (strprefix(lbl_item->label, ICE_LBL_BST_SVM))
 		lbl_item->type =3D ICE_LBL_BST_TYPE_SVM;
-	else if (strstarts(lbl_item->label, ICE_LBL_TNL_VXLAN))
+	else if (strprefix(lbl_item->label, ICE_LBL_TNL_VXLAN))
 		lbl_item->type =3D ICE_LBL_BST_TYPE_VXLAN;
-	else if (strstarts(lbl_item->label, ICE_LBL_TNL_GENEVE))
+	else if (strprefix(lbl_item->label, ICE_LBL_TNL_GENEVE))
 		lbl_item->type =3D ICE_LBL_BST_TYPE_GENEVE;
-	else if (strstarts(lbl_item->label, ICE_LBL_TNL_UDP_ECPRI))
+	else if (strprefix(lbl_item->label, ICE_LBL_TNL_UDP_ECPRI))
 		lbl_item->type =3D ICE_LBL_BST_TYPE_UDP_ECPRI;
=20
 	if (hw->debug_mask & ICE_DBG_PARSER)
diff --git a/drivers/of/property.c b/drivers/of/property.c
index 45e55f618488..f0729619a2a0 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1421,7 +1421,7 @@ DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 static struct device_node *parse_pinctrl_n(struct device_node *np,
 					   const char *prop_name, int index)
 {
-	if (!strstarts(prop_name, "pinctrl-"))
+	if (!strprefix(prop_name, "pinctrl-"))
 		return NULL;
=20
 	if (!isdigit(prop_name[strlen("pinctrl-")]))
diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 0e2387cf4657..4544352d39c0 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -159,7 +159,7 @@ static bool pci_pwrctrl_is_required(struct device_node =
*np)
 	if (ret < 0)
 		return false;
=20
-	if (!strstarts(compat, "pci"))
+	if (!strprefix(compat, "pci"))
 		return false;
=20
 	if (of_pci_supply_present(np))
diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 5ce5ad3efe69..25540b169339 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -582,9 +582,9 @@ static int __init acerhdf_check_hardware(void)
 		 * check if actual hardware BIOS vendor, product and version
 		 * IDs start with the strings of BIOS table entry
 		 */
-		if (strstarts(vendor, bt->vendor) &&
-		    strstarts(product, bt->product) &&
-		    strstarts(version, bt->version)) {
+		if (strprefix(vendor, bt->vendor) &&
+		    strprefix(product, bt->product) &&
+		    strprefix(version, bt->version)) {
 			found =3D 1;
 			break;
 		}
diff --git a/drivers/platform/x86/dell/dell-lis3lv02d.c b/drivers/platform/=
x86/dell/dell-lis3lv02d.c
index fe52bcd896f7..8ff52a7a9242 100644
--- a/drivers/platform/x86/dell/dell-lis3lv02d.c
+++ b/drivers/platform/x86/dell/dell-lis3lv02d.c
@@ -106,7 +106,7 @@ static bool i2c_adapter_is_main_i801(struct i2c_adapter=
 *adap)
 	 * Only match the main I801 adapter and reject secondary adapters
 	 * which names start with "SMBus I801 IDF adapter".
 	 */
-	return strstarts(adap->name, "SMBus I801 adapter");
+	return strprefix(adap->name, "SMBus I801 adapter");
 }
=20
 static int find_i801(struct device *dev, void *data)
diff --git a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c b/drive=
rs/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
index a38d200bd0d9..dd50581a1572 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
@@ -49,7 +49,7 @@ size_t hp_calculate_security_buffer(const char *authentic=
ation)
=20
 	authlen =3D strlen(authentication);
 	size =3D sizeof(u16) + authlen * sizeof(u16);
-	if (!strstarts(authentication, BEAM_PREFIX))
+	if (!strprefix(authentication, BEAM_PREFIX))
 		size +=3D strlen(UTF_PREFIX) * sizeof(u16);
=20
 	return size;
@@ -70,7 +70,7 @@ int hp_populate_security_buffer(u16 *authbuf, const char =
*authentication)
 	char *prefix =3D NULL;
 	int ret =3D 0;
=20
-	if (strstarts(authentication, BEAM_PREFIX)) {
+	if (strprefix(authentication, BEAM_PREFIX)) {
 		/*
 		 * BEAM_PREFIX is append to authbuf when a signature
 		 * is provided and Sure Admin is enabled in BIOS
diff --git a/drivers/platform/x86/lenovo/thinkpad_acpi.c b/drivers/platform=
/x86/lenovo/thinkpad_acpi.c
index 4f81855ad721..293ef2e2c9a5 100644
--- a/drivers/platform/x86/lenovo/thinkpad_acpi.c
+++ b/drivers/platform/x86/lenovo/thinkpad_acpi.c
@@ -1311,9 +1311,9 @@ static int tpacpi_rfk_procfs_write(const enum tpacpi_=
rfk_id id, char *buf)
 		return -ENODEV;
=20
 	while ((cmd =3D strsep(&buf, ","))) {
-		if (strstarts(cmd, "enable"))
+		if (strprefix(cmd, "enable"))
 			status =3D TPACPI_RFK_RADIO_ON;
-		else if (strstarts(cmd, "disable"))
+		else if (strprefix(cmd, "disable"))
 			status =3D TPACPI_RFK_RADIO_OFF;
 		else
 			return -EINVAL;
@@ -4119,12 +4119,12 @@ static int hotkey_write(char *buf)
=20
 	res =3D 0;
 	while ((cmd =3D strsep(&buf, ","))) {
-		if (strstarts(cmd, "enable")) {
+		if (strprefix(cmd, "enable")) {
 			hotkey_enabledisable_warn(1);
-		} else if (strstarts(cmd, "disable")) {
+		} else if (strprefix(cmd, "disable")) {
 			hotkey_enabledisable_warn(0);
 			res =3D -EPERM;
-		} else if (strstarts(cmd, "reset")) {
+		} else if (strprefix(cmd, "reset")) {
 			mask =3D (hotkey_all_mask | hotkey_source_mask)
 				& ~hotkey_reserved_mask;
 		} else if (sscanf(cmd, "0x%x", &mask) =3D=3D 1) {
@@ -5043,33 +5043,33 @@ static int video_write(char *buf)
 	disable =3D 0;
=20
 	while ((cmd =3D strsep(&buf, ","))) {
-		if (strstarts(cmd, "lcd_enable")) {
+		if (strprefix(cmd, "lcd_enable")) {
 			enable |=3D TP_ACPI_VIDEO_S_LCD;
-		} else if (strstarts(cmd, "lcd_disable")) {
+		} else if (strprefix(cmd, "lcd_disable")) {
 			disable |=3D TP_ACPI_VIDEO_S_LCD;
-		} else if (strstarts(cmd, "crt_enable")) {
+		} else if (strprefix(cmd, "crt_enable")) {
 			enable |=3D TP_ACPI_VIDEO_S_CRT;
-		} else if (strstarts(cmd, "crt_disable")) {
+		} else if (strprefix(cmd, "crt_disable")) {
 			disable |=3D TP_ACPI_VIDEO_S_CRT;
 		} else if (video_supported =3D=3D TPACPI_VIDEO_NEW &&
-			   strstarts(cmd, "dvi_enable")) {
+			   strprefix(cmd, "dvi_enable")) {
 			enable |=3D TP_ACPI_VIDEO_S_DVI;
 		} else if (video_supported =3D=3D TPACPI_VIDEO_NEW &&
-			   strstarts(cmd, "dvi_disable")) {
+			   strprefix(cmd, "dvi_disable")) {
 			disable |=3D TP_ACPI_VIDEO_S_DVI;
-		} else if (strstarts(cmd, "auto_enable")) {
+		} else if (strprefix(cmd, "auto_enable")) {
 			res =3D video_autosw_set(1);
 			if (res)
 				return res;
-		} else if (strstarts(cmd, "auto_disable")) {
+		} else if (strprefix(cmd, "auto_disable")) {
 			res =3D video_autosw_set(0);
 			if (res)
 				return res;
-		} else if (strstarts(cmd, "video_switch")) {
+		} else if (strprefix(cmd, "video_switch")) {
 			res =3D video_outputsw_cycle();
 			if (res)
 				return res;
-		} else if (strstarts(cmd, "expand_toggle")) {
+		} else if (strprefix(cmd, "expand_toggle")) {
 			res =3D video_expand_toggle();
 			if (res)
 				return res;
@@ -5458,9 +5458,9 @@ static int light_write(char *buf)
 		return -ENODEV;
=20
 	while ((cmd =3D strsep(&buf, ","))) {
-		if (strstarts(cmd, "on")) {
+		if (strprefix(cmd, "on")) {
 			newstatus =3D 1;
-		} else if (strstarts(cmd, "off")) {
+		} else if (strprefix(cmd, "off")) {
 			newstatus =3D 0;
 		} else
 			return -EINVAL;
@@ -6983,10 +6983,10 @@ static int brightness_write(char *buf)
 		return level;
=20
 	while ((cmd =3D strsep(&buf, ","))) {
-		if (strstarts(cmd, "up")) {
+		if (strprefix(cmd, "up")) {
 			if (level < bright_maxlvl)
 				level++;
-		} else if (strstarts(cmd, "down")) {
+		} else if (strprefix(cmd, "down")) {
 			if (level > 0)
 				level--;
 		} else if (sscanf(cmd, "level %d", &level) =3D=3D 1 &&
@@ -7731,13 +7731,13 @@ static int volume_write(char *buf)
=20
 	while ((cmd =3D strsep(&buf, ","))) {
 		if (!tp_features.mixer_no_level_control) {
-			if (strstarts(cmd, "up")) {
+			if (strprefix(cmd, "up")) {
 				if (new_mute)
 					new_mute =3D 0;
 				else if (new_level < TP_EC_VOLUME_MAX)
 					new_level++;
 				continue;
-			} else if (strstarts(cmd, "down")) {
+			} else if (strprefix(cmd, "down")) {
 				if (new_mute)
 					new_mute =3D 0;
 				else if (new_level > 0)
@@ -7749,9 +7749,9 @@ static int volume_write(char *buf)
 				continue;
 			}
 		}
-		if (strstarts(cmd, "mute"))
+		if (strprefix(cmd, "mute"))
 			new_mute =3D TP_EC_AUDIO_MUTESW_MSK;
-		else if (strstarts(cmd, "unmute"))
+		else if (strprefix(cmd, "unmute"))
 			new_mute =3D 0;
 		else
 			return -EINVAL;
@@ -9245,9 +9245,9 @@ static int fan_write_cmd_level(const char *cmd, int *=
rc)
 {
 	int level;
=20
-	if (strstarts(cmd, "level auto"))
+	if (strprefix(cmd, "level auto"))
 		level =3D TP_EC_FAN_AUTO;
-	else if (strstarts(cmd, "level disengaged") || strstarts(cmd, "level full=
-speed"))
+	else if (strprefix(cmd, "level disengaged") || strprefix(cmd, "level full=
-speed"))
 		level =3D TP_EC_FAN_FULLSPEED;
 	else if (sscanf(cmd, "level %d", &level) !=3D 1)
 		return 0;
@@ -9265,7 +9265,7 @@ static int fan_write_cmd_level(const char *cmd, int *=
rc)
=20
 static int fan_write_cmd_enable(const char *cmd, int *rc)
 {
-	if (!strstarts(cmd, "enable"))
+	if (!strprefix(cmd, "enable"))
 		return 0;
=20
 	*rc =3D fan_set_enable();
@@ -9280,7 +9280,7 @@ static int fan_write_cmd_enable(const char *cmd, int =
*rc)
=20
 static int fan_write_cmd_disable(const char *cmd, int *rc)
 {
-	if (!strstarts(cmd, "disable"))
+	if (!strprefix(cmd, "disable"))
 		return 0;
=20
 	*rc =3D fan_set_disable();
diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/=
touchscreen_dmi.c
index d83c387821ea..72f18dfc4368 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -1877,7 +1877,7 @@ static void ts_dmi_add_props(struct i2c_client *clien=
t)
 	int error;
=20
 	if (has_acpi_companion(dev) &&
-	    strstarts(client->name, ts_data->acpi_name)) {
+	    strprefix(client->name, ts_data->acpi_name)) {
 		error =3D device_create_managed_software_node(dev, ts_data->properties, =
NULL);
 		if (error)
 			dev_err(dev, "failed to add properties: %d\n", error);
diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_ds=
p_rproc.c
index 96d619daf3f5..8e8085f27a64 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -699,7 +699,7 @@ static int imx_dsp_rproc_add_carveout(struct imx_dsp_rp=
roc *priv)
 		 * Ignore the first memory region which will be used vdev buffer.
 		 * No need to do extra handlings, rproc_add_virtio_dev will handle it.
 		 */
-		if (strstarts(res.name, "vdev0buffer"))
+		if (strprefix(res.name, "vdev0buffer"))
 			continue;
=20
 		if (imx_dsp_rproc_sys_to_da(priv, res.start, resource_size(&res), &da))
diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 581bb07f5893..9f39e1a10f99 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -656,10 +656,10 @@ static int imx_rproc_prepare(struct rproc *rproc)
 		 * Ignore the first memory region which will be used vdev buffer.
 		 * No need to do extra handlings, rproc_add_virtio_dev will handle it.
 		 */
-		if (strstarts(res.name, "vdev0buffer"))
+		if (strprefix(res.name, "vdev0buffer"))
 			continue;
=20
-		if (strstarts(res.name, "rsc-table"))
+		if (strprefix(res.name, "rsc-table"))
 			continue;
=20
 		/* No need to translate pa to da, i.MX use same map */
@@ -834,7 +834,7 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
 		}
=20
 		/* Not map vdevbuffer, vdevring region */
-		if (strstarts(res.name, "vdev"))
+		if (strprefix(res.name, "vdev"))
 			continue;
=20
 		if (b >=3D IMX_RPROC_MEM_MAX)
@@ -848,7 +848,7 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
 		}
 		priv->mem[b].sys_addr =3D res.start;
 		priv->mem[b].size =3D resource_size(&res);
-		if (strstarts(res.name, "rsc-table"))
+		if (strprefix(res.name, "rsc-table"))
 			priv->rsc_table =3D priv->mem[b].cpu_addr;
 		b++;
 	}
diff --git a/drivers/remoteproc/st_remoteproc.c b/drivers/remoteproc/st_rem=
oteproc.c
index 486180cdccb4..3a351313b0c1 100644
--- a/drivers/remoteproc/st_remoteproc.c
+++ b/drivers/remoteproc/st_remoteproc.c
@@ -106,7 +106,7 @@ static int st_rproc_parse_fw(struct rproc *rproc, const=
 struct firmware *fw)
 			return ret;
=20
 		/*  No need to map vdev buffer */
-		if (!strstarts(res.name, "vdev0buffer")) {
+		if (!strprefix(res.name, "vdev0buffer")) {
 			/* Register memory region */
 			mem =3D rproc_mem_entry_init(dev, NULL,
 						   (dma_addr_t)res.start,
diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rp=
roc.c
index a47e040c6db8..254ebc820721 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -203,7 +203,7 @@ static int stm32_rproc_prepare(struct rproc *rproc)
 		}
=20
 		/*  No need to map vdev buffer */
-		if (!strstarts(res.name, "vdev0buffer")) {
+		if (!strprefix(res.name, "vdev0buffer")) {
 			/* Register memory region */
 			mem =3D rproc_mem_entry_init(dev, NULL,
 						   (dma_addr_t)res.start,
diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/x=
lnx_r5_remoteproc.c
index a9873a37dd8f..6b2eaa221334 100644
--- a/drivers/remoteproc/xlnx_r5_remoteproc.c
+++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
@@ -471,7 +471,7 @@ static int add_mem_regions_carveout(struct rproc *rproc)
 		if (err)
 			return 0;
=20
-		if (strstarts(res.name, "vdev0buffer")) {
+		if (strprefix(res.name, "vdev0buffer")) {
 			/* Init reserved memory for vdev buffer */
 			rproc_mem =3D rproc_of_resm_mem_entry_init(&rproc->dev, i,
 								 resource_size(&res),
diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 6c1cbb722ca8..21e6e14ced31 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -301,7 +301,7 @@ static int dwc3_pci_quirks(struct dwc3_pci *dwc,
 			    acpi_quirk_skip_acpi_ac_and_battery() &&
 			    /* Lenovo Yoga Tablet 2 Pro 1380 uses LC824206XA instead */
 			    !(bios_ver &&
-			      strstarts(bios_ver, "BLADE_21.X64.0005.R00.1504101516"))) {
+			      strprefix(bios_ver, "BLADE_21.X64.0005.R00.1504101516"))) {
 				dev_info(&pdev->dev, "Using TUSB1211 phy for charger detection\n");
 				swnode =3D &dwc3_pci_intel_phy_charger_detect_swnode;
 			}
diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
index 28e958fcc862..c0786ad5a97f 100644
--- a/drivers/usb/musb/musb_cppi41.c
+++ b/drivers/usb/musb/musb_cppi41.c
@@ -686,9 +686,9 @@ static int cppi41_dma_controller_start(struct cppi41_dm=
a_controller *controller)
 		ret =3D of_property_read_string_index(np, "dma-names", i, &str);
 		if (ret)
 			goto err;
-		if (strstarts(str, "tx"))
+		if (strprefix(str, "tx"))
 			is_tx =3D 1;
-		else if (strstarts(str, "rx"))
+		else if (strprefix(str, "rx"))
 			is_tx =3D 0;
 		else {
 			dev_err(dev, "Wrong dmatype %s\n", str);
diff --git a/drivers/usb/musb/musb_debugfs.c b/drivers/usb/musb/musb_debugf=
s.c
index 5092d62c2062..97cf89c6e451 100644
--- a/drivers/usb/musb/musb_debugfs.c
+++ b/drivers/usb/musb/musb_debugfs.c
@@ -179,36 +179,36 @@ static ssize_t musb_test_mode_write(struct file *file,
 		goto ret;
 	}
=20
-	if (strstarts(buf, "force host full-speed"))
+	if (strprefix(buf, "force host full-speed"))
 		test =3D MUSB_TEST_FORCE_HOST | MUSB_TEST_FORCE_FS;
=20
-	else if (strstarts(buf, "force host high-speed"))
+	else if (strprefix(buf, "force host high-speed"))
 		test =3D MUSB_TEST_FORCE_HOST | MUSB_TEST_FORCE_HS;
=20
-	else if (strstarts(buf, "force host"))
+	else if (strprefix(buf, "force host"))
 		test =3D MUSB_TEST_FORCE_HOST;
=20
-	else if (strstarts(buf, "fifo access"))
+	else if (strprefix(buf, "fifo access"))
 		test =3D MUSB_TEST_FIFO_ACCESS;
=20
-	else if (strstarts(buf, "force full-speed"))
+	else if (strprefix(buf, "force full-speed"))
 		test =3D MUSB_TEST_FORCE_FS;
=20
-	else if (strstarts(buf, "force high-speed"))
+	else if (strprefix(buf, "force high-speed"))
 		test =3D MUSB_TEST_FORCE_HS;
=20
-	else if (strstarts(buf, "test packet")) {
+	else if (strprefix(buf, "test packet")) {
 		test =3D MUSB_TEST_PACKET;
 		musb_load_testpacket(musb);
 	}
=20
-	else if (strstarts(buf, "test K"))
+	else if (strprefix(buf, "test K"))
 		test =3D MUSB_TEST_K;
=20
-	else if (strstarts(buf, "test J"))
+	else if (strprefix(buf, "test J"))
 		test =3D MUSB_TEST_J;
=20
-	else if (strstarts(buf, "test SE0 NAK"))
+	else if (strprefix(buf, "test SE0 NAK"))
 		test =3D MUSB_TEST_SE0_NAK;
=20
 	musb_writeb(musb->mregs, MUSB_TESTMODE, test);
diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
index 3a27773186ae..d35af97cdbad 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -97,7 +97,7 @@ static int create_native_symlink(const unsigned int xid, =
struct inode *inode,
 		 * ensure compatibility of this symlink stored in absolute form
 		 * on the SMB server.
 		 */
-		if (!strstarts(symname, symroot)) {
+		if (!strprefix(symname, symroot)) {
 			/*
 			 * If the absolute Linux symlink target path is not
 			 * inside "symlinkroot" location then there is no way
@@ -171,7 +171,7 @@ static int create_native_symlink(const unsigned int xid=
, struct inode *inode,
 	 * letter so the prefix occupies six characters in UTF-16 too.
 	 */
 	if (!(sbflags & CIFS_MOUNT_POSIX_PATHS) && symname[0] =3D=3D '/') {
-		if (!strstarts(sym, "\\??\\") || !isascii(sym[4]) ||
+		if (!strprefix(sym, "\\??\\") || !isascii(sym[4]) ||
 		    !isalpha(sym[4]) || sym[5] !=3D ':') {
 			rc =3D -EINVAL;
 			goto out;
@@ -905,11 +905,11 @@ int smb2_parse_native_symlink(char **target, const ch=
ar *buf, unsigned int len,
 		 */
 		abs_path =3D smb_target;
 globalroot:
-		if (strstarts(abs_path, "\\??\\"))
+		if (strprefix(abs_path, "\\??\\"))
 			abs_path +=3D sizeof("\\??\\")-1;
-		else if (strstarts(abs_path, "\\DosDevices\\"))
+		else if (strprefix(abs_path, "\\DosDevices\\"))
 			abs_path +=3D sizeof("\\DosDevices\\")-1;
-		else if (strstarts(abs_path, "\\GLOBAL??\\"))
+		else if (strprefix(abs_path, "\\GLOBAL??\\"))
 			abs_path +=3D sizeof("\\GLOBAL??\\")-1;
 		else
 			goto out_unhandled_target;
@@ -918,10 +918,10 @@ int smb2_parse_native_symlink(char **target, const ch=
ar *buf, unsigned int len,
 		if (abs_path[0] =3D=3D '\\')
 			abs_path++;
=20
-		while (strstarts(abs_path, "Global\\"))
+		while (strprefix(abs_path, "Global\\"))
 			abs_path +=3D sizeof("Global\\")-1;
=20
-		if (strstarts(abs_path, "GLOBALROOT\\")) {
+		if (strprefix(abs_path, "GLOBALROOT\\")) {
 			/* Label globalroot requires path with leading '\\', so do not trim '\\=
' */
 			abs_path +=3D sizeof("GLOBALROOT")-1;
 			goto globalroot;
diff --git a/init/main.c b/init/main.c
index 7b0c8c34e6a9..44513443d127 100644
--- a/init/main.c
+++ b/init/main.c
@@ -586,7 +586,7 @@ static int __init unknown_bootoption(char *param, char =
*val,
=20
 	/* Handle bootloader identifier */
 	for (int i =3D 0; bootloader[i]; i++) {
-		if (strstarts(param, bootloader[i]))
+		if (strprefix(param, bootloader[i]))
 			return 0;
 	}
=20
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 1ff8ce857d92..bcdf2ebe0d32 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -68,7 +68,7 @@ static char elf_type(const Elf_Sym *sym, const struct loa=
d_info *info)
 		else
 			return 'b';
 	}
-	if (strstarts(info->secstrings + sechdrs[sym->st_shndx].sh_name,
+	if (strprefix(info->secstrings + sechdrs[sym->st_shndx].sh_name,
 		      ".debug")) {
 		return 'n';
 	}
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 34e0204ea37c..d97502225b3d 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1195,7 +1195,7 @@ static bool verify_module_namespace(const char *names=
pace, const char *modname)
 	const char *sep;
 	bool glob;
=20
-	if (!strstarts(namespace, prefix))
+	if (!strprefix(namespace, prefix))
 		return false;
=20
 	for (namespace +=3D strlen(prefix); *namespace; namespace =3D sep) {
@@ -1836,7 +1836,7 @@ static int setup_modinfo(struct module *mod, struct l=
oad_info *info)
 		 * 'module:' prefixed namespaces are implicit, disallow
 		 * explicit imports.
 		 */
-		if (strstarts(imported_namespace, "module:")) {
+		if (strprefix(imported_namespace, "module:")) {
 			pr_err("%s: module tries to import module namespace: %s\n",
 			       mod->name, imported_namespace);
 			return -EPERM;
@@ -1863,12 +1863,12 @@ static void free_modinfo(struct module *mod)
=20
 bool __weak module_init_section(const char *name)
 {
-	return strstarts(name, ".init");
+	return strprefix(name, ".init");
 }
=20
 bool __weak module_exit_section(const char *name)
 {
-	return strstarts(name, ".exit");
+	return strprefix(name, ".exit");
 }
=20
 static int validate_section_offset(const struct load_info *info, Elf_Shdr =
*shdr)
diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/cod=
ecs/side-codecs/tas2781_hda_i2c.c
index 0c8faa583baa..bf24dce50e23 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -636,14 +636,14 @@ static int tas2781_hda_i2c_probe(struct i2c_client *c=
lt)
 		tas_hda->priv->chip_id =3D TAS2781;
 		hda_priv->save_calibration =3D tas2781_save_calibration;
 		tas_hda->priv->global_addr =3D TAS2781_GLOBAL_ADDR;
-	} else if (strstarts(dev_name(&clt->dev), "i2c-TXNW2770")) {
+	} else if (strprefix(dev_name(&clt->dev), "i2c-TXNW2770")) {
 		/*
 		 * TAS2770, has no on-chip DSP, so no calibration data
 		 * required; has no global I2C address supported.
 		 */
 		device_name =3D "TXNW2770";
 		hda_priv->hda_chip_id =3D HDA_TAS2770;
-	} else if (strstarts(dev_name(&clt->dev),
+	} else if (strprefix(dev_name(&clt->dev),
 			     "i2c-TXNW2781:00-tas2781-hda.0")) {
 		device_name =3D "TXNW2781";
 		hda_priv->hda_chip_id =3D HDA_TAS2781;
@@ -659,7 +659,7 @@ static int tas2781_hda_i2c_probe(struct i2c_client *clt)
 		hda_priv->hda_chip_id =3D HDA_TAS2563;
 		hda_priv->save_calibration =3D tas2563_save_calibration;
 		tas_hda->priv->global_addr =3D TAS2563_GLOBAL_ADDR;
-	} else if (strstarts(dev_name(&clt->dev), "i2c-TXNW5825")) {
+	} else if (strprefix(dev_name(&clt->dev), "i2c-TXNW5825")) {
 		/*
 		 * TAS5825, integrated on-chip DSP without
 		 * global I2C address and calibration supported.
--=20
2.55.0


--i3cutcpsnd4nesfw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4fOAACgkQ64mZXMKQ
wqnwzQ/8CJb9K0NDe3UV7jzLkp85JpIYb489BguoCww8nqsGj+X++kcCQ5bdQCLn
/EDdSPaJiZbEdD1jB56YPOD21fstsm+2xAIhB73oqltCgaQmluYzfLb9e7j9M2sF
Kp3NlRPAAkhaY0nLqs+EZlMDEPotKMIK0QRg3yjYwY485zTJwSKibhWhqOeOa5N+
SmkVLfmORzIVUXYPbQfJb6Wg6YUibfDfgA0XOegYP+NxziOsv/Wh7uooPCDRoJKk
/sZMRrBf8ManlXrOWyCSLUBNh8k64t5AVz+wUHH+1bQTvj15Ul/B4gujdjw7Bcht
oR0Wea+VEm2ptSyGt7uwgK/szZlcTiTbJAZRdTY8hG7VYtuJ5rjBClWHsYPch/PA
GtZ4Ji9JRwfFgbL76p4m75c+cU7dQ7K8+3afyzwtLEf85XtDV8u9+k988zXLIdnw
5nFUzEweVz9TcKwMACaG14/LY3HM6V0UjAYWkCJAzB3o7vCI+dY+iw6ym2gmVEtC
Q/ssziiaLmNTqtesT7WZ1c97cdvoKz2iIbox2Y4hEMalnVXO4eEM5b6An7QbjxvH
ifR0uL5NEGUYd9UfcW98O/+OGH2sxcQThSsKMJUaXwxi+rmYPg79yr7kmH/5qkPA
agAQkU5sbFNGkCfGehy172XJiIouc+MqEVNy8G7/GTV6t9Hsbjs=
=CMQC
-----END PGP SIGNATURE-----

--i3cutcpsnd4nesfw--
