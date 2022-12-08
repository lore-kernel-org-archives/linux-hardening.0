Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BCFC63703
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Dec 2022 16:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiLHQc0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Dec 2022 11:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiLHQcY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Dec 2022 11:32:24 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BA0271E
        for <linux-hardening@vger.kernel.org>; Thu,  8 Dec 2022 08:32:21 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id t18so1683255pfq.13
        for <linux-hardening@vger.kernel.org>; Thu, 08 Dec 2022 08:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=57Ddcfru2LvUQsSfd0q8Xr1c5dKIodEjUxeNkx/mxX0=;
        b=KGXTAc0X86Oo6sdnfCoLnqgKb5/YNtxmCXPjMyJjXMlnm2HJcButMWPYzawWdOta/N
         cSs0YGuCxdtkeovYlpHj3CV+CQEvO/hbxrQx1u6l8gMF21cfbWsfXnVMQQi/LwiZ+Pau
         DELp5r470Ahb/RW/lEDJ84wtTsNeWiUz+jKmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57Ddcfru2LvUQsSfd0q8Xr1c5dKIodEjUxeNkx/mxX0=;
        b=xEduyADZTvA0hIyz9DkfU6g2zPhBxqdwIzVEmreG8AhJMm4DmVfqif63oHmM1pvTVc
         qO1M47XvGD/DMuhGUTTG6ptlBEh+3013j/U8LSofb7Rnyg6b5GPt32VeHYKPFtKi4eQt
         bFHNO3Zfqn8yt090x+EcOS7XuYaq7XrXwUo9jA22cWDYLVb6lQkKR2DQNlaqNgHR2j/g
         V9QjtLdYca44eoqpoHGzsaaqWGUmIYGA4oej11ClWNyqmriYdvtYG9dEzYBlI6LXV9UL
         7FI4xlXH36P04exHOyocADMYiZO5b7ZxswkcnHSRbR1d5DkzdX1jLE6P3dPcZl9yDTqQ
         L6QQ==
X-Gm-Message-State: ANoB5pnihhl7h7aoX1J6MvFMFcLkbRMMGWei1hVGrUvvys+JIhcwM4oM
        Y+7gA6LwauSaN1e3/Kq5lkEGaQ==
X-Google-Smtp-Source: AA0mqf4wxnc/rqiR7541frAh3SkYVsc69VXIbiMFJy68m5JROZIV5OyvOZr8KZI5wI6EPDwLWc4BDQ==
X-Received: by 2002:a62:3882:0:b0:56b:9ce2:891f with SMTP id f124-20020a623882000000b0056b9ce2891fmr83105047pfa.43.1670517140886;
        Thu, 08 Dec 2022 08:32:20 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c20600b00186ff402508sm16742741pll.281.2022.12.08.08.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:32:20 -0800 (PST)
Date:   Thu, 8 Dec 2022 08:32:19 -0800
From:   Kees Cook <keescook@chromium.org>
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6 6/6] mm/memfd: security hook for memfd_create
Message-ID: <202212080831.9010D8A@keescook>
References: <20221207154939.2532830-1-jeffxu@google.com>
 <20221207154939.2532830-7-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207154939.2532830-7-jeffxu@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Dec 07, 2022 at 03:49:39PM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@google.com>
> 
> The new security_memfd_create allows lsm to check flags of
> memfd_create.
> 
> The security by default system (such as chromeos) can use this
> to implement system wide lsm to allow only non-executable memfd
> being created.
> 
> Signed-off-by: Jeff Xu <jeffxu@google.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/lsm_hooks.h     |  4 ++++
>  include/linux/security.h      |  6 ++++++
>  mm/memfd.c                    |  5 +++++
>  security/security.c           | 13 +++++++++++++
>  5 files changed, 29 insertions(+)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index ec119da1d89b..fd40840927c8 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -164,6 +164,7 @@ LSM_HOOK(int, 0, file_alloc_security, struct file *file)
>  LSM_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)
>  LSM_HOOK(int, 0, file_ioctl, struct file *file, unsigned int cmd,
>  	 unsigned long arg)
> +LSM_HOOK(int, 0, memfd_create, char *name, unsigned int flags)
>  LSM_HOOK(int, 0, mmap_addr, unsigned long addr)
>  LSM_HOOK(int, 0, mmap_file, struct file *file, unsigned long reqprot,
>  	 unsigned long prot, unsigned long flags)
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 4ec80b96c22e..5a18a6552278 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -543,6 +543,10 @@
>   *	simple integer value.  When @arg represents a user space pointer, it
>   *	should never be used by the security module.
>   *	Return 0 if permission is granted.
> + * @memfd_create:
> + *	@name is the name of memfd file.
> + *	@flags is the flags used in memfd_create.
> + *	Return 0 if permission is granted.
>   * @mmap_addr :
>   *	Check permissions for a mmap operation at @addr.
>   *	@addr contains virtual address that will be used for the operation.
> diff --git a/include/linux/security.h b/include/linux/security.h
> index ca1b7109c0db..5b87a780822a 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -384,6 +384,7 @@ int security_file_permission(struct file *file, int mask);
>  int security_file_alloc(struct file *file);
>  void security_file_free(struct file *file);
>  int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
> +int security_memfd_create(char *name, unsigned int flags);
>  int security_mmap_file(struct file *file, unsigned long prot,
>  			unsigned long flags);
>  int security_mmap_addr(unsigned long addr);
> @@ -963,6 +964,11 @@ static inline int security_file_ioctl(struct file *file, unsigned int cmd,
>  	return 0;
>  }
>  
> +static inline int security_memfd_create(char *name, unsigned int flags)
> +{
> +	return 0;
> +}
> +
>  static inline int security_mmap_file(struct file *file, unsigned long prot,
>  				     unsigned long flags)
>  {
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 92f0a5765f7c..f04ed5f0474f 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -356,6 +356,11 @@ SYSCALL_DEFINE2(memfd_create,
>  		goto err_name;
>  	}
>  
> +	/* security hook for memfd_create */
> +	error = security_memfd_create(name, flags);
> +	if (error)
> +		return error;
> +
>  	if (flags & MFD_HUGETLB) {
>  		file = hugetlb_file_setup(name, 0, VM_NORESERVE,
>  					HUGETLB_ANONHUGE_INODE,
> diff --git a/security/security.c b/security/security.c
> index 79d82cb6e469..5c018e080923 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1010,6 +1010,19 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
>  }
>  EXPORT_SYMBOL(security_sb_clone_mnt_opts);
>  
> +int security_add_mnt_opt(const char *option, const char *val, int len,
> +			 void **mnt_opts)
> +{
> +	return call_int_hook(sb_add_mnt_opt, -EINVAL,
> +					option, val, len, mnt_opts);
> +}
> +EXPORT_SYMBOL(security_add_mnt_opt);

I think security_add_mnt_opt() isn't supposed to be in here. :)

> +
> +int security_memfd_create(char *name, unsigned int flags)
> +{
> +	return call_int_hook(memfd_create, 0, name, flags);
> +}
> +
>  int security_move_mount(const struct path *from_path, const struct path *to_path)
>  {
>  	return call_int_hook(move_mount, 0, from_path, to_path);
> -- 
> 2.39.0.rc0.267.gcb52ba06e7-goog
> 

Otherwise looks good.

Thanks!

-Kees

-- 
Kees Cook
