Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE89D13F434
	for <linux-hardening@vger.kernel.org>; Tue,  1 Apr 2025 01:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743472565; cv=none; b=V76+a7yq5lkBSvLcC6K6ezYeBNyIwCYlj7oqbWMYEAaG8CO2RKB0iq6G7VLCsrR9R0NUvrJIArMR91xCXXAucOMW8vFy7Qj6SHSjlGm3/xxQp0lNOw7DT2zjs/OG2NrZkg4UXY9yrdSTih8O8gJBJqbKc8fVg5WrKdiwOd0GVJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743472565; c=relaxed/simple;
	bh=oYdy5TUOKD3/QmBchtEfluPYVm4jH9Npv+xFiaubOWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPM6ge7Ln76c2s9cWZTG5uee+ugIvgJTwgoGntc2QBQZQKveRrwLwTL6olABCt3ntZHZW4crZx+0cXtGEoW1MMwWTBeak5iYAP7Ew+1QrjG8CgfIXDTM83HGmcS/TpR97A/UgLVdlcLaNivk60EvD1X6YNt/EDJHNfY6psAvbtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RJV8Ogkx; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RJV8Ogkx"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac298c8fa50so852495366b.1
        for <linux-hardening@vger.kernel.org>; Mon, 31 Mar 2025 18:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743472562; x=1744077362; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xTFYf6OdHdCoXwqeAxP2OyQHhkHeGJVwqSUrO9x7fRM=;
        b=RJV8OgkxVltvH7XZinLrmhiX7qtQhX0uJ6PsAb7KxEqaWz2CYD5c4w0kE0E9Du9hnb
         wIH0dx2p+mElABxkSDBrIBuPxBut1AyXsWFUoXruBsVTEEpY8DDZZIuQdOHxM3EgtGJv
         0dbqJx3ym3c4fxSChwZsec58yIZxKp6IgS7yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743472562; x=1744077362;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xTFYf6OdHdCoXwqeAxP2OyQHhkHeGJVwqSUrO9x7fRM=;
        b=gmib+85AzDztwQT5YuCLaeJ+/KdltnNTfA4Q4Igf/94tPeqEuUQkUmNQpB8JuGXwfW
         DIpk1Uj7IbBq+zXxmjRIHTugK0B1MBilCsE8kWxLo4sQMLRm9hwlEthIvJmWheANG36r
         KSHVBHD8UoILpIsSbfWZTkTfuZmegWVuhDA1BvvOg1gIS1OOgEFgVCWIYErqBKgm15S5
         SU4G2cYCABIlXcnD+OThalSMFmlFE33NAVipgI9caXsiCCI1b0XtFSdiCuuTd8N3do5Y
         wWwmH9/87/bDseY6AjmvFNzGKFkfYKnaWybh9ey5ZFmiBWANLVsD3zLnxh/ZagLPR8XX
         5pxw==
X-Forwarded-Encrypted: i=1; AJvYcCU232vAFd2CXlwIsw/6wCDYn74slhX7+5wyrTv2ZjoEegJnAVxdowRJC37TI2gppZujzPaeDNWnpQNeIMdU+b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyslbZfSy1C89u5uRudQBt0coH6XFDmEhtI7u1QV/+oxedGecdo
	1KHiz7wvo7KJOIwOyMjk94Mla3L7SJkaxmhH8HT5YH9qGf3LKdKERPRg31sh06Sq7pfFZGS2k2U
	fj+c=
X-Gm-Gg: ASbGncsLX9k+4oVqvMC15giyxLw50vgLTVVY6It/H72kVKx9eNSAmWu2uqHUW99uO3p
	PXJ2PRXPaPjd+5zMfvnrJcW6qhskLA6AVRmTIGNjJTyC8X/ykYvKaPY3GzAzGxzQRJ6ldhAKpNB
	7J+J/ai3I8ZqGQ9cWPgQmWkydV8y/t0zkW6HSNyun3rf/i5yqxqsy8dyz60RML4xz8x6kvH348F
	G0QmDh/xCTvKtK1GGc87t+saDpN5r2gxQFn2zNfe6D8lM7Vvj8B6cVEV7oO5AHdmynaMIcQP1e3
	iwRdhIPqOTWqDt3cKNqlnHdJuvQ13ZNqN2//l/8d9mHEOy6M1NLF2nByD8aSnLJ7h9oUXLOtwfU
	GgYg1DP1srm76h4HLtV7sA6LFQAiO/g==
