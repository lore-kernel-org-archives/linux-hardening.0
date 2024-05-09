Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229A41DFC5;
	Thu,  9 May 2024 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715280497; cv=none; b=jtgDA/JyJ3SEv2JKESPbg34e2uUZwOWc6Nc2c7BPtDzuyrG2xFI1dqN/nashir9Z2Zb6ocIcmtkhwU69vKSyCb7/b2G8RhCJ3TTX1/1lPxaqPMoh9nvKUjUMyjPogix7WNJrLs0rPqpv/plw3FA2vpj8BJ6dOPv3xaoJsUMkzJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715280497; c=relaxed/simple;
	bh=1BSYGbRj20fcncP91U6HQrKo4dwZ7O7Jy8mAFNMP1P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLIUsamZq0rcZrfgLL4cXEeGQg2ttdbb3cTWV1TidGR8fP3lChflv+jhTGOSWIbax8DIhzzLggRuFlUDLM5LgZEX3WW+VQ6Y7+3V4XnJsoktbP9+7DSuybvUEB7ElmeeKSi3EVCBB4lUsd/U/SAnNFnHRKa/e76rexY2QOVntUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=AvkdCCHo; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AvkdCCHo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yBryuhVbsX5G3JIiC63QtWbHWndrg7Hoc/s31avaLsE=; b=AvkdCCHogDEzcSiyCZF9dw8g6C
	X0KeSZgV2EK402V6yxvAwPmbn7429/LnT4kQIi7nxgjrMtCKjnGGpe7du0estIZIR5w3Hk1HrlSrt
	0VlzNB/Az8nveVmrkmhksokw4gW0Ldvvat06ZwlLp9sItdIdgbKxmV4fHVK+OvHWnu7C7yJBl1qqG
	6QaayOuZ6oPROTo+d3CqRK1fjiNBagrMQywGZX/FwSz3BF3STd01IQl2p2QYE9Au+S0v7rDztXMG8
	ZrqqnzGmuxYIOaM3TVvA2ro1J+NwQXnJmxFTFsjxJJpRxoJGun6kn3VYo7MNd7u38UDIV3ledqTX5
	fWvGPxpw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s58oI-001Wl4-0D;
	Thu, 09 May 2024 18:48:06 +0000
Date: Thu, 9 May 2024 19:48:06 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Kees Cook <keescook@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
Message-ID: <20240509184806.GS2118490@ZenIV>
References: <202405081144.D5FCC44A@keescook>
 <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook>
 <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
 <202405081949.0565810E46@keescook>
 <20240509140854.GF3620298@mit.edu>
 <CAHk-=wgKyP2ffZPa6aKYtytzzFibiNVN5MS=D2cn7_UGCECKdw@mail.gmail.com>
 <20240509175417.GR2118490@ZenIV>
 <CAHk-=wgXm15gZHvt8waSFhXS9yZTfvMV95xyvNtPc6FSEA_rvA@mail.gmail.com>
 <CAHk-=wgBprh=8Us-MtwH9sVNELZK2hdOkFn3EoauwecYgtXOCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgBprh=8Us-MtwH9sVNELZK2hdOkFn3EoauwecYgtXOCQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, May 09, 2024 at 11:39:04AM -0700, Linus Torvalds wrote:

> .. it might also actually be a good idea *IF* we were to have some
> kind of "implicit cast drops bits" warning, in that the compiler for
> that case wouldn't remove the upper bits calculation, but would
> trigger a warning if they are non-zero.
> 
> So there are actually potential advantages to just always apparently
> doing the full 64-bit arithmetic.
> 
> Without debug warnings, it's a no-op that the compiler will just skip.
> And with some hypothetical debug flag, it would be a "you are now
> losing the high bits of the time value when assigning the result to a
> limited 32-bit time_t" warning.

FWIW, the thing that somewhat worries me about having a helper along
the lines of combine_to_u64(low, high) is that
	foo->splat = combine_to_u64(something, something_else);
would be inviting hard-to-catch brainos -
	foo->splat = combine_to_u64(something_else, something);
would be very hard to catch on RTFS, especially when you'd been
staring at that code for a long time.  Explicitly spelled out
it would be obvious which goes into bits 0..31 and which in 32..64.
