Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3A1C433FE
	for <linux-hardening@archiver.kernel.org>; Mon, 21 Nov 2022 11:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiKULVu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 21 Nov 2022 06:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiKULVe (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 21 Nov 2022 06:21:34 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC24C1F69
        for <linux-hardening@vger.kernel.org>; Mon, 21 Nov 2022 03:16:25 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id a29so18263286lfj.9
        for <linux-hardening@vger.kernel.org>; Mon, 21 Nov 2022 03:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lb2opW9F8iRuPmao9rEV62ivh/DFfQYAcMrDoUHfJeI=;
        b=ujRwQ9dJpwiN+HDFOLwz5WG8Q1I7J/eeDKq76gdjRGRLeDg2s3StSyCD1buNRplLM/
         haQqfw8W+GMoa79BPDJV6Tf6oVNu7T7qohcsXmipGHNnUuEqxkBN2MpvLY5UuSkJnIr1
         NKqn7wNswmTKEBwFHzRTfOkWsqnFJvRoEOwIZTmEHvtpiy5nzUt21bWBefHZTQkH+wLg
         x987sVTowAKSvL5HBNpsVo1LmrISs6K3Sgb+Tx4GLt04e6cuyXKr0F5uWzdZzxWP5zjQ
         a9M1OXjG7EhTcvKyOr8UAWJUS1RczEVJ0/3bn/yVl3/pMGFggRa2s3PbceKGoEbp4HwN
         uIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lb2opW9F8iRuPmao9rEV62ivh/DFfQYAcMrDoUHfJeI=;
        b=IlfCqclhswe8P6tpvkFZIWkLBiMfnRcDhQEq5ctbX6p4Ct2Mp0gZc+jSTZxapINYos
         jIJt1E1hAXgj/f0avyb7Syuy0+UIw6PXRT1RTeSLSsTXIBJ04l2A5rEp+fRpJoIRRUgD
         xIcYtfskSB56GpW6yJX8sCyefM9EC41d+OrVVsYMXHizFT500ZNLWYdvALh/F+HLb6/D
         DMc1d4oiDtVOmnyphydPSATA6JJqy3njy69JK5AlfHMY8U8M32fpk3he2+6nuVlltdpN
         NdRRJbguyrUHzIAL+j9XzxXagFwBVzEMAkYdV9VJNkoEEO3Il6jqPhdExEveRfhhmLCW
         sS0w==
X-Gm-Message-State: ANoB5pkJV2PWNsjKZojE0fDX6dFJ6bk82EGotrt+dIddFtJrR31sm9B5
        I42pQM7n/CR5XO3rRVhQ7vV/xw==
X-Google-Smtp-Source: AA0mqf78lVsAp8TebFcPDrS5txLHqCkaoAB0Cf0bOXh62o5fugGpz6hUZAtSocgDCC9BZo3Q2k3aAw==
X-Received: by 2002:ac2:4bd1:0:b0:4a2:4dc3:a2e with SMTP id o17-20020ac24bd1000000b004a24dc30a2emr2448924lfq.403.1669029383368;
        Mon, 21 Nov 2022 03:16:23 -0800 (PST)
Received: from [192.168.1.101] (95.49.32.48.neoplus.adsl.tpnet.pl. [95.49.32.48])
        by smtp.gmail.com with ESMTPSA id k19-20020ac24f13000000b00498fe38ea0fsm1987187lfr.174.2022.11.21.03.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 03:16:22 -0800 (PST)
Message-ID: <358de1df-7e83-c292-6abf-4011b9f26318@linaro.org>
Date:   Mon, 21 Nov 2022 12:16:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 3/9] arm64: dts: qcom: sdm450: Add device tree for
 Motorola Moto G6
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Julian Braha <julianbraha@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20221119203758.888207-1-luca@z3ntu.xyz>
 <20221119203758.888207-4-luca@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221119203758.888207-4-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 19.11.2022 21:37, Luca Weiss wrote:
> From: Julian Braha <julianbraha@gmail.com>
> 
> Add device tree for the Motorola Moto G6 (ali) smartphone. This device
> is based on Snapdragon 450 (sdm450) SoC which is a variant of MSM8953.
> 
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

> Changes in v2:
> * address review comments from v1
Veeeeeeery vauge!

