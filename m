Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A02F47ECC6;
	Wed, 14 Oct 2026 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791973260; cv=none; b=am8zE+bPh2NLrM5AEZRWlwRs+TMca6kkIjbeayy52sHwEhwiGS4qMyc8VTBlDqus92NGC41A93irUkpeSj9wrdLhFcHlBCatS9uRPDHorU6rrxB+h92vrzxi7J0fuKBkMBDkNXL4VD6j5oCmcRGWw7DiufUTPyQk3XX7h0ybma0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791973260; c=relaxed/simple;
	bh=VhpDEZvTkXWqvyp2s8oj2CfAOxwHTIQU4dABiDBxRBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mPSGXP9mOFyRVlZ0F3ZvIYYNlWioJEFyI79ayiPeDMNXz+HCb81/1SXkZwGmmRcGqMXqHcar1esZ6NdXcHenqMEAOXQ5TVzO1V40q5ev7tm7nFZmpRHpt1Ks+lasbsUXL7jFixn7nVPF1zUwRHUh38bgynfrA2pNLPhXXN1Tz8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzAVM2XJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzAVM2XJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4A31F000FF;
	Wed, 14 Oct 2026 10:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791973258;
	bh=gWrSo/PMIGTc7kwWlNZNJ6yFmB8LvpG1bvD0PiyoSR4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LzAVM2XJOLZYS2PM2+BzzYUUSQmQUvTCTh3tI1GNgWp/t+cn0AlhGl6G9jqYjS6Y7
	 MKdBGy9mPDaqnft8G9IcunnPtBK71JU8j8qdVgb+MSHnp9m+LcX+5Yfk/xVKYpM5fM
	 gG+6kRKx3hknYdPHoe5Qps09nhFlSnFvKyhWIGf+1tD2xAVojGFa60+jVoehTpEbWd
	 /l2Kpr4kfSIKY+eBsLj+w3oCytLD1+hogKdCFiam0qAlZu04JCQCgfx2VpLqtQIC66
	 Qo2i3NXm+ajvZnYrmhCq/oEynJqSVwoOOpxS1Lwc+tkrT3xtThuTDgIou7jBN04psx
	 3gdVHqX/2Pfyg==
Message-ID: <9bf93bde-8abe-4a83-afc6-d5f6954ed3c1@kernel.org>
Date: Wed, 14 Oct 2026 12:20:49 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: qcs6490-rb3gen2: add the clock
 controller
To: Alex Elder <elder@riscstar.com>, sboyd@kernel.org,
 bmasney+clk@redhat.com, jbrunet+clk@baylibre.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org
Cc: abelvesa@kernel.org, kees@kernel.org, gustavoars@kernel.org,
 mohd.anwar@oss.qualcomm.com, lorenzo.bianconi@oss.qualcomm.com,
 danielt@kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Thompson <daniel@riscstar.com>
References: <20261012152408.3729237-1-elder@riscstar.com>
 <20261012152408.3729237-5-elder@riscstar.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261012152408.3729237-5-elder@riscstar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/2026 17:24, Alex Elder wrote:
> The clock controller within the TC9564 SoC is accessed via a PCI
> endpoint bus through BAR 4 of the first embedded PCIe function.
> A syscon node is created to provide access to a range of memory
> that is used by the clock controller and shared with other devices.
> 
> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
> v3: 
> - What was formerly described as a "clock" node is now "clock-controller"
> - Label for the 25 MHz input clock is added (new in this version)
> - The clock-controller node is now a sub-device of the config syscon
> - The config syscon is now (also) compatible with "simple-mfd"
> - The clock-controller DTS node no longer defines a toshiba,config-syscon
>   property, and the config syscon no longer requires a label
> - The clock-controller now requires a (parent) clock property, which
>   refers to the new 25 MHz clock
> 
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index b8d290eed2f38..e7601daf1bc5a 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -9,6 +9,7 @@
>  #define PM7250B_SID 8
>  #define PM7250B_SID1 9
>  
> +#include <dt-bindings/clock/toshiba,tc9564.h>

Unused.

>  #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
>  #include <dt-bindings/iio/qcom,spmi-adc7-pm7325.h>
>  #include <dt-bindings/leds/common.h>
> @@ -891,7 +892,7 @@ pcie@0,0 {
>  		pinctrl-0 = <&tc9563_resx_n>;
>  		pinctrl-names = "default";
>  
> -		clock-25000000 {
> +		tc9564_xo_board: clock-25000000 {
>  			compatible = "fixed-clock";
>  			#clock-cells = <0>;
>  			clock-frequency = <25000000>;
> @@ -967,7 +968,7 @@ dev@0,0 {
>  				#size-cells = <2>;
>  				ranges;	/* This will be updated dynamically */
>  
> -				pci-ep-bus@4 {
> +				pcie_s1b5d0f0_bar4_bus: pci-ep-bus@4 {
>  					compatible = "simple-bus";
>  					#address-cells = <1>;
>  					#size-cells = <1>;
> @@ -995,6 +996,19 @@ pci-ep-bus@4 {
>  	};
>  };
>  
> +&pcie_s1b5d0f0_bar4_bus {
> +	syscon@0 {
> +		compatible = "syscon", "simple-mfd";
> +		reg = <0x0 0x2000>;
> +
> +		tc9564_clock0: clock-controller {
> +			compatible = "toshiba,tc9564-clock";
> +			clocks = <&tc9564_xo_board>;
> +			#clock-cells = <1>;

So here is DTS which is supposed to be the argument why you need inner
device representation in DTS and... no usage of that at all. Otherwise
point me which part of this patch references tc9564_clock0 via phandle.

Best regards,
Krzysztof
