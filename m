Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACA521A92F
	for <linux-hardening@vger.kernel.org>; Fri, 22 Aug 2025 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755850766; cv=none; b=DksoDEGVCKp1EvktY666JS5wBE84Yhp+WDIUlVaJ3BLrx52Hp3qNhTdnGGxsS8lX+z627CoKtdZB0/2o3XGVpo76Pd7UwwzH9YTpnwLl09XSnqagubfAA8/Gd7Kx9SxpPwraoL8IhNqy6ajVIA/h9J8Lx+ebsi7w/FZsZdL7Xt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755850766; c=relaxed/simple;
	bh=ew7PiCTN95H+0hX4JNQzHOU49ftwtk1AHQfa5mcL3yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7aXCfZX3gxlg//w5JZ32Tx7zpiGlyX3VGk3DeXBcK8VmjMSEekRXiWqSJXa4bfbHXRh193sx1Jz6LnuFEc5N2X66mQg5Pl38g718Tr9nNVzmQK5iY9EEhpd2/gS1/1OPeQ2M1H4++Nbld9IkXEMr2aQ05EaJ/Bh0TRO8DDsMXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rHzO71rN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rHzO71rN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=39AQMdJkxgPbll/iDoZEHIJPlCnNpq6W/+jciYIp8SE=; b=rHzO71rNAGuBj37BJ0D/v6ai8e
	N8iL6MX9suE6SAWq98P8FhxeDUkv8EkOfkseQ+UH7azczlPyZvWlCxv3P0iIw7OB+XwAszDgOsWQv
	V8TeESMVbEuwYxoeRhiM0VPcv5UwaDr5iHmxoT3JsaZhs+gpaCDo1pKrNNqFjEA6Gx3HJlcJ3cvZd
	KlgcV+VRCGuqaVWqN9oW1mCSeu1DHl5aWP45W08E4eVpuZbKJFZ9AImuuprt9IWIg+aU9z2ZMaHpi
	V0O3rKMeJMcZtf0sQJj1s0Oaz/GZGTSrOXpUBygv40aUq/dtUP9LY/ARCq3tapdQ4gireID8W0onk
	3QiMy42A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upMzT-00000005Qsq-2Z3y;
	Fri, 22 Aug 2025 08:19:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C9547300342; Fri, 22 Aug 2025 10:19:15 +0200 (CEST)
Date: Fri, 22 Aug 2025 10:19:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Qing Zhao <qing.zhao@oracle.com>, gcc-patches@gcc.gnu.org,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>, Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Dan Li <ashimida.1990@gmail.com>, linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH 4/7] x86: Add x86_64 Kernel Control Flow Integrity
 implementation
Message-ID: <20250822081915.GF3419281@noisy.programming.kicks-ass.net>
References: <20250821064202.work.893-kees@kernel.org>
 <20250821072708.3109244-4-kees@kernel.org>
 <20250821092935.GN4067720@noisy.programming.kicks-ass.net>
 <202508210916.71079E4BA8@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202508210916.71079E4BA8@keescook>

On Thu, Aug 21, 2025 at 11:46:17AM -0700, Kees Cook wrote:
> On Thu, Aug 21, 2025 at 11:29:35AM +0200, Peter Zijlstra wrote:

> > The current kernel FineIBT code hard assumes r11 for now.
> 
> Oh, it looked like it wasn't always r11. Does clang force the call
> register to be r11?

Yes. I'm not sure why, but that's what it does, unconditionally r11.

(funny extra detail, when using retpolines, clang sometimes generates
conditional tail-calls, it merged Jcc and JMP __x86_indirect_thunk_r11
into Jcc __x86_indirect_thunk_r11. I've never seen GCC do this).

> I only do that here if the call expression isn't a
> register (similar to -mindirect-branch-register). Looking at the retpoline
> implementation, I see __x86_indirect_thunk_* being generated for all the
> general registers. 

Yeah, generating the whole set was easiest. The BPF JIT and custom asm
also have retpolines in. Eg.

arch/x86/kernel/ftrace_64.S:    CALL_NOSPEC r8
arch/x86/platform/efi/efi_stub_64.S:    CALL_NOSPEC rdi

> Hm, but in looking now I see all the hard-coded r11 use
> in the fineibt alternatives. I wonder if my boot testing is somehow not
> triggering the FineIBT alternatives patching? I will investigate more...

Right, GCC typically prefers rax (with a wide margin) but pretty much
every register gets used on a big enough code-base.

Random defconfig of the day gets me:

  15227 __x86_indirect_thunk_rax
    417 __x86_indirect_thunk_rdx
    205 __x86_indirect_thunk_rcx
    110 __x86_indirect_thunk_r13
    108 __x86_indirect_thunk_r12
     98 __x86_indirect_thunk_r8
     97 __x86_indirect_thunk_rbp
     96 __x86_indirect_thunk_r10
     85 __x86_indirect_thunk_r14
     38 __x86_indirect_thunk_r15
     36 __x86_indirect_thunk_r9
     34 __x86_indirect_thunk_rbx
     28 __x86_indirect_thunk_r11
     16 __x86_indirect_thunk_rsi
      1 __x86_indirect_thunk_rdi

IIRC you clobber r10 for the hash usage, so you'll not generate indirect
calls through that, but other than that the code seems to preserve
random register if the address is already loaded in it, otherwise loads
into r11.

Anyway, I might be able to deal with the indirect call not being r11,
but it'll take a bit of prodding. Also it will shatter my plans to move
the hash to eax to save a few bytes in instruction encoding. Let me go
poke around with that UDB patch see what's possible.

