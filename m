Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888214;
	b=SqNI0pL2NEej77ZOvXl+JxQowHJxVnXQ1RvvVggY5Bo84S/Qh7vmtd2s1FHyL1ZcvIkB
	 W87QXK4Zz/qwuhiJFyPR1KgBf6ksQHq1Mu6e7ip/jeRiI5N/mo4HYlfLCLkm11wiSR0hy
	 SdZLrpo0EfCFTOkjwqYyXGxwNYePkz8q95174qcXVbBo1S7KkqBN3L+xa7hrR5sYnTe5V
	 kCnujOND3QmLG8R7o0Dzk/F4oxAKfyJBCWw+tDqDKMb0dHh26YJTz+ziH27svnuYVYHOA
	 HEfUfBBA6Vbf/YIgEblqVY3627rRVkwMoaulddfXz/JkxW+dKBHARaUMuYp9dI3Vwfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888214;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Jo1r7Eqpd5Kwul0AOD+n/BJ1YPC7hEey4ChbCDP8t4Y=;
	b=YJLaJ4SEtzFiSaFJZtA0gggWsNcPXfKiKrNzDGCKpjzMHuoLus60mnhYdVRJJxO6LvsJ
	 vFo2Al4+naOTjyMqAORD6XWGTBitsObIBs4YjWAcx0jN3N943qEqesoJNgrNHyEzgUUAk
	 gDOCVeEeDqT9Puj2Rfd3ob9xDT9HvRbqVUVKeNe2+z2umpj6PGtm1zylPSHiO+ha4LQue
	 mZWcoNARFNJNyGuwsKZkAB22oMpzeYqyEV2boPnRw4Dxn5a6ea8V1ZcpGQSseJetUIGR+
	 VSdMnWKKD1AEJiTi8fv/VPQgQNQwUTUmPmtfZ4cQYUY90C/mKn3/O7omDLLR1JHk1Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZoKDw4ug;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA279606A329;
	Thu,  5 Nov 2026 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZoKDw4ug
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E371F000C1;
	Thu,  5 Nov 2026 14:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793888213;
	bh=Jo1r7Eqpd5Kwul0AOD+n/BJ1YPC7hEey4ChbCDP8t4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZoKDw4ugUs1vqT8KwUAFE22r38SFUo+5Kl1uRGyN1HnMz8m5Cx8cbaRxUBW9tukjf
	 pfRfbBQ7vIr/s526utqwnRQ6vk2y2lOMLblQ1212FvZpZ1BI2XoGocuLC9nbUSSe/a
	 2dXQf+lEKU3Oo91fIaA/QYKw+C30UBnr39JkfgTnNSIVKXxiw+fX1O2cB8ypomyVpk
	 aB/rmLvKtxIjYQxiJhoCfCxAT1pMUoX+WyBlN7Qy5nKzBPLHAIem4nMZa2mznOYdOu
	 E3V1FxDTksYsAIHY6DdxE1taJ5HY3zyRGUoOl2KnYFhCvgJMRI/ou3asr4DC8TXWzo
	 1fsCZ4HsI6iag==
Date: Thu, 5 Nov 2026 15:16:45 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
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
Message-ID: <auyOkL1Vb1iKicS9@devuan>
References: <cover.1793876837.git.alx@kernel.org>
 <cover.1793882260.git.alx@kernel.org>
 <qwpovcqznx6eltou4inmj3v62qhh6ouvihqnze7bobnd7lmcbw@rcri4e623icb>
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
	protocol="application/pgp-signature"; boundary="lbomulgyy7xwzfvd"
Content-Disposition: inline
In-Reply-To: <qwpovcqznx6eltou4inmj3v62qhh6ouvihqnze7bobnd7lmcbw@rcri4e623icb>


--lbomulgyy7xwzfvd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
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
Message-ID: <auyOkL1Vb1iKicS9@devuan>
References: <cover.1793876837.git.alx@kernel.org>
 <cover.1793882260.git.alx@kernel.org>
 <qwpovcqznx6eltou4inmj3v62qhh6ouvihqnze7bobnd7lmcbw@rcri4e623icb>
MIME-Version: 1.0
In-Reply-To: <qwpovcqznx6eltou4inmj3v62qhh6ouvihqnze7bobnd7lmcbw@rcri4e623icb>

Hi Bart,

> Date: 2026-11-05 15:01:22+0100
> From: Bartosz Golaszewski <brgl@kernel.org>
>
[...]
>=20
> I have no idea what causes it but I'm getting so many patches lately
> that are subsequent iterations of a series sent with In-Reply-To: header
> pointing to a previous thread.

I don't know what others do, but in my case it's a conscious manual
action.  I use --in-reply-to in git-format-patch(1) to make all
revisions of patch sets be descendants of the cover letter of v1.

We do this in the Linux man-pages, as it helps me keep track of all
revisions of a patch set easily in mutt(1), without having to follow
links or use more-complex tools like b4(1).

> Don't do this. Each new iteration must be a separate thread. Please use
> b4 to manage patch series.

I won't use b4(1); I like bare git-send-email(1) and git-format-patch(1).
But yeah, I can send them as separate threads, if that's the preference
here.

Out of curiosity, what's the benefit of having separate threads?
(Or the converse question: what's the main problem of using a single
 thread?)
They're morally a continuation of the previous threads, which is why it
makes sense to me to have them as subthreads.


Cheers,
Alex

>=20
> Bart

--=20
<https://www.alejandro-colomar.es>

--lbomulgyy7xwzfvd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrsj8gACgkQ64mZXMKQ
wqmoMQ//TtGWqCjfcnXsWY/oa7xvsHVefRAzug6vGgPHtltQxL2N+ABWVUEnj08P
DCpNPQ2e9Mv7M5ABKIaSYajzjRXovNQ0ooTFjhsYaIVXK7yTl2K8Faj8FDNpDLdO
hAg3B9y6uy7O2IK8Vl//8oDO+YfzPVH8vLp6QSvy5OvuXAcL/cHu5nUd12XewLVj
t6AHllKmnjmuc4HjpvyPX/73CW02iBj++erXy2SF8PBTDvZeeX00a3lVPKQnIq9O
VdNTfoWyqpmbaXB3y4hkltNXePY+BY/WFLVYf3zJQKsfoK5FRLs5Fr4lrwEmjcbG
4x5ZcNK/Tc/K8+mpt2Mq9tEU1ocQlpF6RJXIOOtJs0uaD4QowMTBtLL+daCCECgN
KVmOYGqoEEmxXcLMZKWf2Nza034nWPHQKONPUeM01gILFVJILBEfI36zI9W7bVlE
yyO5SF1Rx2KzBxnGZikRTrWQdM8fCWDn5aiFuTlOB24yvGFACZfKNd/tVfZQQ/BP
mHMZr1lZwJwveUzdn0qDWv3Bvw+Dp5sSbwYLCx/nwU+A3dqrCMa/wLJPdHrH4S6Y
uff3mbFO6kxGqCbv3Y89dEogwr3mqxgoYZaFsNlg5HSujG4/cV+0SWphRuhg9I4S
rREyduC6a5jqzyHPqzDCP1Q0/gMEtQgiJNdffQr1B3q/uiNVqPU=
=7MyL
-----END PGP SIGNATURE-----

--lbomulgyy7xwzfvd--
