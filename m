Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604390;
	b=NgHYEgK1A0tRqUosDk+hOLVnQvWYU/l89NAT7VppGsa8Scuco6G0IhOxT23cOXR1edW2
	 fCjuqfJ0TkvS7HV3C+Pmu2wD5iBM3+cMWRtOJW2/VMP2IUpAIX/+fG5TB5C88ojmI18M0
	 /pb1yB1TDZWQ7G6cWHaf75YZoOOw7H1Bezw5D3UfWwPiZ/HyJq0FqUm/QPciKh+QkE5BO
	 BJ2M49kQoJZH9N2AUxni86PKgvsfMis4LmJ2PYgyTW7SGKaeYVnDwtW/7iARVFEbCkux3
	 xgBcCfE3x082oByG+c6Zu2ar0gNLtR+p9lTMhBfhiuaYG1epg7P/5gnKbq81qk/t9aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604390;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=dGx07IkTX64qfZTXn4n2KUmOW0Nf0dSqzevN84bvutE=;
	b=qwz7i8PAxi7o6DH0f05lz0d6F9r3gtGz6HLCc7yCG1dzluM35vj8cAs8mfAKijS8IpyL
	 ytM/eVMvMxDtH1/pD3RqGXlTB2Hpnf4PKuvFxIMVNrslN9B/5EW7nO4cEpUCBciBnPm/m
	 gLBlMo4VmxJdbCL/Bw4pqhgvA4efqWWX8iWx6DfyYxeKD6X1AmJO7coQ7x9cOOeBicrjd
	 8BbHobp8crrfdhxwY4SLgSN94eqQK1sUahlOHTuLgrq0Uh0OITfJRfJJy9MQo8OAMufLZ
	 Xgfknm4gqcA8UrVmuNKAEdRDxwfG0oVTBUytEmeJfr2AvfcGUZ2b/EUTxeuiZSwmqEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bvHfQKWP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95C7606A32E;
	Fri, 13 Nov 2026 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bvHfQKWP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFFE1F000C5;
	Fri, 13 Nov 2026 21:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794604390;
	bh=dGx07IkTX64qfZTXn4n2KUmOW0Nf0dSqzevN84bvutE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bvHfQKWPdlo4UWP6zlAXCICnXXN8xXAaOfYS3jFZRikl03GyRsU02iSf6m5/pZrkS
	 X16xNV1eE1vy2LXeJruDIF6BawYjER8b20i9zJ9rRUmoJF94BeoB8Cwx2K+VG769Hz
	 VTI3jrWJybkC2I6Inb05TZTHNheZ2b4menjPYKJ9TuNryPyu5Pqjl5pShuMvSZd3QE
	 SdIdHOzwQDVL6GkAP6JWRNE4D+0tWI8DqpM48mMHbRMrHd2IKqEfqBaaemS+z5bPkT
	 d1QWjiqw8fwTjS/WfKrEX62Osv9j+l1bi7EJShvYy8Y/xLIsC4vIf4eQPHzmN6inHC
	 M58N8Q7DnfZNA==
Date: Fri, 13 Nov 2026 22:13:01 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
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
Subject: Re: [PATCH v5 7/7] string: Implement strstarts() with strprefix()
Message-ID: <avd794VWdjncD9YI@devuan>
References: <cover.1794574496.git.alx@kernel.org>
 <382a44f7c68672ecead2436d9f569ee23f383830.1794574496.git.alx@kernel.org>
 <avciONW-b_WXoetv@ashevche-desk.local>
 <avcj0YbmHRyhFW-Y@devuan>
 <avcntwOjI2i4seyB@ashevche-desk.local>
 <avcrlaWDlBVAHpnj@devuan>
 <avc1LK0_Deeh0zZo@ashevche-desk.local>
 <avd4XpBivw86pBYh@devuan>
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
	protocol="application/pgp-signature"; boundary="7pxy7jt4w7gbfcvk"
Content-Disposition: inline
In-Reply-To: <avd4XpBivw86pBYh@devuan>


