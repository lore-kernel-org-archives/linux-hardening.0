Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4C83451AA
	for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 10:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769511063; cv=none; b=acR6IfO3EYumEeWHF7n6BrxktHPJsmWngbG6lcD60Qwo5UoIX2qspn9cd8XVSpgDHT0CFs+94hC4mbf3Qx5z7vgXVBvNLLkhq5M5O8wyhlQRAo4/N6V2tmBJUcP4sfrUbpYowhyzh5TV82hVsO4kRITvyYt6nyFgLZSADMPLNbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769511063; c=relaxed/simple;
	bh=LjgsQOJovIj6KZEeW7i2qRMeYJMGaije8moXkQ/PYcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UzxWh+v2lBg7TAbxcI4WPp3jlGsejtWkVm45zMXrmR4o0YFbvOBqnvUuGntLPIrGvF4vd1t5RT0zkWCUhdRJakAEPMlw6ADAimkWUJlwGIGpLGwm4Od2WKxQvpBUsF3ciL8HtwCb2GYoYE7lfG5yotQRTcMu3J3r+ojVKKEuHH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5475+Vg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5475+Vg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602B0C2BCB2
	for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 10:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769511063;
	bh=LjgsQOJovIj6KZEeW7i2qRMeYJMGaije8moXkQ/PYcw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a5475+VghIiuZPfyL4qa8VEXp5Ctve9VCrBl0ynvHPa9Soe8QHdgbJDBjvvOd9fPV
	 FWoFKPHDIba4gYnqgqjgjnsc7KI2ajUkOuBt0eLQaqb7M7aHBDZjg6rSqHQofHt2TW
	 VHGfJvgGGNlEEZLF3avHx2TsbknHS29mhuX+L5y/Q0YGMYtcVStxk9OrXBHFqvdklV
	 bm/E4KbCxg8ORLC0ex/nPTdTJv6QC/faaTYvDfvx9BOf/XWXD539jwxrUzudsPcJ7T
	 p1R+rfWwERfhfTJ5wZfPfBebJARd7btoM+OE4XqP7DpssUHFBPenWQ53xoWoI/wstJ
	 zgUfDHldee6Tw==
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34c27d14559so3318675a91.2
        for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 02:51:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWQXHu9bkQ8270b3A+JUljk2SxUvsBY365ZAKrQBFxPG28Kc90T7bqT1JNDRiY/5zz4JxWgkQhuE/Up/l9Qxo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUiKWOtvdeq1Acab1+/rHnQ4rHKKPaXi3TeurXIdbbQZSkC9Tf
	QOHV0ITivlyzC8yVkI89ey6wMx+pwhTIipX63BQq5EJ2JprDdbrRwc1nEE3q16pyyeDbyTfuAh6
	Sg/YJBaEpJKFjW9/aFMg1vtSQfq6A1l0=
X-Received: by 2002:a17:90a:f950:b0:340:f05a:3ed3 with SMTP id
 98e67ed59e1d1-353fed75832mr1836496a91.17.1769511062886; Tue, 27 Jan 2026
 02:51:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126092630.1800589-12-ardb+git@google.com>
 <20260126092630.1800589-13-ardb+git@google.com> <3d59a8d9-a382-48d8-b79c-f5c23e86c1b7@arm.com>
 <CAMj1kXF4k9EstLkxdNje_rwTehdu2MYvyh7n+4GoMWNcjcHYcA@mail.gmail.com> <427d39c1-ab02-4a66-a0ba-d4fb98ab72d6@arm.com>
In-Reply-To: <427d39c1-ab02-4a66-a0ba-d4fb98ab72d6@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 27 Jan 2026 11:50:51 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGJYXhvt6WUR1ApyVO2NHb9tgNPUX+3+S9nKGmwKPE3rg@mail.gmail.com>
X-Gm-Features: AZwV_QgG2vC9viPMpZzzM08HnseaBerBb4x2QliQhq0LkVgd_A_JAHiwyi_srWA
Message-ID: <CAMj1kXGJYXhvt6WUR1ApyVO2NHb9tgNPUX+3+S9nKGmwKPE3rg@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] arm64: Move the zero page to rodata
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, will@kernel.org, 
	catalin.marinas@arm.com, mark.rutland@arm.com, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Jan 2026 at 11:04, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> On 27/01/2026 09:49, Ard Biesheuvel wrote:
> > On Tue, 27 Jan 2026 at 10:34, Ryan Roberts <ryan.roberts@arm.com> wrote:
> >>
> >> On 26/01/2026 09:26, Ard Biesheuvel wrote:
> >>> From: Ard Biesheuvel <ardb@kernel.org>
> >>>
> >>> The zero page should contain only zero bytes, and so mapping it
> >>> read-write is unnecessary. Combine it with reserved_pg_dir, which lives
> >>> in the read-only region of the kernel, and already serves a similar
> >>> purpose.
> >>>
> >>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >>> ---
> >>>  arch/arm64/kernel/vmlinux.lds.S | 1 +
> >>>  arch/arm64/mm/mmu.c             | 3 +--
> >>>  2 files changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> >>> index ad6133b89e7a..b2a093f5b3fc 100644
> >>> --- a/arch/arm64/kernel/vmlinux.lds.S
> >>> +++ b/arch/arm64/kernel/vmlinux.lds.S
> >>> @@ -229,6 +229,7 @@ SECTIONS
> >>>  #endif
> >>>
> >>>       reserved_pg_dir = .;
> >>> +     empty_zero_page = .;
> >>>       . += PAGE_SIZE;
> >>>
> >>>       swapper_pg_dir = .;
> >>
> >> Isn't there a magic macro for getting from swapper to reserved? That will need
> >> updating?
> >>
> >
> > Why? This just adds an alias to refer to the same allocation.
>
> Oh yes, sorry I completely missed that. And you've even stated it in the commit
> log...
>
> I'm struggling to see where this gets zeroed though? I assume it must be zeroed
> before the old empty_zero_page would have been so everything works fine?
>

It is statically zero initialized in the image.

> Assuming yes, then:
>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
>

Thanks!
