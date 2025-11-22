Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A36427C84B
	for <linux-hardening@vger.kernel.org>; Sat, 22 Nov 2025 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763841723; cv=none; b=E8T2/bgwGe723vQDcZehR74i70oY32aYoNlYJHiXo1ltIoY8h5CacE5v5PpQgTixRNpy5PK/D7jXgi5AHhvnN7ASvbWDDtPYPzjy1H0f4B8a8OTDsfh7U8i9kSACfVvlCUgb+8HV0tM92ke3ONV/8N1+XNJYXgkAAqqY0Ol8P9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763841723; c=relaxed/simple;
	bh=Kj+BG0xdKGqNhRUvh68tbMkfYejpZnIN0MW2Q/oBVMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q51xfosDXs2oaUM8aL8PTumPdmiuGCGtXn98wL3Vd5WAGxqhQXuZAlEIwXZ5ZEoAz98J4Ar0h1Cfsd3Q94Km7oY1bvVHxGy5b4P7Rx3B+rJEiQpW8tDb5w3V/O84UjBbkVXOuATiWVyFhEFkReZCV1U8kaQs2yd04TGxDUZh2mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ko9vQFZA; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ko9vQFZA"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b73875aa527so487176166b.3
        for <linux-hardening@vger.kernel.org>; Sat, 22 Nov 2025 12:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1763841718; x=1764446518; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V8N0HudTgWpU/ayUVIeNFnWWwreLw332W8BlQTA6nQs=;
        b=Ko9vQFZAwQU5PHQXMaLIlc6bUNXqSDtPWFIprALBS1QLHfUZeV4w5JQ16bKnkKvYd0
         PrFVqEE0FwCSWpR9fljuhriwBD92uWQF733ihcUsK2d8E4tdupwbPj7j5SZ72Ko1k33x
         jSrSbBFmc/NtMJMOGJFMDnV1zCPL7muEWH0LY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763841718; x=1764446518;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8N0HudTgWpU/ayUVIeNFnWWwreLw332W8BlQTA6nQs=;
        b=mWWH+TnYeItxTSkhH2WxbkrV+tbOFtENkhL66mak24SJF5wI6rNoA3H5xTaJ0qQH4s
         i0PWHfL6p4E+NKozpPuPutALwKwkYKdEN805dUzDj4e3eZPp0vQUBOkdzeqQnPgm9gD8
         3+LQwDuMS2IXjdvj24JvN9UKjPaw16G2XMDGrffnHPwjc5dQXHg1uAvgfh6Ae6FrOpzX
         hWLrKve7E4qPRdede3yW/NkaAoe9w06vNW2BXo/+eHcwsNcsOX01Ui8cPF6W/dc7IW2p
         kuLwUys7Vc+YYqUuyaIgfK7aj/SUWldVRIJeuEwJCmL3RvaOy5ztx5azmnpV8QEobNKK
         vUdw==
X-Forwarded-Encrypted: i=1; AJvYcCXwhJx48ac1XfZBV0AsWgitM3XREcNLVsHZUF/0CKIpCtL3AnObSbc7tMJY+WGo0eK2kFnfu5BD6z1mKIO77Ok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5hKE5kYxzdypwiUJMEFjlWC1DkdWJA2R7+k3u/NUqlLb0bh85
	8KPGZwj9sZpu3Ql3VW+LtjtN448h4AaDs6sZC+H0xFGCo5ixf6FNiPnPdRKwX5cChgZTtZESY/2
	NpSW95ZP3vQ==
X-Gm-Gg: ASbGncsabS6mSDMa9SdkUHxNUcFVcjawqK2NtJU6vYNm+aE2yEjvBIxOScj5Q/ClAMI
	V08HLbfeZ1sZ57KSFTVRKmfSE8uxkd3oUnBI+V3bQD1Rl4T9VVCdHpEg2/E/uIctXr1I9E0QIPN
	Zb5/+kuQAOyVg4okJhkvqubQebSe6qWCvfZxKE2TwoheWM3pfCQFGv8xptMWJObP7dddEpfN+mu
	aczmPQq8iAKuVjwiLTQH26a6AxoWv9AItui4oGEhgpWlJ9me2am8z0c+PisudoVwRhGyf2xzjeO
	ry0+uUXeMKsbrkMBA6MaFK/fejBYiVczvTWjgj2gsxLxRoHhM5c7Bs8MlzmABWlEWjOBvOxBR6a
	K/AyC1ElIFLIykz1GXGnDbaDlIdU0QgRFc8Z6Ld6NXzZPjp+RQ01dUV5PQQfIWcJOGGvNgV58/2
	m5eIEXXv8/gxxqdUc+HqfNTlQE4hz8/QIykvXBJpReoU/50F7cMU8WYhCylAgj0QEiUp4oKFo=
