Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DD813A256
	for <linux-hardening@vger.kernel.org>; Thu, 28 Mar 2024 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711662652; cv=none; b=be9J56Tlawt1R13wFx9QvzAayGOuD1BOb0Nw4oMXUhZWtMsHhRUkPIcdnvsmQ3ePsDsLPPlk9BzcSjIdtJ8x/4kKfb+L/WCURs+hE5eFzlRaxUnZKAc1kYs7z0VwCvYiCF1GwJBMQL+LV0TVKaxa96cpKmuesQk6SQXyV8xyyxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711662652; c=relaxed/simple;
	bh=AaG/JQ942744By6JWnpn1/mB71bmQP7Qf4tM7JpBi3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsgFOidEM9bhzsYxIN/BAGnXBGIcsjtZfZpOikr8SpIIoc1kKC8RZQchXJ8Qal8d862IOwhTr8OorFGBE7APkJ8lnS0m9aDpuD9LRKXS3cMA3t2/5QbVSuQaDeYQff5e6IGoq2E6VEvieH/Y5nt6YffJvOdLKel72SiVEZYJT4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BVFisEnO; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BVFisEnO"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a480985625so849318eaf.0
        for <linux-hardening@vger.kernel.org>; Thu, 28 Mar 2024 14:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711662649; x=1712267449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c9VNKqIZeu5aRMq+EcvLmL1iZpaTvAUz76/b2Q6IYI4=;
        b=BVFisEnOj6o3zIgtDl2rkZ1dNUmJESvVH14PV41cPjpWHSi/XaQ2rmvr0WSlsLg350
         s6iSJalUYEJlHpfj1QZ3s8O1eiJ7bG9obOEy00gw13Km7mDNbq266NdZGAPoZXL7t80d
         mtj2BVvwIM4xI942JI0YWH+0lDsKpNUhpxKu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711662649; x=1712267449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9VNKqIZeu5aRMq+EcvLmL1iZpaTvAUz76/b2Q6IYI4=;
        b=uuTwBHHn8szjORO7RTSVkjpwYOO7OITytyIJs1XVbgszJiSMnwWc18Lcanbxy23zgD
         yNJWWSoMJCDKaFqyspq1ccCtmde6wu/OB8HRiqaHJ2YDNDFigiuPjoHaEV54d641FCq2
         35rKkv0yiA/0SlFM2adCYzMNZsmPEJnwH78OY5PvU6VBCOGWxMwShTi1fCQwDqYerPR4
         a0Cw/FzmUw4SHq/9qyvDBsXtyIqg6YpIr+Eai4pjvqiCiQE7fpztn1iWSi7lNNGCBE40
         0aJdkvRjB1yNiHi451Pp702IBbvuLhMMGsUUQN/hsOoFE9TpdpwqwJFOD6WJj4J3Eb1B
         FIRw==
X-Forwarded-Encrypted: i=1; AJvYcCXMyUj0oJ468PN8F5psHrlfxyWvpx7adPQbVwBIR6FOJBbBopE08Q7aneV+mF6jKyWefi+z9MR9Jf1yL46hqkzmUMyr6dZpNgtwPsYibkmx
X-Gm-Message-State: AOJu0YyCnNe9TXg/nqZt/dggeOz9rOs4g06hdjJfhQ21IqaZxhB9dC6J
	nrv/dB+5s6RrPicOr/mKDL6pF0XPc0tmsBcewlPXfEV+s3xvS7q/R1GZx6hxwg==
X-Google-Smtp-Source: AGHT+IGJ/A8B+g2+nP/nK7KddniHxRqwqdU/PivvhTlgMDDkbuncjn3iau7BevP2DI44v43cswmPHg==
X-Received: by 2002:a05:6359:4594:b0:17e:9c8c:2c25 with SMTP id no20-20020a056359459400b0017e9c8c2c25mr728796rwb.7.1711662648877;
        Thu, 28 Mar 2024 14:50:48 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t62-20020a632d41000000b005dc85821c80sm1739857pgt.12.2024.03.28.14.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 14:50:48 -0700 (PDT)
Date: Thu, 28 Mar 2024 14:50:47 -0700
From: Kees Cook <keescook@chromium.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	linux-hardening@vger.kernel.org, linux-wireless@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Hancheng Yang <hyang@freebox.fr>, Remi Pommarel <repk@triplefau.lt>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] wifi: ath9k: work around memset overflow warning
Message-ID: <202403281450.CAD08A9B@keescook>
References: <20240328135509.3755090-1-arnd@kernel.org>
 <20240328135509.3755090-3-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328135509.3755090-3-arnd@kernel.org>

On Thu, Mar 28, 2024 at 02:55:05PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc-9 and some other older versions produce a false-positive warning
> for zeroing two fields
> 
> In file included from include/linux/string.h:369,
>                  from drivers/net/wireless/ath/ath9k/main.c:18:
> In function 'fortify_memset_chk',
>     inlined from 'ath9k_ps_wakeup' at drivers/net/wireless/ath/ath9k/main.c:140:3:
> include/linux/fortify-string.h:462:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>   462 |                         __write_overflow_field(p_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Using a struct_group seems to reliably avoid the warning and
> not make the code much uglier. The combined memset() should even
> save a couple of cpu cycles.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
