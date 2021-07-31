Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62380C4338F
	for <linux-hardening@archiver.kernel.org>; Sat, 31 Jul 2021 20:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A7A560EEA
	for <linux-hardening@archiver.kernel.org>; Sat, 31 Jul 2021 20:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhGaUu5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 31 Jul 2021 16:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhGaUu4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 31 Jul 2021 16:50:56 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66058C06175F
        for <linux-hardening@vger.kernel.org>; Sat, 31 Jul 2021 13:50:49 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so104061pjs.0
        for <linux-hardening@vger.kernel.org>; Sat, 31 Jul 2021 13:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VnMqfzMVTg0x1HRdFGfgkTw55GFtvAE3ExK+w4e9m/c=;
        b=km6Orw5PCecHdgsCIybxrUtDbsbCqq4GcjRtwm6+0IQWsmnUj1AGMAEQVCASQ0MlY/
         F9sZeriDjNZnroS4MykGhmc/CDlcgDgQJ/Qxx+bb1zfI6Ufopv7+ACMauMcYkgyphd6F
         iITIE4t3Q49FdPTCcer+1ntCDVCBW0hs43ZzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VnMqfzMVTg0x1HRdFGfgkTw55GFtvAE3ExK+w4e9m/c=;
        b=eKu//fLtJAoHSs4elIt6G5YVd9oPtyCLC3W34QuHTLarn8PE5horPY1WzdV641krZq
         +ri3UgptiVmDqQpzAMJiQS+Q3dm9Dwen0VobzBI/38yL7hAxif2BJmiXqVaS7GYGzG4d
         Ldpy1pPhlpLRdz+wwa5FCEBbm30OwQJXwu3u3PF4Q/dOYwH4QDENuDnNC5endZxiPHhk
         A7xfqLHtgzXZ31eF5qz0tsBJGSlZSqtlFB+hEc8ZVYok2+R56IJdplfoRd2kr+ivkgE1
         w27MT5bhocPgmbYyzzAD9gX7jh3S89eklm1DX8OjN7p5jMeoFWUYYAwVFCREr51G/Db3
         KUbA==
X-Gm-Message-State: AOAM531dxyOOX8Q5RtxLb0VJZtcNku6tUnQ1YVsas8Iq8l7i5mctCEXt
        HBMfGFgCM41nAd6IavUPgc2GEQ==
X-Google-Smtp-Source: ABdhPJxJXxnsMq8LXE+IuPfAcVtjydVwbqHK39nbpIEYmE8fJPBjwKuPClSm32SSpFRqyhrv3ivaCg==
X-Received: by 2002:a17:902:dad0:b029:12c:83ca:fdd4 with SMTP id q16-20020a170902dad0b029012c83cafdd4mr7950160plx.77.1627764648954;
        Sat, 31 Jul 2021 13:50:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a13sm7452631pgt.58.2021.07.31.13.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 13:50:48 -0700 (PDT)
