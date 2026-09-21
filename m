Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D227518120
	for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 21:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790027209; cv=none; b=o0podaa1KdzRqWzRTZfMhVG7rYbyuyTYtvIoHFZKJgUv6/fK9kFC4E921BAlq/V0JNrC6IH9idmdGbeuypDYY/2jqmYq2Gvoc+W33K9uoNgsMjsDLCRz/4HIaoi3HDZXwKELiWylyhW/ehT3rdO3Ksg8+u1BSK9R6fBC6qeM0hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790027209; c=relaxed/simple;
	bh=Yc5Uc7ZFw+ABZqHHGfrsDtaZfnUyH0lPgtl/XXBBFbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oA15NRBvci906MTMIDOzHSW+JhdIBGVdzswZ8yf8x3W9eP35IzUAu5ZtBgD5qBgRoLMOC/ZGnncIsvkJ9TyxBahorBBhJjVR80kF3e+WiU6mByJomRn6i59g5FDVYUhZGpXfZ+TLxhvKTRrsXtuJRXeX6sgDs+rI+O7ARzixmXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=usOtonDa; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="usOtonDa"
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-939109fafd7so279617085a.2
        for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 14:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1790027204; x=1790632004; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MZyT8k12LGsI6T36jz5Fg5RlaOjRcJ/zSXFiTQ+h2nQ=;
        b=usOtonDaMYeMX3ZXgZaMup8ty4PM3XVEiN6I9tL/g6jEtooQtrH3AtpmkoV3OKDhGI
         CzO8IsyvLopA/W4KWaJDJ0TOuGFmA8BP5aFb7z0qnz4WqAxVWyAKeU8rBM4xeYv1Wq18
         T8psDYuiEpG+4hSUXXCkBp+RV89Kcmoqqw2Sng4JI5oVqP3kwkGwZ4ry9UsZkw/rZ78E
         MCAsCOanEbPyYgdzjH00LujvZA1sCg5Eh2qGEptbkdreLbkHvf4zp+zoX3NnUaXAemV/
         fozqoRz9M+kei7U5YJmCTtEHdTltjJojezjJOZtxhLi6CThD0oYhRnRkxNUxjQ30v5sd
         uEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790027204; x=1790632004;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MZyT8k12LGsI6T36jz5Fg5RlaOjRcJ/zSXFiTQ+h2nQ=;
        b=UDXXyr3V8YF0HVq8CzWqf5JxdCRnunKHf/wrWcVHKyvW3zJitX4botW5YY5uQhf1jq
         3xtLlpEOUCYKjCNXeRP6b2dAqjPKP6CSgcVOZtiLm/efncUrU0Fyo960JIs5YIGRujw6
         Q7eJBr7t07MOSbI2IC+KaRZRqi9q8WLhsMaT5kW0NaXp1tnDhpaBjEVjXMefue4Rl/hw
         3TUidiRkvPXG9kz9mQzFBf1+6pr8g+A/utGyUarB2snbW0GohNkBSLfvI6GDFdHwWLYj
         FoKZWMLC5PM7LZcirB2O/QxyOyupVAREKghQ8I+rg9ZNJJifftOEKjsxN7nJ+kZ4pPci
         2Ygw==
X-Forwarded-Encrypted: i=1; AKwUvBypabepqOl487FrXj+vu5pPv4l1KnLAZ1ZGx/Jrq5qvw9aysi28IMjIPCx6r9B3T82791n1f0cWXxSUWJCg/1c=@vger.kernel.org
X-Gm-Message-State: AFuF++mJ8HsRkaRsQ4O6cjTbTphOVQTPqmJz60rPGVfdrnMdXR7c72uo
	sC2pWfiFhMQtcAW0FeqL0xwyeQmnsf4y+7Jgh6PW5Sd6Omf6Kforxn8o78cOIjow/VQ=
X-Gm-Gg: AYBFou1HTRDHQYHzl/md+C2l9rebOyFnbL1Olmce9mbihjA4LPQFK8pkW5Z8nWTmKuB
	R0RR9x3GK67nh0jdlqQhzT1po1hcSfTce+Ofy0aNDbxcU+JwdSnFob202tVtwSMKah2igDtWmlV
	bMkMZ7jBWUhC5WGqErzpz3b1thgghkUzoZVO9RzerdLXdgwXYKjAqtqWqHKDKI5qZP4XcNzTqCl
	98R45VSItX95amZKbCmJOzktOIM9gwUtZhD/+uhUTW21yOnCJ7H4Fn1pdwTZ/wsaOHII1iTyykw
	YIGErGkwWqcnS8SmX47T9kKGQYFiyHkCWXs/1j3VlA8PvXDVhEyC2DlTqNvFH8Hj6OWTt6qgejo
	kDoJi1NJJCL/6JuQ8S0adqXhoBeK6nuaOQRSeAgzHPLeuv/Zj7EhrNHEqlRHuwN3aWBcHx4Zyr9
	HjoyKSIsLdJyDSsC3vX6dkKOqtSWqyjxfvob/pqwOZfSbZ0HgJKWavrrxVrD4PEzG9/GRnAwI=
