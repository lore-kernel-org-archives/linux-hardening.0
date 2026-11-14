Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794669825;
	b=NiKspr/+dwBqMATciG8irBaKj1PAXHHfvjpaGqn49/KTjqWoYPC0B7pMqkkaEZeAuMQ3
	 cLnJAmKcqfK4dHZnKmtJ7/xzjVSCn7ZDFrbh2J360K0VT/NsiGt3XQ3Xk7EjQU4M3VGhZ
	 QwGWDe/OwxWYfK1vJlO9LLrwwFjpplcfRtdy3vLOL9rN1QMSD/vY2WIAPiEq9+ZWOELMf
	 6KW+s9HqMSoCh9X5wCTMLFBwUa0K9uIQ7bKt8bG1iUmvXpflw6ZEyRN/QwQCWYx5GB62z
	 byMFV+9tFdwfMWamE7dMyEFEpTdqMYeiGEo/4dbMRL8yw/E5GpLSr2zBwEtIKv/OjQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669825;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EZYdUe+r/q/p73OEXvolL63NeR+i4R0NnF3/Q/Dm6uE=;
	b=KDHUxY9l6HJZ66yVrB9yhnXagOh3GCvSGKYtBkj6HXZKaF90Ro/tHcUsJejiK4UXytGI
	 dVxas4kuOD1Gd+CFw3TqAfDWTb4BUVah9AXr0IoiPZsRU5q2sXjVUiEBxb63aV10o9igQ
	 XdJuZBhfeFP8xGbTFJwW8vuF/TgG1JCaqnJdl4xym+kwtCLMMuwIcG/4Acjlyl0fzZ4cK
	 Tdjb20CrHF6q3hzcR3AuFlupvoJtTuFQzs4MsOw3sbJ86jll/KVaZ7k+ugUwAv/K0KSR6
	 fzDV7k2iZE0PP+F2Uhg4NM5gHqTaKz2bDZ8RonlO0+iHhPM1jBgkrZJkRditUTkmQSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MmlnIKKU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C00C606A882;
	Sat, 14 Nov 2026 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MmlnIKKU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048A01F000C5;
	Sat, 14 Nov 2026 15:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794669824;
	bh=EZYdUe+r/q/p73OEXvolL63NeR+i4R0NnF3/Q/Dm6uE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MmlnIKKU2duYBOXAs26M+LdYnqI89efDA6Yroo1rnt/haZ6IOVr97rp4wLGNK7+Ax
	 QpJKBPtlEm85e/qpJknMGRk/CpUOKqV331Z7cG6oIKfgjmfQL/LgzagrPbzb5onCCT
	 QtnBLEl9AkLvxbS/6POaS6M3JwGbGJmjeeEvTkl0xBmm13fyV+dSeHURQqu9Cu/Hlu
	 7JB/jdiAdQ8d1s6agwb6izBeJ0NRJabDDEz8XOQUNpUt25jX77BxCzxXO+fZDTCq0x
	 H1xOI2uTU1hxGFAyQlfb1JnBKc5FY45lBCkVc/DxwMVfPvWsSU+WnOppGt95fZ0EPn
	 BC0KEDrxHGgkg==
Date: Sat, 14 Nov 2026 16:23:37 +0100
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
Subject: [PATCH v6 14/19] treewide: Replace boolean uses of str_has_prefix()
 by strprefix()
Message-ID: <0c0070455de00eb63b43c6697555398fa5ef9d87.1794667407.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="b7d5v3bkqczgsw6y"
Content-Disposition: inline
In-Reply-To: <cover.1794667407.git.alx@kernel.org>


--b7d5v3bkqczgsw6y
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
Subject: [PATCH v6 14/19] treewide: Replace boolean uses of str_has_prefix()
 by strprefix()
Message-ID: <0c0070455de00eb63b43c6697555398fa5ef9d87.1794667407.git.alx@kernel.org>
References: <cover.1794667407.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794667407.git.alx@kernel.org>

str_has_prefix() doesn't work well for empty prefixes (see link below),
so this might actually fix some bugs silently where the prefix is an
empty string.

