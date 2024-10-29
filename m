Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8E4143C69;
	Tue, 29 Oct 2024 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730225723; cv=none; b=G3fcnywM5k2crHgr8IkAW9Wdw90yCxXK0qQ9HeRfUGYg4l3hq3lEe3ts0eV8Z5+wqNVlIY435mYQqZ7o+EV9xZ04E375PzzFAOKob0UqAskjGftfO8976ujbKWuDVEuAUDVwY3EyFhJZoa4fJF/xw6yLOl71biULI9b7oxB/avY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730225723; c=relaxed/simple;
	bh=SUd8Fc60kMIwRHBEd644PvXPNmN6u673tT5mHr0L2U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4kc4HZmXk9VTPFNCbsR0LQ+RoSWFjDAvGREAM9YHkTGL68/A/bamR/yo6EyXUtkEZzoWLcHicRF2EMnM7UmxUUYvNPcnQYve3l289eanVTEU87Q8BaJWC+uQeSsZ1ZR8i+cnz7F/UF7gopACiA/abTIXqCI6uN+C0xGm47AyS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCb5Ad1A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCb5Ad1A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DECC4CECD;
	Tue, 29 Oct 2024 18:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730225723;
	bh=SUd8Fc60kMIwRHBEd644PvXPNmN6u673tT5mHr0L2U0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cCb5Ad1ALPrqxmK8RmjJSVLH82wkbcGBny8r8W4SeYAd49O8iT7Nwc9kCtO4gJI3m
	 /m1279qtmKoSs6PEfBaaT093vHFVZiy9MTIulVb1Gw7nigJlxhhHE6wwCyxFTB4eXp
	 mXYJ14oRze08dQ1np6AtzQPxXYqgw9ULxU3vuAtPDOpQJA9L0GO13N6Tzh9sR5QAl5
	 Bp9rDHodEUeuyjqpk/VBiJw4DeKgd77o02eziFehH3OAPknwdIFaXxmCTPVaRLSfME
	 kCDlujuW9kbbtgae3PrjAiIg3fFYnDjDlvVGJLcZn6yH3RkKGreiycMTvswaJ4Qd6v
	 NavE+3CTiJ0Lw==
Date: Tue, 29 Oct 2024 18:15:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Aleksei Vetrov <vvvvvv@google.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ASoC: dapm: fix bounds checker error in
 dapm_widget_list_create
Message-ID: <608eb849-dd8f-4578-b5e7-940cf0883d0c@sirena.org.uk>
References: <20241028-soc-dapm-bounds-checker-fix-v1-1-262b0394e89e@google.com>
 <28ade5d1-d13a-4388-bd0b-f03211937abd@embeddedor.com>
 <ZyDlAd-Z26wnhZK5@google.com>
 <da230ccf-37b6-4e43-be12-9035c594e535@sirena.org.uk>
 <ZyD77Y8bIP3JCAZE@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m9pEjx8BKKls8u8P"
Content-Disposition: inline
In-Reply-To: <ZyD77Y8bIP3JCAZE@google.com>
X-Cookie: May be too intense for some viewers.


--m9pEjx8BKKls8u8P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 29, 2024 at 03:14:53PM +0000, Aleksei Vetrov wrote:
> On Tue, Oct 29, 2024 at 02:08:32PM +0000, Mark Brown wrote:

> > For this fix I couldn't send v2, because it has been already applied by
> > Mark Brown. Guess I would need to send a separate message to the stable
> > team asking them to pick this patch from git.

Yeah, ping the stable team (or there's a good chance if it mentions
something that sounds vaugely like it might be a fix they'll backport it
anyway).

--m9pEjx8BKKls8u8P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmchJjQACgkQJNaLcl1U
h9AQRgf/a2GBYei+J8s+gsxooV9IOOFtXRNfi0r7cTXM76i8ADlzxwfP+0YeOwwZ
aEvlC6FACNmwMYFHUTYakWLna93Z18CI2lYto00Cx62aA0dV8nNXoIuAobXFIg5n
hqMyIfijNAT46GYbrKsFMN6mLv1TzqBPx65a2VxwdKLNJpEQSV+nTNOZNb/2sd/j
5J6w/s0hBWvzqTI9jzCWxQDExdQsGWOH+7ZgGStizVwrwMTGgnjSOmZOhLUU5EEb
6yANvLIcJYYPERnQDLaaBEZpAKC3pHoSVc8S+X4s5DQdlytpPIa2tothmDbKjEG/
x6w2wxTsrsBhiBNzs5eIw/KGZ1lpqA==
=tqkL
-----END PGP SIGNATURE-----

--m9pEjx8BKKls8u8P--
