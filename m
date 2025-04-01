Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE7F1372
	for <linux-hardening@vger.kernel.org>; Tue,  1 Apr 2025 00:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743466329; cv=none; b=biGwFphLUBb0qhnMQcpTOEqVo0XCO/JYMS5qqaIXz+5wEF3dz2NotRNLyOUV3lUvMFkwDmHyaDTgTEHT2MJnSzIM+qOOJJmByGGREgRH4hByQPZgaCQEgRV2Gtbp+20zr3U2KZLcjYKhR5Kn5YpAzk+clwWqdBoWGNEXLeAyJ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743466329; c=relaxed/simple;
	bh=4OBqz7wDraSoW0l6yq+0GpIDBxLW46dFRm5AL8c+8kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfVXIeDaacZlmu3bZ39l8/X5xow5eV31OQDaNnaHT3ZjAvCg3Xk06tbt7/R224OcbDITC4ypqlQa7/2dMZTzVoqVhV7JV2OYq4olIyvrQ+4oZHBHo8VZ2+SDvF8c9j233UGFVt5P6RaEI7bvBZrTvrf7LEt74FJTFz9dfTYZGAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OIwD3GLg; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OIwD3GLg"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e6194e9d2cso9704975a12.2
        for <linux-hardening@vger.kernel.org>; Mon, 31 Mar 2025 17:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743466325; x=1744071125; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JePFNkfbv8aLxrEPQhMGBSSVCyqR/ZwFXTbEBhcrHt4=;
        b=OIwD3GLgr5jCIsOZSl8rv73cmqCFOl6HzHhF+6kTr4uv+Bufqvq49MkQN5SnwOyXK6
         uwg51pae3Bb/GIA6ZSwRmCg/c4YfqbK50jFpLOxvMA1VapY3xFYc7arDIMSwAxGKcWCM
         IyBrS9Cy4oWBXDLEhU1ocYEPSSTeRvu0+Hoec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743466325; x=1744071125;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JePFNkfbv8aLxrEPQhMGBSSVCyqR/ZwFXTbEBhcrHt4=;
        b=p1v5PQl8Fp7C+HPXiU2wteHAQzOmN0Jpk/BKFZ4wrC91ZYIQM/aO6D5I/SgYeB+XJW
         qD90I3ke2Te8Ecu93bc8tKRl7a6KI1O83kf9lOZnMjf4Obbp20jVY+Hhh0vcWHX+DuIf
         YXpDLpGFjMiV0VzHYGZZtoKPF6uMYdRxaCm8VIPFXTd4ch6x5wC7b89+/voP3mfm8Fic
         oy6L927KL9ColrofVkue+eaBN6aCicfzQ9TvEgTO+hM721RM2CPmCtX0Ee6SCGq9Ytcf
         IXHvgkVY9WypeCI6ukR8qm8waWNTB2KrucqBYoPCCa5x9eQ69NuLMKdVAPlK0spOtdwo
         QnIw==
X-Forwarded-Encrypted: i=1; AJvYcCWdsOE3r/EMQxaUKRaMry7TZmDIp/VaDo3F6h+rGufGc/VRL0154sKQ0PZCGtv3qydZ+1Jjwe1nNXfCMpl0VL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7scf1pqVA6wqC1B5J+p0gybOroHOdPj3f/yGOZ6Sew+Af9j6W
	gWAQkFWwvyt34z+bbeXw26QRPKstY0J94oyoo7FV20+GLzWVeN5z+cXw7FYfeSCkN1mAqGQNSN8
	3mew=
X-Gm-Gg: ASbGncuv1l189BLxN6aQ0HSgY6aUMmt4c+i7f1Pfm2yTPX0E8lN8O93jb3wpX/p6Bmr
	Tlau6p1qGLrIh0+aVhbuju9N/9TZMMj9wmSBcF+kprjkIV9KqFnaHxbCzJCIbyNojCeeeX/mLcI
	145r3Acm2PiBtPvwDuu3L8P94JKUcp7F4PGZhecr7OunlmpvCMr3c0qcKxpnRFDTWgObyyoHiMB
	6TIS/W2XcmQ6hy0lG9N2HXWPEE7y8A03AEe1125ulxl6i+k1yxFPO/0m0DA1m7PfGEZFIyQ5TI4
	wraLCg4772E/vndavAJl3IG1fyd0aod66S7eeOTtdcfh25bm5bg4CL6Zz69cZbSXA8AEZSHWtjl
	+EJt4jfkeKEpmppe2i/M=
