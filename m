Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD812ECEBC
	for <linux-hardening@vger.kernel.org>; Fri, 23 Jan 2026 06:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769150678; cv=none; b=X21kSomao8AW4iTTXwGfZ/+cm4i+EdgyOQOHvU9OuF3qpdAMPZMw41lpRJYtzDyNNO5BCXGaSbiF8I4eIgyQ7iAQNYYARlqXZK1sffZHlUJTcj3NaZeT3fHtfW+ZeoUHQovEAcwIOhthokJrqo82vi7b79dL/HNTGnU/2yJbZWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769150678; c=relaxed/simple;
	bh=G68OwHeMFSkFczDKRhFt13EuWCm6wYpmm34gZd/81AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuqGq/Pjdr3Csr1yHHe+/noIPtflNbHgzeFYmitiwBBqgyxZJnHQ73C9nDPk996P6e1UuWqJ52ey1yQagBnlgdIkuvSu6/ltrMkxRepr3Hoyc4Hh2bQ43dejLaLrob2Tf5Xo8g417CV3dTUi7zmvnFfCKHPpQsrI4sD4IhGSF94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyPxseOx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyPxseOx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E822C19425
	for <linux-hardening@vger.kernel.org>; Fri, 23 Jan 2026 06:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769150678;
	bh=G68OwHeMFSkFczDKRhFt13EuWCm6wYpmm34gZd/81AA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LyPxseOxWj+QOfdnqto+kE2kNc0aSNpS8o5GBPeP+13Dv8Gg9bMZgqA3cTflXzDw4
	 P76RsKv4lyp3TEtgvAKWWfSdtBnrjyylnR0wZ1N3lr9ZH0fML2pDi6jdtO6wr3+Rkd
	 yjcMc0kOuUbsABi0iswGbdTl7QCHHcIqLDV3R+rTdofY1wCwo7LcCMEoatGusTCyRT
	 j4UJlOWoWoB7NyQZC9/TTSgvahefLYo+jUPZ5t6VvQ9ISa4yXDruw4XXQCjiKOpUgZ
	 8C9w6wAImmdwFNFOTGoaH7Cu2Z72icXGG/LNUscMO5f6M1z74ZTZoKsqku1qaoFgoU
	 1Fei+9EI/Tnbg==
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29f30233d8aso12380005ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 22 Jan 2026 22:44:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXfW/fZAYXRvA+KvUjn0ECP/CwM2xt66BjxerVwG+ZuYCuWkoEBnznQ+qQ2MQ/Vt00WQLQA6DbaOG4dAVAD8iI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwKamqN3QAbDyV8kANkzoW43h/bLjE4VZMWhKUaKU2OWVMydGr
	+1hjX3pm7uxfL9o5t9xTQj9NftqJWG5OAEWv6gltoPfa8s2mu5LsECIZRUueH33ulUw6rwxIleK
	a2aL3Fbm1X/hMt72G7Pmb9XmyUodjw5A=
X-Received: by 2002:a17:903:8c8:b0:295:560a:e499 with SMTP id
 d9443c01a7336-2a7fe43ed49mr17499125ad.5.1769150678062; Thu, 22 Jan 2026
 22:44:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119164747.1402434-6-ardb+git@google.com> <20260119164747.1402434-9-ardb+git@google.com>
 <ddb667ef-efd1-40f5-832d-9017f6bbbec5@arm.com>
In-Reply-To: <ddb667ef-efd1-40f5-832d-9017f6bbbec5@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 23 Jan 2026 07:44:26 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH7Ed6+uKWEDozu97tfiQUtXxuT5ocp7HoBpZ++T0tvuA@mail.gmail.com>
X-Gm-Features: AZwV_Qj0qFyZ-3lT_l7PUgDK3X-TjJKC_w4YzjPSMNrGxpn-wDUT_EpcLvxvdFU
Message-ID: <CAMj1kXH7Ed6+uKWEDozu97tfiQUtXxuT5ocp7HoBpZ++T0tvuA@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: Move the zero page to rodata
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, will@kernel.org, 
	catalin.marinas@arm.com, mark.rutland@arm.com, 
	Ryan Roberts <ryan.roberts@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Jan 2026 at 07:43, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 19/01/26 10:17 PM, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > The zero page should contain only zero bytes, and so mapping it
> > read-write is unnecessary. Move it to __ro_after_init instead.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/mm/mmu.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 2a18637ecc15..d978b07ab7b8 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -68,7 +68,8 @@ long __section(".mmuoff.data.write") __early_cpu_boot_status;
> >   * Empty_zero_page is a special page that is used for zero-initialized data
> >   * and COW.
> >   */
> > -unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
> > +unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
> > +                                     __ro_after_init __aligned(PAGE_SIZE);
> >  EXPORT_SYMBOL(empty_zero_page);
> >
> >  static DEFINE_SPINLOCK(swapper_pgdir_lock);
>
> A small nit - could this be the first patch in the series here ? Becasue it is
> not related to other three patches.
>

It is related to the other three patches: the 4th patch requires it.

> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

Thanks!
