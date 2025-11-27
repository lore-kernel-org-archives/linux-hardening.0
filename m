Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ABE332EB1
	for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764258062; cv=none; b=HFjQaYVWI40q17bp2w0a+4QQYRFRg1np91EdxSGbEo9dIhpLOR0DyNUzQ0etmKbjUeiAGm7W+hYG9FVEyTJ4Me3ASfzCYfJooGbvEG65fML7eZbqyqlPabAo7D0Cdc5OGh0WbZ6DUCFkr4Bkj9vh7DNUAxAVvIkZ7CRHbw96lfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764258062; c=relaxed/simple;
	bh=MpfSOKAMPLrl+kEKU/dvKMcPaBA2LeweC9XjtAj/9Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PlT/6PjQwq9fr6xt+1WKilbhDTMmCvTedFf17Ub/EGOO49qZqL4MroQ0QnrAL/YiuBRWDyZ/xGqE5ICim20oalfRAcA6pQciu53x5tqXCEsp0WB6J0Xs/6/PQPNyVTAJLDB//c5hqHY1doI6Jtm8ULdWlpH5hItuWu0lJ/T6JGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9Hk9WrR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9Hk9WrR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE4BC19423
	for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 15:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764258061;
	bh=MpfSOKAMPLrl+kEKU/dvKMcPaBA2LeweC9XjtAj/9Co=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f9Hk9WrRrnc/iWUI91Ag3YfJ/huXPE6L0n+FngH3dBVz/Gsr6EQKapyclAb2JSYdb
	 BRqt7P8lXmgJm+kvBk0T41zKN3OdnGRwkZS/iDmAaVF6uz8vPPJVvz+VAB3YyHLuXg
	 bvBfZtd8CdxgosW++KV8lqud3FB0XcN0YdzUr3Z0rpT7c/iNmEau/uXVJ+Lunp1W8O
	 dmca7orepRxFtr4hmF6jXmgDcWr4yJQApSXNHqCwa8KVDHXZtLSBT8jlxJZUFJVvaD
	 NcKpRR3YWjJtYIk+z60NZaQLSB4zIzzQuyaptPu4hERHqTFuYT8YoYj0ZQ52eSJkgR
	 JkIfrkkHS0Vow==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-37a56a475e8so11555281fa.3
        for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 07:41:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVxtnQahIK266XtWo11SAlofvNewio6rt7E2Uyn6F35QRH1T9Y7fGTnEwPoX0c4ux8FlmuPCxJfhd5oJUKC7WU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXcoGtXFcDIL6OESpTxPNkzptjem4313egWLTxbuj37119PzQ8
	pEhBhC2kI5qwGb+TL6azapPhayj4Q4VijCZyGIdbNhfMpYMLB6QFOOJfWL1Ue/0g/o3icqg4b88
	aHS+qt69uiwXimdxwIL8zq7Dg0u5DSJY=
X-Google-Smtp-Source: AGHT+IEr5iB3y/yhQhlzfLl0WouWT4D2DB6qV4v7yx0qlVJ+llTi3bmx1k8kk/xynOW3ksMDP5G9MaudsgA9JXFjMH8=
X-Received: by 2002:a05:6512:3188:b0:595:9d90:5dc6 with SMTP id
 2adb3069b0e04-596a3ecd4d0mr8694338e87.19.1764258060115; Thu, 27 Nov 2025
 07:41:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127092226.1439196-8-ardb+git@google.com> <b1dae5a7-27bd-42de-bcce-9fd3c2b1c178@arm.com>
 <CAMj1kXE-Qm4DQNAcg8Tg7YM4EMdLBu_UJm7M8Cpk3t5g7XqP5w@mail.gmail.com>
 <e996fdd5-7113-4327-a884-336dd5f77c4d@arm.com> <CAMj1kXGyYMy2xhcdNicHkMfWBnEjyhc+xg8ciuR-6WXDxDpZxg@mail.gmail.com>
