Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793561248;
	b=qSAzUyzszEnN/c+jGrmB3PLJKeH8mGAHQ8xX0XA34gvggu/usbYt32yrGqJnXPoEyrwf
	 sFgqtRSuXO0yVmTcNmo+JMefsx2HjxmrRZSZOBZRssJGF2xpfhRDXd+TjEyJ+koGVss+z
	 j+Vo+lzap6JzMVCoq5lY5vNrbpTxuLZjO4DywSBlHDVEIqSf/aYz7fg4IJFslkF2e2fIu
	 1cCMnslwWZl6I30uH+2i/PDXIQYoq4tzZkXD4SlDUBkrYhXFdKNyusWTJephDVAREGc3f
	 rYjPbYdr1/zoAJ+I08ACPaPrXz5y+VwegodQzQaNpF5rN+3mGJGb1KgEhK1AEtKwznQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793561248;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=FBzaqWRuYJDOcynWW1oUqzv1XeYY64zxgMqREXlXnBE=;
	b=DHfocpDFP2D1G/O4cTi6Nw5505PJ7k7Nyk69bl9U8yMxj6ylEDaTK3/kMSz2MKg9I5DB
	 +Mpfg64NE3WsQmrcG50WHML3l224XdkzpGsrW6VESbRXgK6eIYH/gk+KIShIQSkO2UhUh
	 K9ANA4akOViZswpEnmombNlql4tz9SL9qKadHhxfRnufshTgZC81exHDFBWtNBmz4oVWv
	 CE1eyc2vp4N4mus8dS2uQ5yCeBRzP81ISE1cDzrM8zwixilvbfd6d1UpL4NICLB++DAcD
	 McicZ+DLxFWslBe7UQEiyMCLUUoRy8Cd4KrcXACPhWw8L+gGb/hC1+mMm1/q6eR+Ikg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=DhrvIh21;
	arc=none smtp.remote-ip=209.85.210.228
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662F3606A32F
	for <linux-hardening@vger.kernel.org>; Sun,  1 Nov 2026 19:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 662F3606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=DhrvIh21
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-8a9f9473029so1568583b3a.2
        for <linux-hardening@vger.kernel.org>; Sun, 01 Nov 2026 11:27:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793561248; x=1794166048;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FBzaqWRuYJDOcynWW1oUqzv1XeYY64zxgMqREXlXnBE=;
        b=oLOYJ1TW44FXJ3u9Dlrqt9/DNiuL2vNNzVpYaCk54acjNy4vcDYOfTBbCOFg291JdR
         0/AtdK0UIVwkcXOuBoS6OwEFA/sV8sglb/NQjo8B7P9Nq3oO5vFG+/2u95HQm1GOAnU5
         YWGwb2WpeDJMwN/pNzHYlQrRgwKkjC6Q1L8A/y1Ni0gJoyFaKxPXuY65+pq3R4UnEXsF
         ZKnv5fD1uVepIQe2F1tzEBKxPqJcYeOzLDOBZCLdzyIXSVH+GxZO8MHyTjSrcR9RiLco
         a8TfpUKg0IxOZR5IGBlC6xCAKWrOLRK0q46hvR0oJisZo4jYmba7GBEeZFCd01GwyhcA
         4IZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzIMEFgMwOvZTWon3LnL/gc+yN4m9BEAWWAdYqLuGFWbUHB+/tnoj9XnuMnpnylZjPXf/T5frIdMTvqswM96Rk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLuR5n1W8eMFUTaZnNQJ9IXyXD0kcZXqotSd6I4A+TfQLBi1rvQ
	SYSHxym7qfR9z50Xu8X1O53ESY9OsSgTI9+BXroXwgOAQtZ+S6lDrfLRhGWr9N9BtmrdkzdT3Fg
	Prm5cBoIZXgCn5GawCJkJ3zb5Tc+J+4FxqJFWT+AGH/IqXy6OyaqmBJukSZU+bvwhXsAjsnLprt
	1PUoLKyI9Ya0pmqcx3mSXq3/6sF/MQR3IOOip2no5M65SIkTrfS5Y4zz3T4O9BBauo5ANXPPP9v
	2A/S3wvgfHXH2fREuKl2XgXfpFopA==
X-Gm-Gg: AYBFou3t80UGfqGAgTusFg3pDn4cUcQHNcDei0RjVp8tQAwWORVOwE2yFxQfqKqyaVN
	VKwgDg18cw12z4sc2hObVGFK3xNXx2mvbrun4qEWTw55azDqL+k6AcC/dZEcpDZtAyniDROE/YL
	HpZwgzcHEuGhrpz0OFr2LRZMsE2bksfGwpBvVqBYHos2Zcus3t7jL6yPLxkcqeNc/c6q9pr7EKj
	q86erFKZuUgZVSGtjOg/BArl6xAOG5NKLq3DiL8rLXK+JpyIPaIlHorcGwbjFXSVt4zMraxyyka
	eVa7qun3qt7MboMPLRenCb04MwJtoj+3EH2smWT2swjzpAYtm8kx0YuIULDR6CU8xYQW7DOYUpp
	QlXINWKeN3s/TUUPtmsGywdkFFIR8ox4h2zxsxYQE/u0NegLDVes4OR6PqSPQpqeGCdUYVXha1P
	yIYMG0tN8siyDT2pM12+lh3kpR08a8o+YPAmVVOWA=
