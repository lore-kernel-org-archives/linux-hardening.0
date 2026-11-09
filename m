Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794183274;
	b=k98Etd5ddZfhXihWOBNmWjIcfQ8L2bnNpwQ4hvJZOpLKVG5ggGCSMrUcc4frXqexRxLF
	 B4RQWQlfPIwqaN/rJNbMoguo9zMb8NLm2J/Ifh+fPOIbJblYEMI+D+mILyEoKA1sQNZS9
	 1H/Y9pK0hZUM2jB6uJ0Qi7zFGO0uOYybolkXngCSo4AZwz3WiaeJ/4a1RwiBmTjGamUu7
	 UnBGJmn3QaWsPCZExzGeaivrlMuK448M1tDwu1lRvYIq0p7QbajCc7GSeev/FnpcDuWJ2
	 gQzfjmACfVDe8RprJp9QzQ/SDcNIqutOHBKfQpt0rZ56QlmNJCt50flW5ndi8XzIMYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794183274;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=PKbaPQsHHOhvacrmvvpMN5t1cCuxJyoRdKRaZq+8jRY=;
	b=Wvk+8ysU2QxZqCLL7zCpb80hWrLmPT7bg6FJCVWRvJS/N0R9OZb5fVaYmNnOpgEcCsUf
	 JVfvni+JwlWC7oR6JFZuVuOmoLK8lhRHOv4Wzb0IaQh0zCIGNqxK+Im5UwExllmVXwl9p
	 8Ghmpf/Dyk1G46NJIMXionE2/v318Y5g3N3E/kqn343F/ffT1SAZHZu65zdZq8aqjdSxq
	 iCF6dU3elEGCvqYQQHKZJlqaWVgekDx4xwok+/QQ6OKNGpzwmNot3fAV0BQ33EVL8NKc/
	 m42VA8lWdBHv8PAWt8pxNPLV3ddteF3TxIv4S0Q1njUJDZ66C2ayOOBUNwHFvZycjpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZWSuo7o1;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6AF606A322
	for <linux-hardening@vger.kernel.org>; Mon,  9 Nov 2026 00:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC6AF606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZWSuo7o1
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8b68e59ab33so237278b3a.2
        for <linux-hardening@vger.kernel.org>; Sun, 08 Nov 2026 16:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794183273; x=1794788073; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PKbaPQsHHOhvacrmvvpMN5t1cCuxJyoRdKRaZq+8jRY=;
        b=ZWSuo7o1a8UnAu8ncnh5mn3fSiYXc6RaBhlIVj34wIGCkP5oIgEI3ZIhR1PPCStR99
         es4VkceP4A/YQn5zgOskoYrNJsBpiioGXm3dcDwHrc8p0VGbjsVLtf3jpirm4WdIHvyo
         sfNsyrKFGOVtf3DpRkI6+42XEXYU3fPJOpGpRxgKiZsKwZhZe+DhMXYaEjvOE2B1uIef
         L9Z6YW+NrmHGtXWy9t7wPwht+DC66M6tPa8JwfVAfUPQ1K3aT8E0L2RedPDVvIOz+JCS
         igIyLiHooDBiJvvx/F62nscNzDw0Ur+9CODjcwXv/BkqGwA+wl8dx6yOae32sk1bvulp
         nZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794183273; x=1794788073;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PKbaPQsHHOhvacrmvvpMN5t1cCuxJyoRdKRaZq+8jRY=;
        b=IOzVgE1ZV58K+7EPhejoor8ECfUvpqoRiMtlewlpSgzm4D2gl2Fegy7Dx8AaZyxQai
         mr7fTPvAM3jnV1aHz6NUqJVNkGeHwSPw3d5tuMDsL50iyJYPlD1jMH3pwDkcp/6q5aTu
         vF8fpdLZJZKFyDkmY1gO9jhs4Ag5+vZWUJC9R2weriQOyzS9KYSiZiASYVIGC5v74KGD
         H0Zzpzf/eKFmFivDDOTcYW0XqUQ0DQ2PAOUoW9r+tNh6jH1aPuBX00ihW/PEJk8Y+qaW
         11rEshWsZ4qp9LUsEYbmx+p7C25AoIy55BzUkPhhRi8KsSHi/DhpMtvcVH1EnZD8UpPo
         VMGg==
