Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EFD22D7B0
	for <linux-hardening@vger.kernel.org>; Thu, 13 Feb 2025 23:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739489053; cv=none; b=pRxVwI/yyXd93dRA/U86/CztcduVb97ZHZPsBs/74tYI3rD0DR1f8ja9h4gsfViZiZaKqbXHJ/idam4irdYkNcFiaMRp0B+saA/zG5k5sQxSmQSv45A3kMIpiHM5W5Lmh+Rz5Tu1kCOjYpqjbXFKl4bQI7MRk4u+XbOYIx2BGpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739489053; c=relaxed/simple;
	bh=ZreTuX/D9xC0BRibCmr0wVreHyDz6310muxD3riD1C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCcjEAWRtAA6yuEVAXJXFzWwhEZXF3M8aLKu8dIviCDSIsiLm1dA5SQ2BNBKbdFZth/usG/xZ22Odca/ftSfx5hQU1kAcxEW5/fMmdCqi3r1JasvWeQ5xqIiPvDboMHsDQTuPgrFBXSEGlcukcyTiJfm3nobU4SeJ9UgqRbGUIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=QH5fFDzk; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="QH5fFDzk"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220dc3831e3so16367585ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 13 Feb 2025 15:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1739489050; x=1740093850; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qp/gjetAdFdX7c6LEKRIoNpBN6vuc3LKqtmSQ/LdU40=;
        b=QH5fFDzkhOI9RRhdrkh9EBmR5m3VfY6UNtpf4nAxxvPkFHetvAymbieEejyVjYlTa5
         bqsIrpKJq34c2yvzvUnpkFChuxJCXuLV0tRjXODQOIpaH1xLwjqR5cKLJs+BbsRdLTo2
         12j5/B4oTfUzfrif6hPq9zqtw7qMX5UQBuFhBd/8awtYYGYbWVNh9wet/GTZFKFsuuDe
         TifszhRUUKayGnqwpaKMCoGiPN3QgvB0jdRn9EYbm22pR2JOdL4/McMW3X+vbWzpdcPP
         z/IDnU9Q7JweVGoiiRhqw7XBDvac9prC/I9gVapAwliwri73t/iXhefvTLPW8IIf1hVc
         umfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739489050; x=1740093850;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qp/gjetAdFdX7c6LEKRIoNpBN6vuc3LKqtmSQ/LdU40=;
        b=hHFqvaW+7Vykba1O8GoKY/FQfluiV4pMcEwyfnYGXXfhn2b7ET7GT9poaYLSJBlFwo
         vZrkkDOciCs4G9U1yh9GQEix3TQsYQNQLXw+jgG+Q2ZXu8Wm/5WkvYC0015cXL4W5qop
         ARsbZdRXfnfXdRSUIPqEId1NMgdt56UyLBQqqhsdbmQeallTu0BVolGbJmL89KHSEhXA
         1W1Hxk6Y3Y29SpkG7z0vPlbKPRh6qibBWDHO9Im7nskV6y7Iuf8/Qer1auSXX0Hv3Rac
         wWejDCR+yG+YoI0vPjiaAmHMYQ47Zrps4WV0LCmiGhCw1nm4Yt45WiZaLPp/gt9O/dR2
         MVvw==
X-Forwarded-Encrypted: i=1; AJvYcCUVeirMLRAHjN4aPNKS+bfT9bsQ1U/PmqWWYwhbaXauOlbVKh6vN08L84LMplix0OvPxhM17tGwgWTXHMcM+7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxaa1XCs8IUwUaaBkyYEn0jTj873QnzBJkyLDETf5BbCg0q730
	gk/wJhTEwunEMuxy2P5JWr7DcqHveLUEVnbc/SLi8yl7bYNmTHT4Kt4e0J/VzQ==
