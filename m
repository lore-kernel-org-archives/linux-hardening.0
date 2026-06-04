Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FC741B343
	for <linux-hardening@vger.kernel.org>; Thu,  4 Jun 2026 11:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572201; cv=pass; b=Q70ir/y2QsXCkpfjP/Vv88sv+Zv+VUu6/xprQwL5v1b9fBKIYr//+VYVTYEOJfpnJYuksbqNJUqz+Q6VO92jmFJaHtdo+5dPHoj7nQFRN5533QBpzzSYEwIAA2TbouDmGt/Ccyceygrl2jRG//4JxSOoHraGKF7mlOXwJaP4Z90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572201; c=relaxed/simple;
	bh=G9nFh7v8j7acwr3OyC0fVYembfzlnZt3C5JR+74mpZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q7B2rNmMVFAJC1Q9fZ/2LLP8WebTJ9l8zXsvDfERevcm1uU27WrsdqI90wWr5kjijFxkP8afm98yDTeB8/8vmbE65y34KPRQh5RPESp/SWspSwNeVuQ/mOPjgH9rzhWNsfgykRWn2IULedAa6BIgU+1whRbTq/Re4q1wDgGXRtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dvx6AsfG; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dvx6AsfG"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-68c32f3c6d6so574116a12.3
        for <linux-hardening@vger.kernel.org>; Thu, 04 Jun 2026 04:23:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780572198; cv=none;
        d=google.com; s=arc-20240605;
        b=kcvmsZitNQEtgUAag2CXt/DYx1gylMITPXSYspcIZPzergVWVTDk5WqtiKrTNeBy4v
         V4/PdSCTkEbjzWw3rruOAulKKtgyXspeIrzZFKmHDdJH7xJja4URDoFQWdqw3wCNxIZr
         mjv2t9GF1pGedDFoE/HqH6tYwaXxSUU04zZHfIFpBBShto1jwutqMwQNfTUAMEDslF+k
         HTzQbxQi7Vwitf5tzSzZwJmWiSO24qeGXpRdcvT+9yBb6LExANdEPp5mRHyNo/VHp2o+
         aWLN6mnZJON1x6hU6drAGQzEAXyRoH9s1gH1EFFGy4VojIK2Soxzc9DjAUsJJaKAxWq6
         8jCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zSZAPul0pXkxx09T12pErJ7HwDU4RDxf16+6acHgaAM=;
        fh=NSjthNrpgLacnPKEZtSwcyQqLqp9Jy64pQA49rd4ASk=;
        b=Qj6jc6Y9MyZOSfjhAJ/v6ot69pYgX45yblr5hSipEk0YyjplXZ/CkyiU02T4Wb+ce7
         EoH09YbvsJtyNYouWRjATa4IGK3RuYvHhkDr4p2JTbB90auaYksrE34Mu/OZsq82tHVQ
         P9ZqoyV+n452Wy4zGLmnwUqgWSe2QCUDq8cSOupWtBUxWGqMwvfEbQYbWDe/oRmyTq1h
         AbCZQF3fa5fNXnvAuBcX+qmy7Kk5fE9fCBR+ryUGQgZzMs/++TBv3KuReD7bySPb7YXK
         VSUB5vhlpwwE4M+c49kTzOACoCFjA6IYLV+jdc0R2s0+FhXoLv2n/EF8zr99jE+1EdvA
         IPiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780572198; x=1781176998; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zSZAPul0pXkxx09T12pErJ7HwDU4RDxf16+6acHgaAM=;
        b=Dvx6AsfGD02bweAo0ZEINt0kOaCQzPJ1S2+optCdZlXmIr23h/q3YrAsWtupnJ7l45
         c98RGB5NER11WyEenOQEJiqhh0Iy88ubfgMHy7ZCJvzG2v1t15JKlK6T9311q8noIq+t
         CIZFHD1fklBLj0B/CUVGk6CwALZ5FSxxbvzILufg+xELUDVYcg7x8Dzt4jUQgXPvImP0
         asnJzap0HrzweOPVSCBiRJoqC/iBCnwf872TLf/em3etyORjPOjuF6gZ+HpaBwCgLQoX
         tRYik6X8LflxAyu8m7Z91oJSEuFcJ5WhN2i2BEU/P/RNYSQjh2eEM0nx19hgLjtmepPp
         Xv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780572198; x=1781176998;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSZAPul0pXkxx09T12pErJ7HwDU4RDxf16+6acHgaAM=;
        b=Y88XZasi5LfxEWAytw2uH/BjUzEjuXk5qC0wOj9GpXE1zT0gPikv7iE9xLWdtINHnk
         Zcm0oBaKkhIjPL91RIHmQeVXwdgdN0QsjMrW2mgXGI0BmQUPh/vCl1MGwtEUCZ0VZzV+
         sqYtxE7ZCKt1z57XVWYjrrPw0kFlGJD3Kvaqxw3/wYqt2nOm4TbLKIhyiFxseu1Yg3/f
         MEqSv2zE0bEnP5cOvodOEYmwaAWi0/HUDhCEy6cmN+FVF/pOBfFZ5lAeYiIw/ceMVRXL
         EGMgnT0xnDD64qPmsA8iAvfsA10lGuLR83wSnC1dUCEEjfDdlVMdFOpaXlWh30dA/Phs
         q5nA==