In-Reply-To: <CAMj1kXGyYMy2xhcdNicHkMfWBnEjyhc+xg8ciuR-6WXDxDpZxg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 27 Nov 2025 16:40:48 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE0f5j_T6YVGrQF3G+u=QsjAVKdJfdMZ2a_ss7E5-upRA@mail.gmail.com>
X-Gm-Features: AWmQ_bk7bPe_sQz9kUKjfz_fWU9_uzGqLWbNP8titLOMzUkkNUwQQEvuQp7faTw
Message-ID: <CAMj1kXE0f5j_T6YVGrQF3G+u=QsjAVKdJfdMZ2a_ss7E5-upRA@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 0/6] Improve get_random_u8() for use in randomize kstack
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Jeremy Linton <jeremy.linton@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Nov 2025 at 16:03, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 27 Nov 2025 at 15:18, Ryan Roberts <ryan.roberts@arm.com> wrote:
> >
> > On 27/11/2025 12:28, Ard Biesheuvel wrote:
> > > On Thu, 27 Nov 2025 at 13:12, Ryan Roberts <ryan.roberts@arm.com> wrote:
> > >>
> > >> On 27/11/2025 09:22, Ard Biesheuvel wrote:
> > >>> From: Ard Biesheuvel <ardb@kernel.org>
> > >>>
> > >>> Ryan reports that get_random_u16() is dominant in the performance
> > >>> profiling of syscall entry when kstack randomization is enabled [0].
> > >>>
> > >>> This is the reason many architectures rely on a counter instead, and
> > >>> that, in turn, is the reason for the convoluted way the (pseudo-)entropy
> > >>> is gathered and recorded in a per-CPU variable.
> > >>>
> > >>> Let's try to make the get_random_uXX() fast path faster, and switch to
> > >>> get_random_u8() so that we'll hit the slow path 2x less often. Then,
> > >>> wire it up in the syscall entry path, replacing the per-CPU variable,
> > >>> making the logic at syscall exit redundant.
> > >>
> > >> I ran the same set of syscall benchmarks for this series as I've done for my
> > >> series.
> > >>
> > >
> > > Thanks!
> > >
> > >
> > >> The baseline is v6.18-rc5 with stack randomization turned *off*. So I'm showing
> > >> performance cost of turning it on without any changes to the implementation,
> > >> then the reduced performance cost of turning it on with my changes applied, and
> > >> finally cost of turning it on with Ard's changes applied:
> > >>
> > >> arm64 (AWS Graviton3):
> > >> +-----------------+--------------+-------------+---------------+-----------------+
> > >> | Benchmark       | Result Class |   v6.18-rc5 | per-task-prng | fast-get-random |
> > >> |                 |              | rndstack-on |               |                 |
> > >> +=================+==============+=============+===============+=================+
> > >> | syscall/getpid  | mean (ns)    |  (R) 15.62% |     (R) 3.43% |      (R) 11.93% |
> > >> |                 | p99 (ns)     | (R) 155.01% |     (R) 3.20% |      (R) 11.00% |
> > >> |                 | p99.9 (ns)   | (R) 156.71% |     (R) 2.93% |      (R) 11.39% |
> > >> +-----------------+--------------+-------------+---------------+-----------------+
> > >> | syscall/getppid | mean (ns)    |  (R) 14.09% |     (R) 2.12% |      (R) 10.44% |
> > >> |                 | p99 (ns)     | (R) 152.81% |         1.55% |       (R) 9.94% |
> > >> |                 | p99.9 (ns)   | (R) 153.67% |         1.77% |       (R) 9.83% |
> > >> +-----------------+--------------+-------------+---------------+-----------------+
> > >> | syscall/invalid | mean (ns)    |  (R) 13.89% |     (R) 3.32% |      (R) 10.39% |
> > >> |                 | p99 (ns)     | (R) 165.82% |     (R) 3.51% |      (R) 10.72% |
> > >> |                 | p99.9 (ns)   | (R) 168.83% |     (R) 3.77% |      (R) 11.03% |
> > >> +-----------------+--------------+-------------+---------------+-----------------+
> > >>
> > >
> > > What does the (R) mean?
> > >
> > >> So this fixes the tail problem. I guess get_random_u8() only takes the slow path
> > >> every 768 calls, whereas get_random_u16() took it every 384 calls. I'm not sure
> > >> that fully explains it though.
> > >>
> > >> But it's still a 10% cost on average.
> > >>
> > >> Personally I think 10% syscall cost is too much to pay for 6 bits of stack
> > >> randomisation. 3% is better, but still higher than we would all prefer, I'm sure.
> > >>
> > >
> > > Interesting!
> > >
> > > So the only thing that get_random_u8() does that could explain the
> > > delta is calling into the scheduler on preempt_enable(), given that it
> > > does very little beyond that.
> > >
> > > Would you mind repeating this experiment after changing the
> > > put_cpu_var() to preempt_enable_no_resched(), to test this theory?
> >
> > This has no impact on performance.
> >
>
> Thanks. But this is really rather surprising: what else could be
> taking up that time, given that on the fast path, there are only some
> loads and stores to the buffer, and a cmpxchg64_local(). Could it be
> the latter that is causing so much latency? I suppose the local
> cmpxchg() semantics don't really exist on arm64, and this uses the
> exact same LSE instruction that would be used for an ordinary
> cmpxchg(), unlike on x86 where it appears to omit the LOCK prefix.
>

FWIW, my naive get_random_u8() benchmark slows down by 3x on x86 if I
replace cmpxchg64_local() with cmpxchg64(), so I suspect the above
comparison will look different on x86 too.
