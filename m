Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CDE262FF3
	for <linux-hardening@vger.kernel.org>; Thu, 22 May 2025 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747909582; cv=none; b=FeIviNdar4GfJAFzFRNwo84q8/jo5AH3Y6nQZrZz8yt/fdRdWuRNLRBpd0r1vNcLhFrweUC0kmfDnIHLP6vqJ1KF4Ig9v9b1K23NUZ/V6jKXv+ZX+4D4wfHFBMjYKcGayZV4bPwYUCJUtWUQUn3ecO843FLlQ7QebWh5fwcwwis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747909582; c=relaxed/simple;
	bh=ZAibypLz7SpD/NECdINBzP034MLktmjX8S/ADPCEy7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lUQpjTkQkvtH6PBU4hF+x4wbiLuK3IKh9Aas7mzFO3yo/VgOhjPpXkiE1GaU4I3yAw88tZHYr6MGZvBqMCkd/5OwDLdvf3nYeQ8YjiKjPawUZtIUVh+pr5cOWoJvwFgirSCAAAIcSX2tKDbqzFDxUp7sZiEtlESyNj+vVY2DwtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=jW3Arjzp; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="jW3Arjzp"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6000f2f217dso9888553a12.1
        for <linux-hardening@vger.kernel.org>; Thu, 22 May 2025 03:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1747909577; x=1748514377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4caaPIV8qSqyjNDB+/IzXFji0RZ7hdRuW08/jzohm/U=;
        b=jW3ArjzptrQceNz0L44mb3vjvznbdkUVUvKlJBQ82Eop59XSzFPO+haSlfwYOfUUjs
         gwrB8uYVnjIsqabm8W4iv/KBjC08ej6IPtc2UohCfHaCKk5VLbHfm1brhzmsP1oKLb4V
         dJHoJV4g5l5lWhJh57NzaTEGHa6OX+U68EDz+cFY/W2FhguT2zJKpCFBYA/i2b/+ut1F
         EPH3g+XuJQKz4S0ka3DpaRea1Gx1ZW967sJlr5tEx5pqGvfCru8jjDUS11EMjf+pvoMR
         gdsccM6126An1LzYV22CuPeSq8rfqxWlfv7lRhyikE8ZYiV5f0J8YNs3SLlFsIMWRaxV
         gG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747909577; x=1748514377;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4caaPIV8qSqyjNDB+/IzXFji0RZ7hdRuW08/jzohm/U=;
        b=l+Jx16m8VCNM+aWnlk5epamQ7eNuP+OuUEnQx2/sxQxjE8/ff36Dk1Tr+P9Aokw8+C
         Ex+XQEFPE46jV8EfAPzkbj7aElNZVlfcVfzRQ+7PGS/3IhPhLj7IiMs/+Kbb1X0ew8c2
         C/u9Lge2Bo4h04b1qZvSqKQWdZ9UzS89AqP1b71EzY0zJee9vZGPVNvXORE6CCNeEMbJ
         TN8RSez31SC5B8XkaswZi3cg9dWOxRlzx3s3NzCewzXx02abFEOYZlYJNPETUhVGRm6/
         p9M3XOU3iQO8GqRErjNscy2wuwzqPQkPq1k41eaPjVpcE85Dh/68p8SIlECyGAJs+ENT
         D9Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUQXgkd9od8S9X1yEEAdTFfeR8OTDFJxT7fvECbP2SV5pJJmfqkkC5SRhA8Y0JTtFR5WVXOx/fTMgbzuu1jdX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxxfkUgfbwU2GQ9VcBNLJ10F0YFzC+bkJHGk9KzHby5VvHHwlN
	StAgW9hkwrZ0x5oMVBgAIyPQDlvuTnW1meh7puBy8xeoKDocr9phxd/1UfIzfQoC9EU=
X-Gm-Gg: ASbGnculeOBXnSAIcawjHnEeQwzDkMCAB63UTZwaqu7mELsPSaxh0EIWQGd9ySz7KyL
	axkr4iTrxKkipo0Qj737qFXKG1p50EKxIN74o/tplsW+FzrRXLx91e1Tj0Uymh0sICwkE+E8lIt
	eF/mLcgfbBbrDenVtOHY7FM3tKHwqAr9b6IZwa5Yi7fzaxtLI/NraWbipShqIeNa4RQVww4SN/m
	jaeUBUAsDVoSS/oLUPy3UaRlfVbR0xZiyjuu22pq20Ks7Ve3VQYE8upKVAxsqNQmGhsQu7IGCxC
	aZ+ZbdyCFPVQpdUeuhVPu+3fLHvQKuGQBJltjw6Dhz8cwTAnXu0N89Kdu7s=
