Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0608A190662;
	Mon, 17 Jun 2024 23:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718668668; cv=none; b=VTdNBU0fcRiHKL8lkasPefSC/eso4BekGotk9KWjus6XNV6iyQWeyYcvkmqhkCA4eU4+rkenEByVZ3X20hHoXLmSTeDk9+tyw8RaZQKgRpHLwrn3XAyQaH4SAsYkiGUYpeHFauaGr7RGEj3SFWdaO+NmDwdWuZ9RoVH+N2hde3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718668668; c=relaxed/simple;
	bh=jbWaDq1a1L4FtvGxnoO0NxUyE13Pm08R8DtybS4iVgg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kAXHZNRibp9NRIZT1sczGFJKDVuix4VaY45gmtr38ZcdbzItHF9aIPaJ+xKIbtby45w/Ul+4f9aehFcBMMZ1vbU+oluKTXU8DIwurBKYihKnHpNm4EQdTpQcreI+fsIcnHGfiXmlWZnulmBcY/mlmT5LEW1qdwiKxhacQDl2CRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3z3WuypT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p6uHUneJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3z3WuypT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p6uHUneJ"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718668665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8hTbs5uD2MYpUM4xJQu6oqiC+cvQcipUudqa5qlicnY=;
	b=3z3WuypTtqrRGUMI/HVWmrrdczcGEAhXVP9FP2sIlxzZqcn3B7y8LlxNmTOo++na55NNz/
	s/03PXzzDPyayDgM9uFLcmc6Q7dM1ydq5woEz4TlbI2R8hlemxzh3DY+PhfCZS0nM638LZ
	aqNPvn4XigqrJdrVQSZonvZIm1ONjfqfqBSUML/4Vg+KBXnjc7vSmviJe1lw+XL1sp+oKH
	Wkp6BkpCemuJkw8MSuN48kKnF8D+Iw/z/q493Q6r9s0EjYmHT+vlRvyJ3QVbj0Bc/RIUEc
	bbVFRDX843rnMVcrSh3e6kg6SSLK9TNMOmk5wy5Ssed1blPzaQkxNzp7mQ5egw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718668665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8hTbs5uD2MYpUM4xJQu6oqiC+cvQcipUudqa5qlicnY=;
	b=p6uHUneJ+un+L16cMI06hVXDoqwZOa4ndG6eCgTc774G1q0ZOPkFYa6d+7DcrZIVyv8ur+
	QYq8JoN5HGi3U+AQ==
To: Kees Cook <kees@kernel.org>
Cc: Gatlin Newhouse <gatlin.newhouse@gmail.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Marco Elver <elver@google.com>, Andrey Konovalov
 <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, Andrew Morton <akpm@linux-foundation.org>, Rick
 Edgecombe <rick.p.edgecombe@intel.com>, Baoquan He <bhe@redhat.com>,
 Changbin Du <changbin.du@huawei.com>, Pengfei Xu <pengfei.xu@intel.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Xin Li <xin3.li@intel.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Tina Zhang <tina.zhang@intel.com>, Uros Bizjak
 <ubizjak@gmail.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH v2] x86/traps: Enable UBSAN traps on x86
In-Reply-To: <202406171557.E6CA604FB@keescook>
References: <20240601031019.3708758-1-gatlin.newhouse@gmail.com>
 <878qzm6m2m.ffs@tglx>
 <7bthvkp3kitmmxwdywyeyexajedlxxf6rqx4zxwco6bzuyx5eq@ihpax3jffuz6>
 <202406121139.5E793B4F3E@keescook> <875xu7rzeg.ffs@tglx>
 <202406171557.E6CA604FB@keescook>
Date: Tue, 18 Jun 2024 01:57:44 +0200
Message-ID: <87zfrjqg07.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 17 2024 at 16:06, Kees Cook wrote:
> On Tue, Jun 18, 2024 at 12:13:27AM +0200, Thomas Gleixner wrote:
>> In fact is_valid_bugaddr() should be globally fixed up to return bool to
>> match what the function name suggests.
>> 
>> The UD type information is x86 specific and has zero business in a
>> generic architecture agnostic function return value.
>> 
>> It's a sad state of affairs that I have to explain this to people who
>> care about code correctness. Readability and consistency are substantial
>> parts of correctness, really.
>
> Well, it's trade-offs. If get_ud_type() is in is_valid_bugaddr(), we
> have to call it _again_ outside of is_valid_bugaddr(). That's suboptimal
> as well. I was trying to find a reasonable way to avoid refactoring all
> architectures and to avoid code code.

There is not much of a trade-off. This is not the context switch hot
path, right?

Aside of that what is wrong with refactoring? If something does not fit
or the name does not make sense anymore then refactoring is the right
thing to do, no? It's not rocket science and just a little bit more work
but benefitial at the end.

> Looking at it all again, I actually think arch/x86/kernel/traps.c
> shouldn't call is_valid_bugaddr() at all. That usage can continue to
> stay in lib/bug.c, which is only ever used by x86 during very early
> boot, according to the comments in early_fixup_exception(). So just a
> direct replacement of is_valid_bugaddr() with the proposed get_ud_type()
> should be fine in arch/x86/kernel/traps.c.

I haven't looked at the details, but if that's the case then there is
even less of a reason to abuse is_valid_bugaddr().

That said it would still be sensible to convert is_valid_bugaddr() to a
boolean return value :)

Thanks,

        tglx
