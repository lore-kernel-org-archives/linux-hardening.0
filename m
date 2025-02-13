Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C6E1FFC59;
	Thu, 13 Feb 2025 20:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739480009; cv=none; b=hdkQXCyplVCJJwEGQKK36JqY3MD3IEYhTKwVDjxYh/yZNFU5SkWD2hgPnJz7YVGBMxWD57rlDvnWjnd4WHke7rDwZxk5cn3Iz6szs5Q4TYa2ckwSKayIFjd9cvsjQ3Vk3N7Tc6JfOKAvUDubSY/Jb34FNx3qhS7J/JvtciwnXTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739480009; c=relaxed/simple;
	bh=RAQR5ntAmHQ/Wq8vp+BLtvwDDGIGaKQbSbNQFKN2iOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOvh3S15a2A1fX3ze6u2jnVRQyOc6MqCz9pkXephaCkp63ZIjrY/mMemHoFj4dxY12uw/n9wVzv1ZGsNWz15lFoSl69BOnF3jss4uRR5rJ6iwDIzscW4P4Rd8wNi6p+V99lgYOFz0+UpxYMkX7HuPJFyD4GK01aMzmpqjIIQ2XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSbKAPPL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSbKAPPL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4577C4CED1;
	Thu, 13 Feb 2025 20:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739480008;
	bh=RAQR5ntAmHQ/Wq8vp+BLtvwDDGIGaKQbSbNQFKN2iOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LSbKAPPL0evS7fkicTq6YNTcGHDs05DRQxIV8OQcZPfJSoPvfsomXCSQY/MR6zNGb
	 ckqpDeiqCfIPWZa5ZYn3dgU3tacLW96mvvlajIgz41wbeTaVA4a1//RvrwWsc4TDnL
	 wgQKTzrJIBvWnFFNZEr77SFEVQ9O5H4hBnJfCGHDYoHkcgqa+sDT9dbwuBi5XWEl6A
	 dv4jF8Dw7eS7PF96LfhgTT2ROksB6EcA/wNvDtLoRofemNimnj4gKlhKosr8PMAo9z
	 mXeTKIHhyiw2ozpsSTtWa1PGdfNr2nLhtOA1BLDf92ber1yojbh+1EmY5clWG3Gdtc
	 kh0+MGSZgQ3CQ==
Date: Thu, 13 Feb 2025 12:53:28 -0800
From: Kees Cook <kees@kernel.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: jannh@google.com, jmill@asu.edu, joao@overdrivepizza.com,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	luto@kernel.org, samitolvanen@google.com,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
Message-ID: <202502131248.B6CC333@keescook>
References: <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com>
 <202502131224.D6F5A235@keescook>
 <6641d1e0-7151-4857-bb0e-db555d4cdf50@citrix.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6641d1e0-7151-4857-bb0e-db555d4cdf50@citrix.com>

On Thu, Feb 13, 2025 at 08:41:16PM +0000, Andrew Cooper wrote:
> On 13/02/2025 8:28 pm, Kees Cook wrote:
> > On Thu, Feb 13, 2025 at 01:31:30AM +0000, Andrew Cooper wrote:
> >>>> Assuming this is an issue you all feel is worth addressing, I will
> >>>> continue working on providing a patch. I'm concerned though that the
> >>>> overhead from adding a wrmsr on both syscall entry and exit to
> >>>> overwrite and restore the KERNEL_GS_BASE MSR may be quite high, so
> >>>> any feedback in regards to the approach or suggestions of alternate
> >>>> approaches to patching are welcome :) 
> >>> Since the kernel, as far as I understand, uses FineIBT without
> >>> backwards control flow protection (in other words, I think we assume
> >>> that the kernel stack is trusted?),
> >> This is fun indeed.  Linux cannot use supervisor shadow stacks because
> >> the mess around NMI re-entrancy (and IST more generally) requires ROP
> >> gadgets in order to function safely.  Implementing this with shadow
> >> stacks active, while not impossible, is deemed to be prohibitively
> >> complicated.
> > And just validate my understanding here, this attack is fundamentally
> > about FineIBT, not regular CFI (IBT or not), as the validation of target
> > addresses is done at indirect call time, yes?
> 
> I'm not sure I'd classify it like that.  As a pivot primitive, it works
> very widely.
> 
> FineIBT (more specifically any hybrid CFI scheme which includes CET-IBT)
> relies on hardware to do the course grain violation detection, and some
> software hash for fine grain violation detection.
> 
> In this case, the requirement for the SYSCALL entrypoint to have an
> ENDBR64 instruction means it passes the CET-IBT check (does not yield
> #CP), and then lacks the software hash check as well.
> 
> i.e. this renders FineIBT (and other hybrid CFI schemes) rather moot,
> because one hole is all the attacker needs to win, if they can control a
> function pointer / return address.  At which point it's a large overhead
> for no security benefit over simple CET-IBT.

Right, the "if they can control a function pointer" is the part I'm
focusing on. This attack depends on making an indirect call with a
controlled pointer. Non-FineIBT CFI will protect against that step,
so I think this is only an issue for IBT-only and FineIBT, but not CFI
nor CFI+IBT.

> The problem is that SYSCALL entry/exit is a toxic operating mode,
> because you only have to think about sneezing and another user->kernel
> priv-esc appears.

Yeah, once an attacker can make an indirect call to a controlled
address, everything falls apart. And using the entry just makes the
pivot all that much easier to find/use.

-Kees

-- 
Kees Cook
