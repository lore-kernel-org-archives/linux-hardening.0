Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37333E1729
	for <linux-hardening@vger.kernel.org>; Tue, 12 May 2026 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590518; cv=pass; b=TyrePUwp0pei54LmcN7isaOqheYMdRbV1+vhMNs1bYtd60m5RbTtoL9T0N/vF5k2v0KCmHKDSQXBxudBuOdSOdLqDjuXLGZyL0ESe7qVSQ+sylJqYmzOp9LD0cXTPFQmYnGSnt1rUb/AuUjqPFNyuz+8WOwl8Ar7a0DvnCsoO80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590518; c=relaxed/simple;
	bh=k001GOwiMb4dRczjtWUwITXHZjyE/lTx6um46NJkiUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEFGY+IqTGDp4hp36QnNOXB0mfTP0DahfthNUdbwZPOQrSRss5TNlorFGQEh5HaEU+/btXoqj+WkCj5XhgolsPMMXfw4To7SMeQGJdz8PXNVs1zTdxuZOhAL3uv8O+k40wc0wwTPHJ4jQVBiOAV0CMjk+cw6uZsxoWkyYmKWaQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o+KlQdY7; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o+KlQdY7"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-13354eb66baso666403c88.1
        for <linux-hardening@vger.kernel.org>; Tue, 12 May 2026 05:55:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778590516; cv=none;
        d=google.com; s=arc-20240605;
        b=DTlwOVTJpEjcszS0s4JW8vB8NS36+Km5wqBmfR1gMxiZ7JceKT91f5fadiMqOWxHIo
         b+SCZsL9S1NV2eVmRotzp8Mt1V06x3ZfhcDLAXLD2P4IOm8JsfUQGpXqJjlrlLTXDaua
         rv84ez/wiXuy02/7qot3U7LpckB42jjQBxwLeVmB9v6Al5Bm26iVl9L0F4o/slw1mZIN
         ba4Gs0KPVof2zNHBETL8iHnoptgbnOGtBdlMMslz9uYWwZcTQ6wKgkMj5EGH+doLQRqe
         AoejOv7pXZuv38EOMNIbrJZaaCgZ7xUItIc2b/Ayg/aupvEz76nWj242Wp6OAO4XNwZh
         Klzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=k001GOwiMb4dRczjtWUwITXHZjyE/lTx6um46NJkiUA=;
        fh=pzyd4oyCURHxqBBFpzJe/pLIBrtvaCO1dQ+KhCIcC/4=;
        b=O+81XSnlxCB9wpqryxKw4IIBREcH1XCjnX2lbHN6TDWGnFyzfm9XWU5wPgDIN3nMEt
         /c65SpIbww5fug5wAgpYdLZd7snS/9mf+7j+8ztLxA2p4t0RQv2e9NAxDF5EPTg9J7u8
         jnT9//iSE7UzHe2YD1c42eS6Sh2OVgE5GHNIQOKxCM/18RUfCQppQxHgEWDPGYDgtiC+
         Vf2nTD32nI92B4r724fwodv7K8zPbA22cWgB/pRBwRnAKPJ9lcG70bSwgS80TawDZTf3
         ExGJhApAROVAMCRlhxGS3OGy0x6PU0qryWJiktLsD5uySnQhvaSceKB/T6sK3OehNumt
         4RxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778590516; x=1779195316; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k001GOwiMb4dRczjtWUwITXHZjyE/lTx6um46NJkiUA=;
        b=o+KlQdY7IlKaDI47VYq+Z/p5ErFxzXeqQYWFACAM73EmoyN5gyb2udD0P5VnMLUtpS
         EYv0YrVctlm3z+mM/lfy4VDdrd6661m7utczoRmNTheX2J62h95G8J16nfEg5xpmWxNQ
         Hk/IRppCdl8iDFwVbYOfvwtCqUgyYI+nGSr4yXh91FCK/I0nQ/QAuCtPHWa2HuRVLayQ
         IN0YFadSi3WJf1lP1dKbMnGsGh0/3jUfDxNxeAB9Q1ENwEmC7SmgReZmpQ1BZ6ZfWcRU
         WL9DWl+NI0hsx7wKKl6+W9Gz9eSwZm5DgBV7iCWwpS6FFqWDKUPJ8WxeWFaSOzrta+cV
         7E7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778590516; x=1779195316;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k001GOwiMb4dRczjtWUwITXHZjyE/lTx6um46NJkiUA=;
        b=MrRaW+bxkq2alVvJmLbMcp29P1or7pVyRLZwmUPQvhyD1OKnmyaywC36GzihyT9pBv
         weQCMSTKsjjQssqay37AhwTnpicON/NXBQIZzpSnode5oopcAeo9+1T6294LJITTZNY5
         IrnGEzQNbYtCeyvbONqzui8DwxVw8cf0QSGnMT7/ykBn2REPdllr/RRdqGlhoHBNjJHo
         8CtTGLg8FVp4ZWzsCW67p+/yK7ZZBzZsLvGtlp1/Us28adDOgric1AKS6oK3nGd6RJSv
         tMrDSdBc49RgYp6McKHsziDBpj6EZy2wrirjMEoNW6vQ3ejL0uDY8LKr0SHSA/lx32Gp
         OSHA==
