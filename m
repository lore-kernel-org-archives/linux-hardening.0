Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58BA4EB56
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 01:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705973932; cv=none; b=DhxW1GPr1coWQR6cQ6cH+rUWUIEHoh3FW2Yzi9lUB0kH+r5ufcOkStO01Wb9KS8F4Sbzqqb9v9Laa0GeyvCGPCgyC5Z2r+Vjr+0+vIN4NMTnaKuCN8ihCjgau95Mjtuh7rnrOfCbI1HF7lLw8GVHztHk0p7PAxdOrR8OZcD5NsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705973932; c=relaxed/simple;
	bh=zl4aJyrUhSHsvEk27CkHExQkZaJ7tb06Sui5CDGbx34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/tFGbdcHdNc+C6oiJwDe4oA1mCYkbjPbOE6kVtxp0MSYlc56Mr/rj83okR0HLcVVenrVFr8uWjV8Uf7BK4M5fI9SZKmrulYgHDMQoyIFZs5LECyMvnkZKMktsIYMl5zstKoy7Y3zBazcMZEuHhYORomsm79nYK63dpWwAcEOKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G2rhQ12B; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G2rhQ12B"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6dd6c3c8a0eso74100b3a.3
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 17:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705973930; x=1706578730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3WdGUH2BwY/NEYNguaaXC3mNHDjXcBRBu3LEUVRExTQ=;
        b=G2rhQ12BROdNyP0zm9UWTmgqEsFjOH/uQLcqchkMOTWbfq7Pew652vPJzz5jh2m0wO
         rI24nJUMLcv3Jb3wNB9w3xhpY3PBOmFZYv9y2hKsWYfJfL7AsvFEcnbr4C7rYkFAflOL
         Q6cNmmZVEpP68gbzdl1c3NVIlzXOGGHPrOsrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705973930; x=1706578730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WdGUH2BwY/NEYNguaaXC3mNHDjXcBRBu3LEUVRExTQ=;
        b=rGPQ21wxc1JP0TBY8NmSxDmp9U954+19gfPs4D2YlI9ah77CMWdytsygT7cBa9zfg9
         NzUk18bqkKOfWA9Ibzj/tUeZRVmmP/+6i/1Ro0uMPjyYastBljbMhDhFhtzSdwx4tJOO
         xgQ8JryAFChqSiXGer4YeN4TX4hZ2jpB45V9G1rXGDkKeFagMVf4gvlnE/HC/B0sSNZ9
         GPqTPkymrQBOy8BNakkkMliryvPt1WuT3EmfQQ5Z1UR3ElREmoc6nqU5IICQ1ISOQFLT
         idNPTYvRW2eSfzFisoV9a+x1fZi60ttUfIMicnQNJRLuhJm4v+nPfvBXToHjoV/cUxdO
         EQfQ==
X-Gm-Message-State: AOJu0YyUAwzcNuIDErNiNpS2nBcZ+OlZ/gnOzVWvgvBPHfsQDSRCngna
	swUAZOYjb+BodfQbuPrGox3peNo9cUKrSYClxQdsyO4FYhyY5tmnX84Ztpsv6A==
X-Google-Smtp-Source: AGHT+IHQv4+ziECX82p4oiuyPHzvjMvPIEVm9TEr6afRzbnVws9fq5VlFHPtV/DhF9QjU9jJNWCzyA==
X-Received: by 2002:a05:6a21:33a9:b0:19b:1f00:29d3 with SMTP id yy41-20020a056a2133a900b0019b1f0029d3mr3132827pzb.7.1705973930199;
        Mon, 22 Jan 2024 17:38:50 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w15-20020a17090ad60f00b0028dd42b115bsm10167086pju.5.2024.01.22.17.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 17:38:49 -0800 (PST)
Date: Mon, 22 Jan 2024 17:38:49 -0800
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Brown <broonie@kernel.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Vasily Averin <vasily.averin@linux.dev>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 34/82] ipc: Refactor intentional wrap-around calculation
Message-ID: <202401221713.3FCABC9290@keescook>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-34-keescook@chromium.org>
 <CAHk-=whS7FSbBoo1gxe+83twO2JeGNsUKMhAcfWymw9auqBvjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whS7FSbBoo1gxe+83twO2JeGNsUKMhAcfWymw9auqBvjg@mail.gmail.com>

On Mon, Jan 22, 2024 at 05:07:40PM -0800, Linus Torvalds wrote:
> First off, none of this has anything to do with -fno-strict-overflow.
> We do that, because without it gcc ends up doing various odd and
> surprising things, the same way it does with strict-aliasing.
> 
> IOW, you should think of -fno-strict-overflow as a hardening thing.
> Any optimization that depends on "this can overflow, so I can do
> anything I want" is just a dangerous optimization for the kernel.
> 
> It matches -fno-strict-aliasing and -fno-delete-null-pointer-checks,
> in other words.
> 
> And I do not understand why you mention it in the first place, since
> this code USES UNSIGNED INTEGER ARITHMETIC, and thus has absolutely
> nothing to do with that no-strict-overflow flag.

I've tried to find the right balance between not enough details and too
much. I guess I got it wrong. I go into more detail in the cover letter:
https://lore.kernel.org/linux-hardening/20240122235208.work.748-kees@kernel.org/

Basically, this isn't about -fno-strict-overflow -- that's just a wrinkle
on the compiler side. I completely agree: we have to keep the "undefined
behavior" junk as far away from the kernel as possible.

This is about disambiguating the intent of C arithmetic so we can be in
the position to instrument the kernel to catch unexpected wrap-arounds.
We can't use C++ tricks with operator overloading and the introduction
of wrapping vs trapping types, so we have to annotate things directly.

And we have sanitizers for signed, unsigned, and pointers. Hence, the
need to adjust these open-coded wrap tests. It's not about removing UB:
-fno-strict-overflow already does that. This is about let us trap
unexpected wrap-around, regardless of type.

> Stop making the world a worse place.

Rude. I'll leave that to ice storms.

-- 
Kees Cook
