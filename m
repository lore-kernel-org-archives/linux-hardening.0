Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4EF49BD6D;
	Thu,  1 Oct 2026 21:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790889162; cv=none; b=n0sAwm0gzUC5FUWfuiBFsoVir6Jp15rlmKRiYKZ0L3mOgODUFdF641eXUeNw1aK81/8ZUGpGdIpouwQo/3XMsrFGHIrNYCMERECIKY2QFlFJ3n9VgA4HlDqVt+jis+B0U2T8uevXuv/sXhb6s33i4hRjJU41iXxZAPS6jjpO3M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790889162; c=relaxed/simple;
	bh=RDlxXsIVmSOW9EvSGpxVY3V9f1QX8L/coartXlMr17o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMJ7vihRLJo2a2TgALJ43rDP4sLfbWM+IxgLEspIk8lcZoHaiolAiXaID5WuUKjwzDnFL7IyCi3F+XE0czEdwBvmFxkQepASvUCWxMx5RhzL7xUeXrjhkuoHQqno7qmQH+lvFUQ1NF1yfYIIwV19C0Iv7R7y1Dqq1IY5dr95a1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNv4T5Ze; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNv4T5Ze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A931F000FF;
	Thu,  1 Oct 2026 21:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790889159;
	bh=yUe8foPO/YGnw6igCq/IGQXtyjmk4q2ZsCnNJOWDHC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XNv4T5ZetRF09dzG85bpGSDwZTvnZa/nRqbYsEeE9NBYClRVU21lmlJBRZrqX03Xy
	 /ehL+UDNqWZLA7aDzyHTIlsDzWvS4o1eU/n+fMpXMgMmp19AvzC0nfdz9V3ujGvhUT
	 KdhQzzDhZEkh6DDy/zdkh/EppA1/enHlEFcFb76aA004hMTJycE3l/axV6XdcoFpjF
	 ro7XLrFCO3Etsi5drAqHGudFDqR9aEDcaEPW8Uy/5FvJR5GVG0iBHc9zWrtNyogqiP
	 gzmKh37kXNFgx2gPM6o+dWfxWPg8BkSmCVD8poI9q+55Wi7wQ1Nz7DsRzL+swKILQM
	 uEXNiAGYXca+w==
Date: Thu, 1 Oct 2026 22:12:34 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: CL Wang <cl634@andestech.com>, Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	tim609@andestech.com, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: dmaengine: Add support for
 ATCDMAC300 DMA engine
Message-ID: <20261001-outdoors-gainfully-ff7902568cfd@spud>
References: <20261001014503.786490-1-cl634@andestech.com>
 <20261001014503.786490-2-cl634@andestech.com>
 <ar67FuFDeVQe0-wp@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IjTKwb2qVh0/lgHk"
Content-Disposition: inline
In-Reply-To: <ar67FuFDeVQe0-wp@lizhi-Precision-Tower-5810>

--IjTKwb2qVh0/lgHk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2026 at 03:57:10PM -0400, Frank Li wrote:
> On Thu, Oct 01, 2026 at 09:45:02AM +0800, CL Wang wrote:
> > Document devicetree bindings for Andes ATCDMAC300 DMA engine
> >
> > ATCDMAC300 is the IP name, which is embedded in AndesCore-based
> > platforms or SoCs such as AE350 and Qilai.
> >
> > Signed-off-by: CL Wang <cl634@andestech.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >
> > ---
> >   Changes for v7:
> >     - Rebase onto the current dmaengine/next; no changes from v6
> >
> >   Changes for v6:
> >     - Rebase onto dmaengine/next; no changes from v5
> >
> >   Changes for v5:
> >     - No changes from v4
> >
> >   Changes for v4:
> >     - Use items list format with descriptions for reg property
> >       as suggested by Conor Dooley
> >
> >   Changes for v3:
> >     - Rename DT binding file from andestech,qilai-dma.yaml to
> >       andestech,ae350-dma.yaml.
> >     - Deprecate IP-core-based compatible usage and align with
> >       SoC/platform-based strings.
> >     - Dropped Acked-by tag from Conor Dooley due to the above change.
> > ---
> >  .../bindings/dma/andestech,ae350-dma.yaml     | 67 +++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/andestech,ae3=
50-dma.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/dma/andestech,ae350-dma.=
yaml b/Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml
> > new file mode 100644
> > index 000000000000..f040a2bf7d4b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml
> > @@ -0,0 +1,67 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/dma/andestech,ae350-dma.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Andes ATCDMAC300 DMA Controller
> > +
> > +maintainers:
> > +  - CL Wang <cl634@andestech.com>
> > +
> > +allOf:
> > +  - $ref: dma-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - andestech,qilai-dma
> > +          - const: andestech,ae350-dma
> > +      - const: andestech,ae350-dma
> > +
> > +  reg:
> > +    minItems: 1
> > +    items:
> > +      - description: DMA controller register range
> > +      - description: cache control in IOCP controller
> > +
> > +  reg-names:
> > +    minItems: 1
> > +    items:
> > +      - const: dma
> > +      - const: iocp
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  "#dma-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - "#dma-cells"
> > +
> > +additionalProperties: false
>=20
> According to Documentation/devicetree/bindings/writing-bindings.rst
> ref to other yaml(ref: dma-controller.yaml)
>=20
> should use
> unevaluatedProperties: false

It's fine to use additionalProperties: false though, and is correct to
do IMO when the other properties being imported do not apply.

Thanks,
Conor.

--IjTKwb2qVh0/lgHk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCar7MwgAKCRB4tDGHoIJi
0qwzAQCFN1rL6Q89xuOcVB30GAlyjF1xcv6VODIfxy2W2V8g/QD6A+L/HEGbzpfM
jccMAdR6FCwY3WPK/AP9GDxJC2tQgwk=
=XlD3
-----END PGP SIGNATURE-----

--IjTKwb2qVh0/lgHk--
