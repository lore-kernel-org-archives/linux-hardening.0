Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEAF252912
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 21:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757712206; cv=none; b=YdUS1KjGKAL85ME+Mu0q7LvGvHKiM7fL7HdhQS0DA9fYmQjzRtmStFpvh3sUC3Bb4wpOs+/2M5TCtSe1sKoo4lBnnFnAzTXx9rHtAqorhR1PvtNYxQsHOLCHPqLPYH3Lmw2jjywa9t4t/Nv8JyEMd7KYZRmECtcsWZJZSXxJSeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757712206; c=relaxed/simple;
	bh=2Dy+AFZSBBqREYyrzTNCKYakhdJ/6yZjpcuiom9UX0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtTiEr/42c0TFcUDUd1MLGGXgpWKx7xAlWHaxeXd3mvR8my+0of5NQdLuztPgld0ArRZAfZ95xE81qQxxE7u5LO4Clu1p28XsBzJLnYXpuqCmAEMUwgu7nPzNac2vpB3Q99QIhMYYDz8z89CWyNzwgn3oImYkg37VLCLyTjBZUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6TF3bGU; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6TF3bGU"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6296f6ce5ddso464283d50.3
        for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 14:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757712203; x=1758317003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RS6dsPYFszHuSjK7qI4StyWMs+p9b5Aa8Uii6eXeOJk=;
        b=Q6TF3bGUAtqvwBRQYp8pCDo4ggzPcRCcV5Hc1uKhmbynjdiSpZzw7XoU1r7xVuwHzh
         79C0v+bL7B9WhfmWPl0CJUXyMOmEnWXUnpFaDBh7Ft2i+byh/sWqKsnGyXZcco8TxM6J
         89QqCSbBBFkyrvW3eumEbr/FuOK4J1K6r7i1r4odwIXNO7Gf0FXHmhJFG91fawRT5DV3
         k7E/n8cBIvtxfG6atrtx2lSww1wCHYjYVMsJq7nPxFVMKW78owW19FR7V0NxzQ9TySRI
         D49diUT1p3CCYLFJOFGkQbJ1B4XaiAXg6uz1OBROrEEqdKoXY6bZ4XNsGd829lwShhI6
         M0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757712203; x=1758317003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RS6dsPYFszHuSjK7qI4StyWMs+p9b5Aa8Uii6eXeOJk=;
        b=Vy8JI77jibdGS3KGFsL5gg84tGZ2uKHv3MOeJ3AGe59aPqs81hkQ+G91hheHSGP+9s
         bDp9D/Q9SDy+4mNyvDM3gBnji2DJ7iDuG+RT9Dz+Akt+ud3oC74T9OFC4EyDoEG6+6q0
         bnHdr4AZGBr/FwcyZyw4Y0+HDiMJDPeuOlL8cJOxSViz8d07CmYOT1VYjXA47yKuWnt1
         1a5ZFdyAdxEo9mXl4mHkGAoTKSScpT3wZoyrqXfoKjyYn6J+N5KLtzHjWhANGhfMpHG1
         RgbezvRpOEgy7tcks4STRn9KUfEwtJtTAOv27TipnGKLjEyQSl5/KizbEtlbhW0aemz+
         7IZg==
X-Forwarded-Encrypted: i=1; AJvYcCVJQO7ZKuIKoXHNFvi+1RbLMlKSYEgLjnozrBfuttceJtuNOQ48EsXOm5erWuqTLptAEB8k581stRCHye/bs8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0sfm+82LajvNyN6ei5xviV7CQE9130JEKvUe880OJM9aE4N4P
	Sxa2KmN9nu9k1RLJ4g75ZjwZhfRImY6HVVKSrN+boXK4LGUWiF6ftlr7620AGxf/gAji8cqjyXg
	dAWwzT42+WlcYr4f9yND828bnAtgaC60=
X-Gm-Gg: ASbGnctDTWGzOiRFVhM5vgE5pa8yHqbf39IfE45n75heJQNnCYgxQf02p+29JqsSXlk
	mUMCkhebKOBPEyyy+dQsUt5GRFUmelAR4EZrvxqrCosei+PfiBP8eHClQ0F/WBm6/DYE9dCt26A
	2J5mhO6AISpv9laKhNj+KOJGgsLqWb1gGiPzcMayr3pI6M54gL8EwHIbygXWk3ndfMkGBTJDhHB
	tHvtaZeJaBSBFDrA6St7ce07ShLT9CfQKgM1i3NV0+mhT8yuPXvRGYBZYix0GIekOVJ2vUBnm61
	7V3FIMk=
