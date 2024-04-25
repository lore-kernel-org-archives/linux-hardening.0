Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4500614D718
	for <linux-hardening@vger.kernel.org>; Thu, 25 Apr 2024 17:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065325; cv=none; b=juE61y8/XHbNgbssWlw4nKpJ7u9sv0nGkAc8IwQpRGcbJnc2SvLNGuUKVT7x1dkLnqN1a6AkFYudRvQNyEW/rQVXjcV94NT7Qo9B2cwyTfxv76UP0+2G5F8/PfC3e/EkAzQUZyz1IQCFOq4SR2jnOOXDluZx00SajK0AKdDNKD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065325; c=relaxed/simple;
	bh=keQGh11L4ASmhAbfLJCprZcvvRwnGddM3OJi+dbRQ/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYVrEJ4w9ss4snnSZETaq0RNJsweRpER32znle3rL8aLZAdIXJeL7ebSL8b7IlZc+Ft4OUKHUoC+aYlKATBALeuOZYvQeA6cid2gF/VvgDSiHiiyiC75UT558SPNRDFIYicsZm4F2aElzOBm93m9yzCkdKMdC1x4eiTVVN/Baww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KknbITIv; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KknbITIv"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed20fb620fso1140563b3a.2
        for <linux-hardening@vger.kernel.org>; Thu, 25 Apr 2024 10:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714065323; x=1714670123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u1JLCe9OgKQpwj7dtaGJUIZ9L7mQbrj8lQtYz3ctHGE=;
        b=KknbITIvBuVa4J9uv5RbfuoaHwuFvKKM6zIvQO2qP7DSLbzuuaF0nj0ncvdbKlTXBr
         HKPnTxdWzG7u4pjvaCs6a2lHgz3vw9jm4npLq9MMEd8HO1nzbOeYDUhrpZExy9vNWpYr
         QgMebaw3bE3FcuRW2hdO4Nae9B2CICNzxFlGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714065323; x=1714670123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1JLCe9OgKQpwj7dtaGJUIZ9L7mQbrj8lQtYz3ctHGE=;
        b=J8NbLKDV/gefT6jAmV66hclPZnYlfK0mQjDZupL0d67Y0Jv5jRBig04BB8W3/W8CUI
         YlLOGkThI1h4hHxy9RMIjgDjuQ2mxXKkHYAzVVGsXMsoB+pccrjMzWJiOnuXAhm0YF8j
         XpsJQJZ2nFbGkra5Wzvd4cuvigegIKSXPaj9wvoyf0LBaZGir0NCW19pSdLrHQRXfj1h
         P1Q0aZCeTtFJfLt88vxzy7EuG0TL4obAw6hJy1mp+5Pi9kC2MPGRm+cgf8I3G8S4DaMu
         6m2smT1m+aKOuxW5beVFJlF9zr5LzVR70G2D54gYVolkOuHD2QgPakAsjo8YRpH0gXk6
         siSg==
X-Forwarded-Encrypted: i=1; AJvYcCUdZDgEEQ5fBtG/UtSHRMu9hefXMsv0CHcvjU0J5zQ7UTEg3t0OPj0JYCTa/12HriF1ewbkmovK7PJL1m0MGNOuqrzKXVc0VVuZhFd1h+VO
X-Gm-Message-State: AOJu0YwvnFgy+7l3e3viAsSzFer3DWKsSnRiClKtz1bKmMDcgNP0nmEv
	FscR/HyhZkXPTs4qExikUMK7BDI8FkkilG1qgOZ8MhOoSHIMfbZipTLtrlTetQ==
X-Google-Smtp-Source: AGHT+IHdAL2pUCcpe/Rwp2MmAw3VaSPub4F1WVpc3ytbvH+LpXMd2WcDJZqLoubA0TgHiGRSKS322g==
X-Received: by 2002:a05:6a20:5b12:b0:1a7:aecd:9902 with SMTP id kl18-20020a056a205b1200b001a7aecd9902mr294646pzb.49.1714065323492;
        Thu, 25 Apr 2024 10:15:23 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a7-20020a654187000000b0060013d7c463sm6433305pgq.72.2024.04.25.10.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 10:15:22 -0700 (PDT)
Date: Thu, 25 Apr 2024 10:15:22 -0700
From: Kees Cook <keescook@chromium.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org, patches@lists.linux.dev,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: bcm: dvp: Assign ->num before accessing ->hws
Message-ID: <202404251015.23D4949BCF@keescook>
References: <20240425-cbl-bcm-assign-counted-by-val-before-access-v1-0-e2db3b82d5ef@kernel.org>
 <20240425-cbl-bcm-assign-counted-by-val-before-access-v1-1-e2db3b82d5ef@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425-cbl-bcm-assign-counted-by-val-before-access-v1-1-e2db3b82d5ef@kernel.org>

On Thu, Apr 25, 2024 at 09:55:51AM -0700, Nathan Chancellor wrote:
> Commit f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with
> __counted_by") annotated the hws member of 'struct clk_hw_onecell_data'
> with __counted_by, which informs the bounds sanitizer about the number
> of elements in hws, so that it can warn when hws is accessed out of
> bounds. As noted in that change, the __counted_by member must be
> initialized with the number of elements before the first array access
> happens, otherwise there will be a warning from each access prior to the
> initialization because the number of elements is zero. This occurs in
> clk_dvp_probe() due to ->num being assigned after ->hws has been
> accessed:
> 
>   UBSAN: array-index-out-of-bounds in drivers/clk/bcm/clk-bcm2711-dvp.c:59:2
>   index 0 is out of range for type 'struct clk_hw *[] __counted_by(num)' (aka 'struct clk_hw *[]')
> 
> Move the ->num initialization to before the first access of ->hws, which
> clears up the warning.
> 
> Cc: stable@vger.kernel.org
> Fixes: f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with __counted_by")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for finding this!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
