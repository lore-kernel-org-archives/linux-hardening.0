Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ED71953A9;
	Fri, 14 Feb 2025 22:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739571931; cv=none; b=CAv36oLv6/i03m7dvnlbYxpdJ+Wh1DQzc3EkzKGEuCUPIEgHJSCtikxoqO1m/hTaQF/lYfVO1PKn1srOkLLU8j4jrYfeRWBdRHg7ycBh0yo+oEHnYsZ8Xxg7tmZaN88lShn2XMSnXDztlXUac/zWr8+BVpD0+/64G7gE3YSQ668=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739571931; c=relaxed/simple;
	bh=JLPABf+6hAl/sSDOY8RUhJ1VUtF6q/IL7NYfsrits3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSToL+OuA6Uy6wMqOf19eRgvBF9jvT/gJprLpkl5ZVP5dO5vY1TXqKPr+ieXx6eGI0qPJVeChtZQKKa8ktrRrLVbO0UgrCrxm5Bo7uN7HfTcNyTq31YyItyRVAEGUvRIuaNmR3cKRvrUtGofV6w1rEZUeGOPyPf2KucMZsmtpFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCP3T/hy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCP3T/hy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCC5C4CED1;
	Fri, 14 Feb 2025 22:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739571930;
	bh=JLPABf+6hAl/sSDOY8RUhJ1VUtF6q/IL7NYfsrits3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RCP3T/hynzWkWIrGTRQSUzLFmF66srarZI+XHUs4tPEU0xGL9JUTer6r5LhgES9CR
	 540AhPhzEu96R+K3g8WsnlL0vC76KHgKVrKXuZSGPDHd7ho1QAH+MiigeRqESjcV8n
	 yZId+KfiXpJmlEd58gmDWUih8doAfncWXLHlYaK6Po9JWc0fw0IRODvZV30URntHXG
	 iRBEn48aW2h6qGq9JtX7miBjRhyD0j3Ii4NC0E/Qzz6ah+ujwAPFkq0oFHsgEnElsf
	 bwqEMUHISqfR18GvoNwM0DMKU5MXZ1ksguy9tJu6h3TkJk4DTL0YFxGyOkU8UGv7DJ
	 rqaMNewHnoYrg==
Date: Fri, 14 Feb 2025 14:25:28 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Jennifer Miller <jmill@asu.edu>, Andy Lutomirski <luto@kernel.org>, 
	linux-hardening@vger.kernel.org, kees@kernel.org, joao@overdrivepizza.com, 
	samitolvanen@google.com, kernel list <linux-kernel@vger.kernel.org>, 
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
Message-ID: <qczypdkenk2e5atbn46o2xhts6vtu2hxvmucvhkuu7zoziuq2c@26tyi763snot>
References: <Z60NwR4w/28Z7XUa@ubun>
 <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <Z62N6cGmaN+OZfoY@ubun>
 <CAG48ez0Bt9348i=We3-wJ1QrW-_5R-we7y_S3Q1brhoyEdHJ0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0Bt9348i=We3-wJ1QrW-_5R-we7y_S3Q1brhoyEdHJ0Q@mail.gmail.com>

On Thu, Feb 13, 2025 at 08:23:34PM +0100, Jann Horn wrote:
> On Thu, Feb 13, 2025 at 7:15 AM Jennifer Miller <jmill@asu.edu> wrote:
> > In short, we could have the slowpath branch as you suggested, in the
> > slowpath permit the stack switch and preserving of the registers on the
> > stack, but then do a sanity check according to the __per_cpu_offset array
> > and decide from there whether we should continue executing the entrypoint
> > or die/attempt to recover.
> 
> One ugly option to avoid the register spilling might be to say
> "userspace is not allowed to execute a SYSCALL instruction while RSP
> is a kernel address, and if userspace does it anyway, the kernel can
> kill the process". Then the slowpath could immediately start using the
> GPRs without having to worry about where to save their old values, and
> it could read the correct gsbase with the GET_PERCPU_BASE macro. It
> would be an ABI change, but one that is probably fairly unlikely to
> actually break stuff? But it would require a bit of extra kernel code
> on the slowpath, which is kinda annoying...

Could all this be made easier if we went back to having percpu entry
trampolines?  Then the trampoline could just use a PC-relative access to
get the kernel stack pointer without needing %gs.

I think the main reason the entry trampolines were removed was because
they needed an indirect branch to jump back to the global text.  But
they could be allocated within 2GB of the entry text and do a direct
jump.

-- 
Josh
