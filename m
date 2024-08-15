Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3D15A7AA
	for <linux-hardening@vger.kernel.org>; Thu, 15 Aug 2024 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723747216; cv=none; b=VahGg40uUcRnthVBxVhWkmYg7xC98wlmtYSEyzp3VSKPYYau51OpWcSzJK6ckiv7o9xj1VyTxMBpFtZqnRuNyZnIdz6Q4SrbN81yVinw3nIErouFWue5nIFwMEhzgZqb1En2voXER8sLHIato9r4X/gHQveFiebEu3rKbL6q1gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723747216; c=relaxed/simple;
	bh=ZE4Zz5osrC49M/vXSCOxNNjmTAzpqaBfhvQtNfarPYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1Ktv6k0Uc+OlKzrslmIBJkasfYSmK+UXHaO95Sf5X3P+QvUYMnP88m9tvSXH01K7hdLubhLq1DKVbsFXKnQhxzjrvRUJDWAypVeokSGkdAeONgM0BOpN2T7Oh03cCstoVVgCN762T8U+ZYWw/atNRzsV6Q91kHUoBmiuB1H0wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gjBqoKQ6; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gjBqoKQ6"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-201e2fe323aso829965ad.2
        for <linux-hardening@vger.kernel.org>; Thu, 15 Aug 2024 11:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723747214; x=1724352014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7G23jOysGth/FGYl0E61txbtZGC7pVkDJVfmjAiyIyQ=;
        b=gjBqoKQ6LjgERViBhLxF4dtLkLUs9u4dM4mtmBwxxZjkqjj8Ty+rGeLrYqV+ycrG7P
         2Oazrcz97rWoKtn6Iqtn4uKIWmUURYtBt0WJTKtpXZn0w4xOVvSyQDFbu8FywDD0nXwR
         x6LvpcUPXUSrsMVwPEVqm1iJdUWjPIlt+wmSRH3K2hGRegepbsDQdI/GSgEjldgpVQpX
         cak+uULLThN64MHfXp8kFJW2AKaGBx+rEhAv5eGtvrd4p1kugAzndN1vftXdP/XOyoEU
         OoIEyl2S5FMSJ6S8Sz5gI5KxS8gEXBbf1wS9vZdablK5Qo7rDgwGVd4dxkDeWtDG8D7C
         PaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723747214; x=1724352014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7G23jOysGth/FGYl0E61txbtZGC7pVkDJVfmjAiyIyQ=;
        b=TjU14wCsBpdRYj7x+tdBI5XmdV86kE4Fl2icf2RRp/SNBgHL04KLIuyfMMlAK5TdNW
         8t0+WiAuIW7JC6fjqP1bvJuSFgboHsVrWj5LAqoKAPf0t0hE4k8QD2GKQFqKWuyN5oiY
         oT0zperDuVGGs8+t7SMZMbKTkQiLpPI2ebRSxbke+e7HCNrEcKnU1+xWKgqsozAU/k/k
         XLn7M5XKd1dd2i8UkVg/f9RIuXnu+jUau2LKjyJ8as9dpaukYE0DOsG89NAt0ZXJamcB
         +oA6pdfQNckKsO8F/yzSAs/3sBjlNwslIHAmZ0d15Nlz1KOszKDzeHN6FAwVESOPOK3b
         7Hfg==
X-Forwarded-Encrypted: i=1; AJvYcCUzwyuFTC8cqvgzaHxdJY6zM23hKxBY5O6QliUaCn8iHqKng6Ij+Gkzr/smZXHCB+SyvvILQzRImOW0hPS7mF3uHQhyH7Oi2k4xJhlRiF1x
X-Gm-Message-State: AOJu0Yz8yINu2Y2MPP6zHuBYnM/6IrgBmloRT+nrCEJR8AxtlqoVEDsn
	tuoWe50ttsti0myTQY7Y9Pc+KtJlTSskun9WSHRPhTDEMYdRtcjokG5kYqiliWE=
X-Google-Smtp-Source: AGHT+IGOntniUG4ZVlSqTpFpIJZ+pJk0zhBjp0RK1k01rfRL/yPln2Wx1vv0rBpcdb2aXIxs9xW8tA==
X-Received: by 2002:a17:903:2291:b0:1fd:a54e:bc41 with SMTP id d9443c01a7336-2020624daebmr1154665ad.8.1723747213972;
        Thu, 15 Aug 2024 11:40:13 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03a565bsm12995635ad.263.2024.08.15.11.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 11:40:13 -0700 (PDT)
Message-ID: <1019eec3-3b1c-42b4-9649-65f58284bfec@kernel.dk>
Date: Thu, 15 Aug 2024 12:40:12 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: UBSAN: annotation to skip sanitization in variable that will wrap
To: Breno Leitao <leitao@debian.org>, Justin Stitt <justinstitt@google.com>
Cc: kees@kernel.org, elver@google.com, andreyknvl@gmail.com,
 ryabinin.a.a@gmail.com, kasan-dev@googlegroups.com,
 linux-hardening@vger.kernel.org, asml.silence@gmail.com,
 netdev@vger.kernel.org
References: <Zrzk8hilADAj+QTg@gmail.com>
 <CAFhGd8oowe7TwS88SU1ETJ1qvBP++MOL1iz3GrqNs+CDUhKbzg@mail.gmail.com>
 <Zr5B4Du+GTUVTFV9@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zr5B4Du+GTUVTFV9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/24 11:58 AM, Breno Leitao wrote:
>> 1) There exists some new-ish macros in overflow.h that perform
>> wrapping arithmetic without triggering sanitizer splats -- check out
>> the wrapping_* suite of macros.
> 
> do they work for atomic? I suppose we also need to have them added to
> this_cpu_add(), this_cpu_sub() helpers.

I don't think so, it's the bias added specifically to the atomic_long_t
that's the issue with the percpu refs.

-- 
Jens Axboe

