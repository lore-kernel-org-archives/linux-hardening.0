Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917523;
	b=KdkDx6aWDLhEzi00iyMxk/NKdeakuRjyg7x05TIE7pTjX28EMv/wBl+iOB22YcVrBEbN
	 E33zWkb5llVVUBi0w3mSzAGK//NmmMrbVXdX5hMnsyKe5X/tJegvD1GK/rk0L9L5lZXbb
	 GQuYz3p0dSXY/IZFARRbYZ2SsYs8zqJw7cUbb4eg3MAONx2AKE3Xuz9QIv6eBj5/NFABU
	 EJIkTf5jIb/zRFZ3sPneHddeXyXtx/ZV4mn5wArVX0HKTCeUZC4pYJ4tJZ2nQ+wzp3qGs
	 75JRoBwhqqcD14mYKIdN2ikC6Ylju/othmE4j1MhGdbKMrMgYGtm7bCJbFMOrs8t5Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917523;
	h=Received:DKIM-Signature:Date:From:To:List-Id:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6Np0cUB79EyEFeICv6zfCgUE71AE9FMZbFEnxyzvjSQ=;
	b=gvojtOK+g6Kqb9mSnDjd2zArNJ4klp4i38B2HlDpqRpuHtglxf1U8pMe4fDJ8B7QKqqL
	 KOLtTpewCI1FfvXpUUwx3hU+VfA5JW79kDQM2oZlQ5ZimP6RjnSmXTicHzbNTbTu2zaAR
	 EC9B/mIBpmoqVS++qh0eYsvuenBh4sEvlMIb0Z0Oj5qFdr5GfjXyZ3A/8pWCJenvs0CJp
	 5AgFbPQYoLW77zbMok+lF2jntxcGWjoqIh/mfYVY90aHjUoy8DOHZN4bhGOdKYqYDbFnH
	 DPki5HoakT0FZKWhrE4TF5Tj7DFrsry2JYRxm+vos5gbHYbU7KPl3RFtEsOsnn4o+Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KPRDKmOF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0620E606A326;
	Thu,  5 Nov 2026 22:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KPRDKmOF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228ED1F008A1;
	Thu,  5 Nov 2026 22:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793917522;
	bh=6Np0cUB79EyEFeICv6zfCgUE71AE9FMZbFEnxyzvjSQ=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To;
	b=KPRDKmOFG7dUNVBgmlAgES1Y92EiIHJY6uDZfPMhaaQq6n4GEg+QZl3FL0vI55qBD
	 rDm4w6R6IJsC31Tizj35YmllUeBh6++/rvUajEjIKN0n1MllBslu5HAA9L025rI4gB
	 iIrhdmPDKxH0kSWvnI9U7gVDdJUSgXwdukEwPU47aBkIONt2XOKLKJFBrD17iwm+tw
	 OkjTgWoB5WN8IQdF7UBBjpPb0XxZ4Cb+t3Z/7DOdmBaiVe8/0BeMpfsmGRIL7lgqny
	 O89zX/V5mVXrE572LdWo4oVKNDCYj7r8zST5/8FV48FxooexiNRS3XmZdAymIes3pY
	 NTPUn5X6T43/Q==
Date: Thu, 5 Nov 2026 23:25:15 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alejandro Colomar <alx+linux-hardening@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-hardening@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1 1/2] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <auz79Izf6Q5qOQPi@devuan>
References: <cover.1793876837.git.alx@kernel.org>
 <9c81f6f62fd0e908e683c4c08b09a1f95bc2ec9c.1793876837.git.alx@kernel.org>
 <20261105111423.360f4ba8@gandalf.local.home>
 <auyuINXEJKc1KoG7@devuan>
 <20261105115019.2fe7c91b@gandalf.local.home>
 <auy0O467UqOzqYub@devuan>
 <auzGMV1YbO9DodBq@ashevche-desk.local>
 <auzHFRzd86iV4-RA@ashevche-desk.local>
 <auzxXyAU6zyHtMtn@devuan>
 <CAHk-=wjD-fQvBvozu7+TjXa4=arAFgVzyixw4W_A=14Y8rhSLA@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="lqrtrf3hhpuzbu5e"
Content-Disposition: inline
In-Reply-To: <CAHk-=wjD-fQvBvozu7+TjXa4=arAFgVzyixw4W_A=14Y8rhSLA@mail.gmail.com>


--lqrtrf3hhpuzbu5e
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
List-Id: <linux-hardening.lore.kernel.org>
Cc: Alejandro Colomar <alx+linux-hardening@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-hardening@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1 1/2] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <auz79Izf6Q5qOQPi@devuan>
References: <cover.1793876837.git.alx@kernel.org>
 <9c81f6f62fd0e908e683c4c08b09a1f95bc2ec9c.1793876837.git.alx@kernel.org>
 <20261105111423.360f4ba8@gandalf.local.home>
 <auyuINXEJKc1KoG7@devuan>
 <20261105115019.2fe7c91b@gandalf.local.home>
 <auy0O467UqOzqYub@devuan>
 <auzGMV1YbO9DodBq@ashevche-desk.local>
 <auzHFRzd86iV4-RA@ashevche-desk.local>
 <auzxXyAU6zyHtMtn@devuan>
 <CAHk-=wjD-fQvBvozu7+TjXa4=arAFgVzyixw4W_A=14Y8rhSLA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjD-fQvBvozu7+TjXa4=arAFgVzyixw4W_A=14Y8rhSLA@mail.gmail.com>

Hi Linus,

