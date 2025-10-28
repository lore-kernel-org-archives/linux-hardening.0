Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D10D28DB56
	for <linux-hardening@vger.kernel.org>; Tue, 28 Oct 2025 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671586; cv=none; b=H0LwqD9kp66grxLfcid/FtMwK+CosHWVi3/9ymoTAQWUfyJqyBtDVwf+q4sAalZ3zZzNPq3ont/4RKM7/n9dHZgAaT60HUf3QUnPOdQI1qSyxeJ7qAdKGrtkpHnz9keMEOuLlkLxuRf/ohBwmH399691NzZJd0xVxrt2Y+K1MSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671586; c=relaxed/simple;
	bh=PRqV0NiMm5h805OFFkFFy8tFBxkOLM7y4i7v5n8aeXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9K0PYbx90IrT1YRoN3G3AYrfWFnIacgQSLQ1UWZMvBaqMXnEXQKFAhpYd/HjVgc8UFIuqWNw0hrmStPHio7ETuVPgV5Vqq+J2+8k9YeqR9LkUPy2lZ9LJowLKLbye5P5GUznmF9XHooY9TBUDju2pWwMe1Fa1eW1S+YP7tzO/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6CB526BA
	for <linux-hardening@vger.kernel.org>; Tue, 28 Oct 2025 10:12:56 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4D2783F673
	for <linux-hardening@vger.kernel.org>; Tue, 28 Oct 2025 10:13:04 -0700 (PDT)
Date: Tue, 28 Oct 2025 17:12:35 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, kernel@collabora.com,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v8 1/5] dt-bindings: gpu: mali-valhall-csf: add
 mediatek,mt8196-mali variant
Message-ID: <aQD5gwByEmX6GQK9@e110455-lin.cambridge.arm.com>
References: <20251017-mt8196-gpufreq-v8-0-98fc1cc566a1@collabora.com>
 <20251017-mt8196-gpufreq-v8-1-98fc1cc566a1@collabora.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251017-mt8196-gpufreq-v8-1-98fc1cc566a1@collabora.com>

On Fri, Oct 17, 2025 at 05:31:08PM +0200, Nicolas Frattaroli wrote:
> The Mali-based GPU on the MediaTek MT8196 SoC uses a separate MCU to
> control the power and frequency of the GPU. This is modelled as a power
> domain and clock provider.
> 
> It lets us omit the OPP tables from the device tree, as those can now be
> enumerated at runtime from the MCU.
> 
> Add the necessary schema logic to handle what this SoC expects in terms
> of clocks and power-domains.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  .../bindings/gpu/arm,mali-valhall-csf.yaml         | 37 +++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> index 613040fdb444..860691ce985e 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> @@ -45,7 +45,9 @@ properties:
>      minItems: 1
>      items:
>        - const: core
> -      - const: coregroup
> +      - enum:
> +          - coregroup
> +          - stacks
>        - const: stacks

I'm not sure how to parse this part of the change. We're overwriting the property
for mt8196-mali anyway so why do we need this? And if we do, should 'stacks'
still remain as a const?

Best regards,
Liviu

>  
>    mali-supply: true
> @@ -110,6 +112,27 @@ allOf:
>          power-domain-names: false
>        required:
>          - mali-supply
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
> +        power-domains:
> +          maxItems: 1
> +        power-domain-names: false
> +        clocks:
> +          maxItems: 2
> +        clock-names:
> +          items:
> +            - const: core
> +            - const: stacks
> +      required:
> +        - power-domains
>  
>  examples:
>    - |
> @@ -145,5 +168,17 @@ examples:
>              };
>          };
>      };
> +  - |
> +    gpu@48000000 {
> +        compatible = "mediatek,mt8196-mali", "arm,mali-valhall-csf";
> +        reg = <0x48000000 0x480000>;
> +        clocks = <&gpufreq 0>, <&gpufreq 1>;
> +        clock-names = "core", "stacks";
> +        interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH 0>,
> +                     <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH 0>,
> +                     <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH 0>;
> +        interrupt-names = "job", "mmu", "gpu";
> +        power-domains = <&gpufreq>;
> +    };
>  
>  ...
> 
> -- 
> 2.51.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
