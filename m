Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEFF101F8;
	Sun, 22 Oct 2023 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXFCTW+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E28CC433C8;
	Sun, 22 Oct 2023 17:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697996552;
	bh=8Qdm0gg88DXMuTW75MUA5nt2kvFjQcDIwf1BZu94NMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TXFCTW+x6DRjB5QfESnhaZX5JIRDgKu7B5vjQ5SZAF+GuwcKM0DzdQo1m3JlkxxmX
	 i56ELhpHzThW8PZVxe2KND93rpGgK3HovE84ckI7PxpwN0a1Gh51zipCsIQEcGiSCy
	 jlja9EXapC9WXkWFYHTFXwtW+5kLgfiLJ5St5I1TzZegMkNZ/J++yrBpcYhkHzBFyg
	 /MsFTgqO0pHgeohZc/R5+l5/1JUB24J2N8RVETWhMiwy9N6w1aU1TfU6XFWW9Z4068
	 cju3nEbsm3WRnRhNlt6fgOdK472/dkVGdgxUnrS2Thg7TOP5jKCv2l+u9yJkgtz2sJ
	 Hn9uCUQPKHBrg==
Date: Sun, 22 Oct 2023 18:42:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Luka Panio <lukapanio@gmail.com>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: arm: qcom: Add Xiaomi Pad 6
 (xiaomi-pipa)
Message-ID: <20231022-emoticon-expose-633cf6b49084@spud>
References: <20231022173811.8229-1-lukapanio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RzQibzrfM2gURrtv"
Content-Disposition: inline
In-Reply-To: <20231022173811.8229-1-lukapanio@gmail.com>


--RzQibzrfM2gURrtv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 22, 2023 at 07:38:10PM +0200, Luka Panio wrote:
> Add a compatible for Xiaomi Pad 6.
>=20
> Signed-off-by: Luka Panio <lukapanio@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks
Conor.

>=20
> ---
> v2:
> Update commit message
>=20
> v3:
> Update commit message
>=20
> v4:
> Update commit message
>=20
> v5:
> Update commit message
>=20
> v6:
> Update commit message
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentat=
ion/devicetree/bindings/arm/qcom.yaml
> index adbfaea32343..1bfae1b237d2 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -965,6 +965,7 @@ properties:
>                - sony,pdx203-generic
>                - sony,pdx206-generic
>                - xiaomi,elish
> +              - xiaomi,pipa
>            - const: qcom,sm8250
> =20
>        - items:
> --=20
> 2.42.0
>=20

--RzQibzrfM2gURrtv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTVfAgAKCRB4tDGHoIJi
0kuxAP4mtkT5Q+P0m2U1DiEmGo6MosxrP5CaBWxM1kzVLTSL7QEA5JvSO53XY5yj
lZH2701UcOQYiqwYjAIhRKf+MU2HkA4=
=8bYP
-----END PGP SIGNATURE-----

--RzQibzrfM2gURrtv--
