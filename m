Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605F02F874
	for <linux-hardening@vger.kernel.org>; Fri, 26 Apr 2024 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714151181; cv=none; b=VeyfdfMB54JhfCG8EDhOUSrqxrlfeSPW6c8sSeo+SqI/reZzK6DxZb3XpxRnAhzwDD1ebUh+wfobGVyuoH98UhF9rYqrZA0qUUhmZpXBQ6AubByjn5uj1+b8KtitFbLNHU75cTIW2js8gTD50wjxckyD+GNYn54Sfi42I0aVm5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714151181; c=relaxed/simple;
	bh=rUgSrXh/kUp2ce5vjmf3tVk45NuHCMnuJRWXof5A6Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQaMl/igPCBqXMA2pe/GP6eCKUic2sEP6s483cbQiXBoqahuR/kBExxhg2dMtO/RxP2qxffkyCCAA1x/2bq2uU7ZIB2fpzDH9Ysn6A5Su+uN6jnlVKh8p0VxR6rRq7f6s2JJfqNwXyqNnmJ9z49fW1Z3+1oZZkif3tc0Y3kCbmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oCk4ARU4; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oCk4ARU4"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6eff2be3b33so2305807b3a.2
        for <linux-hardening@vger.kernel.org>; Fri, 26 Apr 2024 10:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714151180; x=1714755980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SgX9HQcRhIm4KtQdq9GYft3Q0ZiwCuQWZ5JhWxXdoTI=;
        b=oCk4ARU4a263ukrUlQUorV9/Jrw9YVzOGIG7ZkRWBCRko955Oeb1b7Zh1JH3kcyKNM
         mhRkw7Fj945f+RcI/wgXfi2JspbrYbxbxqoBr5Zu5DUqRCJHNslnIiSsLOstE0ImIvRK
         GW0SOGwybzdag5Rq46fkqIvBzCOV9f/+N4ZH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714151180; x=1714755980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgX9HQcRhIm4KtQdq9GYft3Q0ZiwCuQWZ5JhWxXdoTI=;
        b=pitHu9UozqCbmuQFugKj4c54Au85oQaAHzllNBQmwbvsPu6PM6zg4zU9vmleuDimXc
         h5S74N8ExtdUCGFsQM7ECk0UnmvetnzUh++kZ+OZaiLBg65ZDJHzYL+OEy/e2Hqq3nVV
         ovAhMAXczFCEVxthoukWSxQXDHFZZT+ZrXURmQIw3LEAbeRAp2CyovmVYCtoixGfRMs7
         VxiFcr77oBcmh5jf7Fk8OiYTFXnGN1LFYhS/EePTHAR0vXvQhtbJiCjb2d2jjW2Nchl+
         Is0sIYfdbd7Rzl6hoqTWflSjhjyvylC4BSHPdilpjtRb5edx4bc3c1f5nnBQCAAGWTDK
         n8oQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8kPpLW04GgdfqSa51Q/7aoq/nIFdo7qxgRND4BCpz4Bpcz5dj4+hOg3x1krqsfTfUUNthZEA18h8v0RyJbfI1jHdqKozyWvye6vlh97Gh
X-Gm-Message-State: AOJu0YxTjrT24Wgflpm+V/OLMQJEINrLWDOQolk3+Vwu7wjhXzVTECj8
	U2HD/fmvqgItGZLbz3DaP+tZCnqyQxsWwOVMLh+hFZ7pOteh6zSXFWqJn8hmMA==
X-Google-Smtp-Source: AGHT+IFRuONJTBeF5jWTd1Z1iUSFqM7Mlp2kx8AS+7oOD8Od6nCZUNw8lqItcPq8AJeYMewLdxXOFA==
X-Received: by 2002:a05:6a20:9703:b0:1ad:92e0:f5d7 with SMTP id hr3-20020a056a20970300b001ad92e0f5d7mr3368882pzc.46.1714151179677;
        Fri, 26 Apr 2024 10:06:19 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jw37-20020a056a0092a500b006ecf0ad97bbsm15541913pfb.17.2024.04.26.10.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 10:06:18 -0700 (PDT)
Date: Fri, 26 Apr 2024 10:06:17 -0700
From: Kees Cook <keescook@chromium.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mm/slub: Avoid recursive loop with kmemleak
Message-ID: <202404261005.F7393F558@keescook>
References: <20240425205516.work.220-kees@kernel.org>
 <Ziu_qOmgnWRdAByp@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ziu_qOmgnWRdAByp@arm.com>

On Fri, Apr 26, 2024 at 03:52:24PM +0100, Catalin Marinas wrote:
> On Thu, Apr 25, 2024 at 01:55:23PM -0700, Kees Cook wrote:
> > The system will immediate fill up stack and crash when both

Oops, typo from me: "immediately". You'd never guess I'm a native English
speaker! :)

> > CONFIG_DEBUG_KMEMLEAK and CONFIG_MEM_ALLOC_PROFILING are enabled.
> > Avoid allocation tagging of kmemleak caches, otherwise recursive
> > allocation tracking occurs.
> > 
> > Fixes: 279bb991b4d9 ("mm/slab: add allocation accounting into slab allocation and free paths")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> For the kmemleak bits:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks!

-Kees

-- 
Kees Cook