X-Google-Smtp-Source: AGHT+IFHfC9GZ/mqZrk1tWQU5q/9nTClnXM9fJCqSiqj8Qgrz/PBAyHbmXPKbcTdcEy2Ncy5bMr3ag==
X-Received: by 2002:a05:6402:440f:b0:5ec:958b:6f5a with SMTP id 4fb4d7f45d1cf-5edfdbfe4f4mr8442907a12.28.1743466325511;
        Mon, 31 Mar 2025 17:12:05 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16d3629sm6261853a12.23.2025.03.31.17.12.02
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 17:12:04 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac6ed4ab410so798518666b.1
        for <linux-hardening@vger.kernel.org>; Mon, 31 Mar 2025 17:12:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbfAXTnTeObQv9/Nni+6qKWa7nTiin60A0Losw3Z+EYEaM20JnLFyvWte+PClYEgO4mnulHZhP8ApXrTAaKGc=@vger.kernel.org
X-Received: by 2002:a17:907:2cc7:b0:ac3:b50c:c95b with SMTP id
 a640c23a62f3a-ac738c6f05amr961651866b.56.1743466322604; Mon, 31 Mar 2025
 17:12:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331143426.947281958@goodmis.org> <20250331143532.459810712@goodmis.org>
 <CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com>
 <20250331133906.48e115f5@gandalf.local.home> <CAHk-=wi5pLoe3szxLREQGGJuWU0w_POK9Sv6717UH3b7OvvfjQ@mail.gmail.com>
 <20250331165801.715aba48@gandalf.local.home> <CAHk-=whRNxdkLC6Z91g-_RbrRsUo6K6+nvRWqccjsOycwUe_JQ@mail.gmail.com>
 <20250331194251.02a4c238@gandalf.local.home>
In-Reply-To: <20250331194251.02a4c238@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 31 Mar 2025 17:11:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDQpOeXi_GjKB7Mrh93Zbd__4k+FF_vJd+-prbaacEug@mail.gmail.com>
X-Gm-Features: AQ5f1JqK7DmBOcFeFBdcHQa56oLi7rko5ae58L-hQhqZ-SgnT-hvWfyBuLaYeuE
Message-ID: <CAHk-=wiDQpOeXi_GjKB7Mrh93Zbd__4k+FF_vJd+-prbaacEug@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code do
 the vmap of physical memory
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vincent Donnefort <vdonnefort@google.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Mar 2025 at 16:41, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Hmm, so if we need to map this memory to user space memory, then I can't
> use the method from this patch series, if I have to avoid struct page.
>
> Should I then be using vm_iomap_memory() passing in the physical address?

I actually think that would be the best option in general - it works
*regardless* of the source of the pages (ie it works for pages that
don't have 'struct page' backing, but it works for regular RAM too).

So it avoids any question of how the page was allocated, and it also
avoids the page reference counting overhead.

I thought you did that already for the user mappings - don't use you
remap_pfn_range()?

That's basically the equivalent of vmap_page_range() - you're mapping
a whole range based on physical addresses, not mapping individual
pages.

But I didn't go look, this is from dim and possibly confused memories
from past patches.

> As for architectures that do not have user/kernel data cache coherency, how
> does one flush the page when there's an update on the kernel side so that
> the user side doesn't see stale data?

So if you don't treat this as some kind of 'page' or 'folio' thing,
then the proper function is actually flush_cache_range().

I actually suspect that if you treat things just as an arbitrary range
of memory, it might simplify things in general.

For example, the whole flush_cache_page() thing obviously just flushes
one page. So then you have to artificially iterate over pages rather
than just use the natural range.

HOWEVER.

At this point I have to also admit that you will likely find various
holes in various architecture implementations.

Why?

Because sane architectures don't care (there's basically no testing of
any of this on x86, because x86 is typically always cache coherent
outside of some GPU oddities that are handled by the DRM layer
explicitly, so all of these functions are just no-ops on x86).

And so almost none of this gets any testing in practice. A missed
cache flush doesn't matter on x86 or arm64, and very seldom elsewhere
too.

We do have "flush_cache_range()" calls in the generic MM code, and so
it *should* all work, but honestly, I'd expect there to be bugs in
this area.

Of course, I would expect the same to be true of the page/folio cases,
so I don't think using flush_cache_range() should be any worse, but I
*could* imagine that it's bad in a different way ;)

              Linus
