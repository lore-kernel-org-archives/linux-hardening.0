Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B6E57896
	for <linux-hardening@vger.kernel.org>; Tue, 27 Feb 2024 23:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709076302; cv=none; b=rX5F4FSsHJvosMTb8CNaUlwhpSu14M+hp23Sk4m2yUH4H8V4OJlPXxWBG/8mR8gL4jaZvdS0UVJhVmpG8LyLdpS/Q+BRmcAsIFincVEFTlaTuBWSJtnqrq5tT3+4MRSUotLJHtlUC6KAlg7M9pIQQdh9ZdYaJ4BnDuLTDxJwGkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709076302; c=relaxed/simple;
	bh=HDwa7fbuH1aZDEzp5Ac6iY2RB5pkOpyq5qK/4yKHkbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fg8HufLgdRR4/4iB4kFKhhWDzxs4BEXq7A8Nz33jNTbP1fxImLPdjbca7IHoik7MTOLHIvtgK/56vET45+D2EuXij5sICp5vtr++jvr/zPQ2Nq4878d5evXqz00g5zd/li/ULuYdTmf0M+8RvLBLRgp5qw+DRCRf+42td7F0ljY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kh+uxOPi; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kh+uxOPi"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-365b413549eso910295ab.1
        for <linux-hardening@vger.kernel.org>; Tue, 27 Feb 2024 15:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709076300; x=1709681100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wvIY3k15tE0HcJm4Yzmaclwism7ZYGDgLaZ5F1IOoes=;
        b=Kh+uxOPig0hkA0IOU0u2kAKdbxe+m8QAosuBOGvLzIsQn66kAy+K4i+PRVs4JPHw07
         fgQYU/A+NjtIeojqksBpXmIleVIbSvCV54M2CqvbAmyFFgKbMb3PcWAj4K9RBebBC8Z5
         5ZuUTk0HfNBmPXJnxXd1gAHVfrn+MDDQ/ZAK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709076300; x=1709681100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wvIY3k15tE0HcJm4Yzmaclwism7ZYGDgLaZ5F1IOoes=;
        b=fBv8vieTmAEZ3vAHIlboT9WiUZzQH+OcQVBRsfA45jcydYUBZjy82wNfvED9jltd4S
         O7l1Ytbn37oijI+7BFxqqIrQL1ZGb5sdZTIOJncDDdaRgp2ETXaRLEO7U/0jsaoJlUHk
         s27rLAQbAExkb17dCQrMVOVBAPwkdKVCcZ5BzECaaWL4VUNpElfsC8CCwaoqSSL4H+68
         BuV7AeaiCzfV6nb7fwg3oUaxsn9PweVAqb7KgI20D0kuCg1dCYBQYjYYd69rv5B7PlUZ
         g/YX/qD1x9nJubRjhKMx2VCbSqUDjn2Ujn+IJLmtW9BUtSGFjv5Ux7a+oopyIZSWC+CJ
         rW5A==
X-Forwarded-Encrypted: i=1; AJvYcCWA5LAr9kHVDcJ6xsLRf8pkwmU+I/zRvRoM5XlCoiMUqRPFhd6YARDK/agXLxfbRfvSKQkEFS9WlVfOaTXZ2guKuodONA8Ci8HX8libnlvg
X-Gm-Message-State: AOJu0YzoSGLsxBP+o0nsF5P+Hdest89E/5jqFQH0kCqZ1KXn6EFW/vBL
	Jh2WOiQUCjTRzxzRNQ/JdM2lpwoIhq2IGRepM0g4jTL9qwgzWuExt8MDfa772VY=
X-Google-Smtp-Source: AGHT+IH7h7vSS9kJq/Hsu1hvzmsVL1Hoh2ZLb1ktpG8OlizpzOEJEClNfjMsljDl+J9cw2Cp6ZyxBA==
X-Received: by 2002:a05:6602:38d:b0:7c7:8933:2fec with SMTP id f13-20020a056602038d00b007c789332fecmr10945119iov.2.1709076300126;
        Tue, 27 Feb 2024 15:25:00 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id q10-20020a02cf0a000000b004743021012asm1964451jar.2.2024.02.27.15.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 15:24:59 -0800 (PST)
Message-ID: <ba023321-dd6e-4163-8924-092c87aa17fc@linuxfoundation.org>
Date: Tue, 27 Feb 2024 16:24:58 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] drm: tests: Fix invalid printf format specifiers in
 KUnit tests
Content-Language: en-US
To: David Gow <davidgow@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Kees Cook <keescook@chromium.org>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Willem de Bruijn <willemb@google.com>, Florian Westphal <fw@strlen.de>,
 Cassio Neri <cassio.neri@gmail.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Arthur Grillo <arthur.grillo@usp.br>,
 Brendan Higgins <brendan.higgins@linux.dev>,
 Daniel Latypov <dlatypov@google.com>, Stephen Boyd <sboyd@kernel.org>,
 David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org,
 netdev@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
 Justin Stitt <justinstitt@google.com>
References: <20240221092728.1281499-1-davidgow@google.com>
 <20240221092728.1281499-8-davidgow@google.com>
 <20240221212952.bqw4rdz2i2yf3now@google.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240221212952.bqw4rdz2i2yf3now@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/24 14:29, Justin Stitt wrote:
> Hi,
> 
> On Wed, Feb 21, 2024 at 05:27:20PM +0800, David Gow wrote:
>> The drm_buddy_test's alloc_contiguous test used a u64 for the page size,
>> which was then updated to be an 'unsigned long' to avoid 64-bit
>> multiplication division helpers.
>>
>> However, the variable is logged by some KUNIT_ASSERT_EQ_MSG() using the
>> '%d' or '%llu' format specifiers, the former of which is always wrong,
>> and the latter is no longer correct now that ps is no longer a u64. Fix
>> these to all use '%lu'.
>>
>> Also, drm_mm_test calls KUNIT_FAIL() with an empty string as the
>> message. gcc warns if a printf format string is empty (apparently), so
> 
> clang does too; under -Wformat-zero-length
> 
>> give these some more detailed error messages, which should be more
>> useful anyway.
>>
>> Fixes: a64056bb5a32 ("drm/tests/drm_buddy: add alloc_contiguous test")
>> Fixes: fca7526b7d89 ("drm/tests/drm_buddy: fix build failure on 32-bit targets")
>> Fixes: fc8d29e298cf ("drm: selftest: convert drm_mm selftest to KUnit")
>> Signed-off-by: David Gow <davidgow@google.com>
> 
> Reviewed-by: Justin Stitt <justinstitt@google.com>

David,

Please send this on top of Linux 6.9-rc6 - this one doesn't
apply as is due to conflict between this one and fca7526b7d89

I think if we can fix this here - we won't problems during pull
request merge.

thanks,
-- Shuah