X-Google-Smtp-Source: AGHT+IFNGKRAQxDRw8YM6Df3ufbn3AseFb7JOrrDRAzOp7oR4YS6S6ab1Ixfj0XButiJTgZDbSswiw==
X-Received: by 2002:a17:907:6eaa:b0:ad2:238e:4a1b with SMTP id a640c23a62f3a-ad52d498e5dmr2363750366b.15.1747909577064;
        Thu, 22 May 2025 03:26:17 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.58])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d4cadc5sm1046004466b.167.2025.05.22.03.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 03:26:16 -0700 (PDT)
Message-ID: <b22e7a46-7e35-4840-aae3-a855c97fbde4@tuxon.dev>
Date: Thu, 22 May 2025 13:26:15 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] dt-bindings: phy: renesas,usb2-phy: Add
 renesas,sysc-signals
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, geert+renesas@glider.be,
 magnus.damm@gmail.com, yoshihiro.shimoda.uh@renesas.com, kees@kernel.org,
 gustavoars@kernel.org, biju.das.jz@bp.renesas.com,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-hardening@vger.kernel.org, john.madieu.xa@bp.renesas.com,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250521140943.3830195-1-claudiu.beznea.uj@bp.renesas.com>
 <20250521140943.3830195-6-claudiu.beznea.uj@bp.renesas.com>
 <20250522-evasive-unyielding-quoll-dbc9b2@kuoka>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250522-evasive-unyielding-quoll-dbc9b2@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Krzysztof,

On 22.05.2025 10:03, Krzysztof Kozlowski wrote:
> On Wed, May 21, 2025 at 05:09:36PM GMT, Claudiu wrote:
>>  .../bindings/phy/renesas,usb2-phy.yaml        | 22 +++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
>> index 12f8d5d8af55..e1e773cba847 100644
>> --- a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
>> @@ -86,6 +86,16 @@ properties:
>>  
>>    dr_mode: true
>>  
>> +  renesas,sysc-signals:
>> +    description: System controller phandle, specifying the register
>> +      offset and bitmask associated with a specific system controller signal
> 
> This is 100% redundant information. system controller specifying system
> controller signal.
> 
> Drop.
> 
> 
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    items:
>> +      - items:
>> +          - description: system controller phandle
> 
> What for? Explain the usage. How is ut used by this hardware.

OK, I though I've explained in the renesas,sysc-signals description
section. I'll adjust it and move it here.

> 
>> +          - description: register offset associated with a signal
> 
> What signal? That's a phy.

Would you like me to specify here exactly the signal name? I tried to made
it generic as the system controller provides other signals to other IPs,
the intention was to use the same property for other IPs, if any. And kept
it generic in the idea it could be used in future, if any, for other
signals provided by the system controller to the USB PHY.

As explained in the commit description, on the Renesas RZ/G3S SoC, the USB
PHY receives a signal from the system controller that need to be
de-asserted/asserted when power is turned on/off. This signal, called
PWRRDY, is controlled through a specific register in the system controller
memory space.

With this property the intention is to specify to the USB PHY driver the
phandle to the SYSC, register offset within SYSC address space in charge of
controlling the USB PWRRDY signal and the bitmask within this register.

The PHY driver parse this information and set the signal at proper moments.


> 
>> +          - description: register bitmask associated with a signal
>> +
>>  if:
>>    properties:
>>      compatible:
>> @@ -117,6 +127,18 @@ allOf:
>>        required:
>>          - resets
>>  
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: renesas,usb2-phy-r9a08g045
>> +    then:
>> +      required:
>> +        - renesas,sysc-signals
> 
> That's ABI break.

There is no in kernel device tree users of "renesas,usb2-phy-r9a08g045"
compatible. It is introduced in patch 11/12 from this series. With this do
you still consider it ABI break?

Thank you for your review,
Claudiu
