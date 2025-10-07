Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF259214812
	for <linux-hardening@vger.kernel.org>; Tue,  7 Oct 2025 18:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759861149; cv=none; b=X6N7WqQjyjd235/SE2YjXXkC+LtyEZjbdRZti/XtHzQg6NV8SqYYUEJCwDIkGFuaoUCBFYl+CXWZIj2rxzPqVxWTsVNQHlRYaLSR+6GDqXCxcFzoLPzzTWFjSXc1orOad2MSFkITnK7Sb8rtTEE+rxEtU9aWWhHONmJ2wHsRKpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759861149; c=relaxed/simple;
	bh=1NYA5NXCfUNHGAMPIDINqsi5FPnYmleHEw4ndZr/cwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmDRJUgHjObgQgRjg4R0FmGNkx0xGVuZcsFmm16tWk5PWhfMghzjZydX7Ur/NnJ8rAr71Lc2w6L4/etYipB7+xj8CnkpCH1Lw+cCkCYptc1PrYh9RJge3Jug3v8FeBQ1/T6NGhOYit1mCsS2Y361TBs7OERiBMsvESV+1EzVJqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YplMvuy5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YplMvuy5"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-28e7cd34047so55250945ad.2
        for <linux-hardening@vger.kernel.org>; Tue, 07 Oct 2025 11:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759861145; x=1760465945; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1NYA5NXCfUNHGAMPIDINqsi5FPnYmleHEw4ndZr/cwc=;
        b=YplMvuy5kbPgDl3ljou9lJkcN9nLAcTVdVoIZT0CYuHmj57MIlNgwQJUJFqZOG8vl3
         n8/da0iAS8m9YtuI4yt92wU9/BhDVytxfU2plfmVnJI5dgxYLpwRP/7hFKyPywzqNK6M
         o4JdWuOHHslGYr1vdfGoWVMhNr+hGZ9lj0uyEcKgiOFDhdObG80DaSv6bDDvQxjVRwao
         OIp7jG5LbYKkLN3ORVa69KSYxSiJ/EzmGcjWaKjZhJkyGbOyhukjASvH/tuMhjig0gI2
         xJFsjU0ZeXzrA5tdDzi+b7TK0B9YhoroEIHAV11kuHok7087WUdpmkknz2GqwxSUB48d
         /YKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759861145; x=1760465945;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1NYA5NXCfUNHGAMPIDINqsi5FPnYmleHEw4ndZr/cwc=;
        b=dSlKKCLsOUDvI+4arZQ8afFss+Go0bw6FNGTfK9ZtkJM9BoT1+1q3VruZSNPd0MgEv
         dFs7e3iE7R2kONKR6yAlXk6IWa6yCiT6lSpQ08dpvgEeRN4GuxojAVBFU3hCz7C3866Z
         AufmRgRo9w5xI/pTja4mvg83Fv9R3JCG4g0Kp4+8alNI9lOxPW7IZxcg4bdZbEKnipbE
         FhahAQaYVbQ5VdNX29gfekAhuyDZT+nMS7JY9YjjMT8w3tyDqDeoHk6rsjwPSHmu3WD/
         s6qLcLurzSKIc01dY9IHwablRg4ASXIlCgIo2iqlyF0bh89lQc8enCfBirZZ6629G46p
         a0dg==
X-Forwarded-Encrypted: i=1; AJvYcCXQsHCs7OmymeKcpwXPnWLYbxfvGCS4CPuRzKPkYjoCqCar1zlh+fUZEuzT8+50wZiD7osO6Sv1KNgCfN8DSQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxldSBEubZbbGwXKuxVYElC0OMkbP+7rN3Lt5eKD5gkjJo2hnls
	JgXPaQHgfKYfIS2d9uSksSoXwAh7dMtmw9s+4pDD3hWJ3n4wITrRfcMtii5p72m9KqXN6QsZ55D
	uZowPEAZRTaYPuv/RI9virbuvRnQ6o35mPjztuAhN
X-Gm-Gg: ASbGncsnGneJ3K6zAe6x+cBddHqj5YeZ8f5n5XS75f4Bv4HpbMB8o+poDi6lbDe4za1
	CVwpeGSJWXE24vHorKFUvLRWkAnuTMATG6f5nwMPoKekg8RSLKlKqr79h1/E431+FdZRwPUMg4A
	1CPJcFCG9aTJIcgbPpinYgOS1k2fl9GuLcyKXXbHnnDnEBgL+6aW70IVXTDArnzz5541MhEAyww
	WcUdMzaQos3BzH2Pcam/G48mE1NI1isjUqCTGFsbv4H+qXiv/DmwRc6//YlrV/vxKU9681V2SUz
	sZg=
X-Google-Smtp-Source: AGHT+IHw6dFIKAHzPTv9mVtUGHjBlx7WlkdXf8MR1ZgGcxSTfN3zEfUpxsIIe3xlxd6CYLBEcLBlT5+Vp1Gkw1TXYKQ=
X-Received: by 2002:a17:903:2343:b0:28e:7f50:5d80 with SMTP id
 d9443c01a7336-2902721336cmr7056975ad.7.1759861145158; Tue, 07 Oct 2025
 11:19:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315025852.it.568-kees@kernel.org> <20250315031550.473587-2-kees@kernel.org>
 <aOR15Xb6DfolYM0z@casper.infradead.org> <202510071001.11497F6708@keescook> <e019c59a-ba8b-ec04-dc5b-923cf9dd9d9c@gentwo.org>
In-Reply-To: <e019c59a-ba8b-ec04-dc5b-923cf9dd9d9c@gentwo.org>
From: Marco Elver <elver@google.com>
Date: Tue, 7 Oct 2025 20:18:28 +0200
X-Gm-Features: AS18NWCHLWcuBl7emRjgyAd7xCJevIo8qneqm5GOzEKlmO2F3nZsj3gxx6OmYQU
Message-ID: <CANpmjNMsSGY+QEn=GV8S2sXuuQsioikPR+OhGa3+6EoTqYPkHQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] slab: Introduce kmalloc_obj() and family
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Kees Cook <kees@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Pekka Enberg <penberg@kernel.org>, 
	David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>, Yafang Shao <laoar.shao@gmail.com>, 
	Tony Ambardar <tony.ambardar@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Alexander Potapenko <glider@google.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	llvm@lists.linux.dev, Matteo Rizzo <matteorizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 19:47, Christoph Lameter (Ampere) <cl@gentwo.org> wrote:
>
> On Tue, 7 Oct 2025, Kees Cook wrote:
>
> > But all of that is orthogonal to just _having_ the type info available.
>
> iOS did go the path of creating basically one slab cache for each
> "type" of kmalloc for security reasons.
>
> See https://security.apple.com/blog/towards-the-next-generation-of-xnu-memory-safety/

We can get something similar to that with:
https://lore.kernel.org/all/20250825154505.1558444-1-elver@google.com/
Pending compiler support which is going to become available in a few
months (probably).
That version used the existing RANDOM_KMALLOC_CACHES choice of 16 slab
caches, but there's no fundamental limitation to go higher.
Note, this mitigation is likely not as strong as we'd like to without
SLAB_VIRTUAL (or so I'm told): https://lwn.net/Articles/944647/
