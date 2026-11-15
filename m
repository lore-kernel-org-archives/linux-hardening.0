Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794768387;
	b=z6wK0dHcHNz6rUwFs9Noil0TAaa7C43GXh6HGO6YictDQmd0ks3yh3VpA2H7q9W9ZytY
	 4BZbKHlcPMHWP/2ywg3Cmsef9cj4uuwp3vu/QFD/reYY5rEMToavkZC1WkbdYo6Q/2dmS
	 jZFqON4R241HyL18/O6VXl5yXon7j8X+jcliTQDDhgNC2v9qu/qSKxJ3cJJjk8xduyrpD
	 vz+83HzFpMHNfn4bdQEvOXBdyj7x1CDlWoRElwWWsXWp5P1VZ5cUHtlVhG72tJms9iuGW
	 pCFkegK7UOJ81FlM9jBSNgAQslqBmNu2JONUcfCT0E8wHjtEd+bRzQtp4cw+wEO3h/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794768387;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fScWBKoUqg8cT4axIzp0iWAhjNNBSxhgCq7HWGCsLrY=;
	b=FMCOqW6X1ertSkVtn5Fc9/dK+z7L9Wl7KTbD0W5rIh4mCJ1xGNw+IrWMU6UvqGuKNqcs
	 rOOe3bo3Nw8Oekg8ztO15itfDaOeK7B9f66BHW5CK0cHXDABS79t3CPf4+VX8bBqymtid
	 +yX5XyAJLwlFJUqojsY/tYbieX47Z9Njp9GBhZvxTOEX9lG+SbWalDL22YU/iJ5ICQXQH
	 R6s9kI17/9ROfGMhGBOIq+KyfQ78GyOWDvNlHgd4AsUIV16wwvY5KIDWHmOfySUEmWy+9
	 LGnueGJqU3wBrzgE2DdOlGS+mT6qRFtdgSc2HHEdu5hHbo7N1IAGQtkAvubGwPbDVTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nEXjManc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5834B606A31A
	for <linux-hardening@vger.kernel.org>; Sun, 15 Nov 2026 18:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nEXjManc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B625F1F000C4;
	Sun, 15 Nov 2026 18:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794768386;
	bh=fScWBKoUqg8cT4axIzp0iWAhjNNBSxhgCq7HWGCsLrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nEXjManczzpx1ToZlAknTs8k2hNId0+S+kmZCJnX60yUgG6kPsx53DGhpXU/+8rTa
	 anhk8hK5EAgwPpRcNGtxQY+oLCito4THxSZimqEy+WCCoKDZRCs0vlOWCruCbon78n
	 6q/9P/lCpPmynUthScrHJgU/aOlJwgD7rV3EZt1tCfY5+fDn8jCKjqDmpZzrpmEURj
	 0lLvsaT1/uZjODr+yWf2hY8Pz7zvvAqIl2BCFPcdKe4jjn2+MSnZeqlEI1A9NMTmLt
	 F4hVAa/DQ2gfOWMtJRFPzTVCdcftbQKQLVeEQvXJ/8oDpA3AcULpLW6Jqaw14CEaLm
	 z0rxs6pRXSeww==
Date: Sun, 15 Nov 2026 19:46:24 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, alx+linux-hardening@kernel.org, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 4/4] treewide: Use streq(3) instead of unnecessary uses of
 strncmp(3)
Message-ID: <7994b5827030d909928a7b7dab35d8b049974fa4.1794767906.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
References: <cover.1794767906.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="cat6wfyj3lkwkym3"
Content-Disposition: inline
In-Reply-To: <cover.1794767906.git.alx@kernel.org>


--cat6wfyj3lkwkym3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, alx+linux-hardening@kernel.org, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 4/4] treewide: Use streq(3) instead of unnecessary uses of
 strncmp(3)
Message-ID: <7994b5827030d909928a7b7dab35d8b049974fa4.1794767906.git.alx@kernel.org>
References: <cover.1794767906.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794767906.git.alx@kernel.org>

Uses of strncmp(foo,"bar",sizeof("bar")) are really the same as
strcmp(foo,"bar").  There's no good reason to use strncmp(3).

