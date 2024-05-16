Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8149D14D2B3;
	Thu, 16 May 2024 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715866234; cv=none; b=LEaYEBiLTQDQAnvXm0En2QFJKnLvvTm/zBfN4pT6LtHJ6Y/8wBiZt7UJ/T/id0LwelL5P1Fq7o/jgiqSVNRx7IFxi0Qy5pC9CMAgAB6Drk23ZoA72ACxcuczGHuuDM4JezDWAQWbtAlwR2SiY4qdxUmBj7Uv+zKjju8jxR62PtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715866234; c=relaxed/simple;
	bh=z8BnU2Is6DFB6KVcEKYw3pqMsABrzURYamS+ST69Qk0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ZItztftFVjxn/tMp3b9hZ4xEZnJP6wcl1Ji6HLngBKcVXGIHM2Q+JFNDwqunP44JLWwPd8hKahrUfpNYzSmbPa9ONg1oB6/ASUf2be5kXEIAS6Ennk32nUtD75E99y4jmv+OKysHAdGEyr7pVbyq+FyQxoTHIX+PUMwialGI+eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHwLq/uJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHwLq/uJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4131C113CC;
	Thu, 16 May 2024 13:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715866234;
	bh=z8BnU2Is6DFB6KVcEKYw3pqMsABrzURYamS+ST69Qk0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=PHwLq/uJvoN0fU1gNykdMOT0phruqPrBSqb5l+yRgMUgegRuGl0R4RVb/VQNKldo1
	 mkkrYXbLB3d90j6KBRyAiuzhzE+wD7cwQViOMeIvc+RIHQoh4CRKYXTMeLoYtm5TD9
	 AOsZ4N23KBJIcUFYJtlyZfelrFo5K+/PtJG4THL+kze4j1SPTxfaW0h0xnSKkq198s
	 JYKbDN/WqRLEdSEmlq8TnWU+BozS/3PKiVf7mdKMicq/hW3emTwXiRawbH4XAQIAjK
	 Wc+YRgcTtWW2ykVjX2w7Pi/kOPaTnAIK+pItqhkJTz04bWGClvurKfg/r4q6DEohA1
	 CxGmVALL3FaTg==
Date: Thu, 16 May 2024 06:30:32 -0700
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
CC: Kees Cook <keescook@chromium.org>, Justin Stitt <justinstitt@google.com>,
 Mark Rutland <mark.rutland@arm.com>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
User-Agent: K-9 Mail for Android
In-Reply-To: <20240515073636.GY40213@noisy.programming.kicks-ass.net>
References: <202404291502.612E0A10@keescook> <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com> <202405081144.D5FCC44A@keescook> <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com> <202405081354.B0A8194B3C@keescook> <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com> <20240515073636.GY40213@noisy.programming.kicks-ass.net>
Message-ID: <25882715-FE44-44C0-BB9B-57F2E7D1F0F9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On May 15, 2024 12:36:36 AM PDT, Peter Zijlstra <peterz@infradead=2Eorg> w=
rote:
>On Wed, May 08, 2024 at 04:47:25PM -0700, Linus Torvalds wrote:
>> For example, the most common case of overflow we've ever had has very
>> much been array indexing=2E Now, sometimes that has actually been actua=
l
>> undefined behavior, because it's been overflow in signed variables,
>> and those are "easy" to find in the sense that you just say "no, can't
>> do that"=2E UBSAN finds them, and that's good=2E
>
>We build with -fno-strict-overflow, which implies -fwrapv, which removes
>the UB from signed overflow by mandating 2s complement=2E

I am a broken record=2E :) This is _not_ about undefined behavior=2E

This is about finding a way to make the intent of C authors unambiguous=2E=
 That overflow wraps is well defined=2E It is not always _desired_=2E C has=
 no way to distinguish between the two cases=2E

-Kees

--=20
Kees Cook
