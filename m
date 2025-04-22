Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872CA1E832A
	for <linux-hardening@vger.kernel.org>; Tue, 22 Apr 2025 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745318293; cv=none; b=MoffolHQBce6vABN/E3azedFQOTOloo+gO9IqF+y5mQGTxhD9MKf1RuOBW4cfr3drzn32K+pK9CeGxFx7W4VJosQ+IWDYJ50nJuYEtpf7cJN1IA9IfqRxItiIpD+LJojcoEcniLiK9UNNm8wOo3Ix12mDkwg6SNND+TPHKDMpnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745318293; c=relaxed/simple;
	bh=Z6c8uzRwUL9CRemIiGxumCOt8oUxWa50U/RnhdvAm6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUZixHolmUViYOGfaXYBm+zawNWmw1kyx7H8bTOcj6m1oBYTuZbh5L+8HowRmCq64597HihWF0CyDEko+YAzZftQvku2kshMSRsMBb3gXtkUfs9xfl5vEjiidDDjP/hBh86JG8EEKnh7J3o0QSbHO8ksz1AM904pF/44AXFLVeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UYuN729t; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UYuN729t"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39ac9aea656so6265581f8f.3
        for <linux-hardening@vger.kernel.org>; Tue, 22 Apr 2025 03:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745318290; x=1745923090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x36ME9YCkgctStKKRl+yxhgMtdLAC+ajKdEDhmCB47Q=;
        b=UYuN729tFlE1b8gcMDPRHDaj6XCStLAeknCXmSw9t2PY2JATnzPR7wgDb/lcx05szA
         gEKhuB/Utg3QLnUrAFNc12rxX40Rk0Peqkn/aButFChd8H27MmOifIWb5OMcX4WbkvyL
         I9VGZyUiVOJM/Vn60QAfhEensSwrU9yF5EGBi3I2b6n8/PcbMDjE+wCboRG07VB2edIW
         1P8NgpH4UolZBqshO8zke2RMZeL8MWDKWQakg19FJjCO9RWl1KcIu2qL8mqIL0aRu20Q
         IbyWkwu5Bk1JSZXwDMyFeLnOONPmFd7D8LoTFGxt1cYaEQAOp3eHQzzmPj4+BfGr1qKP
         U7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745318290; x=1745923090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x36ME9YCkgctStKKRl+yxhgMtdLAC+ajKdEDhmCB47Q=;
        b=pj4f2wHlgouQ7txYTbCcfVFoU4HG9aib4zRMXT3wsljR+nYYhfFypWgcr/KiDXc26W
         VVNy0shGkFDwla0VZ60LkRicgYtRJWO+G/HEnkXJTnbuyU5aPBwukjVS8MybfQe+rKZA
         TmtM1ji8kMw6JamrT5r52XoAIoXPwS07DBz8qymoF5J2RELID544/dRhYL88apiwoUsG
         8tNOBIxPYO1VduMD0QQSL+Nq8QDeQYWvD88OGwEAwGlyaR3r9MpJCA0yp+xT+4b0UspY
         k2u8/xqfVR5sjAPDbOApQzEPnPBTkbBn+pg4KGj1cY08ohutVYBd7+F3J2yH8YV5gxgr
         07vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfT42XTS5FFtdTMNn/I41L4k9cfiIVv3sYoSjUYnyOSnFBTBWJiC7Wh97w6O/awawwCH/MhEvEcVdsOLOnguA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3tjxNflDYJco4Wd02LkOlSm2IIxrRYW87IrP+066uZfLLe4j1
	OpaQTVskccOH1rs+C4MnzZOOPx3h6wjjntH4cAXXGwlRkfWpmbHGqatEGZvXW44=
X-Gm-Gg: ASbGncuFQyDhB9jI9uW/Bz9M+GA9FpwgSVM/C9hTYeZnL0SfBkpx8chY0rDAOPxeuCV
	dJeIve44cqP4DezXylLzASvhFlfGKrl9MokNYyXJ8vz/RPVVbuxbr8xNNOVoF352j78aY+rd/zc
	y/0pTslrCs1ONbAAQcq3pa0IOzAfymbbHImZioLWuPUX9mbxAG+1rr2T4G+Vb4blrglKLlC6umW
	4KHgcALV3DADrI6EqKbUjFQyc/g85EPiGEYS30El4s6X+M2fYiBdjGVygZG53bpDyTKThKJwZcS
	ELohoBFgwrXo/Dd7KtrBp4yw5h/OoxTjj8wVYbMzvzZ3WQ==
X-Google-Smtp-Source: AGHT+IHmdZrRl8dVYpwJVQVgKnWXt370mTD794FHi8G5zh54eb5aEDf4XYuBmeYKL/FdPLvQGd7cdw==
X-Received: by 2002:a5d:64a5:0:b0:391:4914:3c6a with SMTP id ffacd0b85a97d-39efba5c644mr10470205f8f.29.1745318289843;
        Tue, 22 Apr 2025 03:38:09 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39efa421c79sm14615464f8f.1.2025.04.22.03.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 03:38:09 -0700 (PDT)
Date: Tue, 22 Apr 2025 13:38:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>
Cc: sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mm/damon/sysfs-schemes: using kmalloc_array() and
 size_add()
Message-ID: <2713f419-760b-4ccc-aeed-de9c4c899506@stanley.mountain>
References: <20250421062423.740605-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421062423.740605-1-suhui@nfschina.com>

On Mon, Apr 21, 2025 at 02:24:24PM +0800, Su Hui wrote:
> It's safer to using kmalloc_array() and size_add() because it can
> prevent possible overflow problem.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  mm/damon/sysfs-schemes.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 23b562df0839..79220aba436f 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -465,7 +465,8 @@ static ssize_t memcg_path_store(struct kobject *kobj,
>  {
>  	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
>  			struct damon_sysfs_scheme_filter, kobj);
> -	char *path = kmalloc(sizeof(*path) * (count + 1), GFP_KERNEL);
> +	char *path = kmalloc_array(size_add(count, 1), sizeof(*path),
> +				   GFP_KERNEL);

Count is clamped in rw_verify_area().

Smatch does a kind of ugly hack to handle rw_verify_area() which is that
it says neither the count nor the pos can be more than 1G.  And obviously
files which are larger than 2GB exist but pretending they don't silences
all these integer overflow warnings.

>  
>  	if (!path)
>  		return -ENOMEM;
> @@ -2035,7 +2036,7 @@ static int damon_sysfs_memcg_path_to_id(char *memcg_path, unsigned short *id)
>  	if (!memcg_path)
>  		return -EINVAL;
>  
> -	path = kmalloc(sizeof(*path) * PATH_MAX, GFP_KERNEL);
> +	path = kmalloc_array(PATH_MAX, sizeof(*path), GFP_KERNEL);

If we boost PATH_MAX to that high then we're going to run into
all sorts of other issues first.

regards,
dan carpenter

