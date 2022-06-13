Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F96C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 19:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347254AbiFMTDI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346971AbiFMTCm (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 15:02:42 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695C049FA5
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 09:37:18 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id o17so5535527pla.6
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 09:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LPXLt9kVpe5Fsi5X1PQCacaJ2vWmIlJcfhVyG9efN0o=;
        b=RW9lBaK0fKKAC/862pfH/kb5UyFjW3glVd7xVHcskrr5o9j1oOG5rfYjOQRaCIbDlb
         ilsSbVHf0M43wrnjgX8JdlfXeptyuAFygTdeVW4GnknNawl+8VtP3LC+hApkqzkYrqC/
         GUVFz6T6A+sBRTFYivsnz1bcqd76Ec+6t91fE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LPXLt9kVpe5Fsi5X1PQCacaJ2vWmIlJcfhVyG9efN0o=;
        b=5/rFL8FBnCYYAq2fOsRAgpjUs8ZuvNQYLqGTL83d6YIGIh2Yk8Dvm0W4cXTOZ6NTqC
         HPbHKqutukoq9ocXuaObSLNrcsa+iD8oJka3iFXyBLdUHj/ywSrti2NOidg5+lgIPS1R
         G3gufGO/Vu4IIUlaUVrSt+dNBO66U41l5cU/Rcokvv/7a2r7ZrcCPXIFk2UjXG6rNUWI
         ZeifK48wF7CeqM4ZSOjdYGwOGtVsCV0n+0rjqD7Ca78d8gotA1my0j+fmclwmri4oPrw
         OABw5+4U2UsAZUb6KEkKukPLgO4OsC2BFwMjDqTaCTDcox912GtkhGEojqc6SLAz5EOb
         G3eA==
X-Gm-Message-State: AOAM533iY+H6K6dnaANw/R5/JZ2+VCj2CYFjbgTbated0HQVcOblBdj/
        G188Tr59fyvwp65JB1mExtOq5A==
X-Google-Smtp-Source: ABdhPJxomxONaGPsH9OZEbVxM7EXcFB/LR/hLbxJ1vhR4m7eLeMmROa0gPYiYHYHcqjy9asXQTlzBQ==
X-Received: by 2002:a17:90b:1c86:b0:1ea:4ceb:2788 with SMTP id oo6-20020a17090b1c8600b001ea4ceb2788mr16785406pjb.16.1655138237683;
        Mon, 13 Jun 2022 09:37:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id jc17-20020a17090325d100b0015e8da1f9e8sm5349510plb.77.2022.06.13.09.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 09:37:17 -0700 (PDT)
Date:   Mon, 13 Jun 2022 09:37:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v4 24/26] mm: add arch hook to validate mmap() prot flags
Message-ID: <202206130932.592AAE7@keescook>
References: <20220613144550.3760857-1-ardb@kernel.org>
 <20220613144550.3760857-25-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613144550.3760857-25-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jun 13, 2022 at 04:45:48PM +0200, Ard Biesheuvel wrote:
> Add a hook to permit architectures to perform validation on the prot
> flags passed to mmap(), like arch_validate_prot() does for mprotect().
> This will be used by arm64 to reject PROT_WRITE+PROT_EXEC mappings on
> configurations that run with WXN enabled.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  include/linux/mman.h | 15 +++++++++++++++
>  mm/mmap.c            |  3 +++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/include/linux/mman.h b/include/linux/mman.h
> index 58b3abd457a3..53ac72310ce0 100644
> --- a/include/linux/mman.h
> +++ b/include/linux/mman.h
> @@ -120,6 +120,21 @@ static inline bool arch_validate_flags(unsigned long flags)
>  #define arch_validate_flags arch_validate_flags
>  #endif
>  
> +#ifndef arch_validate_mmap_prot
> +/*
> + * This is called from mmap(), which ignores unknown prot bits so the default
> + * is to accept anything.
> + *
> + * Returns true if the prot flags are valid
> + */
> +static inline bool arch_validate_mmap_prot(unsigned long prot,
> +					   unsigned long addr)
> +{
> +	return true;
> +}
> +#define arch_validate_mmap_prot arch_validate_mmap_prot
> +#endif
> +
>  /*
>   * Optimisation macro.  It is equivalent to:
>   *      (x & bit1) ? bit2 : 0
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 61e6135c54ef..4a585879937d 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1437,6 +1437,9 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  		if (!(file && path_noexec(&file->f_path)))
>  			prot |= PROT_EXEC;
>  
> +	if (!arch_validate_mmap_prot(prot, addr))
> +		return -EACCES;

I assume yes, but just to be clear, the existing userspace programs that
can switch modes are checking for EACCES? (Or are just just checking for
failure generally?) It looks like, for example, SELinux returns EACCES
too, so this looks correct. (Looking at the mmap man page, it seems the
ship has sailed for this to be EPERM, which looks more correct to me,
but so be it.)

> +
>  	/* force arch specific MAP_FIXED handling in get_unmapped_area */
>  	if (flags & MAP_FIXED_NOREPLACE)
>  		flags |= MAP_FIXED;
> -- 
> 2.30.2
> 

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
