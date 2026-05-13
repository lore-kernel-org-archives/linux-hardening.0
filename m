Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5BE3AE6EB;
	Wed, 13 May 2026 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778662222; cv=none; b=fI4FWpw1tPEuuPwvGSMWQ+JFkg2MAlXZFOygctt8pEymOPtEtuxInUYFNEuL3EcygyrqVMoJeSPs1E4+siczhwymkd0A8KHG3RLYkWKcJccnDMaoRykAu0inp9l/PfnSuvxgsLqnQEXL2MB1hdcJQnUgpDt1ngkJrIlsXowBiB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778662222; c=relaxed/simple;
	bh=N9P1iXvYrJqLgZmIOtPNBCWH68XujKCrRJM/d7OA1NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uw9X+Hm5rV1e34obIJ31YtWSGEfwWb/ko6cAYVbhPAnNsgbxl5R3CagCzG94k6rMdTNZfv1c72iM3zx6MN+FsbGq8BZLUr6Ovm+glVqMc4dNBodGk2frMDzAjCfYuwpyYYnKtV8qREQkSI7LBLB1WbMLfEuLkM+hyUzZD1+C3lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3wsuP8z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3wsuP8z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449B8C2BCB7;
	Wed, 13 May 2026 08:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778662221;
	bh=N9P1iXvYrJqLgZmIOtPNBCWH68XujKCrRJM/d7OA1NE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P3wsuP8z+CNKLupx+n1E2LTwB0iywnD4fV4upd41SWJq+wzKRFN+6l5o/Oie0iFXu
	 QdpC0QzmJbU/K5OQ8IyHfr06kiJlM7LBMiHCJFHxnYf1+zAE/YVHre4MLSRYgTodzF
	 2UX6okTeCTJI9YtbbKEiw4HSykdkmljvjNwc9qLFqVNHKyLSJ8pz4UoB8aqnGx16Mp
	 VHM75dVMdLqFiKF4Iy17YKPz7rWAnLkaR7h7HrJRw1/Fb3kroXQylFyEBZbcz6n1t4
	 Rrku0nAKE7qsstQILa3ifLy6O3io+f5iV74vmoN5D63J7MlkItbWbq+4JnF0SFHtfr
	 lDHvYuOSl8IsA==
Date: Wed, 13 May 2026 11:50:12 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb+git@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Liz Prucka <lizprucka@google.com>,
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 02/15] mm: Make empty_zero_page __ro_after_init
Message-ID: <agQ7RMAw51RlNUOj@kernel.org>
References: <20260427153416.2103979-17-ardb+git@google.com>
 <20260427153416.2103979-19-ardb+git@google.com>
 <CAG48ez1DJ88a0pBCE-Q0VXyDuJgng8zdunb38g4b4JPU88exww@mail.gmail.com>
 <31252c1d-a98d-4635-ab61-ce5b649e256f@app.fastmail.com>
 <CAG48ez2xJwJDgxSH0u2G==9dOQJQxQ7WsQfU14O1H5hEWic1eA@mail.gmail.com>
 <fb5749bb-bc87-4f0b-9ec9-8a1eb7ded3b5@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb5749bb-bc87-4f0b-9ec9-8a1eb7ded3b5@app.fastmail.com>

On Tue, May 12, 2026 at 02:56:16PM +0200, Ard Biesheuvel wrote:
> On Mon, 11 May 2026, at 16:40, Jann Horn wrote:
> > On Mon, May 11, 2026 at 10:59 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >> I think we should simply do something along the lines of the below,
> >> considering that the size of a data object tends to correlate with
> >> its minimum alignment.
> >>
> >> I do find it rather puzzling that the compiler emits empty_zero_page
> >> *after* zero_page_pfn - ideally, we'd combine the below with
> >> -fdata-sections so that the linker sees all individual objects, but
> >> I suspect that would create some problems elsewhere.
> >>
> >>
> >> --- a/include/asm-generic/vmlinux.lds.h
> >> +++ b/include/asm-generic/vmlinux.lds.h
> >> @@ -452,7 +452,7 @@
> >>  #define RO_AFTER_INIT_DATA                                   \
> >>         . = ALIGN(8);                                         \
> >>         __start_ro_after_init = .;                            \
> >> -       *(.data..ro_after_init)                               \
> >> +       *(SORT_BY_ALIGNMENT(.data..ro_after_init))            \
> >
> > Oh, neat, I didn't realize that's possible. That seems like a nicer
> > approach...
> 
> Neat but rather ineffective, unfortunately. (I don't see a size
> difference with the arm64 defconfig kernel)
> 
> Given that empty_zero_page only ever gets its address taken, we
> might just move it into the linker script if that requires tweaking
> anyway. We can just place it at the start of .rodata, which is
> already page aligned on most architectures (and will become page
> aligned unless EMPTY_ZERO_PAGE is #define'd by the arch linker
> script to something else)
> 
> 
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -472,6 +472,17 @@
>  #endif
>  #endif
>  
> +#ifndef EMPTY_ZERO_PAGE
> +#ifndef __HAVE_COLOR_ZERO_PAGE

I don't think we want let architectures that don't use colored zero pages
redefine it.
If it will be really required we can add the ability to redefine
EMPTY_ZERO_PAGE later.

> +#define EMPTY_ZERO_PAGE                                        \
> +       . = ALIGN(PAGE_SIZE);                                   \
> +       empty_zero_page = .;                                    \
> +       . += PAGE_SIZE;
> +#else
> +#define EMPTY_ZERO_PAGE
> +#endif
> +#endif
> +
>  /*
>   * Read only Data
>   */
> @@ -479,6 +490,7 @@
>         . = ALIGN((align));                                     \
>         .rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {   \
>                 __start_rodata = .;                             \
> +               EMPTY_ZERO_PAGE                                 \
>                 *(.rodata) *(.rodata.*) *(.data.rel.ro*)        \
>                 SCHED_DATA                                      \
> 

-- 
Sincerely yours,
Mike.
