Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047F24A7CA0;
	Fri,  9 Oct 2026 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554175; cv=none; b=MeanliDoWe8FOpUmUpmrks3cNZuB6viVVFsZ38V8kTAhBZ8G3cHqlqmnCqfp1ZRNdRPjphAn3PebeJKcr2FcD8t4ROgzvcghdFWP/ylR8KVYhwB9CfmB605E4tKCrYesjkbr/NRt//ujMKIhqlo/DAjSjvGX7Rf6aiIyES05Spc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554175; c=relaxed/simple;
	bh=MPjbQE/OEp3RfABQDN3aEJoRDPy5FBYbL6yuafzhE08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LUb0CkLYyjIJbJgRKIl+VMJ6g3mrYNSrY+bXbAmUGlgI5bAj/UlHN0hYDQUNp0TC8KYrzX0QkNgVdYdQekKXMiTWioWkwWnQwiHvfg/HbdvSx2nxQGcSFwuMRKqW6B9mkS8tQHa9zx0SXKfIc48EOqO9Nifq6MB7UsJ7/96E6WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5jbHCM0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5jbHCM0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1EDB1F000FF;
	Fri,  9 Oct 2026 13:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791554173;
	bh=DtJF/GweLIbUbR7hLO3F/tfaCi8SaxiyqPsE9UseAwA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=m5jbHCM0WZali60BtOLW4t5nKpQACD91YWLUvfKX82tf0ZA/JpTI+ED+gSe6T9SOl
	 Cd4iwdr6AlsO3AegonNOeZtWHfCFiRM3M88Moa0DVG1HuYKHkXIn5k9yzlAlHeM4a8
	 0u5GGNwWUJVp003BSxHbZgoMYjkcKuC+6K5HxcQtLuP8ovV4XcrRalv5PN2aKEg43u
	 dhSR+TiGQsRZv4ezqNcfg5/MDRpc1/Rf8E3/y3GpNaozOD874KkhTgKmdh8fTlaGqV
	 2ha0idH9F657czAEi4TJ3bljkh+iAmTSGayuyN8qkv6i+HvfTpl/AziNZWr7TWShUh
	 LoCFWyzXH4Dtw==