X-Google-Smtp-Source: AGHT+IF7mDTFFlP90HyM2PZ2wkzJy8r0oa/XBSPUCOPlO84anhWl4cv9qCVo9H3l//gvGB0W4EvLmw5CX6m3/WXwn74=
X-Received: by 2002:a53:d6c8:0:b0:5f3:317c:cba3 with SMTP id
 956f58d0204a3-627235eb229mr3125344d50.36.1757712203491; Fri, 12 Sep 2025
 14:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912-mt8196-gpufreq-v2-0-779a8a3729d9@collabora.com> <20250912-mt8196-gpufreq-v2-1-779a8a3729d9@collabora.com>
In-Reply-To: <20250912-mt8196-gpufreq-v2-1-779a8a3729d9@collabora.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Fri, 12 Sep 2025 14:23:12 -0700
X-Gm-Features: AS18NWAF1_rOqs1uHHRFV3uK_QeI_BESdlTq94oWPQCIUjh-7p1xsAHQtKCd0Gw
Message-ID: <CAPaKu7SnopwdGpzZYNQ0GaQmHzL7ES7ZD5sOPPBUMiznXiA+8Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] dt-bindings: gpu: mali-valhall-csf: add
 mediatek,mt8196-mali variant
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 11:38=E2=80=AFAM Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> The Mali-based GPU on the MediaTek MT8196 SoC uses a separate MCU to
> control the power and frequency of the GPU.
>
> It lets us omit the OPP tables from the device tree, as those can now be
> enumerated at runtime from the MCU.
>
> Add the mediatek,mt8196-mali compatible, and a performance-domains
> property which points to the MCU's device tree node in this case. It's
> required on mt8196 devices.
>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  .../bindings/gpu/arm,mali-valhall-csf.yaml         | 32 ++++++++++++++++=
+++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.y=
aml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> index a5b4e00217587c5d1f889094e2fff7b76e6148eb..163b4457f7f25dcdd509c5585=
58a73694521c96d 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> @@ -19,6 +19,7 @@ properties:
>        - items:
>            - enum:
>                - rockchip,rk3588-mali
> +              - mediatek,mt8196-mali
>            - const: arm,mali-valhall-csf   # Mali Valhall GPU model/revis=
ion is fully discoverable
>
>    reg:
> @@ -53,6 +54,9 @@ properties:
>    opp-table:
>      type: object
>
> +  performance-domains:
> +    maxItems: 1
> +
>    power-domains:
>      minItems: 1
>      maxItems: 5
> @@ -91,7 +95,6 @@ required:
>    - interrupts
>    - interrupt-names
>    - clocks
> -  - mali-supply
>
>  additionalProperties: false
>
> @@ -105,9 +108,24 @@ allOf:
>        properties:
>          clocks:
>            minItems: 3
> +        performance-domains: false
>          power-domains:
>            maxItems: 1
>          power-domain-names: false
> +      required:
> +        - mali-supply
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8196-mali
> +    then:
> +      properties:
> +        mali-supply: false
> +        sram-supply: false
> +        operating-points-v2: false
> +      required:
> +        - performance-domains
>
>  examples:
>    - |
> @@ -143,5 +161,17 @@ examples:
>              };
>          };
>      };
> +  - |
> +    gpu@48000000 {
> +        compatible =3D "mediatek,mt8196-mali", "arm,mali-valhall-csf";
> +        reg =3D <0x48000000 0x480000>;
> +        clocks =3D <&mfgpll 0>;
This seems to be an input to the performance domain, not to the gpu.
The rule says

  clocks:
    minItems: 1
  power-domains:
    minItems: 1

but neither is needed on mt8196. Should we set both to 0 (and update
panthor to treat core clock as optional)?

> +        clock-names =3D "core";
> +        interrupts =3D <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH 0>,
> +                     <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH 0>,
> +                     <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH 0>;
> +        interrupt-names =3D "job", "mmu", "gpu";
> +        performance-domains =3D <&gpufreq>;
> +    };
>
>  ...
>
> --
> 2.51.0
>
