Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F92B214811;
	Tue, 11 Feb 2025 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739279603; cv=none; b=g2Pg5DgGVWEvXzceEOE93MiOOt7aP+pAFbkAzx/VtzEME5J6/y0upi81Jen/FNuJ815Q8uQYZ/oQgMscAgZnHsbFfMA6q5xdgr5E0fFaQmjWQFW1XXvtgOWhBlPf68SjvvJAH0sajZXH4uwlEBbKaIh6a8UxsVGlexuVAkncQ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739279603; c=relaxed/simple;
	bh=DXHDCcdSZ74+HT8JhefhzAUBoSlZIMztGyfXMF9pxcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEVevlynOFGxoAkV42DAiD+DM2EB7lGq5/XNe9UETr8mXOxsz2nWdedrzWgBfsSrPMEK1TpGOU6X0RHTuUtXQdbLeKZL773hKhqduuYGh2FpSw6i47GkLhZCfWH6UKhy1PJY1O1WwvIiJFGKqOEgtJFMGRJSe3LG9j0ccwbbb6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7LnbAvU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7LnbAvU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F064C4CEDD;
	Tue, 11 Feb 2025 13:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739279602;
	bh=DXHDCcdSZ74+HT8JhefhzAUBoSlZIMztGyfXMF9pxcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D7LnbAvUGrVDhyysGn7C7ourOQIjJ2uwjXz7Kt38gn1eVvhJUEnyG+AtDw7TzCGE6
	 l9me+Lv9VSuQMnB9b9D8WgRw/lxoFRLsEyIulZTZEWA4/D+WmkJTVAoGS5NwtoIwa+
	 FWawIAwTrlggUeLDRN/wj9v4p+XWf1AlAz+1RqV+pgvlIveMCxH+lkKc5qgYR+w4dE
	 A87s7M2yZrNT4gK0O6ehD7vmBaW+9WTF0nKT7qvoOQsXGXr695ZDzmBpiu/85f2ii2
	 CgvRI2Rt9YNX3KYFmKSZGAoiOLO1Tbr4B5j/0ihjo/PBHtX0ulzlaG+2kZydONBtVG
	 +IAZ6njAAxFaw==
Date: Tue, 11 Feb 2025 13:13:18 +0000
From: Mark Brown <broonie@kernel.org>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ASoC: Intel: sof_sdw: initialize ret in
 asoc_sdw_rt_amp_spk_rtd_init()
Message-ID: <ad5eb513-d3ef-42b8-b4a7-88a6ecf08804@sirena.org.uk>
References: <20250210-soc_sdw_rt_amp-v1-1-1ee1afcd8941@ethancedwards.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KlwLJ2hhBEf8MsIq"
Content-Disposition: inline
In-Reply-To: <20250210-soc_sdw_rt_amp-v1-1-1ee1afcd8941@ethancedwards.com>
X-Cookie: Printed on recycled paper.


--KlwLJ2hhBEf8MsIq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 11:08:27PM -0500, Ethan Carter Edwards wrote:
> There is a possibility for an uninitialized *ret* variable to be
> returned in some code paths.
>=20
> Setting to 0 prevents a random value from being returned.

That'll shut up the warning but is the warning trying to tell us that
there's a logic bug somewhere in the function and we're for example
forgetting to look at a return value in some path in the function?

--KlwLJ2hhBEf8MsIq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmerTO0ACgkQJNaLcl1U
h9AZowf/aDiZbuROEyPiikzdBtyZNIv0RE/feOqyLJttpANt80Ha6yTGBnkEi6Ok
xBRMlSQ0Xfz5k4Gz6kX1Sk79LIFyUfSGnNW/0rjzVhxdT6PfM8Hg0K4ujZ6DxpmJ
BuicLQVEfWMJCw688UliIC2IK6AkET84jHpXYmgyVBH4GQ7wVbb2F2qaicUg39IZ
+W+/T4juBjH+QVia2/k9IDpfgtupug29KyPPAAIJwDrdCTk1RJDQfNV8xJaIxCUp
nVQFRBeWbIdE30zLlbmu0T0yvoAKdSpPwdSWarXTO9uiEsrlb3TXFIOo1055uxWx
e0NpolOzog/setmRTDDRiDqq3LPq2Q==
=UEE1
-----END PGP SIGNATURE-----

--KlwLJ2hhBEf8MsIq--
