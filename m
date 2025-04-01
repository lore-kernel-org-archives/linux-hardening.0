Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EA02AF04
	for <linux-hardening@vger.kernel.org>; Tue,  1 Apr 2025 01:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743471058; cv=none; b=i23wji7wMgHIjBemAIjZLPw0uF4dFd0yaSsg6G0gH5ObayKvNHUpvA+Fjzb8jkTxjHjMrRTKaVhqgBrim4UcfQolLqZKOignkgnGhaR0X1L2we1MKcmWUMI/mfq5yekf+kotnurTTIDOraBJMJEHc2jaFZOU03f49o2DbUNvBY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743471058; c=relaxed/simple;
	bh=ZrZnWSEQfOVCXfCXId9BoQTQz62E8du+T3QQHmnRCcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T17ypJbgCYazbZ8ZY1LTVmMqtINdcd8h9IFZtylhtOk9/pFMc6oe3ivR7fqrzzGWVaUmsJ+1w7tugnKU7Eiwbj/a//8z1xa12UMepEvjBO2+U2hpBWHYW+UnHFM7fA0LGtmZ+TJN0KeeDBDksnS7AlwBAAqrOmr70lGjJNmCchU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WL4CmDdl; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WL4CmDdl"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5b6f3025dso7929498a12.1
        for <linux-hardening@vger.kernel.org>; Mon, 31 Mar 2025 18:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743471054; x=1744075854; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hobhqw8HB8gJ+OpvQWZBbfhBUu6vl3N3/WGeelA1Yck=;
        b=WL4CmDdlDcDtCKLbiVCMl/1JZEx4yMt0lB0NMdcMEilcfoyL6obtPBp6WVnVtLb+ft
         7fcYlL2uOkqBG1I8UFqSJcJLjNdhWiLx7qoLaJWwU/RvgQINW2BvtCizbjEsXgasoOUQ
         N67H6EjDqqirOYzHOipjvlDm4d/YfVP24rfpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743471054; x=1744075854;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hobhqw8HB8gJ+OpvQWZBbfhBUu6vl3N3/WGeelA1Yck=;
        b=JGdIyH+h5/5vCa7WGWWkEWVcnIZmOQrIxM+LDqguX3oXX8lxH/lG3psSkHtMzTv5Qj
         yfF9fn6Glb/oZSYg1tCSfQEPBT+JS7fzJNQKCEDybKus/ywcQ6MAHGYgBC71XxBQJWn3
         8WYHG0xMWlHa0BeLqFWLQ/qdKYEu1lipIpBRI+HLmj2ev6kCcXP+PQsJdTX+sl5E5OLu
         Lq412rOdza6yEJFJNyq8diTj31c3jubCd7LW5pnkpeV9J+cEhA3zo04uvXM60m/e28ZI
         X9+pqarInhbuKvOQP8rLkl1nSx3UwWplCamfWPOxsfh3Qi3LGhKNfEHj47wJ31zsIaLX
         8Jjg==
X-Forwarded-Encrypted: i=1; AJvYcCXpFuOIVTZcDHJuKd7l6k1a3k5qR7zAX3PTE1Q/gHWTOM1yMLtLhIffGt8KCPsl/Bm6zj6VZ5F/kk+yOO+d8VA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIf8pKZ3bMhB5n4fTRdlBsI42hxVsi1yOrpnKH0ebMTwNmA+FN
	zxLalv6n5G/kGMA2hiEYxMJBegTkQD6VTR46Gq6HkHX+GsBQ92L8BPyjQmSSg/mfuRsDXRLnY5A
	Miqs=
X-Gm-Gg: ASbGncs51OXmKA7CzT5NA26L/evvxF1agHlsTskj0WhGw5Jc+FNFXeiE0kfUf1eJB0L
	rt5CnRpVGL0khKKq1PkCJDL5dHjWNzKA8mToa6A8nu3SciB5xY/kdSNQDqMXHRAqiKxEamraCqt
	kpiq5KlRVCUpwqPh77Q0Ki8D/DG7AkQj9x/pn7Ww6CFTOelsg8VdEV2Hyza+kaj8nVsb60FiMbt
	OPseAj+I6c7MFiYJzH7eFi773tFg2CYkkKU18wFKnYvoCVncZOphBYto0E+InsdLF/2YbU4wn5O
	TSxZ6F39WO5sYwbfsF9kcnnYA4eczuKdTLlckl9AZLoFCVBS4Ok+RiuyTqUtEs3EEQaJzXKcZgN
	EtmVF2pwuKSMJQ4yqPXx73Hf92v7QRg==
X-Google-Smtp-Source: AGHT+IHSh1RhkNyZabwXtTq0zf4QDcQq1DQiKOUhPFE3kEhxsTmzp9n32Rvqfd5g4vFjDPNQVKZ4JQ==
X-Received: by 2002:a05:6402:35cf:b0:5e5:d91c:4151 with SMTP id 4fb4d7f45d1cf-5edfd0fd67emr9757531a12.16.1743471054383;
        Mon, 31 Mar 2025 18:30:54 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc17dff0bsm6329873a12.70.2025.03.31.18.30.50
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 18:30:51 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac345bd8e13so853042966b.0
        for <linux-hardening@vger.kernel.org>; Mon, 31 Mar 2025 18:30:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvBPsF712/sVt4nJqXTs54Ih0DRxvO6j89ecKRD/bkGIWH8Xkv531L3aAkdRKrAVAo60iJu055HJdeEcou3JU=@vger.kernel.org
X-Received: by 2002:a17:906:94e:b0:ac7:7e2c:68e9 with SMTP id
 a640c23a62f3a-ac77e2c72ecmr169045266b.25.1743471050531; Mon, 31 Mar 2025
 18:30:50 -0700 (PDT)
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
 <20250331210245.585fff23@gandalf.local.home>
In-Reply-To: <20250331210245.585fff23@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 31 Mar 2025 18:30:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=GNaLzNt5zjee6m9OHNvr=Sc1S-xsnS0cNMfdVp15hg@mail.gmail.com>
X-Gm-Features: AQ5f1JqTHDgiJbxdZ1rnfePfFiTU7-9XsI1CRh3n0IspxIqnhuyKNGYHhQ9hJTY
Message-ID: <CAHk-=wi=GNaLzNt5zjee6m9OHNvr=Sc1S-xsnS0cNMfdVp15hg@mail.gmail.com>
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

On Mon, 31 Mar 2025 at 18:01, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Note, I believe that Linus brought up the issue that because this physical
> memory is not currently part of the memory allocator (it's not aware of it
> yet), that the getting struct page or a "pfn" for it may not be reliable.

'pfn' is always reliable.

The pfn ('page frame number') is literally just the physical address
expressed in 'page units', ie just shifted down by the page shift.

So pfn and phys_addr_t are interchangeable when it comes to mapping
pages. The pfn is in fact often the preferred form, because on 32-bit
architectures a pfn is 32-bit, but a phys_addr_t is often 64-bit and
generates extra code.

I think 'pfn' was introduced as a name ong long ago because it was
what the alpha architecture used in the VM documentation. It probably
predates that too, but it's where I got it from, iirc.

              Linus
