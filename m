Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC7318027;
	Fri, 11 Oct 2024 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728663753; cv=none; b=C+isUq2YwbQTMy7Yv9dqsZpSPjbRCBQV2TYTRM2yaJZ9TG9pVNgb42eJnnXgAkiSIHn+BzWj+4v3dCl8HBfCY0vHXbkv1TJEs7OZNf7FgYVy91g/3jOmNwhJqDDAsCbm8lHQmsNYoo6mOhFf+YnlLrQMIPedmz/pjDlOxZYFATs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728663753; c=relaxed/simple;
	bh=TG4DIBFJ6ZIC+aXyEtgwbCfPgPi21gFjo4WUj0JAeOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jpq4NGktO/qpTeve9NV/epvtAs+8aw8CcLXrHdzy0rkk6jBlW4YEncoss60CMuRU0WoxmwQNtFcW9242zPiOgQeuSMqLxCt5D6iLLlvl2TpVmtPID3ZdLDeKH70KgUsMjFegpTTOtSFHDVEnbNv/GgMfuv0GSHj0w5cjTp1wyJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnjQXIBr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnjQXIBr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5551C4AF09;
	Fri, 11 Oct 2024 16:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728663752;
	bh=TG4DIBFJ6ZIC+aXyEtgwbCfPgPi21gFjo4WUj0JAeOQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DnjQXIBrSidi4KTELiz5a9eA4Kq7xjj8adjeIwGIsEO3abMXc6xg3mavQlKbqZ32F
	 GC08kA0qZ80qQbUAbI5R0NdS3V8jgcI3PMXFc+jds9KQGD0pezh85XvMhdUAsd8J6U
	 isjN+b0RMWkvhgy9JxWSiIaJCoNL5qm0vnZvcmCnO6KQfLaZ8pNkTAiahhbLcmo3He
	 9ACRwr7xct3Pupi1NGtK7j+rcNt0oSZCV0C9gngk8ng8FEcNWI5geZ/NSb+AMpwJ+S
	 rEfGyFLo6rFfeCHRzNHKc+zKAae0kPkoiQ8+Q1o/ie8Skn1U7o4EDszvBFa3+vVhhx
	 f6LWQ9tu7pvuQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5398b589032so3766082e87.1;
        Fri, 11 Oct 2024 09:22:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIOWT9Wam8fGT+XfZNzfekPJd6jR2B5CxbFvBkzZAqAufjZskRLqVgT1OEifTPQwdvwU6DFcbCFZ70l2Tc@vger.kernel.org, AJvYcCVKgMU08sNkM/aFiN/Zjz2KMe5KX7uybXEnTPlwudmtj9WFQ/FU4LR5AlpTTUiZp5UJ0uaHKpKyJ2II7kxZA8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YymVPGGaPphkBQd9KDv4Lt2qE1rkqV+yItcNfcjPAHX5z8jUoZE
	Ro2QFlEShHMAkjPeD2Vm8n1NUUitluIFqFdrO//JImNGSfFmv7CvloK0bvJOh2qDgkCKoqYtHIF
	PrJx5foc6FA7NNZaFixaZtPiAYzE=
X-Google-Smtp-Source: AGHT+IGBOD0uUl8CedMLDxOB5/KToVFNZdHF5xOTUxlpBw5ZkSYEhpFQTRBX7XMrDHDJlR2zXYKCVujoVelgfIoWcEo=
X-Received: by 2002:a05:6512:3d23:b0:536:a4f1:d214 with SMTP id
 2adb3069b0e04-539e54e819cmr64561e87.19.1728663751143; Fri, 11 Oct 2024
 09:22:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010122801.1321976-7-ardb+git@google.com> <20241010122801.1321976-12-ardb+git@google.com>
 <20241010203401.45ds362dpx52ne5z@treble> <CAMj1kXF_-wSM-rmxS5C_cG-srdUgzKQsSGxp54pZ4pMhXeNsfg@mail.gmail.com>
 <20241011160445.7clmhtgywqmkuh4u@treble>
In-Reply-To: <20241011160445.7clmhtgywqmkuh4u@treble>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 11 Oct 2024 18:22:19 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEEYxDEJouXOHHUnGwOcGWc7c9HjNK=ubjvA2HMt9ONaA@mail.gmail.com>
Message-ID: <CAMj1kXEEYxDEJouXOHHUnGwOcGWc7c9HjNK=ubjvA2HMt9ONaA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] crypto: x86/crc32c - Tweak jump table to validate
 objtool logic
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	keescook@chromium.org, linux-hardening@vger.kernel.org, nathan@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Jan Beulich <jbeulich@suse.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Oct 2024 at 18:05, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> On Fri, Oct 11, 2024 at 08:32:33AM +0200, Ard Biesheuvel wrote:
> > On Thu, 10 Oct 2024 at 22:34, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > >
> > > On Thu, Oct 10, 2024 at 02:28:07PM +0200, Ard Biesheuvel wrote:
> > > > From: Ard Biesheuvel <ardb@kernel.org>
> > > >
> > > > Tweak the jump table so
> > > > - the address is taken far way from its use
> > > > - its offset from the start of .rodata is != 0x0
> > > > - its type is STT_OBJECT and its size is set to the size of the actual
> > > >   table
> > > > - the indirect jump is annotated with a R_X86_64_NONE relocation
> > > >   pointing to the jump table
> > > >
> > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > This needs more "why", I assume the goals are to add the annotations +
> > > confuse objtool if it doesn't read them properly?
> > >
> >
> > As presented, this is just a vehicle to test the other changes in the
> > series. That is why I split it off from the previous one.
> >
> > Whether or not we want this code in the tree is up for debate, but I
> > guess it could be useful as a canary for objtool, given that most
> > configs now disable jump tables entirely.
>
> The annotations are definitely needed since that's the future of jump
> table handling.
>

Yeah, I'll split those off

> The rest of the changes aren't worth the effort IMO.  In general we
> don't compromise code quality to make objtool happy.
>
> And "unit test for deprecated jump table detection" is even less of a
> justification than would be something like "objtool can't otherwise
> follow the code".
>

No, quite the opposite - the changes will confuse objtool and so it
will only work correctly if the annotation is provided. That was the
point of this patch, but as I said, I never intended those changes to
be merged.
