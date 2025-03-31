Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D431DE2C6
	for <linux-hardening@vger.kernel.org>; Mon, 31 Mar 2025 21:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743457386; cv=none; b=mjAybvQwxF/JMh51zW09VorEn7QMArBLEmVLglpu1I3fEoAQ12bVlfmTM/E9jgw34xKizDXt7D46xDnQAV8X/1bNPsL9Z29Wn9UDMjMTvi7CdxJMCGU4KgVIJZVn+bnp6xReN+UeoClArkrgKluKY6l0uJHPaKdFfxKlO5KYe7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743457386; c=relaxed/simple;
	bh=Lm23pDBVwGuHLb5lixyGc1iJK3RuhTeNRxc+ez3eQY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvNcas0Lxtylne3uh7AmvaxUKa1BbB/gCeNHDp4FjXu/vHCREgKHddHnJnBKN3wYmXFbanqYXvn29Pm+Qqf0855Aoh0EcKSauk6YXt3LU6ovoPr74T9IfOqGu15KOI30vJJg3LghM0qZWc7y/aGK32Jy3GngNhpixKW6ZciCxkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JNfrLn1X; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JNfrLn1X"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abec8b750ebso767216766b.0
        for <linux-hardening@vger.kernel.org>; Mon, 31 Mar 2025 14:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743457378; x=1744062178; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MPuGyIJoDDjA0SSObIP3jFx1wV25IQcopdyUBR+aHdQ=;
        b=JNfrLn1XCoU3dhpPfA+Bhmur9TFQ0wq7wUbzimm87DvVZh9zjIr9NF86erd6Q6Ce1C
         ekRpgzgAnsrH9GGpfvHTSJJaM0pkVbNfig3OHz4k/Umi+3Mi2YoJ54d/E723yOPW6fg4
         kGceShGTmQIg35iWTufKe8InPlSra53oaOuA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743457378; x=1744062178;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPuGyIJoDDjA0SSObIP3jFx1wV25IQcopdyUBR+aHdQ=;
        b=hL0taoNnI8oBpTlm4O+jcgPreL5sSkKQzwZMCZ2JUZ82Yhhz0k01UeoI2z0rbSfLvI
         y7ucLNfJzLB+kQ/7JrTa1musmIm7xIJQYABHXDZVedg9F0RTBCcfpEoXBCNOeeEpu5ST
         uUK81RLupkHPqvAsK2vz0+5oQk0Ooe9VqAxyhJtdfrHJswdTJspIlTWTyLJLAIseQBfA
         WRH7euspH6tM87HtQZ4RyeP0ph8qRMVVS3Hfmoi88jdeb14YmO0lTzi7Exh7n2CUj/Dr
         AhsmPa5AqMOtUCyOmAaY54hC4aZs5xbdbaXdhgA5DaA2BKn12WWtLkW0idxgS52+0nui
         d+OA==
X-Forwarded-Encrypted: i=1; AJvYcCXqvYwjYDzya31+BlnAwhBevj1j8TNWevGGGHhyqY8Txr/qR1AoU7bhRWHs+cfjHFr6CCWJS15RkWce6eDZBVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywasf/sFh1PQzn9paNn/2Ao+9IckbJq6ndmfqpoPPQKj6E3uqk3
	ezZIuoMwk1SdmhRzyoYgkDhuT/gC8MPExC8iiML5HK2DjuW7kffHyQ7FQ9DIg8XyWYZPhyYekfA
	+C8Y=
X-Gm-Gg: ASbGncsOXQXAb3GOn/TpA90mcZ2tY1jr6HZkXrdYe2UCenOk2Mczholo/+vsftiwr5u
	BzVDb+EYKbnf8CJMA+nt2+4jT29LDHtP+9TDwfGFRstrUtRB9JFfcf7FMkHiBxpJxOcikj26bsS
	Phu4vWpKXXih8QKNbkicwlb/lcOSdzazWD3DlRf2yS9ZuXhlHFpJPHrZdiliR+PlTLq3B8TVGqW
	VZEfoGA+Xr8qmCZz8BLOsZ3GCy4qSvVDUV+BcJZm5rUa6/QVwz4HTmqUauPfMPZl5Pjkqi3NW3m
	6QwIumx203Eag4bhcc4qgPgP56Irw0+BwgL7BuUGdbW3e4L9QE3jl08JV7UKTK0aei4nMfvltn9
	B599XQchlbheuugU562w=
