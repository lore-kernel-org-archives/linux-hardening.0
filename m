Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37CE156F3C
	for <linux-hardening@vger.kernel.org>; Mon, 31 Mar 2025 19:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743448351; cv=none; b=o58yN+V2wI9LQOIpYik/hbH1G6H1bV20VlOXAdjSIdarKoEbbY4qZeTWIQDmty2xCahiP5sEVgomD+Cgpot0A1nOAdfGrk5gIZTmdZ4Os3E7aq4V/tDurb1UiE1ri+E0GtRbyquetMZNd7JsxI2JXssVYk0xkRiVBz2x2a0pnVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743448351; c=relaxed/simple;
	bh=PV4ZWuWia5BRoS43j+c6MY1tfA+wTbXjkY0S7EwOtLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0txE5fxUdtFAGhekCiG4R7V2VNat6yXHenZ2S0RyJ2q8arlJC0OGnrdCvtCueoEErcfLiTogAsQIsOupRcU7kOe41shK48whov32OXEVz59K+KsJ47N6ZhS/FY4Axq1ESLmm4XTcH09vWFUW9qypxh+naVHnnk/+jKz07c6J6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Vsa683ZB; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Vsa683ZB"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso965541666b.3
        for <linux-hardening@vger.kernel.org>; Mon, 31 Mar 2025 12:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743448348; x=1744053148; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CAyEvyF8shhlI0zeiTAETM+fQKaZCzqYYXdl5MvqdzQ=;
        b=Vsa683ZB2hVvUXWnoaqgPfiBn7IHSALcdfed06qMRB64uafo53zftf5vwHm/1Vt36D
         YpyGq2HX/umKc9m3HHTmrAtoJt63C4TOKi76VP5JCrPPn0o68y7KKJgF65cbvICzzHc1
         vakWHr4m4vaLzxOfpjW2/lrLe9zK4OpqLDlGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743448348; x=1744053148;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAyEvyF8shhlI0zeiTAETM+fQKaZCzqYYXdl5MvqdzQ=;
        b=ZR+PVXtxZw4RFBWHHzGHA9tUnvGbgCygw7fBWHAFsvXgWWtUXtrw3rasde/k0SA8Fv
         hu8TXFI6lIYUNmgJ1O7sQxNtLIBcTwNgZKMiGj5YoOTQZE+pMf86aNNyHafnMPnWpbTd
         oPL387w5n2gThNr6MWROL+L8+hQ8WQ4zSOH+ue5an613jCKhp/BwhpbKM/Lab+DXIkJ1
         SwfpEfcWHQbHoYIw+TCStICTXLiuyrS+9W1gMPsOCsARNGNZNciIY2f0pABxicXbCAI+
         8vPscBSWFC9iYOJHI81MYfdNRkw5pjkIaK/Zjl600U3XgKW7xeZZNF0FLfJjb1BUOznj
         OcFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTCqgLkR4lUw2QFzLgQWTcQEJzJYmMAxEY/gkyUMToJ/KTU4+leXMt0eRQCT2re6RahpcE+Sjyw1YmVoHt26Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9GGnE72LxlzDc12im3zEYsJxI1Zr6mu5rXpQKPL1PxImnsH1h
	E2rqXwAwILIOcFcjUE83szR/lS3JcOEe1tVP0D12op3YeXZXakk2kNAqaqThj0FFkQRCn8a7Iwk
	lM7A=
X-Gm-Gg: ASbGncsVz4C7yvoHwvRGOd0w8MDG7TxDSPU6OeyzXKr3g4TfrZWk1V9yJsLi0KxBiQB
	tuczyW2gOSTNnEPsUQ6ojaQBfSZiL7+KZ5C32HGhx3cirJVTgNOa5Jbix0T9tOv6iECJ8oSQKp4
	S4/NzAn2rexJAK8AuOptvCGh9a1hEwcYq5tiBb0ZcbmfCTrwo5mq5KYDtgSnAwn7c5rLysTiUFC
	A3u69eVPJmPANTBUauTLgLxBZsUuTxsafCOZp7MNd4+vYAN2teYKpRS8FOcddjhvdcl02nJXHgw
	FxY088RwQNaFzaAKFM6NKDmolon/8E6b8xeN5alEjsAGvy1cIE/MsNUoMwCIZRVSl3Ilne8XkJQ
	KtUltw7OHx5Gna/qk9GQ=
X-Google-Smtp-Source: AGHT+IHtC5laf+gMU4jo+X/w/+PixighT4UdAJUBEkQ3Ze+hST7p01LyH2ZUF57BdNRs2X8TJcQQ3A==
X-Received: by 2002:a17:907:7205:b0:ac7:3595:5740 with SMTP id a640c23a62f3a-ac782ead600mr33877266b.57.1743448347724;
        Mon, 31 Mar 2025 12:12:27 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac719221029sm661574866b.29.2025.03.31.12.12.25
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 12:12:25 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2a9a74d9cso917338066b.1
        for <linux-hardening@vger.kernel.org>; Mon, 31 Mar 2025 12:12:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWvHYW15OW8LZDzfWPANX6bVPkb0jKW8BRlsOtzwiZgKeJ/8lJZpJycjXgRcK/f26V36byS2M5YQpNmU/dbE+Q=@vger.kernel.org
