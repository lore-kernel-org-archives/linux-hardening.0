Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458361078B
	for <linux-hardening@vger.kernel.org>; Sat,  3 Feb 2024 04:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706936223; cv=none; b=UtjcRg046U+lk5FcxYFqJT4diLszajjUvd7Hvp0flou0C2eUE+lGv0oDNQWsRXLwHvL/+sXaCE8mOsyxl1Gw70/OEfueeYQLQV72TWP5+2pbUDCgboCbv90iLF2tbTUw9tz58LXni7/gtaHsTTXQmsEzDUx56brCzOi3p5cC7R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706936223; c=relaxed/simple;
	bh=wKy8pJGaRQ54CuzSdhu8+xkT6SOYTsPwXkeIF/nYQD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3cwoF8AxeNH9b1/xdQiUQxln/LJDEzAwYCpjvA/qny1WbIfgk1QNduSoN1f/uBErxeLdKeRoAkURA5hSz5VGamrCo91rXEXrHcWfNEy8UpiqJTc7dx2xeFflKkHqehsjn5cf5mXW0uBXjbul50ffe6WReA3YWXc/r10/5qaU5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DM58zrJ/; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DM58zrJ/"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-59a8ee08c23so1192216eaf.2
        for <linux-hardening@vger.kernel.org>; Fri, 02 Feb 2024 20:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706936220; x=1707541020; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Js2QfXs3Kv3aTrQZDgjZoyjW7ifVdIqfUU+Z5Gf8Jr0=;
        b=DM58zrJ/ae/LmnsnDY+/pEK6fRzCBJ270Mx6vZmm/76YOp9zL9sloDSYn3C4oMcHcP
         1lKqB2Wbvo5/q2Bhzin3JnzIMKZsU8dDp8zvnJDfhyENLzg9bthZJYuV3nCrXrmM67UM
         bLLi+nnBPZlwAfvi8tBRsw/c1Osxx8kP2ancyl+SsDUe92+SXoAj3LcVgCBEtlOMAH43
         7QJtNboXhMLWm1ZHwyWpLipFkmC/ph8JI2qkQ+XXmXtGfEMpRsdZQMEGexWkrbAstheV
         C0uHLGfFTK13+YxMH8UWvz8r0VfIyVSw43Uqgu/IkIxNADHux/blK3wSkJba9qH9KL0I
         MQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706936220; x=1707541020;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Js2QfXs3Kv3aTrQZDgjZoyjW7ifVdIqfUU+Z5Gf8Jr0=;
        b=iuKpGfri8ptfi+3RDCMH3rjgJCdj1Z2NNb1/jOsbn+qwAr4KPapj25rtSTw/wm7076
         GemLtVJUWrocjHqBmi5cgvx5pnc1c/+rpkAbfvaTt3lCkoLZHx+x6z6wsGWmpTsdWrkm
         aFtJj9xh67WFs+JjZkX3Q4k2+LguXCA6SvTe7do9Wcn5GI0L9i5dk7sBT5p97nB05Xc4
         UuFwYz5lYMahpYOxOrgZvYNhXeLar9MQ3EOu7ZkW5sJwQlyQP3ixPFrjy5vlNNIfxPPA
         Ev2ATgO3OnWpqzdf/TJCxsibkDcnjX7RD+ZeKslH7D7owFzcmNcxVDBTuZO0YpBIqeNA
         F3qA==
X-Gm-Message-State: AOJu0Yy0kD/8+pAKGsVf7YlDLl5qhLbwggediqkKrV5MWPubq2rtApQ4
	T/DYB+0j1uWHx/XTIA3Wk6ziV38oaVMPq5G34lMjqEQ6MfE7n+yf44X+OsEbEQ==
X-Google-Smtp-Source: AGHT+IGOgmxZ3CB6VB34fKCm/ENjp6io0zJyn4+7PxlwjeLGiYmNeh5ehDZqnV1Yxl+sjPgzEbquAg==
X-Received: by 2002:a05:6358:3a0e:b0:176:916e:5d97 with SMTP id g14-20020a0563583a0e00b00176916e5d97mr9279249rwe.32.1706936219967;
        Fri, 02 Feb 2024 20:56:59 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVF4BmuxQQtX2Z3E/9s1868PC597dydjDbX0qy52eMb3OihcGrpzTKaXf1yyTwQ/q76pQGBRr7jxWpToOrYMr2VjBUQ6ldXWVD2baTsTMwQCjZjCU6CaU0I4KHpQvJcEBTwbR2OSV34Mv1uu1iWHDLWP6PaYWuA4KcBnGRTrdeTCQyTcLCGVGaGp6CjMXZLm0HlJGqxkVPrVTtEQbrQ01muOk/u3++uVfJpMT2wWz8EDAjgNGXx7j79L9B2Y3H0CTsZaN2WcLbFb4TnXBABbatQk4+v5w0cUS0RIoRzHJMban3bI004Sy2Y8Kp1w0domqj4cBTzMMA6+KQtngWNEMDyH7tV6p1+eCw0EQSM
Received: from thinkpad ([117.202.187.138])
        by smtp.gmail.com with ESMTPSA id j31-20020a63595f000000b005cfbe445a85sm2631019pgm.70.2024.02.02.20.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 20:56:59 -0800 (PST)
Date: Sat, 3 Feb 2024 10:26:53 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Erick Archer <erick.archer@gmx.com>
Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dan Carpenter <error27@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Elder <elder@linaro.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] bus: mhi: ep: Use kcalloc() instead of kzalloc()
Message-ID: <20240203045653.GB3038@thinkpad>
References: <20240128112722.4334-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240128112722.4334-1-erick.archer@gmx.com>

On Sun, Jan 28, 2024 at 12:27:22PM +0100, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1].
> 
> Here the multiplication is obviously safe because the "event_rings"
> member never can have a value greater than 255 (8 bits). This member
> is set twice using always FIELD_GET:
> 
> mhi_cntrl->event_rings = FIELD_GET(MHICFG_NER_MASK, regval);
> mhi_cntrl->event_rings = FIELD_GET(MHICFG_NER_MASK, regval);
> 
> And the MHICFG_NER_MASK macro defines the 8 bits mask that guarantees
> a maximum value of 255.
> 
> However, using kcalloc() is more appropriate [1] and improves
> readability. This patch has no effect on runtime behavior.
> 
> Link: https://github.com/KSPP/linux/issues/162 [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Applied to mhi-next!

- Mani

> ---
> Changes in v2:
> - Add more info in the commit message to better explain the change.
>   (Dan Carpenter)
> - Add the "Reviewed-by:" tag.
> 
> Previous versions:
> v1 - https://lore.kernel.org/linux-hardening/20240120152518.13006-1-erick.archer@gmx.com/
> ---
>  drivers/bus/mhi/ep/main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index 65fc1d738bec..8d7a4102bdb7 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -1149,8 +1149,9 @@ int mhi_ep_power_up(struct mhi_ep_cntrl *mhi_cntrl)
>  	mhi_ep_mmio_mask_interrupts(mhi_cntrl);
>  	mhi_ep_mmio_init(mhi_cntrl);
> 
> -	mhi_cntrl->mhi_event = kzalloc(mhi_cntrl->event_rings * (sizeof(*mhi_cntrl->mhi_event)),
> -					GFP_KERNEL);
> +	mhi_cntrl->mhi_event = kcalloc(mhi_cntrl->event_rings,
> +				       sizeof(*mhi_cntrl->mhi_event),
> +				       GFP_KERNEL);
>  	if (!mhi_cntrl->mhi_event)
>  		return -ENOMEM;
> 
> --
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