X-Forwarded-Encrypted: i=1; AL+hErHMKtoHqgK/L0ayyWgMoWkXYMu+wTUSrQ9C1+J6fL6Wj94bsdWPqiSApoG3wvH1PGyfb0STRwhra3d5JENK+7g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+DKyGaNbcTcNcq5waDugeWP5muS1ssdiuVeEwz1uRaFU4qM2jm
	OnEhdGx5fssx1GrahKZfTU1W9CzbAg3kPVVgbOBmF/qdVzB4QMpJ95v+
X-Gm-Gg: AYBFou3Es9+eYdOOONSTOziVo0npHw2ObXkyjTo+VbGDNg0Zs5sMD+7R+R9yL/8x2bF
	rXFSze3P6dLVVr/ZQSeCzxRQuV20C30A+iHFoU6se3L5QsbP8mh+iXvNNJ7o2aa48pDvi7PMt75
	6myw4+op/zAx5k1LrtFUM7YvVKm3V1VvZby45MRCM+C8rNTJqogqPdwB94fTUx9Z/uDFSB/HI0L
	zyBGSMunGGN8wSPBHaCCuY5qBKuwlNlg1igHW52SmVZmuds2eqd+IP1nMkHDkrKdFAz45KFz0ws
	/FxIK4mIpvwxk0oKOIsFtuig4vzH6WfRnCN7r+og4vvnhhj1+9Tnnh4bo7mK+ozWc/yggUFzqYR
	PObDYT9DZg4LvXzcqtSqYEkug9XYjMqKCKY1nCJKDdV8BYpArbZYg2UkXccoT1p22X6Y48KFrsJ
	uLn8+g4vjT20HZcsoP2xhKDrBoR8N64rnwz65l/Akspok3Tw8nwKsf815qYCFZ2FV0nLW/GJrDh
	FrELXyDiiafR6ZYC6V36Wd+DFlsLkZADHxR7QVzPB0zz3PxkjMad/Me6DmDOMocIUjB7IxnIcX6
	imuew3K8883hMG7j56S2Z6hF2NNCTliNecURJ5B2eGVv53A6xy1EEDc7c4diSvRZmlb1GSfaCVv
	1sjw=
X-Received: by 2002:a05:6a00:9a3:b0:897:ffff:c18a with SMTP id d2e1a72fcca58-8b66c3a7923mr2227291b3a.7.1794183272958;
        Sun, 08 Nov 2026 16:14:32 -0800 (PST)
Received: from [172.19.1.51] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b649821abesm777951b3a.34.2026.11.08.16.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2026 16:14:32 -0800 (PST)
Message-ID: <faa957ac-badf-4027-b86b-e12b8dd4bc7e@gmail.com>
Date: Mon, 9 Nov 2026 08:14:16 +0800
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
Subject: Re: [PATCH 2/2] dmaengine: ma35d1-pdma: Add MA35D1 PDMA driver
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, vkoul@kernel.org,
 Frank.Li@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, kees@kernel.org, gustavoars@kernel.org,
 linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20261103022202.2139674-1-shanchun1218@gmail.com>
 <20261103022202.2139674-3-shanchun1218@gmail.com>
 <au4GkvPTXmcvReoj@monoceros>
Content-Language: en-US
From: Shan-Chun Hung <shanchun1218@gmail.com>
In-Reply-To: <au4GkvPTXmcvReoj@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Uwe,

Thanks for your review.

On 11/7/2026 12:57 AM, Uwe Kleine-König wrote:
> Hello,
> 
> On Tue, Nov 03, 2026 at 10:22:02AM +0800, Shan-Chun Hung wrote:
>> +#include <linux/mod_devicetable.h>
>> [...]
>> +#include <linux/platform_device.h>
> 
> Please don't use <linux/mod_devicetable.h>. <linux/platform_device.h> is
> good enough to provide of_device_id already. If you insist on full iwyu,
> please use <linux/device-id/of.h> instead.
I will remove it.
> 
> Best regards
> Uwe

Best Regards,
Shan-Chun