Konrad
> 
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/sdm450-motorola-ali.dts     | 250 ++++++++++++++++++
>  2 files changed, 251 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index afe496a93f94..6bc1be0d525a 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -120,6 +120,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-crd.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-lenovo-thinkpad-x13s.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sda660-inforce-ifc6560.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sdm450-motorola-ali.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-ganges-kirin.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-discovery.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-pioneer.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts b/arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts
> new file mode 100644
> index 000000000000..43e2941f98d9
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts
> @@ -0,0 +1,250 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2022, Julian Braha <julianbraha@gmail.com>
> + */
> +/dts-v1/;
> +
> +#include "msm8953.dtsi"
> +#include "pm8953.dtsi"
> +#include "pmi8950.dtsi"
> +
> +/delete-node/ &qseecom_mem;
> +
> +/ {
> +	model = "Motorola Moto G6";
> +	compatible = "motorola,ali", "qcom,sdm450";
> +	chassis-type = "handset";
> +	qcom,msm-id = <338 0>;
> +	qcom,board-id = <0x43 0xc200>;
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		key-volume-up {
> +			label = "volume_up";
> +			gpios = <&tlmm 85 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEUP>;
> +		};
> +	};
> +
> +	reserved-memory {
> +		qseecom_mem: qseecom@84300000 {
> +			reg = <0x0 0x84300000 0x0 0x2000000>;
> +			no-map;
> +		};
> +
> +		ramoops@ef000000 {
> +			compatible = "ramoops";
> +			reg = <0x0 0xef000000 0x0 0xc0000>;
> +			console-size = <0x40000>;
> +		};
> +	};
> +
> +	vph_pwr: vph-pwr-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vph_pwr";
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +};
> +
> +&hsusb_phy {
> +	vdd-supply = <&pm8953_l3>;
> +	vdda-pll-supply = <&pm8953_l7>;
> +	vdda-phy-dpdm-supply = <&pm8953_l13>;
> +
> +	status = "okay";
> +};
> +
> +&i2c_3 {
> +	status = "okay";
> +
> +	touchscreen@38 {
> +		compatible = "edt,edt-ft5406";
> +		reg = <0x38>;
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <65 IRQ_TYPE_EDGE_FALLING>;
> +		vcc-supply = <&pm8953_l10>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ts_int_active &ts_reset_active>;
> +
> +		reset-gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
> +		touchscreen-size-x = <1080>;
> +		touchscreen-size-y = <2160>;
> +	};
> +};
> +
> +&pm8953_resin {
> +	linux,code = <KEY_VOLUMEDOWN>;
> +	status = "okay";
> +};
> +
> +&pmi8950_wled {
> +	qcom,num-strings = <3>;
> +	qcom,external-pfet;
> +	qcom,cabc;
> +
> +	status = "okay";
> +};
> +
> +&rpm_requests {
> +	regulators {
> +		compatible = "qcom,rpm-pm8953-regulators";
> +
> +		vdd_s1-supply = <&vph_pwr>;
> +		vdd_s2-supply = <&vph_pwr>;
> +		vdd_s3-supply = <&vph_pwr>;
> +		vdd_s4-supply = <&vph_pwr>;
> +		vdd_s5-supply = <&vph_pwr>;
> +		vdd_s6-supply = <&vph_pwr>;
> +		vdd_s7-supply = <&vph_pwr>;
> +		vdd_l1-supply = <&pm8953_s3>;
> +		vdd_l2_l3-supply = <&pm8953_s3>;
> +		vdd_l4_l5_l6_l7_l16_l19-supply = <&pm8953_s4>;
> +		vdd_l8_l11_l12_l13_l14_l15-supply = <&vph_pwr>;
> +		vdd_l9_l10_l17_l18_l22-supply = <&vph_pwr>;
> +
> +		pm8953_s1: s1 {
> +			regulator-min-microvolt = <795000>;
> +			regulator-max-microvolt = <1081000>;
> +		};
> +
> +		pm8953_s3: s3 {
> +			regulator-min-microvolt = <1224000>;
> +			regulator-max-microvolt = <1224000>;
> +		};
> +
> +		pm8953_s4: s4 {
> +			regulator-min-microvolt = <1900000>;
> +			regulator-max-microvolt = <2050000>;
> +		};
> +
> +		pm8953_l1: l1 {
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1100000>;
> +		};
> +
> +		pm8953_l2: l2 {
> +			regulator-min-microvolt = <975000>;
> +			regulator-max-microvolt = <1225000>;
> +		};
> +
> +		pm8953_l3: l3 {
> +			regulator-min-microvolt = <925000>;
> +			regulator-max-microvolt = <925000>;
> +		};
> +
> +		pm8953_l5: l5 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		pm8953_l6: l6 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		pm8953_l7: l7 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1900000>;
> +		};
> +
> +		pm8953_l8: l8 {
> +			regulator-min-microvolt = <2900000>;
> +			regulator-max-microvolt = <2900000>;
> +		};
> +
> +		pm8953_l9: l9 {
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3300000>;
> +		};
> +
> +		pm8953_l10: l10 {
> +			regulator-min-microvolt = <2850000>;
> +			regulator-max-microvolt = <2850000>;
> +		};
> +
> +		pm8953_l11: l11 {
> +			regulator-min-microvolt = <2950000>;
> +			regulator-max-microvolt = <2950000>;
> +		};
> +
> +		pm8953_l12: l12 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2950000>;
> +		};
> +
> +		pm8953_l13: l13 {
> +			regulator-min-microvolt = <3125000>;
> +			regulator-max-microvolt = <3125000>;
> +		};
> +
> +		pm8953_l16: l16 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		pm8953_l17: l17 {
> +			regulator-min-microvolt = <2850000>;
> +			regulator-max-microvolt = <2850000>;
> +		};
> +
> +		pm8953_l19: l19 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1350000>;
> +		};
> +
> +		pm8953_l22: l22 {
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2850000>;
> +		};
> +
> +		pm8953_l23: l23 {
> +			regulator-min-microvolt = <975000>;
> +			regulator-max-microvolt = <1225000>;
> +		};
> +	};
> +};
> +
> +&sdhc_1 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on  &sdc1_rclk_on>;
> +	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off &sdc1_rclk_off>;
> +
> +	status = "okay";
> +};
> +
> +&sdhc_2 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_off>;
> +	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
> +
> +	status = "okay";
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <95 5>, <111 1>, <126 1>;
> +
> +	ts_int_active: ts-int-active-state {
> +		pins = "gpio65";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-up;
> +	};
> +
> +	ts_reset_active: ts-reset-active-state {
> +		pins = "gpio64";
> +		function = "gpio";
> +		drive-strength = <0x08>;
> +		bias-pull-up;
> +	};
> +};
> +
> +&usb3 {
> +	status = "okay";
> +};
> +
> +&usb3_dwc3 {
> +	dr_mode = "peripheral";
> +};
