Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45173A6EED
	for <linux-hardening@vger.kernel.org>; Fri, 18 Sep 2026 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789714449; cv=none; b=POafnGySFEPRnj0O5AQNvihy3mSKLany688FXWILkNWJjcY7vLAxhoaJ/dz/GTVpDBPKOKGVLC93rz4X60unsglre8C1beZsmdj7jofs7HrvcnodJs9ZjD4GZ0VGeOc5w/99u0AemQtTnreYf5JgzPQ7UXWvFh1t9ztZ3PJTZQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789714449; c=relaxed/simple;
	bh=HO0Fx3ax0UU2Z5oRjHrUjN4W80yZT0eIY4Z95uTICaw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DOQ7aMO9Yoh+/xA1i43nQlXqOO5Mdsmi+ZljrB7pmxehAtpOrURSVFcdCkGXusa6VlA4IDR0c4Hr/ELvpTHOs38nvVSW3DoWfio/d+EfSS6ilSyIlNC5Jy9w3wthp9kTOqAj6ARLdfnlC9t6KKypScKG0zZy4sL259ItfyW2924=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsbaxTwJ; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsbaxTwJ"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd4ba9f68so5020485e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 17 Sep 2026 23:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789714446; x=1790319246; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m2zR6Ef6QPEvOrDpgn+jYsLydgVh7EKGMvYSRpLIAZQ=;
        b=NsbaxTwJde5eKu3AZ5hEc9cftRx1XUZ36TLoKn5BpgfTq3HHljGT2k5Zt3kQTCfPrv
         99AQEaIwa/Ii8zyJi/BDICbjhTbu7ug3MmtMieUx8oAF+LiF9ey4gG8u7F1vL0BhiwC4
         9hWrxsuruvyzqT8rqIdhk8hCU0vuDueJEGjP99GZlLOGNe59JZFDjT/JiVV7k0P/iU84
         GmLWefvi08K+MSLkDk5AFVTs2L4K158GaZKzshrfaxJ8t5d4xL2SfqQSZMX6bhSYN3xg
         TInUVviuvcHKRQ06a/7OZQsCDnYul+R8LR7doh1/4n9iK6T6pKWrzLaiSLmbCzp44+s/
         EL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789714446; x=1790319246;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m2zR6Ef6QPEvOrDpgn+jYsLydgVh7EKGMvYSRpLIAZQ=;
        b=FUkhZVkvTHV3E1gWrN/ssDg4rFlx0uGiH+FBOm7V84cB/VSxhvvJMgS3j/C+Rv0ge4
         EoUws1ZnHoj0A9lMdWmSiR1a8rg3dDX9BDTTKZAgajZHgVMucXLgViHxhKvl4dsprmh6
         FBEpeva9OlCWju3yTPV+g9y25+tUcUYpV04SYAh8FZL4yaqV2y6qAQ0webwfY5enjGrr
         C7mGfN75LIn9DTHDtDYjvpcupb0iMsKXG3cy0q3h7UrOmxKIRXlePz4Ty2rc/YJhBxpB
         X43StwyO6GZCU+d+BqzYynEEIP2pw/lWiA4/XVhtLfPM05WeSETdP5nXZa8/mITOfp1k
         M00w==
X-Forwarded-Encrypted: i=1; AKwUvBykdr92qZVog3ocUAoQboFaqSpgxmXyYPiVElXnxs/6wzFGIRD0N9tPXC23gcU7/FJSjfuhvjQW2FfOW9jqL2Y=@vger.kernel.org
X-Gm-Message-State: AFuF++mHs1sw5QNBSuX6eiegs2i5Y+aF3baiE4GCgeu3m6EncemBxXlG
	6rEycP+gnyoRE9TMSJLVx9dcZNfH6l5Fb6ty84cdnAgyhWumue30LqBd
X-Gm-Gg: AYBFou3UFKY9RMCyOK+bL8s2LeHMDicUDhDfvyvpLWQ6d78j4Ax+wZ6luZG0zGja0IQ
	uIBhu2nlh3QDKNrv/Nv43F/zTr3h6Wvjr6V7HeDV90nwPzBDt+bzg1kSNw+GZOozj553K+oLXP6
	tOsVCtm2uu7b02i17Adk5ntCngp+MPPoF3ApUfKmIi8u9BgJNtEWlSyilwok1td56fwA+FC2fdT
	koOf4hyMPzPAaknZ7raBu1SEYYq7Tg9feMgHNGRRzR6i36Oy/bgEYktZ/+8XBhZKS2KCtmPI4TF
	ObV653Ts5Uc/BbYx3NM0TsgnXc05eTThjzMlVWWptQEF54WXnYtspwuwW/DiHwf4L5JcbhQzTZ7
	kfz8BAAxH/a4fgdp2erlhG+4KXEKp0kM00q3fLi3YF9E6is6jUxIKcwhx6in/dhw/zdv2/mpwc+
	iTEF/s7bhwEzU2ehPHG/6EreF86qVlZ8W/X7bHQxiYjEE3tudqX74RFuNmO6IGPnhHCzddTU6mR
	sPM9NEaemjG6ok22flNhuoLbgqpA4K+4Gx3C5SsrSV8skZ/cdnPHFuga+ctOoCsZXYOBFFt1Yqm
	LeLg/YXqNp9soXNsbdRSoZ6Oze7XHyN76DIcCGJxujh6ONEYTDu23XcQKCzFNQsYNW2d7iaM1j6
	YGilnjbp3uKgPJr36XC5OiUZlYvbl2DjaszuVhNkMRrs5KOYWQeR+ESTP38smSkv7+lhLhR98Mi
	uZVRWc
X-Received: by 2002:a05:600c:6296:b0:49e:6fd2:a45 with SMTP id 5b1f17b1804b1-49fc5737c43mr14719955e9.16.1789714445781;
        Thu, 17 Sep 2026 23:54:05 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4871feb5d63sm1906966f8f.3.2026.09.17.23.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 23:54:05 -0700 (PDT)
Date: Fri, 18 Sep 2026 08:54:04 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Kees Cook
 <kees+treewide@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7173: Remove const from chan_arr allocation
 type
Message-ID: <20260918085404.00005583@gmail.com>
In-Reply-To: <20260917211436.i.689-kees@kernel.org>
References: <20260917211436.i.689-kees@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 14:14:37 -0700
Kees Cook <kees@kernel.org> wrote:

> From: Kees Cook <kees+treewide@kernel.org>
> 
> In preparation for making the devm_kmalloc family of allocators type
> aware, we need to make sure that the returned type from the allocation
> matches the type of the variable being assigned. (Before, the allocator
> would always return "void *", which can be implicitly cast to any
> pointer type.)
> 
> The assigned type is "struct iio_chan_spec *", but the converted
> allocation type would be "const struct iio_chan_spec *", as the size was
> taken from "*indio_dev->channels", and "indio_dev->channels" points to
> const. As there is no general way to remove const qualifiers, take the
> size from the assignment target instead. No change in allocation size
> results.
> 
> Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
> drivers/iio/adc/ad7173.o
> 
> Assisted-by: LLM coccinelle
> Signed-off-by: Kees Cook <kees+treewide@kernel.org>
> ---

Makes sense.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
