Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59234C0015E
	for <linux-hardening@archiver.kernel.org>; Sat, 22 Jul 2023 09:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjGVJZt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 22 Jul 2023 05:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjGVJZs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 22 Jul 2023 05:25:48 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F682D7F
        for <linux-hardening@vger.kernel.org>; Sat, 22 Jul 2023 02:25:45 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e6113437cso3630001a12.2
        for <linux-hardening@vger.kernel.org>; Sat, 22 Jul 2023 02:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690017944; x=1690622744;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ny814m9gzq+Ob9vj2yLBGuOvxN+pshyDPV5HjC/GEAk=;
        b=NVo7nwO3gE/bJodg4uEVVkqgSBQp0dAI/Wv5nmuSrPOJhED358gZ/3mIu2vFOAqEmm
         PnWC/EspHvBd20sgweZmuiYA+H4PIRZufN4fWED4QomiMiLWmm0hp3Ghx16d061qpRP7
         EzOvpFrUlpvPtI2bSiknnI6QQ1S9hlJKntCSPxK/CmT6O5hA0MtckZSgpOeSPW7LRHl2
         xHlwImk/g3jG+QZ7Up1bajMFwRqao1bQxkMNpKo28sx3MvCmFNEKm2kXdcnbcZxtnQpa
         PmHxYJQNCFqiT+lW6pdfIFdNf9EGuoeisFmDlx6wJGNiylCBTCHQ/ryQ5VOg3Tabkt7F
         G0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690017944; x=1690622744;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ny814m9gzq+Ob9vj2yLBGuOvxN+pshyDPV5HjC/GEAk=;
        b=U6FU0JHsNLdb46fAnSfhFIPz/y+x0tinZDPcIh8DzG+TnoVRJMoNw5r8CrB1HtQjR6
         cN+Njafd2zli+qSxgtyo7hNhdFA7saUqxW4jPweCYagoINPg4mJ19KvAqHRv+y1m/5ri
         Op9kGtuOoXjxRn3OK/NptfNNg06WtiC6NqaGyOIvyfXIGaYlsat1wq3pwk6ntfmhvnng
         QYtXQNvksVvqFHFz+ooy7MpkWRoayAEIG+M65E4MR+W2gck6Wwae/ZTVRHcdfSLiZBuq
         glV1b3RSonVnkRyjvl+JzkM3iCdndkEY2PIBdNV9mCoNQjgGIBBKzd45wUrHm2Kl9WZG
         g0Yg==
X-Gm-Message-State: ABy/qLbjgU58C5/kPuygTkBx+sJQCbQEVTnkugSaOwOsfNq/hnArdBCQ
        rBHsfUvnITh15UGQVrsKZkcg9w==
X-Google-Smtp-Source: APBJJlFw9zZYX/873W0uin+HNe+VGWU45JIV0csnyr/Iwd3oCwewenuXTxL/NjbssP4+UL8o+MXLXg==
X-Received: by 2002:a05:6402:2da:b0:51d:a488:3b3d with SMTP id b26-20020a05640202da00b0051da4883b3dmr3288580edx.35.1690017944148;
        Sat, 22 Jul 2023 02:25:44 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id b25-20020aa7d499000000b0050bc4eb9846sm3163598edr.1.2023.07.22.02.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jul 2023 02:25:43 -0700 (PDT)
Message-ID: <e4024f81-2d05-f02c-020c-e0a83f9fc68c@linaro.org>
Date:   Sat, 22 Jul 2023 11:25:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 08/10] arm64: dts: Add DTS for Marvell PXA1908 and
 samsung,coreprimevelte
Content-Language: en-US
To:     =?UTF-8?Q?Duje_Mihanovi=c4=87?= <duje.mihanovic@skole.hr>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.com
References: <20230721210042.21535-1-duje.mihanovic@skole.hr>
 <20230721210042.21535-9-duje.mihanovic@skole.hr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230721210042.21535-9-duje.mihanovic@skole.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 21/07/2023 22:37, Duje Mihanović wrote:
> Add DTS for Marvell PXA1908 SoC and Samsung Galaxy Core Prime Value
> Edition LTE, a smartphone based on said SoC.
> 
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
> ---
>  arch/arm64/boot/dts/marvell/Makefile          |   1 +
>  .../pxa1908-samsung-coreprimevelte.dts        | 321 ++++++++++++++++++
>  arch/arm64/boot/dts/marvell/pxa1908.dtsi      | 298 ++++++++++++++++
>  3 files changed, 620 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/marvell/pxa1908-samsung-coreprimevelte.dts
>  create mode 100644 arch/arm64/boot/dts/marvell/pxa1908.dtsi
> 
> diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
> index 79ac09b58a89..0e277a0d368b 100644
> --- a/arch/arm64/boot/dts/marvell/Makefile
> +++ b/arch/arm64/boot/dts/marvell/Makefile
> @@ -27,3 +27,4 @@ dtb-$(CONFIG_ARCH_MVEBU) += cn9132-db-B.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += cn9130-crb-A.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += cn9130-crb-B.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += ac5-98dx35xx-rd.dtb
> +dtb-$(CONFIG_ARCH_MMP) += pxa1908-samsung-coreprimevelte.dtb
> diff --git a/arch/arm64/boot/dts/marvell/pxa1908-samsung-coreprimevelte.dts b/arch/arm64/boot/dts/marvell/pxa1908-samsung-coreprimevelte.dts
> new file mode 100644
> index 000000000000..3e10a77a106e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/marvell/pxa1908-samsung-coreprimevelte.dts
> @@ -0,0 +1,321 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include "pxa1908.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/linux-event-codes.h>
> +
> +/ {
> +	pxa,rev-id = <3928 2>;

Drop. This is not documented.

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).


> +	model = "Samsung Galaxy Core Prime VE LTE";
> +	compatible = "samsung,coreprimevelte", "marvell,pxa1908";

Missing bindings.

> +
> +	/* Bootloader fills this in */
> +	memory {
> +		device_type = "memory";
> +		reg = <0 0 0 0>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		framebuffer@17000000 {
> +			reg = <0 0x17000000 0 0x1800000>;
> +			no-map;
> +		};
> +
> +		gpu@9000000 {
> +			reg = <0 0x9000000 0 0x1000000>;
> +		};
> +
> +		/* Communications processor, aka modem */
> +		cp@3000000 {
> +			reg = <0 0x3000000 0 0x5000000>;
> +		};
> +
> +		cm3@a000000 {
> +			reg = <0 0xa000000 0 0x80000>;
> +		};
> +
> +		seclog@8000000 {
> +			reg = <0 0x8000000 0 0x100000>;
> +		};
> +
> +		ramoops@8100000 {
> +			compatible = "ramoops";
> +			reg = <0 0x8100000 0 0x40000>;
> +			record-size = <0x8000>;
> +			console-size = <0x20000>;
> +			max-reason = <5>;
> +		};
> +	};
> +
> +	fb0: framebuffer@17177000 {
> +		compatible = "simple-framebuffer";
> +		reg = <0 0x17177000 0 (480 * 800 * 4)>;
> +		width = <480>;
> +		height = <800>;
> +		stride = <(480 * 4)>;
> +		format = "a8r8g8b8";
> +	};
> +
> +	muic-i2c {
> +		compatible = "i2c-gpio";
> +		sda-gpios = <&gpio 30 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +		scl-gpios = <&gpio 29 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +		i2c-gpio,delay-us = <3>;
> +		i2c-gpio,timeout-ms = <100>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&muic_i2c_pins>;
> +
> +		muic: extcon@14 {
> +			compatible = "siliconmitus,sm5504-muic";
> +			reg = <0x14>;
> +			interrupt-parent = <&gpio>;
> +			interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_keys_pins>;
> +		autorepeat;
> +
> +		key-home {
> +			label = "Home";
> +			linux,code = <KEY_HOME>;
> +			gpios = <&gpio 50 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		key-volup {
> +			label = "Volume Up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			gpios = <&gpio 16 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		key-voldown {
> +			label = "Volume Down";
> +			linux,code = <KEY_VOLUMEDOWN>;
> +			gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	chosen {};

chosen is usually at the top (as alphabetical order suggests)

> +};
> +
> +&smmu {
> +	status = "okay";
> +};
> +
> +&pmx {
> +	pinctrl-single,gpio-range = <&range 55 55 0>,
> +				    <&range 110 32 0>,
> +				    <&range 52 1 0>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&board_pins_1 &board_pins_2 &board_pins_3>;
> +
> +	board_pins_1: pinmux_board_1 {

No underscores in node names.

...

> diff --git a/arch/arm64/boot/dts/marvell/pxa1908.dtsi b/arch/arm64/boot/dts/marvell/pxa1908.dtsi
> new file mode 100644
> index 000000000000..7131b2070b72
> --- /dev/null
> +++ b/arch/arm64/boot/dts/marvell/pxa1908.dtsi
> @@ -0,0 +1,298 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/dts-v1/;
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/marvell,pxa1908.h>
> +
> +/ {
> +	model = "Marvell Armada PXA1908";
> +	compatible = "marvell,pxa1908";

Undocumented compatible.

Please run scripts/checkpatch.pl and fix reported warnings. Some
warnings can be ignored, but the code here looks like it needs a fix.
Feel free to get in touch if the warning is not clear.


Best regards,
Krzysztof

