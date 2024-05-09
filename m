Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808327F465;
	Thu,  9 May 2024 19:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715282947; cv=none; b=qc9j5iacRAMykoc1f70HhYcY53o+ZXM7YjSo/61OWbfUDPLoiKPhcGmv61u2u6YQM4DiDOeWLrwr5KdrKZ2//z5J4quU/lu45l5e8p+C/1uqV68DZ4CLmsJyAtUgmqutxhHq86yUhsh5UZhlVSSPv3fMfNb1mrccUzQ66aLsq9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715282947; c=relaxed/simple;
	bh=7lftxlv9wEF1ddQ55k2x1+2S4dEoTFNglUMUFySifiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPEcfswu8GRJyj3yT3ptBZ1EOXv/nQbQbTHYgrQMdBFrX5d0SUjp3FoQieGAdVke4sPwAbQVAOS/+7q3l+ChoXiB9sJYHJE7g4RFwPl/SGoI4sZ61q/0YlJeZQnSeF/Kfp3TQcMO8OjXOAoq5WkQEhHgOpCPCJYvGUIa5F659bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KyrBk4hn; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KyrBk4hn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z1llagJFAL/05c0Kzkink3vtBANBjNfoALhnE+We9jU=; b=KyrBk4hnz7mN+mqux89XujaRDV
	KVyj01oBpRIIAyFVrIfrueQkCPCuyBSYUKV0wt499W1oLYoiPgaUuD68PeBmKBgZwgqTt3pwBWwh7
	eHg9J0aF9oov2Sh3wcnz5/HkA1l5sW6e6NQOiKuaISa9Y3b5M2MzQ9zEX68dUpt4sRb5NfW53G0Ly
	Oj8z6ygBO/my30Pub12hkNOXqhyzpHvQWsjAXwchBtzAn3BJBiDmEHFsptlhYXy79TxO3Bq8cfgKV
	jghxdh1w3u5xeRrdODDeufzzziB17pUIb6JehRYhqg52w6NmgTNN3zngwLPy5lCpRcrb11Z1xyb9r
	cW9zIdFw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s59Rm-001bjR-1J;
	Thu, 09 May 2024 19:28:54 +0000
Date: Thu, 9 May 2024 20:28:54 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Kees Cook <keescook@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
Message-ID: <20240509192854.GT2118490@ZenIV>
References: <202405081354.B0A8194B3C@keescook>
 <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
 <202405081949.0565810E46@keescook>
 <20240509140854.GF3620298@mit.edu>
 <CAHk-=wgKyP2ffZPa6aKYtytzzFibiNVN5MS=D2cn7_UGCECKdw@mail.gmail.com>
 <20240509175417.GR2118490@ZenIV>
 <CAHk-=wgXm15gZHvt8waSFhXS9yZTfvMV95xyvNtPc6FSEA_rvA@mail.gmail.com>
 <CAHk-=wgBprh=8Us-MtwH9sVNELZK2hdOkFn3EoauwecYgtXOCQ@mail.gmail.com>
 <20240509184806.GS2118490@ZenIV>
 <CAHk-=wjHA8Di-cpT0pKcScwcWNVYRFvmhBwMrug=Mj5WUwa2rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjHA8Di-cpT0pKcScwcWNVYRFvmhBwMrug=Mj5WUwa2rw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, May 09, 2024 at 12:15:40PM -0700, Linus Torvalds wrote:
> On Thu, 9 May 2024 at 11:48, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > FWIW, the thing that somewhat worries me about having a helper along
> > the lines of combine_to_u64(low, high) is that
> >         foo->splat = combine_to_u64(something, something_else);
> > would be inviting hard-to-catch brainos -
> >         foo->splat = combine_to_u64(something_else, something);
> 
> Yeah, we'd have to be very clear about naming and ordering. So it
> would probably have to be something like
> 
>         result = combine_to_u64_hi_lo(high, low);
> 
> to be easy to use.
> 
> The good news is that if you *do* get it wrong despite clear naming,
> the resulting value will be so obviously wrong that it's generally a
> "Duh!" thing if you do any testing what-so-ever.
> 
> Of course, I say that as somebody who always points out that I haven't
> tested my own patches at all, and they are "something like this,
> perhaps?".
> 
> But having "hi_lo" kind of naming would hopefully make it really
> obvious even when just looking at the source code.

Or something like
	result = to_high32(high) | to_low32(low);
perhaps? ;-)

Re amusing things found by grepping:
		unsafe_get_user(lo, &__c->sig[1], label);               \
		unsafe_get_user(hi, &__c->sig[0], label);               \
		__s->sig[0] = hi | (((long)lo) << 32);                  \
(compat.h, be64 unsafe_get_compat_sigset())

It is correct, actually, but here 'hi' is 'signals in range 0..31' and
'lo' - 'signals in range 32..63'.  Introduced in fb05121fd6a2
"signal: Add unsafe_get_compat_sigset()", looks like nobody had read
it carefully enough for a WTF moment - at least no replies along the
lines of 'might be a good idea to use less confusing names' anywhere
on lore...
