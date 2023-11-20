Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wLqIKqSc"
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDF698
	for <linux-hardening@vger.kernel.org>; Mon, 20 Nov 2023 06:33:04 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso605567466b.1
        for <linux-hardening@vger.kernel.org>; Mon, 20 Nov 2023 06:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700490783; x=1701095583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zoAiFNMN3MBx2kHhT1jADxR7MaRBLjkeeIjTHILsATg=;
        b=wLqIKqScIYCcun3mCJz1P+jobA3v7+iwXVMhRayzBO2SdVveMDYpag2OG5YOPpPR7I
         fAWz1F6oog/OuUn8hevDFJ1gkMJkCp/AlqFQQBfuGVD7ZGgqMurJvOErSkokwpU+Pdz3
         wLICwLDuLHkGEsakeIAY3JUZzeAmVFId92byMfO5aC7RB/9gsN5ROoWdk/d5MUhRb3bA
         wkPPlt/XDHEW3u64L8MHUoxobod4w0Lk8fQKQw8hkZFiQR4d35gLlxC5XVs6hEOatcdc
         nrjvoQ9An1s45wa75Guuje7CdjuLJJpCX6OeAeirpi1tkPXxC2PiLkzwHUsWPtc+cWlL
         CLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700490783; x=1701095583;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zoAiFNMN3MBx2kHhT1jADxR7MaRBLjkeeIjTHILsATg=;
        b=VSfM3eC48Z0FQFvzVRZhUFXwt6MFyFIcKL9mVBlJcK8KoDwxbASF69nTmOZ46431Py
         oMe+GFdiepL+bZBfSzJhwGxUSV2JiKcdMjQh/lr0Ibia+FF5HCVMDsK5obF/IvHwPsiC
         yM+vm36z1l9zptr+xwMCFea+kqR7tBScO1ip4QIxAlzWZEzxUXdh6IO14my9WX2rNAo8
         3nZTYOFxwKew6TZMYjWH96PNGcM7ZIy6W2ukEV28PAHwtFVD9RNtpNF95OJFA+aPVy74
         Iy8zf2ATlFhGWaIlwT3hfY1QKtJ9uKWlQPBTrKbKndCpFmJ4sFGHccNpeE4mWqHBrSr9
         OraQ==
X-Gm-Message-State: AOJu0Yyuzv2mHr5bGKp4nm10dZLarHUCvy21djZJ6EcubTfT07lHGtm5
	LNSaRjI5gvk4tPNt9YAR0N9IxA==
X-Google-Smtp-Source: AGHT+IFAMWl0QerxVsat39nC28l4EF18a1qHEyIom86ybr3an1vksCf9F2MVXxZmkPjLduswTGu+IQ==
X-Received: by 2002:a17:906:2b56:b0:9d3:8d1e:cf0 with SMTP id b22-20020a1709062b5600b009d38d1e0cf0mr4432264ejg.54.1700490782974;
        Mon, 20 Nov 2023 06:33:02 -0800 (PST)
Received: from [192.168.201.100] (178235187204.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.204])
        by smtp.gmail.com with ESMTPSA id mf3-20020a170906cb8300b009f28db2b702sm3912586ejb.209.2023.11.20.06.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 06:33:02 -0800 (PST)
Message-ID: <2085c7a2-046a-4ef0-99b7-1beef0d8d2cb@linaro.org>
Date: Mon, 20 Nov 2023 15:33:00 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: Add device tree for Xiaomi Mi 11
 Ultra
Content-Language: en-US
To: wuxilin123@gmail.com, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <keescook@chromium.org>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20231021-sakuramist-mi11u-v2-0-fa82c91ecaf0@gmail.com>
 <20231021-sakuramist-mi11u-v2-3-fa82c91ecaf0@gmail.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20231021-sakuramist-mi11u-v2-3-fa82c91ecaf0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.10.2023 12:20, Xilin Wu via B4 Relay wrote:
> From: Xilin Wu <wuxilin123@gmail.com>
> 
> Add support for Xiaomi Mi 11 Ultra. This commit brings support for:
> * Front and rear display panels (initialized by bootloader)
> * USB
> * UFS
> * PCIe0
> * Thermistor sensors
> * ADSP/CDSP/Modem/SLPI
> * IR Transmitter
> * RTC provided by PMK8350
> * Buttons
> 
> To create a working boot image, you need to run:
> cat arch/arm64/boot/Image.gz arch/arm64/boot/dts/qcom/sm8350-xiaomi-\
> star.dtb > .Image.gz-dtb
> 
> mkbootimg \
> --kernel .Image.gz-dtb \
> --ramdisk some_initrd.img \
> --pagesize 4096 \
> --base 0x0 \
> --kernel_offset 0x8000 \
> --ramdisk_offset 0x1000000 \
> --tags_offset 0x100 \
> --cmdline "SOME_CMDLINE" \
> --dtb_offset 0x1f00000 \
> --header_version 1 \
> --os_version 14.0.0 \
> --os_patch_level 2099-12 \
> -o boot.img-xiaomi-star
> 
> Then, you can flash it to slot b on the device:
> 
> // You have to either pull vbmeta{"","_system"} from
> // /dev/block/bootdevice/by-name/ or build one as a part of AOSP build process
> fastboot --disable-verity --disable-verification flash vbmeta_b vbmeta.img
> fastboot --disable-verity --disable-verification flash vbmeta_system_b \
> vbmeta_system.img
> 
> fastboot flash boot_b boot.img-xiaomi-star
> fastboot erase dtbo_b
> fastboot set_active b
> fastboot reboot
> 
> Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
> ---
[...]


> +		pmr735a_s1: smps1 {
> +			regulator-name = "pmr735a_s1";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1280000>;
> +		};
You probably want initial mode on this pmic too

[...]

> +
> +&ufs_mem_hc {
> +	reset-gpios = <&tlmm 203 GPIO_ACTIVE_LOW>;
> +	vcc-supply = <&vreg_l7b_2p96>;
> +	vcc-max-microamp = <800000>;
> +	vccq-supply = <&vreg_l9b_1p2>;
> +	vccq-max-microamp = <900000>;
> +	vdd-hba-supply = <&vreg_l9b_1p2>;
These regulators need regulator-allow-set-mode and allowed-modes

Konrad

[...]

> \ No newline at end of file
> 
And this needs to be fixed

looks good otherwise, I think!

Konrad
