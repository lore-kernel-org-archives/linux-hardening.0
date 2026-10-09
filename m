Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8214E80DD
	for <linux-hardening@vger.kernel.org>; Fri,  9 Oct 2026 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791559687; cv=none; b=Urgy2XkeuWdPVIlvyAnUdahC/T73/ziIgZFAbpgOZY9F9RmsQwCd3qvW9SAG/p4FURmXpiM4aLob1pLyuF5wGVXvBHkAbRXV5Wlv6RkyMclkJemdQBWHBq9SQ28mKwopMiQc2Aa3U1l2Zpxj7DXuTKFS9dJbHbkGPdP7EoHV0Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791559687; c=relaxed/simple;
	bh=jfmaWnctqSBU1dtFJUXd14G5f+Bwt3u2QsKEHr4Doww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cw5fwqiWOnbY9UCh8UIy002WH6jYYW1JliMzjdtveyMbl1u5ilGY4gwmO3wdJfK7X4GwJMykedUvlY/2Xq2xt8cnx790s6CxYogF4Jx5xaSIjdfthL9sw19EvSNpmATFLHBiDobLbJFjKRxVgIQsjgvGptVJAdg38nsSzzsLq0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=GFVMesmy; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="GFVMesmy"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-917a6dccc60so21363826d6.0
        for <linux-hardening@vger.kernel.org>; Fri, 09 Oct 2026 08:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1791559677; x=1792164477; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XWJIKajLi/Hl+bQHGE1r4qQlOKx5Aox6GAQJinOVg0Q=;
        b=GFVMesmyH/+lK1De9S/UhUOIGuSowSZ/JWylB+TNI4NI/iPlruc1C0JL8EuM3j16GS
         X2sOChe2yOk/4e8sQBL7IhdvnFWFHPo0u+M8P9OBQgLA0qfSNBb//NaIrmIhIBaiL1Sn
         IkZTNerL3Lx07Y1n9NJXbzsm+QOphGUeKmY5wYr1rorCc8MNJ+q0OR6LyW4uwG9LfAqz
         Qdhin89//2pCvCMusLmSrv22Nkqlk72pfKS0yKXVEKDVG3o0KYo4JV1y49/WtwhG6+u2
         KvfRzvb7RkixU5jz39hoXBosxxwpKopWAUM2Ao+L61jk0VCjgg1XIfGaeJcb8aw0HkFo
         7aHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791559677; x=1792164477;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XWJIKajLi/Hl+bQHGE1r4qQlOKx5Aox6GAQJinOVg0Q=;
        b=w+sVYtf69uq9r4AaG7RBaH+cJMdlUGBTSiQdlSsuq4f4/Peo+9EcONL3Am23DGavvN
         7lZV3h0/t8s2MSSevR/ulRbVOubQKUDAee472/FqT8ThUMWnmFUf64sOmnE+nfBVAEID
         vJYmh2ih+E8pNud9mLlLs66IOileSO7yTlLI8aP8B6V8F7pV2K6QceTSA3vWIhdkeR68
         +V+L6gxBOfZjBb0a1MMOCLUf9T1i0Fi7BYxp05kYcBkj9mikV3Hb/eXxFan4rvU/FIod
         MLL/0kF79Chedf+8v1WnrleAP3aK+21Mst65+o8RtpPYAofuJNggKmyM/Pjvk5LaNIFd
         EI7Q==
X-Forwarded-Encrypted: i=1; AKwUvBwhlFF/QKrVAzNog+sKR52ZSruE2xRPSRrjQROyWMsb8jtYnFDfLZW74swrGC0XkxZWuFk7f10oHH/uhJnVj2w=@vger.kernel.org
X-Gm-Message-State: AFq9FYJj5G5j+NJB/tWo5A9dPVlJzxCZNN5jUMYYFBH7Q9hmdFy33ZiB
	Aj7nCV9I/iYG1R8Z1l0lKe3Vc8+kYYVk8iJ3xTIA74A8k5Lpay2yMfA+seIboN3+Np8=
X-Gm-Gg: AYBFou3yGcqqXs73al/LKNO4CO2Fc7bVKcefK8fYVjlAKlwl55IivjiWaiYegxULoLX
	uYy3ze0Eg7MQg4PQjD5AxNQHJDqQMV7Rhogked5/vsfJ4p0M81rAeU62twNjFXFjfJxhtLqeKW9
	nFhJRT0ErKcSMA9ubXKJdJ/BhFbwkrfwTYVCG/TzYa4Xv3QO74vvZTYGLi2tm2WVnMGBPtMXBPS
	eZNEUxLXV2iHwdg8IbK1oihn1KcJaEA4aVV1S8salBF9TZqYCcR7xBbzUtjImb56kNkvhMwCzsO
	LBf2c2J+yz8rPZdfrZLCwfarW7KIcgrGgrcbvWEC2IGmfvRrZywkgI9eVLaXOlx8tNRAPzbHdJr
	yqnriwO0p95wu+bSDdk/SL96FaJPdUoDS/3lH+ZvQogz/7JwgPsDa8AotJ5p/51k+UJZDW4gO77
	/FBLHIbIW4A67Q7SpezRQ3RTu6BP6LHWhWurumAMOTEvXQcRdZmunnmL5pm6Bj3jA4fPSyZWA=
