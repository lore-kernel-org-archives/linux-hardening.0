Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE2C223715;
	Mon,  7 Apr 2025 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051707; cv=none; b=IfWrinAw19PdYLYFLAFxMZ1OYeai38NgxcJWgHJnvkgkFQguQPJCn8QEccLu7thvdEhQEmdjBTcJiKoeV6ZSIgMe/R1Fn2Gbv2tuaNTyydoNSGRC7zq/Zp2cnOHCe8CLKcCcRekl/ToEP3lg36UkZDW2s1DzcOuI5yqPVbXIOM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051707; c=relaxed/simple;
	bh=WXWBXg7Mxphp/ZcQx+1HGg2KHbspvDldDkveLIdFIX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkmfBXMbVN0Yu+UrNj/sfpdzFvhQWx6qTWtfaKRg/Ew0P1FPiMXU2iL2M18PkRpPl0ZRX0Ct73n1/SyBWNMKXY8ijF5NcvLc7RpmGt4wsoFpZEzZ9+qIRnQMMtRWVak97N/nYI5yCyyr9bz4Y7skZDmIH+gRXOyZ6F4rJttcIq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wr5UMU39; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wr5UMU39"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EF5C4CEDD;
	Mon,  7 Apr 2025 18:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744051706;
	bh=WXWBXg7Mxphp/ZcQx+1HGg2KHbspvDldDkveLIdFIX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wr5UMU39sO6Wo5hAa5DBkFozW402JKSyFJqViy+kN5Dh57rUYZZleQlCPhnGcIHXq
	 TmjoJqBi4TmXdTK+vg/kuHwZHzz6hUEAIZYXNzrmbOMuWjJvHzm+cTlkF+VEfA7vTC
	 zIKizWQ0aeMrS/sTFt+Ga0DTrBG9FmiOvFxJnxhfH7tqHYe43EEt1Huy0vtSc9P6Ri
	 PKEqca1Jh1p9Y4koTH16WKKb3e/le7c8hFsak5tYlVbxifERaCnsou6GQrc493ey0/
	 BqDkjogR+c1htFcP/8L51vfnaMZPK9vPKIMq5U0Uhprx9qxDhDAYqux9NQoye7SbmX
	 ceOuP0m1jN8mA==
Date: Mon, 7 Apr 2025 19:48:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] regulator: hi6421v600: Truncate long strings for
 trailing NUL
Message-ID: <da71edb5-8333-4700-bcac-cc4bdfacd0bd@sirena.org.uk>
References: <20250310222408.work.339-kees@kernel.org>
 <202504071134.1AAF30CAF5@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Mp9tbpEoV+X1gcVS"
Content-Disposition: inline
In-Reply-To: <202504071134.1AAF30CAF5@keescook>
X-Cookie: Meester, do you vant to buy a duck?


--Mp9tbpEoV+X1gcVS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 07, 2025 at 11:35:33AM -0700, Kees Cook wrote:
> On Mon, Mar 10, 2025 at 03:24:09PM -0700, Kees Cook wrote:

> > GCC 15's -Wunterminated-string-initialization saw that these strings
> > were being truncated. Adjust the initializer so that the needed final
> > NUL character will be present.

> Friendly ping on this patch. Who can pick this up?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--Mp9tbpEoV+X1gcVS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf0HfYACgkQJNaLcl1U
h9BDKwf9GIS0wm69aFKwCYCEHzmUyEMCsWc3FkSj7LdyIo7YlbKYxpZEAMp8YORn
YNyEgEEzXhsGV/WCdzgN8b+UlrHf0EBJ+bs9DUIC7JcaTZUw6v4jhkh2omO87pw1
JsAWaAahKJYna4noOx0RtmTogltXZWqcoXpnePK3wgRGo/4DC+wTbKG6kTUONUJ6
2kdHU2q0KSJy4TBXlhl4AmG0o9ycy2PKdi8Hs1xTUD7U8rqIQmu9UjNzcdhAu/Ub
0JBLsZe7s69v585jJjh6ii2URbspiBVcuN9NEigFLP5f/Oxf8Mhm3jIbmVsFHgqV
wS7oxe7YC+8GvV1mKBUPA/0J7N839w==
=b0+I
-----END PGP SIGNATURE-----

--Mp9tbpEoV+X1gcVS--