X-Google-Smtp-Source: AGHT+IFh0NAjSmLIjO7y4Q56A3pKSVmgkE+iza9m9K2LD9b+WaaWm2IinPUKCNx8X5lrJj/kYdRtBQ==
X-Received: by 2002:a17:907:7287:b0:b73:8cea:62bb with SMTP id a640c23a62f3a-b767170cceamr743371466b.31.1763841718174;
        Sat, 22 Nov 2025 12:01:58 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d3bf64sm792125566b.16.2025.11.22.12.01.57
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Nov 2025 12:01:57 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4779d47be12so24332855e9.2
        for <linux-hardening@vger.kernel.org>; Sat, 22 Nov 2025 12:01:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZxUD+hJKsPk4HQG+CNZoWcKibw7jSFFNbhu7rS2DLP3And4YUgjqlXug5ua2Z9J1/DjsuY9id0S4NnV+vJgE=@vger.kernel.org
X-Received: by 2002:a17:906:dc89:b0:b72:a899:168d with SMTP id
 a640c23a62f3a-b767159ef70mr722565666b.13.1763841229122; Sat, 22 Nov 2025
 11:53:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122014258.do.018-kees@kernel.org> <20251122014304.3417954-2-kees@kernel.org>
In-Reply-To: <20251122014304.3417954-2-kees@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 22 Nov 2025 11:53:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiNnECns4B3qxRsCykkHwzovT+3wG738fUhq5E+3Lxxbg@mail.gmail.com>
X-Gm-Features: AWmQ_bmh5uuI5AnMmiOZjFdonQtxoafj9Bhk7ARyKlTTPm6tMsrXbFYBvPbdku8
Message-ID: <CAHk-=wiNnECns4B3qxRsCykkHwzovT+3wG738fUhq5E+3Lxxbg@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] slab: Introduce kmalloc_obj() and family
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Marco Elver <elver@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org, 
	Randy Dunlap <rdunlap@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Vegard Nossum <vegard.nossum@oracle.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>, Yafang Shao <laoar.shao@gmail.com>, 
	Tony Ambardar <tony.ambardar@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Alexander Potapenko <glider@google.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Honestly, I hate this.

In particular, I intensely dislike that horrendous 'SIZE' parameter to
those helper macros, and this just needs to die.

The argument for that horror is also just silly:

On Fri, 21 Nov 2025 at 17:43, Kees Cook <kees@kernel.org> wrote:
>
> These each return the newly allocated pointer to the type (which may be
> NULL on failure). For cases where the total size of the allocation is
> needed, the kmalloc_obj_sz(), kmalloc_objs_sz(), and kmalloc_flex_sz()
> family of macros can be used. For example:
>
>         size = struct_size(ptr, flex_member, count);
>         ptr = kmalloc(size, gfp);
>
> becomes:
>
>         ptr = kmalloc_flex_sz(*ptr, flex_member, count, gfp, &size);

That thing is ACTIVELY WORSE than the code it replaces.

One of them makes sense and is legible toi a normal human.

The other does not.

The alleged advantage is apparently that you can do it on one line,
but when that one line is just horrible garbage, that is not an
advantyage at all.

And the impact of that crazy SIZE on the macro expansions makes the
whole thing entirely illegible.

I will not merge anything this broken.

The whole "limit to pre-defined size" argument is also just crazy,
because now the SIZE parameter suddenly gets a second meaning. EVEN
WORSE.

Finally, I think the parts of this that aren't wrong are too limited,
and do not go far enough.

Because once you give that "alloc_obj()" an actual type, it should
take the alignment of the type into account too.

I also think this part:

+       typeof(VAR) *__obj_ptr = NULL;                                  \
+       if (!WARN_ON_ONCE(!__can_set_flex_counter(__obj_ptr->FAM, __count)) && \

absolutely needs to die.  You just set __obj_ptr to NULL, and then you
use __obj_ptr->FAM. Now, it so happens that __can_set_flex_counter()
only cares about the *type*, but dammit, this kind of code sequence is
simply not acceptable, and it needs to make that *explicit* by using
sane syntax like perhaps just spelling that out, using VAR, not that
NULL value.

IOW. making it use something like "typeof(VAR.FAM)" might work. Not
that crazy garbage.

I never want to see this kind of horrendous patch again. Everything
about it just screamed "disgusting".

                        Linus
