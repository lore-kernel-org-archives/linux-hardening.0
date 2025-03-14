Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251272E3385
	for <linux-hardening@vger.kernel.org>; Fri, 14 Mar 2025 00:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741911636; cv=none; b=NZfiCbCn/PIEIyl788aBAhg69FHUoSG+fIzyd9BaGb+z/1lGpPRDPyXfq52bPHvklCCCoGvoiZXy5+EaUT25YIngbC4bLo8bf21Wg2sbaC5B0a6I0BoMaLwG8dGbyQ2GFhUK0yXrMrk2Fc5Ug4OP5PBVHkLYL9kHS50dkxJ5gMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741911636; c=relaxed/simple;
	bh=S5YjmPSadUARmwccSDcjcvFgEP5CfKEn0cJkIPybeFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCkEM2H3qNSze3HpER/A8pkAP9O1PMrJk/NsGeB7wZtdAkNnykMoKzDEyNs2nSCz4NEwhPy+4A2Lb7fSBylyDByFShpcwdCPOBjZtsRl3Vjf2aRSKjd7shWhxsdoeNicBJfnBUmlFawghMYoPpcVAlpHdIvP69dgJMGTwH52VvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bk9YWhzZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bk9YWhzZ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22349bb8605so34844065ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 13 Mar 2025 17:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741911634; x=1742516434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xKQQgSJ6pX+A9i14RTtMFH1e8UlSjoleXWfJUUAl0Zw=;
        b=bk9YWhzZD+4uzg9e5U9vm41+LBdIfHi2oP6vq9sYKcMX7KsEkwAcHu/BpZj+960OG+
         8HRCY6wGXrJcSYJM1D4s7vflTpyuynG0OWepheCkxLrK62PrLszL+LGCeuAjBzDKF8PD
         sj0OH9eIsbX6ngjm3K7Fl+ZvarBfZzyiAiXBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741911634; x=1742516434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xKQQgSJ6pX+A9i14RTtMFH1e8UlSjoleXWfJUUAl0Zw=;
        b=cMdyqQFAoRlubUm9X6wLjmxlAmA6N+nb2kQunPY4vlpZaj4YKe9jyOQ87kfmi4RQmb
         XSZbpnf7CoCeWOJouddfAQ6WjI53hVPWpoWWRXd3mmCgS6lITbzZjhCgtVLBQBReUsl3
         fh8BJOMvJRT9wXdXxQRiQri2R5nO/azkRxAU70NJMxQve57nojb2DI3APcxPWJNscXrJ
         ajl1n737KV/u1KPdQt8jFjVFKWBRHyzbKeeY6z6HkFmg2pgJtDsLsI0w9Rd1KfzHTRQj
         N46rhtN6aPsDJ4W4QPY/1o5eJJJXvYjYE0cXuu5ogXTDGFhslOBbIG5cSpJF9jwW6NXx
         PkSA==
X-Forwarded-Encrypted: i=1; AJvYcCWtIZdbDWaCydphD+o55zo2yZcHz09u9NCbkT+euu0duJdtfooFvMOCtPgvrQMDHxYcuwSzU5hZgfEf3arvzFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXD14h5GONz0i9pDyDEgFfSeU0yLjH8yaeQlk+ZDX6UI5Ax8YZ
	hl9xHwfgjYtba94GHeK1txqTu8Opjx6HO0RiXYuRxIsC245q1cO3+CpZ/r6U/w==
X-Gm-Gg: ASbGncskPFawcXeG40P02dw3ZMprFJdxOghbsjLx7133lz/L523ud1Wjs/vSadWs5PU
	YE9YJdNM5Y1WYQXDxr5yKtd/AlSAQCKu/KwKXtjNuP/ozuwmOJx4r0YKdB05ygFaAo/WRWufAsG
	SjUmxsC5FUb71pTdV/0d6u1S74mWez+AADndweQ6JVYJmEn41iUVlWTAZo9+KGYXl68KwdCDmeQ
	tUZPUBbmF7rMEii7HVL5DYVga38xOsMauRkQgOzXI8z2uWUxYktmdkW/O3vVSDSKuNxEollaWcY
	lyW5fSg3/Tb7TD+Agd5xyUTOz4Rp3VxLzSZKe5LO2NY/ESzBgJS+Yib8w4DZOXPix8OVhfFSgTf
	en0qh
X-Google-Smtp-Source: AGHT+IFO4eHT7EMLxAUZQcUPLJax7b7GpW64YoD3Aqnq64qGUBHwbVXqhyOVEAxtzl2d2b/7JBsA6w==
X-Received: by 2002:a05:6a21:1519:b0:1f5:8221:d68c with SMTP id adf61e73a8af0-1f5c111720bmr946258637.3.1741911634454;
        Thu, 13 Mar 2025 17:20:34 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9e4cd5sm1910573a12.31.2025.03.13.17.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 17:20:34 -0700 (PDT)
Message-ID: <547ce7ba-7042-70ff-8468-8e449be6fada@broadcom.com>
Date: Thu, 13 Mar 2025 17:04:28 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH][next] misc: bcm-vk: avoid -Wflex-array-member-not-at-end
 warning
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <Z9Nd4AmgrQDiK1Gn@kspp>
Content-Language: en-US
From: Scott Branden <scott.branden@broadcom.com>
In-Reply-To: <Z9Nd4AmgrQDiK1Gn@kspp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

looks fine

On 2025-03-13 15:36, Gustavo A. R. Silva wrote:
> Fix the following warning by removing unused flex-array member
> `data` in `struct bcm_vk_peer_log`:
> 
> drivers/misc/bcm-vk/bcm_vk.h:415:32: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   drivers/misc/bcm-vk/bcm_vk.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
> index 386884c2a263..9344c2366a4b 100644
> --- a/drivers/misc/bcm-vk/bcm_vk.h
> +++ b/drivers/misc/bcm-vk/bcm_vk.h
> @@ -311,7 +311,6 @@ struct bcm_vk_peer_log {
>   	u32 wr_idx;
>   	u32 buf_size;
>   	u32 mask;
> -	char data[];
>   };
>   
>   /* max buf size allowed */