X-Google-Smtp-Source: AGHT+IG+3z8BT8CYC90nhmi8TXs5XVw4PeDb6d3aq4fo4IWCSqPby9Hl05XxhjKM3w8z7xSHLVcgLw==
X-Received: by 2002:a17:907:3f2a:b0:ac1:f19a:c0a0 with SMTP id a640c23a62f3a-ac7389bd701mr974560066b.20.1743472562128;
        Mon, 31 Mar 2025 18:56:02 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71967fd0asm701303766b.132.2025.03.31.18.55.59
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 18:56:00 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2bfcd2a70so661873866b.0
        for <linux-hardening@vger.kernel.org>; Mon, 31 Mar 2025 18:55:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW5oSlDr89k4lKOGNRjg4dLqOjMPawNUOwfDgqYj/+MeXdS0kPlcaIOLeJ8EuDlEHsMAqHTErHG36XNBP71qRo=@vger.kernel.org
X-Received: by 2002:a17:907:3f11:b0:ac7:31a4:d4e9 with SMTP id
 a640c23a62f3a-ac73892d538mr981403666b.4.1743472559324; Mon, 31 Mar 2025
 18:55:59 -0700 (PDT)
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
 <20250331194251.02a4c238@gandalf.local.home> <CAG48ez3w0my4Rwttbc5tEbNsme6tc0mrSN95thjXUFaJ3aQ6SA@mail.gmail.com>
 <20250331210245.585fff23@gandalf.local.home> <CAHk-=wi=GNaLzNt5zjee6m9OHNvr=Sc1S-xsnS0cNMfdVp15hg@mail.gmail.com>
 <20250331214132.49622459@gandalf.local.home>
In-Reply-To: <20250331214132.49622459@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 31 Mar 2025 18:55:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjijTKpotANjhqoKrEFh=B=RLrfGWa7OFB2WJ9RU8jaaA@mail.gmail.com>
X-Gm-Features: AQ5f1Jo416MyRwMxGTnNWGGwQsK3CtyiS56wd70ogS4-q5i40HxlCHES0ZWgQ4M
Message-ID: <CAHk-=wjijTKpotANjhqoKrEFh=B=RLrfGWa7OFB2WJ9RU8jaaA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code do
 the vmap of physical memory
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	linux-hardening@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Mar 2025 at 18:40, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > I think 'pfn' was introduced as a name ong long ago because it was
> > what the alpha architecture used in the VM documentation. It probably
> > predates that too, but it's where I got it from, iirc.
> >
>
> It is old, as I remember using it when I first started Linux kernel
> development back in 1998.

So I did the alpha port in '95, but I meant that the 'page frame
number' as a name may well have roots that go much further back. I
only know it from the alpha architecture docs.

Google only seems to find the modern Linux use, but I wouldn't be
surprised if the alpha architects got it from some much older use (I
would suspect VMS).

> But my memory of it was it was also used as an
> index into a struct page array.

So typically, the pfn is what is used to translate different kinds of addresses.

And yes, one such translation is "turn virtual address into physical
address, then turn that into the pfn, and then use that to index the
array of 'struct page'.

Few places use the pfn itself as the primary thing, but one of those
few things is the low-level page table code. Because page table
entries are literally a combination of the pfn and various per-page
information (protection bits, cacheability, stuff like that).

So to the page table code, 'pfn' is kind of fundamental.

Example: the actual low-level "create a page table entry" is
"pfn_pte()" which takes a pfn and the protection bits.

That's the basis from which all the other page table entry functions
are based on, even if you often have wrapper helpers to hide the 'pfn'
part from users, and you might have seen mk_pte() which takes a
'struct page' and the protection bits. That one just turns the page
into a pfn and then used pfn_pte().

            Linus
