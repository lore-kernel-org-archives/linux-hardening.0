Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177602;
	b=velYH0SIshU9iiCMQepO/1WVmukI3vOodfY96CJyIRa+bKnJ1x57F3ZY2m4lg0T3p6Nz
	 QUXV6OsTRpTcVuEFAo3qoy5tH+gT+RQZASm6UQBSq04fyK+28G6eDJc/FxUC6eFGy5yuZ
	 rHNcsZZLpcLhWY41F/SXDN3BkzbONQ4bWj4F1MuhCWdFaaruEs7WQ6LYhjAY4uGFB8SfS
	 CDjZyw9cZfd2WDLF5KeL9YVRlf4SMj31SwTC/TEFGoiCaWH82M6QfyRd6cmK8PYTMMvys
	 3qbktg7swjD4voZR1BXnjoqhVvJGXQ3UWq23QyT4aXzlDVfyLU3UL+NVQDkIuJxxoMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177602;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=i+Y/07rXkLFQwfl0rlArIush0x5kOH+nsMNA0F/hQv0=;
	b=zR0Ae8T6DKDVc4XdhzP1fwoiwLSduQoFLPxdqR7A6I0Pf138g7Y4Bt26F9SyM6Il8BAz
	 qdhSn6izLfBKbH/dJLeQhBPDDEl1T4jyh4ZgES5GiNpYTEU4937khV1HixsX+8X0t2cEJ
	 Ipz9cb+Z4piODS2zqztyaHQeFjv5v2ZczyorA1kCr2jftCMn+egmjW+Pj1D9D69N5njqE
	 f/Lyumgx5b8OPE+z/QMFB5HErKonprk8ernctBVGuq5vpqFheVyX4A6ayyrubPnksltZf
	 gLFFTWbkQCJ5mjl+sktRpP9fo5FwqW0puTe5N/rRjYD0MKbS/k0adk7Cg/a+kolsIYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=UwO07ypm;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57719606A320;
	Fri, 20 Nov 2026 12:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57719606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=UwO07ypm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i+Y/07rXkLFQwfl0rlArIush0x5kOH+nsMNA0F/hQv0=; b=UwO07ypmY2M/3gR5i8DPHfPKi3
	PekY4u6TyZqu+Ark4E7GE0yFHzhQBRAdLaqvveOPmXt4nGraLYdPQkkxf3ykv6UIyvIAKyW1HbvMn
	GHuYVRfRfZk+hwfdgiXvac45C/uKYPiZM2KujkYetUl33a2lVG2uwhAjbIrKXaEO4fQYBnm3GXLl9
	JN0aEYrWw8TAQwuvp7cCfT/BYJaMt6HLYKgRtNCzGg+zM42REBgQmF/SRej2LDxcQniPx5BpnoPPn
	PX+9kLNybr+OT94kYOGGG1yvoFSNA1UBVuFVOkG9uVhEhPnyPHtDpdlNsjd4q4+9ECT0SbRRLyUAE
	c1OFTLfQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUNhN-00000000kfY-1NPt;
	Fri, 20 Nov 2026 12:26:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 53E993008D6; Fri, 20 Nov 2026 13:26:35 +0100 (CET)
Date: Fri, 20 Nov 2026 13:26:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, kees@kernel.org,
	hpa@zytor.com, gustavoars@kernel.org, ardb@kernel.org,
	hca@linux.ibm.com, nathan@kernel.org, ndesaulniers@google.com,
	morbo@google.com, justinstitt@google.com,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org, riel@surriel.com,
	shakeel.butt@linux.dev, kernel-team@meta.com, rkeilty@meta.com,
	atish.patra@linux.dev, dgreid@meta.com
Subject: Re: [PATCH 2/2] x86/kstack_erase: Use REP STOSQ for large stack fills
Message-ID: <20261120122635.GJ2669272@noisy.programming.kicks-ass.net>
References: <20261119213147.1094488-1-usama.arif@linux.dev>
 <20261119213147.1094488-3-usama.arif@linux.dev>
 <20261120104534.GO2668564@noisy.programming.kicks-ass.net>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120104534.GO2668564@noisy.programming.kicks-ass.net>

On Fri, Nov 20, 2026 at 11:45:34AM +0100, Peter Zijlstra wrote:
> On Thu, Nov 19, 2026 at 01:31:08PM -0800, Usama Arif wrote:
> > +#ifdef CONFIG_X86_64
> > +#define __stackleak_poison __stackleak_poison
> > +static __always_inline void __stackleak_poison(unsigned long erase_low,
> > +					       unsigned long erase_high,
> > +					       unsigned long poison)
> > +{
> > +	unsigned long count;
> > +
> > +	/* Short spans do not amortize the startup cost of REP STOSQ. */
> > +	if (erase_high <= erase_low + 512) {
> > +		while (erase_low < erase_high) {
> > +			*(unsigned long *)erase_low = poison;
> > +			erase_low += sizeof(unsigned long);
> > +		}
> > +		return;
> > +	}
> > +
> > +	count = (erase_high - erase_low) / sizeof(unsigned long);
> > +	asm volatile("rep stosq"
> > +		     : "+D" (erase_low), "+c" (count)
> > +		     : "a" (poison)
> > +		     : "memory");
> > +}
> > +#endif
> 
> Gemini seems to suggest 16-32 words would be sufficient to amortize the
> REP STOS setup. It was also adamant I try and unroll that earlier loop.
> 
> How about something like so, does that make sense? Also, I suppose we
> should make memset64() __always_inline if we use it here. I'm not at all
> sold on the unroll here, the asm is pretty horrid for what it does.

This one is much improved:

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -28,6 +28,7 @@ struct vm86;
 #include <asm/vmxfeatures.h>
 #include <asm/vdso/processor.h>
 #include <asm/shstk.h>
+#include <asm/string.h>
 
 #include <linux/personality.h>
 #include <linux/cache.h>
@@ -580,6 +581,35 @@ static __always_inline bool on_thread_st
 			       current_stack_pointer) < THREAD_SIZE;
 }
 
+#ifdef CONFIG_X86_64
+#define __stackleak_poison __stackleak_poison
+static __always_inline void __stackleak_poison(unsigned long erase_low,
+					       unsigned long erase_high,
+					       unsigned long poison)
+{
+	unsigned long count = (erase_high - erase_low) / sizeof(unsigned long);
+
+	/* Amortize the startup cost of REP STOSQ. */
+	if (count < 32) {
+		unsigned long *ptr = (unsigned long *)erase_low;
+
+		while (count) {
+			unsigned long mod = (count-1) % 4;
+			count -= mod+1;
+			switch (mod) {
+			case 3: ptr[count+3] = poison; fallthrough;
+			case 2: ptr[count+2] = poison; fallthrough;
+			case 1: ptr[count+1] = poison; fallthrough;
+			case 0: ptr[count+0] = poison; break;
+			}
+		}
+		return;
+	}
+
+	memset64((void *)erase_low, poison, count);
+}
+#endif
+
 #ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
 #else
