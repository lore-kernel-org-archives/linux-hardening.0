Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA77D14D2A4;
	Mon, 10 Jun 2024 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718047258; cv=none; b=EcQSuf31VElppyxPioMqDmLVWxl7/v9tpCcjtzZUttePbfP3HLSAIXFEASWPmfDCTXggtbsb+60ZVroOrMAdF5VKr0bf/5pZbcGuJGg+uaC7FVlRh1tlG0A689Mkee1oUv81a7NuzemJhfF14E4bxw2qmQd0HvI+KBagouuzVII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718047258; c=relaxed/simple;
	bh=kt1bp0olkBGzyt6Nu7UC9ZUgmN10seHUl6pXobv+WAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gI8veqZopNcA1nWZTeKjzfGUWnATOFR45gwpu58DR3g4jXh0ymx2hdTXIhquAH1jPU5NRg81y1R+OY6o/OCPyJoR/1pi2yY3cVUnOPuar82Rwiz4T4CmxBXSs4J6KSFbW47FBR2kU5De0bJ5nwG7fYlaA/PBykh3S6DN4WYsxpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdSLRZxq; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdSLRZxq"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-35f06861ae6so2729340f8f.2;
        Mon, 10 Jun 2024 12:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718047255; x=1718652055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Fwxg+U8/L4kUngah1ecBeYb5cChpXVPmYuFhLTZliY=;
        b=OdSLRZxqHU2CTmGvdAUHUreIpsGOMoqqUpK4iEI3dIR2IIE3RAsymFMSkWp6gQJAvv
         8eJ0Fam8LNh24sYdamtPNg7Pk77CNORwZzE3+1YvuJ8jCAoD+X9beynX9fGjWuw21K+5
         gXnAVbeb6vQGA7sgLurqKPE9s/3GevpPCWKUy2+TCyhZs2RxVXpNLjbmQ9rnJJwBggao
         +aWlUrCSV/zKGBDYG0iOLnetrhvxK/NdagY2OHlYuzCF1DluJFrJu26DUlqCBrH5LyE7
         v3dYPTkwOSRm5ZyxEtR1C1KV/961a87bGO6exYMFjc/FExPN2LnpfiR0zKruC92UUU2K
         +DWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718047255; x=1718652055;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Fwxg+U8/L4kUngah1ecBeYb5cChpXVPmYuFhLTZliY=;
        b=B6LsrhR1159jOrhxd+9GuJ9O3HC9wYBpY8BAmrjkA8uNX/QZHpOaSV7987fuaQV4fy
         a9VMK9V+bvZtNQkMZvwblZp3jIV67X05+cwi7wK6i6rP/86ip1UtWpT5ncICdSA3hdnk
         zfNFW6vTZlk1eEdSIlt3Dwht9War7MiHMMh21sFvdgzFrw9mgt6CO7oOAacG7wrwWd9v
         hQBdlETWm+6660llOTfGO4jAfp0Aclb/RqPjGs9DgVApoxzGmZOT9e9I7CQmzhQPKHrP
         NmH0+4FgoEKN92/vsNZdLqnPyZIT8HuJOzCvEG63YWzMb5QxXmRCldbgK/QfKplf0RSi
         HlPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcgomRAYvXI1EMhxWX55BQJT/B8gK98cocetPOrOOG54jwW6gDzAiR20HlgysNcpUA197tAlCxzF30MWy0pxSdXlx6ymwLkdiwpw5P0jIY3ymYDOFyXJIcdpxvN96g/AhMC2eizwB9MKe2f1a9
X-Gm-Message-State: AOJu0YwnBMGF3+YmOZvZwtI9uM2VDhIQv0H0wqNdhbOQjw6sfsptbg7r
	07iRncfp7em43mzL/NUIke95XgS61ryX7ch5PgG29zpzNkzxPmIKIvKCCD9M
X-Google-Smtp-Source: AGHT+IFat6zDS6FF0+LTYBRonG3fD/7yN5MDQC6zZI3WaIUFD/lehrkeGgjA7zSlbf7b6aPG2bP7Gw==
X-Received: by 2002:adf:e9c5:0:b0:35f:9d8:9a48 with SMTP id ffacd0b85a97d-35f09d89bfemr5721228f8f.56.1718047254956;
        Mon, 10 Jun 2024 12:20:54 -0700 (PDT)
Received: from [10.5.1.156] (188-22-218-164.adsl.highway.telekom.at. [188.22.218.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f25dc3f07sm2824329f8f.79.2024.06.10.12.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 12:20:54 -0700 (PDT)
Message-ID: <06f85db2-10b2-4921-b3d6-0061e9801e0c@gmail.com>
Date: Mon, 10 Jun 2024 21:20:53 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kunit/overflow: Adjust for __counted_by with
 DEFINE_RAW_FLEX()
To: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240610182301.work.272-kees@kernel.org>
Content-Language: en-US
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <20240610182301.work.272-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10.06.24 8:23 PM, Kees Cook wrote:
> When a flexible array structure has a __counted_by annotation, its use
> with DEFINE_RAW_FLEX() will result in the count being zero-initialized.
> This is expected since one doesn't want to use RAW with a counted_by
> struct. Adjust the tests to check for the condition and for compiler
> support.
> 
> Reported-by: Christian Schrefl <chrisi.schrefl@gmail.com>
> Closes: https://lore.kernel.org/all/0bfc6b38-8bc5-4971-b6fb-dc642a73fbfe@gmail.com/
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
Thanks for the quick fix!

Seems reasonable and the test passes now.

Tested-by: Christian Schrefl <chrisi.schrefl@gmail.com>
Reviewed-by: Christian Schrefl <chrisi.schrefl@gmail.com>

> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> ---
>  lib/overflow_kunit.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
> index 4ef31b0bb74d..d305b0c054bb 100644
> --- a/lib/overflow_kunit.c
> +++ b/lib/overflow_kunit.c
> @@ -1178,14 +1178,28 @@ struct foo {
>  	s16 array[] __counted_by(counter);
>  };
>  
> +struct bar {
> +	int a;
> +	u32 counter;
> +	s16 array[];
> +};
> +
>  static void DEFINE_FLEX_test(struct kunit *test)
>  {
> -	DEFINE_RAW_FLEX(struct foo, two, array, 2);
> +	/* Using _RAW_ on a __counted_by struct will initialize "counter" to zero */
> +	DEFINE_RAW_FLEX(struct foo, two_but_zero, array, 2);
> +#if __has_attribute(__counted_by__)
> +	int expected_raw_size = sizeof(struct foo);
> +#else
> +	int expected_raw_size = sizeof(struct foo) + 2 * sizeof(s16);
> +#endif
> +	/* Without annotation, it will always be on-stack size. */
> +	DEFINE_RAW_FLEX(struct bar, two, array, 2);
>  	DEFINE_FLEX(struct foo, eight, array, counter, 8);
>  	DEFINE_FLEX(struct foo, empty, array, counter, 0);
>  
> -	KUNIT_EXPECT_EQ(test, __struct_size(two),
> -			sizeof(struct foo) + sizeof(s16) + sizeof(s16));
> +	KUNIT_EXPECT_EQ(test, __struct_size(two_but_zero), expected_raw_size);
> +	KUNIT_EXPECT_EQ(test, __struct_size(two), sizeof(struct bar) + 2 * sizeof(s16));
>  	KUNIT_EXPECT_EQ(test, __struct_size(eight), 24);
>  	KUNIT_EXPECT_EQ(test, __struct_size(empty), sizeof(struct foo));
>  }