X-Google-Smtp-Source: AGHT+IG+gwDBMUE41INT8TZsy6D42+O+gzzhwQQf2P2jhA2tZNzIzZMh4BXil6ooHH4JaIr3YPM0EQ==
X-Received: by 2002:a17:907:2ce3:b0:ac3:2d47:f6af with SMTP id a640c23a62f3a-ac7389fbfcfmr958504166b.20.1743457378627;
        Mon, 31 Mar 2025 14:42:58 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7192ea229sm671544266b.81.2025.03.31.14.42.55
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 14:42:57 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so994869966b.1
        for <linux-hardening@vger.kernel.org>; Mon, 31 Mar 2025 14:42:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXnO6R8PtX4NSLixuRlv7dB75uhyQ9bNOCE+kNaqs2nEgtXRdaPz3fPFQtSuIpP/wdnq2c4M4AtBbqzx7cMXmg=@vger.kernel.org
X-Received: by 2002:a17:906:c113:b0:ac3:8988:deda with SMTP id
 a640c23a62f3a-ac738be3371mr773843566b.40.1743457375081; Mon, 31 Mar 2025
 14:42:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331143426.947281958@goodmis.org> <20250331143532.459810712@goodmis.org>
 <CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com>
 <20250331133906.48e115f5@gandalf.local.home> <CAHk-=wi5pLoe3szxLREQGGJuWU0w_POK9Sv6717UH3b7OvvfjQ@mail.gmail.com>
 <20250331165801.715aba48@gandalf.local.home>
In-Reply-To: <20250331165801.715aba48@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 31 Mar 2025 14:42:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=whRNxdkLC6Z91g-_RbrRsUo6K6+nvRWqccjsOycwUe_JQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jr_8h8f6PhcZPJ4rHbzRksFJUiGmqKEAvAP7bvcH_lEJ4Zf6XawSyFboTU
Message-ID: <CAHk-=whRNxdkLC6Z91g-_RbrRsUo6K6+nvRWqccjsOycwUe_JQ@mail.gmail.com>
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

On Mon, 31 Mar 2025 at 13:57, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Note, this only works with RAM.

That's not the issue, actually.

The issue is whether there's a 'struct page'. And "being RAM" does not
mean that a struct page exists.

For example, using "mem=" on the kernel command line will literally
limit the amount of RAM the kernel will use, and in doing so will
limit the page allocations too.

IOW, all of these kernel command line things are *subtle*.

Don't mis-use them by then making assumptions about how they work
today (or how they will work tomorrow).

> I guess you mean E820.

Yes. Thankfully it's been years since I had to use the BIOS
interfaces, so I no longer remember the exact line noise numbers...

> Mike can correct me if I'm wrong, but the memory that was stolen was actual
> memory returned by the system (E820 in x86). It reserves the memory before
> the memory allocation reserves this memory. So what reserve_mem returns is
> valid memory that can be used by memory allocator, but is currently just
> "reserved" which means it wants to prevent the allocator from using it.

That may indeed be true of reserve_mem.

That doesn't make it any better to then use it for 'struct page' when
the MM layer has explicitly been told to ignore it.

Particularly since my first reaction wasn't from "that's wrong", but
from "that's stupid". Generating that temporary array of pages is just
bogus overhead.

> In fact, if you do pull my v2[*] pull request of the ring buffer code (that
> removes this user space mapping of the persistent ring buffer logic) it
> actually adds the ability to free the memory and add it back into the memory
> allocator.

.. and *after* you've given it back to the memory allocator, and it
gets allocated using the page allocators, at that point ahead and use
'struct page' as much as you want.

Before that, don't. Even if it might work. Because you didn't allocate
it as a struct page, and for all you know it might be treated as a
different hotplug memory zone or whatever when given back.

               Linus
