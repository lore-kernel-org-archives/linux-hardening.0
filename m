Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C78F1CD1F
	for <linux-hardening@vger.kernel.org>; Sat, 15 Mar 2025 18:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742063504; cv=none; b=IZMBNzM+J0plkENpDQVFQ/5VF6vd0h9mVdvRbdJj+PLHn9g/TVGZJxr6i7sayPKM0XZlTs79rxkbMIwmuFFZIgocb6rC4sQAzqd5pf2K4+AS/ygdrgi21e8F4iQDNXctn8Hh+1ETbBnh/maop0HZmwjVz1Ob0Qvtiey2MjhYi1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742063504; c=relaxed/simple;
	bh=XV+UOWy1S9PWbjopZNL+DwSwF3sDIJJk6cvH5cVz+Tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGrvY2l3wYwlaNReeYiYbpGMlDmxNSmnDwk81l5TNCQ7znydyN1ttxs4heSUz14Rk3KQgEHNkJKC4plnk0Cgo3HVWf0wBcOdgNBdZd4MCoKdoN7/NIENwOfp+bLCjKESXfIxiYpLpx2xVEnDGuSWvTArtO4am5cMenDTK6p+55A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QN5hk/Q7; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QN5hk/Q7"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac25313ea37so634014466b.1
        for <linux-hardening@vger.kernel.org>; Sat, 15 Mar 2025 11:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742063499; x=1742668299; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fUg4fCMuPkYhbF/nCEDejVAU0bc8GhrExOsFutZjexE=;
        b=QN5hk/Q7F/xLxXYvCQQ7FqTemmbwLQck/alW8+HCNf8RpO/63ojUIa6GrRjUD3QYD0
         SeXlBPgIPpLNexP7AwXDzTkPexGXrvaxShOuf9SaUt+e9QSYsaJq5f9aCtws4yuhEnDx
         3YK1z2crH3moVus+Mid45Fo2K/bqHCc6pWzIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742063499; x=1742668299;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fUg4fCMuPkYhbF/nCEDejVAU0bc8GhrExOsFutZjexE=;
        b=XYAq0DV2VTqJG/RgxNTpuh8zSAY7BIfSGa2RjeKLEHY+6KmoYL2L+Fy6S9q+b2U6Ub
         6bDrAz60HVo7Qk8eOhpYs1s7QWsWpglWTOcYdJXKHzK8pmY+t82nEkue1mHYbDoY7R6j
         UzqBeReGtJCROodqIeRVvb5Snqqi0YBc+SKC9jf5OMxMx8sNRG7YoGHYwiUMuALk63mm
         FS03d9CUQK3QKSO/1i+WNrkwiHKgjwgUDP9vY2r1JVeo/WJDGEa0n6NSEiJeMs38Jack
         5ye5lBF1y9ySixvsB6L8pjmFetPnYVBF/k3sDjNIG1bkAvJ5yObE0iJ+db0t+bVBGYgX
         L/BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW9V2SNqf+wqtCZhxfQkT1OwwVLrgRCwZHrz+DCy4WaL65b1QIWORbW339jgiqW3+iZGIfJXgpMFB5mKLexYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDzE88vyZLf1SlzxJhPb/dIQh1zLm9K3/2Zq136d1CGTXiS0OX
	WJCW3HUlzugTaIu0YsXMlWGcgr5wM701C92l1B/Qbt1rfq0qTcZDjmbI+IkFbdk3uIaVrJ5E/D8
	n6pM=
X-Gm-Gg: ASbGncvvSUCDgDcZg/yBlVtHJtLdYgRIB7J2Ztau7E6RRvaz+3qEhtM/MgWqbudGYtI
	23FZLXAobWIBaii+vI7ZJygZVrNr4C2ffsMoJdP8xQCyZIBBNimafqPxKHbA3FbdCozu7dAW4gT
	+bG70lb/XEws64GvDMLHY538tB/IXlMfkYjpMR+a6PKsVBaJkCbNsuePcWf8KkOwxY7fyHWE5ou
	g2gqxmDAiGqsQbegKX1Gq7Qtx6J+ArCjSWSUzA0JWHoN+6MwVV27bFEw9jhGQOnFA+Aeg1WM+o+
	3meOWOO5a+PHUJB7I1q8jep7XPOlKruVcQH8ZmcIMH/oIH5Sfx1fck9bZora19SYvl07eVEHTb2
	ZYx3ZAzFZCeJQJrO9CHRSYaUbkQg5tg==