X-Gm-Gg: ASbGnctnp83KnTt2rheMAdXndBM/EE05WorOWv7Jy9Dso16LOxjjt/Bf3Dvv24CN0l4
	SBT9NtPQQc3kSEgY2WMdSV60wkEmGmpGszkCT/syncsUBYEFfPE5Zb62sr2t4uippPNoRE0nrjN
	stQAqQhouvMyiZHQU5zq0AGfjuYpDV3+EeaWrmP3+OIitG0AeuHnGA5J7ot2GbBux1ShuXH6HFM
	qZ0TaGHsuoILRLspTtJHdY3ti+OsbDfJ1VeSLcHRHxW0j1QPao2UriojlmTkZFqjwiik8USQmdb
	+A==
X-Google-Smtp-Source: AGHT+IGLtuJxSqRI4nthlUDDkKg7XvGKGwcUQ17nvqDoBisfU00E2fqXx+w9i3u+ydNAI1dx4+sgHg==
X-Received: by 2002:a05:6a20:9383:b0:1ea:f941:8d8e with SMTP id adf61e73a8af0-1ee6c9cf2abmr7504562637.16.1739489050570;
        Thu, 13 Feb 2025 15:24:10 -0800 (PST)
Received: from ubun ([2600:8800:1689:e500:401f:7374:956f:20c5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e2fesm1847678b3a.118.2025.02.13.15.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 15:24:09 -0800 (PST)
Date: Thu, 13 Feb 2025 16:24:06 -0700
From: Jennifer Miller <jmill@asu.edu>
To: Andrew Cooper <andrew.cooper3@citrix.com>, Jann Horn <jannh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>, linux-hardening@vger.kernel.org,
	kees@kernel.org, joao@overdrivepizza.com, samitolvanen@google.com,
	kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
Message-ID: <Z65/Fpd9cnUk8TjE@ubun>
References: <Z60NwR4w/28Z7XUa@ubun>
 <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <Z62N6cGmaN+OZfoY@ubun>
 <CAG48ez0Bt9348i=We3-wJ1QrW-_5R-we7y_S3Q1brhoyEdHJ0Q@mail.gmail.com>
 <60447cd2-a8da-4be6-80fa-a5639b7455b1@citrix.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60447cd2-a8da-4be6-80fa-a5639b7455b1@citrix.com>

On Thu, Feb 13, 2025 at 09:24:18PM +0000, Andrew Cooper wrote:
> On 13/02/2025 7:23 pm, Jann Horn wrote:
> > On Thu, Feb 13, 2025 at 7:15 AM Jennifer Miller <jmill@asu.edu> wrote:
> >> Here is some napkin asm for this I wrote for the 64-bit syscall entrypoint,
> >> I think more or less the same could be done for the other entrypoints.
> >>
> >> ```
> >>     endbr64
> >>     test rsp, rsp
> >>     js slowpath
> >>
> >>     swapgs
> >>     ~~fastpath continues~~
> >>
> >> ; path taken when rsp was a kernel address
> >> ; we have no choice really but to switch to the stack from the untrusted
> >> ; gsbase but after doing so we have to be careful about what we put on the
> >> ; stack
> >> slowpath:
> >>     swapgs
> 
> I'm afraid I don't follow.  By this point, both basic blocks are the
> same (a single swapgs).

Ah sure, the test/js could be moved occur after swapgs to save an 
instruction.

>
> Malicious userspace can get onto the slowpath by loading a kernel
> pointer into %rsp.  Furthermore, if the origin of this really was in the
> kernel, then ...
> 
> >>
> >> ; swap stacks as normal
> >>     mov    QWORD PTR gs:[rip+0x7f005f85],rsp       # 0x6014 <cpu_tss_rw+20>
> >>     mov    rsp,QWORD PTR gs:[rip+0x7f02c56d]       # 0x2c618 <pcpu_hot+24>
> 
> ... these are memory accesses using the user %gs.  As you note a few
> lines lower, %gs isn't safe at this point.
> 
> A cunning attacker can make gs:[rip+0x7f02c56d] be a read-only mapping,
> at point we'll have loaded an attacker controlled %rsp, then take #PF
> trying to spill %rsp into pcpu_hot, and now we're running the pagefault
> handler on an attacker controlled stack and gsbase.
> 

I don't follow, the spill of %rsp into pcpu_hot occurs first, before we
would move to the attacker controlled stack. This is Intel asm syntax,
sorry if that was unclear.

Still, I hadn't considered misusing readonly/unmapped pages on the GPR
register spill that follows. Could we enforce that the stack pointer we get
be page aligned to prevent this vector? So that if one were to attempt to
point the stack to readonly or unmapped memory they should be guaranteed to
double fault?

> >>     ~~normal push and clear GPRs sequence here~~
> >>
> >> ; we entered with an rsp in the kernel address range.
> >> ; we already did swapgs but we don't know if we can trust our gsbase yet.
> >> ; we should be able to trust the ro_after_init __per_cpu_offset array
> >> ; though.
> >>
> >> ; check that gsbase is the expected value for our current cpu
> >>     rdtscp
> >>     mov rax, QWORD PTR [8*ecx-0x7d7be460] <__per_cpu_offset>
> >>
> >>     rdgsbase rbx
> >>
> >>     cmp rbx, rax
> >>     je fastpath_after_regs_preserved
> >>
> >>     wrgsbase rax
> 
> Irrespective of other things, you'll need some compatibility strategy
> for the fact that RDTSCP and {RD,WR}{FS,GS}BASE cannot be used
> unconditionally in 64bit mode.  It might be as simple as making FineIBT
> depend on their presence to activate, but taking a #UD exception in this
> path is also a priv-esc vulnerability.

Sure, we could rdmsr IA32_TSC_AUX in place of rdtscsp. After the wrgsbase 
we could switch to the expected kernel stack now that gsbase is fixed 
before taking any #UD.

> 
> While all CET-IBT capable CPUs ought to have RDTSCP/*BASE, there are
> virt environments where this implication does not hold.
> 
> >>
> >> ; if we reach here we are being exploited and should explode or attempt
> >> ; to recover
> >> ```
> >>
> >> The unfortunate part is that it would still result in the register state
> >> being dumped on top of some attacker controlled address, so if the error
> >> path is recoverable someone could still use entrypoints to convert control
> >> flow hijacking into memory corruption via register dump. So it would kill
> >> the ability to get ROP but it would still be possible to dump regs over
> >> modprobe_path, core_pattern, etc.
> > It is annoying that we (as far as I know) don't have a nice clear
> > security model for what exactly CFI in the kernel is supposed to
> > achieve - though I guess that's partly because in its current version,
> > it only happens to protect against cases where an attacker gets a
> > function pointer overwrite, but not the probably more common cases
> > where the attacker (also?) gets an object pointer overwrite...
> >
> >> Does this seem feasible and any better than the alternative of overwriting
> >> and restoring KERNEL_GS_BASE?
> > The syscall entry point is a hot path; my main reason for suggesting
> > the RSP check is that I'm worried about the performance impact of the
> > gsbase-overwriting approach, but I don't actually have numbers on
> > that. I figure a test + conditional jump is about the cheapest we can
> > do...
> 
> Yeah, this is the cheapest I can think of too.  TEST+JS has been able to
> macrofuse since the Core2 era.
> 
> > Do we know how many cycles wrgsbase takes, and how serializing
> > is it? Sadly Agner Fog's tables don't seem to list it...
> 
> Not (architecturally) serialising, and pretty quick IIRC.  It is
> microcoded, but the segment registers are renamed so it can execute
> speculatively.
> 
> ~Andrew
> 
> >
> > How would we actually do that overwriting and restoring of
> > KERNEL_GS_BASE? Would we need a scratch register for that?
> 

I think we can do the overwrite at any point before actually calling into 
the individual syscall handlers, really anywhere before potentially 
hijacked indirect control flow can occur and then restore it just after 
those return e.g., for the 64-bit path I am currently overwriting it at the
start of do_syscall_64 and then restoring it just before 
syscall_exit_to_user_mode. I'm not sure if there is any reason to do it
sooner while we'd still be register constrained.

~Jennifer
