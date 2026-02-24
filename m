Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6922D37996F
	for <linux-hardening@vger.kernel.org>; Tue, 24 Feb 2026 11:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931516; cv=none; b=JySt3Ae73TOt0+O4++P4ozNE3TMjWC0O7HCMKZga9GtiDfH+WgDR7s2hiCiw2PomztZ4SIzRuVFO+ZJm/Q7kSBWKRijMpRQmA9Lm9MhBrZbH3xFREcoLmACgxiJvZbdpDFOGKbb15la131HNHN/fFsa/LD1J1WAhHgTXbZRjtg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931516; c=relaxed/simple;
	bh=wTNPYvldKqT8E/99ZE7dTEJbH62XG1KG1J6bDFSPh+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uOFMv4bS1qpkrMk1hg1lhGXnU9nsIpnNoapSEwfHavcWI6ugkSlChacS5YqAs6LEE7HmtiXJrJCIGcZD5QOwmPBXOmqnCbTSu73kEd+Ogmz/eCyaIDGhJcba09as0NP02BTC/yroWB0NxuQHP5WMsTUL8fvEPsqY3iwm7yGqDOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvwmLUcw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvwmLUcw"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso45944205e9.2
        for <linux-hardening@vger.kernel.org>; Tue, 24 Feb 2026 03:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771931514; x=1772536314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwqR4mogOeV02cqzMt1+tF/fnlUYylAA5gPYZ8oxqZQ=;
        b=dvwmLUcw2j8Ap3HLEe1aMS+zujYEbqVjuxoeX0lpOxOTrFieSdM6q2WvR+AqFF85JK
         83E6jsHSgvul535Ipajrgn4CeMEorEHOtqBq/VXjoQRnlbSTuE12zr0spMK3VxvhA3tB
         BPBqxH87/omtYoO8/4lR23Tt+TWJp6MwfvlD535ni0HBmYgy32+wV+Mp81lPVWrOQnKM
         iSFbCl3zDwj8a9YxP1H0GyACAe8yc3+yZ7X53BFhWHMxh6EZt3YdL0lPkupKLnXUZmLj
         0XtKl/lQKd8YPv4xQlibcRlh83mJhFlho97Dfg65kZnQfMAeXPgPzTsTI+PA79TLG6o5
         ohvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771931514; x=1772536314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UwqR4mogOeV02cqzMt1+tF/fnlUYylAA5gPYZ8oxqZQ=;
        b=MC8om5eHqpOIc/cBEOGXvyKGyH5esQviJvcbwl9wWddDXTOeCDmQTgP9ZdovVQEr6+
         m4CluSYeH503bG62Nl50oNstcgq2NyKxQiq2SwtCfp4M3EwF+JSXHa8r7xrcoq9jg+cS
         9vZvOt2xyBPEeKi6FxUcZZY11l+DEIJAWRA/pS5+bp48mqST24TAVzWnWLlOjE9JxXDE
         gsKV9rFiYS875MXS6mQdA9pOiLdrjb1Xy2ZqJL0slSHZb1P0R0qQAMlR/IDZ8jCsshSM
         lOc0ecPsnbCSjodySBzyO6zw4/gURx15lf0Y/uGKkkBvB39KuoNottP5oPZ+n/gKSW/z
         /RWw==
X-Forwarded-Encrypted: i=1; AJvYcCVZeyg3hqHF8dXV/U/8YfwdOhG3kkWz+uDDuD2dfaG2au719Z3mFDXuDA31SG9njB5oArUeliT85eQZPhZGjjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5w9kl1t3V0ik68X2rYedjRgXVXpuLVvIWDA+yodAcsXDyghNP
	AdJTdC5Lox3BobSWUT5vlLsMKQ0KOroZRODfXv6MM+NVJRHQYFl3o05A
