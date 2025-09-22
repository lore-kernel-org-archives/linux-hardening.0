Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FD82C187
	for <linux-hardening@vger.kernel.org>; Mon, 22 Sep 2025 10:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535319; cv=none; b=rDXMDaL2ifbqaJ+BFjywPk9hOSo54pIG+Av/PSsBbhOPNfZpLOTMDgtQHdMlt4MG0UnfBluH68NFh56DXSewoLqU68sehHXVxvuhA7pGa1dpkKBBnnRxbIZHiPLdHvaxzuvBnMQqKbK19fglmvPzaGbyVVvvA2G3YVa0D/HH46E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535319; c=relaxed/simple;
	bh=GLC9unjLHcduutfU2De8SO6Cn5IZFndntQa/0T2wPQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lW6PNcZ4K9sf+6Ow0H4eMQmU6UYx6uK6pfiHS3Qti1iuBfFZIFpbJI4TbBMh90etLuPj1hIbw0IFZrC0kGC72By3qOB7EECGZ25hdWNB6OzgXPjXggUgjABJbrsJ4omFcd7sdCD+CPCP3iaA4wi9oIoL5BhkrfIIc/62dfP4bTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cHO1HZ5M; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cHO1HZ5M"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46d40c338b8so5422315e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 22 Sep 2025 03:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758535315; x=1759140115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y811XUkUAcjUYq9kF2IbC9o9QTenp6PpvmUvV5JyxCo=;
        b=cHO1HZ5M30mU5lJ+mWZ3CuIc02V2Kw+aRK3u+qJ6OaPpYZ8smMH0dyYT9aBV+j5G3A
         5RngpuRemNRb2YCNUzP0pJxaX78uxGNQLguZ0yyIh+JBfbANGjhPZKwxGrntsMUzTWLc
         NRJeDWPfTtYQBs/HEpOUUeVHjTSLKGDAgm4Hu3A7+tYwLVpjk1G2K46X9NNey6VL5K+f
         dohhc3vEM7Oi4lYHZQ2Wjn4MVuI2GpkSoOuoSIV+OmuRxuoVh+SjNY1kjNuchAEF5vcs
         jdPQl+7bVFQsuuvHlfB3KTCLmKUHtkduO6xgd1qX+whD6UJo1QUDV77jRLywTeqCYSoV
         Z77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758535315; x=1759140115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y811XUkUAcjUYq9kF2IbC9o9QTenp6PpvmUvV5JyxCo=;
        b=Vf5ZjMnt/rmlmzBwc8P7rLWYa5IkcCU3bEyIsP/aRojojz0fk67EQxMT4B9H9EZcMb
         RSn8OszVUOYJTf9wFPVwqXXnKDBPxOQkNUprrn1Pn5KBvsmU6N4lqYupGHlrYSNoc5dM
         JdXAlYO5peyyhThZl0OhyQz6LtHsKZ1he6hc8JR3nQhdgWECK4k1BCStrJKBOumixXAS
         ukBmeKGzLPkq/78LzvCAzYZlWhwJibHa1O8VGeJMF0MlgRXetf2TmBAWWL3LUS7tJNq9
         WTvLVZ/UvgjSvgJ0BR0ML8MNoOg733lE1Qr+UeM/eKB2YB9JKDOgkxNNcXFhS7vi/pVM
         wAoA==
X-Forwarded-Encrypted: i=1; AJvYcCUXMJHvU5OZ6OlDVjpRORzRcq2tGPjgooFb0ISRIwFmXJuCEhizlSCqg4Co7jF4lf0WQP1cIfnfDmCgRf2PxAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5/TO5VKMtSkLCcNuTgQvF7fSlM5HqHKe++4YdB69NMhHSJtRi
	3NejIb/a5ASKpI5KnPoBVa8IjfAhGb2gDpfArtjjZ+wkaeSLRKs6jGjy6wyjZmhYzJI=
X-Gm-Gg: ASbGncuFE7agm3RC5tokMYJyRX9MyaAk8CLUb7i75aNSk//QwRkZlNu+fYpSRPvSyLh
	8vwL/gGFE0KR0R5p0JFomdQmTrCPxAtmuRFvxanet/GJjpbGlCoE6ja3+hUnJvcEH1UdZR+8qb+
	AFH2sjVMigSWeQkSPJ+/oVf9jeIWen3uYsQ+Q4tfqJD1C0CXLdcwC9dTEZ13Fq+0sqkSKzoYKSI
	hNoOH+5i9MvyDi2lFVFYxjcHYccgRhDMO7XhuNWCVAMS1x86q8FTZDJFghCCu6I8DqBwUn86v2h
	CK1LHEebwC6eyXndZRHtdxR0+w02wr4hr+rfWyly1u0bt2R53Bdj/LgA8RF4VkrTijKjRXWBVQi
	vsPzcfU1II7SYyH/AojLAvrloDHQhdAUu
X-Google-Smtp-Source: AGHT+IHyiSZQlLreoJ3W3Ph8Q291wVJ5XeiMCjmBz4nM2qvfV1a5GmC8lVHC1BmJs2M+jyBWopho2A==
X-Received: by 2002:a05:6000:144f:b0:3ea:e0fd:290a with SMTP id ffacd0b85a97d-3ee7ca198bcmr9624896f8f.12.1758535315118;
        Mon, 22 Sep 2025 03:01:55 -0700 (PDT)
Received: from [10.11.12.107] ([79.118.185.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee1095489asm18419549f8f.24.2025.09.22.03.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 03:01:54 -0700 (PDT)
Message-ID: <c0a0daf4-e9e3-4152-8e5e-c7b52a30dae9@linaro.org>
Date: Mon, 22 Sep 2025 11:01:51 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v3 15/16] kmemdump: Add Kinfo backend driver
To: Eugen Hristev <eugen.hristev@linaro.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
 andersson@kernel.org, pmladek@suse.com, rdunlap@infradead.org,
 corbet@lwn.net, david@redhat.com, mhocko@suse.com
Cc: mukesh.ojha@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org,
 linux-hardening@vger.kernel.org, jonechou@google.com, rostedt@goodmis.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org
References: <20250912150855.2901211-1-eugen.hristev@linaro.org>
 <20250912150855.2901211-16-eugen.hristev@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250912150855.2901211-16-eugen.hristev@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/12/25 4:08 PM, Eugen Hristev wrote:
> Add Kinfo backend driver.
> This backend driver will select only regions of interest for the firmware,
> and it copy those into a shared memory area that is supplied via OF.
> The firmware is only interested in addresses for some symbols.
> The list format is kinfo-compatible, with devices like Google Pixel phone.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
> ---
>  MAINTAINERS               |   5 +
>  mm/kmemdump/Kconfig.debug |  13 ++
>  mm/kmemdump/Makefile      |   1 +
>  mm/kmemdump/kinfo.c       | 293 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 312 insertions(+)
>  create mode 100644 mm/kmemdump/kinfo.c

I tested the series on pixel 6 and I could see the backtraces correctly
decoded by the bootloader:

Tested-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Thanks!
