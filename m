Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139F228488F
	for <linux-hardening@vger.kernel.org>; Tue,  6 Oct 2026 00:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246658; cv=none; b=lVkVu5zNMf80xPlq5H6Anwky8X9EkTUn3NQ7i7As9uAGLcgo8YPDXrwb0XwPfMa+2u8+ebY7CuIFMpsZYDyWFsgkI8s2NbJg6g4EhIUHcq5MUX6TSZN4nvcBDP+5Olhb+uGvfUJjhr2aWJa2amLNKAJOP0LZymdSJObPtxqhD8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246658; c=relaxed/simple;
	bh=nlfOu/Cx3dx7WAl82DavblqM7D6pKK70uc9LSQAqkOY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jyT7azkOZzUthLD6EEFtMoKn22qfJY9j/LLoPYnxVratw2OD7rvddssM0RNhkgi1xPYPgMUfEuvBvJBjXzReyeyWXJ9PlXMCNaKmq5eZ69h7YY6XHePxYKaoudL47i0lrFs7kk+aHTTwQ4fVbipR2yhcFOQqRtpmwR7MOvv4i08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=inEWEQNc; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="inEWEQNc"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93cbc3ab2fdso106353285a.3
        for <linux-hardening@vger.kernel.org>; Mon, 05 Oct 2026 17:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1791246654; x=1791851454; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CN7LmvsZdWmYM0BHY8P9OeOGiwwpFgBTQfuLY2b1oDc=;
        b=inEWEQNchdRW0C5a3Ij3mnDWP+Qn1rJrUIpRlz2ecpMH35Ys//re8a8PPze4x9avVQ
         nNjLlfoKRHSHkIh+/CyaRyJpWSxgf0PiV0cWEoPXGGhdz3u9Kw+nsR17s45eZ6utSHTK
         C5i9HMTUDqoiWXey6NWK3/Xc/QDXs3mgRGfTtz+Fr6gGWDfBgz6XrlQs3EGcKz1wLC8p
         F2aHMYXEuvlE06f7G2HjcFaRDWlmEuv/YxOwrS8DJnmF0h4HH1zZstC18YGeUrpay9Sg
         fX3hj1IGJ9R5TTbyvNz4/RXdgdura0ILpu37dGTBRTXhwFiFT6VU76l0GWHTMkWuJ/8e
         JI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791246654; x=1791851454;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CN7LmvsZdWmYM0BHY8P9OeOGiwwpFgBTQfuLY2b1oDc=;
        b=qreiQUTOm/G23pa8vZ+srQfKy2PnU06yFmJuqJ57pdk0vRXs1yx0Vk2fdlVl3iu1SD
         KKDSZjJlzCP0+hSt9SMAZ5FNQi0Zcsi3ParBA/cTzXiaXUPRgmXFv4rTjXPt88piiFtx
         iDdo87AHk0Lzi7MIsIQRoiyPFKUTZnpwndcHBsDBfMhlP8370xXvgN0ztbhdJm4G5wVO
         tt3DceWzxGBaTYfmARmI4JqTfFVsinANw/XaeOzAC6FjzN0sLV/wCht//STOIRGp0tqJ
         glwrLJ7zqeFa1/rl6Q8gpfSBZpqiccx0YLzNDG0Mpxhcx1eDO5MEYi3X5p5QQ9ZL9hCP
         1pjA==
X-Forwarded-Encrypted: i=1; AKwUvBxkvAv3kwVbjg6tYl5bHCOo0H385UzDeILmBllqPNfHy/CsR6Ut4+60ghLhRtDthB/6B75teCx8gAXC/sCZwzE=@vger.kernel.org
X-Gm-Message-State: AFuF++mYYOCUTj58hhH+ICIF1IPu3DB68OHlATD/MbUf88xrK2AQGwvc
	7dxmWSy94pxqDxr1fDDh5vn4ixyNshMZOBJQQmMO2w6bamAGdEmirqoIRLtXIISX+UI=
