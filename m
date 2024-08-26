Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94F219AA68;
	Mon, 26 Aug 2024 20:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724704413; cv=none; b=bQvbEtwaO3TH7Uwle4nHmfhaYm5RwDRh1Qyz4DULdpOa4uoYYPDnGgPmnYe0Wp14s0RXX3k5XbFRh6Fwnhl66M55Gxf55+khEAOOeTsqMmWnJbc+Rb9ncAwKE6eDU7GTjqXmo5r/L5GO8gA/nZFBU/UBVfW48DD3celgWMevy0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724704413; c=relaxed/simple;
	bh=6Ujl2G5gIrien3C3SbfeSa+BffaoHLb0DPf+NbVfzzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OaR8suAe0dpls2zRPbCibo8UFxDQfU6XEG4zE1fgNp0pd/b/WiMP9wNXyOusXAtB0GeiANNh+rTq5PGFBw5SGjzng4qaml3/mQIdNN01AKWJ4Yr1CilPZkVEuC7Jh4NV+n3jMjZLtTL6kdFKpcHJD4RnAsjYRVyXa9NWBsYgfLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqRmg//D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqRmg//D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5E3C8B7B8;
	Mon, 26 Aug 2024 20:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724704412;
	bh=6Ujl2G5gIrien3C3SbfeSa+BffaoHLb0DPf+NbVfzzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TqRmg//DS/iIlzGfhj1EwZDxczhSLCcIJBMVzbQUoCKOEQmkb/P5WCN3f46IDGbFw
	 HtEmaOBkuoJibOb+gcGrwvMWbltYiqq+r8aLx8YowBKpsGyifLaWwDQnMLHEWgzIuA
	 CXWCXjqpJ/RXTlC67WbB2bKGvXFLCAP3AMSicCa59y7LIdDI4bb8Vr8Ca9+4s45CCQ
	 nxbJeX4QelP21ZtGd9WBTpARfNrwu+s/u+RJDOV42web6HNz40KLT83qfgyXjSBT+D
	 4K5uS3HLXVY/1vqggUGfxRQaVUXoL9/gg2SuAiOfmNyKPYK7LE69vqZPfRYTE5DD+A
	 X98B7/Z/0RBhw==
Date: Mon, 26 Aug 2024 13:33:31 -0700
From: Kees Cook <kees@kernel.org>
To: Wen Yang <wen.yang@linux.dev>
Cc: Greg KH <gregkh@linuxfoundation.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore: replace spinlock_t by raw_spinlock_t
Message-ID: <202408261332.84DE549F0@keescook>
References: <20240819145945.61274-1-wen.yang@linux.dev>
 <2024081925-opposite-pessimist-9b98@gregkh>
 <e7b031d7-3916-4d6d-8dfd-70412c5d24b6@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7b031d7-3916-4d6d-8dfd-70412c5d24b6@linux.dev>

On Sat, Aug 24, 2024 at 03:25:04PM +0800, Wen Yang wrote:
> 
> 
> On 2024/8/20 01:45, Greg KH wrote:
> > On Mon, Aug 19, 2024 at 10:59:45PM +0800, Wen Yang wrote:
> > > pstore_dump() is called when both preemption and local IRQ are disabled,
> > > and a spinlock is obtained, which is problematic for the RT kernel because
> > > in this configuration, spinlocks are sleep locks.
> > > 
> > > Replace the spinlock_t with raw_spinlock_t to avoid sleeping in atomic context.
> > 
> > This feels odd, is it only an out-of-tree RT thing?  Or does this affect
> > in-kernel code as well?  What prevents any normal spinlock from sleeping
> > in your system configuration as well?
> > 
> 
> Thank you for your comment.
> 
> If we enable PREEMPT_RT, it will also affect in-kernel code, such as in the
> following scenario:
> 
> echo b > /proc/sysrq-trigger
>   - sysrq_handle_reboot
>   - emergency_restart
>   - kmsg_dump
>   - pstore_dump
> Obtained psinfo->buf_lock, if there is a lot of error log in the kernel, it
> will last for a long time
> 
> If the system unexpectedly crashes at this time:
>   - panic()
>   - kmsg_dump
>   - pstore_dump
> Attempting to obtain psinfo->buf_lock while disabling interrupts and
> preemption, but since this lock is already held by the above process, it
> will result in illegal sleep.

Reading Documentation/locking/locktypes.rst seems to suggest pstore does
want the raw version. I'm surprised there aren't many more cases where
this is a problem. :P

-- 
Kees Cook