X-Forwarded-Encrypted: i=1; AFNElJ/JDSLc9F4BX+8t4+kVULADkdC6Gp7AdOoPPxVS5EQsung423DbKeud2dx3C/+VzzpllQ+CJcrmsEOlQHJi7Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDodKFuTXdwQSIZudLQ961ui7plfCw+vgGObj2PqFq0sD/i0EQ
	uJIlrfJBliJY9ZqOeo1DOotTbTLws69ISvRre3MLBXKY5dMK023dBfX0Y7B9QSH/cLdzXVbddh/
	OdMCBdWq6IkQ3iS5TsCfQizITVhJj/GbwfvbAT+cc
X-Gm-Gg: Acq92OHkgkC893RN5Hab/IJHCepZOU23rJNiDtxQs1azWAroBO2BgMw3MlZzv3Bf2Od
	5tKSpHxnPIYyH+S++eUDqCgiA7R/c4U7zR7n01RdsvooyrH12eFGotv69IussdTU4iQHX6iaqXn
	aqzUtavYPsB7AftVCE3i6pCg+hu8RO+rz1Gwn0/6J/i5dKd1h/RcmBdnZrGBY+f+jJy9MMzPogz
	EmEefiOM9U7slNgVbRSvHxM0zgU7euVxr412L7eWjgEuS7bxIcb30hzez0+S/6md1+tmHwYpT2z
	dSa/Awu02aHMZX2kb9BmpWUCQZOBweavBEnvNE174gOe
X-Received: by 2002:a05:7022:2529:b0:12a:6a64:81ee with SMTP id
 a92af1059eb24-132a7edc7a5mr7596782c88.3.1778590515386; Tue, 12 May 2026
 05:55:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511200136.3201646-1-elver@google.com> <20260511200136.3201646-2-elver@google.com>
 <afc2202a-2e0b-43e0-9556-06be2da33c83@kernel.org>
In-Reply-To: <afc2202a-2e0b-43e0-9556-06be2da33c83@kernel.org>
From: Marco Elver <elver@google.com>
Date: Tue, 12 May 2026 14:54:38 +0200
X-Gm-Features: AVHnY4JQX5cZZPTvWGLXHBJoCN4agKvIY9SusDXvPP6Ojv3wTK7cyl5mLfOsNmM
Message-ID: <CANpmjNN0-b0TG2=7SsPpRuubwTWYfoAiYgnnM_5-39SoVfv=Pw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] slab: improve KMALLOC_PARTITION_RANDOM randomness
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Bill Wendling <morbo@google.com>, 
	David Hildenbrand <david@kernel.org>, David Rientjes <rientjes@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
	Justin Stitt <justinstitt@google.com>, KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Matteo Rizzo <matteorizzo@google.com>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, linux-hardening@vger.kernel.org, 
	Nicolas Schier <nsc@kernel.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>, 
	"Liam R. Howlett" <liam@infradead.org>, Alexander Potapenko <glider@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kasan-dev@googlegroups.com, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 May 2026 at 12:37, 'Vlastimil Babka (SUSE)' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
> On 5/11/26 22:00, Marco Elver wrote:
> > When using CONFIG_KMALLOC_PARTITION_RANDOM, _RET_IP_ was previously used
> > to identify the allocation site. _RET_IP_, however, evaluates to the
> > caller's parent's instruction pointer rather than the actual allocation
> > site; this would lead to collisions where a function performs multiple
> > allocations.
> >
> > With the generalization to kmalloc_token_t, we now generate the token at
> > the outermost macro, and using _THIS_IP_ would fix this for all cases.
>
> Hm but it means in patch 1 we make things even worse and then fix them
> again, and also improve what was suboptimal prior to the series.
> Would it be instead possible to reorder patches 1 and 2 so we improve the
> current state first, and then introduce typed partitioning without any
> changes to the randomized one? (aside from changing the previously correcly
> used cases _RET_IP_ to _CODE_LOCATION_).

It won't work (it could be made to work if _THIS_IP_ wasn't broken).
The compiler is supposed to maintain semantics of a static variable in
a function, even inline functions, and refer to the same static
variable -- and because kmalloc_type is an inline function, if
_CODE_LOCATION_ is the non-_THIS_IP_ version, it'd break.

Even if _THIS_IP_ wasn't broken, the other complication is introducing
the slab.c vs. outside use of kmalloc_type differentiation.

Both these problems go away if we make this patch 2 (using
_CODE_LOCATION_ on the outer macro, not in an inline function).

While I understand that maybe we could have considered this as a
stable backport, I think it's borderline; the feature isn't broken
per-se, just slightly lower randomness than perhaps intended if size
is a constant expression. A minimal fix prior to the macro rework
currently eludes me.
