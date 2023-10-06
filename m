Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E9338FA6;
	Fri,  6 Oct 2023 20:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qykK950d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF79C433C7;
	Fri,  6 Oct 2023 20:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696625635;
	bh=oauOVFT+PrZQ4LbhFiEvzNY1S0t5n89QX4XT55V6IgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qykK950dTH96BIMrlSxNk8F7VgVWrjQ0wm/EHPGYwP5AOi5ayH7AvATp2Jboup2WN
	 axuuvRZOQBYLh+2+I9jQgJha4Zf+IeSiNhyq+NK4ucPmIkE+VkrIzU8fqG2Z8zZoe9
	 IJp/cG6FvEdOrZFJ5oeN7J3ZL1EUesyalkvY19j+lDFGS1HFG4T+eezRSDgLGhTf0v
	 yVYjdpujB0aRzaD6bzgIiLF6qRYP8j6i+n6hTeUeNqnuHG3KvPYO+c5RSFwfmB4Rbb
	 QPAeXKkDWm8gDryJqedpgaWo3Y0nqLR+AkKYWIKEgr3kNdQ7LdCG1hpT6cEDbbuYW4
	 92aS+GaFg3bdg==
Date: Fri, 6 Oct 2023 21:53:49 +0100
From: Mark Brown <broonie@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	asahi@lists.linux.dev, alsa-devel@alsa-project.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ASoC: apple: mca: Annotate struct mca_data with
 __counted_by
Message-ID: <6c7db067-78f2-4637-8064-3dc7c0489b90@sirena.org.uk>
References: <20230922175050.work.819-kees@kernel.org>
 <202310061321.E7247C52B@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xBZ5y17+t2QN5UsW"
Content-Disposition: inline
In-Reply-To: <202310061321.E7247C52B@keescook>
X-Cookie: Rome wasn't burnt in a day.


--xBZ5y17+t2QN5UsW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 01:22:55PM -0700, Kees Cook wrote:
> On Fri, Sep 22, 2023 at 10:50:50AM -0700, Kees Cook wrote:

> > Prepare for the coming implementation by GCC and Clang of the __counted=
_by
> > attribute. Flexible array members annotated with __counted_by can have
> > their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOU=
NDS
> > (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> > functions).
> >=20
> > As found with Coccinelle[1], add __counted_by for struct mca_data.
>=20
> Friendly ping. Mark, can you pick this up please?

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

--xBZ5y17+t2QN5UsW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUgc9wACgkQJNaLcl1U
h9AThAf/TVx58WnyibTJozFRT7p4/Ow/TjcP0UNKN4akoSmOUCmaCr8FAebKU1+t
wj1hcUXFXVIQP/EWLB2hf0pPGxzF0pIcx0gGGl46bSCFO0jXks35z0iGcMniCiNA
kSZf/TswG7Guf6j2vwKiwa5eDnnbjtRMzHsW0WZ5UQxslZwRORs/Uvhj80RsfPQ2
NeWrMXwVNs7kmVPS9+12eYUG62+dyFwMKqDhsFraoKIyzUZkIlM+EWi0P9oRm87V
1PyWUzk/CjTMyZpeWWBoj+Q3vtlPIpcFePRpM+LfCN7muZyWQbAvqJqyJgqhW3Iv
mx+Kp3meL06isrlLlnnkOBAXrvPRkQ==
=9Vt7
-----END PGP SIGNATURE-----

--xBZ5y17+t2QN5UsW--
