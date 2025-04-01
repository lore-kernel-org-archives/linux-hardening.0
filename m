Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D08317E
	for <linux-hardening@vger.kernel.org>; Tue,  1 Apr 2025 00:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743466190; cv=none; b=iOXPJCeG72IeiIn/f54qB3y7wIaY1gqKcbSd5WBJFrheDLV5RwYE0jFtvV0LaPfX2ZmQHu17kYXCa1Pv8C5eOuOOe6EfTYNN2NGC7+LItdzBBUbBrVSMSbnnUXUcIlVJZgsGsBx9il65oCtxElTB5eh9lzOkTXkmhMc3JedUn+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743466190; c=relaxed/simple;
	bh=wPyTGkQawqkLpSGDotx6rkJZMEfb8YqJiwVvYcCr+/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HwD0VKDTWTBiJLTD5ztMVIO4xS0NzhM8xz+m/5wFFsT7gJ3ha4Hh1VMNceTLCU8ImqdO3+v5RLOvk2OAg/1wPgH0BwNqmerTlo5SAHksfj7l5Rmr59Q07roTBcqqDL+OPa1XJXsJ1B7pcE/pxCwHLXpuHOUDE6kiTLzMyjrpRWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YhhWFXwX; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YhhWFXwX"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ee2e154a35so4794a12.0
        for <linux-hardening@vger.kernel.org>; Mon, 31 Mar 2025 17:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743466187; x=1744070987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPyTGkQawqkLpSGDotx6rkJZMEfb8YqJiwVvYcCr+/s=;
        b=YhhWFXwXynF1qnSL0ZuSa8MR11ZMGiVuAeifVtUefoe2Y6+3t2DiEuIBcVQP2Oged/
         kSHU8rB+9glccoMHwvWnAy1jDvYBK38OlCAUU/o9gX9Fp5/b/ptZrB+BcSeQNDl/A3A8
         h5Bk6OI8vyCZ2vA0JyfxAiEBbXiig65To8M9LyvsKhsvEwspPBzLCg/Gqk8DT+o845b6
         WxfuQ0cQRGQdrJuiAhx7D+lvrSO/9Vm8+xaXUnUUDJ1ibPy7YXP0CvpXaCCHsGBKcgG9
         9jUzOqxqTvp3tLi0W7RZipDnd4oOkzil4eECNvkxL6FPugJuNul9P3jcQ7YtWjv9HYeJ
         kcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743466187; x=1744070987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPyTGkQawqkLpSGDotx6rkJZMEfb8YqJiwVvYcCr+/s=;
        b=l/x34e83nXeK1G2havzgu9FtYYs3CBXC1qInIndy/65YsBUmuMr1hGTQGEyZxOCF/E
         rZT2bRiOqQUhl/qJtZWUz1fPd84bpR+xtKI2pK24+mrWPJ3tPQSWsC6Qfm0WXqhm/CLb
         H3advUmhtOUOLSoRrLhJgNCXmLXbryzC9FfRCbOTR/r3Y9OtNXfiLcc5+C8knaORFLi0
         kEa/q8KKti1fAyvXax+7QvXs5Ht76XRBIdxS5/22XFUWWkq15WKblG3CTiTXQZlTMnAA
         vZjvTGkF5igVdRiahJZXiY8J9S8l6rsCJU8PYvB0O5Sg8R2ANA1cu8DWnm4R/VlcJHJN
         C7GA==
X-Forwarded-Encrypted: i=1; AJvYcCWLT7iTPIL0FCvGl+mp/GifOJ0QPiCEeexu3D8c7frP0ryb0+JcC+y5kDGtLsdZ1G384qmirkpheXPs1KUGVnE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz5ZwdGQwtay+oNPOgoKqWp+Qg8qYHDsvkhk2m0gQU5T00G59x
	K2Ln+MOM2o82qot3vi1J+l09qHAS9HfGpxZjwP+9VcLdR1WUJEk0LXxt0tqzyDStQJ9Lo6iznte
	kvU9wz15HgKfw3uNmbd0tTnTq46h5sNt9bcc7
X-Gm-Gg: ASbGnct4wPz4N+VAGqd1J1OfYerbdltrU7ZPHIwTM7UiyTSt2DsheliofnQw8BMkreQ
	syPUUofNGcUhU453n0feR1S2BWk47r6sxisG3KaZDB5URgHjGj9s+QPOjkI4v+J4Hu7/KUVaKVH
	Rv6b4jfLSUxCHtGj6q8Dt3NkYBm5IhZ44HW9TO4APJpM8qb84wSgRIVyq1enUkwlz3
X-Google-Smtp-Source: AGHT+IGEfc/o4rZDLBV4UTZfPGbmzzxGSYaiV1F5ZnIE+a4cQJYdyPrPGUXjOZRNCUEGgEhZf27v3IolyxOGkRjFV7A=
X-Received: by 2002:a50:d692:0:b0:5dc:5ae8:7e1 with SMTP id
 4fb4d7f45d1cf-5f02b1fda43mr53204a12.6.1743466186566; Mon, 31 Mar 2025
 17:09:46 -0700 (PDT)
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
From: Jann Horn <jannh@google.com>
Date: Tue, 1 Apr 2025 02:09:10 +0200
X-Gm-Features: AQ5f1JpUrW2lj0TfrSE6BTXIbjBh2EGzMdTMoZ84opNiVKnrWGQgwOyns_oePeU
Message-ID: <CAG48ez3w0my4Rwttbc5tEbNsme6tc0mrSN95thjXUFaJ3aQ6SA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code do
 the vmap of physical memory
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	linux-hardening@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 1:41=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
> On Mon, 31 Mar 2025 14:42:38 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > .. and *after* you've given it back to the memory allocator, and it
> > gets allocated using the page allocators, at that point ahead and use
> > 'struct page' as much as you want.
> >
> > Before that, don't. Even if it might work. Because you didn't allocate
> > it as a struct page, and for all you know it might be treated as a
> > different hotplug memory zone or whatever when given back.
>
> Hmm, so if we need to map this memory to user space memory, then I can't
> use the method from this patch series, if I have to avoid struct page.
>
> Should I then be using vm_iomap_memory() passing in the physical address?

For mapping random physical memory ranges into userspace, we have
helpers like remap_pfn_range() (the easy option, for use in an mmap
handler, in case you want to want to map one contiguous physical
region into userspace) and vmf_insert_pfn() (for use in a page fault
handler, in case you want to map random physical pages into userspace
on demand).

> As for architectures that do not have user/kernel data cache coherency, h=
ow
> does one flush the page when there's an update on the kernel side so that
> the user side doesn't see stale data?

flush_kernel_vmap_range() (and invalidate_kernel_vmap_range() for the
other direction) might be what you want... I found those by going
backwards from an arch-specific cache-flushing implementation.

> As the code currently uses flush_dcache_folio(), I'm guessing there's an
> easy way to create a folio that points to physical memory that's not part
> of the memory allocator?

Creating your own folio structs sounds like a bad idea; folio structs
are supposed to be in specific kernel memory regions. For example,
conversions from folio* to physical address can involve pointer
arithmetic on the folio*, or they can involve reading members of the
pointed-to folio.
