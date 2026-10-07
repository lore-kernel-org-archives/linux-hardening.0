Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1001A4ACC60
	for <linux-hardening@vger.kernel.org>; Wed,  7 Oct 2026 12:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791377663; cv=none; b=Cu7dMIYJtU6x42w7DdE8vl7ng+TtPqBk31BjkVlnPMvTwttF6EK5E2V/KNzwosdddU1jc3D5oMJSv21ZE4uX6ms9iSi5aztzcXZL/4LDHkqgnCV4V9DLrYAgN09bE01rOrQlbyMYJ6dPxfanGlmWr8ZjNFJw8RGFcY58KFjHcQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791377663; c=relaxed/simple;
	bh=vQ5ti0IRpJKxnO/ajOgsAv5J3ZdzP6Vf+7alXOHlJ2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G7K7wk4sRa0FDY3Ou2vjb8BBt1gcLBbcWNm5r+/aUS5NQRLvuEYUVOIvNmXzTPHlYOcD7zJc3obNZe0eABaPBFCdIGKRaXL6GcROyRvWPWlUxLCgM3+C3N3sWckApL0iGNorhmLmZ1ZWOrh5RhnL7KneH0MYl/+lWM1osohAXF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RRPuu6+l; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RRPuu6+l"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-381b831d535so3937136a91.0
        for <linux-hardening@vger.kernel.org>; Wed, 07 Oct 2026 05:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791377654; x=1791982454;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WRr2bOzV+ACM051eiPZmuzY0jHiw8RpNfmmijxyyZ5s=;
        b=dvDtihWRJUiunp0X3Qo1NHRgYPFknd3f0d6zT9X9KwZa0O5vs49di/g3826ACp9+lj
         RZVLcEWUydA5Qwl4EATEMjEb3NTmpsGaZOCV+D6CicTccCfFclsTNFSnl5A/gyUDHUru
         dTku+pJplFNYrfqm3pYI0WjzkTG+GmNN7NToKuwGs0wHP8/43hh/F7KKQHYyQfHhcwMH
         V+aGsDmOibPSjr6/3pCWXC3MAyB2cK3MyoGB1Tu8odbF+Y2Tp+SkFa2UKa8XnGySw26z
         Bl7Zi9wSCiKtJ/f1F5qVgFkDxlqmpbJIUhBigi9AtXOy0C1R8OV5vfNkkPM6EICjtDco
         rMoQ==
X-Forwarded-Encrypted: i=1; AKwUvBwx3hSFg8BcPifyRaHFwUKO8YlmtYkjrGObs0KrOAViqWIJ9fT9ny6UStXQ8WkORweZR1BTF/MdFUM3dY9iA0E=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkE6qDNcTH1uvRyaSlgDr3yCrA4AeZUZoLdcmYAZVEr5vezIKf
	YVmLeEYjGYqYeyvlSYD9Ym6Q6rGEZ36w8Pj2hMNdbo7+68BK/VBBqc3xA8piR/3xVHqWnd84x8/
	iQ5sATBeNZA902zET9+rfAqASy88kBzLED7ZNq02jjKxemwSrBqVyYlS2WBKteDF0NXECUwyLW6
	KVm8iV6QxuePfKy7fMFdXvFzwKpi2vCF1sgJJfcux9WXYwcHTMNlSiD5DZcqMRwU9Ooha2s4ETQ
	m4SaCXW+za5a8MYoigWKNgz7HCslA==
X-Gm-Gg: AYBFou11+8ih+MF0fgdYRhY4hu2IP48mLpFj8SUOSW+7vAtb7KcBlfAv5Zq4+NsuV0V
	ZAFdYobFYp3Z+T7QUeWK0auPNFGJIfvs15yyQuCsXhzYZqrDJ7eOEgoRWemOI2LPIgiKBq1Iqku
	7jy4hF5iC3WJugVwvuDSO5QEs1NNWsBIuEH3qZVyn3nfTb1d85SANfCJed2q+mOKw+xcsN8h07S
	4LVdJBXww8n5NGe3nuKUvX2eEoJXLa53Z6NT+6rg/WCBMG1hsrgyH/lFJRH6pH6b80BODum6FEl
	CeArpkukxVk1/cZFuVarkax6iZM2CwGwgc/oVA+OQun8F7CeHXy0Ntr5lGAHNv7YNMqqmcdcx8r
	u0nJ36/I8/XfjmcuRZmNF8ip+p8G+vlswFWVp+haZv0P1sAFOAfz/Tv61RxVgfU3LUJ+bBKCuMo
	D8gtoH5JEEIrZcVYmwiQd2qHJu06z5EJqad2QvdT9jBA==
X-Received: by 2002:a17:90b:4b09:b0:3a8:7e69:6e63 with SMTP id 98e67ed59e1d1-3a8a1b91a84mr2185019a91.53.1791377653598;
        Wed, 07 Oct 2026 05:54:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a8a48cb52fsm338394a91.3.2026.10.07.05.54.12
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2026 05:54:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc73895c7d5so4771947a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 07 Oct 2026 05:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791377652; x=1791982452; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WRr2bOzV+ACM051eiPZmuzY0jHiw8RpNfmmijxyyZ5s=;
        b=RRPuu6+lLm6I2x6sXOOrNvh1BLc+q5EIBLLmmXx+lD/h9iH79fNTnhWy6F1udM7B4Y
         vLGo6TBGs/902r8fPhs883WYm/II5uXZ3yHbWv+89GDFCMfqkSCGc+TAPvli9EocJPLb
         VR5PnBWs1eANLE7zz+/0g/lVQzf+8ywkIx8us=
X-Forwarded-Encrypted: i=1; AKwUvBzkLpl2Upw8cINiwLq8q1yw0SNLUOMNO4W3cekw1d6lELPf/K9Jaw1uik2ZXLrEplAUrdRsvYvDJa11DR8z+uA=@vger.kernel.org
X-Received: by 2002:a05:6a21:3990:b0:3dd:85aa:452c with SMTP id adf61e73a8af0-3e134044716mr1756552637.30.1791377651832;
        Wed, 07 Oct 2026 05:54:11 -0700 (PDT)
X-Received: by 2002:a05:6a21:3990:b0:3dd:85aa:452c with SMTP id adf61e73a8af0-3e134044716mr1756535637.30.1791377651379;
        Wed, 07 Oct 2026 05:54:11 -0700 (PDT)
Received: from [10.176.2.78] ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd0a92d5b51sm1411697a12.14.2026.10.07.05.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 05:54:10 -0700 (PDT)
Message-ID: <d28a1cfd-1bcc-4319-bbbf-7189a1ff8dc3@broadcom.com>
Date: Wed, 7 Oct 2026 14:54:04 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
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
 Hante Meuleman <meuleman@broadcom.com>, linux-hardening@vger.kernel.org
References: <20260925-brcm4388-submit-v1-0-b5cbc2cde2fb@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <20260925-brcm4388-submit-v1-0-b5cbc2cde2fb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

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

Thanks for this series. It is taking me longer to review the full 
series, but wanted to let you know I am looking at it.

Regards,
Arend
