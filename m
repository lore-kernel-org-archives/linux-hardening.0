Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856E542A92;
	Tue, 29 Oct 2024 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730210917; cv=none; b=e5VwT3fFFETqP+RLzrUOgRGQsKcsBKYoFhWhin1YrNMqQU8sURlYYDQOcePSSccvYy774Anx7wUH09Mamwm3rLNGqkXg0i4iXwhK35u+GJJBjn57Kag4akmdcQuGujCDdVFHa1kqg6acySR3ykt0aWBIetx6M/bMc6UuwKSqip4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730210917; c=relaxed/simple;
	bh=ObDzOhYCuptnWikVtFmXWeBb94o2pZmdsPmc1Vb4m4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRlp5PCYZPTbiwgkJLDq4IFoIF4AHxUSM0afz7tmnmN5z0zMOqBgJr15oWkP6f6Kns3YofqgldhA8Sq5Jmo1IbNuadXf8UlVk5c+tHplC3+IGqIWg+pqdsGBGeT++2wi2wNiEjlr/OvE46hK89/GI0L0txMDWU4QAabHlGiFQoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyLq3F6C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyLq3F6C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5ECC4CECD;
	Tue, 29 Oct 2024 14:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730210917;
	bh=ObDzOhYCuptnWikVtFmXWeBb94o2pZmdsPmc1Vb4m4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CyLq3F6C4Jb3uE3m9U9UXOrYlYTQilpLv2CHJmEOSnK7XypTSrePEMX0XasfLcydi
	 cOh23QeYStyUJih2j/+ED2eegBEhW98+aakvfIPBISE48FqbsBLmLiG+kRmbcCUkLq
	 1OX/S4YG+dJwcpFiElWDl2YrLPBc/ohXhX29N3IVOODd2jXGI9BjScSk0iMGFaW1wZ
	 0Gq3FGWWXXJYbTlEoJQcA4UgpWuoZCHtAYd0mw/J/cGD1BkpsHzY/adpVcA3VRpmBd
	 JaguFeCPVNK/fAgLWigDFWYoO/xz9uYeZBKKHO2LFYyBVMcm3PIboxGuvkm/f7m/Z8
	 imQ51x9DOJKVQ==
Date: Tue, 29 Oct 2024 14:08:32 +0000
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
Message-ID: <da230ccf-37b6-4e43-be12-9035c594e535@sirena.org.uk>
References: <20241028-soc-dapm-bounds-checker-fix-v1-1-262b0394e89e@google.com>
 <28ade5d1-d13a-4388-bd0b-f03211937abd@embeddedor.com>
 <ZyDlAd-Z26wnhZK5@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Smf6UI3x8BM1at2s"
Content-Disposition: inline
In-Reply-To: <ZyDlAd-Z26wnhZK5@google.com>
X-Cookie: May be too intense for some viewers.


--Smf6UI3x8BM1at2s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 29, 2024 at 01:37:05PM +0000, Aleksei Vetrov wrote:

> Sent v2.

That doesn't seem to have shown up here?

--Smf6UI3x8BM1at2s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcg7F8ACgkQJNaLcl1U
h9B/rAf/cLEITqILQmYrE0RumhbYtZyY4dnDDKVlSj2QfLqRDxLP4bfdZt/xfMn9
W0KcIXOwy4PuMJe/vKNvOg0GfWX3wDyGBwxiGbaZpZpRlZJgHNInpqPqCKVAPJw9
Kf3DgtiAL7CdUB+5JKcFK4lPZZ6R4aqWV5V3moU6+J54a5wVCyHL5V+4KCB3XNgC
J3BH8XSVx4+CrA6YdxNzJL8YYii88a96PZf5V5beBbMQhz8gWV9bRjwWatnLBtsF
yvUyl9J4R/A7a7wKnQ+X3aUbQFpS5t7hmSIZU/dJqhqLZ///JiNCiOaDe57eWYc5
Aauaqaq0v1NgxKFldJkgN80cVYOoDQ==
=8qa+
-----END PGP SIGNATURE-----

--Smf6UI3x8BM1at2s--