Message-ID: <aafe2703-bfb8-43da-8472-b1dfa36fa8f9@kernel.org>
Date: Fri, 9 Oct 2026 15:56:03 +0200
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
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <b190fe58-364b-4b94-9cab-c5f81f874289@riscstar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/10/2026 15:44, Alex Elder wrote:
> On 10/9/26 4:31 AM, Krzysztof Kozlowski wrote:
>> On Mon, Oct 05, 2026 at 06:09:24PM -0500, Alex Elder wrote:
>>> Define the binding for the clock controller functionality present in
>>> the Toshiba TC9564 SoC.
>>>
>>> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
>>> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
>>> Signed-off-by: Alex Elder <elder@riscstar.com>
> 
> I'm just about to send version 3 of this series (and
> then a new reset series derived from the code that was
> previously combined with the clock code).  Some things
> related to what you mention have changed.  I show that
> below, but also respond to your other comments, and try
> to advocate for the approach used.
>>> ---
>>> v2: - Only define clock information, not reset information
>>>      - Reworded description to avoid talking about software
>>>      - Clock IDs are now consecutive (no more commented-out values)
>>>
>>>   .../bindings/clock/toshiba,tc9564-clock.yaml  | 54 +++++++++++++++++++
>>>   MAINTAINERS                                   |  7 +++
>>>   include/dt-bindings/clock/toshiba,tc9564.h    | 34 ++++++++++++
>>>   3 files changed, 95 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/clock/toshiba,tc9564-clock.yaml
>>>   create mode 100644 include/dt-bindings/clock/toshiba,tc9564.h
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/toshiba,tc9564-clock.yaml b/Documentation/devicetree/bindings/clock/toshiba,tc9564-clock.yaml
>>> new file mode 100644
>>> index 0000000000000..329b8f002cf2d
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/toshiba,tc9564-clock.yaml
>>> @@ -0,0 +1,54 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/clock/toshiba,tc9564-clock.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Toshiba TC9564 Clock Controller
>>> +
>>> +maintainers:
>>> +  - Alex Elder <elder@riscstar.com>
>>> +  - Daniel Thompson <daniel@riscstar.com>
>>> +
>>> +description:
>>> +  The Toshiba TC9564 is an SoC accessed by a host system through the
>>> +  upstream PCIe port on the PCIe switch it implements.  The switch
>>> +  includes an embedded PCIe endpoint that provides access to various
>>> +  SoC peripherals (including a clock controller) via its BARs.
>>> +
>>> +  A total of 21 clocks are implemented, though two of these are not
>>> +  controllable.  Access to the clock controller relies on PCIe being
>>> +  functional, so the PCIe clock is assumed to be always on.  Similarly,
>>> +  the PCIe controller relies on I2C, so the I2C clock is also assumed
>>> +  to be always on.
>>> +
>>> +  Clock ids are defined in <dt-bindings/clock/toshiba,tc9564.h>.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: toshiba,tc9564-clock
>>> +
>>> +  toshiba,config-syscon:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description:
>>> +      Phandle for the configuration space system controller.
>>
>> I do not see my previous comment addressed - you have no resources here,
>> so this belongs to the parent. You responded something about pci-ep, but
>> the parent is not pci-ep. Open your code:
>> https://lore.kernel.org/lkml/20260918165234.687224-5-elder@riscstar.com/
>>
>> I clearly see code like:
>>    syscon {
>>      clock@ {
>>      };
>>    };
>>
>> so I do not understand what pci-ep has anything to do here.
> 
> What I have now (about to send) looks like this:
> 
>      syscon@0 {
>          compatible = "syscon", "simple-mfd";
>          reg = <0x0 0x2000>;
> 
>          clock {
>              compatible = "toshiba,tc9564-clock";
>              #clock-cells = <1>;
>          };
>      };
> 
> A reset node will also go inside the syscon, so there is another
> function for that MFD.
> 
> The regmap belongs to the parent, and is looked up this way:
> 
>      regmap = syscon_node_to_regmap(dev_of_node(dev->parent));

That's driver code, so irrelevant. So how does this solve my comment
from v1?

> 
>> What's more, I still do not see any usage of these clocks outside. And I
>> still did not receive actual answers (or I missed them) how these clocks
>> are routed OUTSIDE of the connector. You said for example:
>> "Ultimately the TC9564 SoC has a single 25 MHz input clock,"
>>
>> but that is input. I did not ask how this device receives clocks. I
>> asked how the host receives the clocks from this device.
> 
> I was explaining that the clock input gets split into a number
> of "output" clocks derived from that one input.  However you're
> right, almost all of these clocks are connected to blocks
> internal to the SoC.  There is only one 25 MHz clock that is
> exposed externally (CLOCK_REFCLKO).
> 
> I think your point (or one of them) is that, even if pci-ep-bus
> is used, the only things that warrant being described with
> devicetree are those that can affect things outside the chip.
> Everything else is not really variable from the perspective of
> the platform, and inner details can be determined (and controlled)
> by software.
> 
> 
> Our original version of this code incorporated clock and reset
> control inside the networking driver.  Rob commented that the
> DWMAC driver should bind to the PCI functions and "everything
> else...should be under the PCIe switch upstream node in a
> pci-ep.bus".
> 
> The only driver associated with the switch inside the TC9564
> is the special power control driver, accessed via I2C.  The
> PCI switch functionality is otherwise provided without any
> special handling, or is handled by generic code.
> 
> What *is* available is the PCI endpoint functions and their
> BARs, so the endpoint buses use those.
> 
> PCI endpoint bus makes available things that devicetree
> does that are very useful (including a standard way of
> describing connections between blocks in the SoC).
> 
> 
> I know that doesn't address the "exposed clocks" issue,
> but it provides some background on why things were done
> the way they were.
> 
> 
> The single exposed clock *might* justify presenting the
> clock controller device in devicetree.  There are also
> resets exposed externally via GPIOs, and these control
> external entities (PHYs).

I cannot find any of these exposed. Please point me to DTS code showing
this.


Best regards,
Krzysztof
