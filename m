Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AF621A0A
	for <linux-hardening@vger.kernel.org>; Wed,  4 Oct 2023 20:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAwHegU/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033FBC433C7;
	Wed,  4 Oct 2023 20:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696449682;
	bh=gjAk4UeEADlOi0BC/Bp+G5FyDEKB7pC9rqguaqpqXso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gAwHegU/wHV6Bxt8YH/rMEV7s/F3x4BajMAeWDYw1DLfytncmYeJ5UjC0ZVrWuMfP
	 XSoJsKLdxtspS469093dUFmT3EfkPg9oXLkWgXuTCGD/bkktKLXmsto7ioXBHg5Ggw
	 irLpI5/EMYLAlkwSPNSi5zvOgr3AF9FJDeulq0peLgXC+OOurnjNJuWh//0Yvhhmf6
	 HfqDmbNj7Gg6wQGRln6SuAcvHlf1If12etGka9kkGFpDWGqZt5ETV51j3HCw8xVYuN
	 sY8yLhIAJXPA00k6AmaViHMZmNcIG3PxZqWVc5i+eYmRxi+JWT6CMus88y/N5aFzFP
	 eACcu6ZKHVHzA==
Date: Wed, 4 Oct 2023 21:01:17 +0100
From: Mark Brown <broonie@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Include additional ASoC paths
Message-ID: <223d82ac-0df9-40d2-b7f7-bb86eb0eb6a0@sirena.org.uk>
References: <20231004193441.work.109-kees@kernel.org>
 <f258a7e6-0728-4f55-a71a-6e99113ce7e5@sirena.org.uk>
 <65EBA3C4-46B6-49DE-8F03-AF0E2776FDF7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mr1DUG+4KnAxv4Ld"
Content-Disposition: inline
In-Reply-To: <65EBA3C4-46B6-49DE-8F03-AF0E2776FDF7@kernel.org>
X-Cookie: This space intentionally left blank.


--mr1DUG+4KnAxv4Ld
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 04, 2023 at 12:41:14PM -0700, Kees Cook wrote:

> >The SOF header is also missing from the entry for SOF.

> Ah, right! Can you take this and tweak it with the missing entries, or should I send a v2?

Could you send an incremental patch please?  It's already in my CI as
is.

--mr1DUG+4KnAxv4Ld
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUdxIwACgkQJNaLcl1U
h9BxIgf+IvcKFL2bBBrbzwqg2T+mZYRH2CbfMSOOHa9gAMMUA+fW4V/+BXbtMt32
fOD3I07lzYPDDJZbc4bqK6JgF1ac/mfBBgd0dBW4vop2bvkHBqnmNccpNUAqXYUq
KZ55EYFRLimORYedYS0CBPeC6Dw0cz/W98bFJUEFUNE1cD7YWJaoUvAdOGdH88tN
xMkPaJJIw0SWzahcIjF2dpZ83PrkzfjRVsLTVCVXC/+zUM2VBQGL+fB12BDvq1wu
j8khObJ9nNXAGF2fp6HsuoUgOjROD2StkEF17xv9FJb5MH4FRGE4fe60NSebQOuY
dX4jmpM7yy8BWIiM04Tn6qvqti+IOw==
=cbt6
-----END PGP SIGNATURE-----

--mr1DUG+4KnAxv4Ld--