> Date: 2026-11-05 13:48:18-0800
> From: Linus Torvalds <torvalds@linux-foundation.org>
>
> On Thu, 5 Nov 2026 at 13:24, Alejandro Colomar
> <alx+linux-hardening@kernel.org> wrote:
> >
> > I think it might indeed be that find(1) is slow at filtering, because
> > using git-ls-files(1) is faster without piping to grep(1):
>=20
> No. Your find | grep" speedup is because you use two cores for this.
> So it's slower, but does it in parallel, which is faster on a machine
> with idle cores.
>=20
> The reason git ls-files is faster is different: it's because git
> ls-files is just that fast.
>=20
> And it's so fast that now the pipe overhead is much much more
> expensive than git itself, and so doing "git ls-files | grep" is
> slower and only adds overhead even if you have idle cores.
>=20
> And the reason git ls-files is so fast is because it doesn't do any
> directory searches. It just looks at the git index file.
>=20
> So git ls-files really does something very different from 'find'. It
> just looks at the files that git already knows about, and it basically
> only opens '.git/index' and parses it.

Oh, thanks!  That makes sense.

[...]
>=20
> Anyway, if you search sources and don't want to care about object
> files or other generated files etc, I'd heavily suggest using "git
> ls-files" and "git grep" exactly because it's much faster.

Indeed, git-ls-files(1) seems more appropriate than find(1), especially
after having built a kernel, which makes find(1) go turtle-slow and list
the built stuff.

> (Ok, "git grep" isn't always faster, the whole regex algorithm issue
> can go both ways, but 'git grep' does do the same "just look at files
> that are actually known to git" thing, and obviously it can look at
> different revisions etc too, so it's really *good* at greapping the
> actual committed history, although if you go back in history you'll
> obviously be paying a much higher price because now the cost is often
> not the regex, but the unpacking of the objects etc)

I'm not a fan of git-grep(1), because it's easier to remember grep(1),
as I already need to remember it for other stuff.

But yeah, a pipe `git ls-files | xargs grep ...` seems what I'd be
using.  After all, the slow thing is find(1), not grep(1).  And I like
the separation of concerns, so that one program is listing files, and
another one is searching their contents.

I'm finding some issues with git-ls-files(1), though: it's listing
symlinks, which grep(1) complains about.  I wish I could discard those
with something like '-type f'.

	$ time git ls-files | xargs grep ARRAY_SIZE | wc -l
	grep: scripts/dtc/include-prefixes/arc: Is a directory
	grep: scripts/dtc/include-prefixes/arm: Is a directory
	grep: scripts/dtc/include-prefixes/arm64: Is a directory
	grep: scripts/dtc/include-prefixes/dt-bindings: Is a directory
	grep: scripts/dtc/include-prefixes/microblaze: Is a directory
	grep: scripts/dtc/include-prefixes/mips: Is a directory
	grep: scripts/dtc/include-prefixes/nios2: Is a directory
	grep: scripts/dtc/include-prefixes/openrisc: Is a directory
	grep: scripts/dtc/include-prefixes/powerpc: Is a directory
	grep: scripts/dtc/include-prefixes/riscv: Is a directory
	grep: scripts/dtc/include-prefixes/sh: Is a directory
	grep: scripts/dtc/include-prefixes/xtensa: Is a directory
	grep: tools/testing/selftests/devices/probe/boards/Dell: No such file or d=
irectory
	grep: Inc.,XPS: No such file or directory
	grep: 13: No such file or directory
	grep: 9300.yaml: No such file or directory
	60570

	real	0m0.819s
	user	0m0.439s
	sys	0m0.430s
	$ time git grep ARRAY_SIZE | wc -l
	60568

	real	0m0.308s
	user	0m0.443s
	sys	0m1.172s

When searching in old versions, I usually am git-blame(1)ing stuff, so
I already know which file to list.  In that case, I tend to do
`git show v6.0:some/file.c | grep something`.


Have a lovely night!
Alex

>=20
>             Linus

--=20
<https://www.alejandro-colomar.es>

--lqrtrf3hhpuzbu5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrtAkAACgkQ64mZXMKQ
wqlnwA//U2IIiZPQ4PdneZ0WRKyzeGHalEIn6Ix83qdUJCof9JoDaxARs/IF9afY
84HhMxdmBNcMTP7POW+vCiW2cAOyDc7eXcZzKW/ourFbhhWDm07x+stN+piH0qG+
ulQcoCcq7paBJabwJFO0CN6Ve0MpPR3/07uJizXhe/UL+zjcVKRaJv7l1xD3bRRk
FvKbLNta+OcLw1NPJyHFuvXzSpQpurge2LRPBJrs3UbjRQOsqYAjs+t9IhtFTsPn
2RvICzKDS22YARS+ILoZNvIZG0/rrERWuuZX7mrMaihSC/sq41iAwEl7rHYQ5xj+
J9JQw4QA9iw3OPJ5y4HOENsvvkbzkEemwxmatilgSSr4qdmFujxbgUr1sHM9MZfY
wiyHXsHL0aHTBigniHng+Gz9F0GEd20Z7HxnLri13JlrqBLZjvSf5QdXWGjlW5SG
5qasMIn3DKcXjjZVdk+0cq1MnimrMzv5+CexDrwNjzOl1aVW3/iARgPhyvDrDzG2
SQWwyG8k0rYaKPd7gSTXx9oCsM9nUlhZ95L6nXl7jjY2XsC0LobmtGk9xP7pmQtv
NNTUSc0CerNaM4+MX87B/cTv70P0PwDgIQ+gFnMTcYN2mF3bsV0KSoszOzw4Pgsv
ElIIrJTFEY5AOjPehpjau2GDLUF7q291TKbpzEecgPBA40j/vxw=
=YfjE
-----END PGP SIGNATURE-----

--lqrtrf3hhpuzbu5e--
