Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DB92110
	for <linux-hardening@vger.kernel.org>; Tue,  1 Apr 2025 00:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743467285; cv=none; b=nu7KEpYCsYdXMOQGwjVQbG6I5wMJF9nYzGgz88prWzisz4aaPjm2sAHUPhNXk9cMo6H8vO73exXgldJQ929ebaSODKxRY3bAiVz4nF4vRtDthJrj1irKciff3sHkVMqld0OtsyHEHP57imN9sk7h/9V29swABgt2d/m5Y31ZR7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743467285; c=relaxed/simple;
	bh=26+GYqb2X3NwLsu1qFcx4SuY1JzDD5ReS/TzARaJw1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLk2E6g4MQciAdJv7QDYeVE/+eiz+qrcucLZlSABrOG7Qh4zKBsb9OTUAlb4q6dW/bwLG8hm1EXSvIetPn2oqWg1VF2hFnXu5BlBSIJhC6AldIxusLH58HlqdTm4UAsXiCvaIvWxBBYa8fI/aWO4YlMA1GCJZnKFDWZA+ZAtOcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=L+CAok/M; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="L+CAok/M"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so747339466b.0
        for <linux-hardening@vger.kernel.org>; Mon, 31 Mar 2025 17:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743467281; x=1744072081; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qGbH0NonJSxr19KvUYelWs1NH940om4VboO0W8M328o=;
        b=L+CAok/M20SAOrGj3Opc3WtTqpLhqTCbptETEGA02TsHH+EHY1ADnX8vfexrBey5x6
         Q3Xh52fSziByh+eD/vSOUutWterEzdzzkJBNLitYo4ICs/+RcZLtmmXel4M07D19DBiV
         HHuknde0IQaKukg8X65XnyIIRVs/6ZqQDwAuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743467281; x=1744072081;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGbH0NonJSxr19KvUYelWs1NH940om4VboO0W8M328o=;
        b=HTzQlzIA8unVyyJc42NtHibcanjgOpfGQ0Ut/N560vM1y2xIiFuRYHDvItCxgNh9cY
         A/6UaZuihr48iwcLMhJiweuzaM0atNMo70DF/ovmMr7w3ef+oGq570nI5mXceu6AwJqM
         ZPhr5m4/v/C0ff5dD4F/GutkMDGuaRSde9SZ+GFTHhfn3Vs+y3ioeP6MutvrQ7bBQDqP
         bSVZGr0rVEkjeBUvg8Rh5JNjc6gDBR+5oV+JiSX9ndKjlPfdy0iW4BCo1ZCz9n3+2nU5
         1PAu4OEdtbGAL90dyozY1bqcsknbsb6CyZvreZ0v8szHMZlxok6+xFiHMPqAeQK4DuiD
         0RJw==
X-Forwarded-Encrypted: i=1; AJvYcCVTJlno4CDNlHftnpZV1CXlWmiQJ9BO3SLqqszgUwuIDdF/U4KxGrgJ5AsZZ0uFqX0K+f2DdhOqlagiqJoBQf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpUPaDjUr/+seK/6I9aK9TT6BiMZo29u2o9yiGJTG6CeVKKpuP
	5dolhilGuEUVMx6+Rh/dPMbPCGqFkudGxXQgqd1r3J4LGiIkNijc/ocd3kr0cu7i2Mh2u3cVHxP
	61XY=
X-Gm-Gg: ASbGncu2VFZF3qMTUsabQb5AdY4S50twVpnv0HmSnKDMt5qnkzJB5zcySPQHkCpTxgN
	tMlt+I/tVO++P7FIde8tpxYGIsxh5E/mYFyMaTRFtsGLScZOnxUE219MA886ErFwPLYoi9ZTzcH
	zJnFdwidZR57987EluS0W/d3pi6f04QGK5F6J4QRoQeKsiUGCYiUJdSH8j/VciX/2wshEE1YY6y
	FBR7zkXhbzyX/Oql4KMfWjSpKZSO1q4VzZxgWfskJrIajeuuybPPYeE/d0ohZsTHbUVot5JzIgc
	p9sc0w4pqNzdjBEuNG7bZjbMLO5C32nornaFDafJPbE5cRF4u+05PkbfKHjg6Yv9P1dQSXuXJ6V
	5ZE5S7RAk7mRTWhnRrvnefQ+rDr41zw==
