Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5B213CA8A
	for <linux-hardening@vger.kernel.org>; Wed, 24 Apr 2024 23:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714002076; cv=none; b=PoC3TaYtqxLe7Sh5wrz2jmazd3Hwu4oL4GQMqA1bp6cND36AJ2fhqzlUtu/hqc49r1dIHoFtnm/+RPkhYehxJZQIFLZh9EEot9+uqV/wlXwtX5gZIdERqP7SenHV70Ygie//fmfXrRuUKA9B7KcW0NL6Nj238O1rFLLdEFErGBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714002076; c=relaxed/simple;
	bh=6/nCZHN2ot48niRYtILsWxW3A5Rhs7kQzyWs5jyek1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhveRFwiJtMBVjcfzGIETiM2afod0xDD4XN5o0iFTh7Y+PdavB1PobPmt9VpOGwKOLXNwXR6k5PHYvEJDSQuZizG4gl8Rs4WcMGh22rFcTKYrS5A219kK9DuDfi0DB4L8/zTKiY0ZUa5ggdQGMuMv6s8O7MBDcpU3cbVPTplrOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QnY8CZJh; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QnY8CZJh"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e65a1370b7so3774035ad.3
        for <linux-hardening@vger.kernel.org>; Wed, 24 Apr 2024 16:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714002074; x=1714606874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EoToNmnIGQ/tl3VHTK0FT9JY72AxGKijH26JKi5+fVQ=;
        b=QnY8CZJhTsPFSi4w4PkrRWtrY1WmkKbA8QV/LCygPM8cq72JVRsp/LY1JMt9sP/7F2
         jAWYr781FitO9fYKdWKDoGf+CxTtc2Y3vE6AfcR4BkuyCucigVIPd5c/t0K9+Qrss6EH
         UX4MWVzui3Kq07TwzMy11bPT5NtYa7k2yZxRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714002074; x=1714606874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoToNmnIGQ/tl3VHTK0FT9JY72AxGKijH26JKi5+fVQ=;
        b=Uufcez5O3X3Ru68HGY3Rd4DOUEIeeFVeSGhPdhLkiYSSlekESTKi65pGNZ0F+Y9T2S
         nCal93qN0OcW9aOHDhv+nMwdLG+z8wP6bmYWVr2opT/qLAyPLaVaXpOTnRtMaLKUSNHJ
         qmbEiWww33MmMdoCXOt9ym7p6S8rJC0v/o2hQ0/EhrJBF7xkdMCcF86yq0hsgXMQRYbo
         mYVKil4ykB6hf+aDnTqMWukgJeoGc0+Iniq0DtlGzv+HHPXazP24xPiwuEVugr+szqvh
         t9CjaNYrryWKfKumj3m13mUmDzu7yRDM8BDz0CujxPE9GxCebCtn2WcIF4w155jvctEJ
         qZGw==
X-Forwarded-Encrypted: i=1; AJvYcCU7WpD0S5ODT9gZe+wrIEqPQRIUhSIgXakSodCXywKUpzsTZiVWuIUXsSIt5UX1pL5y9VH3d9S7a3uKzGNW3NvfCfpR5u/JcuWJk/PnxQes
X-Gm-Message-State: AOJu0YziByXwYZa/4X+I6tjK7UmKvBRfqdLf8G2S4PaxBnghF5CZRR8D
	Kkvk/lweLZW3yVMynpCcas6dxBYjmOSmUqYM/Q2KWUP/NQkOQ/1ubaYdrHzpQw==
X-Google-Smtp-Source: AGHT+IEKgCjBpENw0+PWDNYZyL454MuCp/jPYNsO+pEjvBJa9o+e+CAFfi7+1nI4ZhFCYvLI+RA//w==
X-Received: by 2002:a17:903:2302:b0:1e3:d0fd:236c with SMTP id d2-20020a170903230200b001e3d0fd236cmr5913125plh.37.1714002074531;
        Wed, 24 Apr 2024 16:41:14 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p23-20020a1709027ed700b001d8f111804asm12691608plb.113.2024.04.24.16.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 16:41:14 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:41:13 -0700
From: Kees Cook <keescook@chromium.org>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: tony.luck@intel.com, gpiccoli@igalia.com,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com,
	Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH] pstore/ram: Replace of_node_put with __free() for
 automatic cleanup
Message-ID: <202404241639.3F455ECCD@keescook>
References: <20240415161409.8375-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415161409.8375-1-jain.abhinav177@gmail.com>

On Mon, Apr 15, 2024 at 04:14:09PM +0000, Abhinav Jain wrote:
> Add __free(device_node) to the parent_node struct declaration.
> Move declaration to initialization for ensuring scope sanity.
> Remove of_node_put from parent_node struct.
> 
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
> ---
>  fs/pstore/ram.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index b1a455f42e93..14f2f4864e48 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -644,7 +644,6 @@ static int ramoops_parse_dt(struct platform_device *pdev,
>  			    struct ramoops_platform_data *pdata)
>  {
>  	struct device_node *of_node = pdev->dev.of_node;
> -	struct device_node *parent_node;
>  	struct resource *res;
>  	u32 value;
>  	int ret;
> @@ -704,14 +703,13 @@ static int ramoops_parse_dt(struct platform_device *pdev,
>  	 * we're not a child of "reserved-memory" and mimicking the
>  	 * expected behavior.
>  	 */
> -	parent_node = of_get_parent(of_node);
> +	struct device_node *parent_node __free(device_node) = of_node_parent(of_node);

Please don't move variable definitions into the middle of the function
body. :)

>  	if (!of_node_name_eq(parent_node, "reserved-memory") &&
>  	    !pdata->console_size && !pdata->ftrace_size &&
>  	    !pdata->pmsg_size && !pdata->ecc_info.ecc_size) {
>  		pdata->console_size = pdata->record_size;
>  		pdata->pmsg_size = pdata->record_size;
>  	}
> -	of_node_put(parent_node);

So this change is functionally fine, but there's really no good reason
to do this -- there is no fancy error handling here, so there's no
benefit to making this change. It doesn't really help readability.

-Kees

>  
>  	return 0;
>  }
> -- 
> 2.34.1
> 

-- 
Kees Cook
