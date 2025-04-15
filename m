Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A1219E7D1;
	Tue, 15 Apr 2025 10:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744714621; cv=none; b=GzPT7kdrCOoSEx0Uhv1ZLKqk6gYE/kAJM1CAlsdfcbjopm4MHixiEBhVagLWk3N1xaoE8s2zk+rRtD1g6GI6duMpxHYBkH9DO4+c4pjmQpxI4pXp2bPk4VeofdbDRMrcxk1doCp2419HV4L15DWmay2EZK2n0SUIbcTG5olL8LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744714621; c=relaxed/simple;
	bh=gncSXvctAfz3x+QPjq1GkzJ1RvaBWWsQilFS9Cal2Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvrLcgkPRX9dGErRVzwo+VvDpwQMbMWhqgF49Z9uBpuq7wCKgqyP2zz868ZouoDY0FBxn+ZrqOXPwNwQqcdJYsk9bldf3JYaidFAuP5h4eJUIDfcuLMyV8X1jvVFUERHxQAMMQajj7B9OnsDF1rH3NK+2TOl9nG9lcmpn9LB8ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0cQxFT3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0cQxFT3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F97C4CEDD;
	Tue, 15 Apr 2025 10:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744714621;
	bh=gncSXvctAfz3x+QPjq1GkzJ1RvaBWWsQilFS9Cal2Gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i0cQxFT3RRZC8yY7ylivYIatGVbQknK/j3dArhiCBWdYQK0M5cnbXDEVPgMmVkCEY
	 Rf2GlzRTd9nIl+G0oV4OnYZ07QOaNqFI4Xyc4+UlEgEJ5YGB/MJH54V8Ojh9WSyUfx
	 J60+mnOIh5H50UoaQDRqGpcu+tJiDvlGghl1DWJv0puE1z9KQweQLUatXGVVIaUlW0
	 o3dNgm6ccZivDdeb2nUNY3kFpbNLxmWj+F7fo2aGIRhwArzbblq/8e9q8U/10MJNwB
	 Z+D1fpNYu0LpPpb5x3YkVrBDQrJLVPYACTGkxNKLbm99GweCc7EfKNlmpBUqT2a13k
	 wvdcqt0l3mFSw==
Date: Tue, 15 Apr 2025 11:56:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ASoC: cs-amp-lib: Annotate struct cirrus_amp_efi_data
 with __counted_by()
Message-ID: <9a0595a3-00c0-4006-bd54-99b938ee95bd@sirena.org.uk>
References: <20250415090354.92211-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/Ul50wVluqGlUpJm"
Content-Disposition: inline
In-Reply-To: <20250415090354.92211-2-thorsten.blum@linux.dev>
X-Cookie: 10.0 times 0.1 is hardly ever 1.0.


--/Ul50wVluqGlUpJm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 11:03:55AM +0200, Thorsten Blum wrote:
> Add the __counted_by() compiler attribute to the flexible array member
> 'data' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.

As documented in submitting-patches.rst please send patches to the=20
maintainers for the code you would like to change.  The normal kernel
workflow is that people apply patches from their inboxes, if they aren't
copied they are likely to not see the patch at all and it is much more
difficult to apply patches.

--/Ul50wVluqGlUpJm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf+O3cACgkQJNaLcl1U
h9DbuAf/R5ZPmY2sT7rqBcn+Ww2UqdNCX4IdMEqqO812LvTuNJ9NHTSUclfcVzZz
BLkzNPiJzqiOEApU9dbCOCLOuSay9+jOrpuLdcOWCRQIZg1+GZam3VQsGsNsBx5Y
Zs7Tu2P3M5XHHFtMLIO1KlmIt/4ACPDRwKsuS91OuT8DASckLF88pe4pbFB1PsMY
1xaQwd6WXpM4v4+6JFIVJeWSwPJktIeEx8vRzmB8CjE1w83JdRdAgxWZFPronvMt
RVAkyOejz6QmPPMvGjhECWWS5hhXp1e3mLvOWqM+dWV3ZlhPuB6Mql5PNX7SCQKt
QvHY3jwQIJW9K3SYScftlCK34XbLIg==
=K6sS
-----END PGP SIGNATURE-----

--/Ul50wVluqGlUpJm--
