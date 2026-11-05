Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793900788;
	b=2jOR/kMLguvdUjnEzXJziUhPGLa8BrI6PJB3q8zDzdLf9IgtUbajrrmp/MXOA52Borw0
	 XQod6dGR5pkprxaLNGGvMc8NYSDfMk5fW6G+lhifya+77Zst0koAGcaDmOLeNwLn6UpvP
	 feXQUPWK2BAmg202B11yMzW/rneC+FS02xtbrvB60FHB6xkIYqnF7sbvh1dpoq4ei46G7
	 YVIYFP9nzoPAFerz+XDZzB/1US5Ozbbh/2Dhws/ufktYoBHUtByaF7L6rhaHdyA1yIAMg
	 GEeuAPvWhiWSSMD86yd8aSBkb7Z8DHroaVm7lMHhiWF9UdZ7yuKbltLmb1v5mp6HK2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900788;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1HgftRwAwLnhfiLR/85kVsbaRZr/mPYOvCEPHArlrQI=;
	b=vp6/n1egxVNoPUJit9TeSCh0t+4M6I67D9NIX+OX1IZ75ZphtFgei5QML/m18hLaBbqs
	 cwu9cl+oD7O1rOOLQIZ06I7oIuQe99hAr8doj7jZCSt3rLItIdLWN6F498QA14YPMUkpH
	 uojusx8/Qnc8MrMBcBdi6LXFsog2wibEQdxf+mJ2PpSw+fCDxB1FsPpxur0pvvEqzYN56
	 HlB6ieKy3uvHWrElH9sgZC7Z8igVts2bfBQGG+OuDAzR6QQbyGB9OlBtapdTD1pOsVyO9
	 lqrq7EYg+PffP70IgLdWNRw9y8MbiSFO/7v/6szOQUMJroQIZsJvH1+kZDHMOv5veqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1AnpClJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0144606A31B;
	Thu,  5 Nov 2026 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1AnpClJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47271F000C1;
	Thu,  5 Nov 2026 17:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793900787;
	bh=1HgftRwAwLnhfiLR/85kVsbaRZr/mPYOvCEPHArlrQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U1AnpClJtiEffs7LOpHK4RJoy2lTUfDrjwyq231gCUp3ByZmkRyE6+Paul9LB90OX
	 TyUiX0r3yI1J5SV+vAgJny0EWrDPDgQn7PGX4KjisK1QJyFVuTc+KjwHxoa+ek4ZiZ
	 uZI2dc1CyqPimq2cLXRgdsvUFiNpSX9GCc0rUDY2HAWoq2eDh0oL+Kk0Rke+A6fcg3
	 H3BOUHV1bY0fVWemVVdJxjmTpG3tuhTKvIXtKxQ3tLgVChSO/bUXvBJKpQeG6nVGvq
	 ev9zXEChRksm7WvlZ3VA2SQU9LATOu2U3QGqzEhFnBho8bg/XwYnhTz5/tEpbDMFZE
	 LbOJzLaOBjuWQ==
Date: Thu, 5 Nov 2026 18:46:18 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1 1/2] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <auy0O467UqOzqYub@devuan>
References: <cover.1793876837.git.alx@kernel.org>
 <9c81f6f62fd0e908e683c4c08b09a1f95bc2ec9c.1793876837.git.alx@kernel.org>
 <20261105111423.360f4ba8@gandalf.local.home>
 <auyuINXEJKc1KoG7@devuan>
 <20261105115019.2fe7c91b@gandalf.local.home>
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
	protocol="application/pgp-signature"; boundary="kholroagynivwo7h"
Content-Disposition: inline
In-Reply-To: <20261105115019.2fe7c91b@gandalf.local.home>


--kholroagynivwo7h
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1 1/2] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <auy0O467UqOzqYub@devuan>
References: <cover.1793876837.git.alx@kernel.org>
 <9c81f6f62fd0e908e683c4c08b09a1f95bc2ec9c.1793876837.git.alx@kernel.org>
 <20261105111423.360f4ba8@gandalf.local.home>
 <auyuINXEJKc1KoG7@devuan>
 <20261105115019.2fe7c91b@gandalf.local.home>
MIME-Version: 1.0
In-Reply-To: <20261105115019.2fe7c91b@gandalf.local.home>

Hi Steve,