X-Forwarded-Encrypted: i=1; AFNElJ+tco5Wiqqq3UnQfDjwXkc4zYx1Fppuv7rjQktWppyhr72sRGiss48zGhCqubTg7jQk3uPqvAs1mV4YhG6rjyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1qHkHa3hX9FELwA3zy7YacZJnKpkIF9iL0jZtV1g2SidMmND4
	ucwLeh7N9eWHyL+nwCvJvS0Aoy1itpd8y1/mrIa5xthdV3NL5j/UJAfpwRAm0AreYzJII+Bbt7g
	yE2zh+J2KfcwVYSyIk9HPtOt3POc1uFRzAHG3AbY7Cg==
X-Gm-Gg: Acq92OFjtZoHtHu0OShUHwCZcbXNsR8K38HO1y1CiVjmqf/Ey2pgGxzcrxTp2p4tbC7
	Oe0XKnuQuhb93O3ZduQtnO58CiFzNfCqIMjDWv5GB3BTBGYArn28Ap0L+eqt0gBM5DG4Mf+lZrE
	9IODtbOF5S3sQPLRC3EnqqGZLLEjUwhN/ZpvhRkVt5itoRV4RMZyCx1/W2DBTRSJdpsdwemjHVh
	abapp98p2ZWEVEM4vqt2XreHKCVHleoCl5rkIotmK6EBSSzzEA+B8iUe86xRC6/t6KKrdSWYnyw
	c1wm+4YUcU+1HD24GH9fMUx2ued2u0BYn8OGjw/6ugrRF6/Q
X-Received: by 2002:a05:6402:3215:b0:68b:539c:d269 with SMTP id
 4fb4d7f45d1cf-68e710ebc51mr4043117a12.12.1780572197841; Thu, 04 Jun 2026
 04:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org> <20260603-acpm-tmu-v8-1-0f1810a356e6@linaro.org>
In-Reply-To: <20260603-acpm-tmu-v8-1-0f1810a356e6@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 4 Jun 2026 12:23:06 +0100
X-Gm-Features: AVHnY4Ia0mw8gm7Hj0ZlJv6TfIxLHonorNGMBp2ITPuIwQPM__6LAPjP3GLorns
Message-ID: <CADrjBPqhrnMv0xoMK+K=rMmd9jKAHYqFkn6y7EKoqm=i9o656A@mail.gmail.com>
Subject: Re: [PATCH v8 1/5] dt-bindings: thermal: Add Google GS101 TMU
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, jyescas@google.com, linux-kernel@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jun 2026 at 14:00, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
> Document the Thermal Management Unit (TMU) found on the Google GS101 SoC.
>
> The GS101 TMU utilizes a hybrid control model shared between the
> Application Processor (AP) and the ACPM (Alive Clock and Power Manager)
> firmware. This hybrid ACPM TMU architecture is also present on other
> Samsung Exynos SoCs (e.g., AutoV920, Exynos850).
>
> While the TMU is a standard memory-mapped IP block, on this platform
> the AP's direct register access is restricted to the interrupt pending
> (INTPEND) registers for event identification. High-level functional
> tasks, such as sensor initialization, threshold programming, and
> temperature reads, are delegated to the ACPM firmware.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

>  .../bindings/thermal/google,gs101-tmu-top.yaml     | 69 ++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml b/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
> new file mode 100644
> index 000000000000..75560ebca48d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/google,gs101-tmu-top.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung Exynos ACPM Thermal Management Unit (TMU)
> +
> +maintainers:
> +  - Tudor Ambarus <tudor.ambarus@linaro.org>
> +
> +description:
> +  The Samsung Exynos ACPM TMU is a thermal sensor block found on Exynos
> +  based platforms (such as Google GS101 and Exynos850). It supports
> +  both direct register-level access and firmware-mediated management
> +  via the ACPM (Alive Clock and Power Manager) firmware.
> +
> +  On these platforms, the hardware is managed in a hybrid fashion. The
> +  Application Processor (AP) maintains direct memory-mapped access
> +  exclusively to the interrupt pending registers to identify thermal
> +  events. All other functional aspects - including sensor
> +  initialization, threshold configuration, and temperature acquisition
> +  - are handled by the ACPM firmware. The AP coordinates these
> +  operations through the ACPM IPC protocol.
> +
> +properties:
> +  compatible:
> +    const: google,gs101-tmu-top
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: APB peripheral clock (PCLK) for TMU register access.
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#thermal-sensor-cells":
> +    const: 1
> +
> +  samsung,acpm-ipc:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle to the ACPM IPC node.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +  - "#thermal-sensor-cells"
> +  - samsung,acpm-ipc
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/google,gs101.h>
> +
> +    thermal-sensor@100a0000 {
> +        compatible = "google,gs101-tmu-top";
> +        reg = <0x100a0000 0x800>;
> +        clocks = <&cmu_misc CLK_GOUT_MISC_TMU_TOP_PCLK>;
> +        interrupts = <GIC_SPI 769 IRQ_TYPE_LEVEL_HIGH 0>;
> +        #thermal-sensor-cells = <1>;
> +        samsung,acpm-ipc = <&acpm_ipc>;
> +    };
>
> --
> 2.54.0.1013.g208068f2d8-goog
>
