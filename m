Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271177;
	b=WCIvMXb8WQb/wZeydXoevMFtvDjdsVeXSZ1QX/iYnc3usXIYBepwQbkcXsW3vM3l1eVs
	 40Epiidvaj7wA8PDIAbTroWBnZWR9TvYe/PHrWYk4DbiB5jnRyjJirR2OXbCjcFKMYeBs
	 1E+2wvkv/uxlsbodtsewgyj7XPWmNhTxzA1mW11ulbiu4NcT+EULHrv2TU9WuafneDVi9
	 5eVUMJzQay6VBOu98pnk9Fo8uZDlwvOAgyQkfWQT+64bN3ASVUcnEtYA31HCHgVwRG4ov
	 xluhuS2pgKSL3hK2pjzwbyDwieBAdZTRWWqFAInN4hRAsI210P39lctUV2Jejn5yK8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271177;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=IoWT26L+lCNjLByITvEDqGCl/vVklbh6utt0NNZqd+U=;
	b=CKW/FvNX9HnuoynqLZNaLqid9wXVsfvjnZVpE0k2Jeg3MlHYEv3RLlvmbMibYViZdQ94
	 kqhXM0v9k/7QZpnJw3ZDGForgHbP/+sxC0nORjizZGAwVV7vS1/3WUi3X5AQ77wnaU183
	 pI6Tz5+Q+RX3+XPaPoLCpKq3mMB90Osyyu0PrrnjJW7lQUdpBasjvFWlOIEwsU3ePgpyz
	 G1TSRJG2Rb9w1lHIfmm4X2fXQgVXFcMKBd5pEB8ijJn0imK9JWjhcE6SQKLpCt0Ey5LT6
	 wJEACmXzKwv3sZaPOd9gypufDz1gAtDnkjnbnqAJe765OJBKw3f5khMOZK9hh21DozA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a6nYydig;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91470606A326
	for <linux-hardening@vger.kernel.org>; Tue, 10 Nov 2026 00:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91470606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a6nYydig
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b094e649d3so965898a91.0
        for <linux-hardening@vger.kernel.org>; Mon, 09 Nov 2026 16:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794271176; x=1794875976; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IoWT26L+lCNjLByITvEDqGCl/vVklbh6utt0NNZqd+U=;
        b=a6nYydig6QvSKo7EkEElyV2YraExoirso0hjPWfiBXMd5zbsE5V2+ys7gBTXGBgLMy
         KztL3S4lXSLQNQFXbomWBbd4uwbtyFzJ3PlMxe3uSSdlmkG5VE/Md9tv0hOKnruaYi0x
         aPiGZY/Lb/b9UIj6yOm3Bkfm7pAV+dJnpXqlq919gh7//xQg6gdoEVc1qcuuy4ZsBpqV
         bd01OkHyArnS20r2xDk3ROR//CEabXF5XGAQjI7VyXzuf/s1A2ioL/h/VL0QUAHHRZFz
         iXsyGWYm6ejppGHGdXnl0oclHQR9TKzhn0HYYCOubjWw6Rhb4LBRNRyKYxgjASXaQTqt
         k2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794271176; x=1794875976;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IoWT26L+lCNjLByITvEDqGCl/vVklbh6utt0NNZqd+U=;
        b=dn2lYPJrYeOQYL0JG0ns3RXPGVDh+V9/JT5HC8rkoqgMTEQEGn0O4C0+w05oUAzW7U
         i22TTha/PfJPM9k3/vW/EQR5EidCm0MmmR4dysCWSz6ky63056sLufyodPifrTzKJV2L
         Ase7T6rpKXyIzI6T16PrJytle1TwZkQ58gjKhkHOdQMKovavPFbvasuwRP1LD2GuB33H
         Vo64YsJJCQv1z4uZWC3ULX4j+ZjE1loqIV6xYEptxord76+kMxnrxhziFgvETGfsg288
         ddXVE9vVVwsilTiOqMtkiadrAKgGarJgJW15jlOtOHq63+KQVvNYJgPAHOm2qk45qCDT
         pFiw==
