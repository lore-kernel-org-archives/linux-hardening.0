Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E702D3EC1;
	Tue, 31 Mar 2026 21:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774993692; cv=none; b=hb9S8tcD1G/OmRKolCqaANv5fGZean4RmH1MjzSK9s0nGoyMVmLpO3WMWR5o4pqR2S9ofIA72PYnjAa+1+d7R/x4uJqn82f1I9CL2Pz5AIYT+KgLEZHxj1swVIkc36+Y2FE3hAA0tM07dnnQVrzhFfqfjByNlAPXn+nKF2r5tcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774993692; c=relaxed/simple;
	bh=Qtm4MQQoKVdK0bfXHk8uzn1QcTd69reiKnAw38kPbqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTpO38hyyFLLMq3QYhAFe/BAp6yg6a2kORLlIfc6835jjjxdXDYY2BS31a/QanaduxiYoaARRI6l7EhZEyaaITrqZk8+Oan+1QPAJm5zlaYHFBcNC6NxRhrTqjY2/ApTya59fSFMQsx0c3nHtnHghOTJrGA7eGqCn95zY9iYGDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxWO47Uh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxWO47Uh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A71C19423;
	Tue, 31 Mar 2026 21:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774993691;
	bh=Qtm4MQQoKVdK0bfXHk8uzn1QcTd69reiKnAw38kPbqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pxWO47Uhb7/GCyl1QjpMF7RrVl4DmMvZxQ9XfKH0FsW7AKvLUQqm2bVVuRZwxIX8t
	 LDtGaJu/YrIGPkDQup4VkOS3b3E3bUMER9k4GiOhdGcQYd8Xj61G8KXAbp7IJo+LRu
	 +vqMY7e+Rd7J8RLGqPqiAZbg2rMrETT5kChqfqfegYB+/SbMjOxMqdJS2X8aF2BN50
	 yxvWv/TD+BOdVPy8RrWkt9o/GkCZ5qyG9g4KVbKuoSgOUtZeB2WyNZdzUQijaIgqpm
	 M+lx3EZ8pyiJEre1clTcVuATD/doHmP3FCJTadfsCz5KCKwLyNFLI7+nboRp/ByRzb
	 Dlp/gKrxVv5ow==
Date: Tue, 31 Mar 2026 14:48:11 -0700
From: Kees Cook <kees@kernel.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, kernel-dev@igalia.com, kernel@gpiccoli.net,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] pstore/ftrace: Factor KASLR offset in the core kernel
 instruction addresses
Message-ID: <202603311445.F9975321B1@keescook>
References: <20260313201010.1622406-3-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313201010.1622406-3-gpiccoli@igalia.com>

On Fri, Mar 13, 2026 at 05:00:22PM -0300, Guilherme G. Piccoli wrote:
> The pstore ftrace frontend works by purely collecting the
> instruction address, saving it on the persistent area through
> the backend and when the log is read, on next boot for example,
> the address is then resolved by using the regular printk symbol
> lookup (%pS for example).
> 
> Problem: if we are running a relocatable kernel with KASLR enabled,
> this is a recipe for failure in the symbol resolution on next boots,
> since the addresses are offset'ed by the KASLR address. So, naturally
> the way to go is factor the KASLR address out of instruction address
> collection, and adding the fresh offset when resolving the symbol
> on future boots.
> 
> Problem #2: modules also have varying addresses that float based
> on module base address and potentially the module ordering in
> memory, meaning factoring KASLR offset for them is useless.
> So, let's hereby only take KASLR offset into account for core
> kernel addresses, leaving module ones as is.
> 
> And we have yet a 3rd complexity: not necessarily the check range
> for core kernel addresses holds true on future boots, since the
> module base address will vary. With that, the choice was to mark
> the addresses as being core vs module based on its MSB. And with
> that...
> 
> ...we have the 4th challenge here: for some "simple" architectures,
> the CPU number is saved bit-encoded on the instruction pointer, to
> allow bigger timestamps - this is set through the PSTORE_CPU_IN_IP
> define for such architectures. Hence, the approach here is to skip
> such architectures (at least in a first moment).
> 
> TL;DR: let's factor KASLR offsets on pstore/ftrace for core kernel
> addresses, leaving module addresses out and also leaving the
> architectures that define PSTORE_CPU_IN_IP.
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
> 
> 
> Hi folks, first of all thanks in advance for reviews and comments!
> 
> I was testing a pstore/ftrace patch the other day and noticed
> the lack of the KASLR support. But to my surprise, it was not
> as easy to fix up as I expected heh
> 
> Main reason is the obvious thing with modules: the way to
> go, I think, is to somehow save the module name (or some other
> id?) and the instruction offset inside such module, to then
> resolve that in next boot, when printing. But that would require
> more intrusive changes in the way pstore/ftrace saves the IP
> (which is quite simple now), leading to some potentially
> meaningful perf overhead.
> 
> Hence, I've decided to just mess with core kernel addresses
> so far, lemme know WDYT - should I somehow pursue fixing
> modules addr resolution as well? Or doesn't worth the changes?
> Any ideas on how to approach that? I noticed that currently,
> modules' symbols are sometimes resolved fine, sometimes they're
> bogus but point to the module at least (not some other random
> code), but eventually they are just nonsense addresses.
> 
> Regarding the choice of using the MSB to store if an addr is core
> kernel or module, well this was also a choice taking into account
> simplicity and performance, lemme know please if it's no good and
> any suggestions on how to better do it, I can easily re-implement!
> Thanks again,
> 
> Guilherme
> 
> 
>  fs/pstore/ftrace.c   | 33 +++++++++++++++++++++++++++++++--
>  fs/pstore/inode.c    |  6 ++++--
>  fs/pstore/internal.h |  2 ++
>  3 files changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/pstore/ftrace.c b/fs/pstore/ftrace.c
> index 13db123beac1..58f8204b23af 100644
> --- a/fs/pstore/ftrace.c
> +++ b/fs/pstore/ftrace.c
> @@ -18,10 +18,35 @@
>  #include <linux/cache.h>
>  #include <linux/slab.h>
>  #include <asm/barrier.h>
> +#include <asm/setup.h>
>  #include "internal.h"
>  
>  /* This doesn't need to be atomic: speed is chosen over correctness here. */
>  static u64 pstore_ftrace_stamp;
> +unsigned long kaslr_off;

