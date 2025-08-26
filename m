Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A6C286881
	for <linux-hardening@vger.kernel.org>; Tue, 26 Aug 2025 10:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756205458; cv=none; b=mBt6IkWtYI5rE0OqWAMEgCnDc+HjUkS5punHkWujYQ4nCMhwZRenrLdBtgRth/qUAz30vJgmbostE0nBrbugZRtz2+ArnfORGs3OkfzD6zHwBNj1bVSFvGaTL+yly6n3RI7cU2j6mvhKMuWxLZwNgyoiYa07kvW3YxuzdzNwTA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756205458; c=relaxed/simple;
	bh=LBKQHJXt7k5q/EQimxKbRfxnkhOmIaY3I8CzQ5DxlNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6y2BRZsM40qcNYWrlnPT5ceeZm0UFRiwuOdReq5zazH9dKseB2lRv7/fbBM/X5gTGbNWT4O/h1JpF3MwQvMgI5EN4f4x365iPdQZ8LGmJTfZkHxC9jKgBgNeWgtU4hU4E8cN00zYL708EKvx0YwTgWdvgVjpxTM/2La1oiXmHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DT3cQ/a/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DT3cQ/a/"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24457f581aeso40986045ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 26 Aug 2025 03:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756205456; x=1756810256; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LBKQHJXt7k5q/EQimxKbRfxnkhOmIaY3I8CzQ5DxlNs=;
        b=DT3cQ/a/uuuC3xUcZQ3Z+xwz1x50T5fnE6KZJ2JuZwyi1hINdMnrKtKMbJM7t/bm0w
         US69ZKvUC4S4Ce5Se0/BFllzOCpr0jHDsQU+GHdyZMuL/RtzXVeer0ixAXBQjFjL4577
         htrFfewxgC5Bt/gYWYPX0NI81Ft3JmSRV0frNldNxKrZ5tPyD4Lu5MDDAlyLb2H2gsml
         j+ZAaj1FIqN3mgAmaBkrhJc1NzWXVD1MtgfLTZjKSUkpUV5DaDbcQxmJHfpwV03r2kaR
         q5yESMXdiE+B0uYki15AUGlsjZiCc2A8UsiSVhGw2KfJS/ufahxExHAztKL3L+GFEJTw
         qGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756205456; x=1756810256;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LBKQHJXt7k5q/EQimxKbRfxnkhOmIaY3I8CzQ5DxlNs=;
        b=VeTNxBjjwWvgeKvRZHbW7YRaKRnpNh2LrO4c6goIU0q1ssXp1GNfVfqLpuC0nLzVWd
         ehoGvYUd+C3QwFiLj9qK3TcVhwdgWHFAqbXYiLn2z27XFqd11UgXE6lRf52272GpnDZs
         0o8xnHgRPNjFS1Gg2d0NgUZdfHLMw1uePiHoJwTZXaQ13gDaxXpYWIqCL2k/N61cNz1P
         UvU93DRBZHBRGXlJjgu6rFQjfsV24wl2Bru0j5RdzbgI56kwnpFo72kjEuUqjE944Y/8
         5L5VWwf7oOvsAR8FW2XeOfIAVgK3GMdIwJmHkaIg0x3WOpoz++szMP+2Rc4ZZ7ygwCHA
         LNRw==
X-Forwarded-Encrypted: i=1; AJvYcCVpQkVU8kREauqU5hjiEVf7P5gkjb5fRuYmNNxPkiH137lC+wukZUxHKVoB+BPFuWL5cYPoEg1FuegUxN7HppM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl7XrcmTqlia1X19H1bfS21eYFmEqGuyKGkbI3rw45fh9hRFSy
	MWzMhBKKz7iADNr0a+jIVWUvAlP5ZSTrQzl9iabQepH9N+vnO4JfUBCcWHehCYchnrHP1RcObPH
	vu5HFzH1s1Ks+f4xqp/xMc+fCQJFHwkip2OjEZZoz
X-Gm-Gg: ASbGnctC80T/bijcmKapL8tFu/+Gr/qZGn2+Bni2AblvQc3jacyiP4AopugfHV8oCI+
	HShoHv8rmDGGMH+2zqeS5ZwxYPMLPMqWaHM9ysh1zhL5SvUp9GM5pOx+OzmazL5BXoth7cgwXh0
	ny5Mzd52mPZ8ZoS9lLRfFSZxySjPIu9N0JS6LhXqKHSm8g0lOYZa94NO6otRCIfSgogvyEWjo8p
	9d71rFikD125gt6eb+bZEvT29c=
X-Google-Smtp-Source: AGHT+IHf6qim9cZNDk1kCo2rmmsC3LEblFH6JZzN5wGzcAVCxtsbcMX6nHM5LML7vHzagExj5m6bdqA2j2JdFPNAzSw=
X-Received: by 2002:a17:903:40d1:b0:246:d00b:4ae3 with SMTP id
 d9443c01a7336-246d00b549dmr76053385ad.61.1756205455660; Tue, 26 Aug 2025
 03:50:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825154505.1558444-1-elver@google.com> <0DC67CE5-6006-4949-A81D-882DBDF4DAC4@kernel.org>
In-Reply-To: <0DC67CE5-6006-4949-A81D-882DBDF4DAC4@kernel.org>
From: Marco Elver <elver@google.com>
Date: Tue, 26 Aug 2025 12:50:18 +0200
X-Gm-Features: Ac12FXy7R8YoW-2EpRHczPhHZJ0RjV4YJMdaLPQVeIhDdwxbJBGrafjAEUd74Ec
Message-ID: <CANpmjNMpnyQ=PhZ4jkSiAR7gg8WJOiunoxwhRWuUD1U_EEnyrw@mail.gmail.com>
Subject: Re: [PATCH RFC] slab: support for compiler-assisted type-based slab
 cache partitioning
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Alexander Potapenko <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrey Konovalov <andreyknvl@gmail.com>, David Hildenbrand <david@redhat.com>, 
	David Rientjes <rientjes@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Florent Revest <revest@google.com>, GONG Ruiqi <gongruiqi@huaweicloud.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Jann Horn <jannh@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Matteo Rizzo <matteorizzo@google.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-hardening@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Aug 2025 at 22:18, Kees Cook <kees@kernel.org> wrote:
> On August 25, 2025 11:44:40 AM EDT, Marco Elver <elver@google.com> wrote:
> >Additionally, when I compile my kernel with -Rpass=alloc-token, which
> >provides diagnostics where (after dead-code elimination) type inference
> >failed, I see 966 allocation sites where the compiler failed to identify
> >a type. Some initial review confirms these are mostly variable sized
> >buffers, but also include structs with trailing flexible length arrays
> >(the latter could be recognized by the compiler by teaching it to look
> >more deeply into complex expressions such as those generated by
> >struct_size).
>
> Can the type be extracted from an AST analysis of the lhs?
>
> struct foo *p = kmalloc(bytes, gfp);
>
> Doesn't tell us much from "bytes", but typeof(*p) does...

Certainly possible. It currently looks for explicit casts if it can't
figure out from malloc args, but is not yet able to deal with implicit
casts like that. But it's fixable - on the TODO list, and should
improve coverage even more.