Link: https://lore.kernel.org/linux-hardening/20261104-fwnode-for-each-prop=
-v1-1-6e28fe1c72c4@oss.qualcomm.com/
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 arch/alpha/kernel/setup.c                     |  2 +-
 arch/parisc/kernel/setup.c                    |  2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c     |  2 +-
 arch/s390/kernel/early_printk.c               |  2 +-
 arch/s390/kernel/module.c                     |  6 ++---
 arch/s390/kernel/setup.c                      |  4 ++--
 arch/s390/lib/test_unwind.c                   |  6 ++---
 drivers/gpio/gpio-aggregator.c                |  2 +-
 drivers/gpu/drm/xe/xe_configfs.c              |  6 ++---
 drivers/iio/pressure/hsc030pa.c               |  2 +-
 drivers/md/dm-inlinecrypt.c                   |  2 +-
 drivers/media/i2c/ds90ub960.c                 |  2 +-
 drivers/remoteproc/mtk_scp.c                  |  2 +-
 .../media/atomisp/pci/atomisp_csi2_bridge.c   |  2 +-
 drivers/tty/serial/serial_base_bus.c          |  4 ++--
 kernel/debug/kdb/kdb_main.c                   |  2 +-
 kernel/kcsan/debugfs.c                        |  2 +-
 kernel/kcsan/report.c                         |  2 +-
 kernel/kprobes.c                              |  4 ++--
 kernel/locking/locktorture.c                  |  8 +++----
 kernel/power/main.c                           |  2 +-
 kernel/trace/trace_events.c                   |  2 +-
 kernel/trace/trace_events_hist.c              | 14 ++++++------
 kernel/trace/trace_events_synth.c             |  2 +-
 kernel/trace/trace_events_user.c              | 22 +++++++++----------
 kernel/trace/trace_probe.c                    | 22 +++++++++----------
 mm/arch_numa.c                                |  2 +-
 mm/kfence/report.c                            | 14 ++++++------
 sound/soc/sdw_utils/soc_sdw_senary_sdca.c     |  2 +-
 29 files changed, 73 insertions(+), 73 deletions(-)

diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index 4cbcfb1852d5..79e63580b419 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -452,7 +452,7 @@ setup_arch(char **cmdline_p)
 #ifndef alpha_using_srm
 	/* Assume that we've booted from SRM if we haven't booted from MILO.
 	   Detect the later by looking for "MILO" in the system serial nr.  */
-	alpha_using_srm =3D !str_has_prefix((const char *)hwrpb->ssn, "MILO");
+	alpha_using_srm =3D !strprefix((const char *)hwrpb->ssn, "MILO");
 #endif
 #ifndef alpha_using_qemu
 	/* Similarly, look for QEMU.  */
diff --git a/arch/parisc/kernel/setup.c b/arch/parisc/kernel/setup.c
index 4d3015a411d6..6cd1b65276b5 100644
--- a/arch/parisc/kernel/setup.c
+++ b/arch/parisc/kernel/setup.c
@@ -56,7 +56,7 @@ static void __init setup_cmdline(char **cmdline_p)
=20
 	/* autodetect console type (if not done by palo yet) */
 	p =3D boot_command_line;
