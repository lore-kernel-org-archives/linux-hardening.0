Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A9A431E5F
	for <linux-hardening@vger.kernel.org>; Mon, 17 Aug 2026 13:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786973093; cv=none; b=Yv6r3GXA9zBr97vXc50rJcyrQPrqv1Q6zX0i4w6C9YkUcIPawH38mzbZ750WSbuJsZa7AiIdBKEYDsUDC5u0O32v3gY5FbDZ1cwD2bpFGd0juRHnYlsKwMnFKr8X2nJ9xPeqk6iYj3a4hWuUy2bB5kTopkovVI7djvWxEl1dL/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786973093; c=relaxed/simple;
	bh=Hw/jfXcPPMobBLBI8W1VNi7tiStnZDpg9z6Ju3cQlQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIhJsXAGXb7D90tWNjy/CcqNpxS6y1771v7qTzoaGFEq7tqsUrP0gT85l0iDgaOJA2B5c1GmXGUUn+FufMXNX7OOnwppDsaL6Kt2tmyIWPVDF9ehPkDZ1UvLdUqwMUAidV9wJnR42Wce0bAsmNcUlwo5M13LGmaQYR4BMscIIRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Vr+7rqUS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Vr+7rqUS"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4998e0916faso16779995e9.2
        for <linux-hardening@vger.kernel.org>; Mon, 17 Aug 2026 06:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1786973088; x=1787577888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oBxqkvt2QiyULLxw2yg2sHAVvNGWnYOoHvbaWXtRPBA=;
        b=Vr+7rqUSSmJQlcFh13E5PEUcs5NjpEBKr1CbNuCsbKC4C8uXbCU1uU/vxfKju1teOs
         jYGjkaMMapiV2Ag1e3hWftj3u5VTC4qrYkr4XyGS5qQVqK+o1a8GmZ54J9Rc3j8wyOki
         EWWPHSYwh5EWtxEl+k0XVg22Dz+3a8F/8JLASx4ox+loy/THofG/OjeOThDkzr30H6+/
         JVQWJs/noLpZ/sdk8odXwzlkO/cc+VJw04xPYbcMaoUzN5a7fcEfnAFckjfmY701GS/a
         LAB8BoCmE0Q+mgJGQGNCIzbSv16raXt3dmojRPlz/Ky1FYeZ1+0r2lIpJfcbPrM9QAPq
         YNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786973088; x=1787577888;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oBxqkvt2QiyULLxw2yg2sHAVvNGWnYOoHvbaWXtRPBA=;
        b=H7/8X1KQiYce/Jr3aZzAp6Lg26n1Tqe0BMcaapiD1I7jrzsldOBBFXf/6rApSBpnLO
         y1LsXmn2hMCp/qnYk+xPSe2ZRDO7eJKVSb7b7x4VeV2FtbfdJ1vl17UuwpMH+8F644zQ
         CccKpBFoUeHM8cytulaz5P5i79L7Cc8d5bxIsHb6MhSZnpqb6lHlEzhUwb7mGN4pKa98
         wigKZUfJt/RhMI3z0dXNnCoRikl66wZ3ZOJLRmtmc5rSuwRLJYRhwc1pCpSRhy0XzA9d
         WivGAE0Iye4pkoeljPmP/iOOaCow/Z2CXoy0HZ7ZVxZ1XBRsonF9YAsswbFAnQTTwagC
         bkwA==
X-Forwarded-Encrypted: i=1; AHgh+Rpat6ZcSDcdDQGSixKqPIIzOh+oupBTu1x2RsETb4z339JWT8U5fNfqFkrX4RpL898ZcITsMwpfTPsa/F5Kfsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywad4HLKLiomQsxdAsp3no3oNHvffnW5p+sVu+XgUlC43KzHqe7
	qu6vUAfMTBD4DF3CB9GyPYH6LONFIo/fI7qn34MydtSQnuzV4eTNlYRrFxVAUrUfFQ==
