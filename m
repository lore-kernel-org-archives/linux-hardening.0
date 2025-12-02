Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21AD212548
	for <linux-hardening@vger.kernel.org>; Tue,  2 Dec 2025 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764668839; cv=none; b=E+wP4uYjdZKUgpZ7Af7XgzexjnVgFMbjlEsNOLJ6Ba2n0WBPlKIahFCnImsxCJd3W3WWE6ZJbNJs6Msq5WhilCVaQ4/qw/XsBXqwM2QF+MzpgkUHVl4ygG93xMh7gNNLWgRGgMkZDhwf9NTm8Xj7i+nrm/BUeaqQbJva2Mb0res=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764668839; c=relaxed/simple;
	bh=5ggDXftwdZr/kTsZyKDnWSz0DzTJCd6ukt2EAH5tghM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LkiOonFiHmZMJn0CYR+efV08Kzmo3zPNpKWr9k0cIOz5IWm0L9MdQc2Hj5W5jRQijRy81XBWrM//BN/+rvvHCXiGJuveOpsO8W2iiOpvbw+vARgw2hKZTc8ltKejfGe1aG93SJ3kGJNSs+0nhaACGxOw0bwyiBattcsAZVderTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOR3NCVk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOR3NCVk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2D3C19425
	for <linux-hardening@vger.kernel.org>; Tue,  2 Dec 2025 09:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764668838;
	bh=5ggDXftwdZr/kTsZyKDnWSz0DzTJCd6ukt2EAH5tghM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oOR3NCVkUTKcZLzCQnKS9AfOiHWKsuRHm7IMmfCXKfG8+HAIt56xeLD37GepkuFQ5
	 6nYritOMIXdmKMXvtCku0B/KGA7VLY9aAQxNItEfwrBfBVBoimql8LavhO5aKbcSLk
	 8nPny2D8HJ7tNMXkhS9WqUjcIw9zg95n4RXIew0tmJ7t9fN6l4tcV6eeNlAvmc1Mzx
	 vFvNVkVv6UtTGgBUuC/loXp/spc4ovFU5u916QiwkG15tQZMQq1RerMPFrCLInlUF4
	 jLf4r5ZccL0c/h6PHWlXc5Ga8D70hJ4V3Hq9kVmmODwewqH3H/k+80AWbjDpV46gpx
	 xRtJIGC5SF7Mw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5959b2f3fc9so129180e87.2
        for <linux-hardening@vger.kernel.org>; Tue, 02 Dec 2025 01:47:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXHqwLcu399dib3xnBdf0ogi8e9CAVNm57iS12xSRVIsvv5srhMGAdBJzsFECAg6RRQ7EstvogMQfygFF4AFIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIJtTutL+q7V6pChQpk969RbHv54oeAWFWjmPPR/eBRvteU9t7
	LcRvVmPC5a88PU4/vsXBw4zmbmUXLpz8L3jXHJHN30WbEzRFCxPrry0qxzZ6G48Mt5xQWmxFMB9
	2xbTTDR8ShnemIA8u3odapUBUh4rzOoA=
X-Google-Smtp-Source: AGHT+IHt+dLC0PQ/Cdu+pC9RBnvFwH7KuKgNQh4NNTHSUTzn9hzUskV3Z4v5k5DuB6/FecC6kDqHzAlpDCFJyoBoYVU=
X-Received: by 2002:a05:6512:1154:b0:595:7876:7b78 with SMTP id
 2adb3069b0e04-596a3eac7edmr14275988e87.15.1764668836817; Tue, 02 Dec 2025
 01:47:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127105958.2427758-1-ryan.roberts@arm.com>
 <20251127105958.2427758-3-ryan.roberts@arm.com> <CAMj1kXFY1RXk8T4f46bkm_sr0nJfBoO+ii68JK4+CsRiDwKdCg@mail.gmail.com>
 <9097505d-b18b-4f85-a02c-7f2865ad8bca@arm.com> <CAMj1kXHX1W2Kz5NJehtzDhOCKWEd6y1sp8+ViOMHGsq9e8=7Pw@mail.gmail.com>
 <aS6ylpLIyDZOvBDB@J2N7QTR9R3>