This should at least be "static", but why have it sitting in the data
segment at all, only to be scraped out by attackers with a arbitrary read
primitives? Can we just call kaslr_offset() directly as needed instead
(it's already an inline)?

-Kees

> +
> +static inline unsigned long adjust_ip(unsigned long ip)
> +{
> +#ifndef PSTORE_CPU_IN_IP
> +	if (core_kernel_text(ip))
> +		return ip - kaslr_off;
> +
> +	__clear_bit(BITS_PER_LONG - 1, &ip);
> +#endif
> +	return ip;
> +}
> +
> +inline unsigned long decode_ip(unsigned long ip)
> +{
> +#ifndef PSTORE_CPU_IN_IP
> +	if (test_bit(BITS_PER_LONG - 1, &ip))
> +		return ip + kaslr_off;
> +
> +	__set_bit(BITS_PER_LONG - 1, &ip);
> +
> +#endif
> +	return ip;
> +}
>  
>  static void notrace pstore_ftrace_call(unsigned long ip,
>  				       unsigned long parent_ip,
> @@ -47,8 +72,8 @@ static void notrace pstore_ftrace_call(unsigned long ip,
>  
>  	local_irq_save(flags);
>  
> -	rec.ip = ip;
> -	rec.parent_ip = parent_ip;
> +	rec.ip = adjust_ip(ip);
> +	rec.parent_ip = adjust_ip(parent_ip);
>  	pstore_ftrace_write_timestamp(&rec, pstore_ftrace_stamp++);
>  	pstore_ftrace_encode_cpu(&rec, raw_smp_processor_id());
>  	psinfo->write(&record);
> @@ -132,6 +157,10 @@ void pstore_register_ftrace(void)
>  	if (!psinfo->write)
>  		return;
>  
> +#ifdef CONFIG_RANDOMIZE_BASE
> +	kaslr_off = kaslr_offset();
> +#endif
> +
>  	pstore_ftrace_dir = debugfs_create_dir("pstore", NULL);
>  
>  	pstore_set_ftrace_enabled(record_ftrace);
> diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
> index 83fa0bb3435a..62e678f3527d 100644
> --- a/fs/pstore/inode.c
> +++ b/fs/pstore/inode.c
> @@ -105,17 +105,19 @@ static int pstore_ftrace_seq_show(struct seq_file *s, void *v)
>  	struct pstore_private *ps = s->private;
>  	struct pstore_ftrace_seq_data *data = v;
>  	struct pstore_ftrace_record *rec;
> +	unsigned long ip, parent_ip;
>  
>  	if (!data)
>  		return 0;
>  
>  	rec = (struct pstore_ftrace_record *)(ps->record->buf + data->off);
>  
> +	ip = decode_ip(rec->ip);
> +	parent_ip = decode_ip(rec->parent_ip);
>  	seq_printf(s, "CPU:%d ts:%llu %08lx  %08lx  %ps <- %pS\n",
>  		   pstore_ftrace_decode_cpu(rec),
>  		   pstore_ftrace_read_timestamp(rec),
> -		   rec->ip, rec->parent_ip, (void *)rec->ip,
> -		   (void *)rec->parent_ip);
> +		   ip, parent_ip, (void *)ip, (void *)parent_ip);
>  
>  	return 0;
>  }
> diff --git a/fs/pstore/internal.h b/fs/pstore/internal.h
> index a0fc51196910..079284120db9 100644
> --- a/fs/pstore/internal.h
> +++ b/fs/pstore/internal.h
> @@ -9,6 +9,7 @@
>  extern unsigned int kmsg_bytes;
>  
>  #ifdef CONFIG_PSTORE_FTRACE
> +extern unsigned long decode_ip(unsigned long ip);
>  extern void pstore_register_ftrace(void);
>  extern void pstore_unregister_ftrace(void);
>  ssize_t pstore_ftrace_combine_log(char **dest_log, size_t *dest_log_size,
> @@ -16,6 +17,7 @@ ssize_t pstore_ftrace_combine_log(char **dest_log, size_t *dest_log_size,
>  #else
>  static inline void pstore_register_ftrace(void) {}
>  static inline void pstore_unregister_ftrace(void) {}
> +static inline unsigned long decode_ip(unsigned long ip) { return ip; }
>  static inline ssize_t
>  pstore_ftrace_combine_log(char **dest_log, size_t *dest_log_size,
>  			  const char *src_log, size_t src_log_size)
> -- 
> 2.50.1
> 
> 

-- 
Kees Cook
