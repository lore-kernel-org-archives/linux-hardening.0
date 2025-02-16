Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6FD42070;
	Sun, 16 Feb 2025 23:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739749964; cv=none; b=U+eDqfcjNQPz7dvzwQJHAJhXRXGfiaFSmFU/1lZMyDw1ZZTPEzmpE89POkYj0AA+e/wsxZHGlQU8T7d5oRyPpcUlGzLlrR8vC0FnTibs9DNyRRDaWsV5fETjzk9j6i9chl9fhcsNSqzU0lePHX1/GdFkVEiOQO9KLSPPfWa6p8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739749964; c=relaxed/simple;
	bh=3L4tlo2c89d3kSO8HthDGeRHFhL9r4lRwxE1YOMYINg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6P7tW7ZEERVD5TGuLc0NH0s0In5C3goqBkqWRvnVj8qkeqBDtBWQ8YHlEkndZqWXLcsart+lsbW5X2FjLuaQk6zc8eezNKHmN6Xw63o+tCYUANV8+kmD7LSxhVhy0gdDJmNjCNBjQJ3I2AwDE0RnNatIMI0JUNfDdTo7dH1jDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmJPh0sI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmJPh0sI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2FCC4CEDD;
	Sun, 16 Feb 2025 23:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739749963;
	bh=3L4tlo2c89d3kSO8HthDGeRHFhL9r4lRwxE1YOMYINg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XmJPh0sIU2EOQbr30hukSMw+vM9rIDRJ1pNQqFVjfkXpRaQ+Vu5ETrd5ybFmVwcnO
	 +OvFRWiSc/lCJBl+Gz6jwx2YPYGNrdOEqKwFVBlxM1QX46aksCY8x1Fek1YFoKO+I+
	 lQAOhAVXLmoYF3oOJQIq10FLjRZesPEUNzhQzcxnKYk82+GQ+VnAfTWf+KF5+vHoy6
	 z3Jsgme7ZWkCF79KbjVjJBbhHtP/YZIv1mBKlboGyIHc38UuwgU1WKRSD+mFgFYv0i
	 FzLddAB/uO/GTFFMT6ZcuHvO9Op2XUeQbURgtj+cgVUCZmnr8SzjPvmokcMcoTd+od
	 vw7lFNoYm+rBw==
Date: Sun, 16 Feb 2025 15:52:40 -0800
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
Message-ID: <202502161552.54EA17D@keescook>
References: <20250214192210.work.253-kees@kernel.org>
 <5d26bcdf-0e72-45b6-98c5-f90481650f09@citrix.com>
 <202502141345.C78A253D@keescook>
 <7ae6ee84-b5ae-479b-b963-9e9aefcd3bfa@citrix.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ae6ee84-b5ae-479b-b963-9e9aefcd3bfa@citrix.com>

On Fri, Feb 14, 2025 at 10:40:28PM +0000, Andrew Cooper wrote:
> On 14/02/2025 9:54 pm, Kees Cook wrote:
> > On Fri, Feb 14, 2025 at 07:39:20PM +0000, Andrew Cooper wrote:
> >> Architecturally, FineIBT without FRED seems to be no improvement over
> >> simple IBT.  (I'd love to find some way of hardening the entrypoints,
> >> but I can't see a robust way of doing so.)
> > If you're just looking at IBT, yes. But kCFI (with or without IBT,
> > but without FineIBT) will do hash checking at the call site, which
> > should make it impossible to reach the entrypoints from an indirect call
> > in the first place, as they have no hash preceding them.
> >
> >> However, micro-architecturally, FineIBT is still far better than simple
> >> IBT for speculation issue, seeing as Intel keep on staunchly refusing to
> >> turn off the indirect predictors by default like AMD do.
> >>
> >> A security conscious user ought to be using FineIBT for this, given a
> >> choice, even if it's not perfect in other regards.
> > A security conscious user should use kCFI without FineIBT. :) But I
> > think we might be thinking about different elements of security. I am
> > focusing on control flow, and I think you're considering speculation?
> 
> True.  The security realist knows they're dammed either way, and gets a
> stiff drink instead.

I don't know how any of our livers survive. :)

-- 
Kees Cook