X-Received: by 2002:a05:620a:4496:b0:93b:d7d7:8739 with SMTP id af79cd13be357-93c15e4296bmr271488185a.46.1790027203515;
        Mon, 21 Sep 2026 14:46:43 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c19a604dasm24653985a.11.2026.09.21.14.46.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 14:46:43 -0700 (PDT)
Message-ID: <85b0e7de-e4a8-4e08-b801-a9664d366e1a@riscstar.com>
Date: Mon, 21 Sep 2026 16:46:41 -0500
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: mfd: introduce the TC9564 config syscon
To: Krzysztof Kozlowski <krzk@kernel.org>
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
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260920-fiery-fanatic-manticore-6abf0a@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/20/26 1:18 PM, Krzysztof Kozlowski wrote:
> On Fri, Sep 18, 2026 at 11:52:30AM -0500, Alex Elder wrote:
>> Define the binding for a system controller used in the Toshiba
>> TC9564 SoC.
>>
>> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
>> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
>> Signed-off-by: Alex Elder <elder@riscstar.com>

Thank you for your feedback, Krzysztof.

>> ---
>>   .../bindings/mfd/toshiba,tc9564.yaml          | 56 +++++++++++++++++++
>>   MAINTAINERS                                   |  1 +
>>   2 files changed, 57 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/toshiba,tc9564.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/toshiba,tc9564.yaml b/Documentation/devicetree/bindings/mfd/toshiba,tc9564.yaml
>> new file mode 100644
>> index 0000000000000..32e73a727c82a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/toshiba,tc9564.yaml
>> @@ -0,0 +1,56 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mfd/toshiba,tc9564.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Toshiba TC9564 System Controller
>> +
>> +maintainers:
>> +  - Alex Elder <elder@riscstar.com>
>> +  - Daniel Thompson <daniel@riscstar.com>
>> +
>> +description: |
> 
> Do not need '|' unless you need to preserve formatting.

OK.

>> +  The Toshiba TC9564 is an SoC accessed by a host system through the
>> +  upstream PCIe port on the PCIe switch it implements.  The switch includes
>> +  an embedded PCIe endpoint on one of its downstream ports that provides
>> +  access to various SoC peripherals (including a clock and reset controller)
>> +  via one of its BARs.  A system controller provides managed access to the
>> +  first two pages of this memory region to ensure accesses made by these
>> +  peripherals produce well-defined results.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: toshiba,tc9564-config
>> +      - const: syscon
>> +      - const: simple-mfd
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  ranges: true
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 1
> 
> Both properties and simple-mfd are redundant. You do not have children.

I think ranges, #address-cells, and #size-cells might have
been left here by mistake, and I hadn't noticed.  (They are
required to be included within a pci-ep-bus sub-node, but
even if that's why they're here, they're in the wrong place.)

I will remove these three properties, as well as the
"simple-mfd" compatible string in version 2.

>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +unevaluatedProperties: false
> 
> And this should be additionalProperties instead

OK.
>> +examples:
>> +  - |
>> +    syscon@0 {
>> +        compatible = "toshiba,tc9564-config",
>> +                     "syscon",
>> +                     "simple-mfd";
>> +        reg = <0x0 0x2000>;
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        ranges;
> 
> As you can see here - no children.

I have seen some examples of syscon nodes that incorporate
sub-devices, while others do not.

Our purpose for defining a syscon here is to coordinate
access for multiple devices to several registers located
within the same page of memory.

I think this device was originally defined in a sub-node
because the only memory accesses it requires are within
the range covered by the syscon.

Should we instead define the syscon to be a fairly trivial
standalone thing, and then refer to it in the clock/reset
device node by phandle?  (Or have the driver look it up
by compatible string?)

     tc9564_config_syscon0: syscon@0 {
         compatible = "toshiba,tc9564-config",
                      "syscon";
         reg = <0x0 0x2000>;
     };

     clock@1004 {
         compatible = "toshiba,tc9564-clock";
         toshiba,config-syscon = <&tc9564_config_syscon0 0x1004>;
         #clock-cells = <1>;
         #reset-cells = <1>;
     };
> I also have doubts that this is needed - I see no updates to the misc
> binding, which would be referencing it. But then another point would be,
> that you do not need separate child node, which has no properties.

I'm sorry if I'm missing something.  I saw other examples of
syscon nodes being defined, and tried to copy what I saw, but
obviously got it wrong.

> Well, has one - address space.
> 
> Lack of full picture is not helping here.

I will gladly provide a better picture, but I also want to
stay focused on what's necessary for the binding.

I have more in my next message.

					-Alex

> Best regards,
> Krzysztof

