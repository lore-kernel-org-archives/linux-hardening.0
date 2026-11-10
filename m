Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353629;
	b=ITaZ4dppzhTgk5dPvJ2btKnmLOj5btWqttQUBNNlwsP2ezPTQP+BelbQM9410VZvbrhO
	 FOcyfo3jOiBHQu27UMEttotF0uYsAAgwPOlS9vwLJmAnnBfgprfgzU7Mwmunp6jDD0XFm
	 z0h74r4GZQmGOwto5axW7foD6M3cbHlnLAxJaB65tffEAoe3U3igZnV0M+1jm5ZzqZ7O/
	 sC5IMVK3e2FWtmuHBEogA9ku1TI1RTNH/BjLBocJxz5aYWOZ1xEmxE65u0KOYs3Ez5Syr
	 iID5cW+u26znNyQY3ZpkozdFleOVS17jNxUh11GQb7p9MijsIXMkXM77xCa41kWKwdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353629;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=16O4fMiI2fl7wUGY/maE6Aam1B9zKeQnyFQjkcZdqbI=;
	b=iXU7GYpDp+saOkcCcFIsoiXTYiX2H8CZToLQ1AQ83Ffjz7atrfrPb8Kn5Aq1HCZUzIad
	 0IXVtEwxurWNqG180qrZr+sxE1LCkvFbKQ8aakvCdnxcXJJgj2cxQYJbOWI4jayYPDolU
	 kYPrrMkY/0VPM4kuSVKyIip/kJDs1naGPKfYxazUKcCas9Ww+WLdvoKvZ9f2frkPcI8n+
	 0aYYdxbEquwbjeRJqCbT8RMu4zGPbsPL/KTL6cxfbW6AN65TkZprBrHUuispKFfko8Lmr
	 0ckaCC9+1rVSYYcPa5NyzXTMJ/mptYmCQ9h63iTfsOIKuYtSLUBLzwQb6u9Q+Mdp7IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mw+CAmRm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80FD606A320;
	Tue, 10 Nov 2026 23:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mw+CAmRm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6587E1F0093C;
	Tue, 10 Nov 2026 23:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794353629;
	bh=16O4fMiI2fl7wUGY/maE6Aam1B9zKeQnyFQjkcZdqbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mw+CAmRmiISb/eKKgFF6nzJENo5LfWq55rIT+U4iDpKVZix/ugOPfGTsXP4fIQxFE
	 Jf4QJCfMJNibFdgHy73/u+n0qJx63ftSjvxWjBQOpVjEYT5+Ro5I0xPLeAb5+CuM4C
	 FV3MVnUPbj+ne0VOcRvOxulbWfR35rOwhMIpBy8oMhzxnYRi5e24elg22FmwJLBs8h
	 PIZzEs2ZVOgKoQJdcXB6mkIy0JHaNT/axYyyOF1CJYc/btIuervE7zi3rUcOcx37PM
	 D8op1h/uMlsLDLuPwnPqfMXwfEXGgSFJ+StGsOSq7elnJHAa+9b55ZcIBg6Rmr/Whj
	 So7AQSEuV0fwg==
Date: Wed, 11 Nov 2026 00:33:45 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Alejandro Colomar <alx@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bill Wendling <morbo@google.com>, Petr Mladek <pmladek@suse.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Shuvam Pandey <shuvampandey1@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] seq_buf: Mark a seq_buf overflowed when terminating
 it loses a byte
Message-ID: <avOpWXrMYrJz8ETU@devuan>
References: <20261104033110.out.418-kees@kernel.org>
 <ausTcdh966BNVA-_@devuan>
 <20261110220602.272c5b-kees@kernel.org>
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
	protocol="application/pgp-signature"; boundary="zzbkid7pe7r2xd4x"
Content-Disposition: inline
In-Reply-To: <20261110220602.272c5b-kees@kernel.org>


--zzbkid7pe7r2xd4x
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Alejandro Colomar <alx@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bill Wendling <morbo@google.com>, Petr Mladek <pmladek@suse.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Shuvam Pandey <shuvampandey1@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] seq_buf: Mark a seq_buf overflowed when terminating
 it loses a byte
Message-ID: <avOpWXrMYrJz8ETU@devuan>
References: <20261104033110.out.418-kees@kernel.org>
 <ausTcdh966BNVA-_@devuan>
 <20261110220602.272c5b-kees@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261110220602.272c5b-kees@kernel.org>

Hi Kees,

> Date: 2026-11-10 14:06:07-0800
> From: Kees Cook <kees@kernel.org>
>
> On Wed, Nov 04, 2026 at 12:17:00PM +0100, Alejandro Colomar wrote:
> > > No current caller checks for overflow after terminating a seq_buf that
> > > can be left exactly full, so none of them behaves differently.
> >
> > Okay for this patch, but still some question:
> >
> > Since data truncation is almost always wrong, is it a bug that those
> > users are not verifying that no overflow happened?  Or do they have a
> > good reason to not verify?
>=20
> Right, this would need a case-by-case analysis. Some expect it and some
> don't. This change to the API is to make it defensive in the general
> case without making existing truncation worse.

Agree.  In shadow-utils we have the same approach.  We're first
hardening the writes to avoid overflows, and are leaving the truncations
unreported as they were before, since that needs a case-by-case
analysis.

I won't give my reviewed-by, since I fundamentally think this is
building on the mistake of having sizes and lengths instead of pointers.
But I _think_ this patch is good, FWIW.


Have a lovely night!
Alex

>=20
> -Kees
>=20
> --=20
> Kees Cook

--=20
<https://www.alejandro-colomar.es>

--zzbkid7pe7r2xd4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrzqdkACgkQ64mZXMKQ
wqmSQg//Q/+A73PLV73CVv55LrNmsBxE37N5gmuSEBL7r3KH78MXJ4/V8Qu86jJs
IVK/oIEP5UDLW3/q87QprhR/QDmbvzzi9zqLJMLs2GyO23zfo074a+9qpGsgktGi
29i8GycZ9GB6f4iFWoux4YESzzItA+ruE/Pav6MdeJ+JonEXcLxvyI/0Wrqojz+A
mLp9JgfitAtWiYMGlLhHTAC74I0l5WgjlJzRVZeJuJks/cenkjbfoCxJmLsshw3w
vfJMZTgRpX1YoT2S1RC0cSDxXON4t/R68RQdrbnveU+TXrh1fMfw2aIkMqs+sh6b
tV7VIl89GG+K+bjQhiLnO8sPeOWasxBkUaHbM+ixjiUfHb0Z1WwchN2bTUdKqAo6
cGBGB0bxhfRQbDk8S0QC1xL5hF5MN9W+26EgjZ8r/WV4Ct9uelfUvQE42EV30Alu
OENr6DIwlrlbvljEAkI3utLDnM+uMnOkihiDahjbg5mISuE11F1LAhnHVjoTf86G
InoJLao5GjJPR1ScWyTWA3vyaODmpa4+cddUuPePl0+NYkjVwwx1nEUAjiaTE81L
elhkToqsoaI/pabc4mjcmLmuycBCz0BUREyZ2oFVqWdiO01vSzp2/PiWHbORyXOR
udZCqCEveTE9S0biaep20Xi0ZrFphKTDOprML1rwhxpknMWR1DU=
=lPCQ
-----END PGP SIGNATURE-----

--zzbkid7pe7r2xd4x--
