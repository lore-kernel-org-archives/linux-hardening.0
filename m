Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896947;
	b=eA0PoIKfvo7GffTwtqpO6HtKludauEA58xWrKJ5YjEBQNHQOuOpKciFdGST3DNz8sG34
	 NHoDHpOohOS9G4KqFrA+XtoVRRAMvmKmJhSGEnfR/6mtZ+iXDGirXLP8B+Bmho1dNqYaH
	 VnxL1znvG6zDdvPgziucZAxQoWjBgxM/Fgq0lUSeTv79EY6n9N/YezD7SO2PP3WLe8TM1
	 C/hoZZ8Q39M3+JR1PGFBhlb0OjDQ0+RS+HO9M+kgfjW5Qr7ppD2y5PzrUSdgCGxwK5csz
	 km172rJ1kjJK/KncNugpNrqQwrm8LNaHVd55Yl2qn9JyhANb2SK+UfZm/BNf8pLtcbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896947;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=A5z68CFRM/6YCihr3HEdTyBTNSmIyzUL+fF+d7hT5KY=;
	b=TDnBRcbEEUtvmU+87BqsDVRE36nWTuWIg5nkQ327DWPhApxWOY0l/6Fk2+s1QOSlI7u2
	 JhevIiIbAScuTcIhjDBiQgjqIvB9SF3CUYh4u/4w+g+Ge9B12H+eT95bp2kpwK6KKiU8v
	 dgpPTR2BzMU01gMG8lpTUVA8mzcI9kfLS6uPzCKNzva6etF/vinwBUQ5DYtVMGMYtX30v
	 NLkFMXTFgp0i3ntOadWtitiiF9W/yl1Lk+y97J5josDvcfShqyuKw+9bwI96NyEkaCuSP
	 iNWgpgfC48oWscsQonm8jgp640dPYBvGU0fYkn0y/qMfDNCx9P3cILEnJN1ZCkAPDtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ax/AGobN";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6139D606A923;
	Thu,  5 Nov 2026 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ax/AGobN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966AE1F00919;
	Thu,  5 Nov 2026 16:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896947;
	bh=A5z68CFRM/6YCihr3HEdTyBTNSmIyzUL+fF+d7hT5KY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ax/AGobN5b82qMX62m3W82zGu/OT0yEV/E7Op9g68v/AxXp7EXBExDomChH9EdDcm
	 iciRleEpYLtviUrkYP2xvkNxfsmGysdGixHNwhODxWCUxYiiCQSR48a7OwHpaBQp4Z
	 K2wuxlhnZC1w0GH9JDYmYHGjCmTkxQz/Fr5fVPJJTJvi+G2GBSsRpPBFKBDBbOSh3C
	 TNHRRVSGT9yF/cQ7WrK9fUTg5p65glSuwonMI4AHYNWax6QuBZxjeY9TtDmmT1Bs7Y
	 tWwOrBGSFiBKVlR4peN4/1XHIh1Z+3oxM4gHM/JF7CSzH75ZrltQ0XZaZakEOTqCcg
	 ZkvaGRm9UcHYA==
Date: Thu, 5 Nov 2026 17:42:19 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
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
Subject: Re: [PATCH v2 0/2] Add strprefix() and fix a bug with it
Message-ID: <auyv5LCuyqH4KL8B@devuan>
References: <cover.1793876837.git.alx@kernel.org>
 <cover.1793882260.git.alx@kernel.org>
 <qwpovcqznx6eltou4inmj3v62qhh6ouvihqnze7bobnd7lmcbw@rcri4e623icb>
 <auyOkL1Vb1iKicS9@devuan>
 <5001d8c2-2334-48bd-bc95-6b33e3922a46@kernel.org>
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
	protocol="application/pgp-signature"; boundary="omrct4i5bg4dodwb"
Content-Disposition: inline
In-Reply-To: <5001d8c2-2334-48bd-bc95-6b33e3922a46@kernel.org>


--omrct4i5bg4dodwb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
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
Subject: Re: [PATCH v2 0/2] Add strprefix() and fix a bug with it
Message-ID: <auyv5LCuyqH4KL8B@devuan>
References: <cover.1793876837.git.alx@kernel.org>
 <cover.1793882260.git.alx@kernel.org>
 <qwpovcqznx6eltou4inmj3v62qhh6ouvihqnze7bobnd7lmcbw@rcri4e623icb>
 <auyOkL1Vb1iKicS9@devuan>
 <5001d8c2-2334-48bd-bc95-6b33e3922a46@kernel.org>
MIME-Version: 1.0
In-Reply-To: <5001d8c2-2334-48bd-bc95-6b33e3922a46@kernel.org>

Hi Krzysztof,

