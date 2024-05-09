Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC8215CD7D
	for <linux-hardening@vger.kernel.org>; Thu,  9 May 2024 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715263762; cv=none; b=Nb8xEqOlv6yE9sjWXGHCx9h9SzVKcc1ISASxqt03/pyOqJBDzjy2zsj3TLBDc1zz7bxKXY1JbCAG9oJyaZlzOF3XsHklKRmClfI5ARZg1JF2CwHnmiVikrRrJCE4ghNXsEcUlhqjcTB29BCatpTH1jnfUGv47i68gnCpzBziYNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715263762; c=relaxed/simple;
	bh=bDtjaP+V9cNNcRR6gQ6xBNCDLfECgvJQYpI7pGbQcNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7Dph8L/1YI1GIYizVVk+odvmezxjv8ExFTQ7nMqZKrmNKuWqfmrGzYghV5xYI7V2+E06YHXmmX69MwrdyXx6Lc0NmQ4Tuggzm312FgpjM/b/9FGIzdZfwwyOUnVRECnmGoy0UoOfx5GdxgpGH5j5KMjlEBWWd2YIAhPFDZ1jXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=SV/L7qne; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="SV/L7qne"
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 449E8s2L030572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 May 2024 10:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1715263737; bh=XxIwd5YKnaE8tpaDDWso8SeLqi8X1R5IdpdBS5HW8MA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=SV/L7qneh5rtjlelL+8GnEOpp4vpOJv/fLJ2OiI0gTeX2do9nvZktzGfc8e8jXGJb
	 ctB78KcRwIkz5IlkYvd6UF/ftvNdA6c3LFVbQvMM81he9Cei67CAh/x1mTYU2XxhXk
	 +gLCHwot5DFmHjNE76S3B+BYx1k3Kh21Ji3sHCowoyVH7y+oTrzflqqPedQtbnxiDw
	 nPhAE82WnR9b3MNtIsf6EIDAGm1Hc19aWWQKGAPwtySmKyUw2rR0nQM8chDs2iIswe
	 4C/8ivf9Fb5MgxtWddSgTtwpk9B47xCCtm/Md7m1tzz9+BFcHz2MYvNOuwPAcJjelm
	 QQKlRE0ZoJbfg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 69CF715C026D; Thu, 09 May 2024 10:08:54 -0400 (EDT)
Date: Thu, 9 May 2024 10:08:54 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Justin Stitt <justinstitt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
Message-ID: <20240509140854.GF3620298@mit.edu>
References: <202404291502.612E0A10@keescook>
 <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook>
 <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook>
 <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
 <202405081949.0565810E46@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405081949.0565810E46@keescook>

On Wed, May 08, 2024 at 11:11:35PM -0700, Kees Cook wrote:
> > I think it would be interesting in general to have some kind of
> > warning for "implicit cast drops bits".
> > 
> > I fear that we'd have an enormous about of them, and maybe they'd be
> > unsolvable without making the code *much* uglier (and sometimes the
> > fix might be to add an explicit cast to document intentionally dropped
> > bits, but explicit casts have their own issues).

Seapking of which, I recently had to work around an overactive
compiler UBSAN which complained about this:

struct ext2_super {
       ...
       __u32	time_lo;
       __u32	time_high;
       ...
}

	time_t	now;
	
	sb->time_low = now;
	sb->time_high = now >> 32;

This is obviously (to a human) correct, but because of stupid compiler
tricks, in order to silence compiler-level and ubsan complaints, this
got turned into:


	sb->time_low = now & 0xffffffff;
#if (SIZEOF_TIME_T > 4)
	sb->time_high = (now >> 32) & EXT4_EPOCH_MASK;
#else
	sb->time_high = 0;
#endif

and in the opposite case, I was forced to write:

#if (SIZEOF_TIME_T == 4)
	return *lo;
#else
	return ((time_t)(*hi) << 32) | *lo;
#endif

... and this made me very sad.  Grumble....

				- Ted

