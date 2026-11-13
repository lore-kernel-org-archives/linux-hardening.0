Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604670;
	b=5eiMAZkvb8aiGImse8Afw69PR4my8lnZMUqOwWv9klMnc+f6rosODWvLfBPhPBxbU3YD
	 orqSFuOYg0+oZq6/jbdULNmQ/utK+mHd3Mshi5/dRS6l6CJ+F6vRSDKTb0TLtVFWhw6oM
	 FqIJRZ8JXC7Y3tUWk6WHVNuvpJlR9ev10ri3nlVqLNJSIh7Y6rIahyslBXiOuheKozm8x
	 CnjNIS8cU8QnVQGLmwpr86FBKk2lNsUPMuilQwvZOUIut+37eRRBM3hosqLaoy7zjfnRO
	 RdZbbJVd4r6HZRORfPl0E3riZ++zA1QJ+Z8ZJSBxC3YX1tPwNtoebuKzPko/WmxNN5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604670;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4N5xsxpwvne3KR3+TK/JJohtuEzflEYpCYDVnKbMZuk=;
	b=UpibAEkr0ih3Mvp+kQqTvmx31lKHBvL/NQs/8RdKqozlKL2aA8QrtJMDDls4MaLnTFKs
	 vEt32qvgO6aCTP7xN57G9NBrshdtr5szuKinjCd0aumKjEHW7zA/IGZbOu/0kFjJkLGIz
	 eqSWgfBV54jM9wo7stAsG+BqSnw9eHoYUp64yYPP4xKhPXB6n9jkt5QVKRThupWYxCnDH
	 kbNO5S+Ssi4MHF1uczL4pzkLu0AwIlFPWDSo1wenA8tYBtFrPTgmh2/tWpYWGohGuxbO8
	 SGe75u0+mmY/LdvfbRAVc+NoxkAg9RzHFR4CjLNgXPGrdEfa8glYDyEtyzdaI3Rx24A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j+Lz0hbS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10951606A32E;
	Fri, 13 Nov 2026 21:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j+Lz0hbS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0961F000C4;
	Fri, 13 Nov 2026 21:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794604669;
	bh=4N5xsxpwvne3KR3+TK/JJohtuEzflEYpCYDVnKbMZuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j+Lz0hbSxnd56ZRNKyl7Urmab+H4WQ+CoMnuGO6U2Gev+AckbdRCktnrbsLhp495Y
	 S/uURM1ghcjvFymLUF4KElyrKt1NeClmbXLxBZ72BcMtZXgIanKajS3zkwIIWTGvLD
	 S12pp7ITxBhHP37JE1g0bUkh8Y0Q4BqY085emGC0GtNdrmLPpgCvcPEhwBdexpAL8k
	 NC+ejg/XslO/1Uo9w83XtYhEg+kw7MNU6P5FrJkYB5fKIS1yP7J/ftEO3pUSxSRlp8
	 Q/WU4lZOLf4vOVrCq2yrtOUtookj7ZtASXE6IR0E20W4qG4LkBdIfS0Z8aqbmy47RW
	 TIe/LQswARl1A==
Date: Fri, 13 Nov 2026 22:17:41 +0100
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
Message-ID: <avd-M_qd0ONnwOZj@devuan>
References: <cover.1794574496.git.alx@kernel.org>
 <382a44f7c68672ecead2436d9f569ee23f383830.1794574496.git.alx@kernel.org>
 <avciONW-b_WXoetv@ashevche-desk.local>
 <avcj0YbmHRyhFW-Y@devuan>
 <avcntwOjI2i4seyB@ashevche-desk.local>
 <avcrlaWDlBVAHpnj@devuan>
 <avc1LK0_Deeh0zZo@ashevche-desk.local>
 <avd4XpBivw86pBYh@devuan>
 <avd794VWdjncD9YI@devuan>
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
	protocol="application/pgp-signature"; boundary="ypu55joap5pnvkpe"
Content-Disposition: inline
In-Reply-To: <avd794VWdjncD9YI@devuan>


--ypu55joap5pnvkpe
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
Message-ID: <avd-M_qd0ONnwOZj@devuan>
References: <cover.1794574496.git.alx@kernel.org>
 <382a44f7c68672ecead2436d9f569ee23f383830.1794574496.git.alx@kernel.org>
 <avciONW-b_WXoetv@ashevche-desk.local>
 <avcj0YbmHRyhFW-Y@devuan>
 <avcntwOjI2i4seyB@ashevche-desk.local>
 <avcrlaWDlBVAHpnj@devuan>
 <avc1LK0_Deeh0zZo@ashevche-desk.local>
 <avd4XpBivw86pBYh@devuan>
 <avd794VWdjncD9YI@devuan>