X-Received: by 2002:a17:907:2cc5:b0:abf:73ba:fd60 with SMTP id
 a640c23a62f3a-ac782be130dmr33191366b.29.1743448345444; Mon, 31 Mar 2025
 12:12:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331143426.947281958@goodmis.org> <20250331143532.459810712@goodmis.org>
 <CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com> <20250331133906.48e115f5@gandalf.local.home>
In-Reply-To: <20250331133906.48e115f5@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 31 Mar 2025 12:12:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5pLoe3szxLREQGGJuWU0w_POK9Sv6717UH3b7OvvfjQ@mail.gmail.com>
X-Gm-Features: AQ5f1JpTB-4kVjtmNv0aborYt6qti1nP5IpkPDDowc_-kPaTaqaDeELjzSuvoaw
Message-ID: <CAHk-=wi5pLoe3szxLREQGGJuWU0w_POK9Sv6717UH3b7OvvfjQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code do
 the vmap of physical memory
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vincent Donnefort <vdonnefort@google.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Mar 2025 at 10:38, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I just did this to be robust in case what was passed in was not aligned. In
> all my use cases, it is.

I really think that ALIGN() is absolutely the opposite of robust.

It silently just makes incorrect values generate incorrect code.

Robust is dealing correctly with incorrect values, not making it
incorrect data just create even more incorrect data.

> OK, so I did copy this from fs/pstore/ram_core.c as this does basically the
> same thing as pstore. And it looks like pstore should be updated too.

Please just stop copying code from random drivers or filesystems.

Christ.

I've said this before: core kernel code has higher quality
requirements than random drivers (or even random filesystems).

You can't copy crazy incorrect snippets from random sources and put it
in core kernel code.

> This is due to what the "reserve_mem" kernel command line feature gives
> back. It reserves physical memory that is not part of the kernel memory
> allocator (it also works with memmap ie. memmap=12M$0x284500000, which also
> requires physical memory addresses that are not part of the memory
> allocator).

Yeah, so in that case turning those into "struct page *" is
horrendously wrong, because you've literally taken it away from the
memory management.

If it's not part of the kernel memory allocator, it does not
necessarily have a "struct page *" associated with it. Using a pointer
to 'struct page' and passing it off is just fundamentally more than a
bug: it's seriously and deeply broken.

It's probably much more obviously broken if the physical addresses
came from a PCI device, and this all just happens to work because it's
actually real RAM and we ended up having a 'struct page []' for it for
some random reason.

But the generral rule is that if all you have physical RAM addresses,
you can use them as phys_addr_t (or turn them into pfn's, which is
just the page index of the physical address).

I think that *completely* bogus code worked only entirely due to luck
- the 'struct page *' was never actually dereferenced, and it got
turned back into a pfn and then a page table entry by the vmap code
using purely address arithmetic (page_to_phys() and page_to_pfn()).

So it probably only ever used pointer calculations, although some of
those actually can end up depending on dereferencing 'struct page' (to
find the base zone of the page, to find the mapping).

Add even with just pointer games, that should actually have triggered
a warning in vmap_pages_pte_range() from this:

                if (WARN_ON(!pfn_valid(page_to_pfn(page))))

which I suspect means that we actually *do* end up having 'struct
page' backing for those..

Looking closer...

I think what happened is that reserve_mem() actually does end up
giving you pages that have the 'struct page' backing store even if
they aren't mapped. Which makes the 'struct page' pointer stuff work,
and those pages end up working as 'reserved pages'.

And I suspect that happens exactly because we had users that mis-used
these 'struct page *' things, so it might even be intentional.

Or it might just be because that memory *has* been in the E280 memory
map before it was reserved, and the 'strict page' arrays may have been
sized for the original E280 information, not the "after stealing"
information.

I didn't go look into that early memory reservation code, but I would
not be surprised if there have been fixups to work around bugs like
this. I haven't had to look at it in ages, but maybe the bootmem code
knows that bootmem allocations then might be given back to the VM and
need to have those 'struct page' backing store things

Or - and this is also entirely possible - maybe you were just very
lucky indeed because the code to allocate the 'struct page' regions
ends up intentionally over-allocating and rounding things up.

Because of how the buddy allocator works, each 'struct page' array
needs to be rounded up to the maximum page allocation, so I think we
always allocate the page arrays of a memory zone up to at least
PAGE_SIZE << NR_PAGE_ORDERS boundaries (so 8MB-aligned, I think). So
there's fundamnetally some slop in there.

Anyway, if you allocated them as physical addresses outside of the
regular MM code, you should not use 'struct page' in *any* form.  You
really can't just turn any random physical address into a page, unless
it came from the page allocator.

And yes, I'm not at all surprised that we'd have other mis-users of
this. We have some very historical code that depends on reserved pages
going back all the way to linux-0.01 I suspect, because things like
the original VGA code knew that the physical addresses were in the
BIOS hole region that was backed by 'struct page'.

                Linus
