Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354B718BBB9;
	Mon, 17 Feb 2025 18:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739817512; cv=none; b=EFmyIhkle/2+AZKw/hpXp8Vrp2/Qlj5JqIwycK9/RTFA7QDA159a+Izo9NL9Juma1mMrf/9bByh7C0onZLcKQY/kcRaCqwVuzEJtacVKwK2XBCXTDgwxuWJrIOh2tBw31GstwzS+v35K0NMZ9aKWD67UyorNIifghjeH+hwHRcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739817512; c=relaxed/simple;
	bh=p+MoBa72KVvlqi6aWicJbmnoV900cQSrVhXyOT9Hi1M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S82kS0d5iQeAaiguUgG2eOtwqUHAUdszh5SHvrlRcjeibT0EtIVepaAi/dvEo5a554r50KUMv8ETvfUY5oP5K8nf4n5giSEVPUVfCZ9UKQEfA3/Yok5YWosk3cq55dI9emnAMNkLGQdAFk5Jt5PJc2wABjaKB9KZ0IIEw6cesnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6oLmxjp; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6oLmxjp"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43937cf2131so31186385e9.2;
        Mon, 17 Feb 2025 10:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739817509; x=1740422309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFKUweoSkQnhokyuzvXsHWDn9zurQi5MHISz9Qh6rtw=;
        b=S6oLmxjpCo3T60jePrFlk2m0b2oYPeIkTaalkBYcjjDo9LMnhF80mIYnDo3vsdmejp
         LFdnHQJ104CWo1L3M73S5c6ggzmE5zNB+oox+IIu8tRsw8N658jqc4szvNhWNlD+7ET2
         5j1DRBvqsmkkI98KdCiEPPVzcZlakObImD3lxFIxD6fLvWXGb3qrw2PzxZ5WQUmEoBrW
         ovHxxCYiZ43yr0nAF/1joS40BlkRk9t175aUwFWRtJ+ZuOVK6TB2Mhj1nW1sMm5i7Dxa
         q3JLejc7PVdK6QHOrcBsO3gfTe09QqBpxRgEOYbKn54UhR+SgzCmhyyddp3K6kfjLX+h
         nNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739817509; x=1740422309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFKUweoSkQnhokyuzvXsHWDn9zurQi5MHISz9Qh6rtw=;
        b=cTt1E1gh2ah8ZwX+lx03JSH0Z297Re1H26Uccj+qqYp8xdjKAMvUqS/zy0FU+QoD50
         DFevBRn0occ4i0YioLiV0PQTAu7B9XvTgcIEGBcgjWKMgL+wX3iyD87bO2+ge1WYd6xF
         3C986i6+OYMMlV7Rhy0MhS7ZxfBDW9Xjba1QOsicscYNul56h/iy9DxikJ2IscD1Qgre
         yLK/Ws1EDyBYOHVhyd1EiD5glHTt6jGw3JzcSko3i40RIXczo2MkrWsHegrtg11k9shk
         79cs0HSaRsSN5A1ERcrgyxxqIxgZQxz94R0J3AAZNJWIsdTx4vhIQRM53fyYXKLWshlI
         8Gow==
X-Forwarded-Encrypted: i=1; AJvYcCVUUnXP5NGYKXIKAu55+jRnOwxqoZnGgUDhZqorSz4iNOHog9VwZn4drZ9wnK+R3Bq5wCpHFMX2aZA9PtxdYcc=@vger.kernel.org, AJvYcCXgXEp+/iXaRAR8jgojmShfWQlo4pLQ/iE+FIWuxDwOVlhKSMCEQDy+YUSTnEXl3NiCILYsRF485RjMndkB@vger.kernel.org
X-Gm-Message-State: AOJu0YyVKuq6gZNVF6OgdrbCm5FJ0kyoGoBpF2zHjrBrv3Xyk6m0pqW+
	pGIsYwMhnW28+8b7ny2uwpjnyNDE6Vxv1R/LoiAtJKUzynRhdcaF
X-Gm-Gg: ASbGnct4b7EKCzoeEorwCBYa2XcJ8GRmq2Idbhj3rpBoiiizjEAH1PXZC4AcxFZ1Ic3
	DiiwIXFhM5O49lxj1K2UMyFCp0YWNv43zeW0BXDHcBkRtlLhr/HfjVjDEmRPknGl9gVX1iVTmeX
	ns9F9ZVHUJLFLunZ3RJ5D1ivhaW5vjj36yq0cFcPW0OCbFMZvMRBaoWFByVsheH8fDajb0PeBog
	G5MVeuMh4hXVWWHOgI1fMFYqbNtetMgdTwfXseLo3+IHEmIGsYaMIyStTS0tVoKq+qgMAUI49Mu
	OoLT2OXgqkU54lUYMICt0w86+t5UFEvQHx4DPkk4fp1L0vneur8zdw==
X-Google-Smtp-Source: AGHT+IF31l27x2012sCEF7nXPo644NzxlM+P1KouFIGxbulaIz9leaxA8lB5fjyvrHRAmNdhYHT8aA==
X-Received: by 2002:a05:600c:1d23:b0:434:9934:575 with SMTP id 5b1f17b1804b1-4396e6fe730mr120415665e9.16.1739817509258;
        Mon, 17 Feb 2025 10:38:29 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43982bcc607sm40993705e9.16.2025.02.17.10.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 10:38:28 -0800 (PST)