This code seems to have been confused, and probably thought using
strncmp(3) was somehow safer than strcmp(3), but it is not.

Let's rewrite with streq(3), which makes it more readable.
This patch is not changing the behavior of the existing code.

These cases were found with the following script:

	$ git grep -E 'strncmp\([^,]*, [^,]*, sizeof.*[A-Z"]' \
	| grep -v -- '- 1';

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 arch/m68k/sun3/prom/console.c                  | 6 +++---
 drivers/edac/amd64_edac.c                      | 2 +-
 drivers/edac/i10nm_base.c                      | 2 +-
 drivers/edac/igen6_edac.c                      | 2 +-
 drivers/edac/imh_base.c                        | 2 +-
 drivers/edac/pnd2_edac.c                       | 2 +-
 drivers/edac/sb_edac.c                         | 2 +-
 drivers/edac/skx_base.c                        | 2 +-
 drivers/gpu/drm/tilcdc/tilcdc_panel_legacy.c   | 2 +-
 include/linux/remoteproc/pruss.h               | 2 +-
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 2 +-
 tools/bpf/bpftool/btf.c                        | 4 ++--
 tools/perf/util/callchain.c                    | 8 ++++----
 tools/perf/util/evsel.c                        | 3 +--
 14 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/arch/m68k/sun3/prom/console.c b/arch/m68k/sun3/prom/console.c
index eb4f6c903fb8..f54a52b1e8d2 100644
--- a/arch/m68k/sun3/prom/console.c
+++ b/arch/m68k/sun3/prom/console.c
@@ -92,7 +92,7 @@ prom_query_input_device()
 		if(prom_node_has_property(st_p, "keyboard"))
 			return PROMDEV_IKBD;
 		prom_getproperty(st_p, "device_type", propb, sizeof(propb));
-		if(strncmp(propb, "serial", sizeof("serial")))
+		if(!streq(propb, "serial"))
 			return PROMDEV_I_UNK;
 		prom_getproperty(prom_root_node, "stdin-path", propb, sizeof(propb));
 		p =3D propb;
