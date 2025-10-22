Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345892EBB9B
	for <linux-hardening@vger.kernel.org>; Wed, 22 Oct 2025 05:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111305; cv=none; b=DQNDO/k1jae+i6+Ljwrc0/JIv+FaYw3gqc0sk4IxK1ftc912ijAPsgOJHOwVdH6SN8UwUtZsa80g8twcnZ8luUYOZGT3OP+h99CbNAVyCtjot9mjAV/iBLf/Htx8xDQRps0rlNP+lPbXtb+WUdfOzRDCYH7xl/ZnW38aLs/Xjuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111305; c=relaxed/simple;
	bh=Yfli7nrNGWAirNBDg6CXZHLXMoqOZK8KHRWfvR153kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+4NQZGVR65ndb/5iy7dVzuTpqcRss19CXYDU5hQTsu0jhh5EH3yKbVL7jAAACDl7E2mboE00j2eYgDwpicax1IEsArpWdvENSaajsgiWtWxCcNLVxQr8JCgYaNDb1YWe1PgRNUsC/XGO9wNjqZpDBA2sKQnTAUdawAUEsCOHIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EA4JWB16; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EA4JWB16"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so84281215ad.2
        for <linux-hardening@vger.kernel.org>; Tue, 21 Oct 2025 22:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761111302; x=1761716102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=56ezGE6Ds9KP53wZYmYW6a4SSoZf29RYPFd4r32eFsg=;
        b=EA4JWB16r+NXgjHMeMN9NN9KSu5R9Yy8KCxl56vrgzUuc27h1WpYbekyKs+ngvf9E6
         YpCEaSjFsZqtKKfIR1Ue70YGGJ9nYuBDXFecfpdrhbxJdTQ+nn/VMC9oqoVsDd40p22f
         Ez3Lq5AxcYC280OcvMweY60pM+McAPT2MaBL+pHBXNtixInkzvh2RpLuC5XkD2VlMgyC
         pGgFj606MBeT3mQM8LTJ98jLyjvJi91wfE80JCFpjtcBMm5FgTYh3kOlK7x63zezL0UJ
         EZf5ahL87tSLqOSuxv1gZAPCzM2mTMv5wiFvFHGJhvUJeFZwM0WYnmXHcnR/wulCKIfN
         zDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761111302; x=1761716102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56ezGE6Ds9KP53wZYmYW6a4SSoZf29RYPFd4r32eFsg=;
        b=LPt85Wf5olocI7G2I5SvuTgkPnGDRovQKgUl0BzDo3mTDiqAsCgA/7vXNbcwRhV/PX
         OcSorfbC0AS/lESfIk2FqLZBPrjO9iRuRUYVrjV2tMTvVO/9t9RM3Vw9IY/Dw2F96V4B
         lUjNd+sriPoQ0t63CPPkXzdaY5GszhoHtc+v1j4+vXNP6B9rrsS9WelH9JZu7jUUlHuY
         rvVS6MeieVHHlcN3dLutkOWSMZNC90gtXKeHd0lAWaRNmTdyfGubCZZZ9hxgtYob0vUN
         Snr25JDmvFPLK4bCo67iQJuXKdwmGtWjpNjl76w/ARRo39X+3Tl2YmnjSg1gNEQlxdxY
         tg2A==
X-Forwarded-Encrypted: i=1; AJvYcCXmAbwXK0JXFVnHARxbLteQHnt+7/VJ5YLsGrzJVnbyhyoeAdVrcUlLB62QhYk+WTvyby/vqYIPa6Wwk+Iwdew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxeet0jQKVxoxmKWaPdLVyv6jH1BobgUM9OfWBHGfDJp+VbGOfR
	EeFGGodg9CULhzjrvDyh91OZMBLVMVfeA+ub6I2CRNf8gElR9YSgBIwEvRozO63CzrM=
X-Gm-Gg: ASbGncuy5azOTCzEgme6howV5Q/Zq+LpbHXGQZbpSjODF2XfNE7qx3/GQYESAsoExqe
	pcxVv9roGLplxz92K2QLhawXCc+SmZh3+bTFlJEbKm0keK9bLUE5Wa9aSng1oC2MaN8s4p0iKS+
	M0CKQ6JE417bHjKqvr6bmNxAa9jNP0Ug+ZwGD6Hsu+ADkclka5aP3w8XaMVPADmF6popmj2ZK+R
	AZW6N2iRI51H1nyXqbcZwjNBY63o3GGI4qDQxVXfufNzqnvbOi3NZ8CVjM2LMyHgnQt/1n1uiOO
	AW2b3Qzbs5KiEX8YJ2r/dqB1t5clUblgVEqqPQzTpseAA6GttToj3rhCDmS2iQNkhYZFYM/V9mB
	coyDtBLDIX9aGUeMSronnq48GW4m4Wx7tqdnynPILUqxQ+nkT4YreuOGiWI+YgtSR3Z5NWYbp7I
	cyQfj4eWMQ36+E
X-Google-Smtp-Source: AGHT+IGnVjE3oW9jfoMl45fRu62Au+V7hXBYTBJW0Xz1osI8MZwsrdpeSGQan//AK1Laa1HoxY0dkg==
X-Received: by 2002:a17:902:ce07:b0:290:a3b9:d4c7 with SMTP id d9443c01a7336-290ca121944mr241503655ad.30.1761111302331;
        Tue, 21 Oct 2025 22:35:02 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a766745dasm11961911a12.14.2025.10.21.22.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 22:35:01 -0700 (PDT)
Date: Wed, 22 Oct 2025 11:04:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-hardening@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Replace deprecated strcpy in
 cpufreq_unregister_governor
Message-ID: <rgk3oym7r2gkx4gjqsot3n55s4jtlgyl7vayutaneyuqegybzl@njlf3ohiykjq>
References: <20251017153354.82009-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017153354.82009-2-thorsten.blum@linux.dev>

On 17-10-25, 17:33, Thorsten Blum wrote:
> strcpy() is deprecated; assign the NUL terminator directly instead.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 852e024facc3..0d3e77cf96a7 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2550,7 +2550,7 @@ void cpufreq_unregister_governor(struct cpufreq_governor *governor)
>  	for_each_inactive_policy(policy) {
>  		if (!strcmp(policy->last_governor, governor->name)) {
>  			policy->governor = NULL;
> -			strcpy(policy->last_governor, "\0");
> +			policy->last_governor[0] = '\0';
>  		}
>  	}
>  	read_unlock_irqrestore(&cpufreq_driver_lock, flags);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
