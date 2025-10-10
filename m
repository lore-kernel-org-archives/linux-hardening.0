Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8835036B
	for <linux-hardening@vger.kernel.org>; Fri, 10 Oct 2025 04:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760069959; cv=none; b=kSz9lyN8XC5SkAMC/2NVd/HSoxnJVwxFNYmI8hUmtaN+94+eSbwyqIv0XoTe6DSbcLhJ5N4UNBho4bY2/nqNOTppwF1tbjyB0KyD6RjluADmrs3gaxnX0yBpR1zWjP2jCdCV+54ppCwPaRN8vDJXDI/9RlUuedAXqVbNqG9xRT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760069959; c=relaxed/simple;
	bh=xwBn4qXrK+XNYpR0WLdPTYV+y8T+IAIrJ3YSUkkzQC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPbd8IYu3WFi3fbIAeaxaRKkKIk3+siMroRZhxDTiCFhToegPPYHFoCJ/eyJi9q4ROUn1S7KOwx2DkRvMPkkUibr+Z7v+wLZab1UV1xfVk1CbYMNuMhPk6O4Wv4M1+vxibQnCPQ7KiO50atpPKB1M+aOtU0gLHl/JOow2bjCcuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KNnBjr0q; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KNnBjr0q"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46faa5b0372so10303035e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 09 Oct 2025 21:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760069956; x=1760674756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WwOa80v1gASmUxbIlKVNpJ7pC74JVx0S1JpZYmF7fT4=;
        b=KNnBjr0q5HdJcHl5KW1xWguYCm47g8hx1IkMR1zE4/dtFOxJneZHF+e/vQhNMA/v46
         0O/yBa5nz3V8GKiXGcCvZ8BYDNjtexNaajr+6UOLWEL1QFQFy8JJYVp6CoXJ13goGpv8
         xWxommaivpJU2vOGQSxjRMkySIIkQzb1gSiDJ/0ExzOIZSfn7bvaJ8mzsj+HXJCcw04E
         AQZgRYU786KIw6YRGsAalBf9+5ED4JRfj+EA4myMJMu/DNoiUC5ExCYd02Ix9eA5CN3m
         zvUb4hMHwWpnRRB5GMkEofL0mUVA+iT81dRClswUTeRPQPCOrS44AB7x+gsGvMVDmofT
         9TUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760069956; x=1760674756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WwOa80v1gASmUxbIlKVNpJ7pC74JVx0S1JpZYmF7fT4=;
        b=o6PlHehlvwjyhWQYOoVutbtxVm0T0yUV4f1nKZ/IEobq9GJ++ABpFiS4WvaXoSlGuM
         e90doOycvF96OdUyhzOEPIE6cC9c+6KpIH+gDpoTWpQBGr4gAYKd6kVhNqNjAQScesk7
         DeE4Kmyp6mOF9iAeLavKVuimRnrfezvN0RTZQD4Ct6aJ1dzngXyv/QwwCiUZq+rEYkK4
         WM2RLufQiKrJr5CKpP6NT0fMQBayprEb25ydUT6FCq+Ib08YpWl+3rhyle3HoqtatA8g
         KJ3ELISddn/lzJzaXbZHJACxnWPqdWMxFnbN3u+dlRTpqNXWyxLpZHldMa4aZpHu0yjm
         UY9w==
X-Forwarded-Encrypted: i=1; AJvYcCX87odYgjhQIiHWe4VbsGU5xOXfGTAlOq47CnYNOHLN/Nnd4WgH0pRW/iJgvY2jhjm30xO+ViS4eYIpWLsmEbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9FwjNOygK4mUTU+DACxswJ8vAPNVlD9FkFSmpquCEDrCNaTj3
	RHMFcQhdU1IbXNK7f0gF7dQCh9wd9QwY0aw0oeKyCSD+oBQefItMsqqMXaw8NCtWbL8=
X-Gm-Gg: ASbGncsYzJgOJlpJwH4fR9xf9KnDhW0aH4OfEWYoVmPRq4dHd8Q7A0nAI60zIjByXVw
	WbVCWhtuaSs8mjwxFq9eOLB6vYzwmz7rKLR5IG8FWGmnGZO8F53lz0LWd0NdzqwAXYrbkg0zrjz
	BW4rkYUtESWu5vc/u1fVIsocs5+pwjhkPPIh1FBPP4U9Kyy6HhYYZZ2LYUC5cznETE1OG4WcAc0
	/AWksZvIhYzJvx9q092sskFSD9IpxBhKds8AElth2MWJ8MyR8oG9E5zEY1gcOZn+R+EChoQLcRe
	CdKvq0J1kuJnJMdC6vvx0EMEhV+O0ixsmkjCHE8FyEAV/PxuShgti6l54GpDHXvEvMXJzJT50qn
	kKkQhljSCtBpwnK7110JATzCSBa01T/+8881uspZnCRpA+8wx+yXZVMxvClEmjw==
X-Google-Smtp-Source: AGHT+IGJgO2IvwgPLgeBx8x9ysG+IFbcbA482p2h3xQBgGrT2la38bcOWIrduOHO8n5qJqWFiyffew==
X-Received: by 2002:a05:600c:a43:b0:46f:b32e:5094 with SMTP id 5b1f17b1804b1-46fb32e50fcmr30537085e9.32.1760069955819;
        Thu, 09 Oct 2025 21:19:15 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb4982b30sm24491365e9.6.2025.10.09.21.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 21:19:15 -0700 (PDT)
Message-ID: <565d9afb-cdd0-44c0-a070-9c603689f123@suse.com>
Date: Fri, 10 Oct 2025 06:19:14 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] module: Add compile-time check for embedded NUL
 characters
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Rusty Russell <rusty@rustcorp.com.au>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-modules@vger.kernel.org,
 Hans Verkuil <hverkuil+cisco@kernel.org>,
 Malcolm Priestley <tvboxspy@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20251010030348.it.784-kees@kernel.org>
 <20251010030610.3032147-3-kees@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20251010030610.3032147-3-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/25 5:06 AM, Kees Cook wrote:
> Long ago, the kernel module license checks were bypassed by embedding a
> NUL character in the MODULE_LICENSE() string[1]. By using a string like
> "GPL\0proprietary text", the kernel would only read "GPL" due to C string
> termination at the NUL byte, allowing proprietary modules to avoid kernel
> tainting and access GPL-only symbols.
> 
> The MODULE_INFO() macro stores these strings in the .modinfo ELF
> section, and get_next_modinfo() uses strcmp()-family functions
> which stop at the first NUL. This split the embedded string into two
> separate .modinfo entries, with only the first part being processed by
> license_is_gpl_compatible().
> 
> Add a compile-time check using static_assert that compares the full
> string length (sizeof - 1) against __builtin_strlen(), which stops at
> the first NUL. If they differ, compilation fails with a clear error
> message.
> 
> While this check can still be circumvented by modifying the ELF binary
> post-compilation, it prevents accidental embedded NULs and forces
> intentional abuse to require deliberate binary manipulation rather than
> simple source-level tricks.
> 
> Build tested with test modules containing both valid and invalid license
> strings. The check correctly rejects:
> 
>     MODULE_LICENSE("GPL\0proprietary")
> 
> while accepting normal declarations:
> 
>     MODULE_LICENSE("GPL")
> 
> Link: https://lwn.net/Articles/82305/ [1]
> Suggested-by: Rusty Russell <rusty@rustcorp.com.au>
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