--7pxy7jt4w7gbfcvk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
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
Subject: Re: [PATCH v5 7/7] string: Implement strstarts() with strprefix()
Message-ID: <avd794VWdjncD9YI@devuan>
References: <cover.1794574496.git.alx@kernel.org>
 <382a44f7c68672ecead2436d9f569ee23f383830.1794574496.git.alx@kernel.org>
 <avciONW-b_WXoetv@ashevche-desk.local>
 <avcj0YbmHRyhFW-Y@devuan>
 <avcntwOjI2i4seyB@ashevche-desk.local>
 <avcrlaWDlBVAHpnj@devuan>
 <avc1LK0_Deeh0zZo@ashevche-desk.local>
 <avd4XpBivw86pBYh@devuan>
MIME-Version: 1.0
In-Reply-To: <avd4XpBivw86pBYh@devuan>

> Date: 2026-11-13 21:57:24+0100
> From: Alejandro Colomar <alx+linux-hardening@kernel.org>
>
[...]
> > > -  strstarts():
> > > 	It could be improved by returning a boolean-like pointer,
> > > 	instead of a bool, but:
> > >=20
> > > 	-  We may need to fix some callers, since some of them might
> > > 	   need an explicit conversion with !!.  It'd be risky to change
> > > 	   the implementation without first verifying that.
> >=20
> > How many cases do we have that needs special attention? Can you run spa=
tch to
> > grep those?
>=20
> I *think* the only ones I expect this would be necessary are functions
> that return a boolean-like int.
>=20
> 	// returns 1:true 0:false -1:error=3D
> 	int
> 	foo(...)
> 	{
> 		...
> 		return !!strprefix(...);
> 	}

