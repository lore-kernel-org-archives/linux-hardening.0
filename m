Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C721B2222DE;
	Thu, 13 Feb 2025 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739478513; cv=none; b=MqlchFaRGIffVHToDde+wlloiOusZ84B5ZY8a5Kgxs5fywJvxhtqlBGyHLICE/nNRqQ3/Lt1nSgHSBhgXrqMNO5bD9wOF5/S/J+kkzk+BLkW+39CMlm1WtFnDrzb7gljQZ7qnuLGgEld4qJOuWpMCiTOOiq6fxEnmvKFIQ0SOhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739478513; c=relaxed/simple;
	bh=kONj13IcqgHJ804P/bAafBVxsgQtnFkjDzMz0OaRA5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAcy7miTltYn357Z1syOgxAc2nTHcWEdCr7kpKTRWXHUoOa/La1uIDYrOUmLpTMEyLzfHHqa0uYL8a5x+JcH8aLkNTqr9gfD9E0ubTAFgAorey3jA6hs4DwfK3htTFQ/IrSDBXX54dNtZMQwHUXLRjf4hrObyQjCV9SopHREKAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iahmU/xL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iahmU/xL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1BDC4CED1;
	Thu, 13 Feb 2025 20:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739478513;
	bh=kONj13IcqgHJ804P/bAafBVxsgQtnFkjDzMz0OaRA5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iahmU/xLEyQ5W/x8G1XXoCuN03pzKYwXt5cjuLid0J2kmowncl+TcJsBFiFdnXAAw
	 G2ImJXb8GEatewBIrpkPliLaVlqt+YwGGaUUe7ZSu+QTYYixOnY8NQ2L7bIeTRgQUv
	 XKnoPM2jM1FoMZeunPhWxtFsi2R5Y5hFOZiAaOJoy/mpOM4gWxkgDqxt6cxdKUlMuU
	 BoApdn8Ievmh5OjxdKpuGyto3xVNRAyh7XmFvutyOt9T/k4TTYgxr4QRgZbm8S/7vs
	 LNDWpa83WcAlnkwCZMlGuxN6RkOyoj8ufbHuvlgSph2scXDoaLz4qnczlhAkx5/TP9
	 F+nNPktOc/3gg==
Date: Thu, 13 Feb 2025 12:28:33 -0800
From: Kees Cook <kees@kernel.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: jannh@google.com, jmill@asu.edu, joao@overdrivepizza.com,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	luto@kernel.org, samitolvanen@google.com,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
Message-ID: <202502131224.D6F5A235@keescook>
References: <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com>

On Thu, Feb 13, 2025 at 01:31:30AM +0000, Andrew Cooper wrote:
> >> Assuming this is an issue you all feel is worth addressing, I will
> >> continue working on providing a patch. I'm concerned though that the
> >> overhead from adding a wrmsr on both syscall entry and exit to
> >> overwrite and restore the KERNEL_GS_BASE MSR may be quite high, so
> >> any feedback in regards to the approach or suggestions of alternate
> >> approaches to patching are welcome :) 
> >
> > Since the kernel, as far as I understand, uses FineIBT without
> > backwards control flow protection (in other words, I think we assume
> > that the kernel stack is trusted?),
> 
> This is fun indeed.  Linux cannot use supervisor shadow stacks because
> the mess around NMI re-entrancy (and IST more generally) requires ROP
> gadgets in order to function safely.  Implementing this with shadow
> stacks active, while not impossible, is deemed to be prohibitively
> complicated.

And just validate my understanding here, this attack is fundamentally
about FineIBT, not regular CFI (IBT or not), as the validation of target
addresses is done at indirect call time, yes?

-Kees

-- 
Kees Cook
