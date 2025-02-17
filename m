Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C5A2135AF;
	Mon, 17 Feb 2025 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788801; cv=none; b=YkttcQOWGqps/LnAa0PwE948o7Wjp6PlN3Kn41DSZYqvedIrymUx5ZFHE7wb0ESiOx4/rYi4yBnv+eLhvlLeDkcAkrrocTsxIWFqjnvOzJxeif8ROKMyAXsWWRoyKbl+F4P5fTGmGYui3ntH4QSPOGyBfxULSc8MoHM4VcY9u4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788801; c=relaxed/simple;
	bh=aexLyFKD2izY1bwPV7rn+KFIvV8FTQbYldZGou1hmvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMuGwIramJCfZV7JVMas/y7C2ejZYeXe+fA8dilaTn4nKbyaqa9z5lh7ewamyrJ+3Gs2N32bjSZ7CAt+Kgt2bvxtZ95NwFheeYRoWuhRKQCgks58p6SpuMRR9Fcjl3Jz4ryklkiLRPIZqnroHNkBxG6Ij1IqAbakhJj0duURrqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RVRUZ31E; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RVRUZ31E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OE4rNS8s/qPZLHL+1S0BHoa0MIZLU9wgIaMlGXFasXI=; b=RVRUZ31EH3FU/hiV/9opTaU4OM
	D65gb+ZHDhF6OlYLrWMcV1tSwA9lz3S5/DUh7LSkN0t2fdUE/hnYiwCU7SzVhpsrUldiUXHMXyGno
	K3+3hgGVvzMar/81T0914p0IdBaDlmX8TSboyDPFZbjNJ/8UJVw5+zfrxYmdDTlKf0Ff9VLyF1Mu/
	79RywaKA5JmbNYMkTf19OJc83vJ+fxwC1UZ48e7VrYk6CoZmQJl6c4Gp/V+6FQmUCgJk5sg95RtC+
	/Cxc+3vvZ7B+HzUWUij94RCUFNEbBQEU5Bkrh+VOBwKGbokR/I9+zsM352KvoQOtFr/cnb8x5owhQ
	qdd2FXAw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tjyXa-00000001mIh-0YCV;
	Mon, 17 Feb 2025 10:39:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 05561300756; Mon, 17 Feb 2025 11:39:53 +0100 (CET)
Date: Mon, 17 Feb 2025 11:39:52 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, jannh@google.com,
	jmill@asu.edu, joao@overdrivepizza.com,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	luto@kernel.org, samitolvanen@google.com,
	scott.d.constable@intel.com, x86@kernel.org
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
Message-ID: <20250217103952.GM14028@noisy.programming.kicks-ass.net>
References: <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com>
 <202502131224.D6F5A235@keescook>
 <6641d1e0-7151-4857-bb0e-db555d4cdf50@citrix.com>
 <202502131248.B6CC333@keescook>
 <20250214095751.GF21726@noisy.programming.kicks-ass.net>
 <20250215210729.GA25168@noisy.programming.kicks-ass.net>
 <202502161547.B05817003F@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202502161547.B05817003F@keescook>

On Sun, Feb 16, 2025 at 03:51:27PM -0800, Kees Cook wrote:
> On Sat, Feb 15, 2025 at 10:07:29PM +0100, Peter Zijlstra wrote:
> > On Fri, Feb 14, 2025 at 10:57:51AM +0100, Peter Zijlstra wrote:
> > > On Thu, Feb 13, 2025 at 12:53:28PM -0800, Kees Cook wrote:
> > > 
> > > > Right, the "if they can control a function pointer" is the part I'm
> > > > focusing on. This attack depends on making an indirect call with a
> > > > controlled pointer. Non-FineIBT CFI will protect against that step,
> > > > so I think this is only an issue for IBT-only and FineIBT, but not CFI
> > > > nor CFI+IBT.
> > > 
> > > Yes, the whole caller side validation should stop this.
> > 
> > And I think we can retro-fit that in FineIBT. Notably the current call
> > sites look like:
> > 
> > 0000000000000060 <fineibt_caller>:
> >   60:   41 ba 78 56 34 12       mov    $0x12345678,%r10d
> >   66:   49 83 eb 10             sub    $0x10,%r11
> >   6a:   0f 1f 40 00             nopl   0x0(%rax)
> >   6e:   41 ff d3                call   *%r11
> >   71:   0f 1f 00                nopl   (%rax)
> > 
> > Of which the last 6 bytes are the retpoline site (starting at 0x6e). It
> > is trivially possible to re-arrange things to have both nops next to one
> > another, giving us 7 bytes to muck about with.
> > 
> > And I think we can just about manage to do a caller side hash validation
> > in them bytes like:
> > 
> > 0000000000000080 <fineibt_paranoid>:
> >   80:   41 ba 78 56 34 12       mov    $0x12345678,%r10d
> >   86:   49 83 eb 10             sub    $0x10,%r11
> >   8a:   45 3b 53 07             cmp    0x7(%r11),%r10d
> >   8e:   74 01                   je     91 <fineibt_paranoid+0x11>
> >   90:   ea                      (bad)
> >   91:   41 ff d3                call   *%r11
> 
> Ah nice! Yes, that would be great and removes all my concerns about
> FineIBT. :) 

Excellent!

> (And you went with EA just to distinguish it more easily?
> Can't we still use the UD2 bug tables to find this like normal?)

No space; UD2 is a 2 byte instruction. IIUC all the single byte
instructions that trip #UD are more or less 'reserved' and we shouldn't
be using them, but I think we can use 0xEA here since it is specific to
the paranoid FineIBT thing -- and if people want to reclaim the usage,
all they need to do is fix IBT :-) -- which as I said before should be
done once FRED happens.

(/me makes note to go read the very latest FRED spec -- its been a
while).

> > And while this is somewhat daft, it would close the hole vs this entry
> > point swizzle afaict, no?
> > 
> > Patch against tip/x86/core (which includes the latest ibt bits as per
> > this morning).
> > 
> > Boots and builds the next kernel on my ADL.
> 
> Lovely! Based on the patch, I assume you were testing CFI crash location
> reporting too?

Sami was, he reminded me I forgot to hook up FineIBT, so I did :-)

> I'll try to get this spun up for testing here too.

Thanks!