In-Reply-To: <aS6ylpLIyDZOvBDB@J2N7QTR9R3>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 2 Dec 2025 10:47:04 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG=HDVso1xc6TGgSrBpV3Sq2YQLdPKg2dw5z9qdrbdWBw@mail.gmail.com>
X-Gm-Features: AWmQ_blCgBuasVYCdeSRmkAklRBD9CiSjWrO_9R_rpE8NZAt2_O4xueJjWI6XLM
Message-ID: <CAMj1kXG=HDVso1xc6TGgSrBpV3Sq2YQLdPKg2dw5z9qdrbdWBw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/2] randomize_kstack: Unify random source across arches
To: Mark Rutland <mark.rutland@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Kees Cook <kees@kernel.org>, 
	Ard Biesheuvel <ardb+git@google.com>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Jeremy Linton <jeremy.linton@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Dec 2025 at 10:35, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Dec 02, 2025 at 10:15:22AM +0100, Ard Biesheuvel wrote:
> > On Mon, 1 Dec 2025 at 19:20, Ryan Roberts <ryan.roberts@arm.com> wrote:
> > > On 28/11/2025 11:01, Ard Biesheuvel wrote:
> > > > On Thu, 27 Nov 2025 at 12:00, Ryan Roberts <ryan.roberts@arm.com> wrote:
> > > >> diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
> > > >> index 089b1432f7e6..83c7e6710f6d 100644
> > > >> --- a/include/linux/randomize_kstack.h
> > > >> +++ b/include/linux/randomize_kstack.h
> > > >> @@ -6,6 +6,7 @@
> > > >>  #include <linux/kernel.h>
> > > >>  #include <linux/jump_label.h>
> > > >>  #include <linux/percpu-defs.h>
> > > >> +#include <linux/prandom.h>
> > > >>
> > > >>  DECLARE_STATIC_KEY_MAYBE(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
> > > >>                          randomize_kstack_offset);
> > > >> @@ -45,9 +46,13 @@ DECLARE_STATIC_KEY_MAYBE(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
> > > >>  #define KSTACK_OFFSET_MAX(x)   ((x) & 0b1111111100)
> > > >>  #endif
> > > >>
> > > >> +static __always_inline u32 get_update_kstack_offset(void)
> > > >> +{
> > > >> +       return prandom_u32_state(&current->kstack_rnd_state);
> > >
> > > I've got bot warnings because this is being called from noinstr code. I guess
> > > the best option is to just move add_random_kstack_offset() to after
> > > instrumentation is enabled for the affected arches.
> >
> > Just put instrumentation_begin()/instrumentation_end() around the call
> > to prandom_u32_state() - that seems to be the common approach for
> > punching holes into the 'noinstr' validation.
>
> That silences the warning, but isn't necessarily safe, so please DO NOT
> do that blindly.

Oops - sorry about that.

> The instrumentation_{begin,end}() annotations are only
> supposed to be used when we know by construction that instrumentation is
> safe.
>
> Generally, if you can move this to after instrumentation is already
> enabled, that should be safe, and so that'd be the better approach.
>
> Ryan, can you share those warnings (e.g. link to those reports)?
>
> IIUC only x86 has noinstr validation, and from a quick scan, I expect
> you see warnings from:
>
> * do_syscall_64()
> * do_int80_syscall_32()
> * __do_fast_syscall_32()
>
> For all of these, it is not safe to call instrumentable code before the
> calls to {syscall_,}enter_from_user_mode{,_prepare}(). You'll need to
> move the stack rnadomization after the existing instrumentation_begin()
> calls.
>
> We'll need to go check the other architectures similarly.
>

Given that prandom_u32_state() does a fairly straight-forward mangle
of 4 32-bit words, might it be better to make that __always_inline
itself?