> Date: 2026-11-05 11:50:19-0500
> From: Steven Rostedt <rostedt@goodmis.org>
>
[...]
> > > > Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.=
com> =20
> > >=20
> > > Is there a link to the report? Please add that. =20
> >=20
> > Message-Id: <20261104-fwnode-for-each-prop-v1-1-6e28fe1c72c4@oss.qualco=
mm.com>
> >=20
> > or in link format,
> >=20
> > Link: <https://lore.kernel.org/linux-hardening/20261104-fwnode-for-each=
-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/>
> >=20
> > Which one do you prefer?
>=20
> The correct method is:
>=20
>  Link: https://lore.kernel.org/linux-hardening/20261104-fwnode-for-each-p=
rop-v1-1-6e28fe1c72c4@oss.qualcomm.com/

Ok; done.

[...]
> > > > + * DEPRECATED: Use strprefix() =20
> > >=20
> > > No, it is still useful. Converting trace_event_filter() to strprefix()
> > > would be very painful, and likely error prone. =20
> >=20
> > What is trace_event_filter()?
>=20
> Oops, typo, I meant trace_event_filter.c

Still not found.

	alx@devuan:~/src/linux/linux/master$ find | grep trace_event_filter.c
	alx@devuan:~/src/linux/linux/master$ find | grep trace.event.filter
	alx@devuan:~/src/linux/linux/master$=20

Oh, now I see:

	$ grep -rl str_has_prefix | grep trace.event
	kernel/trace/trace_events_user.c
	kernel/trace/trace_events.c
	kernel/trace/trace_events_synth.c
	kernel/trace/trace_events_filter.c
	kernel/trace/trace_events_hist.c

<trace_events_filter.c>, then.  I've been having a look at that file,
out of curiosity, and it'd be simpler (more robust) with pointers:

	diff --git i/kernel/trace/trace_events_filter.c w/kernel/trace/trace_event=
