Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B656502B1
	for <linux-hardening@vger.kernel.org>; Sat, 21 Sep 2024 05:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726897534; cv=none; b=uuhyNE8CGN8KPUxdAm1ci2OvvaM7hDUo7dOZywxZouganAr+FtAElt9nOOSYFndDEE0IA2CUYIIM4kkKY4BmYuCb4BZFck2Lw+ASjsJkHbMTxuHwSc+0JrfoCC+DKqZnIVGOyS62c7Nr9A0zQ2Yr7R/Kcme7wx+RMjpsLwrowPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726897534; c=relaxed/simple;
	bh=mRY+u52b0HS9G77V1X6KCObW5QNyLv/D/xsBI18z748=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwBDnv7wpx8WpAyVIxjdFPRKarioZ1Pp+JaNSIvgw4yztFGyZMBEI0jDDgpI+05nzfyNuj+iojTVz4xiMlHpBNlVFZYLTGg6Aht6p9bFczOrV8ni9xjKEPeqJZPEnyRvcxN6mDKlrc8M982gXsSUv0frVbRMHwp/GfhQE8/mxpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d+r4x3zc; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d+r4x3zc"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso465066466b.1
        for <linux-hardening@vger.kernel.org>; Fri, 20 Sep 2024 22:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726897531; x=1727502331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tt91zIU78UembNOoavBRGKqs4HCoYoTrI5Z7h5+MO2c=;
        b=d+r4x3zcsKbS96WYeYwjG7kWQnDToW8sf9GSrSyY9Spl00aIxwMTRVdYWYQ4vTC5qm
         aAfbc5kNJSFxHs9XLPu4vxXCq03vQq7nTRSn7AUVpAqlYNgFZC9QSColu8ArlKgajcQ0
         6HghqeKEXworXsgwR+pIEFvHjpKr7S++LHLiGgNBA4z6h/kgXKQnc36/MWTNzCdE1x3K
         5vPnYOi3b6vA0E4+ouPtj1gRf6UHli9WUoWieb3NlV1MnXg0H6ZnyVJirHfMQQYer2St
         FWVk8UU17R+4nFRxU6SMVY8UIwxWJfGT/tZe4qvdvaRxy3JIAp9r8EAZv5Ndjw2NsVXd
         x+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726897531; x=1727502331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tt91zIU78UembNOoavBRGKqs4HCoYoTrI5Z7h5+MO2c=;
        b=Ov0JaiWFD/JywSrKedDR5Onw1wACwxz0PSe4lJbjK9STy05bZBJKdBOGboc6w3HMuQ
         pfmauwSlYDRju1CHW174iKrJ5Ji0xMxBMFNLq7Hbqyrslh6/RBCyhhBlS9hKNpd9ZUi3
         9oRweifvcEwMyk9O6eOFW/g3/G6ow1G1hxSJ2hGkmzyhfMt35BsNu/xh4DG5KFi/RyKR
         t/sJs8zHyCEpy7CitP5/OInsSBbKdSOkFi3/rGxvpzTpt2mMDqFOAKoDiYxQH3WWeCDu
         Jk2pd4PZpx5OOodU9siUg5fK3mxeuZGv9dgQKedJdAKz0O2GVSPUNtCDYwuXKBiXfvSj
         FHaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3CLGTVSwog7rJvvNfC4nqpXfMWk/RffsGuRLSON+802iFm6bhqUcrZCEvZ9UaATGhUjfOmiKBj7XGl2neKvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4mPv0ozTCLZ+0vR0092P+ipGX3pUzHSrsxksvx8Rt15Pqhd9+
	WBdSMRs6zpx2qjad2A9d44KmX/dj65bIuP5AjL4OwwKJi2TrZuQce4vmz6Ow99o=
X-Google-Smtp-Source: AGHT+IG7vuSvZQQrOANcGu/QBcXt2ctzgd+JxbXK3wqq7h22fBgHCfoWtmF7mHf8rru4jQdl1tYn1g==
X-Received: by 2002:a17:907:f1dd:b0:a8d:42ec:e65d with SMTP id a640c23a62f3a-a90c1c384b1mr880535466b.7.1726897530859;
        Fri, 20 Sep 2024 22:45:30 -0700 (PDT)
Received: from localhost ([83.68.137.68])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061096a3fsm943697866b.15.2024.09.20.22.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 22:45:29 -0700 (PDT)
Date: Sat, 21 Sep 2024 08:45:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] container_of: add container_first() macro
Message-ID: <694a8a87-cc98-4c04-8228-d399133fdd39@suswa.mountain>
References: <Zu1vekikKNR5oUoM@elsanto>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zu1vekikKNR5oUoM@elsanto>

On Fri, Sep 20, 2024 at 02:50:02PM +0200, Gustavo A. R. Silva wrote:
> This is like container_of() but it has an assert to ensure that it's
> using the first struct member.
> 

I just remembered that Greg wanted this based on container_of_const().

Really container_of_const() should be renamed to container_of() and
container_of() should be renamed to container_of_helper() and we
would add a #define container_of_const container_of for the transition.

> Co-developed-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  include/linux/container_of.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/include/linux/container_of.h b/include/linux/container_of.h
> index 713890c867be..928c5865c1b4 100644
> --- a/include/linux/container_of.h
> +++ b/include/linux/container_of.h
> @@ -22,6 +22,24 @@
>  		      "pointer type mismatch in container_of()");	\
>  	((type *)(__mptr - offsetof(type, member))); })
>  
> +/**
> + * container_first - cast first member of a structure out to the containing
> + *		     structure
> + * @ptr:	     the pointer to the member.
> + * @type:	     the type of the container struct this is embedded in.
> + * @member:	     the name of the member within the struct.
> + *
> + * WARNING: any const qualifier of @ptr is lost.
> + */
> +#define container_first(ptr, type, member) ({				\
> +	void *__mptr = (void *)(ptr);                                   \
> +	static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
> +		      __same_type(*(ptr), void),                        \
> +		      "pointer type mismatch in container_of()");       \
> +	static_assert(offsetof(type, member) == 0, "not first member");	\
> +	((type *)(__mptr - offsetof(type, member))); })
> +
> +

I added too many blank lines.

regards,
dan carpenter

