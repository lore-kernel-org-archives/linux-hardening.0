Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BE23DDDB2;
	Tue, 31 Mar 2026 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774972620; cv=none; b=K4Ft3Ae6RvRbjwYCmIjX8YOr5jt8hpMzhXZzkjKglQJ4nfgL6KMfMz0Wc/MBhjNdweEYViTkk27zRNl008wvZ0gCJ29wMCc7p5mwOaPdvJO9xFk23EKztLaVgWgbF7I/ddayKe1tULcEnPp+7xwmylx/0GBLJjX7rdLqHWa3pNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774972620; c=relaxed/simple;
	bh=cMB/hxflKGdMnWo7hIlIqDPGCm8N+gymbuXM5qpBwug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDzcBE0Q9VKo5tC0QmuuJroAUebeo349z2/8v4KJ/oGhvrA+tJAh2am6X6Owk8ORtURY7qS0gW5bJWN37ZSwP25guOFern3mYJHxK0D2PW+1Sa4+57XhxO60xyU1X3F6DpZ2zFevpGI6fHfucd5F9B0+l2mp0pGzEknvaU4UkEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W85sgUYc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W85sgUYc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEF8C19423;
	Tue, 31 Mar 2026 15:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774972619;
	bh=cMB/hxflKGdMnWo7hIlIqDPGCm8N+gymbuXM5qpBwug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W85sgUYc/UUp7TF8tFrfLKZ9mXjxmRh/qTSx1kMGT44p+DJ1e86yVVC/jpS+EZi/h
	 /iXKvgCAgLbJPa4+1E2HMOMtBRz/pTuwxCJ8VqFqU5h/F/cZAjoT+TxBMm28IT0VKX
	 EWteg6xZRntKhtuVW+S9XMD10atrf3x0mCieNWlpBwfelEnL1qplsal3+W9vIaKInP
	 GYd291LRt7l5zu3tIAw6EFzXN8Mr6DxwCmVeE36r8/FNXqslLLTdna6+uW/nqYJDVm
	 izmY/dO0nP1iTwu5uefN/M1cCOj81JbaCc9wusteUfyDLHv/VQkIqFmiumK/GDGYMg
	 IHnil7OtVVVSQ==
Date: Tue, 31 Mar 2026 08:56:59 -0700
From: Kees Cook <kees@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next 2/3] fortify: Optimise strnlen()
Message-ID: <202603310853.E7248DDB5@keescook>
References: <20260330132003.3379-1-david.laight.linux@gmail.com>
 <20260330132003.3379-3-david.laight.linux@gmail.com>
 <202603302335.0AEEF9154@keescook>
 <20260331111428.0b0575dd@pumpkin>
 <20260331155541.0451cb29@pumpkin>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331155541.0451cb29@pumpkin>

On Tue, Mar 31, 2026 at 03:55:41PM +0100, David Laight wrote:
> On Tue, 31 Mar 2026 11:14:28 +0100
> David Laight <david.laight.linux@gmail.com> wrote:
> 
> > On Mon, 30 Mar 2026 23:36:07 -0700
> > Kees Cook <kees@kernel.org> wrote:
> > 
> > > On Mon, Mar 30, 2026 at 02:20:02PM +0100, david.laight.linux@gmail.com wrote:  
> > > > From: David Laight <david.laight.linux@gmail.com>
> > > > 
> > > > If the string is constant there is no need to call __real_strlen()
> > > > even when maxlen is a variable - just return the smaller value.
> > > > 
> > > > If the size of the string variable is unknown fortify_panic() can't be
> > > > called, change the condition so that the compiler can optimise it away.
> > > > 
> > > > Change __compiletime_strlen(p) to return a 'non-constant' value
> > > > for non-constant strings (the same as __builtin_strlen()).
> > > > Simplify since it is only necessary to check that the size is constant
> > > > and that the last character is '\0'.
> > > > Explain why it is different from __builtin_strlen().
> > > > Update the kunit tests to match.    
> > > 
> > > See also
> > > commit d07c0acb4f41 ("fortify: Fix __compiletime_strlen() under UBSAN_BOUNDS_LOCAL")
> > > 
> > > -Kees
> ...

Your series does pass all the wacky corner case tests that got added
over the years, though I need to go through older GCC and Clang releases
to double-check. I've pushed a branch to kernel.org for 0day testing:
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=dev/v7.0-rc2/fortify-strlen

> > That really means you can only use __builtin_strlen().
> > Which means you'll get a compile-time error from:
> > 	char foo[3] = "foo";
> > 	__builtin_strlen(foo);
> > rather the 'not a constant' when checking strscpy(tgt, foo, 3);
> > At a guess that never happens except in the tests.
> 
> I wrote this change a while ago, I tried using __builtin_strlen()
> but got a compile error in the tests.
> 
> However I've just built an x86-64 allmodconfig kernel on top of
> my patches with:
> #define __compiletime_strlen(p) __builtin_strlen()
> so something must have changed since then (probably related to the
> __nonstring changes).
> 
> So the actual fix for the above is to use __builtin_strlen().
> IIRC it also detects a few more strings being constant.

Hrm, the "no NUL in the string" case is a weird one, but yeah, probably
hit by the __nonstring work.

Can you write up new test cases to validate what you're after? I can
update the branch I pushed.

-Kees

-- 
Kees Cook