X-Received: by 2002:a05:6214:3015:b0:917:99d1:bda2 with SMTP id 6a1803df08f44-91b5d4bd16dmr23896676d6.8.1791559677476;
        Fri, 09 Oct 2026 08:27:57 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b55091fd4sm21019796d6.36.2026.10.09.08.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 08:27:57 -0700 (PDT)
Message-ID: <4a1dacc9-7642-48e4-b9e9-6a20c0e6aa43@riscstar.com>
Date: Fri, 9 Oct 2026 10:27:55 -0500
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: introduce
 toshiba,tc9564-clock.yaml
To: Jerome Brunet <jbrunet@baylibre.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
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
 <1jcxtjos65.fsf@starbuckisacylon.baylibre.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <1jcxtjos65.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/9/26 9:38 AM, Jerome Brunet wrote:
> On ven. 09 oct. 2026 at 09:23, Alex Elder <elder@riscstar.com> wrote:
> 
>> On 10/9/26 8:56 AM, Krzysztof Kozlowski wrote:
>>> On 09/10/2026 15:44, Alex Elder wrote:
>>>> On 10/9/26 4:31 AM, Krzysztof Kozlowski wrote:
>>>>> On Mon, Oct 05, 2026 at 06:09:24PM -0500, Alex Elder wrote:
>>>>>> Define the binding for the clock controller functionality present in
>>>>>> the Toshiba TC9564 SoC.
>>>>>>
>>>>>> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
>>>>>> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
>>>>>> Signed-off-by: Alex Elder <elder@riscstar.com>
>>
>> . . .
>>
>>>>>> +properties:
>>>>>> +  compatible:
>>>>>> +    const: toshiba,tc9564-clock
>>>>>> +
>>>>>> +  toshiba,config-syscon:
>>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>>>> +    description:
>>>>>> +      Phandle for the configuration space system controller.
>>>>>
>>>>> I do not see my previous comment addressed - you have no resources here,
>>>>> so this belongs to the parent. You responded something about pci-ep, but
>>>>> the parent is not pci-ep. Open your code:
>>>>> https://lore.kernel.org/lkml/20260918165234.687224-5-elder@riscstar.com/
>>>>>
>>>>> I clearly see code like:
>>>>>      syscon {
>>>>>        clock@ {
>>>>>        };
>>>>>      };
>>>>>
>>>>> so I do not understand what pci-ep has anything to do here.
>>>>
>>>> What I have now (about to send) looks like this:
>>>>
>>>>        syscon@0 {
>>>>            compatible = "syscon", "simple-mfd";
>>>>            reg = <0x0 0x2000>;
>>>>
>>>>            clock {
>>>>                compatible = "toshiba,tc9564-clock";
>>>>                #clock-cells = <1>;
>>>>            };
>>>>        };
>>>>
>>>> A reset node will also go inside the syscon, so there is another
>>>> function for that MFD.
>>>>
>>>> The regmap belongs to the parent, and is looked up this way:
>>>>
>>>>        regmap = syscon_node_to_regmap(dev_of_node(dev->parent));
>>>
>>> That's driver code, so irrelevant. So how does this solve my comment
>>> from v1?
>>
>> I'm trying Krzysztof.
>>
>> The clock controller uses two registers, 0x1004 and 0x100c,
>> to manage whether a set of clock signals are enabled or not.
>> (The reset controller uses two adjacent registers, 0x1008
>> and 0x1010, to manage whether a set of reset signals are
>> asserted or not.)
>>
>> You said "no resources except a small address space" and I
>> guess it's not clear to me what size is "big enough" to
>> warrant representing something as a separate device.
>>
>> *One* of the managed clocks is a 25 MHz clock, exposed
>> through a pin on the SoC.  That one clock signal is
>> therefore usable by the platform (although on the RB3gen2
>> it's not used).
>>
>> Rather than expose the register addresses in the clock
>> node, a syscon is defined, covering 8 KB, and the actual
>> offsets used are just defined in the clock and reset
>> driver source code.
>>
>> If that's not the right thing to do, please say that.
>>
>>>>> What's more, I still do not see any usage of these clocks outside. And I
>>>>> still did not receive actual answers (or I missed them) how these clocks
>>>>> are routed OUTSIDE of the connector. You said for example:
>>>>> "Ultimately the TC9564 SoC has a single 25 MHz input clock,"
>> . . .
>>
>>>> The single exposed clock *might* justify presenting the
>>>> clock controller device in devicetree.  There are also
>>>> resets exposed externally via GPIOs, and these control
>>>> external entities (PHYs).
>>>
>>> I cannot find any of these exposed. Please point me to DTS code showing
>>> this.
>>
>> It is not used by this platform, but is available for other
>> platforms to use.  Its name is "REFCLKO" and is exposed on
>> ball C17 of the SoC, if a platform designer decided to use it.
>>
>> I only mention its existence as a reason to justify defining
>> the clock as a separate device, but I realize you are arguing
>> that I should do it somehow differently.
>>
>> 					-Alex
> 
> While on the topic of description, I'm little bit concerned that this
> controller does not any input ? Does it have an on-board oscillator
> somehow ?

No, it has an external fixed 25 MHz input, and this is a good
point, that should be represented.

> None of the clocks described in your driver take a parent from what I
> can see. It is as if the clocks of this device are generated out of thin
> air. Is it really how this works ?

No, you're right to point this out.  Thank you.

					-Alex
>>>
>>> Best regards,
>>> Krzysztof
>>
> 

