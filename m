Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57B53F54C9;
	Wed,  6 May 2026 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778086248; cv=none; b=SAdlbkZDSZtrO1sR4cQH0SS4/Bk91rpQ+xL3FtcHvbWGM0m4041ZcwKmGw54V7Cy6rIDKxuFmEfgoDmwA+R5Js5yOOjOibcn4Zd8lkVOoV9cINKDiZ5VKNakw8a+b1xMrF+wPk7P8OdqR1aqg0k0IEAlQCmxfEriJDhfKhJJf4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778086248; c=relaxed/simple;
	bh=pOJDXd9BTWPHOrjma3w01gKJ9yQD8JR6DABPprD4juo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POmOFGwBzBPRHRigr2qRd9vlwLqpq1YBa8srLFe7sV/UfzJdOtd+Kwyo+dBlg9P4CQxMA268TNS6wcZpzKSEOODqL6jhv4Zkz6VURAhw0JLeAk/P78k6+HhlZ1Nlzvi9uW37Y0zp1xG8Z0z+KpR13vGpEO0xjKvHxZU5ve0JFmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYTUWoW3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYTUWoW3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24968C2BCB0;
	Wed,  6 May 2026 16:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778086248;
	bh=pOJDXd9BTWPHOrjma3w01gKJ9yQD8JR6DABPprD4juo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VYTUWoW3H5vCjUCgmrfCcJ/xz6rEsCUmILwoWgjoP2FHvtApH+1w3Vy/jxbLBst6R
	 akCmqailADl4hfXoVntaPUvLrq7AnApapbbgNOurAdHmoucg1zZ9uQDZz9PJBnzm7y
	 8imo50Li3WywN/NhjMuvwp3HxdNCc8p8GMmsNZosl7f/TyINq0pBcERAHSCKt1KnCc
	 Hepe+KOWvYHScz+5mq8pVtMJgjB+IsL0pQyRULt3atNtks0TVmegYWRMT9gQQBeY4T
	 IHerAaQxJVTV/TIiORWAe3XwExBQD+j7W9NL5s+BKeQOH7qLSv0G0GwOBnWEN7q1cl
	 P6mIWE3jq8Qkw==
Date: Wed, 6 May 2026 17:50:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Gregor Herburger <gregor.herburger@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>,
	Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: raspberrypi,bcm2835-firmware: Add
 bcm2712-firmware compatible
Message-ID: <20260506-unguided-duty-892b11b7c618@spud>
References: <20260506-rpi-otp-driver-v3-0-294602663695@linutronix.de>
 <20260506-rpi-otp-driver-v3-1-294602663695@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UAK+6adw4mTfXo2d"
Content-Disposition: inline
In-Reply-To: <20260506-rpi-otp-driver-v3-1-294602663695@linutronix.de>


--UAK+6adw4mTfXo2d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 06, 2026 at 02:28:15PM +0200, Gregor Herburger wrote:
> Add a compatible string for the bcm2712 firmware.
>=20
> Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
> ---
>  .../bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml      | 13 +++++++=
+++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm283=
5-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm=
2835-firmware.yaml
> index 983ea80eaec9..fbcfa2bc168a 100644
> --- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmw=
are.yaml
> +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmw=
are.yaml
> @@ -21,9 +21,16 @@ select:
> =20
>  properties:
>    compatible:
> -    items:
> -      - const: raspberrypi,bcm2835-firmware
> -      - const: simple-mfd
> +    oneOf:
> +      - items:
> +          - enum:
> +              - raspberrypi,bcm2712-firmware
> +              - raspberrypi,bcm2835-firmware
> +          - const: simple-mfd
> +      - items:
> +          - const: raspberrypi,bcm2712-firmware
> +          - const: raspberrypi,bcm2835-firmware
> +          - const: simple-mfd

This diff doesn't make sense, either the new firmware is compatible with
the old one or it is not. It shouldn't appear twice.

pw-bot: changes-requested

Cheers,
Conor.

> =20
>    mboxes:
>      maxItems: 1
>=20
> --=20
> 2.47.3
>=20

--UAK+6adw4mTfXo2d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaftxYgAKCRB4tDGHoIJi
0sjZAP4qTF2TnlozstYloQhMzmmjOpygViy+wQxmE1B/ZrNgHwEAxV3cIWEz1ig7
ohLMbJt8aoOkyiAMSEZJajxAUxfmfwg=
=bVxd
-----END PGP SIGNATURE-----

--UAK+6adw4mTfXo2d--
