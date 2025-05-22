Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AEF28C5C1
	for <linux-hardening@vger.kernel.org>; Thu, 22 May 2025 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747924794; cv=none; b=jv4Z1HlONzN9mue+dekUV0DH1OxUY4kUYhBpRR6b3HHZjgJgd/zxOQv09tx4pa0gi1KdncU2ppJ3MBa84i1JK4TvOk7IxxEk8XUgIj3WUG8FwAuCNFqDPgV0NmWwo4MmPLRAhj1Rp8zNud+lAKa/5uR3MRSurVQProT6Dj7S3Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747924794; c=relaxed/simple;
	bh=YKlbXnURs97TmbTpjUezNbI938aiKGi/vqj82PNrfgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1JTBUyvVYlzxAT3QrNcs+kuM9M7uSIKEUOpSVFUVDT9PAxgVVJ9qYlZSNt7FKHlC2UGBK2X9mqYV2ghsoh8ArK4mbo/xBZ1XXAxyGdvYqX5rNZlXmZvoT0xlCUTtQMaqhZ/kiDd4zM/hUmdFplmr6S0eqsCs8rnsWGDpTo1EQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=QCvAumpQ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="QCvAumpQ"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5f3f04b5dbcso12229517a12.1
        for <linux-hardening@vger.kernel.org>; Thu, 22 May 2025 07:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1747924791; x=1748529591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5dUW3XcT56QSO6IzrjYqsZTqvCBor25DIllhfgnMqf8=;
        b=QCvAumpQmugaw0sbSIj8flMl4Rjm4dyNn71jU06GSadnbIFiluK9vVU1TkWoVf+MM7
         CYLILaNBEi8emIR3xNY6MN/CKcpuGpa549RPt83W0qQLaYSFiVlfZ12vt3i7Selu1Cqy
         fixKIP2nVTwQkLC1hg/vwgQMjat2mBbN3O1EWHvzpMQPWpqg0C6NPVRcARO6g4XuldHs
         a6cjWspkl2+reFmJKmkCkVh945GqIv3HZAMdztT1taodPCzSqOtkrNVBq/JV2YjhcYVu
         uz8BbByVeP+GsJEBQ/HVjBcCnQS2bwkIWr62sXDq3miABZtUMGRiXso7KK54e+2ejKpU
         hUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747924791; x=1748529591;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5dUW3XcT56QSO6IzrjYqsZTqvCBor25DIllhfgnMqf8=;
        b=q0RwXEUkhAMbyQLkrxrvdY7kmXWLbR8/bBRVgreytimJ5cWx/1rZvONlPMYMRM5MMR
         0EpMawc7JBT8+ESeOO3dSja9a62oaQrjhYvP8W6MMBlZI2K7MJmUIEcmrgF1GqfJI5fo
         A7pNjtOSq33YfcCr/izQ322VGWUEFioufeJyynt4opaukQyoGWb1u0/fspt18eDD532A
         QsTAax+1mOLd1Z6zDjSCKs/cFJrGvF/m2UbK5lgWvxeyar32sLzew4q0Badmc2HluWW/
         /D+AHza0cELIJL2JSD87xzO1DcllUI8GsjxsD+y4dYWxSpo1cYQBsvdqD+E25Izb8Jp1
         fHqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmIb9E07YoeRJA7l90m7ZfVtncoXYXCashsN/Ao38EYxegQyIM1OPonjkxzStbWyTyaCo5zeK3lOFrfrjFfQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycun6firlGb/RevLGzLTtBPd/n9RQAygZ1sfO7VJ9XIMXcT5n9
	WLhWAAP47h0SmL0NYv5l9p47g1LBMjEunEeJql9FGKgwpnagBdP4ImQ2WxsMdT4zDs8=
X-Gm-Gg: ASbGncvR9gDabzekrPclBvPfDwJGCC1BV7MKwNk2ZMD5BhZzYUi7CAuibuj8RZF1sT6
	lhsMomDERFJZ88J9SFnMbokzs9vv+rhPGhqtGv35SNI/Ie7CpYvQ6NEoroB/7ZBFaTUO+qemvuO
	3ZmZAatN4ZcuaV/Be5OnYw+eho9PLKbtesafC2RoPObcpPTTuFhKOzLFPBJ9FLL6Ie3U3Wz1PU3
	zAWgWVnqcQBrbTJsp4T1Wa/vVGSQbZzJtfQkZ1Z90BU1vEMDV71RsSx1QG1yjnI65QkQMebrtnX
	tcCtxU/JRjFqQt70s+CuxE9Cv+wGUIQxACS0gClI0XjAGtSu0GCA7sVC1P8=
X-Google-Smtp-Source: AGHT+IE/RdKTMZdYx9F6yx1Kzprvz+cSKkMQRkLYiOsz7mEXFrIWg/Hdk4IKesUgJcilzgg+XPJrLQ==
X-Received: by 2002:a05:6402:34c8:b0:602:4405:777b with SMTP id 4fb4d7f45d1cf-602440578f8mr5149377a12.24.1747924790721;
        Thu, 22 May 2025 07:39:50 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.58])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6004d4f1c7esm10543212a12.14.2025.05.22.07.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 07:39:50 -0700 (PDT)
Message-ID: <797611e1-3786-45c4-9103-3ee8f96cec6d@tuxon.dev>
Date: Thu, 22 May 2025 17:39:47 +0300
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
 <b22e7a46-7e35-4840-aae3-a855c97fbde4@tuxon.dev>
 <4a07048a-c55a-4fd3-b4e5-7f9d218de76f@kernel.org>
 <68d83aaf-280a-4c19-becf-c6e1d9c2432b@kernel.org>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <68d83aaf-280a-4c19-becf-c6e1d9c2432b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 22.05.2025 15:48, Krzysztof Kozlowski wrote:
> On 22/05/2025 14:46, Krzysztof Kozlowski wrote:
>>>>>  
>>>>> +  - if:
>>>>> +      properties:
>>>>> +        compatible:
>>>>> +          contains:
>>>>> +            const: renesas,usb2-phy-r9a08g045
>>>>> +    then:
>>>>> +      required:
>>>>> +        - renesas,sysc-signals
>>>>
>>>> That's ABI break.
>>>
>>> There is no in kernel device tree users of "renesas,usb2-phy-r9a08g045"
>>> compatible. It is introduced in patch 11/12 from this series. With this do
>>> you still consider it ABI break?
>>
>> Then this patch cannot be split from binding introducing the user. Don't
>> add unused/undocumented compatibles.
>>
> Or you meant DTS?

Yes, I meant in tree DTS.

> I asked about ABI which is not about in-kernel users.
> You can always change in-kernel users, so what would be any point of a
> binding and its ABI?
> 
> Best regards,
> Krzysztof