X-Forwarded-Encrypted: i=1; AL+hErGpW6INOk6LqYfX4wPZ4WcFvpGufKrOtLNf/nE8x3OjdVaCKE4tV+ndBDtG+kbWMXxtP+XfHbuHhPNBJEiHIpY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8YlmxChzHoAUxhDs0H+q/qr4cjA83wgCVZTVfSAvessCinAHpi
	zHG6SlyYYw/z9Jq4YDDITZvLivk96MijTpMaoY8uA3vt/Q7klCJYiANdbiV4eM4I
X-Gm-Gg: AYBFou04eU4JOZWGOmmGXSsbU3Wm06RgLRE7jYjAxXPKdmu2kL7vis3qy9Ki5bzEn2D
	pgFrit/8//Gp8/PcUn1LyuPrtRreHDXe7kib0oNARhCUq4koBdvBLHRpKS7FIyQ8i4yUiLlYIOy
	dc/1a8CmDZquZuXU1YYuQEffD6BdwkY46FdWHoN1xnoAfuWvakQUoLk2bZAPAtFb7UsLbUThc/y
	Lzoo+7fQIjhUHhxDlziEsofAKlKk9RmdoOdXkEWjvwJzWJWXnxCXQI1JcF3avSIBTYSKETo2pu3
	j20zjsOBDM1eV0U5MbwBmd89tSzM9kP54mVdGEYy/COKYL0TRzOZoCEPlfFkBZo1nOOC2ZKjEPQ
	p/KIkzmuOQ/GmO0an8OiU4lEqjr1zF1NbNso18rmeMl1vZ5ohwxbFUdyPdf5HbJg7NcXHeJqnxD
	7V1JNfX3R/KeFDmwLWFML8twNdPOkL0aGSX0s99ImQi8uFnaZv177DPAU75EF2xcMH6YNWvVJe9
	uMw+ullPGVNYpgrL5c0qOS7yerQNMxSdc8Nke5qN11zFNx9rbjsD5WwyphzN9aNnyfvoJNtCGzg
	IX8GoKazlo6Trc4vI7vxGpjD3oMjHEL+7wNs7Vv2K2CWCmGeq4ILzz+oeqQ3x7qwuAZFus2YBAR
	BRPeB
X-Received: by 2002:a17:90b:4ad0:b0:3ac:9d83:8856 with SMTP id 98e67ed59e1d1-3b166ad1ee5mr1415032a91.9.1794271175917;
        Mon, 09 Nov 2026 16:39:35 -0800 (PST)
Received: from [172.19.1.51] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b16779d5c8sm1512711a91.2.2026.11.09.16.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 16:39:34 -0800 (PST)
Message-ID: <d2f451a0-33bb-47ab-b31e-aa40df9d7ab7@gmail.com>
Date: Tue, 10 Nov 2026 08:39:18 +0800
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
Subject: Re: [PATCH v2 1/2] dt-bindings: dma: nuvoton,ma35d1-pdma: Document
 MA35D1 PDMA controller
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, vkoul@kernel.org,
 Frank.Li@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, kees@kernel.org, gustavoars@kernel.org,
 linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20261109052900.2960473-1-shanchun1218@gmail.com>
 <20261109052900.2960473-2-shanchun1218@gmail.com>
 <20261109-petite-imposing-ermine-fbbbcd@quoll>
Content-Language: en-US
From: Shan-Chun Hung <shanchun1218@gmail.com>
In-Reply-To: <20261109-petite-imposing-ermine-fbbbcd@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Krzysztof,

Thanks for the review

On 11/9/2026 9:16 PM, Krzysztof Kozlowski wrote:
> On Mon, Nov 09, 2026 at 01:28:59PM +0800, Shan-Chun Hung wrote:
>> Add binding for Nuvoton MA35D1 PDMA controller.
>>
>> Signed-off-by: Shan-Chun Hung <shanchun1218@gmail.com>
>> ---
>>   .../bindings/dma/nuvoton,ma35d1-pdma.yaml     | 71 +++++++++++++++++++
>>   1 file changed, 71 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/dma/nuvoton,ma35d1-pdma.yaml
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> Best regards,
> Krzysztof

Best Regards,
Shan-Chun

