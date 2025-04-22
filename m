Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F8113B59B
	for <linux-hardening@vger.kernel.org>; Tue, 22 Apr 2025 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745318687; cv=none; b=FDYX0SJRJ+LBBz0vwfjB9DDI9MeowIZAlWBAAbQCh9D+xrZRlO7TQBp9yBNoHoUv+CzvNcgD58B3hLAhp8nh70Bsfoq2wYXXIXo0nmCnubYz69JAoGeaEA+rcR/Qt1g9p+BKktR871A3w8GPhuNrjw4le5E3GpKqjL5mtWpL/Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745318687; c=relaxed/simple;
	bh=jaIK3y9skttjOZKNe7Pdvk/sD+BmWmSRwYZmKO1UDRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4tlijQaXbGkLyjO6JhkQYmUkyET8ZQlpHB1VqlxWp28tZjhXkfuwISi3P1BFv3CDmyConn7eL1m9rh2O3rENv/wCam4CdCQ8FQsIUkrG0cDAADbn/K1IRtxTF0B2Ufu553fd6Xw6zn1kwTG3rmAVWQCDpICCavOVXXczQ3OWHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=arkE2kQy; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="arkE2kQy"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so37001525e9.0
        for <linux-hardening@vger.kernel.org>; Tue, 22 Apr 2025 03:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745318683; x=1745923483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E2ZlSb8C4TopIE9lOnaluqGxSWa7ZTy/niRKFxlJXsg=;
        b=arkE2kQyThHt6WlohJEBhCB+n9V6jgMfdVhAL0onHrxt8jDojvTT72F8LICuqzKnxy
         PrAmNgkUH4RjEQyPcgntght4KJJKzxOGBQTgY6bCDcVSnZndZ0O5kwEpAgY1ufMAcvwi
         iVqFim2NvgAICptpF1nU+WJDPIWHyHPTjK5dQzSeLrZotitKcSc2xsKZtMgmKJp6wMqo
         BtxUZIROgAA+TQAz7q4Tfd7wiRjsTMxhqd6Dfomp/bP3z6Pb8ULex1Es3XfpgzeW8ETi
         pncbEMQFyjRNyjik7akh3J7p2G41smDEAZvIA7JimPSQfSr5cP4O7KcG6xhWulVriLH6
         vyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745318683; x=1745923483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2ZlSb8C4TopIE9lOnaluqGxSWa7ZTy/niRKFxlJXsg=;
        b=d2i91rXx/POtqRrnH9wP45GAchbVvbw2ibNhQlmP3ZTnTRMpZnIquephdmq1PC35Dt
         PfixwbiyRfFb0n0ggJKQcMt+R7tZ5l4G87jZOEx5/hN1iu5YjuXkdMqAX6cXZbmPcsOs
         r8M+YKpf3dHJcumcLtW1/GRrgUqjdQVK2DqQU19SisRj1m+okGrY69IjbYBQourshNe2
         JxktML4VSNSyrcW/ZOguGn1Wm/nE/9L8tB7P+8rZtHZhgRFsatvIJlsufvxMKLtlgjYJ
         Dt8vfLmdGBOWjABvAJGvUdOR9oadkEYlHyygYYAC9NyByYALdWdXN65zTyhZ76cOg2LW
         fa/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQf67axHCZTaU5UzgvzVq+l4PSJhhAqiMDPfov6TyqosSAyqJ3oixItZQkYNbF2+emyD2TJAU0Ykg551G2KWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfxt9+dvgeR1izWdO9UpBEzqyJKVj+a2msb9t9+5hgG8JdBu6S
	YOlhKM0s450ew979cv3hpjJyJus9zM/C5VcZE+eaA4oM+lM70UUyANzhsbvIkE8=
X-Gm-Gg: ASbGncu77I9oxOSqbp4m7cGgffSSe+dkK50XWJ4PV+EATD90VrL4cI2kSH9lGRntcBq
	QHE1YQtuwcM3sjV8uXlWoCxL77inKH74bEDWRaSdQJbhHo6ErmNkDhEKanO6cuiGpHQj/pw/67m
	1LWHQnZd9H4kQag/Ey2ChPQowg9SiN10acpiXB09POQ6hYGD7e36ZRWV87ueFm3BFBV8aU8YDEy
	IJMIFW9QDJQ/172senK7Tvs+oPYF/dPzo0rvmYHzkse5BLduIBV30JsjQqCi4mhDvha3l07HNAc
	2NIe6IiSBusVr+cJYtUXB87Euzhd7IQHw0Jy89lPs3VTEEMsV3Xu2yn4
X-Google-Smtp-Source: AGHT+IGmQB87kk25ssevPLdZ7b8PjzlRTbK4qnCrbpA2fIVwAWfGo22Ft+WhXErpVr6BVQJ+4nZjZg==
X-Received: by 2002:a05:600c:5395:b0:43d:db5:7b1a with SMTP id 5b1f17b1804b1-4406ab96f63mr141741765e9.12.1745318683311;
        Tue, 22 Apr 2025 03:44:43 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4406d5d712esm166577665e9.36.2025.04.22.03.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 03:44:42 -0700 (PDT)
Date: Tue, 22 Apr 2025 13:44:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>
Cc: sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mm/damon/sysfs-schemes: using kmalloc_array() and
 size_add()
Message-ID: <adbc06d8-1a6c-4279-9596-d743505d64dd@stanley.mountain>
References: <20250421062423.740605-1-suhui@nfschina.com>
 <2713f419-760b-4ccc-aeed-de9c4c899506@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2713f419-760b-4ccc-aeed-de9c4c899506@stanley.mountain>

On Tue, Apr 22, 2025 at 01:38:05PM +0300, Dan Carpenter wrote:
> On Mon, Apr 21, 2025 at 02:24:24PM +0800, Su Hui wrote:
> > It's safer to using kmalloc_array() and size_add() because it can
> > prevent possible overflow problem.
> > 
> > Signed-off-by: Su Hui <suhui@nfschina.com>
> > ---
> >  mm/damon/sysfs-schemes.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 23b562df0839..79220aba436f 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> > @@ -465,7 +465,8 @@ static ssize_t memcg_path_store(struct kobject *kobj,
> >  {
> >  	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
> >  			struct damon_sysfs_scheme_filter, kobj);
> > -	char *path = kmalloc(sizeof(*path) * (count + 1), GFP_KERNEL);
> > +	char *path = kmalloc_array(size_add(count, 1), sizeof(*path),
> > +				   GFP_KERNEL);
> 
> Count is clamped in rw_verify_area().
> 
> Smatch does a kind of ugly hack to handle rw_verify_area() which is that
> it says neither the count nor the pos can be more than 1G.  And obviously
> files which are larger than 2GB exist but pretending they don't silences
> all these integer overflow warnings.
> 

Actually rw_verify_area() ensures that "pos + count" can't overflow.  But
here we are multiplying.  Fortunately, we are multiplying by 1 so that's
safe and also count can't be larger than PAGE_SIZE here which is safe as
well.

regards,
dan carpenter