MIME-Version: 1.0
In-Reply-To: <avd794VWdjncD9YI@devuan>

> Date: 2026-11-13 22:13:10+0100
> From: Alejandro Colomar <alx+linux-hardening@kernel.org>
>
> > Date: 2026-11-13 21:57:24+0100
> > From: Alejandro Colomar <alx+linux-hardening@kernel.org>
> >
> [...]
> > > > -  strstarts():
> > > > 	It could be improved by returning a boolean-like pointer,
> > > > 	instead of a bool, but:
> > > >=20
> > > > 	-  We may need to fix some callers, since some of them might
> > > > 	   need an explicit conversion with !!.  It'd be risky to change
> > > > 	   the implementation without first verifying that.
> > >=20
> > > How many cases do we have that needs special attention? Can you run s=
patch to
> > > grep those?
> >=20
> > I *think* the only ones I expect this would be necessary are functions
> > that return a boolean-like int.
> >=20
> > 	// returns 1:true 0:false -1:error=3D
> > 	int
> > 	foo(...)
> > 	{
> > 		...
> > 		return !!strprefix(...);
> > 	}
>=20
> I've searched for cases of this, and also for cases of assignment to
> a variable that might be of type int (I expect this to be less
> frequent).  I haven't used spatch(1) so far, but just grep(1):
>=20
> 	$ grep -rn -e '=3D .*strstarts(' -e 'return .*strstarts('
> 	drivers/mtd/spi-nor/issi.c:141:	return name && strstarts(name, "pm25lv");
> 	drivers/platform/x86/dell/dell-lis3lv02d.c:109:	return strstarts(adap->n=
ame, "SMBus I801 adapter");
> 	arch/arm/kernel/module.c:25:	return strstarts(name, ".init") ||
> 	arch/arm/kernel/module.c:32:	return strstarts(name, ".exit") ||
> 	arch/powerpc/perf/imc-pmu.c:1026:	return strstarts(event->pmu->name, "th=
read_imc");
> 	tools/perf/util/map.c:21:	return strstarts(filename, "/data/app-lib/") ||
> 	tools/perf/util/annotate-arch/annotate-x86.c:144:	if (arch->family >=3D =
0x15 && (strstarts(ins1, "test") ||
> 	tools/perf/util/annotate-arch/annotate-x86.c:150:	if (arch->family >=3D =
0x19 && (strstarts(ins1, "add") ||
> 	tools/perf/util/annotate-arch/annotate-x86.c:200:		arch->ins_is_fused =
=3D strstarts(cpuid, "AuthenticAMD") ?
> 	tools/perf/util/symbol.c:854:	if (e_machine =3D=3D EM_S390 && strstarts(=
name, "psw_idle")) {
> 	tools/perf/util/env.c:733:		return strstarts(perf_arch, "ppc64") ? EM_PP=
C64 : EM_PPC;
> 	tools/perf/util/env.c:1049:		is_amd =3D env->cpuid && strstarts(env->cpu=
id, "AuthenticAMD") ? 1 : -1;
> 	tools/perf/util/env.c:1072:		is_intel =3D env->cpuid && strstarts(env->c=
puid, "GenuineIntel") ? 1 : -1;
> 	tools/perf/util/symbol.h:55:	return strstarts(str, KLP_SYM_PREFIX);
> 	tools/perf/builtin-trace.c:2272:			if (*after =3D=3D '=3D' && (strstarts=
(after + 1, "0x") ||
> 	tools/perf/perf.c:143:	return (strstarts(var, header) && !strcmp(var + s=
trlen(header), c->cmd));
> 	tools/perf/tests/symbols.c:155:	if (dso !=3D text_dso && strstarts(dso__=
short_name(dso), dso__short_name(text_dso)))
> 	tools/testing/selftests/bpf/prog_tests/sockmap_redir.c:321:	if (type =3D=
=3D SK_SKB_INGRESS && strstarts(out, "v_"))
> 	tools/objtool/klp-sympos.c:372:	return strstarts(sym->sec->name, ".init"=
);
> 	tools/objtool/klp-checksum.c:66:	return strstarts(sym->sec->name, ".roda=
ta.cst") &&
> 	tools/objtool/klp-diff.c:204:		export->mod_ns =3D strstarts(namespace, "=
module:");
> 	tools/objtool/klp-diff.c:339:	return strstarts(sym->name, ".L");
> 	tools/objtool/klp-diff.c:380:	return strstarts(sec->name, ".discard.");
> 	tools/objtool/klp-diff.c:422:	return strstarts(sym->name, "__initcall__"=
) ||
> 	kernel/module/main.c:1866:	return strstarts(name, ".init");
> 	kernel/module/main.c:1871:	return strstarts(name, ".exit");

With a multi-line search with pcre2grep(1) I've checked that I didn't
miss any more complex cases.  I'm quite confident that there's only one
case that needs to be improved (the one below).


Cheers,
Alex

>=20
> From all these, only one case was using int.  Here's a patch for making
> it more robust:
>=20
> 	diff --git i/tools/perf/util/map.c w/tools/perf/util/map.c
> 	index 41cdddc987ee..944f10d32796 100644
> 	--- i/tools/perf/util/map.c
> 	+++ w/tools/perf/util/map.c
> 	@@ -16,7 +16,7 @@
> 	 #include "thread.h"
> 	 #include "vdso.h"
> 	=20
> 	-static inline int is_android_lib(const char *filename)
> 	+static inline bool is_android_lib(const char *filename)
> 	 {
> 		return strstarts(filename, "/data/app-lib/") ||
> 		       strstarts(filename, "/system/lib/");
>=20
> It's technically not necessary, since the '||' operator converts to
> bool, but just in case someone removes one of those calls, using bool
> will prevent a bug.
>=20
> All the other cases were either using 'bool', or didn't need a change
> for other reasons.
>=20
> So, I can include this diff as a preparation patch in this set, and then
> make strstarts() be
> 	#define strstarts(s, prefix)  strprefix(s, prefix)
>=20
> And then have a global search-and-replace for it.
>=20
>=20
> Cheers,
> Alex
>=20
> >=20
> > >=20
> > > > 	   To avoid that risk, I prefer adding a new API, and
> > > > 	   deprecating strstarts() for new code.  Over time, I could
> > > > 	   slowly migrate users from strstarts() to strprefix().
> > >=20
> > > I believe this is unneeded step which may last for a few releases wit=
hout even
> > > guarantee that it will be finished. In such a case I would like to se=
e a branch
> > > with full conversion done before you start sending per-subsystem piec=
es out.
> >=20
> > Okay; I can do that.
> >=20
> > > > 	-  The name isn't ideal, since "starts" doesn't specify whether
> > > > 	   it looks for a string that starts with a given prefix, or if
> > > > 	   it looks for a string that starts with any of the given
> > > > 	   characters.
> > > >=20
> > > > 	   That is, by the name, I wouldn't be able to know whether
> > > > 	   strstarts implements
> > > >=20
> > > > 		bool strstarts(const char *s, const char *xxx)
> > > > 		{
> > > > 			return strspn(s, xxx);
> > > > 		}
> > > > 	   or
> > > > 		bool strstarts(const char *s, const char *xxx)
> > > > 		{
> > > > 			return strprefix(s, xxx);
> > > > 		}
> > >=20
> > > I didn't get this. We should not really need an implementation detail=
s of
> > > the API beneath. Documentation what should be read before use. Do we =
have
> > > documentation for strstarts()? Is it clear? Maybe that what should be=
 addressed
> > > first?
> > >=20
> > > > -  strends():
> > > > 	Same as with strstarts() but from the end.
> > > >=20
> > > > -  str_has_prefix():
> > > > 	It was an attempt at strprefix(), but with a problematic
> > > > 	approach.  It's frozen because of trace code.
> > > >=20
> > > > -  strprefix()/strsuffix():
> > > > 	I'd add them to slowly replace strstarts()/strends().
> > >=20
> > > See above about "slowly"...
> > >=20
> > > > > > I prefer replacing strstarts()/strends() with strprefix()/strsu=
ffix().
> > > > > >=20
> > > > > > But if you prefer changing strstarts() to return a pointer, I'm=
 also
> > > > > > okay-ish with it.  It's not a perfect name, but I can live with=
 it.
> > > > > >=20
> > > > > > > However, after looking at the uses in the kernel, I prefer
> > > > > > > to see the strprefix() be not implemented at all, just optimi=
zation against
> > > > > > > strstarts()/strends() if required can be performed.
> > > > > >=20
> > > > > > I don't understand this last sentence.
> > > > >=20
> > > > > It's basically repeats the idea of having only one pair out of tw=
o.
> > > >=20
> > > > Ok.
> > > >=20
> > > > > With this series will be
> > > > >=20
> > > > > str_has_previx()
> > > > > strstarts()
> > > > > strends()
> > > > > strprefix()
> > > > > // potentially strsuffix()
> > > >=20
> > > > Yes.  I'd like to replace strstarts()/strends() with
> > > > strprefix()/strsuffix(), but prefer to do that slowly, to avoid
> > > > introducing bugs due to missing explicit conversions to bool.
> > > >=20
> > > > Should I add notes that the strstarts()/strends() APIs are deprecat=
ed?
> > >=20
> > > Isn't Steven against that? I already forgot his points.
> >=20
> > As far as I understood, he was against deprecating str_has_prefix(), but
> > we didn't yet talk about strstarts().
> >=20
> > > Keeping them
> > > just as aliases to strprefix()/strsuffix() perhaps the good start
> > > (see below).
> >=20
> > Ok.
> >=20
> > > > > To me seems too many for the similar task. I understand that trac=
e user is
> > > > > special one, but does it use strstarts()/strends()?
> > > >=20
> > > > I didn't find any uses:
> > > >=20
> > > > 	$ git ls-files | grep kernel/trace/ | xargs grep strstarts
> > > > 	$ git ls-files | grep kernel/trace/ | xargs grep strends
> > > >=20
> > > > > Despite on naming I think we just good to have only str_has*() an=
d one of
> > > > > strprefix()/strsuffix(), strstarts()/strends().
> > > >=20
> > > > In the long term, I agree.  But I think the transition should be
> > > > careful.  What do you think?
> > >=20
> > > Yes, it should take a few phases, first one perhaps to align strstart=
s() to not
> > > rely on the returned value to be boolean.
> >=20
> > Ok.
> >=20
> > > In parallel with that, your current series can also be considered. Th=
en
> > > similar, if even required, to be done against strends().
> >=20
> > Agree.
> >=20
> > > And one more phase
> > > is to replace strstarts()/strends() with strprefix()/strsuffix() all =
over
> > > the kernel.
> >=20
> > Ok.
> >=20
> > Thanks!
> >=20
> >=20
> > Have a lovely night!
> > Alex
> >=20
> > >=20
> > > --=20
> > > With Best Regards,
> > > Andy Shevchenko
> > >=20
> > >=20
> > >=20
> >=20
> > --=20
> > <https://www.alejandro-colomar.es>
>=20
>=20
>=20
> --=20
> <https://www.alejandro-colomar.es>



--=20
<https://www.alejandro-colomar.es>

--ypu55joap5pnvkpe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr3fnUACgkQ64mZXMKQ
wqkl+Q/8CO+cAUI4pCDrJ90LWKACYUXpO0wHadFPlEiFX+woCbzxURgIiU0Q3jeR
gi6in6yqvt22NoMS7eHatJpskZyxWTnssCQsuRonJrMihhJ+urBU8bN3RrGTMu3U
YdsgpmQDnaBcKKhJE8yw5mZ3oFqr77yA3JGnnMm7lYhkILYyNjXkwAWhbUx+Y4Jl
T7Sm44AvbYysyjYRsVVYTFCZrYQyGDk3dBjLgcATgFQ+2rBq0ifO2OoG1VQYvsKl
VoWa3yWdch0Wq6Av+aRqmPh/g55NnRHwOmwgAhrAKh4V48vcyAeabLMxJ9q3J/3t
96LBtGAbloyRqacvvbvo+6b9uevNh0OmohUw0Ijcq2dqAk6ox1vfyjTFfUaG0W3R
uY5Fpgb+MV09aWhwmAQ/tbiST0hwcX3jo8rF9MyUdEgfs6DVagNQbPf2LekVaB/+
zZTwuBJ1bXQcyVlPhfRmL0QaHkOFjVhymvRMwWpQhSosj7OARboK6B0oFWrC8HqB
rAF8NyKN4bA8qQ5RNoWzBANyMz7xYkPYaJlhZ64/uoCKyqwzfmEHiZRFbSHYLX/d
Mv0KAQuynRVSetcN4KnIDYyX4Cmsp2lu0kHHnitlingOGs7PJ5++/HXc76QWccv1
KxkpvGbIopKrD/G8bsID7ou8nJ/HhZZhd8mqymPFP1fb+AzOi6s=
=F/xO
-----END PGP SIGNATURE-----

--ypu55joap5pnvkpe--
