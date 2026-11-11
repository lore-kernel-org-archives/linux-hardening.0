Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402570;
	b=yby5hZDcYEJP05nSmf8d7DItd1RTEB8rEvuI8I3OnaG+JpSsr40nCzJK0wh9DdxJnzMO
	 PlRUvdnT5hHqFKn//rPoAdEvgK4uwg6C3aKCYt1uPwejwsNxVD3B4NAhzTH+O8pcEwchV
	 zkvN4L9yWBbUw1hVtYjDwHiKnO0paPCK3mHqE62ZVaDIBrbjHxF65U1cdNQ+T8U9gedDn
	 /HM2jFeLq0vNZDmbRx8x4Ymze5KBI4T9pB5o2c1DWJuJf14d6w6twKx8gVOzIXo1bEBcg
	 1yjF2sXq0cz0O+86ChlBSxVI+90CDyekaguHiYOZsxdFd5DzUmdiSzKIkJQ38BLjQPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402570;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=myTzMTEVgNJ9R2A9o9uEj3ASLDjoWKyGqA3BNP4iJWk=;
	b=hSDFd7wsLUiL1/zQvmYZkjp8uLXfx8JpLU5sycMpJsxWuCorNQUvLO3sycTWRLtFHgMr
	 OIQbmScuzSeyJRSQI2CI8TnLl/PfxUNBaMU/dBHvQ8uOFdByreOm0TrzfVJ63i44UtVt4
	 I/812tOLI4/K9ZrPh77vVrzabYm+YvTGIz8Drqaht95h0rk6sp/JSnOZ6jIHExL1fVT+l
	 r8L20xqd8ApaZd22cxTkGi3q+L4UI9PzZW9IvsYtuZO1SIvRPAWT5gPBCWy2uzFp1iNVc
	 vovPwFJY4JhIl95EHgCiswO29abHmEzVzBkr5FK3UYRBDWMtHbGUWbd2FTvpBlemiEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B1HsNoS3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE66606A888;
	Wed, 11 Nov 2026 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B1HsNoS3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05631F00A06;
	Wed, 11 Nov 2026 13:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794402570;
	bh=myTzMTEVgNJ9R2A9o9uEj3ASLDjoWKyGqA3BNP4iJWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B1HsNoS3ZmRDWZNuYSbODVDeuktqIoLR2c1a6m8O18dO/Tj3h7a3jwY7KJaLMROW2
	 WcRjv0oYpnT/zVPk8zwYtfhRUf7ZRTmiQbax4uzSs4S2FzIZhEWsEhwY6wKTPYXywQ
	 LwtpUVRr8Tm+IYUmQ+OUXah4oBsYYhID014GbwaA0iz9ioLQZ1hdZ5jffVTt7fScJ1
	 FVWfjRXvcPzbZKbsg4pz0pzkcq4F6z5NzC84VNV4ERwWDf5lCCNIht7/pcNRpOTiyP
	 83HLodIFXqbHtrUMD60fOuoVv4777BzkpKlk4YPeD+7t1afOoTu2SSlEcjmtKnUKhp
	 I1PT6bjqp+XWQ==
Date: Wed, 11 Nov 2026 13:09:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: soc-core: reset rtd->num_components after
 allocation
Message-ID: <853110dc-2ab9-4271-9e81-20ce5068ecc0@sirena.org.uk>
References: <20261109102536.357134-1-ghidoliemanuele@gmail.com>
 <87bj7yw9e2.wl-tiwai@suse.de>
 <87FF4A7B-853C-466A-AB01-2D9137DEE6CC@kernel.org>
 <EAAF07EF-6B11-4EA5-A5AF-A7787CA2F196@kernel.org>
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
	protocol="application/pgp-signature"; boundary="+JyK9ecf3AVrKjur"
Content-Disposition: inline
In-Reply-To: <EAAF07EF-6B11-4EA5-A5AF-A7787CA2F196@kernel.org>
X-Cookie: Do not pick the flowers.


--+JyK9ecf3AVrKjur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 10, 2026 at 09:59:12PM -0800, Kees Cook wrote:

> For example, what keeps snd_soc_rtd_add_component() from overflowing
> that array? If you want to protect the array, add another member, say
> max_component, and use that for the counter, which gets set at
> allocation time and protects the array from indexing beyond the actual
> allocation size.

We could do that, and it'd certainly be good to do so, but anything
that's in a position to do anything here will already have sufficient
access to the system that it can just directly cause issues.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--+JyK9ecf3AVrKjur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr0aQQACgkQJNaLcl1U
h9CDogf/S3na6XdVpn5IhiTtPHeH6LC6TYfn8B33uirn/dIJ54WsGUXcX64eocfM
p3hLO+Y6AEQg9cbbeexeLqmF+pNbyC7AozLPIkhtLQjQRCdsfjPXFn6Q7HGgjJyD
hvWOdhAW2KrDE0/TFplotVcYyWwMCspu5QsIORFSIE8ckoUkCppCEmmcsHYxjvIm
IroNxhmPQJrXFbBveGZhRhdgONBkucVoBoYm9evLazFa1dbb3GrvLG6yZLNcE1fF
bSafzYSHj02eVuEGuCI8w2/pYu7bPkCO77KgunPYBBtvW0bPZBhIq6ykxLR26Hb+
LVTnSa/HAJQ3F91CFZJNrf3NLHJToQ==
=6thM
-----END PGP SIGNATURE-----

--+JyK9ecf3AVrKjur--
