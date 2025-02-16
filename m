Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F3C18BBB9;
	Sun, 16 Feb 2025 23:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739749355; cv=none; b=uhs7eyamLCsYhZtadem4q48Fb97SU5stVI7nupGa1vq+ZImsxe/61l+Q80ECArBSGiuMvWVqhlNZYtF+EWvuKDI9hd1N8EcJA23b2Xz7++qag7x84MSNgTiIV4EB0seIhpKDT1vSv86HKBa9GzxLdfiZmzvz3lrbnKGdTejaSUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739749355; c=relaxed/simple;
	bh=5bk93z+PwohGYKTzQ822INlBIaO8f7t9pYHJ3jPQK3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mil9zf8fl/hDtfXrgCmqhoSnfZKNPT4CH8NZWBYfzlK2oAgU7+VPaoDQYl/PqD+46KdJBXIxZ7D0ic2xDLhoaeSyy4hdLJlFacFiLpLN0k6sNlHcy2F2OFUEinXP2QmI7D/H64RrjHalz3p8RfOCeHE+7S2nAXSH7j6LxZ9dYdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wj/VQgZ1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wj/VQgZ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337AFC4CEDD;
	Sun, 16 Feb 2025 23:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739749355;
	bh=5bk93z+PwohGYKTzQ822INlBIaO8f7t9pYHJ3jPQK3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wj/VQgZ1TgooE6sck/rBgVevrAxRWA0hFwZgk4DtjnlM6XjBJ3IG651IpV/O5IOI8
	 8vupnvMJ+IRgD9Z/fsT7D90UgBhZQ/cb4FnoC0Q0p+a/ldyprjYla2HbqQY6DukhNe
	 xPyvxU6wsPHvl80reADnOeagtCMJgcj+TudOFCgXSG7JUxQYwtYJWb7BQ1OguWb0fh
	 XBKQyNr0Focl3NAxFz94ZhEMXMxr/fVMcK3dVL3V5wwVq1tNnOzl406NlCKPPerXQA
	 92mPegcYudThaEV7UCYR2DY8FmvVN0J7Tp8VpPbEITlH1+yFrQVgDweVp91BfHZtj8
	 9mEN2BY5DBsTQ==
Date: Sun, 16 Feb 2025 15:42:31 -0800
From: Kees Cook <kees@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, jmill@asu.edu,
	joao@overdrivepizza.com, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, luto@kernel.org,
	samitolvanen@google.com,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
Message-ID: <202502161538.33E0A340@keescook>
References: <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com>
 <202502131224.D6F5A235@keescook>
 <6641d1e0-7151-4857-bb0e-db555d4cdf50@citrix.com>
 <202502131248.B6CC333@keescook>
 <CAG48ez3ALBtj82PXn7XZ_cJ2ikOgXq3yFi+__DFn1pk0CAGzFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3ALBtj82PXn7XZ_cJ2ikOgXq3yFi+__DFn1pk0CAGzFQ@mail.gmail.com>

On Thu, Feb 13, 2025 at 09:57:37PM +0100, Jann Horn wrote:
> On Thu, Feb 13, 2025 at 9:53 PM Kees Cook <kees@kernel.org> wrote:
> > On Thu, Feb 13, 2025 at 08:41:16PM +0000, Andrew Cooper wrote:
> > > On 13/02/2025 8:28 pm, Kees Cook wrote:
> > > > On Thu, Feb 13, 2025 at 01:31:30AM +0000, Andrew Cooper wrote:
> > > >>>> Assuming this is an issue you all feel is worth addressing, I will
> > > >>>> continue working on providing a patch. I'm concerned though that the
> > > >>>> overhead from adding a wrmsr on both syscall entry and exit to
> > > >>>> overwrite and restore the KERNEL_GS_BASE MSR may be quite high, so
> > > >>>> any feedback in regards to the approach or suggestions of alternate
> > > >>>> approaches to patching are welcome :)
> > > >>> Since the kernel, as far as I understand, uses FineIBT without
> > > >>> backwards control flow protection (in other words, I think we assume
> > > >>> that the kernel stack is trusted?),
> > > >> This is fun indeed.  Linux cannot use supervisor shadow stacks because
> > > >> the mess around NMI re-entrancy (and IST more generally) requires ROP
> > > >> gadgets in order to function safely.  Implementing this with shadow
> > > >> stacks active, while not impossible, is deemed to be prohibitively
> > > >> complicated.
> > > > And just validate my understanding here, this attack is fundamentally
> > > > about FineIBT, not regular CFI (IBT or not), as the validation of target
> > > > addresses is done at indirect call time, yes?
> > >
> > > I'm not sure I'd classify it like that.  As a pivot primitive, it works
> > > very widely.
> > >
> > > FineIBT (more specifically any hybrid CFI scheme which includes CET-IBT)
> > > relies on hardware to do the course grain violation detection, and some
> > > software hash for fine grain violation detection.
> > >
> > > In this case, the requirement for the SYSCALL entrypoint to have an
> > > ENDBR64 instruction means it passes the CET-IBT check (does not yield
> > > #CP), and then lacks the software hash check as well.
> > >
> > > i.e. this renders FineIBT (and other hybrid CFI schemes) rather moot,
> > > because one hole is all the attacker needs to win, if they can control a
> > > function pointer / return address.  At which point it's a large overhead
> > > for no security benefit over simple CET-IBT.
> >
> > Right, the "if they can control a function pointer" is the part I'm
> > focusing on. This attack depends on making an indirect call with a
> > controlled pointer. Non-FineIBT CFI will protect against that step,
> > so I think this is only an issue for IBT-only and FineIBT, but not CFI
> > nor CFI+IBT.
> 
> To me, "CFI" is really just a fairly abstract concept; are you talking
> specifically about the Clang scheme from
> <https://clang.llvm.org/docs/ControlFlowIntegrityDesign.html>, or
> something else?

Ah, sorry, I mean KCFI (and note that FineIBT is a run-time alternatives
pass that transforms the "stock" KCFI):

https://clang.llvm.org/docs/ControlFlowIntegrity.html#fsanitize-kcfi
https://lpc.events/event/16/contributions/1315/
https://www.youtube.com/watch?v=bmv6blX_F_g

-Kees

-- 
Kees Cook