X-Received: by 2002:a05:6a00:1c91:b0:89e:b291:89c1 with SMTP id d2e1a72fcca58-8a9bfbf3312mr7036461b3a.53.1793561247590;
        Sun, 01 Nov 2026 11:27:27 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-8aad9636c18sm69988b3a.3.2026.11.01.11.27.25
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Nov 2026 11:27:27 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c40aa03ded8so120064966b.2
        for <linux-hardening@vger.kernel.org>; Sun, 01 Nov 2026 11:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793561244; x=1794166044; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FBzaqWRuYJDOcynWW1oUqzv1XeYY64zxgMqREXlXnBE=;
        b=DhrvIh21w1XzU5LgWa9mrFLSjCH/FjS5+8gKwe4Xa4Diyaen3FJnosCbGfUO+p07SW
         ijy1U2WlmTouxOa58w/1JLPLZaQi6XCay+WFJIpK3ADbMZZHVTP7o/aFW322QNLLsCut
         PzU4LFIRWv4FO1Qsoa4/m6FSNeRi8OeOtvc/c=
X-Forwarded-Encrypted: i=1; AKwUvBweNQc/imjZ5LXg7V6fbwJODok/D2bDSZnbv+kIeYrrhuZzp/DLdH7gnCWoaY5FNOHkzLVnhNdVPGyt4pGh7Wo=@vger.kernel.org
X-Received: by 2002:a17:907:86a4:b0:c46:9d7b:37d with SMTP id a640c23a62f3a-c4ca7a4b544mr641618466b.17.1793561244334;
        Sun, 01 Nov 2026 11:27:24 -0800 (PST)
X-Received: by 2002:a17:907:86a4:b0:c46:9d7b:37d with SMTP id a640c23a62f3a-c4ca7a4b544mr641618066b.17.1793561243910;
        Sun, 01 Nov 2026 11:27:23 -0800 (PST)
Received: from [192.168.178.26] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabc1920csm303460866b.5.2026.11.01.11.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 11:27:22 -0800 (PST)
Message-ID: <d78cbbd2-601a-4cf1-800f-3be57a2b7de2@broadcom.com>
Date: Sun, 1 Nov 2026 20:27:22 +0100
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
Subject: Re: [PATCH 00/13] wifi: brcmfmac: Add BCM4388 support
To: michael.reeves077@gmail.com, Pieter-Paul Giesberts
 <pieterpg@broadcom.com>, "Franky Lin (Zhenhui)" <frankyl@broadcom.com>,
 Mathy Vanhoef <vanhoefm@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, asahi@lists.linux.dev,
 Hector Martin <marcan@marcan.st>, Daniel Berlin <dberlin@dberlin.org>,
 Janne Grunau <j@jannau.net>, linux-kernel@vger.kernel.org,
 Hante Meuleman <meuleman@broadcom.com>, linux-hardening@vger.kernel.org,
 Peter Robinson <pbrobinson@gmail.com>,
 Izabela Bakollari <ibakolla@redhat.com>
References: <20260925-brcm4388-submit-v1-0-b5cbc2cde2fb@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <20260925-brcm4388-submit-v1-0-b5cbc2cde2fb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

+ Peter, Izabela

On 25/09/2026 15:43, Michael Reeves via B4 Relay wrote:
> The Broadcom BCM4388 chipset requires new PCIe initialization and
> firmware interfaces. Add support for these interfaces to brcmfmac to
> enable basic station operation.
> 
> This series adds:
> - Signed firmware loading and mailbox transport
> - Fixes for chip identification and firmware capability matching
> - Versioned scan and join requests, and extended PMK payloads
> - Updated event mask handling
> 
> These changes include work by Hector Martin and Daniel Berlin from Asahi
> Linux, refactored where needed for upstream inclusion.
> 
> The series provides basic station support only. 6 GHz support is planned
> for a follow-up patchset after this lands. The driver retains legacy
> interfaces for older firmware.
> 
> Tested on an Apple M3 MacBook Air (J613):
> - Device boot and network scanning
> - 5 GHz WPA2-PSK association and DHCP
> - Bidirectional TCP traffic

Finally got some time to get this series tested on my setup. The patches 
generally look good. So far no regressions observed. It would be good if 
some more people could test this series on their equipment. I will do 
some more testing and wait some days.

Regards,
Arend
