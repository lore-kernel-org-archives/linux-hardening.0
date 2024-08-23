Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443B019E;
	Fri, 23 Aug 2024 00:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724371958; cv=none; b=LFWqCdtEiCZbYiqYUP4M/pLH9H6aM5W3cnwQDXyLPi3Hx4KdbOpN2oe3sJQ+M9VtTDP6QfELP2Uv7ocQBVgOl4C+QQzMzdO/Uof73aDh05qdE9fHYoXke3MVgdjd4ts4im/qjlrDWh+nMAJpgCjgzKY9hFkVlylb/W/MvwSdvZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724371958; c=relaxed/simple;
	bh=8clxRUF3beC9N/kDrAYpJXurCOaFpHqIVwlbhvPhZ3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6SHU/w669j08Z1KBRQQO772IwkwZLhBF46aoSuyQ06MJRDqk9IGPPBfY4frwHCnFSWh8OhAavAVYCEtlU+T11ZRR7/rG27LXYMr2KPD+C/Rxbn2QdfRupBEMzrnjVtaKmDR5eCj/5W/0PGZ79spBr2FrMSN3vk+qCzmJesX8NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIqeUo97; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIqeUo97"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE7CC32782;
	Fri, 23 Aug 2024 00:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724371957;
	bh=8clxRUF3beC9N/kDrAYpJXurCOaFpHqIVwlbhvPhZ3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qIqeUo97omLg8jkf89PXA1rOZipTUyvSQtem2frcLErpT/zp5EUJuu7kC9CiV946o
	 Xmrisj2z6WX/DLTfF/Zaf01mCn3rgKzP6bXCNnQRcDicics2i2QPPV7SgRXb7WL4dB
	 3SkOgmaTIiey2A2KUrq2/J5d20xk20qHhbShQc9VoSsR88wjTagUUjXv6yPKEFXyo/
	 Mg2AWlZkuvkIOPJdTuxK1liodPMBiCTA666e6872+fU6Vp49wSQlaXQOJmla/G6xB9
	 tUYAVht4cTHV95sBUXcUVHNrjzd2jC49Xop+20cRwKp/FhLCXC0xtFAAwU2IIT+x4r
	 XX7PNKhZ/c4zA==
Date: Thu, 22 Aug 2024 17:12:37 -0700
From: Kees Cook <kees@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Mirsad Todorovac <mtodorovac69@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Peter Collingbourne <pcc@google.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86/syscall: Avoid memcpy() for ia32
 syscall_get_arguments()
Message-ID: <202408221712.DC796105C@keescook>
References: <20240708202202.work.477-kees@kernel.org>
 <842a88e0-90ae-48be-91c9-8a7c3a8359a9@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <842a88e0-90ae-48be-91c9-8a7c3a8359a9@intel.com>

On Thu, Jul 11, 2024 at 02:01:53PM -0700, Dave Hansen wrote:
> On 7/8/24 13:22, Kees Cook wrote:
> ...
> > diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
> > index 2fc7bc3863ff..7c488ff0c764 100644
> > --- a/arch/x86/include/asm/syscall.h
> > +++ b/arch/x86/include/asm/syscall.h
> > @@ -82,7 +82,12 @@ static inline void syscall_get_arguments(struct task_struct *task,
> >  					 struct pt_regs *regs,
> >  					 unsigned long *args)
> >  {
> > -	memcpy(args, &regs->bx, 6 * sizeof(args[0]));
> > +	args[0] = regs->bx;
> > +	args[1] = regs->cx;
> > +	args[2] = regs->dx;
> > +	args[3] = regs->si;
> > +	args[4] = regs->di;
> > +	args[5] = regs->bp;
> >  }
> >  
> 
> Yeah, that's much less magic.  I'll stick this in the queue to go in to
> the tree in a few weeks.
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Ping. I can take it via the hardening tree if you want, though?

-- 
Kees Cook
