Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910652989B5
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jun 2026 15:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228735; cv=none; b=Qi94UeXKAqoTICB7lWyyl3OoQU6lVBS+SOk8TBEMB08qOOYeT3dS9VZZqLx9h7+ysZ53WVMH/XqZh4nd2WB3+DO0MiOcuAjomWitJUfGUB36W0LX+NGEhWj34gT7z/YAkEfxVKJHLwEg/rYCC2qxtAmx/kl44Ho21fhgRSwiy6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228735; c=relaxed/simple;
	bh=5XQn0m/3gLi9moDpRLDBV/PwAY+GgnG88rPcDckEboU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pruyNGyad5v1CQd+ZYYwYnrQI0jhnqNI2vAOWiPrkv0/UfD7FCwuyxuOC4QjF/J6ht3kzNTshUYGP6Vzw/zGhVdbhADg7mJE0Y4CtbSllFQPQ0Try4NTP2SfZVL74aafs2/4GuMtggtlpu/QN1YZxeReHz/yDYxcszg4/PO1PF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3yeJ9Rb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3yeJ9Rb"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49258ac7294so234625e9.0
        for <linux-hardening@vger.kernel.org>; Tue, 23 Jun 2026 08:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782228732; x=1782833532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+53L7UNPV2jK/LZnIdPZ946XAJTC8u0G7Peoj+okLE=;
        b=Q3yeJ9RbJm2PZ6xtChd7MXOgwwPUYjUwrkAzOAc+j9clXtDbwwdmBYrbvrMTBoxmjE
         1BgYFbxd79WIceuQa8trw1Kaa/RJVTr5YNAnNMHt8ajHGEwX5HcZV9IQiMAi1B/e1ahL
         rnOJ6WqmpU6hghDUOHaSZu1I1FcptM/1OVFB+QJ65Mgy6yU/e4Ivyb+h2Ct5MuggEjuU
         /9UvBh5srLMMLlH/cTXkMlCHX+lPadT+bF33Kyv7FdFihRLjYGHqBufdrPsCeEcj6LmO
         bvzloG0Pc1eY/besf4kME3lp2xlrweq/qyomiibD7j06E38H4HMMr8A8SMaUZGXFTI7S
         9yQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782228732; x=1782833532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0+53L7UNPV2jK/LZnIdPZ946XAJTC8u0G7Peoj+okLE=;
        b=nWy0YcMP8yOF7j0tVtza0sxzsgSAO+nGbh7gNSWgJxFQBhZ7sb3gAkQoym5nhBUDgG
         GKH4gI9+hVJGjuoH726DMygQQmQv7DTwWmcSbY4zi8ENWXMArtAJaT75M7FjqYpwxv3L
         J/+UHigaEfgZlhip93YrmDDRMu6h0Y1FGXkOhc9+9DvdPhkQSA0iUx6hUAG+sycClI61
         Tx0hF2I/LOkXnvnWV9wTxInAn11xt7rBKUv5cg4gzZKMpgZnpFUq2z/Eq2gzHjVZhV+W
         HyIgQVISfkMsHcwlpnBD34HjKwcFSC7dAO9CtcePbGTCvfI2R57lbKOjqlHjEIgYVWhl
         2zOQ==
X-Forwarded-Encrypted: i=1; AFNElJ/5nfUxNt8BpEZMxMAFaDFHBSg3/bIpizP8maDyhh2UuIvEECR2R8my62VTr7TdnbjUaw7VWvtw0NPF1Pectzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBu288WOqPTX3K/gzKfbOrR+O7C9318axVZnSaes6+tpSwW8Da
	xnfU2oGxa7jLglZUqfq95Di94Cwd9mHxcdneJsOr7lu4PQmMbCdAUB49
X-Gm-Gg: AfdE7cnY1Jry+TmW8kFTJ/+dgoLmE4CHJwQI4rvFBmXksWq+1OZE38WUNdownmTV0ZP
	Vj6ciTGE4K1DfaCMwwb6yt40e9zkbf7AIszejLsamVtNRgkRDc/vst/OQ3qSc4H1CtHsIxmKjEo
	Vb9PtQW1D8guwrPow9PSHvP+4JIobhnp6lfJqsR6TxKVAovhzTrGm6Wzhm75LEbQZQyV4jjCNGT
	P3wApmxhML35RZjpv9eCAOIB2i49mDTiTE7YzvrK3m4msD7QXYLV9DgglvabwCusa6Zopia+Ql9
	W4MBR1pVCBE4KbNrFvEU3HMLPhRKiJBXJGq69WuOiebCfkb/u4aPMJRvruSkXWe0lXB8YFZHtSF
	ZFHBt9b4EPPy1JMYn4Jlr0IWMzdBauDZngncIoUxAfJ4o8mhD4329qVqJ0+PQgh9QsU6m7cIJbt
	Tfw4pCcE6WDGkJ0V1ROC8lBJcA9wa2P1kx0xIoVJcerI1xsgFgZg==
X-Received: by 2002:a05:600c:3baa:b0:492:42e1:1b6a with SMTP id 5b1f17b1804b1-49242e11d31mr310507785e9.25.1782228731641;
        Tue, 23 Jun 2026 08:32:11 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49249207dabsm537984865e9.0.2026.06.23.08.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 08:32:11 -0700 (PDT)
