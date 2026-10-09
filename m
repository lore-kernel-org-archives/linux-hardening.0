Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5192E4E4C43;
	Fri,  9 Oct 2026 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557174; cv=none; b=Bn/o9+HehhyFHL7GE2UfheA2QAYgt1dxKmSztU2QsVDF8Io0yloDirND1HKFQ/O3B/jQFdbaWOG0BQa6/oKyFLNZpQWWHG5XWK4ydxkVacn4E6MY7lj+KiKYf5tZeJqGf+QDCGHn0oWg9XhrhzAsLjNUpnPV5xqqCwu/FECnYxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557174; c=relaxed/simple;
	bh=93kjYLOQu7rxs6t6unplP70FqIIK48qGdTWUIJuE3Hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1woLoNKpc1NQqodgDyFSCo5axeFrhQmcqNQLIAgWi18XOUCU4gFzhTTLAVoIgCbTHJHxXoKqhyeNDWouN5GZHLza+214HgsqHJX0XVj/oXo+YOVYuxDxJlYrbdl+xJfuBOxrA5sTEM7R9zC4YpB5oVKJsXFfooa06ECr60FcZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DK1ZSfrs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DK1ZSfrs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFC01F00893;
	Fri,  9 Oct 2026 14:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791557172;
	bh=6cUenmNTYC7qMAewCrSEbIVswliLQpgsX0IJlOlJnFw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DK1ZSfrsh/ZGAauXJLhHvNsUJJkK5iaO2GWkqIbGqkkx9YmuCgBLwKRb28NPDRZq6
	 7Slfs8gc1Xa9ldXqga8Eao4IBiiYK4BZA0U3K/1ump+w5Pq9AdayLS3v2U6KR2jX5K
	 Bm1cNI6v7KDCgfKmSWxalw5M5YdBcQ539lzd92Lg9zdvD3YB5XbSlq5TZfgxZk34Ur
	 jNLGkWXVeinT8oy3xLfEsvQaHsQKdTTj0/YdbIcAFmgWes9m3KD1s29JQYbL+hFT/D
	 MSCKiCO2tiGF8CKYZkYx9hjgyjx9+YVuteMoXBw1lVRzVtrzVZT0P5+HGbx30chCQY
	 HfPv0CiLc2kSw==
Message-ID: <ad511ae7-755d-42bc-a55d-12b93d49ddaf@kernel.org>
Date: Fri, 9 Oct 2026 16:46:02 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: introduce
 toshiba,tc9564-clock.yaml
To: Alex Elder <elder@riscstar.com>
Cc: sboyd@kernel.org, bmasney+clk@redhat.com, jbrunet+clk@baylibre.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
 kees@kernel.org, gustavoars@kernel.org, mohd.anwar@oss.qualcomm.com,
 lorenzo.bianconi@oss.qualcomm.com, danielt@kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Thompson <daniel@riscstar.com>
References: <20261005230927.2000398-1-elder@riscstar.com>
 <20261005230927.2000398-2-elder@riscstar.com>
 <20261009-gifted-stylish-tortoise-95b14d@quoll>
 <b190fe58-364b-4b94-9cab-c5f81f874289@riscstar.com>
 <aafe2703-bfb8-43da-8472-b1dfa36fa8f9@kernel.org>
 <77dacc46-7294-47c8-899a-fd56b6a2af55@riscstar.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <77dacc46-7294-47c8-899a-fd56b6a2af55@riscstar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/10/2026 16:23, Alex Elder wrote:
> On 10/9/26 8:56 AM, Krzysztof Kozlowski wrote:
>> On 09/10/2026 15:44, Alex Elder wrote:
>>> On 10/9/26 4:31 AM, Krzysztof Kozlowski wrote:
>>>> On Mon, Oct 05, 2026 at 06:09:24PM -0500, Alex Elder wrote:
>>>>> Define the binding for the clock controller functionality present in
>>>>> the Toshiba TC9564 SoC.
>>>>>
>>>>> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
>>>>> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
>>>>> Signed-off-by: Alex Elder <elder@riscstar.com>
> 
> . . .
> 
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: toshiba,tc9564-clock
>>>>> +
>>>>> +  toshiba,config-syscon:
>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>>> +    description:
>>>>> +      Phandle for the configuration space system controller.
>>>>
>>>> I do not see my previous comment addressed - you have no resources here,
>>>> so this belongs to the parent. You responded something about pci-ep, but
>>>> the parent is not pci-ep. Open your code:
>>>> https://lore.kernel.org/lkml/20260918165234.687224-5-elder@riscstar.com/
>>>>
>>>> I clearly see code like:
>>>>     syscon {
>>>>       clock@ {
>>>>       };
>>>>     };
>>>>
>>>> so I do not understand what pci-ep has anything to do here.
>>>
>>> What I have now (about to send) looks like this:
>>>
>>>       syscon@0 {
>>>           compatible = "syscon", "simple-mfd";
>>>           reg = <0x0 0x2000>;
>>>
>>>           clock {
>>>               compatible = "toshiba,tc9564-clock";
>>>               #clock-cells = <1>;
>>>           };
>>>       };
>>>
>>> A reset node will also go inside the syscon, so there is another
>>> function for that MFD.
>>>
>>> The regmap belongs to the parent, and is looked up this way:
>>>
>>>       regmap = syscon_node_to_regmap(dev_of_node(dev->parent));
>>
>> That's driver code, so irrelevant. So how does this solve my comment
>> from v1?
> 
> I'm trying Krzysztof.

In v1 I asked to fold the node into the parent. v2 did not have it. v3,
which you are preparing, still has no node folded, because they are
separate.

> 
> The clock controller uses two registers, 0x1004 and 0x100c,
> to manage whether a set of clock signals are enabled or not.
> (The reset controller uses two adjacent registers, 0x1008
> and 0x1010, to manage whether a set of reset signals are
> asserted or not.)
> 
> You said "no resources except a small address space" and I
> guess it's not clear to me what size is "big enough" to
> warrant representing something as a separate device.
> 
> *One* of the managed clocks is a 25 MHz clock, exposed
> through a pin on the SoC.  That one clock signal is
> therefore usable by the platform (although on the RB3gen2
> it's not used).
> 
> Rather than expose the register addresses in the clock
> node, a syscon is defined, covering 8 KB, and the actual
> offsets used are just defined in the clock and reset
> driver source code.
> 
> If that's not the right thing to do, please say that.

Nodes should be squashed.

> 
>>>> What's more, I still do not see any usage of these clocks outside. And I
>>>> still did not receive actual answers (or I missed them) how these clocks
>>>> are routed OUTSIDE of the connector. You said for example:
>>>> "Ultimately the TC9564 SoC has a single 25 MHz input clock,"
> . . .
> 
>>> The single exposed clock *might* justify presenting the
>>> clock controller device in devicetree.  There are also
>>> resets exposed externally via GPIOs, and these control
>>> external entities (PHYs).
>>
>> I cannot find any of these exposed. Please point me to DTS code showing
>> this.
> 
> It is not used by this platform, but is available for other
> platforms to use.  Its name is "REFCLKO" and is exposed on
> ball C17 of the SoC, if a platform designer decided to use it.

Yeah, but you do not describe the SoC but PCI EP device, thus my claim
is that clocks cannot be used by the host. The SoC itself for different
hardware uses would have different binding, so that's not an argument to
have anything here, unless these different uses are also documented here.

Best regards,
Krzysztof