@@ -139,12 +139,12 @@ prom_query_output_device()
 		local_irq_restore(flags);
 		propl =3D prom_getproperty(st_p, "device_type", propb, sizeof(propb));
 		if (propl >=3D 0 && propl =3D=3D sizeof("display") &&
-			strncmp("display", propb, sizeof("display")) =3D=3D 0)
+			streq("display", propb))
 		{
 			return PROMDEV_OSCREEN;
 		}
 		if(prom_vers =3D=3D PROM_V3) {
-			if(strncmp("serial", propb, sizeof("serial")))
+			if(!streq("serial", propb))
 				return PROMDEV_O_UNK;
 			prom_getproperty(prom_root_node, "stdout-path", propb, sizeof(propb));
 			p =3D propb;
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 0c0d11c72925..19bba83a900f 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4137,7 +4137,7 @@ static int __init amd64_edac_init(void)
 		return -EBUSY;
=20
 	owner =3D edac_get_owner();
-	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
+	if (owner && !streq(owner, EDAC_MOD_STR))
 		return -EBUSY;
=20
 	if (!x86_match_cpu(amd64_cpuids))
diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 87e541c3bf4b..338101240c8d 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -938,7 +938,7 @@ static int __init i10nm_init(void)
 		return -EBUSY;
=20
 	owner =3D edac_get_owner();
-	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
+	if (owner && !streq(owner, EDAC_MOD_STR))
 		return -EBUSY;
=20
 	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 776c5db2f598..4225ad0ae13f 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -1990,7 +1990,7 @@ static int __init igen6_init(void)
 		return -EBUSY;
=20
 	owner =3D edac_get_owner();
-	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
+	if (owner && !streq(owner, EDAC_MOD_STR))
 		return -EBUSY;
=20
 	rc =3D pci_register_driver(&igen6_driver);
diff --git a/drivers/edac/imh_base.c b/drivers/edac/imh_base.c
index 6ca0df031bf5..5fbbd5dc69f3 100644
--- a/drivers/edac/imh_base.c
+++ b/drivers/edac/imh_base.c
@@ -543,7 +543,7 @@ static int __init imh_init(void)
 		return -EBUSY;
=20
 	owner =3D edac_get_owner();
-	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
+	if (owner && !streq(owner, EDAC_MOD_STR))
 		return -EBUSY;
=20
 	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index ea208c637113..5f2bbf2a89e4 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1528,7 +1528,7 @@ static int __init pnd2_init(void)
 		return -EBUSY;
=20
 	owner =3D edac_get_owner();
-	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
+	if (owner && !streq(owner, EDAC_MOD_STR))
 		return -EBUSY;
=20
 	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 6e248855a549..38948fd88c16 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -3629,7 +3629,7 @@ static int __init sbridge_init(void)
 		return -EBUSY;
=20
 	owner =3D edac_get_owner();
-	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
+	if (owner && !streq(owner, EDAC_MOD_STR))
 		return -EBUSY;
=20
 	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index ae2fda006632..2fcb766527e0 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -612,7 +612,7 @@ static int __init skx_init(void)
 		return -EBUSY;
=20
 	owner =3D edac_get_owner();
-	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
+	if (owner && !streq(owner, EDAC_MOD_STR))
 		return -EBUSY;
=20
 	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_panel_legacy.c b/drivers/gpu/drm=
/tilcdc/tilcdc_panel_legacy.c
index 7583b6ebba2a..9201080106ba 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_panel_legacy.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_panel_legacy.c
@@ -74,7 +74,7 @@ static int __init tilcdc_panel_copy_props(struct device_n=
ode *old_panel,
=20
 	/* Copy all panel properties to the new panel node */
 	for_each_property_of_node(old_panel, prop) {
-		if (!strncmp(prop->name, "compatible", sizeof("compatible")))
+		if (streq(prop->name, "compatible"))
 			continue;
=20
 		ret =3D tilcdc_panel_update_prop(&ocs, new_panel, prop->name,
diff --git a/include/linux/remoteproc/pruss.h b/include/linux/remoteproc/pr=
uss.h
index 039b50d58df2..0ff71e8ca016 100644
--- a/include/linux/remoteproc/pruss.h
+++ b/include/linux/remoteproc/pruss.h
@@ -74,7 +74,7 @@ static inline bool is_pru_rproc(struct device *dev)
 {
 	const char *drv_name =3D dev_driver_string(dev);
=20
-	if (strncmp(drv_name, PRU_RPROC_DRVNAME, sizeof(PRU_RPROC_DRVNAME)))
+	if (!streq(drv_name, PRU_RPROC_DRVNAME))
 		return false;
=20
 	return true;
diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/cod=
ecs/side-codecs/tas2781_hda_i2c.c
index 0c8faa583baa..28e33c9e960d 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -109,7 +109,7 @@ static int tas2781_read_acpi(struct tasdevice_priv *p, =
const char *hid)
 	sub =3D acpi_get_subsystem_id(ACPI_HANDLE(physdev));
 	if (IS_ERR(sub)) {
 		/* No subsys id in older tas2563 projects. */
-		if (!strncmp(hid, "INT8866", sizeof("INT8866"))) {
+		if (streq(hid, "INT8866")) {
 			p->speaker_id =3D -1;
 			goto end_2563;
 		}
diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index abd661db91e6..0a38e7f5cebb 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -860,13 +860,13 @@ static int dump_btf_kfuncs(struct btf_dump *d, const =
struct btf *btf)
 			continue;
=20
 		name =3D btf__name_by_offset(btf, t->name_off);
-		if (strncmp(name, KFUNC_DECL_TAG, sizeof(KFUNC_DECL_TAG)) =3D=3D 0) {
+		if (streq(name, KFUNC_DECL_TAG)) {
 			err =3D ptr_array_push(ft, &kfuncs);
 			if (err)
 				goto out;
 		}
=20
-		if (strncmp(name, FASTCALL_DECL_TAG, sizeof(FASTCALL_DECL_TAG)) =3D=3D 0=
) {
+		if (streq(name, FASTCALL_DECL_TAG)) {
 			err =3D ptr_array_push(ft, &fastcalls);
 			if (err)
 				goto out;
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 31c675cbab63..bcdb5da09b1f 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -277,7 +277,7 @@ int parse_callchain_record(const char *arg, struct call=
chain_param *param)
=20
 	do {
 		/* Framepointer style */
-		if (!strncmp(name, "fp", sizeof("fp"))) {
+		if (streq(name, "fp")) {
 			ret =3D 0;
 			param->record_mode =3D CALLCHAIN_FP;
=20
@@ -285,7 +285,7 @@ int parse_callchain_record(const char *arg, struct call=
chain_param *param)
 			if (tok) {
 				unsigned long size;
=20
-				if (!strncmp(tok, "defer", sizeof("defer"))) {
+				if (streq(tok, "defer")) {
 					param->defer =3D true;
 				} else {
 					size =3D strtoul(tok, &name, 0);
@@ -296,7 +296,7 @@ int parse_callchain_record(const char *arg, struct call=
chain_param *param)
 			break;
=20
 		/* Dwarf style */
-		} else if (!strncmp(name, "dwarf", sizeof("dwarf"))) {
+		} else if (streq(name, "dwarf")) {
 			const unsigned long default_stack_dump_size =3D 8192;
=20
 			ret =3D 0;
@@ -311,7 +311,7 @@ int parse_callchain_record(const char *arg, struct call=
chain_param *param)
 				ret =3D get_stack_size(tok, &size);
 				param->dump_size =3D size;
 			}
-		} else if (!strncmp(name, "lbr", sizeof("lbr"))) {
+		} else if (streq(name, "lbr")) {
 			if (!strtok_r(NULL, ",", &saveptr)) {
 				param->record_mode =3D CALLCHAIN_LBR;
 				ret =3D 0;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d060fca8090f..a40ca32fdaf7 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -445,8 +445,7 @@ bool evsel__is_function_event(struct evsel *evsel)
 {
 #define FUNCTION_EVENT "ftrace:function"
=20
-	return evsel->name &&
-	       !strncmp(FUNCTION_EVENT, evsel->name, sizeof(FUNCTION_EVENT));
+	return evsel->name && streq(FUNCTION_EVENT, evsel->name);
=20
 #undef FUNCTION_EVENT
 }
--=20
2.55.0


--cat6wfyj3lkwkym3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr5/f8ACgkQ64mZXMKQ
wqm4vw//ZgJLdQ6Q0+1KocDkBuS2+L6JwW4G9I+tlqQ1kG9qfYmHnmJXrLYM+n+W
RGwSE8d//whYkBf+qJvNAVhRrNLBJJ17+wSp9Cw+MpfEpcENzi6xqR4Tni/tHmfj
yDP6vMK3IlifATb3oWtnbuY71/0Oc3aJWsRK3QbN4M97cP9WVkyPeIAakQbtoqgi
AauGHK2OG5ncAEXMzCvbwAPQcUWU1eWMH5BBVPQquza8Gm+M6jn0mO5FZdARbUTw
6h4nUiwXG9oWZ9F+yWS8rHnqlzMDNftPEvGzs9kw046Lat676g7cUt7Wc+GXAzVG
szCk+OOQ2JUnskr5hYZ8J5PFIbjMcuty0sYg3eoi93In638O8ypT3qkr/hiKBoYf
6EU431Ih1MZN3nwP85Dx/PI38bHtSO8yONvd540AtYK/1EC0Uz5ybc911GegeOa/
q4P8N20iCYrtwrXOq8RLUMlLkuPpN+8Isz1A8+rGi3HyrcxQ0wN0mEL+eKQR34CE
AmbUI5Eh/FuS3GtVVXPo7ysyyJPx9zzUB2x/rVxvqADyuUX9WgUnbzoHm7yvCOY5
Vf+Ow9lw5Fngj3ofRDC/DLTPUaUZzz67ZtvGufwfiDarEZ927kwA15FP3llHKR6b
vncaoL3Z1VEU4d5jNH4Hs85AYSuVHc3knYVHGQA+4IqzSAh0gyA=
=MfHB
-----END PGP SIGNATURE-----

--cat6wfyj3lkwkym3--