X-Gm-Gg: AZuq6aLSAxWSRTAuQAq57Hc/OdY/YXpRUd6czdUWYJ8fYJ9Hap1ugP1gJTZubJFgt1/
	CQEHUW8vcisfVbUKK0EZrBvesGoPXW0gKd7uTOsJb89hTCWXs/xHHx3UWDAKQRUftbPSvRwpCYe
	6TLNMb8q7gFKuTASf/WzqkMuk2zh13c4TZEiCdK4Fv7QZyiN8ZHuU1PPPn4YNU+5tC0ZwkCUWvv
	3sSWFXosmm3MgB4NTmtMDKIx+HCxepxiDFTqqxa0rN7iy2t8ezJjugShXDA2ODy3K0ZhFkPcL4R
	LxjiG5RL4INnkMj43tZ+Jb6ExttMTG073kPw5uVrlbKaTMVC4RbLoKiopsxrRv9VceSpY9HPKBT
	jJdyOtAMKH4pXQCE9UG9qyv23vhwzrPFdUgldqNilMSK+gnQ/hZXt4BmfSyxxGF3AdGhBZF/8AR
	R8EdJ0jynxuJTR3FN7z5MWf3SzWNOiWW1+exVKtjWVn4xYbzaRwqxMwnDOlgNB5/kz
X-Received: by 2002:a05:600c:8b16:b0:480:68ed:1e70 with SMTP id 5b1f17b1804b1-483a963de73mr263902315e9.35.1771931513686;
        Tue, 24 Feb 2026 03:11:53 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9caadedsm216756765e9.10.2026.02.24.03.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 03:11:53 -0800 (PST)
Date: Tue, 24 Feb 2026 11:11:51 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Jonathan
 Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo
 <harry.yoo@oracle.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org,
 linux-hardening@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Miguel Ojeda <ojeda@kernel.org>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Matthew Wilcox <willy@infradead.org>, John
 Hubbard <jhubbard@nvidia.com>, Joe Perches <joe@perches.com>, Christoph
 Lameter <cl@linux.com>, Marco Elver <elver@google.com>, Vegard Nossum
 <vegard.nossum@oracle.com>, Pekka Enberg <penberg@kernel.org>, Joonsoo Kim
 <iamjoonsoo.kim@lge.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, Jann Horn <jannh@google.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, Yafang Shao <laoar.shao@gmail.com>, Tony Ambardar
 <tony.ambardar@gmail.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Jan Hendrik Farr <kernel@jfarr.cc>,
 Alexander Potapenko <glider@google.com>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH v6 4/5] slab: Introduce kmalloc_flex() and family
Message-ID: <20260224111151.6154ce59@pumpkin>
In-Reply-To: <675ec547-dac8-465f-b3c9-a0f97c5bdef7@lucifer.local>
References: <20251203233029.it.641-kees@kernel.org>
	<20251203233036.3212363-4-kees@kernel.org>
	<675ec547-dac8-465f-b3c9-a0f97c5bdef7@lucifer.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Feb 2026 10:26:36 +0000
Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> On Wed, Dec 03, 2025 at 03:30:34PM -0800, Kees Cook wrote:
...
> > +/**
> > + * __alloc_flex - Allocate an object that has a trailing flexible array
> > + * @KMALLOC: kmalloc wrapper function to use for allocation.
> > + * @GFP: GFP flags for the allocation.
> > + * @TYPE: type of structure to allocate space for.
> > + * @FAM: The name of the flexible array member of @TYPE structure.
> > + * @COUNT: how many @FAM elements to allocate space for.
> > + *
> > + * Returns: Newly allocated pointer to @TYPE with @COUNT-many trailing
> > + * @FAM elements, or NULL on failure or if @COUNT cannot be represented
> > + * by the member of @TYPE that counts the @FAM elements (annotated via
> > + * __counted_by()).
> > + */
> > +#define __alloc_flex(KMALLOC, GFP, TYPE, FAM, COUNT)			\
> > +({									\
> > +	const size_t __count = (COUNT);					\
> > +	const size_t __obj_size = struct_size_t(TYPE, FAM, __count);	\
> > +	TYPE *__obj_ptr;						\
> > +	if (WARN_ON_ONCE(overflows_flex_counter_type(TYPE, FAM,	__count))) \
> > +		__obj_ptr = NULL;					\  
...
> Annnd now I typed that I realise that Linus fixed this up in mainline and I was
> working with a stale version of this file :))

I think someone else mentioned it, but having a WARN_ON_ONCE() is there
is really a bad idea.
The code bloat must be stunning.

I won't ask why the #define parameters are all UPPER CASE.

	David


