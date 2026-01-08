Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27D74A50C8
	for <linux-hardening@vger.kernel.org>; Thu,  8 Jan 2026 12:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767874220; cv=none; b=r4OUoYoEwce3g4A6fTbSjjeF2ecNojijy3tE42no3aaSwsJNsGcURH/s9mIqs8wycJUk41u2ETtp2NX4r7n/4EwS+jpuiqBHr/+nZVPo70dqbfpDVvEy9rsTJ7atApF6jo/Kk4jYJjtgRIQaBuD7N1roDgDNQd38DGhG9ts14Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767874220; c=relaxed/simple;
	bh=IDmGxmWPlKa9YEhGuBWqIyMsqGdkoTjfGE3cpLh7Kn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0TeE4K8hLAqqGgKyV8l6/1KcMej8sYIZROvFeGNOqrTCgva0HR+K8nQb3+Moce75OhJ3HIKwfC+LpA7aQHDzdQXp7v/fs5cuRF2Lu+d9iI5z/i7ggLN2oVAR5Er7cDrPy13qsZo27FGqotTvIAMNG2hLyczgulyTE5gyxwoNY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgbUTLwO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgbUTLwO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F82C2BC87
	for <linux-hardening@vger.kernel.org>; Thu,  8 Jan 2026 12:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767874218;
	bh=IDmGxmWPlKa9YEhGuBWqIyMsqGdkoTjfGE3cpLh7Kn8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XgbUTLwOE0MKOpJXxfLW5mbpZhPMCZGMip/HXNSNKBJFzh1Q39BrGpU2ViUwAs4C0
	 2EulBDqIhXvWa4LASQV4055t519e9gfkl4rUgOMlp7pfEECvnO86kiuJ8MJXoODjvt
	 ARFLgf1saKKT/YTf7h/LTfCoxU6Cwwr7YWP1cSpZXyshSVastBaVPQHUwiGI9lyYb2
	 2pjVD83RVni/ic7SWITHE5cRyIu9U+WLQaQWhQ1hIB0nbVZA/7E0Yt1uSCOu3vY6G1
	 VsYBpnBr6iKZDihALKK/ji9yO/cONybs7KzS9+G7Wvnfx2DaflCdvfe4WPqVTW/Z2h
	 e+R8F1LQI2e2Q==
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34c5f0222b0so2036226a91.3
        for <linux-hardening@vger.kernel.org>; Thu, 08 Jan 2026 04:10:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWlYwQ0ptuE3KSOCP4Wuq45jWeRaCePl1Wv4efiGXENqoSsR2KcNQ2eqA36FFNvtdPB2huMh4zBCmgQm0c2nhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO5E4JAilZXwYFTNToI5ja804fVMlXgMNCELmr3PKkqDsnyiqA
	l9BjJ1qf1dblGYrYpgCDQhRIHlFRr+E9qJvdn3CiholY3g8i9CgkUIyoFD8G+Qj7+cjY/eoon53
	Mjq2a7RWQGn/rIgvSfTGarPTOoIacvcw=
X-Google-Smtp-Source: AGHT+IHcC9O6HZglQY6uw8GA8QzjvcAFABuHS/Wgov9FXhPkORCKhi2pTdjo4LVGkBgUtaVSOm76JujXwj/a+wS7GME=
X-Received: by 2002:a17:90b:4acb:b0:349:7f0a:381b with SMTP id
 98e67ed59e1d1-34f68b4c603mr5854088a91.8.1767874218184; Thu, 08 Jan 2026
 04:10:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108092526.28586-21-ardb@kernel.org> <20260108092526.28586-32-ardb@kernel.org>
 <20260108120829.6ea6aa0a@pumpkin>
In-Reply-To: <20260108120829.6ea6aa0a@pumpkin>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 8 Jan 2026 13:10:05 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFY=Os10Ov6Wv6XNxqLqbEAWTOjkdaohxL3SvveCLWnLA@mail.gmail.com>
X-Gm-Features: AQt7F2o-WwesPvulyrCqJE6xuFgFRttaRyJ0K2lsMiGxZ_ei84NhJ3vdn2RMti0
Message-ID: <CAMj1kXFY=Os10Ov6Wv6XNxqLqbEAWTOjkdaohxL3SvveCLWnLA@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 11/19] x86/rethook: Use RIP-relative reference for
 fake return address
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	Uros Bizjak <ubizjak@gmail.com>, Brian Gerst <brgerst@gmail.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Jan 2026 at 13:08, David Laight <david.laight.linux@gmail.com> wrote:
>
> On Thu,  8 Jan 2026 09:25:38 +0000
> Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > Pushing an immediate absolute address to the stack is not permitted when
> > linking x86_64 code in PIE mode. Usually, the address can be taken using
> > a RIP-relative LEA instruction, but this is not possible here as there
> > are no available registers.
> >
> > So instead, take the address into a static global, and push it onto the
> > stack using a RIP-relative memory operand.
>
> The comment implies the address is 'fake'.
> Does that mean it could just be a constant?

It could be, but it isn't, across all architectures.

> Clearly the unwinder would need the same change.
>

Why? The value being pushed is the same.