X-Google-Smtp-Source: AGHT+IFVLlueuvIRA3FaFz3x1X/fGRtgqwBeZZ8gbzZfgaBFmeaaFaCaE8bSqfwBBUAjtD8iBsW0ng==
X-Received: by 2002:a17:907:d89:b0:abf:75d7:72a2 with SMTP id a640c23a62f3a-ac738be70a3mr861436666b.38.1743467281549;
        Mon, 31 Mar 2025 17:28:01 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71927b06fsm691892766b.53.2025.03.31.17.28.00
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 17:28:00 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so747337366b.0
        for <linux-hardening@vger.kernel.org>; Mon, 31 Mar 2025 17:28:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzT/i2Elf7sMPPjfvq3ZKj229VAT8pCuIkRNxTPjUtRWxy3jnOz8ItcLRpFI6dS6wxvJzTITt9jlxXJEsg7bk=@vger.kernel.org
X-Received: by 2002:a17:907:7eaa:b0:ac3:45c6:a1ec with SMTP id
 a640c23a62f3a-ac738a841a3mr1257375966b.25.1743467280043; Mon, 31 Mar 2025
 17:28:00 -0700 (PDT)
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
 <20250331194251.02a4c238@gandalf.local.home> <CAHk-=wiDQpOeXi_GjKB7Mrh93Zbd__4k+FF_vJd+-prbaacEug@mail.gmail.com>
In-Reply-To: <CAHk-=wiDQpOeXi_GjKB7Mrh93Zbd__4k+FF_vJd+-prbaacEug@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 31 Mar 2025 17:27:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjQ=ZY5K+tSF1xui3aoL2Vkzsvp8W1mQ9iVeTQ9Cnbc7Q@mail.gmail.com>
X-Gm-Features: AQ5f1Joik-SCEnqhzDRblUTUj3BDSsq66RHEyMLggTfPfjoeXEo8UparowVcV48
Message-ID: <CAHk-=wjQ=ZY5K+tSF1xui3aoL2Vkzsvp8W1mQ9iVeTQ9Cnbc7Q@mail.gmail.com>
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

On Mon, 31 Mar 2025 at 17:11, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I thought you did that already for the user mappings - don't use you
> remap_pfn_range()?
>
> That's basically the equivalent of vmap_page_range() - you're mapping
> a whole range based on physical addresses, not mapping individual
> pages.

Btw, if you are wondering why this isn't consistent: for user space
mapping 'remap_pfn_range()' takes a starting physical 'pfn' and a
size, while for kernel space 'vmap_page_range()' takes a 'phys_addr_t'
and a size, then I have no answers for you.

Except just "random historical accidents".

There are a lot more "map into user space" cases, and it's the much
more common case, and it's the one that a lot of drivers have used for
a long time.

The 'vmap' code in contrast really started out as just "vmalloc()"
which allocated the pages while mapping and "ioremap()" which mapped
in IO areas into kernel virtual memory.

And then the interface has very occasionally gotten updated over the
years and we *have* had some unification, but it's been driven not by
"let's make this a kernel version of user mappings", but by "random
odd use cases".

You can see this just in the statistics: remap_pfn_range() has hundreds of uses.

In contrast, vmap_page_range() has something like five uses - when you
grep for it, half of the hits for it are in the mm/vmalloc.c
implementation and the header file declaration).

So I do think vmap_page_range() is the right thing to do here, but it
is *so* rare that maybe it has issues. There simply generally isn't
any reason to map contiguous pages into kernel space.

The *typical* use for kernel virtual mappings is either

 (a) turn physically discontiguous allocations into a contiguous
virtual mapping (ie "vmalloc" like things, sometimes with
pre-allocated arrays of pages)

or

 (b) map device pages into kernel space (ie "ioremap()" kinds of things)

so vmap_page_range() is kind of an odd and unusual duck, which is why
people may not be all that aware of it.

And being an odd and unusual duck might mean it has bugs, but the good
news is that "vmap_page_range()" is actually the underlying
implementation of "ioremap()", so it *does* actually get tested that
way.

           Linus
