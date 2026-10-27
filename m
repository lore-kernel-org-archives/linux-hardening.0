Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114735;
	b=1AFMPlP7FX6fGILEFR/33Tdb2ZHlYRL6J8/NjhsPtZJfg/pRMmB7gm+3MhzvC3tVHv0g
	 V/2j+aNvw31xTrW93/Jd7QQKCy2e0ewUImcb+sym1qS2Z3reyRulL9hDOiY23rx5RW5Gu
	 5Fifc7RMt9/WuIuXxTpjKb0Nu/Z+odM86O/YTpYk4nm6e+mpy8zLwSwfugcLYABqTBePe
	 Kemmy+cK6/0mP6RlUp7OxePb3SM6LbegDWop2TisD/kDppvNjyTnMzA1lO/sGcqmmP3vU
	 GT73gEjmy9l4F39Qf8H6GkPobvysUelKF1bODprDS6+scKJEYt3l/dTpSl/BTUOk+Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114735;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=MAKDx31khoefmfUOeL61lGC9ufpndRmKXdUk86UDyqw=;
	b=WpwpprhcMW24GZrbc/2wTDAEABTqV7Xezic13fgobe7pBe8qdVrylPxkwsDXLGFWHyz6
	 tWJXzrN9I4uaFqjyVStYm3QNaGSNkO1bz55HY4Hna2c7KN0ERvwTq/aUb/CPAHt/+Ne9b
	 s48Q1zqDM4yJAxNS7gvdna5rcEBTpIWTDi/FdqN58PyAAD9L+9qedD8bgQi0E8/Akv7F0
	 ztM9jvSIdr6SEfPOPMn/ujZWA+Fj0WbZKOavB9VOseCHLJrZddGvXQCyrFa0Q334Lh/VW
	 mcdi7sPyFo3vPWs1KbjIOSMhN21WXqw8mT3AI1/IbUkS5Iz2WslGBTZFFZX/JVtzhLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cLnckm3H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B4B606A31D;
	Tue, 27 Oct 2026 15:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cLnckm3H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E601F01825;
	Tue, 27 Oct 2026 15:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793114734;
	bh=MAKDx31khoefmfUOeL61lGC9ufpndRmKXdUk86UDyqw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cLnckm3H8keXxOmWbcw0algepILOQqKfuYzEvH6392uZph2Sn2U1ego1hl+yvw9f/
	 vKNa4hWvcmAW/DMABwir3vFtT5eLsFk3EpOoLSq+gWgIpgT0lPv87wkKxof/kAWNjW
	 tWo1yY1QcmScO4OSnJjPRUAZ3DPo6Lq6jB2NtiCraOstdCAWHM54j06m5PjMTfxNKD
	 +8c5ngOSI+33eXvYF9GMAiph0K20lCr1httWkPpCdoK+KDanveD2RH9opNqhgtZrde
	 NZ11Rw+KCyjep/llL9tmw5kJqZHAGJeH/VhPm0agumhlY5lBvTHfpOgoGCV6LCzH7N
	 6EIQ4Hx59Jmfw==
Message-ID: <e6f56e97-f920-466b-9ad6-ec43be0f5e2a@kernel.org>
Date: Tue, 27 Oct 2026 16:25:25 +0100
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
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
 <ad511ae7-755d-42bc-a55d-12b93d49ddaf@kernel.org>
 <ee6ba585-2b87-4e38-963d-9d2731cf4d78@riscstar.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <ee6ba585-2b87-4e38-963d-9d2731cf4d78@riscstar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/10/2026 17:09, Alex Elder wrote:
> On 10/9/26 9:46 AM, Krzysztof Kozlowski wrote:
>> On 09/10/2026 16:23, Alex Elder wrote:
>>> On 10/9/26 8:56 AM, Krzysztof Kozlowski wrote:
>>>> On 09/10/2026 15:44, Alex Elder wrote:
>>>>> On 10/9/26 4:31 AM, Krzysztof Kozlowski wrote:
>>>>>> On Mon, Oct 05, 2026 at 06:09:24PM -0500, Alex Elder wrote:
>>>>>>> Define the binding for the clock controller functionality present in
>>>>>>> the Toshiba TC9564 SoC.
>>>>>>>
>>>>>>> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
>>>>>>> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
>>>>>>> Signed-off-by: Alex Elder <elder@riscstar.com>
>>>
>>> . . .
>>>
>>>>>>> +properties:
>>>>>>> +  compatible:
>>>>>>> +    const: toshiba,tc9564-clock
>>>>>>> +
>>>>>>> +  toshiba,config-syscon:
>>>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>>>>> +    description:
>>>>>>> +      Phandle for the configuration space system controller.
>>>>>>
>>>>>> I do not see my previous comment addressed - you have no resources here,
>>>>>> so this belongs to the parent. You responded something about pci-ep, but
>>>>>> the parent is not pci-ep. Open your code:
>>>>>> https://lore.kernel.org/lkml/20260918165234.687224-5-elder@riscstar.com/
>>>>>>
>>>>>> I clearly see code like:
>>>>>>      syscon {
>>>>>>        clock@ {
>>>>>>        };
>>>>>>      };
>>>>>>
>>>>>> so I do not understand what pci-ep has anything to do here.
>>>>>
>>>>> What I have now (about to send) looks like this:
>>>>>
>>>>>        syscon@0 {
>>>>>            compatible = "syscon", "simple-mfd";
>>>>>            reg = <0x0 0x2000>;
>>>>>
>>>>>            clock {
>>>>>                compatible = "toshiba,tc9564-clock";
>>>>>                #clock-cells = <1>;
>>>>>            };
>>>>>        };
>>>>>
>>>>> A reset node will also go inside the syscon, so there is another
>>>>> function for that MFD.
>>>>>
>>>>> The regmap belongs to the parent, and is looked up this way:
>>>>>
>>>>>        regmap = syscon_node_to_regmap(dev_of_node(dev->parent));
>>>>
>>>> That's driver code, so irrelevant. So how does this solve my comment
>>>> from v1?
>>>
>>> I'm trying Krzysztof.
>>
>> In v1 I asked to fold the node into the parent. v2 did not have it. v3,
>> which you are preparing, still has no node folded, because they are
>> separate.
> 
> Are you saying to fold it into the PCI function?

I do not see in the example the parent being PCI function, so I do not
understand that. What is this node? What is its parent?


> 
> If so, could the PCI function be a clock provider and
> define #clock-cells (and #reset-cells)?
> 
> Because as things stand now, clock and reset are used by
> the two DWMAC Ethernet interfaces as well as a separate
> interrupt controller (one for each PCI function).
> 
> It sounds a little like you might prefer everything being
> wrapped up in the DWMAC driver, as we originally did six
> months ago.
> 
Not sure which patchset you refer to - v1 was in September.

Best regards,
Krzysztof