X-Gm-Gg: AR+sD11iFVP8LpBvtdlPMTsKo77lOYDrirAUTCKj8fbmZRf/KOp+DCnI3W4NHT5Ugs9
	6KCl5UQGFhEtyF4MLEDFOR5YhiDcVPASVrHA+/gXtlUdbovLlZaFKMHKytxS/BfeddyPzfzJzol
	KZweoieS9/XO8CA9FYyZhoZOFJq9VfON4ESZpIDKrf2j3Zg/djNIv6XsGUU23nIlPXgNUaVnyDp
	nSSBNBvAIIVZaSUp5w+BdcU+sZCJdYuivnA82s66/SPb4Qln7LUz4CYXRWBZhTN524Z5XUX8vWu
	wxLDsVtPXmbJtJnQN96vF29yPTO24lH2MFhgQ7IxE3ZEimhrLnZO7D7ruIrMx9f9LMsfgxItNgD
	19e4Lqg96unqV4+dso5VHHymRgFnjKRbjYbRpDLIdjGds6m+h+rkjCqREqWsmLKzED9Ks9k3nIZ
	Ggo5EMxR4ybL3C44PPt6Mzqmr5jgb0+h7T4If14ZQdxxw/hZNESlw5wnP00GSB2NDD8QJECkA=
X-Received: by 2002:a05:600c:3b1d:b0:499:87b6:f3c0 with SMTP id 5b1f17b1804b1-4998807e4c9mr382618245e9.14.1786973087942;
        Mon, 17 Aug 2026 06:24:47 -0700 (PDT)
Received: from spiro ([141.5.46.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996109652sm188597975e9.4.2026.08.17.06.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 06:24:47 -0700 (PDT)
Date: Mon, 17 Aug 2026 06:24:44 -0700
From: Jennifer Miller <jmill@asu.edu>
To: Kees Cook <kees@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, linux-hardening@vger.kernel.org, xmei5@asu.edu, 
	samitolvanen@google.com, peterz@infradead.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v1 1/1] bpf: Enable JIT hardening by default
 when x86_64 CFI is enabled
Message-ID: <aoL_G-3chdLZGxSJ@spiro>
References: <20260710191932.120911-1-jmill@asu.edu>
 <20260710191932.120911-2-jmill@asu.edu>
 <202608091030.C69278022@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202608091030.C69278022@keescook>

On Sun, Aug 09, 2026 at 10:30:35AM -0700, Kees Cook wrote:
> On Fri, Jul 10, 2026 at 12:19:32PM -0700, Jennifer Miller wrote:
> > Initializes bpf_jit_harden to 1 if x86_64 CFI is enabled. Prevents the
> > misuse of BPF JIT code to craft CFI signatures or Endbr64 instructions
> > by enabling constant blinding for JITted BPF code from unprivileged
> > users.
> > 
> > Signed-off-by: Jennifer Miller <jmill@asu.edu>
> > ---
> >  kernel/bpf/core.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 47fe047ad30b..ed22b90c6e4e 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -548,7 +548,11 @@ void bpf_prog_kallsyms_del_all(struct bpf_prog *fp)
> >  /* All BPF JIT sysctl knobs here. */
> >  int bpf_jit_enable   __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_DEFAULT_ON);
> >  int bpf_jit_kallsyms __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_DEFAULT_ON);
> > -int bpf_jit_harden   __read_mostly;
> > +/* Enable hardening by default when x86_64 CFI is enabled to prevent CFI
> > + * hashes and endbr64 instructions from being crafted.
> > + */
> > +int bpf_jit_harden   __read_mostly = IS_ENABLED(CONFIG_X86_64) &&
> > +					IS_ENABLED(CONFIG_CFI);
> 
> Why not just do this for all CONFIG_CFI?
> 
> -Kees
> 

The intention was to not enable JIT hardening by default for other
architectures when CONFIG_CFI is enabled when we don't know if it would
be preventing any CFI from being bypassed. It may be possible that kCFI
on other architectures is able to be bypassed in similar ways to x86_64,
but we haven't looked into it.

~Jennifer

> >  long bpf_jit_limit   __read_mostly;
> >  long bpf_jit_limit_max __read_mostly;
> >  
> > -- 
> > 2.34.1
> > 
> 
> -- 
> Kees Cook
