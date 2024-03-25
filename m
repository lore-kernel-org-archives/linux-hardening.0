Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1623D82D64
	for <linux-hardening@vger.kernel.org>; Mon, 25 Mar 2024 23:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711408440; cv=none; b=Q7i4x0Y+sebZJw9JnAFKltA4CUMZg1a/r2IGuqjy/XrZNPjUYdL9kSKCVUjEZl2tlFAp6MGiO3yMxYNha+SM062X8yIMEhI2/tIySwGXQQE8cn8Fqr6lgLk8Dk87nslYJ08ijOHyh0UwbzWejbQhKaIhx355u+ahZSvv7Ubb+lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711408440; c=relaxed/simple;
	bh=aqJifYxn5u78ALwMxq1Y3V8SdDX+a7VN76OUmiP10H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CePaeozUJpv4Jkz6TyUs2ij8fRr328Zzb0lW4vde3qNDj7yEEzm4MdjRmzO+LZSB1IvaPEO4kQvpgcTkpG40xKqyiNXw1zz5kBySRE/W/oPBx0yzAX9KyvQLLHh4AAC6dpFF0fTOcMrqFPQOpPlUI+zXR786M3f0lKo7+IyhTRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GH4vf/Jn; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GH4vf/Jn"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2228c3ffcbdso2081073fac.2
        for <linux-hardening@vger.kernel.org>; Mon, 25 Mar 2024 16:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711408438; x=1712013238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YTiIah+56OL95MvLxsoMlL16NsHmbf/z1NDz1O3yUIE=;
        b=GH4vf/Jnr1xb/rd3tsWz+/EJdXNILyP8iZ+ai4vChv37rtXtJ8TwT0DOadtJPcjiIc
         Kn5R7TJWxFi7V+ONpDiyRcf1Y2BbprtMs+oafRXtKPdIXz9zJ8v1km5tiDT8CjDZCmV8
         9Tgz72H0T6vToQIG3/spo3KL/AJG6xPiahLBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711408438; x=1712013238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTiIah+56OL95MvLxsoMlL16NsHmbf/z1NDz1O3yUIE=;
        b=c3tQdozCAOhaneWFfXFDd9kA6E96RLANn6ueU0a02LDRNPV49QpuCGQMtALbmbZ+b9
         xOynS5W9gNfWe+dZN/5nwrazxaqutNMDHQawu7RToN8SuR0D7pw1T7U+LpiNmIow409n
         D+I6gvZw731zWy0+LlEDADu//GImjOxYR4QM9+gYuSnp2cn1RHQTibmlicnea6f8XxW/
         O2uIfsroZzzvlQCFz3RUisH7iPYjFmy6LywUsj94oH7sWA0WV8lYqovCB61htvahnP6E
         lw7K0+/hN7l0Zgjjd98Yqdi46mfE60mTtzu3i9NkWYd/6PcLIP0Eoc5fV1qs+kh7SNGC
         1H/g==
X-Forwarded-Encrypted: i=1; AJvYcCUtzqSX53Gw0UYqPLlyZhzYeIgsbVCsHZ1eTmkBgSC1Gbd8t1Cw6gjKt+uhbp0cYuQ4TQsZ5tL2tGO9ExUJjVTTZQMWF02sxvfb8UufQnpF
X-Gm-Message-State: AOJu0YwxUBJuQDVd0dMoR6UNz9kOyKDZOI8Bzru8Ym9ShAZcGHY3pW68
	lNIqGZS0LmI+fVc00novzyVhikRrp7MkZXHHikJP8WEbGYQLGlXdY56aFMhwYw==
X-Google-Smtp-Source: AGHT+IGtyD4P4iqpqDllYpprt5vrEviS5VJKJGKD5uIFgXBnta+btyjjzK1a/0Cds/Qxz+YmqTU1tA==
X-Received: by 2002:a05:6871:554:b0:229:b0bb:3017 with SMTP id t20-20020a056871055400b00229b0bb3017mr7943491oal.59.1711408438066;
        Mon, 25 Mar 2024 16:13:58 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c29-20020a056a00009d00b006eabaf689edsm27328pfj.113.2024.03.25.16.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 16:13:57 -0700 (PDT)
Date: Mon, 25 Mar 2024 16:13:56 -0700
From: Kees Cook <keescook@chromium.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 4/9] slab: Introduce kmem_buckets_create()
Message-ID: <202403251609.1F681B5D@keescook>
References: <20240305100933.it.923-kees@kernel.org>
 <20240305101026.694758-4-keescook@chromium.org>
 <eppzf5gil6izcn6nnvzgzukagdikqnfxdvziga7ipnpl5eeern@i7jfzslklsu6>
 <202403251327.C15C1E61A@keescook>
 <67tgebii42rwneeyqekmxxqo2bzgyysdqggciuew27bc3gbrkg@5ceqjmiaxvyu>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67tgebii42rwneeyqekmxxqo2bzgyysdqggciuew27bc3gbrkg@5ceqjmiaxvyu>

On Mon, Mar 25, 2024 at 05:49:49PM -0400, Kent Overstreet wrote:
> The codetags are in their own dedicated elf sections already, so if you
> put the kmem_buckets in the codetag the entire elf section can be
> discarded if it's not in use.

Gotcha. Yeah, sounds good. Once codetags and this series land, I can
start working on making the per-site series.

> "usercopy window"? You're now annotating which data can be copied to
> userspace?

Hm? Yes. That's been there for over 7 years. :) It's just that it was only
meaningful for kmem_cache_create() users, since the proposed GFP_USERCOPY
for kmalloc() never landed[1].

-Kees

[1] https://lore.kernel.org/lkml/1497915397-93805-23-git-send-email-keescook@chromium.org/

-- 
Kees Cook