X-Google-Smtp-Source: AGHT+IE3hYZIakOvedRogzrs4W3QjkSkuH2xQmuzoNpBOPaikj9VQzqgSfJefK8NC8xzERgkozwYIw==
X-Received: by 2002:a17:907:868c:b0:ac2:8a4:b9db with SMTP id a640c23a62f3a-ac33017726fmr854320166b.16.1742063499469;
        Sat, 15 Mar 2025 11:31:39 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a9f0b0sm407288566b.174.2025.03.15.11.31.38
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Mar 2025 11:31:38 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac289147833so556465366b.2
        for <linux-hardening@vger.kernel.org>; Sat, 15 Mar 2025 11:31:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWD6E3Ogx3vMG8KhBJg52Vc6aiurTGd7Vg5nPS2hLFk6Ekv/76MJZMMyuDM+skx895NBqIJtsYEa4rnwUILIOg=@vger.kernel.org
X-Received: by 2002:a17:907:6e8d:b0:ac3:47ad:41e8 with SMTP id
 a640c23a62f3a-ac347ad42e1mr292577866b.1.1742063497897; Sat, 15 Mar 2025
 11:31:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315025852.it.568-kees@kernel.org> <20250315031550.473587-2-kees@kernel.org>
In-Reply-To: <20250315031550.473587-2-kees@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 15 Mar 2025 08:31:21 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiFjwOk9knz8i-zAqE=Kc73+3TgkMuj-C_mNB1U=k2W7A@mail.gmail.com>
X-Gm-Features: AQ5f1JqnUqw5FSbsGnxD4hWFlYlctW64jtsJobEgwKJ2Lw8II8J0HunpM362-9I
Message-ID: <CAHk-=wiFjwOk9knz8i-zAqE=Kc73+3TgkMuj-C_mNB1U=k2W7A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] slab: Introduce kmalloc_obj() and family
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Marco Elver <elver@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>, Yafang Shao <laoar.shao@gmail.com>, 
	Tony Ambardar <tony.ambardar@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Alexander Potapenko <glider@google.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Mar 2025 at 17:15, Kees Cook <kees@kernel.org> wrote:
>
> Introduce type-aware kmalloc-family helpers to replace the common
> idioms for single, array, and flexible object allocations:
>
>         kmalloc_obj(ptr, gfp);
> [ ... ]

Honestly, I absolutely hate this.

Don't do this. It's a huge mistake.

Yes, it's a really easy and convenient interface to use.

And it's a ABSOLUTELY HORRENDOUSLY BAD interface to actually then *maintain*.

Why? Because it's simply visually and syntactically entirely wrong.
It's much much too easy to miss that there's an assignment there,
because the assignment is hidden inside that macro that visually looks
like a function call.

So when you scan the code, the data flow becomes very hard to see.

So no. A hard NAK on this. It's wrong, it's bad, and it's crap.

Maintaining code is AT LEAST as important as writing it, and arguably
much more so. And making code and data flow visually clear is
important, and this is actively detrimental to that.

So I understand why you want to do this, but no, this is absolutely
not the way to do it.

It needs at a minimum some way to make it very very visually clear
that this is an assignment to 'ptr', and honestly, I do not see how to
do that cleanly.

Alternatively, this might be acceptable if the syntax makes mistakes
much harder to do. So for example, if it wasn't just an assignment,
but also declared the 'ptr' variable, maybe it would become much safer
simply because it would make the compiler warn about mis-uses.

Using visual cues (something that makes it look like it's not a
regular function call) might also help. The traditional C way is
obviously to use ALL_CAPS() names, which is how we visually show "this
is a macro that doesn't necessarily work like the normal stuff". Some
variation of that might help the fundamental issue with your
horrendous thing.

But something very serious needs to be done before this is acceptable.
Because no, the advantage of writing

        kmalloc_obj(ptr, gfp);

instead of

        ptr = kmalloc(sizeof(*ptr), gfp);

is absolutely NOT worth the horrendous disadvantages of that
disgusting and wrong syntax. You saved a handful of characters, and
made the code faster to write, at the cost of making the result be
much worse.

My suggestion would be to look at some bigger pattern, maybe including
that declaration. To take a real example matching that kind of
pattern, we have

        struct mod_unload_taint *mod_taint;
        ...
        mod_taint = kmalloc(sizeof(*mod_taint), GFP_KERNEL);

and maybe those *two* lines could be combined into something saner like

        ALLOC(mod_taint, struct mod_unload_taint, GFP_KERNEL);

which would stand out visually (which is admittedly very different
from being "pretty" ;), and would also save you some typing because it
also gets rid of the declaration.

We allow declarations in the middle of code these days because we
needed it for the guarding macros, so this would be a new kind of
interface that dos that.

And no, I'm not married to that disgusting "ALLOC()" thing. I'm
throwing it out not as TheSOlution(tm), but as a "this interface
absolutely needs clarity and must stand out syntactically both to
humans and the compiler".

          Linus
