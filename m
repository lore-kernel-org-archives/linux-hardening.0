Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E38438FA6;
	Fri,  6 Oct 2023 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yv9UEybo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4934C433C8;
	Fri,  6 Oct 2023 20:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696625792;
	bh=bI2+ouc+Xefa27ZvVv+DaV++HNZwlDaiJksobE7s8II=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yv9UEybo9t0NALe5Gm80xon6sSfaKTOuNxG7J8EjTkPruZowav+xgrIyBHEMCDCtM
	 +Egr3iK5Wr7ySpLKQbDfyN+Tp+KKkjxgi5hkvwiLQZMJ6dC9ScZsBHoWFOPfXI4IPt
	 aTFyhqgji69p7yak+vOl16me5hVNfkd0VWtH8fVmhpziXdzSF2n9VGQJzmN1R/cX2f
	 GFZBIUzUhBLXYKJ6KyhK1s38E20dER/b93kCazfq868PmW4rf4LJK158zGL8blFyMV
	 GhnDmy/lc+m0V7MY159k79JPx6NGw2dIAhG+8dTE5EiTu/H2+a7c02ks9FkCxlsXNy
	 F57rgsmSl01mg==
Date: Fri, 6 Oct 2023 21:56:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] regulator: da9063: Annotate struct da9063_regulators
 with __counted_by
Message-ID: <cc654fb0-6e13-46ca-a5cc-d9fa103219e4@sirena.org.uk>
References: <20230922175207.work.576-kees@kernel.org>
 <202310061339.56F7680B5E@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UVGNWx+IHQQYoB/c"
Content-Disposition: inline
In-Reply-To: <202310061339.56F7680B5E@keescook>
X-Cookie: Rome wasn't burnt in a day.


--UVGNWx+IHQQYoB/c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 01:40:08PM -0700, Kees Cook wrote:
> On Fri, Sep 22, 2023 at 10:52:07AM -0700, Kees Cook wrote:

> > Prepare for the coming implementation by GCC and Clang of the __counted=
_by
> > attribute. Flexible array members annotated with __counted_by can have
> > their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOU=
NDS
> > (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> > functions).
> >=20
> > As found with Coccinelle[1], add __counted_by for struct da9063_regulat=
ors.

> Friendly ping. Mark can you pick this up?

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

--UVGNWx+IHQQYoB/c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUgdHgACgkQJNaLcl1U
h9C+LQf/X+gZV3JvymRIlvWotBbIHsdzzyH5bvHQ+Acobf3F567RPr5EP3ZL7EeT
+cs+U8/UdEw0zCNVOofkKyvZospOTi9X/U3HsYVU4osWM4v+B7fsOtm2n0Q8hL9B
Jlf3ra49TuQzRtB3enC6AtdvRABtx9s9Zd8DBkMvDOnBARiqzI2Bk/yzKtAhCoRa
oJMoMxmyoLt/IppOe0j/pS955L/2F0sFEBClNpognRVu8oyr4CmhYTZUhBhGMtOV
/iMxiRm+PFUS6P6rUrRR1D6Yobvw+zC+7HJtXDFKMTFuxDzUa+WboK0UqcMc6Xe8
fUqzU1Xf0ZKO4GdbKtBlPxE1zm2jSA==
=PQgx
-----END PGP SIGNATURE-----

--UVGNWx+IHQQYoB/c--
