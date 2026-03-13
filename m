Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB86526E6FA
	for <linux-hardening@vger.kernel.org>; Fri, 13 Mar 2026 06:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382180; cv=none; b=kreB9HypG8hxzMAhywPwh+9Wh5TxZ14k26oJP+mRkCfVLE2Bj4UQtB8jDhbV02B3YizvX8LMZsLobeGz1G0bEbFmUGHjyg6ybGuIo9cnRCN3cJmgdMH7FMmCFfJfWPJVpFdqVmJPDTj/nROcvniT0FeHaH1N68/R/wj/KlSn5pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382180; c=relaxed/simple;
	bh=tMO9psBLLMvClqTpa7aKiQnuy7/vbHhQyKWYXYxKS2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hh98EbDDT5DUpN9CZIEJaWOyTFwVQh5syt4LO0rL3hpcBOiM5w4jt1mUudKD78tsrdr7m99ERbpUe1Np3RYSjpAjhmT6p9tZ8/1iIwyUlBDxNN/5m92a04TDkQsODYSr5a/2ZqcrZC0MR/iF3SHJucrcFtCmDbaWZrq6ptfZpkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DHArzXVZ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DHArzXVZ"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35a1dd9c842so655772a91.1
        for <linux-hardening@vger.kernel.org>; Thu, 12 Mar 2026 23:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773382178; x=1773986978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NedMiBsFyZMnPxqjdpPK7kjyHNNvVmLJBW01aJOpOfk=;
        b=DHArzXVZUY4noqQmaDcgC2aHSdLdFh0tEgtAdJBO8ho3OPfMYdIC45/nvGsAObjV77
         0cozbjDNikgTIZG5dx4ctu4qd+UNIulooHj7B8ilOxtCVM0LmsnNFkrwrNnFE+lEDH/W
         pVVg7X/vsCJCZCK314O/OsNgF71Sj37/YtBggUYiWAAy0WkNq2uM4tZdTMiIUqZ0/Edn
         BlbzC0LOn7aCCBu3OKGvnVGWcXHaC5Dt4pExwTKY/EyqX73YcH/RCKZL05NA/2FcwzMB
         +0Xd2GK3pYWgKO+1HWMY+SvC/aAYZW7h9/3MIdtlP3mfSZCpQZY/F56bmzyZp2BKfhoJ
         tNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382178; x=1773986978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NedMiBsFyZMnPxqjdpPK7kjyHNNvVmLJBW01aJOpOfk=;
        b=VInPYqXHpa2Ug+RQIiuUAaN3ba6PRPrxV/08pPTTzGrXl/Lj5ry/90FtnotRJTjFfa
         //5Q+Br+Huj/zz8+wL4mAs3/bturHs6tiW9TqEQqDxxf6ru+Kv1e0xfB7TK9u/S26pZZ
         dJqO79S+3g0lSKsDSVT0nkggK+qozIFU0Uw7h0m+R9zXK4v19k3hq1f1SH9rM/3Ql81P
         3SCSSyZEjptHTXFG3WDLSQpPyLIfpxZ8pSU9oTuCx3cbS3K50xKc1A/Op6rBwRit7CiO
         g9uDbPcSKDvD2f52JefYFADWeV3qxZurckfEOTaDgdH520qPWJYLi6lP53QnvNOxQoav
         8u2g==
X-Forwarded-Encrypted: i=1; AJvYcCVqFheb0rAuUh1TmRIBN9pyNb2wStZEdLFCWU+QkFtTBfM7mGu23Ud4odKx2CjI1F875akImCbs4+zlGOwi24Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAu/KWrONIT2fl0n+vsB932op0bya9/bFOUeOFOsDxdWn7KwwH
	GuJR4BoYFULDKPptL/f7Ve8oZE3Zh5PyI2RM3DBKx7xcrZLfh8xEfO37A3qQd9LuOK3igN6wzBF
	1AHOa
X-Gm-Gg: ATEYQzxaXrQpbjAYNblsi1hqgb0degF1R36b78egfIJhQqU7H0he07izRNaTzWjR2jh
	FgAlcA25qUcf/I25UAyyz2PsEk6b12iruM75badJSQbg1Qhm2zapl2de47b2Had8LYF4TUab8hZ
	CB/afYvsyTrPozr8dqHH0nFuqqkC4wTYJnQUYYOCFjPR1F7vQgTOPcd1QXVwLBv7+1XRE++TBpZ
	j8cKQ1Q6dSVU9xohFsqNTdLT13mT9JYTo3+sP8pVHHlL9wL0w+SHpv1oWDy5T2RaPmo+7kcLX/0
	0mS0CI+cjVuWnV1W4iomLKHWu5wXrOGHpI3bGL6SBCLI6nK3xjfssLl6LIgSQdUv/9Z1gfFL1/l
	BSgq7idJXA3EneWxyy5JAQSlU0QOodbG3SPwmgo7yxly0/wCtAAgFg7sowveQiulzZR+GIDGHnn
	X7Zk6x1ntcIcSoRjA5waW5V3t9
X-Received: by 2002:a17:90b:3b87:b0:341:88d5:a74e with SMTP id 98e67ed59e1d1-35a220811a4mr1802735a91.29.1773382178162;
        Thu, 12 Mar 2026 23:09:38 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a1c34fa3esm3329099a91.4.2026.03.12.23.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 23:09:37 -0700 (PDT)
Date: Fri, 13 Mar 2026 11:39:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-gpio@vger.kernel.org, 
	"Enrico Weigelt, metux IT consult" <info@metux.net>, Viresh Kumar <vireshk@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:VIRTIO GPIO DRIVER" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv3] gpio: virtio: remove one kcalloc
Message-ID: <7jwgbrijeldghk44tdg2be5q7o7vuj5np3nlbl2pxuln6c7ll7@ntuquxxdnfmm>
References: <20260312193717.12221-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312193717.12221-1-rosenp@gmail.com>

On 12-03-26, 12:37, Rosen Penev wrote:
> A flexible array member can be used to combine allocations.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  v3: add counting field for __counted_by.
>  v2: add space in struct
>  drivers/gpio/gpio-virtio.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> index ed6e0e90fa8a..57d0eb532c3c 100644
> --- a/drivers/gpio/gpio-virtio.c
> +++ b/drivers/gpio/gpio-virtio.c
> @@ -52,7 +52,6 @@ struct virtio_gpio {
>  	struct virtio_device *vdev;
>  	struct mutex lock; /* Protects virtqueue operation */
>  	struct gpio_chip gc;
> -	struct virtio_gpio_line *lines;
>  	struct virtqueue *request_vq;
> 
>  	/* irq support */
> @@ -60,6 +59,9 @@ struct virtio_gpio {
>  	struct mutex irq_lock; /* Protects irq operation */
>  	raw_spinlock_t eventq_lock; /* Protects queuing of the buffer */
>  	struct vgpio_irq_line *irq_lines;
> +
> +	u16 ngpio;
> +	struct virtio_gpio_line lines[] __counted_by(ngpio);
>  };

I wonder if it is worth it anymore. Why combining allocations is better when we
are ending up using more memory ?

-- 
viresh
