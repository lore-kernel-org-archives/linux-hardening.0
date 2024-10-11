Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BB811187;
	Fri, 11 Oct 2024 06:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728628366; cv=none; b=c+ZDQB9Pr8H4jdf2a/zhJB9vv1HcD4TVaSVkgeKG9boRkdXB7Zt0EJeK47kVzy3x64hbCKN+tAIgxIEY0WT9GZ5Dgyg5nu1uJGpHdzJbNyVsXnGNCx9/b0oV0/CTmpR9GZ5DnyjUI5wH9xr5H6PQ05SA3Fznoo6R3jK4hkU/5KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728628366; c=relaxed/simple;
	bh=AnL5GeFPQyjZfL3ql7vc0FPXzGCajzMT1GjLn2sCZzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xn70j/MEd5qqOietLKVRIiXmEpEDXjcZtPO/5S3q3e2TyDuBDWrl2hpNP3Wd41t5ZzUjugd8AJMXYIYMT+ifCjKpXyb/PDhrIXUnk8ovcNs36/9ul+vza6K8PcMKSeLpvjRhE7PC6Vo0sHzfGbS/GMR/9Sswm06l2VrV4lpGhhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSpFYioH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSpFYioH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5DDC4CEC3;
	Fri, 11 Oct 2024 06:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728628366;
	bh=AnL5GeFPQyjZfL3ql7vc0FPXzGCajzMT1GjLn2sCZzQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bSpFYioHXvgvo64LbtZiF5aZufjwqLdz4sG6roNWUTDvW7VQFeleEid++JjdLl0+i
	 NGDZBa2OheVIua1qlJzuTGP7PsEQYrE+HZQd7rahT4YwghyF8HJZ4ZaiN3N7JC1ZY7
	 1pd/6XS7UKxpk15mvzDzNz+CNdTvKnYXAri6N4erc1qEvfY6KleQ6++djixPNXZiEv
	 2Q6J2BRXz0G4kRqT3fIu920xyY2/8iyTGlW7b3O1Nx4t1e4Ojbpj7ZXZORJNqL5lCG
	 54bPYJU8ZQnDe7jLt86PBPoXoIBkgh/i3+f4XgRE7t5ertF1AqTU9oyyt1+DQUz/AO
	 Q1ftI0JWP0DBQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5369f1c7cb8so2287103e87.1;
        Thu, 10 Oct 2024 23:32:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDnrrO87Hq5dB+vgK8yzhs0iaBykAtIKqLVSavvzxqWlRDK8IBV5o29uPb3P4t0/gSguXrPKmMzbtNYkoDzEk=@vger.kernel.org, AJvYcCVf1+68slt2uR7zbfJpfdu98AkfnhG7Aig/BsGvjVB9Hn+4VODet0c7YuvrRgdbn41ayunWXWcapmzug1mc@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh2vvC4ZNqNa4BPXDd7H3id10O8cR0mZtJmLcLV1VJsMW0SBGf
	PeH57U2uViwImXFv1GrP9iPylGsuLYB45HDMbG6osPriLDJANn0sELIjbKV9tp7cgFHdtkZUKjl
	w+1ZW8Asvp6fJvq3EgTrRaLHLCzc=
X-Google-Smtp-Source: AGHT+IEAUXKzjdMmeNguDYQVESVsGf3mVgAC7fcVfgrWwu9ShcvQNW53b+1p0KO6WvSGIt1o8n1nn2SYvX9O88RQ6Tw=
X-Received: by 2002:a05:6512:3c98:b0:530:aa3e:f3c with SMTP id
 2adb3069b0e04-539da3c4a5dmr686774e87.14.1728628364597; Thu, 10 Oct 2024
 23:32:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010122801.1321976-7-ardb+git@google.com> <20241010122801.1321976-12-ardb+git@google.com>
 <20241010203401.45ds362dpx52ne5z@treble>
In-Reply-To: <20241010203401.45ds362dpx52ne5z@treble>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 11 Oct 2024 08:32:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF_-wSM-rmxS5C_cG-srdUgzKQsSGxp54pZ4pMhXeNsfg@mail.gmail.com>
Message-ID: <CAMj1kXF_-wSM-rmxS5C_cG-srdUgzKQsSGxp54pZ4pMhXeNsfg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] crypto: x86/crc32c - Tweak jump table to validate
 objtool logic
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	keescook@chromium.org, linux-hardening@vger.kernel.org, nathan@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Jan Beulich <jbeulich@suse.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Oct 2024 at 22:34, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> On Thu, Oct 10, 2024 at 02:28:07PM +0200, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Tweak the jump table so
> > - the address is taken far way from its use
> > - its offset from the start of .rodata is != 0x0
> > - its type is STT_OBJECT and its size is set to the size of the actual
> >   table
> > - the indirect jump is annotated with a R_X86_64_NONE relocation
> >   pointing to the jump table
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> This needs more "why", I assume the goals are to add the annotations +
> confuse objtool if it doesn't read them properly?
>

As presented, this is just a vehicle to test the other changes in the
series. That is why I split it off from the previous one.

Whether or not we want this code in the tree is up for debate, but I
guess it could be useful as a canary for objtool, given that most
configs now disable jump tables entirely.