I've searched for cases of this, and also for cases of assignment to
a variable that might be of type int (I expect this to be less
frequent).  I haven't used spatch(1) so far, but just grep(1):

	$ grep -rn -e '=3D .*strstarts(' -e 'return .*strstarts('
	drivers/mtd/spi-nor/issi.c:141:	return name && strstarts(name, "pm25lv");
	drivers/platform/x86/dell/dell-lis3lv02d.c:109:	return strstarts(adap->nam=
e, "SMBus I801 adapter");
	arch/arm/kernel/module.c:25:	return strstarts(name, ".init") ||
	arch/arm/kernel/module.c:32:	return strstarts(name, ".exit") ||
	arch/powerpc/perf/imc-pmu.c:1026:	return strstarts(event->pmu->name, "thre=
ad_imc");
	tools/perf/util/map.c:21:	return strstarts(filename, "/data/app-lib/") ||
	tools/perf/util/annotate-arch/annotate-x86.c:144:	if (arch->family >=3D 0x=
15 && (strstarts(ins1, "test") ||
	tools/perf/util/annotate-arch/annotate-x86.c:150:	if (arch->family >=3D 0x=
19 && (strstarts(ins1, "add") ||
	tools/perf/util/annotate-arch/annotate-x86.c:200:		arch->ins_is_fused =3D =
strstarts(cpuid, "AuthenticAMD") ?
	tools/perf/util/symbol.c:854:	if (e_machine =3D=3D EM_S390 && strstarts(na=
me, "psw_idle")) {
	tools/perf/util/env.c:733:		return strstarts(perf_arch, "ppc64") ? EM_PPC6=
4 : EM_PPC;
	tools/perf/util/env.c:1049:		is_amd =3D env->cpuid && strstarts(env->cpuid=
, "AuthenticAMD") ? 1 : -1;
	tools/perf/util/env.c:1072:		is_intel =3D env->cpuid && strstarts(env->cpu=
id, "GenuineIntel") ? 1 : -1;
	tools/perf/util/symbol.h:55:	return strstarts(str, KLP_SYM_PREFIX);
	tools/perf/builtin-trace.c:2272:			if (*after =3D=3D '=3D' && (strstarts(a=
fter + 1, "0x") ||
	tools/perf/perf.c:143:	return (strstarts(var, header) && !strcmp(var + str=
len(header), c->cmd));
	tools/perf/tests/symbols.c:155:	if (dso !=3D text_dso && strstarts(dso__sh=
ort_name(dso), dso__short_name(text_dso)))
	tools/testing/selftests/bpf/prog_tests/sockmap_redir.c:321:	if (type =3D=
=3D SK_SKB_INGRESS && strstarts(out, "v_"))
	tools/objtool/klp-sympos.c:372:	return strstarts(sym->sec->name, ".init");
	tools/objtool/klp-checksum.c:66:	return strstarts(sym->sec->name, ".rodata=
=2Ecst") &&
	tools/objtool/klp-diff.c:204:		export->mod_ns =3D strstarts(namespace, "mo=
dule:");
	tools/objtool/klp-diff.c:339:	return strstarts(sym->name, ".L");
	tools/objtool/klp-diff.c:380:	return strstarts(sec->name, ".discard.");
	tools/objtool/klp-diff.c:422:	return strstarts(sym->name, "__initcall__") =
||
	kernel/module/main.c:1866:	return strstarts(name, ".init");
	kernel/module/main.c:1871:	return strstarts(name, ".exit");

=46rom all these, only one case was using int.  Here's a patch for making
it more robust:

	diff --git i/tools/perf/util/map.c w/tools/perf/util/map.c
	index 41cdddc987ee..944f10d32796 100644
	--- i/tools/perf/util/map.c
	+++ w/tools/perf/util/map.c
	@@ -16,7 +16,7 @@
	 #include "thread.h"
	 #include "vdso.h"
	=20
	-static inline int is_android_lib(const char *filename)
	+static inline bool is_android_lib(const char *filename)
	 {
		return strstarts(filename, "/data/app-lib/") ||
		       strstarts(filename, "/system/lib/");

It's technically not necessary, since the '||' operator converts to
bool, but just in case someone removes one of those calls, using bool
will prevent a bug.

All the other cases were either using 'bool', or didn't need a change
for other reasons.

So, I can include this diff as a preparation patch in this set, and then
make strstarts() be
	#define strstarts(s, prefix)  strprefix(s, prefix)

And then have a global search-and-replace for it.


Cheers,
Alex

>=20
> >=20
> > > 	   To avoid that risk, I prefer adding a new API, and
> > > 	   deprecating strstarts() for new code.  Over time, I could
> > > 	   slowly migrate users from strstarts() to strprefix().
> >=20
> > I believe this is unneeded step which may last for a few releases witho=
ut even
> > guarantee that it will be finished. In such a case I would like to see =
a branch
> > with full conversion done before you start sending per-subsystem pieces=
 out.
>=20
> Okay; I can do that.
>=20
> > > 	-  The name isn't ideal, since "starts" doesn't specify whether
> > > 	   it looks for a string that starts with a given prefix, or if
> > > 	   it looks for a string that starts with any of the given
> > > 	   characters.
> > >=20
> > > 	   That is, by the name, I wouldn't be able to know whether
> > > 	   strstarts implements
> > >=20
> > > 		bool strstarts(const char *s, const char *xxx)
> > > 		{
> > > 			return strspn(s, xxx);
> > > 		}
> > > 	   or
> > > 		bool strstarts(const char *s, const char *xxx)
> > > 		{
> > > 			return strprefix(s, xxx);
> > > 		}
> >=20
> > I didn't get this. We should not really need an implementation details =
of
> > the API beneath. Documentation what should be read before use. Do we ha=
ve
> > documentation for strstarts()? Is it clear? Maybe that what should be a=
ddressed
> > first?
> >=20
> > > -  strends():
> > > 	Same as with strstarts() but from the end.
> > >=20
> > > -  str_has_prefix():
> > > 	It was an attempt at strprefix(), but with a problematic
> > > 	approach.  It's frozen because of trace code.
> > >=20
> > > -  strprefix()/strsuffix():
> > > 	I'd add them to slowly replace strstarts()/strends().
> >=20
> > See above about "slowly"...
> >=20
> > > > > I prefer replacing strstarts()/strends() with strprefix()/strsuff=
ix().
> > > > >=20
> > > > > But if you prefer changing strstarts() to return a pointer, I'm a=
lso
> > > > > okay-ish with it.  It's not a perfect name, but I can live with i=
t.
> > > > >=20
> > > > > > However, after looking at the uses in the kernel, I prefer
> > > > > > to see the strprefix() be not implemented at all, just optimiza=
tion against
> > > > > > strstarts()/strends() if required can be performed.
> > > > >=20
> > > > > I don't understand this last sentence.
> > > >=20
> > > > It's basically repeats the idea of having only one pair out of two.
> > >=20
> > > Ok.
> > >=20
> > > > With this series will be
> > > >=20
> > > > str_has_previx()
> > > > strstarts()
> > > > strends()
> > > > strprefix()
> > > > // potentially strsuffix()
> > >=20
> > > Yes.  I'd like to replace strstarts()/strends() with
> > > strprefix()/strsuffix(), but prefer to do that slowly, to avoid
> > > introducing bugs due to missing explicit conversions to bool.
> > >=20
> > > Should I add notes that the strstarts()/strends() APIs are deprecated?
> >=20
> > Isn't Steven against that? I already forgot his points.
>=20
> As far as I understood, he was against deprecating str_has_prefix(), but
> we didn't yet talk about strstarts().
>=20
> > Keeping them
> > just as aliases to strprefix()/strsuffix() perhaps the good start
> > (see below).
>=20
> Ok.
>=20
> > > > To me seems too many for the similar task. I understand that trace =
user is
> > > > special one, but does it use strstarts()/strends()?
> > >=20
> > > I didn't find any uses:
> > >=20
> > > 	$ git ls-files | grep kernel/trace/ | xargs grep strstarts
> > > 	$ git ls-files | grep kernel/trace/ | xargs grep strends
> > >=20
> > > > Despite on naming I think we just good to have only str_has*() and =
one of
> > > > strprefix()/strsuffix(), strstarts()/strends().
> > >=20
> > > In the long term, I agree.  But I think the transition should be
> > > careful.  What do you think?
> >=20
> > Yes, it should take a few phases, first one perhaps to align strstarts(=
) to not
> > rely on the returned value to be boolean.
>=20
> Ok.
>=20
> > In parallel with that, your current series can also be considered. Then
> > similar, if even required, to be done against strends().
>=20
> Agree.
>=20
> > And one more phase
> > is to replace strstarts()/strends() with strprefix()/strsuffix() all ov=
er
> > the kernel.
>=20
> Ok.
>=20
> Thanks!
>=20
>=20
> Have a lovely night!
> Alex
>=20
> >=20
> > --=20
> > With Best Regards,
> > Andy Shevchenko
> >=20
> >=20
> >=20
>=20
> --=20
> <https://www.alejandro-colomar.es>



--=20
<https://www.alejandro-colomar.es>

--7pxy7jt4w7gbfcvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr3fVcACgkQ64mZXMKQ
wqln4w//fpBJiQ4zkPG/2pLBvZbo+A4RioSCGAZpTt26UgZM9tPY0l8w7++PT3I1
LCdlucJFo4yqqYWh6vMA5mMAWDcbYoCWvNWGPWtx71KBkHp/0tVS7iPsl1/0bebl
XZ1Vv4QwOB3800/ViRQFdW8xsXDt/vyGpjxvi2bf/ht0CIjhCFtkGkZIaqHKFjOk
5DVbzDzQ1GpGnQAaQlv7lNOMLSxgI0eowhBn5im/YDSVa5zSMlUo1Qpuj1KazXay
xWIdjQQG7O/GdjJN2BgLmGFOIM6IqLs1dm9sqbaqlbs8+LCSEDZ6QP4jj64cojN0
JlglcPBSWo1QJK/mQKYzS+K91qi/0/ORXuAdMf9M12sOIyZ50Q0I8yCKQAhuIqNy
YTtj22sXslrTxa8MEgKcqYRzlHy/Fp9hXsR52ppPu1RW+eC5U1WqxKOyvde4qsBy
DDRBpZ1TsIovMw0iBbkzmebQYRGIugtGXgEuTj4fpteL/QfASFdZDU/yGFNCr3gQ
pV1NnPItO8X+AS+v/X5X7PygE9BIeCJrc+KiuMR8Q20njzWymrV+MOMmxsm/aqvi
DKhP62kPTfPbTgcaQ40uVVIjXmu28L7y/CV3+VQtXbm+B2Vn7BJ1qKJkKGdlA9Qu
bapvFOH/MvYD/H6CoDAXMNcFGth1ZPxGCQzTWOrQaetSJ/6wwfw=
=piCm
-----END PGP SIGNATURE-----

--7pxy7jt4w7gbfcvk--