Date: Mon, 17 Feb 2025 18:38:27 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <kees@kernel.org>, Andrew Cooper <andrew.cooper3@citrix.com>,
 jannh@google.com, jmill@asu.edu, joao@overdrivepizza.com,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 luto@kernel.org, samitolvanen@google.com, scott.d.constable@intel.com,
 x86@kernel.org
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
Message-ID: <20250217183827.41da5f52@pumpkin>
In-Reply-To: <20250217131321.GO14028@noisy.programming.kicks-ass.net>
References: <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
	<c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com>
	<202502131224.D6F5A235@keescook>
	<6641d1e0-7151-4857-bb0e-db555d4cdf50@citrix.com>
	<202502131248.B6CC333@keescook>
	<20250214095751.GF21726@noisy.programming.kicks-ass.net>
	<20250215210729.GA25168@noisy.programming.kicks-ass.net>
	<20250217130629.37f556b0@pumpkin>
	<20250217131321.GO14028@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 14:13:21 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Feb 17, 2025 at 01:06:29PM +0000, David Laight wrote:
> > On Sat, 15 Feb 2025 22:07:29 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >   
> > > On Fri, Feb 14, 2025 at 10:57:51AM +0100, Peter Zijlstra wrote:  
> > > > On Thu, Feb 13, 2025 at 12:53:28PM -0800, Kees Cook wrote:
> > > >     
> > > > > Right, the "if they can control a function pointer" is the part I'm
> > > > > focusing on. This attack depends on making an indirect call with a
> > > > > controlled pointer. Non-FineIBT CFI will protect against that step,
> > > > > so I think this is only an issue for IBT-only and FineIBT, but not CFI
> > > > > nor CFI+IBT.    
> > > > 
> > > > Yes, the whole caller side validation should stop this.    
> > > 
> > > And I think we can retro-fit that in FineIBT. Notably the current call
> > > sites look like:
> > > 
> > > 0000000000000060 <fineibt_caller>:
> > >   60:   41 ba 78 56 34 12       mov    $0x12345678,%r10d
> > >   66:   49 83 eb 10             sub    $0x10,%r11
> > >   6a:   0f 1f 40 00             nopl   0x0(%rax)
> > >   6e:   41 ff d3                call   *%r11
> > >   71:   0f 1f 00                nopl   (%rax)  
> > 
> > I tried building a fineibt kernel (without LTO) and that isn't what I
> > see in the object files.
> > (I not trying to run it, just do some analysis.)
> > While the call targets have a 16 byte preamble it is all nops apart
> > from a final 'mov $hash,%rax'.
> > The call site loads $-hash and adds -4(target) and checks for zero.
> > It is too small to be patchable into the above.  
> 
> Right after that comes the retpoline site, which is another 6 bytes
> (assuming you have indirect-branch-cs-prefix, which all kCFI enabled
> compilers should have).

I'm building with clang 18.1.18 - should be new enough.
I may not have retpolines enabled, a typical call site is (from vmlinux.o):
    3628:       48 89 c6                mov    %rax,%rsi
    362b:       41 ba 83 c5 2c af       mov    $0xaf2cc583,%r10d
    3631:       44 03 51 fc             add    -0x4(%rcx),%r10d
    3635:       74 02                   je     3639 <vc_handle_exitcode+0x739>
    3637:       0f 0b                   ud2
    3639:       ff d1                   call   *%rcx
    363b:       4c 89 f6                mov    %r14,%rsi

That one has three targets, one is:
000000000008a5c0 <__cfi_kvm_sev_es_hcall_prepare>:
   8a5c0:       90                      nop
   8a5c1:       90                      nop
   8a5c2:       90                      nop    
   8a5c3:       90                      nop    
   8a5c4:       90                      nop    
   8a5c5:       90                      nop    
   8a5c6:       90                      nop    
   8a5c7:       90                      nop    
   8a5c8:       90                      nop    
   8a5c9:       90                      nop    
   8a5ca:       90                      nop
   8a5cb:       b8 7d 3a d3 50          mov    $0x50d33a7d,%eax
    
000000000008a5d0 <kvm_sev_es_hcall_prepare>:
   8a5d0:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1) 8a5d1: R_X86_64_NONE    __fentry__-0x4
   8a5d5:       48 8b 46 28             mov    0x28(%rsi),%rax

I think that if I had endbra enabled objtool would remove them from non-exported
functions whose address isn't taken.
But none of the 'mov $hash,%eax' get removed - and I think they should suffer
the same fate.

I'm not sure why I don't have endbra though.
I did remove a lot of the mitigations from the config I copied to add the caller
side fineibt (I think) hash checks.
After all this is a local system I want to run fast, not a semi-public one
someone might try to hack.

> You need to go read arch/x86/kernel/alternative.c search for FineIBT

I found some stuff in one of the docs.
Didn't read that bit of source.

What I was hoping to obtain was a list of the valid target functions for
each indirect call site.
With the stack offset of the call (which objtool knows) and a lot of 'shaking'
an real estimate of max stack depth can be determined.
(and recursive loops found.)

	David
 