-	if (!str_has_prefix(p, "console=3D") && !strstr(p, " console=3D")) {
+	if (!strprefix(p, "console=3D") && !strstr(p, " console=3D")) {
 		strlcat(p, " console=3D", COMMAND_LINE_SIZE);
 		if (PAGE0->mem_cons.cl_class =3D=3D CL_DUPLEX)
 			strlcat(p, "ttyS0", COMMAND_LINE_SIZE);
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platf=
orms/powernv/pci-ioda.c
index 728a5610d167..1cf0b4afe3df 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1629,7 +1629,7 @@ int64_t pnv_opal_pci_msi_eoi(struct irq_data *d)
  */
 bool is_pnv_opal_msi(struct irq_chip *chip)
 {
-	return chip && chip->name && str_has_prefix(chip->name, "PNV-");
+	return chip && chip->name && strprefix(chip->name, "PNV-");
 }
 EXPORT_SYMBOL_GPL(is_pnv_opal_msi);
=20
diff --git a/arch/s390/kernel/early_printk.c b/arch/s390/kernel/early_print=
k.c
index cefe020a3be3..095e282c1e06 100644
--- a/arch/s390/kernel/early_printk.c
+++ b/arch/s390/kernel/early_printk.c
@@ -36,7 +36,7 @@ static int __init setup_early_printk(char *buf)
 	if (early_console)
 		return 0;
 	/* Accept only "earlyprintk" and "earlyprintk=3Dsclp" */
-	if (buf && !str_has_prefix(buf, "sclp"))
+	if (buf && !strprefix(buf, "sclp"))
 		return 0;
 	register_early_console();
 	return 0;
diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
index 9d1f8a50f5a4..e9734d2b25f3 100644
--- a/arch/s390/kernel/module.c
+++ b/arch/s390/kernel/module.c
@@ -520,15 +520,15 @@ int module_finalize(const Elf_Ehdr *hdr,
 			apply_alternatives(aseg, aseg + s->sh_size);
=20
 		if (IS_ENABLED(CONFIG_EXPOLINE) &&
-		    (str_has_prefix(secname, ".s390_indirect")))
+		    (strprefix(secname, ".s390_indirect")))
 			nospec_revert(aseg, aseg + s->sh_size);
=20
 		if (IS_ENABLED(CONFIG_EXPOLINE) &&
-		    (str_has_prefix(secname, ".s390_return")))
+		    (strprefix(secname, ".s390_return")))
 			nospec_revert(aseg, aseg + s->sh_size);
=20
 		if (IS_ENABLED(CONFIG_STACKPROTECTOR) &&
-		    (str_has_prefix(secname, "__stack_protector_loc"))) {
+		    (strprefix(secname, "__stack_protector_loc"))) {
 			rc =3D stack_protector_apply(aseg, aseg + s->sh_size);
 			if (rc)
 				break;
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index b60284328fe3..7074cdd58aa3 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -269,7 +269,7 @@ static void __init conmode_default(void)
 #endif
 			return;
 		}
-		if (str_has_prefix(ptr + 8, "3270")) {
+		if (strprefix(ptr + 8, "3270")) {
 #if defined(CONFIG_TN3270_CONSOLE)
 			SET_CONSOLE_3270;
 #elif defined(CONFIG_TN3215_CONSOLE)
@@ -277,7 +277,7 @@ static void __init conmode_default(void)
 #elif defined(CONFIG_SCLP_CONSOLE) || defined(CONFIG_SCLP_VT220_CONSOLE)
 			SET_CONSOLE_SCLP;
 #endif
-		} else if (str_has_prefix(ptr + 8, "3215")) {
+		} else if (strprefix(ptr + 8, "3215")) {
 #if defined(CONFIG_TN3215_CONSOLE)
 			SET_CONSOLE_3215;
 #elif defined(CONFIG_TN3270_CONSOLE)
diff --git a/arch/s390/lib/test_unwind.c b/arch/s390/lib/test_unwind.c
index bb47958f5aed..8d6b6efe02fc 100644
--- a/arch/s390/lib/test_unwind.c
+++ b/arch/s390/lib/test_unwind.c
@@ -87,10 +87,10 @@ static noinline int test_unwind(struct task_struct *tas=
k, struct pt_regs *regs,
 				kunit_err(current_test, "backtrace buffer is too small\n");
 		}
 		frame_count +=3D 1;
-		if (prev_is_func2 && str_has_prefix(sym, "unwindme_func1"))
+		if (prev_is_func2 && strprefix(sym, "unwindme_func1"))
 			seen_func2_func1 =3D true;
-		prev_is_func2 =3D str_has_prefix(sym, "unwindme_func2");
-		if (str_has_prefix(sym, "arch_rethook_trampoline+0x0/"))
+		prev_is_func2 =3D strprefix(sym, "unwindme_func2");
+		if (strprefix(sym, "arch_rethook_trampoline+0x0/"))
 			seen_arch_rethook_trampoline =3D true;
 	}
=20
diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index b0b65416d74d..efa92e925461 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -1546,7 +1546,7 @@ static ssize_t gpio_aggregator_delete_device_store(st=
ruct device_driver *driver,
 	unsigned int id;
 	int error;
=20
-	if (!str_has_prefix(buf, DRV_NAME "."))
+	if (!strprefix(buf, DRV_NAME "."))
 		return -EINVAL;
=20
 	error =3D kstrtouint(buf + strlen(DRV_NAME "."), 10, &id);
diff --git a/drivers/gpu/drm/xe/xe_configfs.c b/drivers/gpu/drm/xe/xe_confi=
gfs.c
index 2ddd707a6dbd..8bd11f5bdfa1 100644
--- a/drivers/gpu/drm/xe/xe_configfs.c
+++ b/drivers/gpu/drm/xe/xe_configfs.c
@@ -521,7 +521,7 @@ static const struct engine_info *lookup_engine_info(con=
st char *pattern, u64 *ma
 		u8 instance;
 		u16 bit;
=20
-		if (!str_has_prefix(pattern, engine_info[i].cls))
+		if (!strprefix(pattern, engine_info[i].cls))
 			continue;
=20
 		pattern +=3D strlen(engine_info[i].cls);
@@ -836,7 +836,7 @@ static ssize_t parse_wa_bb_lines(const char *lines,
 		p +=3D ret;
 		p +=3D strspn(p, " \t");
=20
-		if (str_has_prefix(p, "cmd")) {
+		if (strprefix(p, "cmd")) {
 			for (p +=3D strlen("cmd"); *p;) {
 				ret =3D parse_hex(p, &val);
 				if (ret < 0)
@@ -848,7 +848,7 @@ static ssize_t parse_wa_bb_lines(const char *lines,
 				dwords++;
 				wa_bb_append(&wa_bb[info->engine_class], val);
 			}
-		} else if (str_has_prefix(p, "reg")) {
+		} else if (strprefix(p, "reg")) {
 			p +=3D strlen("reg");
 			ret =3D parse_hex(p, &val);
 			if (ret <=3D 0)
diff --git a/drivers/iio/pressure/hsc030pa.c b/drivers/iio/pressure/hsc030p=
a.c
index 0374d406b401..eaf5ee190be5 100644
--- a/drivers/iio/pressure/hsc030pa.c
+++ b/drivers/iio/pressure/hsc030pa.c
@@ -476,7 +476,7 @@ int hsc_common_probe(struct device *dev, hsc_recv_fn re=
cv)
 		return dev_err_probe(dev, ret,
 			     "honeywell,pressure-triplet could not be read\n");
=20
-	if (str_has_prefix(triplet, "NA")) {
+	if (strprefix(triplet, "NA")) {
 		ret =3D device_property_read_u32(dev, "honeywell,pmin-pascal",
 					       &hsc->pmin);
 		if (ret)
diff --git a/drivers/md/dm-inlinecrypt.c b/drivers/md/dm-inlinecrypt.c
index 3479dfe5f708..4a1cc2da4c29 100644
--- a/drivers/md/dm-inlinecrypt.c
+++ b/drivers/md/dm-inlinecrypt.c
@@ -257,7 +257,7 @@ static int inlinecrypt_ctr_optional(struct dm_target *t=
i,
 			ti->error =3D "Not enough feature arguments";
 			return -EINVAL;
 		}
-		if (str_has_prefix(opt_string, "keytype:")) {
+		if (strprefix(opt_string, "keytype:")) {
 			const char *val =3D opt_string + strlen("keytype:");
=20
 			if (!*val) {
diff --git a/drivers/media/i2c/ds90ub960.c b/drivers/media/i2c/ds90ub960.c
index 7d7ba6d349fc..725245a1680b 100644
--- a/drivers/media/i2c/ds90ub960.c
+++ b/drivers/media/i2c/ds90ub960.c
@@ -4692,7 +4692,7 @@ ub960_fwnode_get_link_by_regs(struct fwnode_handle *l=
inks_fwnode,
 	fwnode_for_each_child_node(links_fwnode, link_fwnode) {
 		u32 link_num;
=20
-		if (!str_has_prefix(fwnode_get_name(link_fwnode), "link@"))
+		if (!strprefix(fwnode_get_name(link_fwnode), "link@"))
 			continue;
=20
 		ret =3D fwnode_property_read_u32(link_fwnode, "reg", &link_num);
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 9751acc2bf83..2dd18b34a378 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -1147,7 +1147,7 @@ static const char *scp_get_default_fw_path(struct dev=
ice *dev, int core_id)
 		return ERR_PTR(-EINVAL);
=20
 	/* If the compatible string starts with "mediatek,mt" assume that it's ok=
 */
-	if (!str_has_prefix(compatible, "mediatek,mt"))
+	if (!strprefix(compatible, "mediatek,mt"))
 		return ERR_PTR(-EINVAL);
=20
 	if (core_id >=3D 0)
diff --git a/drivers/staging/media/atomisp/pci/atomisp_csi2_bridge.c b/driv=
ers/staging/media/atomisp/pci/atomisp_csi2_bridge.c
index cca91c6d71a5..2cfe5f92ca3b 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_csi2_bridge.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_csi2_bridge.c
@@ -222,7 +222,7 @@ static int atomisp_csi2_get_pmc_clk_nr_from_acpi_pr0(st=
ruct acpi_device *adev)
=20
 		acpi_get_name(rhandle, ACPI_SINGLE_NAME, &b_name);
=20
-		if (str_has_prefix(name, "CLK") && !kstrtou8(&name[3], 10, &clock_num) &&
+		if (strprefix(name, "CLK") && !kstrtou8(&name[3], 10, &clock_num) &&
 		    clock_num <=3D 4) {
 			ret =3D clock_num;
 			break;
diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/seri=
al_base_bus.c
index 5f23284a8778..1a5512457b74 100644
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -33,11 +33,11 @@ static const struct device_type serial_port_type =3D {
 static int serial_base_match(struct device *dev, const struct device_drive=
r *drv)
 {
 	if (dev->type =3D=3D &serial_ctrl_type &&
-	    str_has_prefix(drv->name, serial_ctrl_type.name))
+	    strprefix(drv->name, serial_ctrl_type.name))
 		return 1;
=20
 	if (dev->type =3D=3D &serial_port_type &&
-	    str_has_prefix(drv->name, serial_port_type.name))
+	    strprefix(drv->name, serial_port_type.name))
 		return 1;
=20
 	return 0;
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 40c332d2179d..d3c8afaae4b3 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -803,7 +803,7 @@ static void parse_grep(const char *str)
 	cp++;
 	while (isspace(*cp))
 		cp++;
-	if (!str_has_prefix(cp, "grep ")) {
+	if (!strprefix(cp, "grep ")) {
 		kdb_printf("invalid 'pipe', see grephelp\n");
 		return;
 	}
diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 2af39ba5b70b..b945f9ab39a3 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -233,7 +233,7 @@ debugfs_write(struct file *file, const char __user *buf=
, size_t count, loff_t *o
 		WRITE_ONCE(kcsan_enabled, true);
 	} else if (!strcmp(arg, "off")) {
 		WRITE_ONCE(kcsan_enabled, false);
-	} else if (str_has_prefix(arg, "microbench=3D")) {
+	} else if (strprefix(arg, "microbench=3D")) {
 		unsigned long iters;
=20
 		if (kstrtoul(&arg[strlen("microbench=3D")], 0, &iters))
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 11a48b78f8d1..00f9b12f6a6d 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -292,7 +292,7 @@ static int get_stack_skipnr(const unsigned long stack_e=
ntries[], int num_entries
 		cur =3D strnstr(buf, "kcsan_", len);
 		if (cur) {
 			cur +=3D strlen("kcsan_");
-			if (!str_has_prefix(cur, "test"))
+			if (!strprefix(cur, "test"))
 				continue; /* KCSAN runtime function. */
 			/* KCSAN related test. */
 		}
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 2441b9e39343..e8ce9ad73389 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1860,8 +1860,8 @@ static bool is_cfi_preamble_symbol(unsigned long addr)
 	if (lookup_symbol_name(addr, symbuf))
 		return false;
=20
-	return str_has_prefix(symbuf, "__cfi_") ||
-		str_has_prefix(symbuf, "__pfx_");
+	return strprefix(symbuf, "__cfi_") ||
+		strprefix(symbuf, "__pfx_");
 }
=20
 static int check_kprobe_address_safe(struct kprobe *p,
diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index e618bcf75e2d..5408c4de5b01 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -1277,16 +1277,16 @@ static int __init lock_torture_init(void)
 	}
=20
 #ifdef CONFIG_DEBUG_MUTEXES
-	if (str_has_prefix(torture_type, "mutex"))
+	if (strprefix(torture_type, "mutex"))
 		cxt.debug_lock =3D true;
 #endif
 #ifdef CONFIG_DEBUG_RT_MUTEXES
-	if (str_has_prefix(torture_type, "rtmutex"))
+	if (strprefix(torture_type, "rtmutex"))
 		cxt.debug_lock =3D true;
 #endif
 #ifdef CONFIG_DEBUG_SPINLOCK
-	if ((str_has_prefix(torture_type, "spin")) ||
-	    (str_has_prefix(torture_type, "rw_lock")))
+	if ((strprefix(torture_type, "spin")) ||
+	    (strprefix(torture_type, "rw_lock")))
 		cxt.debug_lock =3D true;
 #endif
=20
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 5429e9f19b65..763f84900e4b 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -781,7 +781,7 @@ static suspend_state_t decode_state(const char *buf, si=
ze_t n)
 	len =3D p ? p - buf : n;
=20
 	/* Check hibernation first. */
-	if (len =3D=3D 4 && str_has_prefix(buf, "disk"))
+	if (len =3D=3D 4 && strprefix(buf, "disk"))
 		return PM_SUSPEND_MAX;
=20
 #ifdef CONFIG_SUSPEND
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 49d135bc2fbf..d467cdf9c805 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2182,7 +2182,7 @@ static int f_show(struct seq_file *m, void *v)
 	 */
 	array_descriptor =3D strchr(field->type, '[');
=20
-	if (str_has_prefix(field->type, "__data_loc"))
+	if (strprefix(field->type, "__data_loc"))
 		array_descriptor =3D NULL;
=20
 	if (!array_descriptor)
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_h=
ist.c
index 1aae7d7c6dc5..c099bfbb9fb6 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1468,9 +1468,9 @@ static int parse_action(char *str, struct hist_trigge=
r_attrs *attrs)
 	if (attrs->n_actions >=3D HIST_ACTIONS_MAX)
 		return ret;
=20
-	if ((str_has_prefix(str, "onmatch(")) ||
-	    (str_has_prefix(str, "onmax(")) ||
-	    (str_has_prefix(str, "onchange("))) {
+	if ((strprefix(str, "onmatch(")) ||
+	    (strprefix(str, "onmax(")) ||
+	    (strprefix(str, "onchange("))) {
 		attrs->action_str[attrs->n_actions] =3D kstrdup(str, GFP_KERNEL);
 		if (!attrs->action_str[attrs->n_actions]) {
 			ret =3D -ENOMEM;
@@ -1508,7 +1508,7 @@ static int parse_assignment(struct trace_array *tr,
 			ret =3D -ENOMEM;
 			goto out;
 		}
-	} else if (str_has_prefix(str, "name=3D")) {
+	} else if (strprefix(str, "name=3D")) {
 		attrs->name =3D kstrdup(str, GFP_KERNEL);
 		if (!attrs->name) {
 			ret =3D -ENOMEM;
@@ -3775,7 +3775,7 @@ static int action_parse(struct trace_array *tr, char =
*str, struct action_data *d
 		goto out;
 	}
=20
-	if (str_has_prefix(action_name, "save")) {
+	if (strprefix(action_name, "save")) {
 		char *params =3D strsep(&str, ")");
=20
 		if (!params) {
@@ -3801,7 +3801,7 @@ static int action_parse(struct trace_array *tr, char =
*str, struct action_data *d
 		data->track_data.save_data =3D save_track_data_vars;
 		data->fn =3D ontrack_action;
 		data->action =3D ACTION_SAVE;
-	} else if (str_has_prefix(action_name, "snapshot")) {
+	} else if (strprefix(action_name, "snapshot")) {
 		char *params =3D strsep(&str, ")");
=20
 		if (!str) {
@@ -3826,7 +3826,7 @@ static int action_parse(struct trace_array *tr, char =
*str, struct action_data *d
 	} else {
 		char *params =3D strsep(&str, ")");
=20
-		if (str_has_prefix(action_name, "trace"))
+		if (strprefix(action_name, "trace"))
 			data->use_trace_keyword =3D true;
=20
 		if (params) {
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_=
synth.c
index e2870212e58d..016ca522e5af 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -167,7 +167,7 @@ static int synth_event_define_fields(struct trace_event=
_call *call)
=20
 static bool synth_field_signed(char *type)
 {
-	if (str_has_prefix(type, "u"))
+	if (strprefix(type, "u"))
 		return false;
 	if (strcmp(type, "gfp_t") =3D=3D 0)
 		return false;
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_u=
ser.c
index f658c3a77aa7..8669f11fb9bd 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1098,13 +1098,13 @@ static int user_field_size(const char *type)
 		return sizeof(char);
 	if (strcmp(type, "unsigned char") =3D=3D 0)
 		return sizeof(unsigned char);
-	if (str_has_prefix(type, "char["))
+	if (strprefix(type, "char["))
 		return user_field_array_size(type);
-	if (str_has_prefix(type, "unsigned char["))
+	if (strprefix(type, "unsigned char["))
 		return user_field_array_size(type);
-	if (str_has_prefix(type, "__data_loc "))
+	if (strprefix(type, "__data_loc "))
 		return sizeof(u32);
-	if (str_has_prefix(type, "__rel_loc "))
+	if (strprefix(type, "__rel_loc "))
 		return sizeof(u32);
=20
 	/* Unknown basic type, error */
@@ -1145,10 +1145,10 @@ static int user_event_add_field(struct user_event *=
user, const char *type,
 	if (!field)
 		return -ENOMEM;
=20
-	if (str_has_prefix(type, "__data_loc "))
+	if (strprefix(type, "__data_loc "))
 		goto add_validator;
=20
-	if (str_has_prefix(type, "__rel_loc ")) {
+	if (strprefix(type, "__rel_loc ")) {
 		validator_flags |=3D VALIDATOR_REL;
 		goto add_validator;
 	}
@@ -1349,12 +1349,12 @@ static const char *user_field_format(const char *ty=
pe)
=20
 static bool user_field_is_dyn_string(const char *type, const char **str_fu=
nc)
 {
-	if (str_has_prefix(type, "__data_loc ")) {
+	if (strprefix(type, "__data_loc ")) {
 		*str_func =3D "__get_str";
 		goto check;
 	}
=20
-	if (str_has_prefix(type, "__rel_loc ")) {
+	if (strprefix(type, "__rel_loc ")) {
 		*str_func =3D "__get_rel_str";
 		goto check;
 	}
@@ -1401,7 +1401,7 @@ static int user_field_set_string(struct ftrace_event_=
field *field,
 	pos +=3D snprintf(buf + pos, LEN_OR_ZERO, " ");
 	pos +=3D snprintf(buf + pos, LEN_OR_ZERO, "%s", field->name);
=20
-	if (str_has_prefix(field->type, "struct "))
+	if (strprefix(field->type, "struct "))
 		pos +=3D snprintf(buf + pos, LEN_OR_ZERO, " %d", field->size);
=20
 	if (colon)
@@ -1808,7 +1808,7 @@ static int user_event_create(const char *raw_command)
 	char *name;
 	int ret;
=20
-	if (!str_has_prefix(raw_command, USER_EVENTS_PREFIX))
+	if (!strprefix(raw_command, USER_EVENTS_PREFIX))
 		return -ECANCELED;
=20
 	raw_command +=3D USER_EVENTS_PREFIX_LEN;
@@ -1861,7 +1861,7 @@ static int user_event_show(struct seq_file *m, struct=
 dyn_event *ev)
=20
 		seq_printf(m, "%s %s", field->type, field->name);
=20
-		if (str_has_prefix(field->type, "struct "))
+		if (strprefix(field->type, "struct "))
 			seq_printf(m, " %d", field->size);
=20
 		depth++;
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index a880a90642d7..62acdf737c12 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -370,10 +370,10 @@ static int parse_this_cpu(char *arg, struct traceprob=
e_parse_context *ctx)
 		trace_probe_log_err(ctx->offset, NOSUP_PERCPU);
 		return -EINVAL;
 	}
-	if (str_has_prefix(arg, THIS_CPU_PTR_PREFIX)) {
+	if (strprefix(arg, THIS_CPU_PTR_PREFIX)) {
 		arg +=3D THIS_CPU_PTR_LEN;
 		ctx->offset +=3D THIS_CPU_PTR_LEN;
-	} else if (str_has_prefix(arg, THIS_CPU_READ_PREFIX)) {
+	} else if (strprefix(arg, THIS_CPU_READ_PREFIX)) {
 		arg +=3D THIS_CPU_READ_LEN;
 		ctx->offset +=3D THIS_CPU_READ_LEN;
 		is_read =3D true;
@@ -745,7 +745,7 @@ static int parse_btf_arg(char *varname,
 	u32 tid;
=20
 	/* Note: field is not separated at this point, so check prefix. */
-	if (!str_has_prefix(varname, "$current") &&
+	if (!strprefix(varname, "$current") &&
 	    !ctx->funcname && !(ctx->flags & TPARG_FL_TEVENT))
 		return -EINVAL;
=20
@@ -1001,8 +1001,8 @@ static int handle_typecast(char *arg, struct tracepro=
be_parse_context *ctx)
 		ctx->offset +=3D 1;
 		tmp++;
 	} else if (*tmp =3D=3D '+' || *tmp =3D=3D '-' ||
-		   str_has_prefix(tmp, THIS_CPU_PTR_PREFIX) ||
-		   str_has_prefix(tmp, THIS_CPU_READ_PREFIX)) {
+		   strprefix(tmp, THIS_CPU_PTR_PREFIX) ||
+		   strprefix(tmp, THIS_CPU_READ_PREFIX)) {
 		/* Dereference can have another field access inside it. */
 		char *open =3D strchr(tmp + 1, '(');
=20
@@ -1412,7 +1412,7 @@ static int parse_probe_vars(char *orig_arg, const str=
uct fetch_type *t,
 	if (ctx->flags & TPARG_FL_TEVENT)
 		goto inval;
=20
-	if (str_has_prefix(arg, "retval"))
+	if (strprefix(arg, "retval"))
 		return parse_probe_var_retval(orig_arg, pcode, end, ctx);
=20
 	len =3D str_has_prefix(arg, "stack");
@@ -1420,7 +1420,7 @@ static int parse_probe_vars(char *orig_arg, const str=
uct fetch_type *t,
 		return parse_probe_var_stack(arg, len, code, ctx);
=20
 	/* $current returns the address of the current task_struct. */
-	if (str_has_prefix(arg, "current"))
+	if (strprefix(arg, "current"))
 		return parse_probe_var_current(orig_arg, arg, pcode, end, ctx);
=20
 	len =3D str_has_prefix(arg, "arg");
@@ -1642,8 +1642,8 @@ static int parse_probe_arg_nested(char **parg, struct=
 traceprobe_parse_context *
 	while (true) {
 		/* Determine if this is a nested argument */
 		if (arg[0] !=3D '+' && arg[0] !=3D '-' && arg[0] !=3D '(' &&
-		    !str_has_prefix(arg, THIS_CPU_PTR_PREFIX) &&
-		    !str_has_prefix(arg, THIS_CPU_READ_PREFIX))
+		    !strprefix(arg, THIS_CPU_PTR_PREFIX) &&
+		    !strprefix(arg, THIS_CPU_READ_PREFIX))
 			break;
=20
 		/* If nested, check the maximum depth limit */
@@ -2228,7 +2228,7 @@ static int argv_has_var_arg(int argc, const char *arg=
v[], int *args_idx,
 	int i, found =3D 0;
=20
 	for (i =3D 0; i < argc; i++)
-		if (str_has_prefix(argv[i], "$arg")) {
+		if (strprefix(argv[i], "$arg")) {
 			trace_probe_log_set_index(i + 2);
=20
 			if (!tparg_is_function_entry(ctx->flags) &&
@@ -2335,7 +2335,7 @@ const char **traceprobe_expand_meta_args(int argc, co=
nst char *argv[],
 			continue;
 		}
=20
-		if (str_has_prefix(argv[i], "$arg")) {
+		if (strprefix(argv[i], "$arg")) {
 			char *type =3D NULL;
=20
 			n =3D simple_strtoul(argv[i] + 4, &type, 10);
diff --git a/mm/arch_numa.c b/mm/arch_numa.c
index a4b1732274fa..8380b8fe11d5 100644
--- a/mm/arch_numa.c
+++ b/mm/arch_numa.c
@@ -24,7 +24,7 @@ static __init int numa_parse_early_param(char *opt)
 {
 	if (!opt)
 		return -EINVAL;
-	if (str_has_prefix(opt, "off"))
+	if (strprefix(opt, "off"))
 		numa_off =3D true;
 	if (!strncmp(opt, "fake=3D", 5))
 		return numa_emu_cmdline(opt + 5);
diff --git a/mm/kfence/report.c b/mm/kfence/report.c
index d548536864b1..e6fae0c2b9b5 100644
--- a/mm/kfence/report.c
+++ b/mm/kfence/report.c
@@ -97,9 +97,9 @@ static int get_stack_skipnr(const unsigned long stack_ent=
ries[], int num_entries
 	for (skipnr =3D 0; skipnr < num_entries; skipnr++) {
 		int len =3D scnprintf(buf, sizeof(buf), "%ps", (void *)stack_entries[ski=
pnr]);
=20
-		if (str_has_prefix(buf, ARCH_FUNC_PREFIX "kfence_") ||
-		    str_has_prefix(buf, ARCH_FUNC_PREFIX "__kfence_") ||
-		    str_has_prefix(buf, ARCH_FUNC_PREFIX "__kmem_cache_free") ||
+		if (strprefix(buf, ARCH_FUNC_PREFIX "kfence_") ||
+		    strprefix(buf, ARCH_FUNC_PREFIX "__kfence_") ||
+		    strprefix(buf, ARCH_FUNC_PREFIX "__kmem_cache_free") ||
 		    !strncmp(buf, ARCH_FUNC_PREFIX "__slab_free", len)) {
 			/*
 			 * In case of tail calls from any of the below to any of
@@ -114,10 +114,10 @@ static int get_stack_skipnr(const unsigned long stack=
_entries[], int num_entries
 		 * into the slab allocators. Includes the *_bulk() variants by
 		 * checking prefixes.
 		 */
-		if (str_has_prefix(buf, ARCH_FUNC_PREFIX "kfree") ||
-		    str_has_prefix(buf, ARCH_FUNC_PREFIX "kmem_cache_free") ||
-		    str_has_prefix(buf, ARCH_FUNC_PREFIX "__kmalloc") ||
-		    str_has_prefix(buf, ARCH_FUNC_PREFIX "kmem_cache_alloc"))
+		if (strprefix(buf, ARCH_FUNC_PREFIX "kfree") ||
+		    strprefix(buf, ARCH_FUNC_PREFIX "kmem_cache_free") ||
+		    strprefix(buf, ARCH_FUNC_PREFIX "__kmalloc") ||
+		    strprefix(buf, ARCH_FUNC_PREFIX "kmem_cache_alloc"))
 			goto found;
 	}
 	if (fallback < num_entries)
diff --git a/sound/soc/sdw_utils/soc_sdw_senary_sdca.c b/sound/soc/sdw_util=
s/soc_sdw_senary_sdca.c
index 5c2cd75307c9..afaca66e41ef 100644
--- a/sound/soc/sdw_utils/soc_sdw_senary_sdca.c
+++ b/sound/soc/sdw_utils/soc_sdw_senary_sdca.c
@@ -33,7 +33,7 @@ static const struct codec_route_map codec_routes[] =3D {
 static const struct codec_route_map *get_codec_route_map(const char *dai_n=
ame)
 {
 	for (size_t i =3D 0; i < ARRAY_SIZE(codec_routes); i++) {
-		if (str_has_prefix(dai_name, codec_routes[i].codec_name))
+		if (strprefix(dai_name, codec_routes[i].codec_name))
 			return &codec_routes[i];
 	}
 	return NULL;
--=20
2.55.0


--b7d5v3bkqczgsw6y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4fPkACgkQ64mZXMKQ
wqnEVQ/8CyMzsMSN2kV9ZUt/RKVk8Qv2jHA15k9pNSyKTSnfl796bjNOG+SSQbld
LIAgStUSQ9MMXQfScDPUrTehQG/+JvGgbzwFaJSKsqlWAI08C/JAG+t175VB0glO
khHfQU4gBSjiTLQ8qDJ3JmyIGvcxBhQD7RixFtEasodKQsxTR1gUCNtJx9e58V1A
P8KZD0bbmwI8NgWmIz5EIkWyv5w1SrMRP/aJ7ZBkqJSm4MSX0ZKPn7zWoM7ny7G6
Y8RaM0h8ZETVxebSfDuMeT/iJlyWbzya8sD9/qt5CJIXokBB9n3Ei0obQ8bBN24U
PrkPjpNxLatCy+QUrxkMleIO7xXnnj5hrDelnR3WJQzblHj4iq4uOD/fD97QqSg8
UF8agMB6ecdq9hpr5RmTXQ57H62iUtnfxJNSxpeEpVWytjtE7OkiAULsrUntEfhE
ZTxga0T81Sb7TY1RiNBWnwGpSvi3/2Krugja674C2J7RvGZ/Bb145miT7ePCoZyt
vvBQM6gLNIsleps93nCyljqevHY89jT3w5DDQ+aTgEo919IJadoRBZdT6KrYM6Bu
C//m9B7hVVha61/gd4pwQW6Zezn0cQkFdqgf6Fhe9ZkkQAUZFwRXBn3NnAGPIsUw
H9jHsoOK+a+PzBNCy6718rkYU1bgW6B6/53iIFHx6aF1kp8Gs9c=
=5tjC
-----END PGP SIGNATURE-----

--b7d5v3bkqczgsw6y--
