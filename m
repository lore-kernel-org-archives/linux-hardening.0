Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE43192D97;
	Fri, 14 Feb 2025 21:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739570063; cv=none; b=u/1PpHi9ac01XAhZ5CYo7clkgTaZldZDwfaySvLI3/s41cNs+yQsChSofMZAzVsB+cQWo5CoJ22XSBBS/iINOrKKNKqtEqnb9/ODDiP4ikUYsmX52wfATrbdNbbYDfboOZB0k6mHagFgyxg+ocvPhGfr829nJZMLxX/Crudo4nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739570063; c=relaxed/simple;
	bh=uRfKfjbgood2oZBoeQ7L8Qzh6eonOIzIT7jJrprzJRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcRwntYIN1rbBnt9pODQLeS0Hkk2u0FnoDhmPv/PV+cgXOCpALpSDKyltnF9XnZFLviHBrsQonJwRP2DHELejz1emL3o7WJtoizH7qxUcomqSGfkAEzSYVbotilJMHibMWZD93kVg2ogFQ3zvxM5+uhNDyXmFl2URNsO1gkZd5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUcsSmsV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUcsSmsV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F61C4CED1;
	Fri, 14 Feb 2025 21:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739570062;
	bh=uRfKfjbgood2oZBoeQ7L8Qzh6eonOIzIT7jJrprzJRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uUcsSmsVRmlwjw+ummZCIBP8j0khD0VzLni8PC8J+hQeZ10qTrMh9PvHuBObQpXJZ
	 820XbhgdKLruj1e8jyAbtP3xpLaNPRL6mzRM0gJudhLRkh4HkSo9coFtmXPLy64/7L
	 Om7pEurdwcMrkU+Fuw45nNwuXvbBbhwxzmRhnEAPigFR1HLwUnHQTUaapYvMGs7J9/
	 pSt7j7lHdUooyaDdCDlPcRxXsSE0nN4uM7qv+E1tbrg091aRrWOobRgYy9du+e8G3H
	 KDXeEGHvQSIk6/T5EIS1WKP0RI02ZbsLEaKPR8hSLIsix4nJYWyuRfcP0yetp+FEPx
	 1O7ENQQfhWulw==
Date: Fri, 14 Feb 2025 13:54:19 -0800
From: Kees Cook <kees@kernel.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Jennifer Miller <jmill@asu.edu>,
	Sami Tolvanen <samitolvanen@google.com>,
	Jann Horn <jannh@google.com>, Nathan Chancellor <nathan@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86/kcfi: Require FRED for FineIBT
Message-ID: <202502141345.C78A253D@keescook>
References: <20250214192210.work.253-kees@kernel.org>
 <5d26bcdf-0e72-45b6-98c5-f90481650f09@citrix.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d26bcdf-0e72-45b6-98c5-f90481650f09@citrix.com>

On Fri, Feb 14, 2025 at 07:39:20PM +0000, Andrew Cooper wrote:
> On 14/02/2025 7:22 pm, Kees Cook wrote:
> > diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
> > index ef5e0a698253..dfa2ba4cceca 100644
> > --- a/arch/x86/include/asm/cfi.h
> > +++ b/arch/x86/include/asm/cfi.h
> > @@ -93,7 +93,7 @@
> >   *
> >   */
> >  enum cfi_mode {
> > -	CFI_AUTO,	/* FineIBT if hardware has IBT, otherwise kCFI */
> > +	CFI_AUTO,	/* FineIBT if hardware has IBT, FRED, and XOM */
> 
> You discuss XOM in the commit message, but there's no check ...
> 
> >  	CFI_OFF,	/* Taditional / IBT depending on .config */
> >  	CFI_KCFI,	/* Optionally CALL_PADDING, IBT, RETPOLINE */
> >  	CFI_FINEIBT,	/* see arch/x86/kernel/alternative.c */
> > diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> > index 97422292b609..acc12a6efc18 100644
> > --- a/arch/x86/kernel/alternative.c
> > +++ b/arch/x86/kernel/alternative.c
> > @@ -1323,7 +1323,9 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
> >  
> >  	if (cfi_mode == CFI_AUTO) {
> >  		cfi_mode = CFI_KCFI;
> > -		if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT))
> > +		/* FineIBT requires IBT and will only be safe with FRED */
> > +		if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT) &&
> > +		    cpu_feature_enabled(X86_FEATURE_FRED))
> 
> ... here.
> 
> Is this meant to be "/* TODO: wire up XOM */" or is that accounted for
> somewhere else?

Yeah, I wasn't sure how to best capture that in here. XOM doesn't exist
yet for x86... I could add a TODO like that?

> Also, while I hate to come back and contradict myself from earlier...
> 
> Architecturally, FineIBT without FRED seems to be no improvement over
> simple IBT.  (I'd love to find some way of hardening the entrypoints,
> but I can't see a robust way of doing so.)

If you're just looking at IBT, yes. But kCFI (with or without IBT,
but without FineIBT) will do hash checking at the call site, which
should make it impossible to reach the entrypoints from an indirect call
in the first place, as they have no hash preceding them.

> However, micro-architecturally, FineIBT is still far better than simple
> IBT for speculation issue, seeing as Intel keep on staunchly refusing to
> turn off the indirect predictors by default like AMD do.
> 
> A security conscious user ought to be using FineIBT for this, given a
> choice, even if it's not perfect in other regards.

A security conscious user should use kCFI without FineIBT. :) But I
think we might be thinking about different elements of security. I am
focusing on control flow, and I think you're considering speculation?

-Kees

-- 
Kees Cook