s_filter.c
	index c10951bcfc5f..44594a41d2d6 100644
	--- i/kernel/trace/trace_events_filter.c
	+++ w/kernel/trace/trace_events_filter.c
	@@ -1674 +1674 @@ static int parse_pred(const char *str, void *data,
	-       int s;
	+       char *s;
	@@ -1675,0 +1676,9 @@ static int parse_pred(const char *str, void *data,
	+       char *p;
	+
	+#define CTYPE_LOWER_C     "abcdefghijklmnopqrstuvwxyz"
	+#define CTYPE_UPPER_C     "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	+#define CTYPE_DIGIT_C     "0123456789"
	+#define CTYPE_BLANK_C     " \t"
	+#define CTYPE_SPACE_C     CTYPE_BLANK_C "\n\v\f\r"
	+#define CTYPE_ALPHA_C     CTYPE_LOWER_C CTYPE_UPPER_C
	+#define CTYPE_ALNUM_C     CTYPE_ALPHA_C CTYPE_DIGIT_C
	@@ -1678,3 +1687,2 @@ static int parse_pred(const char *str, void *data,
	-       while (isspace(str[i]))
	-               i++;
	-       s =3D i;
	+       s =3D str;
	+       s =3D stpspn(s, CTYPE_SPACE_C);
	@@ -1682,6 +1690,3 @@ static int parse_pred(const char *str, void *data,
	-       while (isalnum(str[i]) || str[i] =3D=3D '_')
	-               i++;
	-
	-       len =3D i - s;
	-
	-       if (!len)
	+       p =3D s;
	+       p =3D stpspn(p, CTYPE_ALNUM_C "_");
	+       if (p =3D=3D s)
	@@ -1690 +1695 @@ static int parse_pred(const char *str, void *data,
	-       field_name =3D kmemdup_nul(str + s, len, GFP_KERNEL);
	+       field_name =3D kmemdup_nul(s, p - s, GFP_KERNEL);
	@@ -1704 +1709 @@ static int parse_pred(const char *str, void *data,
	-       if ((len =3D str_has_prefix(str + i, ".ustring"))) {
	+       if (char *p_ =3D strprefix(p, ".ustring")) {
	@@ -1706 +1711 @@ static int parse_pred(const char *str, void *data,
	-               i +=3D len;
	+               p =3D p_;
	@@ -1710 +1715 @@ static int parse_pred(const char *str, void *data,
	-       if ((len =3D str_has_prefix(str + i, ".function"))) {
	+       if (char *p_ =3D strprefix(p, ".function")) {
	@@ -1712 +1717 @@ static int parse_pred(const char *str, void *data,
	-               i +=3D len;
	+               p =3D p_;
	@@ -1715,2 +1720 @@ static int parse_pred(const char *str, void *data,
	-       while (isspace(str[i]))
	-               i++;
	+       p =3D stpspn(p, CTYPE_SPACE_C);
	@@ -1721 +1725 @@ static int parse_pred(const char *str, void *data,
	-               if (strncmp(str + i, ops[op], strlen(ops[op])) =3D=3D 0)
	+               if (strprefix(p, ops[op]))
	@@ -1726 +1730 @@ static int parse_pred(const char *str, void *data,
	-               parse_error(pe, FILT_ERR_INVALID_OP, pos + i);
	+               parse_error(pe, FILT_ERR_INVALID_OP, pos + (p - str));
	@@ -1730,6 +1734,3 @@ static int parse_pred(const char *str, void *data,
	-       i +=3D strlen(ops[op]);
	-
	-       while (isspace(str[i]))
	-               i++;
	-
	-       s =3D i;
	+       p +=3D strlen(ops[op]);
	+       p =3D stpspn(p, CTYPE_SPACE_C);
	+       s =3D p;
	@@ -1748 +1749 @@ static int parse_pred(const char *str, void *data,
	-                       parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i=
);
	+                       parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + (=
p - str));
	@@ -1758 +1759 @@ static int parse_pred(const char *str, void *data,
	-                       parse_error(pe, FILT_ERR_INVALID_OP, pos + i);
	+                       parse_error(pe, FILT_ERR_INVALID_OP, pos + (p - st=
r));
	@@ -1762 +1763 @@ static int parse_pred(const char *str, void *data,
	-               if (isdigit(str[i])) {
	+               if (isdigit(*p)) {
	@@ -1764,2 +1765 @@ static int parse_pred(const char *str, void *data,
	-                       while (isalnum(str[i]))
	-                               i++;
	+                       p =3D stpspn(p, CTYPE_ALNUM_C);
	@@ -1767 +1766,0 @@ static int parse_pred(const char *str, void *data,
	-                       len =3D i - s;
	@@ -1769,2 +1768,3 @@ static int parse_pred(const char *str, void *data,
	-                       if (len >=3D sizeof(num_buf)) {
	-                               parse_error(pe, FILT_ERR_OPERAND_TOO_LONG,=
 pos + i);
	+                       len =3D p - s;
	+                       if (len >=3D ARRAY_SIZE(num_buf)) {
	+                               parse_error(pe, FILT_ERR_OPERAND_TOO_LONG,=
 pos + (p - str));
	@@ -1774,2 +1774 @@ static int parse_pred(const char *str, void *data,
	-                       memcpy(num_buf, str + s, len);
	-                       num_buf[len] =3D 0;
	+                       strcpy(mempcpy(num_buf, s, len), "");
	@@ -1779 +1778 @@ static int parse_pred(const char *str, void *data,
	-                               parse_error(pe, FILT_ERR_INVALID_VALUE, po=
s + i);
	+                               parse_error(pe, FILT_ERR_INVALID_VALUE, po=
s + (p - str));
	@@ -1783,3 +1782,2 @@ static int parse_pred(const char *str, void *data,
	-                       s =3D i;
	-                       for (; str[i] && !isspace(str[i]); i++)
	-                               ;
	+                       s =3D p;  // XXX: Dead code?  (line 1734+2)
	+                       p =3D stpcspn(p, CTYPE_SPACE_C);
	@@ -1787,2 +1785,2 @@ static int parse_pred(const char *str, void *data,
	-                       len =3D i - s;
	-                       name =3D kmemdup_nul(str + s, len, GFP_KERNEL);
	+                       len =3D p - s;
	+                       name =3D kmemdup_nul(s, len, GFP_KERNEL);
	@@ -1794 +1792 @@ static int parse_pred(const char *str, void *data,
	-                               parse_error(pe, FILT_ERR_NO_FUNCTION, pos =
+ i);
	+                               parse_error(pe, FILT_ERR_NO_FUNCTION, pos =
+ (p - str));
	@@ -1801 +1799 @@ static int parse_pred(const char *str, void *data,
	-                       parse_error(pe, FILT_ERR_NO_FUNCTION, pos + i);
	+                       parse_error(pe, FILT_ERR_NO_FUNCTION, pos + (p - s=
tr));
	@@ -1818 +1816 @@ static int parse_pred(const char *str, void *data,
	-                       parse_error(pe, FILT_ERR_IP_FIELD_ONLY, pos + i);
	+                       parse_error(pe, FILT_ERR_IP_FIELD_ONLY, pos + (p -=
 str));
	@@ -1827,2 +1825,4 @@ static int parse_pred(const char *str, void *data,
	-               if (str[i] =3D=3D '\'' || str[i] =3D=3D '"')
	-                       q =3D str[i];
	+               if (strspn(p, "'"))
	+                       q =3D "'";
	+               else if (strspn(p, "\""))
	+                       q =3D "\"";
	@@ -1830 +1830 @@ static int parse_pred(const char *str, void *data,
	-                       q =3D 0;
	+                       q =3D NULL;
	@@ -1832,2 +1832,2 @@ static int parse_pred(const char *str, void *data,
	-               for (i++; str[i]; i++) {
	-                       if (q && str[i] =3D=3D q)
	+               for (p++; !streq(p, ""); p++) {
	+                       if (q && strspn(p, q))
	@@ -1835,2 +1835 @@ static int parse_pred(const char *str, void *data,
	-                       if (!q && (str[i] =3D=3D ')' || str[i] =3D=3D '&' =
||
	-                                  str[i] =3D=3D '|'))
	+                       if (!q && strspn(p, ")&|"))
	@@ -1842 +1841 @@ static int parse_pred(const char *str, void *data,
	-               len =3D i - s;
	+               len =3D p - s;
	@@ -1844 +1843 @@ static int parse_pred(const char *str, void *data,
	-                       parse_error(pe, FILT_ERR_OPERAND_TOO_LONG, pos + i=
);
	+                       parse_error(pe, FILT_ERR_OPERAND_TOO_LONG, pos + (=
p - str));
	@@ -1852,2 +1851 @@ static int parse_pred(const char *str, void *data,
	-               memcpy(pred->regex->pattern, str + s, len);
	-               pred->regex->pattern[len] =3D 0;
	+               strcpy(memcpy(pred->regex->pattern, s, len), "");
	@@ -1855 +1853 @@ static int parse_pred(const char *str, void *data,
	-       } else if (!strncmp(str + i, "CPUS", 4)) {
	+       } else if (strprefix(p, "CPUS")) {
	@@ -1866 +1864 @@ static int parse_pred(const char *str, void *data,
	-                       parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i=
);
	+                       parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + (=
p - str));
	@@ -1876 +1874 @@ static int parse_pred(const char *str, void *data,
	-                       parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i=
);
	+                       parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + (=
p - str));
	@@ -1880,4 +1878,3 @@ static int parse_pred(const char *str, void *data,
	-               /* Skip CPUS */
	-               i +=3D 4;
	-               if (str[i++] !=3D '{') {
	-                       parse_error(pe, FILT_ERR_MISSING_BRACE_OPEN, pos +=
 i);
	+               p =3D strprefix(p, "CPUS");
	+               if (!strspn(p, "{")) {
	+                       parse_error(pe, FILT_ERR_MISSING_BRACE_OPEN, pos +=
 (p - str));
	@@ -1886 +1883 @@ static int parse_pred(const char *str, void *data,
	-               maskstart =3D i;
	+               maskstart =3D p;
	@@ -1889,5 +1886,3 @@ static int parse_pred(const char *str, void *data,
	-               for (; str[i] && str[i] !=3D '}'; i++)
	-                       ;
	-
	-               if (str[i] !=3D '}') {
	-                       parse_error(pe, FILT_ERR_MISSING_BRACE_CLOSE, pos =
+ i);
	+               p =3D stpcspn(p, "}");
	+               if (streq(p, "")) {
	+                       parse_error(pe, FILT_ERR_MISSING_BRACE_CLOSE, pos =
+ (p - str));
	@@ -1897,2 +1892,2 @@ static int parse_pred(const char *str, void *data,
	-               if (maskstart =3D=3D i) {
	-                       parse_error(pe, FILT_ERR_INVALID_CPULIST, pos + i);
	+               if (maskstart =3D=3D p) {
	+                       parse_error(pe, FILT_ERR_INVALID_CPULIST, pos + (p=
 - str));
	@@ -1903 +1898 @@ static int parse_pred(const char *str, void *data,
	-               tmp =3D kmalloc((i - maskstart) + 1, GFP_KERNEL);
	+               tmp =3D kmalloc((p - maskstart) + 1, GFP_KERNEL);
	@@ -1907 +1902 @@ static int parse_pred(const char *str, void *data,
	-               strscpy(tmp, str + maskstart, (i - maskstart) + 1);
	+               strcpy(mempcpy(tmp, maskstart, p - maskstart), "");
	@@ -1917 +1912 @@ static int parse_pred(const char *str, void *data,
	-                       parse_error(pe, FILT_ERR_INVALID_CPULIST, pos + i);
	+                       parse_error(pe, FILT_ERR_INVALID_CPULIST, pos + (p=
 - str));
	@@ -1923 +1918 @@ static int parse_pred(const char *str, void *data,
	-               i++;
	+               p =3D strprefix(p, "}");

BTW, I've included there a comment in a line of code that I think might
be dead code (I didn't verify thoroughly, but at first glance, it seems
to be).  grep 'XXX' above.

> > 	alx@devuan:~/src/linux/linux/master$ grep -rn '\<trace_event_filter\>'
> > 	alx@devuan:~/src/linux/linux/master$ grepc trace_event_filter .
> > 	alx@devuan:~/src/linux/linux/master$ grep -rn trace_event_filter
> > 	kernel/trace/trace_events.c:2833:static const struct file_operations f=
trace_event_filter_fops =3D {
> > 	kernel/trace/trace_events.c:3222:			*fops =3D &ftrace_event_filter_fop=
s;
> >=20
> > If you point me to a specific line of code, I can attempt a rewrite.
>=20
> I rather not touch that code.

Yeah, I don't intend to touch that code seriously; it was just to show
that it can be done, and it doesn't make it worse.  If the code was
written from scratch, I'd certainly write it with strprefix().  The only
reason to keep str_has_prefix() in it is to not touch old code that
works, but not because it's more appropriate.

So, I'd like to mark str_has_prefix() as deprecated.

> > > > + *
> > > >   * A common way to test a prefix of a string is to do:
> > > >   *  strncmp(str, prefix, sizeof(prefix) - 1)
> > > >   *
> > > >   * But this can lead to bugs due to typos, or if prefix is a point=
er
> > > > - * and not a constant. Instead use str_has_prefix().
> > > > + * and not a constant. Instead use strprefix(). =20
> > >=20
> > > The above can be replaced with:
> > >=20
> > >  * This is useful for testing for a prefix and returning the length.
> > >  * If you only need to test the prefix and perhaps get the pointer to=
 the
> > >  * position of the string after the prefix, then use strprefix(). =20
> >=20
> > Ok, conditional to being convinced that str_has_prefix() is
> > actually useful in some case.
>=20
> Note, the only "bug" is that it can't handle an empty prefix case, which
> was never what it was designed to do. The place that the above fixes, was=
 a
> helper function that used this inappropriately.
>=20
> Hence, the use of str_has_prefix() was never meant for an empty string. I
> should have added (and can still add)
>=20
> 	/* Empty prefix is undefined */
> 	WARN_ON_ONCE(!prefix[0]);

Why make it not work for a valid string unnecessarily?  We can do better
by returning a pointer, which doesn't need to have this limitation at
all.  It's the "good taste" design of
<https://www.youtube.com/watch?v=3D78Y17hAo96I>.

> The fwnode_name_eq() could have done:
>=20
> 	/* Empty prefix always matches */
> 	return name[0] || str_has_prefix(node_name, name) =3D=3D len;

Yes, you can.  But why would you do it, if you can avoid it?

> Instead.
>=20
> -- Steve


Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es>

--kholroagynivwo7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrswOQACgkQ64mZXMKQ
wql6Lg//YVBu5quwKa48IYsK3MUvtjfek+VRm3sBMvw34uqQQbD4VrJpvigFfuv7
K5iFoOA3kh6Qpf+mXS/ZrbN4wEm9g+ck7ho4UsZFZZrAsPxgE9YKG+F8tO262GTj
nzfG7tVh2fpW+dTuiia3LYH+BIauc5oOb0FiXWXHHjqtYWtHJAvClBuhDHsW3vdL
adS4QqkAC+TB2YEgQJf4VtiaGoTevtZ33/hoBuo1gBAPtc+ykQPtxl+6Q+2gImFv
ZZmYdkFHxQ4VinCfqgOj9N7YiQZMUam+E/ocLRNffcPH0R95bMvsmM8POqMEKwoT
p4ui9Sr3iYMuGqBBtMo228LpRSV+73Ol557412C5JjY3YH43pz4WW6dzzyYyOlAC
dd+WVLOVnIhSbqxg1H0zc675GzNqtBQ0TaRVIiRj06hLnfcNTKV8K9yjVB8TUvQZ
UrLm3q6dDesvixkSdZqDfjTKB4XUZTZOZwYX+9bpOOO80W1G0j9guJ9IY0EVOFwt
Dbh5ssqDErIvObM6SMeg3mRcGZeldt7uPyouOKqOPy3Wnx1SllfHVagH1rDaCjxW
wItWsGJMZ8VrCgBeZS9PgBZOiUyvNJ96Y+f7dPdTyt+k6sJjfm8NxJ9AVL2OMxvY
daJtFOlWr9xB7qqRWa9i5rVmh7Qtbyugex6B/9x/p1uZaIaUPs8=
=Ik32
-----END PGP SIGNATURE-----

--kholroagynivwo7h--
