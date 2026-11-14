Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794669833;
	b=QxxJ35z9TVblSSEGu735/K2SpULvxVHJreVQ/D4DOSJZxp1VQT6sTuxhTWFEHtpZc3r6
	 cB3uawGDUFNM6UgedRyks++HcLCs/+bWRwoa5+GQ6pgCgnQTi1dyUH9MwHQ0Tfi2DJntH
	 wJKE5w7UGmYWUoUx8+riIJe+s+JCcu0oWgFhHI4CHgPt0GuvEJ/L/hSXZh7XfLlyXwyvk
	 hexRZCA/NTF/0P+7gXgXJ52ZlerpNTqyQ5u3HBq+ZL2RW9kRjfCYlHINiBkpqPvO36PO3
	 oPoPZpShjiy6YCdONIsuQDp5YUWqirq7y/T2sE4pmOOJR9SNBP0eMIdgvC4ozn562Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669833;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wXzh00OfSblbRDpkYv0gwVSnhwrQ4b8jZo+4YK7HnIs=;
	b=P5l9SEnKZXCQUDyvYaT95tE+uEGG9y59E0g6temWZ2hyqOECP0JP7Opeohs51EXBNrgh
	 0GF45VHtCZCmCptib2Kg+R6lX8QM8jaiWtRZk037ElogU+SzeGICGulFurZZrzftUl6TW
	 +OjPKizd3UpRSFZVZQtuEcGvyOSHPi012pRPr7dtI976mQBF0ITekR6oiM0kfs67wVogd
	 eMXQ+h3tySwkvU+likEhzVN8FOpDoV5blQ9wKOCoLDkpCfbUon+XalEvz9gwYwNa+DSG4
	 3Xl+K4a/LkvC4qmAIrN/DigeTlD79i/XjPqiDMeRsTud2wLNjfiOf944DwVZouF+krQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="orR/GQ50";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AA5606A333;
	Sat, 14 Nov 2026 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=orR/GQ50
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1503C1F000C5;
	Sat, 14 Nov 2026 15:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794669832;
	bh=wXzh00OfSblbRDpkYv0gwVSnhwrQ4b8jZo+4YK7HnIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=orR/GQ50aZeD60ZFOmyQBrH9IPuLbFCMTotWCrAW65o0ydaWRCz16qlXT22jN9/3v
	 NKv8bmps32h+V2P9b24tdtsAZvX+mgXvxQr5ExqfbKN1dR9RIPouPZP+/IkfmymXPL
	 zDSykcgD9h9DZIK3x2npJ5M6FzbRLfXvjNBwBFoQSV1Du+DkZo5ukUBl0mgCKJ3zQ3
	 ZHOcc+3qx+GBhMFuy5GzfPa1dHaIdp9BV6Dh0rge+8jLI/JTsKrpU/yU5QlOS06Ee+
	 Slr3nhAn3To8xL9uThelVfV5hzmDb3wv3SmwPlcciMpQW0MpyQWy1xuaLCAKyk6CRV
	 VV4qNHQJyaang==
Date: Sat, 14 Nov 2026 16:23:45 +0100
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
Subject: [PATCH v6 15/19] treewide: Replace some uses of str_has_prefix() by
 strprefix()
Message-ID: <95bfed420dd9616707e640708245ce2aebbb6ff6.1794667407.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="pe7m43gpxae6rttt"
Content-Disposition: inline
In-Reply-To: <cover.1794667407.git.alx@kernel.org>


--pe7m43gpxae6rttt
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
Subject: [PATCH v6 15/19] treewide: Replace some uses of str_has_prefix() by
 strprefix()
Message-ID: <95bfed420dd9616707e640708245ce2aebbb6ff6.1794667407.git.alx@kernel.org>
References: <cover.1794667407.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794667407.git.alx@kernel.org>

In many cases, it results in simpler code.  For example:

	-       prefix_len =3D str_has_prefix(name, PDSC_FW_COMPONENT_PREFIX);
	-       if (prefix_len)
	-               name +=3D prefix_len;
	+       name =3D strprefix(name, PDSC_FW_COMPONENT_PREFIX) ?: name;

