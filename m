Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A7519FA9A;
	Thu, 11 Jul 2024 21:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720734304; cv=none; b=HopyppNB4Pegm/FJB+X19smGqKDQa7gymwpjJwLzXs9HKqoF0f+62hi/FWcIsyLhJ2zIkGuIYtUuozyVP4uRLUpcgtd7drLmZkW/h4zs/xgD+nWf/ZBIVY/1xLSq2Yca+z5GpdSKQkLX2Ipwsw61fBsztdrg/wH9Na5Tmvx7ZRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720734304; c=relaxed/simple;
	bh=y4QCjrZp9udTHrKwao6/0x3F9ZJopGjZZ/0G6cebUoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBafdQhwmY3O9X0S4poyWArAQ60EiShGHXyHV4sDAa5Vc1mxgELAmQ9j9jdWwhzJaiXZo5Nd5+am0PfR8WZd56MRsKCgvvs6I+yd1FsV4w/yo1uEDmR0T4xPtLJhfETZdDDYrPX5ewk15p3ez1geR64fvRNlUUunXKPWX3mU/mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qYulYDrM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qYulYDrM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Q7XTOdv/1NFK+VQFz08tWfPZaB/5T1Gst3uridfDy8E=; b=qYulYDrM5a+mSSnWjHLULZz/hV
	oUxfKtOT1hcAbmxkqvrP10YQFASm2zRWpnNxxYNJtvZWOPlRGbtW+eOOcZ2dBESs1J4ZUyQs15b8a
	GJAclUyRyEEiWwUp50qeWHmd7p6mk4FWPWI/JEFQejdTtvlzIsE48U9gbX/LJa8CyuxEskKygJcKI
	aSwRuOnXrtmuRlbsy9eE1sTdvqgLUq0VfyE+wYVFal4lUfsD5uspAtEXIDRNhMbppxBr42qYjtKGx
	ctYGGDemDT4SUngr/kkHGoFn5rWcCzTMnEDBYfDOFwgi1Y+ooK95kWDkTq02SqdVquNUXd8/pI5an
	Egb4H2FA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sS1at-0000000Bgtl-13Yx;
	Thu, 11 Jul 2024 21:44:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9B44230050D; Thu, 11 Jul 2024 23:44:50 +0200 (CEST)
Date: Thu, 11 Jul 2024 23:44:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Mirsad Todorovac <mtodorovac69@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Peter Collingbourne <pcc@google.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86/syscall: Avoid memcpy() for ia32
 syscall_get_arguments()
Message-ID: <20240711214450.GG27299@noisy.programming.kicks-ass.net>
References: <20240708202202.work.477-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240708202202.work.477-kees@kernel.org>

On Mon, Jul 08, 2024 at 01:22:06PM -0700, Kees Cook wrote:
> Modern (fortified) memcpy() prefers to avoid writing (or reading) beyond
> the end of the addressed destination (or source) struct member:
> 
> In function ‘fortify_memcpy_chk’,
>     inlined from ‘syscall_get_arguments’ at ./arch/x86/include/asm/syscall.h:85:2,
>     inlined from ‘populate_seccomp_data’ at kernel/seccomp.c:258:2,
>     inlined from ‘__seccomp_filter’ at kernel/seccomp.c:1231:3:
> ./include/linux/fortify-string.h:580:25: error: call to ‘__read_overflow2_field’ declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror=attribute-warning]
>   580 |                         __read_overflow2_field(q_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> As already done for x86_64 and compat mode, do not use memcpy() to
> extract syscall arguments from struct pt_regs but rather just perform
> direct assignments. Binary output differences are negligible, and actually
> ends up using less stack space:
> 
> -       sub    $0x84,%esp
> +       sub    $0x6c,%esp
> 
> and less text size:
> 
>    text    data     bss     dec     hex filename
>   10794     252       0   11046    2b26 gcc-32b/kernel/seccomp.o.stock
>   10714     252       0   10966    2ad6 gcc-32b/kernel/seccomp.o.after
> 
> Reported-by: Mirsad Todorovac <mtodorovac69@gmail.com>
> Closes: https://lore.kernel.org/lkml/9b69fb14-df89-4677-9c82-056ea9e706f5@gmail.com/
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Daniel Sneddon <daniel.sneddon@linux.intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Brian Gerst <brgerst@gmail.com>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Cc: Peter Collingbourne <pcc@google.com>
> ---
>  arch/x86/include/asm/syscall.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
> index 2fc7bc3863ff..7c488ff0c764 100644
> --- a/arch/x86/include/asm/syscall.h
> +++ b/arch/x86/include/asm/syscall.h
> @@ -82,7 +82,12 @@ static inline void syscall_get_arguments(struct task_struct *task,
>  					 struct pt_regs *regs,
>  					 unsigned long *args)
>  {
> -	memcpy(args, &regs->bx, 6 * sizeof(args[0]));
> +	args[0] = regs->bx;
> +	args[1] = regs->cx;
> +	args[2] = regs->dx;
> +	args[3] = regs->si;
> +	args[4] = regs->di;
> +	args[5] = regs->bp;
>  }

Just for my education on things foritfy; would something like:

void syscall_get_arguments(struct pt_regs *regs, unsigned long args[6])
{
        memcpy(args, (typeof(args))&regs->bx, 6*sizeof(args[0]));
}

work?
