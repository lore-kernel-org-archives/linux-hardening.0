Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0621B29D
	for <linux-hardening@vger.kernel.org>; Wed,  4 Oct 2023 19:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOsLsmCH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A5BC433C7;
	Wed,  4 Oct 2023 19:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696448404;
	bh=FlsaevMEj2RSWwYmDVDwqSBRXP3iR8ph2Wyz+A1kh6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pOsLsmCHyEqNfe5KySvFctctkD4pd0SklEWoLKwtS2TGXNYHWnM24vd8N0uwuMBJv
	 6pro430mVYoVMCCb9wmh/DXcdItJSy8tBlLSYBqCMcigkWVQE5pXeXEn0kVaiOUz2l
	 BQ3/+WIU7kb2HlVocjvOZGD+R5oLH7YdfUWASoOXqAeNN5cSU0UxFlJrNRvAbit4wk
	 /i8jiNusXW7xLKxfjXUE6oMHRegvv39Z3b1OXXvpPpsmKnCHp6JdaNoOcaBc7OHZil
	 Q7jj4X2gc4dwiBiEvnW0jc2y9xoZGctBVIE5VI3EzALZjPsn4kV1IKTgNulNr2vWi3
	 BBPqrKXeivBYQ==
Date: Wed, 4 Oct 2023 20:40:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Include additional ASoC paths
Message-ID: <f258a7e6-0728-4f55-a71a-6e99113ce7e5@sirena.org.uk>
References: <20231004193441.work.109-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8QQHSDF6ypZtF4tt"
Content-Disposition: inline
In-Reply-To: <20231004193441.work.109-kees@kernel.org>
X-Cookie: This space intentionally left blank.


--8QQHSDF6ypZtF4tt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 04, 2023 at 12:34:45PM -0700, Kees Cook wrote:

> +++ b/MAINTAINERS
> @@ -20116,6 +20116,8 @@ F:	Documentation/devicetree/bindings/sound/
>  F:	Documentation/sound/soc/
>  F:	include/dt-bindings/sound/
>  F:	include/sound/soc*
> +F:	include/sound/sof/
> +F:	include/uapi/sound/asoc.h
>  F:	sound/soc/

The SOF header is also missing from the entry for SOF.

--8QQHSDF6ypZtF4tt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUdv48ACgkQJNaLcl1U
h9DDygf+JdiGJ8HYN9ucxA5Qvg+1jQsKP68oVMfoAYPDsXQ175C2gXEwiwypNkM2
Qj0l77i+ILIV54dZc9PBy32hmHgTtFcgoP78BGGQNVY+BQe+8rN3IWfsegG157i6
xiUSqqlGTs3Syxp2v7KTNdf3QJb43PL2Ofdxfy1JvhStZxX4xqSnYkkdLIJoClsr
edJVuq1n1S7a09uvZc1SqvQo4Z5sT2lfLNk5/DIPXdPkVUgr4cfARkPNNWYss3o1
z8f/M3naQ1u0Sc1Q+H/qiCnbHa5vVbrnjOV6ptbTeBx9Iuf1W6XPA7IraruLE9Ev
a69/R8wKeotb4Z/eg7Q5S+gAfTkf8Q==
=f8m5
-----END PGP SIGNATURE-----

--8QQHSDF6ypZtF4tt--
