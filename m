Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FB53F4DD2;
	Wed, 23 Sep 2026 07:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148345; cv=none; b=u7V4cTtlBheSrrK0atNs5lzLjiikCk0JisA5657oaCUhJ0+FH/KZpOP+ZaLMd7/PKaweh7JQqMYItEo0tzJDG5E/0DgeD51MFGMysuk1/g7rJ8TCX/chN+3Zi9hwsGwcsLzgLbF5MGx+cP5PId5YIsr7FpQRTqRJJ7bbxX9hUiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148345; c=relaxed/simple;
	bh=gjKAhENt8OS/KqIAW7SARRbkKsR3HmNYD+TAopC3l9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=in3DrK/8/fOZ3k+eXJLI8+SF0jyx0NvRJs4blqzedc83eoT+32jfZoTSJEpWJzbOiND/5mremyOcGzYYZActNvywYXLfPQIqvvV/MCDQngWGM60sGMI2567MroCqymzxjk7y2atUxFI+5YEilWRugn0VSKXDRbomZ4K1hgQdQ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnTvaGXU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnTvaGXU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5C91F000FF;
	Wed, 23 Sep 2026 07:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148343;
	bh=nHU+klMl+6fj4IxcKpc7ReZXkRGsZ/M7dfsPEKrCLKE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PnTvaGXUEepbUNJGYgo3QOK4ATe+VF/C8uPkFpcODBJG2+8AQajxzrLP9gSiT1cpN
	 oqdoJh4cY7kJEcr2m69K9E87Y8ff2qQOhA73C5DmXfBv7i1WF7u06LJ3tKG17/ycaS
	 wPSA9YdoCgh9YctF48BD1ljFpgbQ5ynzDGb3B4KWCZdC1eJ3v2Z4hzONnPMSLMC0nd
	 38OjgtZXzVh4ccWsjkiIR6Fm8BGgCsYPDMyKR8FcEzjpv8mj8TlWc2V7svKF/hWGGP
	 uyAFHMeWZk2IJPrfxD2ODwhF6dqj0o7YHfc7uIuwSogMPlgqR3nCoNjVX1Qhw7IVam
	 VD5SqOjKsZI/g==
Message-ID: <fbeac5ba-a28d-4d34-8d23-4946aef515ea@kernel.org>
Date: Wed, 23 Sep 2026 09:25:34 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: mfd: introduce the TC9564 config syscon
To: Alex Elder <elder@riscstar.com>
Cc: sboyd@kernel.org, bmasney+clk@redhat.com, jbrunet+clk@baylibre.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, lee@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
 kees@kernel.org, gustavoars@kernel.org, p.zabel@pengutronix.de,
 daniel@riscstar.com, mohd.anwar@oss.qualcomm.com,
 lorenzo.bianconi@oss.qualcomm.com, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260918165234.687224-1-elder@riscstar.com>
 <20260918165234.687224-2-elder@riscstar.com>
 <20260920-fiery-fanatic-manticore-6abf0a@quoll>
 <85b0e7de-e4a8-4e08-b801-a9664d366e1a@riscstar.com>
 <7e32063f-f1a4-4259-96c9-fcbdd25c7f2f@riscstar.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <7e32063f-f1a4-4259-96c9-fcbdd25c7f2f@riscstar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/09/2026 23:02, Alex Elder wrote:
> On 9/21/26 4:46 PM, Alex Elder wrote:
>>> I also have doubts that this is needed - I see no updates to the misc
>>> binding, which would be referencing it. But then another point would be,
>>> that you do not need separate child node, which has no properties.
> 
> Krzysztof, I've done some additional work on this based on
> your feedback.
> 
> I think you are correct that there is no need to define
> this as a special syscon with its own compatible string.
> 
> Instead, I can simply define a simple syscon with a label:
> 
>          tc9564_config_syscon0: syscon@0 {
>                  compatible = "syscon";

I never proposed anything like that. I asked to drop simple-mfd.

>                  reg = <0x0 0x2000>;
>          };
> 
> And then have the devices that need to use it, refer to
> its label using a phandle:
> 
>          tc9564_clock0: clock@1004 {
>                  compatible = "toshiba,tc9564-clock";
>                  toshiba,config-syscon = <&tc9564_config_syscon0>;
>                  #clock-cells = <1>;
>                  #reset-cells = <1>;
>          };
> 
>          tc9564_emac0: ethernet@40000 {
>                  compatible = "toshiba,tc9564-xgmac";
>                  reg = <0x40000 0x8000>;
>                  toshiba,config-syscon = <&tc9564_config_syscon0 0x1070>;
> 		. . .
> 	};
> 
>          tc9564_emac1: ethernet@48000 {
>                  compatible = "toshiba,tc9564-xgmac";
>                  reg = <0x48000 0x8000>;
>                  toshiba,config-syscon = <&tc9564_config_syscon0 0x1074>;
> 		. . .
> 	};
> 
> That simplifies things a bit, and requires no devicetree binding.
> 
> If you think this is incorrect, please let me know, otherwise it
> is the direction I plan to go with the next version of this
> series.
> 

I think nothing behind PCI EP should be described in DT, because
everything is internal to the device and implied by compatible (or
vid/pid). We do describe internals of devices in DT usually for complex
devices (like some display blocks with multiple subblocks) or when they
are used outside of that device. That's why I asked how are all these
clocks and resets exposed to the host. If the syscon is used only by the
device itself, I don't quite get the benefits of describing it in DT.

Best regards,
Krzysztof
