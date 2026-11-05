Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891690;
	b=VgcEPmDThyq5qViW2qA1NUCefXBKb7KFfpp6YRVh+fBaeKvdQctLAH8OxCObb7KxxhM7
	 CC5pYvEFqB2Sqfl3lY2rLbaqV/YhkHr3jndRACIP4PTSz4xR9tA9gARx0G+hsbAvJ4waK
	 bcc9u15+lwM8TRw+oPbxZvA4NZLC5uL4+N7bsZxhUxHTiePRLLHdLB8GwZMxyds4jKHew
	 6EHDH4CAtd6Ga7gcgFSvLiWFbS1UOugpdKmA6DJnwAz9TLeU80R9Ytiba0ml3vffrvehj
	 rxqfIKGuCuwqS1gRVXtrvm6dAML26W6kQwkNGV2wMxLD+3+ISZTDfbEo8PruaxQqoUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891690;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=yOzy2PAIq62MC1WpjHdTy2YV85p8V8fhM653keuOdKs=;
	b=xKydwl4WhlfQvz50xcB6aVtTsGDwAzSYlXKgRxSNOGGrOs+XzeONms99gh68SuOztoOB
	 VFlCyqUYFFr7VYXBnl/iOF/YpLAGzem/z9nb9inpXQyEKTnqp0wquilVyVGjqOdCOpp8c
	 0pZQDmonlWZUbKhiQw7e2We673fPP+5xfkB2QpNv/f4jBSsHNCa8101EbntLh9wU3mjh2
	 uAQeuxUsBLgLliHqHVQyCfqGCbe80goYsvePYWrNs3/fRxjh0GMDpQ2Cx0fsyostvtcHq
	 pRRtvNfsijiRFC35u0gy+w9cEM+kIMBRGiYDB9XKKzs1jeHDE9kVc8iLI6ahHZ9TLlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ePPkSbC7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D0F606A328;
	Thu,  5 Nov 2026 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ePPkSbC7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3EF1F00919;
	Thu,  5 Nov 2026 15:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793891689;
	bh=yOzy2PAIq62MC1WpjHdTy2YV85p8V8fhM653keuOdKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ePPkSbC7tJbK6ObzWMO3sw3edej37cbZKBQR/4pSWeo4Q0+4qm7XW2OxAEx7wlc6o
	 eV2YqkF823NQgaf+R3xImy6QsO0eozb5tCF4pdfaIhCPVnnEVcDyvBHue3E4XrFXSL
	 ClTaAQiVVIZYg/YBzJwpabzmusrqP/o2IghZg2s9C4KcKBJxedVqsGU+oEzFJ2geLj
	 rT/9N8MEbaiZ4XJa2w25V61vrgJOYYszCKu0JN38YqMxDDabHiWTq/5smKKVk9LsJc
	 BNINk2VIf4La4WSRDWkCserYPhESkFhFkFFRhb4yc2EDA8PdUZIoNs2FKMOjzmIaup
	 NWvDCFrHfbNlw==
Date: Thu, 5 Nov 2026 16:14:42 +0100
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
Message-ID: <auycXnj5KXMyxhc4@devuan>
References: <cover.1793876837.git.alx@kernel.org>
 <cover.1793882260.git.alx@kernel.org>
 <qwpovcqznx6eltou4inmj3v62qhh6ouvihqnze7bobnd7lmcbw@rcri4e623icb>
 <auyOkL1Vb1iKicS9@devuan>
 <3lj2ivlwz6wpf66u3ifg5lxlmqbe5gulcr56rd7zxcgrhx2pj6@dxdqaxsp5hvu>
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
	protocol="application/pgp-signature"; boundary="pevfwlbhslllt3ga"
Content-Disposition: inline
In-Reply-To: <3lj2ivlwz6wpf66u3ifg5lxlmqbe5gulcr56rd7zxcgrhx2pj6@dxdqaxsp5hvu>


