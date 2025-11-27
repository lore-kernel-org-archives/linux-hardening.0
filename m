Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585C327380A
	for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 19:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764270100; cv=none; b=cuFYNcn9qA4qWEqBDudS714Qgauqn8uVLDQhnKCrUu0pnp4wYiDQjCTiE/NItKCb9q3pgVmxgQKiIf1gkewdPKfA1Wm9iagvFmzmhvdUdHdSJt9NDarrj+MMG79moPOD4I8WpWKb0XknpTdnMkkM1XsFrhXW9Vdm/z7zvfx2IDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764270100; c=relaxed/simple;
	bh=pyik1ppWsyn99IJmPwJb8rPtQa356xa43z61sJ0psZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8TPOk8WVUD4RaeF57VpvqqzHKe8VFhhMnalFHmuAg6SNxX9Q/xHzgAXIBJ+ocZTbAxMr1cC3oy877Qblg5lWGhbE2rCRZJzJ329KTJWz7bLgl1SPGAY4sdd8TlyA2+T/0DE0Zo3aEsrCpx/ONbjZKGBQpwsNNTrmRf6PdXPFc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vd08SOMl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vd08SOMl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAFDC116D0
	for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 19:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764270100;
	bh=pyik1ppWsyn99IJmPwJb8rPtQa356xa43z61sJ0psZA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Vd08SOMlOgwGw5/+/GvAcXLiRh+3UiHakhJGwaq7DkutarH+xGtveL0OcdQW+C2wR
	 HslVDSCTWkDhes4fzOLL9pRjnXcUouVIuP6rQ32t7Kw7WLuisK2UvZbxRREieyZZFV
	 aCOAYyzamwmv/p6K+Ejv8J8BKQhqN2DAPB9+S/vGmFzw1A2uFR1rz4dIeFS21SKMYQ
	 /ZwDAEjHYVwia2F7ENmsgCu1yJ4ZmmLXjslYDCtoZaKR62LKhM3KBFuRJle8gQsA51
	 vrrsY3UsrrM0m6gXDZVNXzUMNkaQW5gl0zhZKdDLcTpnMrBoCR2RCrtM+jjxDQ7OSu
	 uoZq2xbJo6SJw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5958931c9c7so1510928e87.2
        for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 11:01:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWyHQB8DSMkGVxBS2Pcd7KLEIV0W3rHjHNHfA22JXdM8H1Mczuy5dxBnaoyHuu+z0XkfZXtDfZr86XP+iXrvjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnThgWKbmWjZldXJ/qw7XjdpHXQom4kodUwUvLoG+S7mGYSsKL
	nFj0rIP8f3rpbluvKrRryK1IHDsk7/iDPVcScMiXuc4yWu4+SfIXpYMvHAXC/VWOjnoFZW/jqV1
	l0e7JWPYBp9oIHUQBSpCixZPEgjD/NZw=
X-Google-Smtp-Source: AGHT+IGwO8km+DEKBaxbbTEf6xRCO3rvZTLW39354N1V9n8/1e78+i+7IjvkI/cbPpzn3XbNIhdZrrNc3oe68ND8ySE=
X-Received: by 2002:ac2:4e08:0:b0:577:285f:32bd with SMTP id
 2adb3069b0e04-596b526cc5fmr4598727e87.26.1764270098336; Thu, 27 Nov 2025
 11:01:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127092226.1439196-8-ardb+git@google.com> <b1dae5a7-27bd-42de-bcce-9fd3c2b1c178@arm.com>
 <CAMj1kXE-Qm4DQNAcg8Tg7YM4EMdLBu_UJm7M8Cpk3t5g7XqP5w@mail.gmail.com>
 <e996fdd5-7113-4327-a884-336dd5f77c4d@arm.com> <CAMj1kXGyYMy2xhcdNicHkMfWBnEjyhc+xg8ciuR-6WXDxDpZxg@mail.gmail.com>
 <f95593ac-d4cf-4e06-9a94-cc5133897c59@arm.com> <aSiDSp8NpqJkr1oD@J2N7QTR9R3>
In-Reply-To: <aSiDSp8NpqJkr1oD@J2N7QTR9R3>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 27 Nov 2025 20:01:25 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF9-tXVQS-_p8c058ssn80xaiDu+01SR98=yQ004xevng@mail.gmail.com>
X-Gm-Features: AWmQ_blCzWooEduQY70i7aS-W3HH2XR2ydJyogg_jetISwCHw8QoRgAWB6Ylzzs
Message-ID: <CAMj1kXF9-tXVQS-_p8c058ssn80xaiDu+01SR98=yQ004xevng@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 0/6] Improve get_random_u8() for use in randomize kstack
To: Mark Rutland <mark.rutland@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Ard Biesheuvel <ardb+git@google.com>, 
	linux-hardening@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <Catalin.Marinas@arm.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Nov 2025 at 17:58, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Nov 27, 2025 at 03:56:59PM +0000, Ryan Roberts wrote:
> > On 27/11/2025 15:03, Ard Biesheuvel wrote:
> > > So the question is really whether we want to dedicate 16 bytes per
> > > task for this. I wouldn't mind personally, but it is something our
> > > internal QA engineers tend to obsess over.
> >
> > Yeah that's a good point.
>
> I think it's a fair point that some people will obsesses over this, but
> I think the concern is misplaced.
>
> I know that people were very happy for the kernel FPSIMD context to
> disappear from task_struct, but 16 bytes is a fair amount smaller, and
> I'm pretty sure we can offset that with a small/moderate amount of work.
>
> AFAICT there are extant holes in task_struct that could easily account
> for 16 bytes. I can also see a few ways to rework arm64's thread_info
> and thread_struct (which are both embedded within task_struct) to save
> some space.
>

Oh, I completely agree. But it is going to come up one way or the other.

> > Is this something we could potentially keep at the start of the
> > kstack? Is there any precident for keeping state there at the moment?
> > For arm64, I know there is a general feeling that 16K for the stack
> > more than enough (but we are stuck with it because 8K isn't quite
> > enough). So it would be "for free". I guess it would be tricky to do
> > this in an arch-agnostic way though...
>
> We went out of our way to stop playing silly games like that when we
> moved thread_info into task_struct; please let's not bring that back.
>

Agreed. (after just having moved the kernel mode FP/SIMD buffer from
task_struct to the kernel mode stack :-))