> Date: 2026-11-05 16:21:02+0100
> From: Krzysztof Kozlowski <krzk@kernel.org>
>
[...]
>=20
> My mailbox gets 200-300 patches per day (not counting replies), so I
> have no idea how that could be manageable if all versions of some series
> were threaded to itself. Some old thread popping up to the top,
> half-read, deeply nested like 20-deep indentation?
>=20
> But even in second workflow, reviewing individual patches via b4 or mutt
> after shazaming (my main workflow of DT) not via inbox, would get huge
> irrelevant thread of past discussions requiring me to look for stuff
> actually for the review. How to find actual patch to review in this huge
> thread? I tried many times, takes much more time than reviewing simply
> current version.

I send patch set revisions in reply to the cover letter of v1, not in
reply to the last revision.  This means that revised patches will be
indented 2 levels deep, not 20+.

That is, this is how they'd look:

		[PATCH v1 00] ...
		=E2=94=9C=E2=94=80> [PATCH v1 01] ...
		=E2=94=9C=E2=94=80> [PATCH v1 02] ...
		=E2=94=9C=E2=94=80> [PATCH v1 03] ...
		=E2=94=9C=E2=94=80> [PATCH v2 00] ...
		=E2=94=82 =E2=94=9C=E2=94=80> [PATCH v2 01] ...
		=E2=94=82 =E2=94=9C=E2=94=80> [PATCH v2 02] ...
		=E2=94=82 =E2=94=94=E2=94=80> [PATCH v2 03] ...
		=E2=94=9C=E2=94=80> [PATCH v3 00] ...
		=E2=94=82 =E2=94=9C=E2=94=80> [PATCH v3 01] ...
		=E2=94=82 =E2=94=9C=E2=94=80> [PATCH v3 02] ...
		=E2=94=82 =E2=94=94=E2=94=80> [PATCH v3 03] ...
		=E2=94=94=E2=94=80> [PATCH v4 00] ...
		  =E2=94=9C=E2=94=80> [PATCH v4 01] ...
		  =E2=94=9C=E2=94=80> [PATCH v4 02] ...
		  =E2=94=94=E2=94=80> [PATCH v4 03] ...

I jump to new mails with <tab>, and the patches have low indentation.
I have never felt it hard to navigate within mutt(1), FWIW, but YMMV.

Anyway, I can do it just for me, by editing the local mail after
sending, and adding an In-Reply-To header just for me.

> b4 is not so more complex, honestly it's just new interface and after
> learning a few new commands is straightforward and easy. And solves
> successfully, without creating noise or problems to others, all problems
> which you might be trying to solve:

> referencing earlier versions,

Solved with threads.

> easy
> comparing between any version,

Solved with the --range-diff in the cover letter.

> collecting trailers, sending nice
> thank-you letters with commit and tree references etc.

I do these manually, but they're much less work than the two above.

> I believe there should be no excuse for modern maintainer to not use b4
> in the workflow. The same BTW for submitters of anything bigger than
> 3-patch series.

It feels more comfortable to me to use git(1) and mutt(1); YMMV.  :)


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>

--omrct4i5bg4dodwb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrssesACgkQ64mZXMKQ
wqlpHw//RjSIF6gNAbgOqdFPgLJvqudRprJPRKJmM9FdTdtxPda3nDoRXI7kuAde
IqlKhuSOIgoec1ipKnn2G3e/yXzxAWYHdodkPHo3FmbK8mcxMS+9ruX+UA/xx19B
VmcsS5mpCa1A0ryYsKq7jvvfvr2WlgrDY6kbF2Us0vMXDY8pjKWMo5lpZBx7dOG4
ObYERV39/2zwztawHLbIcQfD/sm+dUbEQ/GRylu/N5qwjYVwFEJGgVDOysTZllsP
kYFVCh8bL6Sl/QxuHOeb10/Jn7L8BwiteNEUUlGYybSsrGE2eaWPM07qFGOjtgtZ
rP/Ye2dxKMzYuXmzSaRiaRtbPb4a3fLvYPjbGYVq5C064qxBm6uEGwZH5keLzh1P
c5PGyNpVimKB9c3ZGzRtCUsj7590gZzPK3v3yLYT5rWp6iJH4cXp6AFYlB3RmlZl
A77JZrTJ77pMTX1zpMq0wxmboYrPZvjwSSsHOMaI8inNX+mfa5kpdDzjDCN8JaBy
nP3n4XkIqGEjG9S2Rwy7EkAq2RYdoyDnCqty6eAZQtUgUy6RgXTObu3AHB2w2aqs
8+re7oMPjZUJ+V6luuXA3iCT3KhmmnnGKNwI436A5TRysMfu6pU70wAzNA3pwvgA
uY9tmYvBrRzUndraWhZ18WJKIONCEXEQQbIeEjZijmoAcNjmL54=
=Oe7n
-----END PGP SIGNATURE-----

--omrct4i5bg4dodwb--