It avoids explicit pointer arithmetic, which also prevents certain bugs.

After this commit, only a few uses of str_has_prefix() remain.  Those
are difficult to remove, as the surrounding code is deeply based on
lengths.  Let's leave those, as it's too risky to touch that code.

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 drivers/net/ethernet/amd/pds_core/fw.c |  5 +--
 kernel/printk/braille.c                | 14 ++++----
 kernel/trace/trace.c                   |  9 +++---
 kernel/trace/trace_events.c            |  3 +-
 kernel/trace/trace_events_hist.c       | 44 ++++++++++++--------------
 kernel/trace/trace_events_synth.c      |  8 +++--
 kernel/trace/trace_stack.c             |  6 ++--
 7 files changed, 42 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/fw.c b/drivers/net/ethernet/=
amd/pds_core/fw.c
index 7fe4594e9f9b..3f0b1137dd90 100644
--- a/drivers/net/ethernet/amd/pds_core/fw.c
+++ b/drivers/net/ethernet/amd/pds_core/fw.c
@@ -50,16 +50,13 @@ void pdsc_fw_components_invalidate(struct pdsc *pdsc)
=20
 static u8 pdsc_name_to_fw_type(const char *name)
 {
-	size_t prefix_len;
 	int i;
=20
 	/* "fw" without suffix maps to main firmware */
 	if (!strcmp(name, "fw"))
 		return PDS_CORE_FW_TYPE_MAIN;
=20
-	prefix_len =3D str_has_prefix(name, PDSC_FW_COMPONENT_PREFIX);
-	if (prefix_len)
-		name +=3D prefix_len;
+	name =3D strprefix(name, PDSC_FW_COMPONENT_PREFIX) ?: name;
=20
 	for (i =3D 1; i < ARRAY_SIZE(pdsc_fw_type_names); i++) {
 		if (pdsc_fw_type_names[i] &&
diff --git a/kernel/printk/braille.c b/kernel/printk/braille.c
index 17a9591e54ff..18847d88140b 100644
--- a/kernel/printk/braille.c
+++ b/kernel/printk/braille.c
@@ -11,18 +11,18 @@
=20
 int _braille_console_setup(char **str, char **brl_options)
 {
-	size_t len;
+	char *p;
=20
-	len =3D str_has_prefix(*str, "brl,");
-	if (len) {
+	p =3D strprefix(*str, "brl,");
+	if (p) {
 		*brl_options =3D "";
-		*str +=3D len;
+		*str =3D p;
 		return 0;
 	}
=20
-	len =3D str_has_prefix(*str, "brl=3D");
-	if (len) {
-		*brl_options =3D *str + len;
+	p =3D strprefix(*str, "brl=3D");
+	if (p) {
+		*brl_options =3D p;
 		*str =3D strchr(*brl_options, ',');
 		if (!*str) {
 			pr_err("need port name after brl=3D\n");
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e8c4efa8107b..1c40a00c5bd7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4085,19 +4085,18 @@ int set_tracer_flag(struct trace_array *tr, u64 mas=
k, int enabled)
=20
 int trace_set_options(struct trace_array *tr, char *option)
 {
-	char *cmp;
+	char *cmp, *p;
 	int neg =3D 0;
 	int ret;
 	size_t orig_len =3D strlen(option);
-	int len;
=20
 	cmp =3D strstrip(option);
=20
-	len =3D str_has_prefix(cmp, "no");
-	if (len)
+	p =3D strprefix(cmp, "no");
+	if (p)
 		neg =3D 1;
=20
-	cmp +=3D len;
+	cmp =3D p;
=20
 	mutex_lock(&event_mutex);
 	mutex_lock(&trace_types_lock);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index d467cdf9c805..72e42def1dd0 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -266,9 +266,8 @@ static struct trace_event_fields *find_event_field(cons=
t char *fmt,
 	const char *p =3D fmt;
 	int len;
=20
-	if (!(len =3D str_has_prefix(fmt, "REC->")))
+	if (!(fmt =3D strprefix(fmt, "REC->")))
 		return NULL;
-	fmt +=3D len;
 	for (p =3D fmt; *p; p++) {
 		if (!isalnum(*p) && *p !=3D '_')
 			break;
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_h=
ist.c
index c099bfbb9fb6..d5578b67ce9f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1485,25 +1485,26 @@ static int parse_action(char *str, struct hist_trig=
ger_attrs *attrs)
 static int parse_assignment(struct trace_array *tr,
 			    char *str, struct hist_trigger_attrs *attrs)
 {
-	int len, ret =3D 0;
+	char *p;
+	int ret =3D 0;
=20
-	if ((len =3D str_has_prefix(str, "key=3D")) ||
-	    (len =3D str_has_prefix(str, "keys=3D"))) {
-		attrs->keys_str =3D kstrdup(str + len, GFP_KERNEL);
+	if ((p =3D strprefix(str, "key=3D")) ||
+	    (p =3D strprefix(str, "keys=3D"))) {
+		attrs->keys_str =3D kstrdup(p, GFP_KERNEL);
 		if (!attrs->keys_str) {
 			ret =3D -ENOMEM;
 			goto out;
 		}
-	} else if ((len =3D str_has_prefix(str, "val=3D")) ||
-		   (len =3D str_has_prefix(str, "vals=3D")) ||
-		   (len =3D str_has_prefix(str, "values=3D"))) {
-		attrs->vals_str =3D kstrdup(str + len, GFP_KERNEL);
+	} else if ((p =3D strprefix(str, "val=3D")) ||
+		   (p =3D strprefix(str, "vals=3D")) ||
+		   (p =3D strprefix(str, "values=3D"))) {
+		attrs->vals_str =3D kstrdup(p, GFP_KERNEL);
 		if (!attrs->vals_str) {
 			ret =3D -ENOMEM;
 			goto out;
 		}
-	} else if ((len =3D str_has_prefix(str, "sort=3D"))) {
-		attrs->sort_key_str =3D kstrdup(str + len, GFP_KERNEL);
+	} else if ((p =3D strprefix(str, "sort=3D"))) {
+		attrs->sort_key_str =3D kstrdup(p, GFP_KERNEL);
 		if (!attrs->sort_key_str) {
 			ret =3D -ENOMEM;
 			goto out;
@@ -1514,17 +1515,15 @@ static int parse_assignment(struct trace_array *tr,
 			ret =3D -ENOMEM;
 			goto out;
 		}
-	} else if ((len =3D str_has_prefix(str, "clock=3D"))) {
-		str +=3D len;
-
-		str =3D strstrip(str);
-		attrs->clock =3D kstrdup(str, GFP_KERNEL);
+	} else if ((p =3D strprefix(str, "clock=3D"))) {
+		p =3D strstrip(p);
+		attrs->clock =3D kstrdup(p, GFP_KERNEL);
 		if (!attrs->clock) {
 			ret =3D -ENOMEM;
 			goto out;
 		}
-	} else if ((len =3D str_has_prefix(str, "size=3D"))) {
-		int map_bits =3D parse_map_size(str + len);
+	} else if ((p =3D strprefix(str, "size=3D"))) {
+		int map_bits =3D parse_map_size(p);
=20
 		if (map_bits < 0) {
 			ret =3D map_bits;
@@ -4881,8 +4880,7 @@ static int parse_actions(struct hist_trigger_data *hi=
st_data)
 	struct action_data *data;
 	unsigned int i;
 	int ret =3D 0;
-	char *str;
-	int len;
+	char *str, *p;
=20
 	for (i =3D 0; i < hist_data->attrs->n_actions; i++) {
 		enum handler_id hid =3D 0;
@@ -4890,14 +4888,14 @@ static int parse_actions(struct hist_trigger_data *=
hist_data)
=20
 		str =3D hist_data->attrs->action_str[i];
=20
-		if ((len =3D str_has_prefix(str, "onmatch(")))
+		if ((p =3D strprefix(str, "onmatch(")))
 			hid =3D HANDLER_ONMATCH;
-		else if ((len =3D str_has_prefix(str, "onmax(")))
+		else if ((p =3D strprefix(str, "onmax(")))
 			hid =3D HANDLER_ONMAX;
-		else if ((len =3D str_has_prefix(str, "onchange(")))
+		else if ((p =3D strprefix(str, "onchange(")))
 			hid =3D HANDLER_ONCHANGE;
=20
-		action_str =3D str + len;
+		action_str =3D p ?: str;
=20
 		switch (hid) {
 		case HANDLER_ONMATCH:
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_=
synth.c
index 016ca522e5af..2a7df262aa8f 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -2268,12 +2268,14 @@ static int create_synth_event(const char *raw_comma=
nd)
=20
 	/* This interface accepts group name prefix */
 	if (strchr(name, '/')) {
-		len =3D str_has_prefix(name, SYNTH_SYSTEM "/");
-		if (len =3D=3D 0) {
+		const char *n;
+
+		n =3D strprefix(name, SYNTH_SYSTEM "/");
+		if (!n) {
 			synth_err(SYNTH_ERR_INVALID_DYN_CMD, 0);
 			return -EINVAL;
 		}
-		name +=3D len;
+		name =3D n;
 	}
=20
 	len =3D name - raw_command;
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index e7f4e523587d..3f8ddb7b8530 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -539,10 +539,10 @@ static char stack_trace_filter_buf[COMMAND_LINE_SIZE+=
1] __initdata;
=20
 static __init int enable_stacktrace(char *str)
 {
-	int len;
+	char *p;
=20
-	if ((len =3D str_has_prefix(str, "_filter=3D")))
-		strscpy(stack_trace_filter_buf, str + len);
+	if ((p =3D strprefix(str, "_filter=3D")))
+		strscpy(stack_trace_filter_buf, p);
=20
 	stack_tracer_enabled =3D 1;
 	return 1;
--=20
2.55.0


--pe7m43gpxae6rttt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4fQEACgkQ64mZXMKQ
wqnihw/9F+OS6VOveTwq9EkkG0dru9Vlmdz3Xnn2uIxUZPThPmWnM5mzlSGjtKu1
WbXsMz0ObMC/RQY7xop03ixAwSwG7Ke4aM+ZhzwZKEsGe+BLkQQmrquLIP3GyQIh
FeGp3WFcuNekp2ImZ6W8M3Yfq6+B9n6UO/9x2ue7YXvFosZBBNFTU2LVgOA21fTg
fH1XsvEpa7ygIwknIH8m/NWi+zNFoXSelub51yxLcoL7EaeXnsSlt85apSeD6ArB
14DMbZWsJf0NsAknCmGDtOc3oC42mWyTQDPpJ3v+/+1d2Yrmvo0vthXdZ0d+aELY
83p8jlXgUCpo1MjzKZUoZoo2fpJSCyxAiulJ9R2Mn6+QJADgAMyXRSGsnm2PHYe1
oR7s0jyAWCaexFLpL/fz0+1qnauQqEUTWS5FWWW2G927Z6gN3a+1YOhtAuRJ+PhX
TeBNc++YgiXZf6i5ejhG8nFrcnh73ASZgcboxDPYXv96evYoxpSOjtLZMmj9pPC7
QwVwaa8KFvttB3FcU6IzFXlKQREl/oAKGDLbOSwqjDUGLyr+iZWNM2QRjwuKcgVZ
Li3c9S/0h5KzZEg6mYCmzkr9L0IrN5LpXUEKBKzu6oCgRQz93lCqPJXo3l+OIhu6
+4rZ8RpTRTKGpXd4ngPgGy7hWcT/TV4Rtlc/pieUYYR+rbv5HrQ=
=mhA1
-----END PGP SIGNATURE-----

--pe7m43gpxae6rttt--
