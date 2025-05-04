Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50672AE7C;
	Sun,  4 May 2025 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746348266; cv=none; b=SzUYfl/rVcEosBqe3Q0EH+ybWO4YW1GFSWsQ7XhyZWhXpN1Zp4hxcr6qTCiaUQTOnAR2XJskQBhYLm+EDnQARN8+yba85HbBf/G6/KCgUnfrEUlpj6x3AV/QD1huo36BndcHP0dcQiXXcISQ+Z0ChVvseOtd2diCRcJLHYJdbzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746348266; c=relaxed/simple;
	bh=DuZLt4NBgqyPvHNG4sC1zIFj3mL3e1JjsQxnA4j7FYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ww/kqp1SCm8GemUr6isGBQhAMGHX0yaadnuzlnYHCKaU4LcuiyxiXyBp0j1kNludOEaFAmahtRRQ4OAz8gXAzL+q/h/60TptBziWSQL6FSZYWf809jkdjqdW0Yvp+amEsBKQzKya42fDprVPoHHV/A+stdefglD8ODwJ7XXrIgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8eeP9SV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8eeP9SV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01F6C4CEE7;
	Sun,  4 May 2025 08:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746348265;
	bh=DuZLt4NBgqyPvHNG4sC1zIFj3mL3e1JjsQxnA4j7FYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U8eeP9SVPpUQP2vkf42qFVr6qWU0fqdNcgCv8yejCu2l0BA827/0qIf/kHvycanz3
	 vJJBcy9bsTp97bFLdZR1JYniNqR0C/aAyYM8LC7LWn4OiYCFU1PG39hAMNy3p1Z0a2
	 VGCAAkDa5fOqdUbUixcw/JJHZdvn0D1xirEu051LPvohbmD3me7NXWXO72rG+3iyXv
	 yyQ1X12TdSWp+wKc6SRRCHa+LCOfughW5rqdRvNYQdxqvcIZW8zSqD98Rrs8ZHXXnA
	 irFTKYhH0B+J0ohxiSedbnlasbmtQj+b25P368X6eYBwNueXXukYVqAF9QgtHLu/W9
	 wp37/NxLBvjpg==
Date: Sun, 4 May 2025 10:44:20 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: hardened_usercopy 32-bit (was: Re: [tip: x86/merge] x86/fpu:
 Make task_struct::thread constant size)
Message-ID: <aBco5IostuyCepaT@gmail.com>
References: <20250503120712.GJaBYG8A-D77MllFZ3@fat_crate.local>
 <aBcM7UXj8HQWZeHJ@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBcM7UXj8HQWZeHJ@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Borislav Petkov <bp@alien8.de> wrote:
> 
> > On Mon, Apr 14, 2025 at 07:34:48AM -0000, tip-bot2 for Ingo Molnar wrote:
> >
> > > The fpu_thread_struct_whitelist() quirk to hardened usercopy can be 
> > > removed, now that the FPU structure is not embedded in the task 
> > > struct anymore, which reduces text footprint a bit.
> > 
> > Well, hardened usercopy still doesn't like it on 32-bit, see splat below:
> > 
> > I did some debugging printks and here's what I see:
> > 
> > That's the loop in copy_uabi_to_xstate(), copying the first FPU state
> > - XFEATURE_FP - to the kernel buffer:
> > 
> > [    1.752756] copy_uabi_to_xstate: i: 0 dst: 0xcab11f40, offset: 0, size: 160, kbuf: 0x00000000, ubuf: 0xbfcbca80
> > [    1.754600] copy_from_buffer: dst: 0xcab11f40, src: 0xbfcbca80, size: 160
> > 
> > hardened wants to check it:
> > 
> > [    1.755823] __check_heap_object: ptr: 0xcab11f40, slap_address: 0xcab10000, size: 2944
> > [    1.757102] __check_heap_object: offset: 2112
> > 
> > and figures out it is in some weird offset 2112 from *task_struct* even
> > though:
> > 
> > [    1.750149] copy_uabi_to_xstate: sizeof(task_struct): 1984
> > 
> > btw, the buffer is big enough too:
> > 
> > [    1.749077] copy_uabi_to_xstate: sizeof(&fpstate->regs.xsave): 576
> > 
> > but then it decides to BUG because an overwrite attempt is being done on
> > task_struct which is bollocks now as struct fpu is not part of it anymore.
> > 
> > And this is where I'm all out of ideas so lemme CC folks.
> 
> Thx for the report, mind sending the exact .config that fails for you?

BTW., mind sending the full bootlog as well? I cannot reproduce it here 
with CONFIG_HARDENED_USERCOPY=y, so I suspect it's something about the 
build, HW or boot environment.

Thanks,

	Ingo