X-Gm-Gg: AYBFou18vteYMN/oRtyTCArWx30fOHLZLrvRnen/3eDfhqUvvSOBf8TWb39hwMgltS2
	zdsqqsqYwJdXageWwCsdVO3Met1C/8Wzrs+JPE7eHSSvCI6JKo6xKqxON4Kt7ixXWr2/AydYSIz
	Efa41rtWmdg8jhc28UMnjyh+NJQfH3+gr6bU7IrFwn+KjYoTywBLeRheovd6kOEX2ggFblKyudQ
	3b9b40f1c0IjirzlpiR7s5JdQ/PM9h7Hz2Cj/04O8aGGC4FHZsmuoAv1LjwubaH+YFOKpij9exn
	v4ZqFL77tQeYW+zmWVxh+7NgWDrVO0Kqmc/7LCTpOOOOIAVlj5TRdCUrP1bdYfi/dN2PH+GZvwI
	SYqLzkafh5Sz0S5fG70/SfJnpxUmNsHl+rcWz66Tgcv45QIZDNsfsjawoMlYt+bw7TK/weOpnk8
	KajWoDjGzTb6IW7ygbSWwU7vKUdRt0yQthwFgOYstqsOdrOyVhtfujvfNaiU9JpjihDQDzeWI=
X-Received: by 2002:a05:620a:800e:b0:93c:326b:43b1 with SMTP id af79cd13be357-93e5104ee28mr1517731985a.36.1791246653835;
        Mon, 05 Oct 2026 17:30:53 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca26371bsm998476985a.30.2026.10.05.17.30.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 17:30:53 -0700 (PDT)
Message-ID: <c92b8d7f-20a1-4bca-b51e-40ae52155099@riscstar.com>
Date: Mon, 5 Oct 2026 19:30:51 -0500
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: qcs6490-rb3gen2: add the clock
 controller
From: Alex Elder <elder@riscstar.com>
To: sboyd@kernel.org, bmasney+clk@redhat.com, jbrunet+clk@baylibre.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org
Cc: abelvesa@kernel.org, kees@kernel.org, gustavoars@kernel.org,
 mohd.anwar@oss.qualcomm.com, lorenzo.bianconi@oss.qualcomm.com,
 danielt@kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Thompson <daniel@riscstar.com>
References: <20261005230927.2000398-1-elder@riscstar.com>
 <20261005230927.2000398-4-elder@riscstar.com>
Content-Language: en-US
In-Reply-To: <20261005230927.2000398-4-elder@riscstar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/26 6:09 PM, Alex Elder wrote:
> The clock controller within the TC9564 SoC is accessed via a PCI
> endpoint bus through BAR 4 of the first embedded PCIe function.
> A syscon node is created to provide access to a range of memory
> that is used by the clock controller and shared with other devices.
> 
> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
> v2: - Moved the clock devicetree node to be a peer (rather than a child) of
>        the syscon node

Whoops.  I dropped the "reg" property, and that means
the change mentioned above leads to a warning.

Either make them peers, but keep the clock node "reg"
property, or drop "reg" and make the clock node
subordinate to the syscon.

I will address this in version 3 of this series, but
(unless someone suggests otherwise) I'll wait to get
feedback on the rest of the series before I send that.

					-Alex

> 
>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 0e3bbdaf4661f..06246d185b50f 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -9,6 +9,7 @@
>   #define PM7250B_SID 8
>   #define PM7250B_SID1 9
>   
> +#include <dt-bindings/clock/toshiba,tc9564.h>
>   #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
>   #include <dt-bindings/iio/qcom,spmi-adc7-pm7325.h>
>   #include <dt-bindings/leds/common.h>
> @@ -961,7 +962,7 @@ dev@0,0 {
>   				#size-cells = <2>;
>   				ranges;	/* This will be updated dynamically */
>   
> -				pci-ep-bus@4 {
> +				pcie_s1b5d0f0_bar4_bus: pci-ep-bus@4 {
>   					compatible = "simple-bus";
>   					#address-cells = <1>;
>   					#size-cells = <1>;
> @@ -989,6 +990,19 @@ pci-ep-bus@4 {
>   	};
>   };
>   
> +&pcie_s1b5d0f0_bar4_bus {
> +	tc9564_config_syscon0: syscon@0 {
> +		compatible = "syscon";
> +		reg = <0x0 0x2000>;
> +	};
> +
> +	tc9564_clock0: clock {
> +		compatible = "toshiba,tc9564-clock";
> +		toshiba,config-syscon = <&tc9564_config_syscon0>;
> +		#clock-cells = <1>;
> +	};
> +};
> +
>   &pm7325_gpios {
>   	kypd_vol_up_n: kypd-vol-up-n-state {
>   		pins = "gpio6";

