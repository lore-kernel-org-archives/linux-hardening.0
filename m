Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757BF2D94A9
	for <linux-hardening@vger.kernel.org>; Wed, 30 Jul 2025 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753884268; cv=none; b=J86AwvzBQrSN2zLt9VtUe56uCLamIGKNLOL3HDsX48zhQYE9mrM/kHxS6TDwiA256YDmNrF9DqL+vE8oQiMkpDT79YUhyFlOKyh23aEggldbbj7p4dD390ovUVMDTBFRLpxUQ4J3Gjfy4KXAQ63SnN9A1TfcbkTQnTM18oqlce4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753884268; c=relaxed/simple;
	bh=nZU05SYgwuxz9tXqf+2n4kG2ZxRFgsh3LY/Vsv1Amyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txB1Jb1enn49dnOWtjEkmrlsglBpcaHYJ5EfWboq9zRnbLSax9t9xKB909yrPjXScpL40G4yotdyY+I47FjapfzecNtcjEQqt7trB/HJYnSFHAVw3LtUdrO1G5K4y1x7LMP/l3pUrDzpiqL7pIxH1nx1yT5lJg7vdlXfDn9zqEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GP0fX2fT; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GP0fX2fT"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-45618ddd62fso66528015e9.3
        for <linux-hardening@vger.kernel.org>; Wed, 30 Jul 2025 07:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753884264; x=1754489064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jk6Gtn926lXsIj4x4Dh1A7mGQexyVuqQFAqQu1Vz/9Y=;
        b=GP0fX2fThCo+QUvvVO00lJN+qe8vl5TFgrK3Xpk8vqL+HVZmw9sa0mofHBToGJwgjG
         bdkseuVtRNtOOIt/sEG2U+sFFFz2v4K8RIevJvOBZ2Eq8ivawkjruCwlAMJQ/EeRvmG+
         9IpmRlM0qsUlheO7CsEy47dri87oHrHZtiEwnl+uYMAFT44GzICOWXwC799VBYgYf3NU
         roL9RYmN3xcScWFf2t5TEaZl8nwI3jIOKmC2cDBHii7u+1j8ZXa+31X6LmAZGkRIP083
         VKJBp3dbhvXX8Dcnh5xYCCqeLE4rIMpBaUSOhM88NwIIEGIFc8Q729FI9CiCzbR5wfEn
         eN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753884264; x=1754489064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jk6Gtn926lXsIj4x4Dh1A7mGQexyVuqQFAqQu1Vz/9Y=;
        b=gFWqStL5yXPmw+v9dcgLTblMFei1pcN2ftY4Yon/p92vs0W/H26/c2eJ6QXpjFNk92
         uUYFzF1uzgf9s01kYN5qmj4gSN4N+yvz3PpncdJGuC9eUwughIXKC+qOz6AXXeQHPRfw
         tyQIJA4emQJzeancDI/kZSqwFDyBU/O4ElI4yFdeVAGWz53339dPfCN9y6iNU5GUPFV0
         MjSKogRNCdZ26yq/ncf4oXvz4dTPp2K75YcRaLdB7dtvlhhnrEArzocmwcxUCHDcHkUP
         Z2alw8GapwetD0voNFETJVMAz+qesZ92I20U+JP0fPCzlMg1iqpUau8uOZAxryCZRoEz
         /TgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwqoL+t2Y3rXvHWY9kPYLREm2B57PfwTiCJbXA4tKWasr0j5edbipJwwsVR9k+saXLw6XrPrrbMIa+f9diSr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg1eoUM705ybq2G1UusR+5rDDx4PRYautfO5w0fCLSw9qE1dO7
	RjC/0b9ntzrYJBhDVvNpSa9xPb5ATxeF7aujX9OAe2UX1oxKafLDJb5bbBQQHfx1KOg=
X-Gm-Gg: ASbGncvXyd65FeSOZ77a+ZrEordbRLPtwysNOMBJ7FMjJhUVP/+xzrhvfghnkznfnZI
	88hE3MUgxwpCWuUhsAzN65kvljL3YS+NAcQ9E1qeJAnNOylsa1avuIb41PV6velmrosGfkB8rP9
	J3MndhrVGtiQte+AJoqcWHHJRnKGa11D6aGKzM91hjx6YE2Me0kfpWMorOElXC8LuaS/rtPinVN
	KPJR5K796dsb1OyzdU9nww4VCsu0dJpBxGaUCZTB7ldUyF/ftdR9t/ST8xd/ZvUTTCi0B+MDk9p
	Y84kHmajmErhxVB3zROrnZsUr7/hxA4KZYSWpmuZWi2fEzWzKLWafbXGr6bdIGdNkn53VvfghMB
	1UyuZ1d87OzCenPRXOCnHHjM+lNl8aeXpRNL8Q24i
X-Google-Smtp-Source: AGHT+IHNA6XybUky+XOgMeIdLaBli11kALj6z7ErPNCO0GKInoPJQDHw2ePlzrIieSLuzlwB0GbSLA==
X-Received: by 2002:a05:600c:630f:b0:456:18ca:68fd with SMTP id 5b1f17b1804b1-45898a828a3mr27912095e9.10.1753884263659;
        Wed, 30 Jul 2025 07:04:23 -0700 (PDT)
Received: from [192.168.0.33] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b788f5f255sm10023729f8f.13.2025.07.30.07.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 07:04:23 -0700 (PDT)
Message-ID: <9843578b-2adb-4f6f-b3c1-99dac003e2bf@linaro.org>
Date: Wed, 30 Jul 2025 17:04:22 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v2 16/29] mm/show_mem: Annotate static information
 into Kmemdump
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, tglx@linutronix.de, andersson@kernel.org,
 pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 corbet@lwn.net, mojha@qti.qualcomm.com, rostedt@goodmis.org,
 jonechou@google.com, tudor.ambarus@linaro.org
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
 <20250724135512.518487-17-eugen.hristev@linaro.org>
 <7ecaae9e-a088-4c1b-9caf-6a006a756544@redhat.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <7ecaae9e-a088-4c1b-9caf-6a006a756544@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/30/25 16:55, David Hildenbrand wrote:
> On 24.07.25 15:54, Eugen Hristev wrote:
>> Annotate vital static information into kmemdump:
>>   - _totalram_pages
>>
>> Information on these variables is stored into dedicated kmemdump section.
>>
>> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
>> ---
>>   mm/show_mem.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/show_mem.c b/mm/show_mem.c
>> index 41999e94a56d..93a5dc041ae1 100644
>> --- a/mm/show_mem.c
>> +++ b/mm/show_mem.c
>> @@ -14,12 +14,14 @@
>>   #include <linux/mmzone.h>
>>   #include <linux/swap.h>
>>   #include <linux/vmstat.h>
>> +#include <linux/kmemdump.h>
>>   
>>   #include "internal.h"
>>   #include "swap.h"
>>   
>>   atomic_long_t _totalram_pages __read_mostly;
>>   EXPORT_SYMBOL(_totalram_pages);
>> +KMEMDUMP_VAR_CORE(_totalram_pages, sizeof(_totalram_pages));
> 
> Tagging these variables that way is really rather ... controversial.
> 
> As these are exported globals, isn't there a way to have a list of what 
> to include and what not somewhere else?
> 
> Not sure if any of that would win a beauty price, though.
> 

Annotating the variable was suggested here :

https://lore.kernel.org/lkml/87h61wn2qq.ffs@tglx/

It does not win a beauty prize but it's simple and efficient at least.
Do you think it would be better to gather all the annotations for the
globals in a single place ?

Eugen
