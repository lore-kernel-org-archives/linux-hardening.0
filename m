Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795373480;
	b=oX82OGtybiC2DEZfl1hBwuLgRD54JBUwrlsuXkdVn24MSqeTmwnRwtBAWwtFu9kGoAMH
	 JDZh1sO2vDF8TUwMwoI3ZXI9kGneV42WceCFsH12UI9T4gXW3cMGE+6+hn41Hq2WYKn/k
	 qyJr7yuylAZIHzT6zOsyjuvzhrANd0Kr7Kxk/vXnp9MJ4Y05EQuG5jm6sfWHNOrr16hGi
	 zp5hTKwx3p+hZQLMJSNEnjIlqCiVsH1fYhEgrJ/isvnnI6fQXOJfLK8CTzTyKrl1xVG4Q
	 nLCdRYjHIpiEXxBmCSe0J0pULgo9hXRmbKCVZywelr3gNOSBPSDLs0rixr/x7sEMJBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795373480;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tBD687EIYEUvkIrpnbGGfnzsILSIPeHgGqT6hWEefwg=;
	b=lsg06S6DdlYnjU6wL7bckJ0SE9OdXRFp8Dr+QgJ8sUja+L1EpVtOJ6CaYcwqF2Q8ApTt
	 0oiWSKe5kM5MBosw231u+0a55IW41kw9KOqDHBovd9ggifyHYx23vX1tMofulDa/rKjpn
	 KfUubSE1EJs/3RX4NmZIfvD3fB7txRtYkBbVbunkknDPy6RHeuAL4eQM7KGlXOYAKrJ9s
	 Cja50O0yPdQUxLouPBM/YErJNCIQ3qeAG4nr6cAVbLHn+6lVGouXTtF6x3FmUzMhERXaz
	 v81hwpNsOPdQT4fyh3PVpl0zQbU3CDL2/+iG1AjzsRkx9eGOqqTXyyTl8tUVGdVbG0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="GT/4K5bV";
	arc=none smtp.remote-ip=95.215.58.209
Received: from mta1.migadu.com (out-209.mta1.migadu.com [95.215.58.209])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA887606A320
	for <linux-hardening@vger.kernel.org>; Sun, 22 Nov 2026 18:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA887606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GT/4K5bV
X-Envelope-To: linux-hardening@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=tU3pIbFxSg5klEZ/exx9wdGBs2UPDs6YWG2Y6wCAkFY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795373477; v=1; x=1795978277;
 b=GT/4K5bVm+ehbEeyEdOGqAGY9JhjiFM/JyPXs/1GKd/LSuJeab9GJmQfEfMbs41hxoBMPmQz
 L8qNN2ndCAccEAfyB3G8tOuZgB7DwmdWNbWye01SMuOy022Lh4G1+0m8QcZdaAtuNghD2yC2ZBy
 Zjnq8mXFdCx34Fk5C6uimnzs=
X-Envelope-To: linux-hardening@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id e4ed702f020cbf52;
	Sun, 22 Nov 2026 18:51:17 +0000
X-Mizu-Trace-ID: e4ed702f020cbf52
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: David Laight <david.laight.linux@gmail.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	kees@kernel.org,
	hpa@zytor.com,
	gustavoars@kernel.org,
	ardb@kernel.org,
	hca@linux.ibm.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	rkeilty@meta.com,
	atish.patra@linux.dev,
	dgreid@meta.com
Subject: Re: [PATCH 2/2] x86/kstack_erase: Use REP STOSQ for large stack fills
Date: Sun, 22 Nov 2026 10:51:13 -0800
Message-ID: <20261122185114.1025845-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261121182208.19594445@pumpkin>
References: 
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 21 Nov 2026 18:22:08 +0000 David Laight <david.laight.linux@gmail.com> wrote:

> On Sat, 21 Nov 2026 13:57:39 +0000
> Usama Arif <usama.arif@linux.dev> wrote:
> 
> > On 20/11/2026 10:55, David Laight wrote:
> > > On Thu, 19 Nov 2026 13:31:08 -0800
> > > Usama Arif <usama.arif@linux.dev> wrote:
> > >   
> > >> With KSTACK_ERASE, every return to user space poisons the part of the
> > >> task stack that was used since the previous return. The generic
> > >> __stackleak_poison() does that one word per loop iteration, so a syscall
> > >> that went 1-2 KiB deep pays for 128-256 separate stores. On Meta hosts
> > >> running many small VMs, stackleak_erase() accounts for about 1.5% of
> > >> non-idle host kernel cycles.
> > >>
> > >> Override __stackleak_poison() on x86-64, as s390 already does, through
> > >> the hook added by commit 491a78663e03 ("stackleak: allow to specify arch
> > >> specific stackleak poison function"). Fill spans larger than 512 bytes
> > >> with REP STOSQ and keep the word loop for shorter ones, where the fixed
> > >> startup cost of REP STOSQ does not pay off. REP STOSQ starts to win at
> > >> about 300-400 bytes on Zen 5c and Cooper Lake, so on both no span gets
> > >> slower.  
> > > 
> > > As a matter of interest (and separately from the exact code) how did you
> > > measure the performance to get the 300-400 byte gain point?
> > >   
> > 
> > With a userspace benchmark pinned to one CPU. Each sample is one fill of
> > a stack buffer straight after a getppid() syscall, with
> > lfence;rdtsc;lfence around the fill only, an empty call subtracted, and
> > the mean of 15 times taken. The size stayed fixed for a whole run,
> > so the branches were well predicted. The plain loop and REP STOSQ
> > cost the same at about 430 bytes on Zen 5c and 320 bytes on
> > Cooper Lake.
> 
> The lfence (or mfence - which is the one you really need) take long
> enough that they don't give meaningful timings for anything short.
> I think they manage to overlap with the setup times for 'rep xxx'.
> You also get the problem that the tsc doesn't measure clocks and a lot
> of benchmarks run long enough that the cpu speed changes.

I redid it your way (user rdpmc on the cycles counter, no fences, data
dependencies in and out), and also with lfence and with mfence around
the rdpmc. Where REP STOSQ starts to win, in bytes:

                          plain loop   2 stores per loop
  Zen 5c, your method         384            877
  Zen 5c, lfence              429            821
  Zen 5c, mfence              424            829
  Cooper Lake, lfence         277            320
  Cooper Lake, mfence         358            358

With fences the loop and REP STOSQ both read a few cycles lower, so
the crossovers move by about 50 bytes. The fenced cycle counts match
my TSC numbers.

On Cooper Lake your method gives the plain loop the same crossover as
the fences, but has the two-store loop filling 512 bytes in 38 cycles
on a core that does one store per clock (60 with lfence, 66 with
mfence). The second rdpmc only waits for the loop pointer, which is
ready while the last stores are still queued.

> 
> I've updated my benchmark code and run some tests on zen5.
> This uses the PERF_COUNT_CPU_CYCLES counter but directly executing rdpmc.
> I then use data dependencies from the original count to the test code,
> and from the test result to the second rdpmc (which nicely has a register
> number) to get a time that includes the test function with little overhead.
> The clock count for an empty test function is 25, 32 with a memory read.
> 
> Each test is run 10 times and the clock count for each shown separately.
> The first column includes the cost of the I-cache loads and any branches
> that get mispredicted because (in these cases) the length changes.
> This is most obvious for the libc calls.
> 
> memset() to 4k aligned buffer
> 0: len   16 ok  445   32   32   32   32   32   32   32   32   32 no_memset
> 5: len   16 ok 10538  107   52   52   52   52   52   52   52   52 libc
> 6: len  256 ok  193  101   48   48   51   44   51   44   44   44 libc
> 7: len  512 ok  120   83   51   51   51   51   51   51   51   51 libc
> 8: len 1024 ok  111   56   56   55   56   55   56   55   56   56 libc
> 9: len 2048 ok  117   71   72   72   72   72   72   72   72   72 libc
> 10: len   16 ok   90   78   74   55   54   55   54   55   54   55 stosb
> 11: len  256 ok  112   78   78   78   78   78   78   78   78   78 stosb
> 12: len  512 ok   80   80   80   80   80   80   80   87   80   80 stosb
> 13: len 1024 ok   90   95   89   95   89   88   89   95   89   95 stosb
> 14: len 2048 ok  105  111  104  104  104  111  104  111  104  111 stosb
> 15: len   16 ok  104   88   84   58   58   58   58   58   58   58 stosq
> 16: len  256 ok  125   80   80   80   80   80   80   80   80   80 stosq
> 17: len  512 ok   82   83   83   90   82   82   83   83   82   82 stosq
> 18: len 1024 ok   90   91   91   98   91   98   91   98   91   91 stosq
> 19: len 2048 ok  106  113  106  113  106  113  106  106  106  113 stosq
> 20: len   16 ok  133   65   57   33   33   26   26   26   26   26 longs
> 21: len  256 ok  159  152   80   42   42   42   42   42   42   42 longs
> 22: len  512 ok  187  115   88   58   56   57   57   57   57   57 longs
> 23: len 1024 ok  146  211  167   89   88   88   88   88   88   90 longs
> 24: len 2048 ok  213  213  209  167  153  155  153  153  155  152 longs
> 
> memcpy() between 4k aligned buffers
> 0: len   16 ok  119   63   59   33   33   33   33   33   33   33 no_copy
> 5: len   16 ok 7333  103   51   51   51   51   51   51   51   51 libc
> 6: len  256 ok  447  105   51   51   51   51   51   51   51   51 libc
> 7: len  512 ok  405   56   56   56   56   56   56   56   56   56 libc
> 8: len 1024 ok  421   96   66   65   64   66   64   70   64   70 libc
> 9: len 2048 ok  406  139   81   83   81   85   81   83   83   81 libc
> 10: len   16 ok   91   81   76   56   56   56   56   56   56   56 movsb
> 11: len  256 ok  115   77   76   77   76   77   76   77   76   77 movsb
> 12: len  512 ok   80   81   80   81   80   81   81   81   80   81 movsb
> 13: len 1024 ok   90   89   90   89   90   89   90   89   90   89 movsb
> 14: len 2048 ok  112  106  105  106  105  106  105  106  105  106 movsb
> 15: len   16 ok  108   87   85   65   57   65   57   65   57   65 movsq
> 16: len  256 ok  119   78   78   78   79   78   79   78   79   78 movsq
> 17: len  512 ok   81   83   82   83   82   82   82   83   82   82 movsq
> 18: len 1024 ok   91   91   91   91   91   91   91   91   91   91 movsq
> 19: len 2048 ok  107  107  107  107  107  107  107  107  107  107 movsq
> 20: len   16 ok  110   62   56   32   32   32   32   32   32   32 longs
> 21: len  256 ok  203  128   58   57   57   57   57   47   47   47 longs
> 22: len  512 ok   97  152  190   95   65   63   65   63   65   63 longs
> 23: len 1024 ok  226  185  155  100   99   98  100   98   99   98 longs
> 24: len 2048 ok  201  262  260  179  171  166  170  169  171  166 longs
> 
> I added enough barrier() and OPTIMIZER_HIDE_VAR() to get the 'longs'
> loop to be sane - it sets/copies two 64bit locations each iteration.
> Both tests manage a loop iteration every clock (on zen5).
> 
> The cutoff for 'rep stos' is pretty much 1k.

For a loop with two stores per iteration, yes. But clang emits the
v2.1 loop with one store per iteration, which crosses at about 400
bytes on Zen 5c; your numbers give about 450 for a loop doing one
store per clock. gcc 15 unrolls it by two, which moves that to about
850. With the fences, Cooper Lake crosses at 280-360 bytes whatever
the loop shape, and a 1 KiB cutoff would make 512-1023 byte spans up
to 53 cycles slower there. 512 is in between and IMO the best comprimise.


> For memcpy() it is a bit lower.
> 
> 'rep movsq' is slightly slower than 'rep movsb' because of the 'len /= 8'.
> But it is much slower for counts of 1 (included above) and 0.
> 
> I need to boot up one of my other systems to see how older Intel cpu fair.
> 

The poison is -0xBEEF, so it has to be STOSQ, and memset64() only sees
spans over 512 bytes, never a count of 0 or 1.

In the kernel the fill hardly matters any more. Timing
stackleak_erase() over the same syscall mix, the fill is 7-8 ns of a
44 ns erase (37 ns with the generic loop), and REP STOSQ for
everything, Duff's device, 2x and 4x unrolling and v2.2 all land
within 1.2 ns of each other. About 37 ns is the search for the poison.

Over here I am testing on an AMD server less than 2 years old (Zen 5c)
and an Intel one that is 6 years old (Cooper Lake). IMO 512 bytes plus
memset64() (v2.1) is a good compromise between them.

> David
> 
> > 
> > > If the count is variable - likely in real life, you'll get a branch
> > > misprediction penalty (about 20 clocks on zen5) every time you change
> > > between the two choices.
> > > The copy loop will have another mispredict penalty for the loop itself.
> > > 
> > > So you are likely to get an overall improvement if you use 'rep stos'
> > > for all lengths - even the ones for with it is slightly slower.
> > > Unless, that is, you know at compile time that most of the length
> > > will be short.  
> > 
> > 
> > I timed every stackleak_erase() in a Zen 5c guest running a
> > futex, epoll, procfs and unix socket mix, with the variants switchable
> > at runtime and alternated over 15 rounds:
> > 
> >   Unpatched                     68.3 ns per erase
> >   REP STOSQ for all lengths     47.3 ns
> >   v1 / v2.1 (loop up to 512 B)  46.6 ns
> >   v2.2 (4 stores/iteration)     43.7 ns
> > 
> > The spans aren't random. Unix socket and /proc/self/stat exits were over
> > 1 KiB every time, while getppid(), epoll_wait(), read() and write() exits
> > were under 128 bytes almost everytime.
> > 
> > My preference still is v2.1 because of the simplicity.
> > 
> > > 
> > > David
> > >   
> > >>
> > >> The fill is inline asm, so the noinstr function still makes no calls.
> > >> memset64() would be the same instruction, but it is only static inline,
> > >> and with KMSAN it is an out-of-line function.
> > >>
> > >> In a Zen 5c KVM guest, stackleak_erase() got about 35% cheaper per return
> > >> to user space (71 ns to 46 ns, scan included) over a futex, epoll, procfs
> > >> and Unix socket syscall mix. Same-vCPU futex wake/wait and Unix socket
> > >> sendmsg()/recvmsg() ping-pong round trips got 5-8% faster.
> > >>
> > >> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> > >> ---
> > >>  arch/x86/include/asm/processor.h | 25 +++++++++++++++++++++++++
> > >>  1 file changed, 25 insertions(+)
> > >>
> > >> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> > >> index 77488ff5eb8c7c..049231d484ad0e 100644
> > >> --- a/arch/x86/include/asm/processor.h
> > >> +++ b/arch/x86/include/asm/processor.h
> > >> @@ -580,6 +580,31 @@ static __always_inline bool on_thread_stack(void)
> > >>  			       current_stack_pointer) < THREAD_SIZE;
> > >>  }
> > >>  
> > >> +#ifdef CONFIG_X86_64
> > >> +#define __stackleak_poison __stackleak_poison
> > >> +static __always_inline void __stackleak_poison(unsigned long erase_low,
> > >> +					       unsigned long erase_high,
> > >> +					       unsigned long poison)
> > >> +{
> > >> +	unsigned long count;
> > >> +
> > >> +	/* Short spans do not amortize the startup cost of REP STOSQ. */
> > >> +	if (erase_high <= erase_low + 512) {
> > >> +		while (erase_low < erase_high) {
> > >> +			*(unsigned long *)erase_low = poison;
> > >> +			erase_low += sizeof(unsigned long);
> > >> +		}
> > >> +		return;
> > >> +	}
> > >> +
> > >> +	count = (erase_high - erase_low) / sizeof(unsigned long);
> > >> +	asm volatile("rep stosq"
> > >> +		     : "+D" (erase_low), "+c" (count)
> > >> +		     : "a" (poison)
> > >> +		     : "memory");
> > >> +}
> > >> +#endif
> > >> +
> > >>  #ifdef CONFIG_PARAVIRT_XXL
> > >>  #include <asm/paravirt.h>
> > >>  #else  
> > >   
> > 
> 
> 
