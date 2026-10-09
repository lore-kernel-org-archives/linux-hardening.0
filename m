Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE834D6C21
	for <linux-hardening@vger.kernel.org>; Fri,  9 Oct 2026 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556712; cv=none; b=DslTggPGu5Sms5c9G8jgq+sYFXGmSrDpUtgFwSRFDBSJX0JM9SfslZjy7wWY48hlFT13tNfHPtuBzxPSp+B7YogNTWWg8IH33a2Ldq0sz/p/o+rdb7eOzRR2Mtl6t1AffH9LkgUvWNw1wKM5B50MWjb6QAOvdCrdFgb1PfpE3hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556712; c=relaxed/simple;
	bh=fR7q+Enx5sddKW2mLK9nmPbd75EbrXPCo0qCI1rlWN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WyQYZlBcs39i3p5+yEDqiOxy8sNSPa6phdOTMWsV0Dn9iErlI+uox2v7M4Atq7NJL6ghUaNckuqoSS8dp3h49YToRJ8jOzSU8Dzynman1BE3GyLc4wwOxteNonIsxJF2Zj7VsMwRwTaoCf4HwruadCmyYxCkALHKknuYiQJkBac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=No+ZOGgc; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="No+ZOGgc"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48c02782159so2807975f8f.0
        for <linux-hardening@vger.kernel.org>; Fri, 09 Oct 2026 07:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1791556708; x=1792161508; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pw+7/YrpQiBB458JMj0CBklEjmVY2DERmPYaWqC3uAI=;
        b=No+ZOGgcBVHwhMV4Wn5JYf1370qKpeHgZVPZ8WSd3YboTxtzzaf6fJfkaWOlLz/FDG
         DQgkZvV77zmWf6SAdEIdBBGfWUGpIQlovAnTbWPREviYUsCLHfbAqZMffUJHhVvd8wwh
         f+39i1rEkZFRSONXeWX1+pX561pZoJ8w7/F3adPQ02S2+9zefxlE80ETvPEvYUoAxG0e
         EKxKFshVokCp53jtLQt3njuZ+v0JR2a2yKqCzQivLdGzeO4fiPhO3nYC5bZTrj9j0Lv1
         X5c4GyT1B6Pak4syqhVgXoTplUzfR/jmtiHw1R6F4RkAdW4X9tSnWhbMJW9IlyTgqWCL
         jrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791556708; x=1792161508;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pw+7/YrpQiBB458JMj0CBklEjmVY2DERmPYaWqC3uAI=;
        b=Dt9pprAnjCI7sVpovbalrARiEdkm1Y0TpLj6B2VTUfH/4ndZbWqTpQMKDhbob0DcvH
         CmOKCcS6B0uJCCK97sTx9OsMLSjHBm4Xz2S9xH976J3cSXLvcW6is63l67E70dUcJ6ld
         U3Ex3FbRK5wnpTOf5II6K9evGiqwtZHzaf662dxZzBXkSVmuW/FN55ew3eyR+P6gB3gS
         DDVaE31q6l08gOOdmYleef2ZX5VC+YqjJvxTKf7qfzId9eUMyPVq/1ZUtkPj5kSqAA43
         PXU2OA3Ho51hpXPnz43M/gj9TZyyUBCNJ/wO7WdoFObsuUTTpKPn9bu0HZHKfvOweiMZ
         mYBA==
X-Forwarded-Encrypted: i=1; AKwUvByKLDChwE7xzujbt+kRsVUM+tj/4/YKuq033GC+JwRetNNAgn9nnrZ3cwjeaRoKOPgRrra1wfIEDpq2tHH3Af4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMQamMKYdkhJUq+J25nG2UpvHiUpRAG5TtRCXBEt/hC3nOOOiT
	RxwFJcvF6l0J1qNgdHYoWhsg2uKIq5amMweaPfn+/8skyMdNQ7AQFC+ew0nvCN6hgq0=
X-Gm-Gg: AYBFou3vWloc96Sijf87hbDbBr8UJmCBZNYvWf6/LzLxwSpm1br8jNNNcPfk8Qr+oAs
	e4Mq3/gmFHK/uUYJG4RktmSoqQaqwUwFy30fT5YBUrzKO1HMPQXMid+U6flaIgHuHkN5BFio2Wx
	LqbaBRyfCcFxf0TWyxwzhuV38UcDZkW3yGmVVEhUwZYpsXL6SLV0lTHq+yrpSMlcsYWR5L4011d
	x/ggC8/5QKwdb4qfOlLr7eWk8DmmlPgaN1/NAtjQ8W48Z/1LMaFPmX1hWiB8s73HWt++gTc03sg
	efg1MriEAxXWGdtlg2DCEunypkuS5U00iarE3fbISQAoqU1uvSSULtBW41fqkR1fq9ULnWpSsEZ
	gkTzOIoSL0VlFpfD8CpPxeP50EgIXyEzGJwE40zL1+yrvHjrvV8U6FgbWnZOuhWcHiLGKuNauVz
	CvOGRTo4NI1Xe3gKo6KnQeyvEHQL+Oe6A44MazQRJSuZSZ3GN05k7Qv6Ipvfg1uQBM0GuAeZf9o
	ahjKGgLXZk1iidlag==
X-Received: by 2002:a5d:5b87:0:b0:48c:5c2e:434d with SMTP id ffacd0b85a97d-48dbaae84eemr2941589f8f.21.1791556707821;
        Fri, 09 Oct 2026 07:38:27 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db94e2ef0sm4359750f8f.20.2026.10.09.07.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 07:38:27 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Alex Elder <elder@riscstar.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: sboyd@kernel.org, bmasney+clk@redhat.com, jbrunet+clk@baylibre.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
 kees@kernel.org, gustavoars@kernel.org, mohd.anwar@oss.qualcomm.com,
 lorenzo.bianconi@oss.qualcomm.com, danielt@kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Thompson <daniel@riscstar.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: introduce
 toshiba,tc9564-clock.yaml
In-Reply-To: <77dacc46-7294-47c8-899a-fd56b6a2af55@riscstar.com>
References: <20261005230927.2000398-1-elder@riscstar.com>
 <20261005230927.2000398-2-elder@riscstar.com>
 <20261009-gifted-stylish-tortoise-95b14d@quoll>
 <b190fe58-364b-4b94-9cab-c5f81f874289@riscstar.com>
 <aafe2703-bfb8-43da-8472-b1dfa36fa8f9@kernel.org>
 <77dacc46-7294-47c8-899a-fd56b6a2af55@riscstar.com>
Date: Fri, 09 Oct 2026 16:38:26 +0200
Message-ID: <1jcxtjos65.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On ven. 09 oct. 2026 at 09:23, Alex Elder <elder@riscstar.com> wrote:

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
>
> I only mention its existence as a reason to justify defining
> the clock as a separate device, but I realize you are arguing
> that I should do it somehow differently.
>
> 					-Alex

While on the topic of description, I'm little bit concerned that this
controller does not any input ? Does it have an on-board oscillator
somehow ?

None of the clocks described in your driver take a parent from what I
can see. It is as if the clocks of this device are generated out of thin
air. Is it really how this works ?

>
>> 
>> Best regards,
>> Krzysztof
>

-- 
Jerome