Date: Tue, 23 Jun 2026 16:32:03 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Kees Cook <kees@kernel.org>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>
Subject: Re: [PATCH v1 1/2] overflow: Allow to sum a few arguments at once
Message-ID: <20260623163203.195416b4@pumpkin>
In-Reply-To: <ajqTpJAMFFV3H5Im@ashevche-desk.local>
References: <20260617112250.2791461-1-andriy.shevchenko@linux.intel.com>
	<20260617112250.2791461-2-andriy.shevchenko@linux.intel.com>
	<202606182046.AE5F6A241@keescook>
	<ajTlfuOFHXlA7xdu@ashevche-desk.local>
	<202606192025.CF68F2E@keescook>
	<ajY5hg0f34C-iV3R@ashevche-desk.local>
	<54974e4298efd26a52c9c0e9ada88d57e8695a09.camel@sipsolutions.net>
	<ajqTpJAMFFV3H5Im@ashevche-desk.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 17:09:40 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Jun 22, 2026 at 01:16:29PM +0200, Johannes Berg wrote:
> > On Sat, 2026-06-20 at 09:56 +0300, Andy Shevchenko wrote:  
> > > Johannes, are you okay to take a new version (I assume the wish is to have
> > > the balanced additions)? If so, I will prepare one.  
> > 
> > Sure, I can take the patches, sounds good to me.  
> 
> Will send soon, for the record the *.i file is 61 character less with the patch.
> 
> Was
> 
> size = __builtin_choose_expr((sizeof(int) == sizeof(*(8 ? ((void *)((long)(n_channels) * 0l)) : (int *)8))), sizeof(*(request)) + __builtin_choose_expr((sizeof(int) == sizeof(*(8 ? ((void *)((long)(n_channels) * 0l)) : (int *)8))), (n_channels) * sizeof(*(request)->channels) + ((int)sizeof(struct {_Static_assert(!(!(!__builtin_types_compatible_p(typeof(((request)->channels)), typeof(&((request)->channels)[0])))), "must be array");})), size_mul(n_channels, sizeof(*(request)->channels) + ((int)sizeof(struct {_Static_assert(!(!(!__builtin_types_compatible_p(typeof(((request)->channels)), typeof(&((request)->channels)[0])))), "must be array");})))), __size_add(sizeof(*(request)), __builtin_choose_expr((sizeof(int) == sizeof(*(8 ? ((void *)((long)(n_channels) * 0l)) : (int *)8))), (n_channels) * sizeof(*(request)->channels) + ((int)sizeof(struct {_Static_assert(!(!(!__builtin_types_compatible_p(typeof(((request)->channels)), typeof(&((request)->channels)[0])))), "must be array");})), size_mul(n_channels, sizeof(*(request)->channels) + ((int)sizeof(struct {_Static_assert(!(!(!__builtin_types_compatible_p(typeof(((request)->channels)), typeof(&((request)->channels)[0])))), "must be array");}))))));
> - size = __size_add(size, size_mul(sizeof(*request->ssids), n_ssids));
> - size = __size_add(size, size_mul(sizeof(*request->match_sets), n_match_sets));
> - size = __size_add(size, size_mul(sizeof(*request->scan_plans), n_plans));
> - size = __size_add(size, ie_len);
> 
> Now
> 
> size = __size_add(__size_add(__size_add(__builtin_choose_expr((sizeof(int) == sizeof(*(8 ? ((void *)((long)(n_channels) * 0l)) : (int *)8))), sizeof(*(request)) + __builtin_choose_expr((sizeof(int) == sizeof(*(8 ? ((void *)((long)(n_channels) * 0l)) : (int *)8))), (n_channels) * sizeof(*(request)->channels) + ((int)sizeof(struct {_Static_assert(!(!(!__builtin_types_compatible_p(typeof(((request)->channels)), typeof(&((request)->channels)[0])))), "must be array");})), size_mul(n_channels, sizeof(*(request)->channels) + ((int)sizeof(struct {_Static_assert(!(!(!__builtin_types_compatible_p(typeof(((request)->channels)), typeof(&((request)->channels)[0])))), "must be array");})))), __size_add(sizeof(*(request)), __builtin_choose_expr((sizeof(int) == sizeof(*(8 ? ((void *)((long)(n_channels) * 0l)) : (int *)8))), (n_channels) * sizeof(*(request)->channels) + ((int)sizeof(struct {_Static_assert(!(!(!__builtin_types_compatible_p(typeof(((request)->channels)), typeof(&((request)->channels)[0])))), "must be array");})), size_mul(n_channels, sizeof(*(request)->channels) + ((int)sizeof(struct {_Static_assert(!(!(!__builtin_types_compatible_p(typeof(((request)->channels)), typeof(&((request)->channels)[0])))), "must be array");})))))), ie_len), size_mul(sizeof(*request->ssids), n_ssids)), __size_add(size_mul(sizeof(*request->match_sets), n_match_sets), size_mul(sizeof(*request->scan_plans), n_plans)));
> 

Both those seem to contain multiple expansions of is_constexpr().
I'd be surprised if __builtin_constant_p() wasn't good enough.

I also wonder what kind of mess the object code looks like.

I'd also worry whether the saturating maths in any way performs the correct check.
I suspect the (non-saturated) value gets used for a kmalloc(),
but that has much smaller valid (and sane) limits than can come out of the above.

	David