--pevfwlbhslllt3ga
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
Message-ID: <auycXnj5KXMyxhc4@devuan>
References: <cover.1793876837.git.alx@kernel.org>
 <cover.1793882260.git.alx@kernel.org>
 <qwpovcqznx6eltou4inmj3v62qhh6ouvihqnze7bobnd7lmcbw@rcri4e623icb>
 <auyOkL1Vb1iKicS9@devuan>
 <3lj2ivlwz6wpf66u3ifg5lxlmqbe5gulcr56rd7zxcgrhx2pj6@dxdqaxsp5hvu>
MIME-Version: 1.0
In-Reply-To: <3lj2ivlwz6wpf66u3ifg5lxlmqbe5gulcr56rd7zxcgrhx2pj6@dxdqaxsp5hvu>

Hi Bartosz,

> Date: 2026-11-05 16:00:59+0100
> From: Bartosz Golaszewski <brgl@kernel.org>
>
[...]
> >=20
> > I won't use b4(1); I like bare git-send-email(1) and git-format-patch(1=
).
> > But yeah, I can send them as separate threads, if that's the preference
> > here.
> >=20
>=20
> Yes. It's also the preference mentioned in the kernel documentation for
> multi-patch series.

Ok.

> > Out of curiosity, what's the benefit of having separate threads?
> > (Or the converse question: what's the main problem of using a single
> >  thread?)
>=20
> I may mark a thread in mutt as "done" for whatever reason and then all I
> see is a reply under something I've already processed so I may as well
> skip it. On the other hand: a new thread gets my full attention.
>=20
> Such sub-threads also can confuse tools like b4 that maintainer use to
> queue patches.

Thanks!

> > They're morally a continuation of the previous threads, which is why it
> > makes sense to me to have them as subthreads.
> >=20
>=20
> That's what change-id is for in b4 tracking. That's also what the
> changelog should contain: links to previous versions.

This always felt to me a bad workaround for not using proper threads,
but I'll accomodate my patch sets, anyway.  Thanks!


Cheers,
Alex

[...]

>=20
> Thanks,
> Bartosz

--=20
<https://www.alejandro-colomar.es>

--pevfwlbhslllt3ga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrsnWEACgkQ64mZXMKQ
wqnH+g/7BVp/kFhabayTy/pyEVUqpL4R0y0LOKFvvMn+dbfAK9GCB2S62fi2Hwn/
S8jeu03LHEmccA+6yp39/A2yhPAd3jPtyK9UcLNgfPhCTMGj9MjIUpvNkl89PlYV
C9HHZK2uw3IEfNiWBVlD0JjadKepmkbLJeJkCoNpoGWx0qz7t+Ki0XyhJqJcLH4b
DJcGLp/o4ytvbxXKnn8GPZMach+YSe97ArvWW1kOFto01I8J+EW9cdTgpN1jyXl2
ypmmU27/qgJ9ggVxRt0Ssx9EPCZscGUP/03T04Hht8nZFYxerOwTwUrbsagwRQsg
RV+QK8GSNdtWTpSNzFBEfDtZX5oiShR8ViMKSgQsjoJcEJFrRrgcxP7k/T8u3wfk
qDQirp66w5TxPCAuojq6FGob5EUqBiL1TmO1PBkG0txlc0chAztA5VpgnlTItPM/
6LPt+dw1dcRAojOP1MrPGXSYTU0pOH6KiPjbacS4GbturWhoqS3WwWNQh9cIKFTk
4Dx5pBqzIAm8M4oM8GNJvVJBW4cq6Jjm+mrrcaSNAsudbtqA5ohQOQpzSowMNMAi
HvKXR9/PVi1AAkTxzRJvYPJ2sFHiCoD4EqiV6BII+daDEDxJM0JJpbUv5nm6Wvpi
D/l1WrH3iKFs6M3Bm9HoQep0LPhQvl9EYQGJcxyrKSfCzEe03C8=
=qTaI
-----END PGP SIGNATURE-----

--pevfwlbhslllt3ga--
