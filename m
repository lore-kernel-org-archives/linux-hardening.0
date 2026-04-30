Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D189443;
	Thu, 30 Apr 2026 04:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777523780; cv=none; b=pvMOHRBNBGuUTsROI3XwjwdLDYyOWwJDGhmKjAwTXrploKQU5YxKf94aAglyOJFRIjoMf7VYuLXVBY48PopcfHW7Hut2ZSySIEGFwD6ERyAZyasSJ2m4p7fMhXWAFcDw0MFLZ5XO9oFgjCJPK+5aMGe8DOdF9+6HswVKVMHYnjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777523780; c=relaxed/simple;
	bh=VbcIB6QDI2GK0JR953/0w8mpjwHUSLTAdJnyiHgZ3uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRILnQkbHBgSef3v47O1aXD+xpD4yGFLgqQNuqdZngCGi2IkUJNwwafU9/aB+r7PBqEnMdh8KsX+q2lnYZkVa1N4XNnbmz46t3AydaUosWtbBCyQeaOKtt/HGn4NLOwVggYPT656GGDOlpDrrUAykYTyjQK4fo5MXoyCLrTkBeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2bEfmKo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2bEfmKo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779A4C2BCB8;
	Thu, 30 Apr 2026 04:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777523779;
	bh=VbcIB6QDI2GK0JR953/0w8mpjwHUSLTAdJnyiHgZ3uU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l2bEfmKo2t/3x7JU4zUCVmrXGP4Sco7GBQ1Qs0UphMMxy8oOArePHaLGApzIMliKi
	 hbqcVK7OdeNjMCYFgrEBDxqNJsiOYFlurMsWM4L4I8h7tci1txLXRRThwUUAkDfswp
	 y1vghb+kvMS5/MrigQ7flkR6SE7lZLHhayXQKnhZyDkwhS1sLJLvgoEEo78Dtw2ce6
	 qVenlU3zWFoZFKRRc3ksIPjqhsnYo7PxjRItDIB9OTuLZITJ64PLPynhkUZVjhGg7j
	 1ZwyWif2oEtPjOnD+wCw6rShgNI9WpEm71ztMB5j6sDhIR1MZ5sCaXcWUM71WrLGt2
	 qTY+y3HCc8JRg==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 0338A1AC585D; Thu, 30 Apr 2026 05:36:16 +0100 (BST)
Date: Thu, 30 Apr 2026 13:36:16 +0900
From: Mark Brown <broonie@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: soc-topology: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <afLcQBJ4POnSacjV@sirena.co.uk>
References: <afKSFY3qrlSOJ0EJ@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rm/wZXL0pdXmZTTy"
Content-Disposition: inline
In-Reply-To: <afKSFY3qrlSOJ0EJ@kspp>
X-Cookie: 667:


--rm/wZXL0pdXmZTTy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 05:19:49PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.

> Use the __TRAILING_OVERLAP() helper to fix the following warning:
>=20
> sound/soc/soc-topology-test.c:136:38: warning: structure containing a fle=
xible array member is not at the end of another structure [-Wflex-array-mem=
ber-not-at-end]

Sashiko is complaining about this breaking some of the users:

   https://sashiko.dev/#/patchset/afKSFY3qrlSOJ0EJ%40kspp

I don't know enough to tell if that's actually a sensible report or not.

--rm/wZXL0pdXmZTTy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmny3EAACgkQJNaLcl1U
h9BcdQf7B2LyfhgJTqEFONNd2QkN7fyotJxQhasVPwLUNYsp1S4Auq4lonFumKva
ykhfS7z1Qb5tVzcq17z4k0sbLfenR6m6pc9Nz9m3vp+5DUW7+uXHCazxYnbv72ol
dkz92vv/zNs/ST4fCJms1xXXRhDqk3lYvNMs+rPWDCB1TJKNJj7sblyeQ6bOrTPJ
S7r78sSukLfZeEuuPhB9Pt3L6Wqe2dPdu+tYyAdKfZv6nPPC6FQ4TMpUvi2ENdk6
ryyLUiLf5tSxbl+P6avT7lFptIeNT/alS73q+hDXOa6cTyQnmfu0y0V3z+JVzdmU
PQ7u3n6Exx2CBLHXA9KsL4zzVkaOEw==
=NT4I
-----END PGP SIGNATURE-----

--rm/wZXL0pdXmZTTy--