Date:   Sat, 31 Jul 2021 13:50:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Wang Zi-cheng <wzc@smail.nju.edu.cn>
Cc:     tycho@tycho.pizza, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] RFC v2 struct const ops pointers member hardening
Message-ID: <202107311334.C63187D@keescook>
References: <20210728065239.472464-1-wzc@smail.nju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728065239.472464-1-wzc@smail.nju.edu.cn>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jul 28, 2021 at 02:52:40PM +0800, Wang Zi-cheng wrote:
> Signed-off-by: Wang Zi-cheng <wzc@smail.nju.edu.cn>
> --------------------
> RFC v2 struct const ops pointers member hardening
> 
> I apologize for making mistakes in my previous submission, I fix the previous problems,
>  add compile options and make tests(compile and lmbench).
> 
> 1. this is a useful hardening, my opinion was wrong in the previous patch, 
> because the attacker may overwrite a struct with an "struct file*" pointer,
>  which point to a manufactured file struct with malicious f_op.
> Hardening operation pointers CAN help.
> > On the other side, kernel uses `kmem_cache_create` to alloc file/inode rather than `kmalloc`, 
> > which makes it hard to exploit through heap overflow or UAF, so maybe this is not a "must" update.
> 
> 2. V2 add compile option 'STRUCT_CONST_OPS_POINTER_HARDENING' in 
> 'Security options -> Kernel hardening options -> Struct const operation pointers hardening'
> 
> > PATCH v1
> > some security sensitive kernel objects, i.e. inode, file, use 'const' to declare operations pointers, 
> > and these pointers reference to the static global variables in read only data segment.
> 
> > ```
> > struct file {
> >   ...
> > 	const struct file_operations	*f_op;
> > 
> > const struct file_operations ext4_file_operations = {
> > ```
> 
> > However, const pointers are just compile hints with no hardware restrictions and prone to be modified by attakers at runtime.
> > It would be safer to make sure struct const pointer members are not pointing to malicious payload in the slab objects(direct mapping region).
> > we only need to check "open" syscall, because most file-related operations start with "open".
> 
> 
> ---
>  arch/x86/include/asm/pgtable_64_types.h |  5 +++++
>  fs/open.c                               |  5 +++++
>  include/linux/mm.h                      |  9 +++++++++
>  security/Kconfig.hardening              | 13 +++++++++++++
>  4 files changed, 32 insertions(+)
> 
> diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
> index 91ac10654570..869ef3dfaf29 100644
> --- a/arch/x86/include/asm/pgtable_64_types.h
> +++ b/arch/x86/include/asm/pgtable_64_types.h
> @@ -128,18 +128,23 @@ extern unsigned int ptrs_per_p4d;
>  
>  #define __VMEMMAP_BASE_L4	0xffffea0000000000UL
>  #define __VMEMMAP_BASE_L5	0xffd4000000000000UL
> +#define DIRECT_MAPPING_TB_L4 64UL
> +#define DIRECT_MAPPING_TB_L5 32000UL
>  
>  #ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
>  # define VMALLOC_START		vmalloc_base
>  # define VMALLOC_SIZE_TB	(pgtable_l5_enabled() ? VMALLOC_SIZE_TB_L5 : VMALLOC_SIZE_TB_L4)
>  # define VMEMMAP_START		vmemmap_base
> +# define DIRECT_MAPPING_SIZE_TB 	(pgtable_l5_enabled() ? DIRECT_MAPPING_TB_L5 : DIRECT_MAPPING_TB_L4)
>  #else
>  # define VMALLOC_START		__VMALLOC_BASE_L4
>  # define VMALLOC_SIZE_TB	VMALLOC_SIZE_TB_L4
>  # define VMEMMAP_START		__VMEMMAP_BASE_L4
> +# define DIRECT_MAPPING_SIZE_TB		DIRECT_MAPPING_TB_L4
>  #endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
>  
>  #define VMALLOC_END		(VMALLOC_START + (VMALLOC_SIZE_TB << 40) - 1)
> +#define DIRECT_MAPPING_END		(__PAGE_OFFSET + (DIRECT_MAPPING_SIZE_TB << 40) - 1)
>  
>  #define MODULES_VADDR		(__START_KERNEL_map + KERNEL_IMAGE_SIZE)
>  /* The module sections ends with the start of the fixmap */
> diff --git a/fs/open.c b/fs/open.c
> index e53af13b5835..871750b57267 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -820,6 +820,11 @@ static int do_dentry_open(struct file *f,
>  
>  	/* normally all 3 are set; ->open() can clear them if needed */
>  	f->f_mode |= FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
> +	/* check if f_op point to malicious payload */
> +#ifdef CONFIG_STRUCT_CONST_OPS_POINTER_HARDENING
> +	WARN_ON (!check_valid_ops_pointer((unsigned long) f->f_op));
> +	WARN_ON (!check_valid_ops_pointer((unsigned long) f->f_inode->i_op));

I would use WARN_ON_ONCE() to avoid spamming the logs. Also, if you use
a void * argument for check_valid_ops_pointer(), you can avoid these
casts, and keep the cast central to check_valid_ops_pointer() itself,
making the code easier to read.

Also, I recommend using:

	if (IS_ENABLED(CONFIG_STRUCT_CONST_OPS_POINTER_HARDENING)) {
	}

instead of the #ifdefs.

> +#endif
>  	if (!open)
>  		open = f->f_op->open;

Shouldn't the test happen here instead, since the "open != NULL" case
will skip dereferencing f->f_op?

>  	if (open) {
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8ae31622deef..c787acda7012 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3250,6 +3250,15 @@ static inline int seal_check_future_write(int seals, struct vm_area_struct *vma)
>  
>  	return 0;
>  }
> +#ifdef CONFIG_STRUCT_CONST_OPS_POINTER_HARDENING
> +static inline bool check_valid_ops_pointer(unsigned long addr)
> +{
> +	if (addr >= __PAGE_OFFSET && addr <= DIRECT_MAPPING_END) 
> +		return false;
> +	else
> +		return true;
> +}
> +#endif

It looks like you want to be checking for the ops pointer to point
into kernel .rodata section, yes? (Or maybe some are also in just
.data?) I think an easier (and more accurate) approach would be to
introduce something like the existing func_ptr_is_kernel_text() routine
but for rodata (maybe named func_ptr_is_kernel_rodata()). You'd
need to add core_kernel_rodata() like core_kernel_data() and
is_module_rodata_address(), similar to is_module_text_address().

>  
>  #endif /* __KERNEL__ */
>  #endif /* _LINUX_MM_H */
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index a56c36470cb1..3a7e2a046842 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -219,4 +219,17 @@ config INIT_ON_FREE_DEFAULT_ON
>  
>  endmenu
>  
> +config STRUCT_CONST_OPS_POINTER_HARDENING
> +	depends on X86_64

Using ptr_is_kernel_rodata() would also make this architecture-agnostic.

> +	bool "Struct const operation pointers hardening"
> +	help
> +		Security sensitive kernel objects, i.e. 'inode', 'file' protect 
> +		indirect call pointers by declaring const operation pointers and 
> +		making these pointers reference to static const global variables. 
> +		However const members in the kernel object are just compile hints
> +		with no hardware restriction. To hardening the operations pointers
> +		in structs, put a check in "open syscall" and make sure pointers
> +		are not pointing to the malicious payload in slub 
> +		objects(direct mapping region).

This appears to be a form of weak CFI designed to protect specifically
these ops pointers, yes?

For your commit log, perhaps justify why ops pointers are chosen to
protect. Are there other pointers that could be protected as well? (In
other words, what would be the _next_ most common thing an attacker
would corrupt in the face of this defense being present?)

-Kees

> +
>  endmenu
> -- 
> 2.32.0
> 
> 
> 

-- 
Kees Cook
