Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C74EDE989
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 03:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjIODK0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 14 Sep 2023 23:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjIODKZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 14 Sep 2023 23:10:25 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE2E270A
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 20:10:21 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c0c6d4d650so15165655ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 20:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694747420; x=1695352220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s66uVsXieXZEwrz2tGtxEkm4KD1eEh+8pBHuZBZ6AXU=;
        b=P2w+CZR3beoD5p/U38+1uhux+DgXnGntEWHLtjl+CMCIwWyBqnc7aYA6/SfpkZvWBG
         jal7TD6wp+GWlM/LpHSoGye9x+OvljaXjBFPglv+yybcQQovvexv/4OTYKcKOJkim9Lt
         kyZdd/M5d5G3Zxir4hZLiu4c9ur80vlctnZ+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694747420; x=1695352220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s66uVsXieXZEwrz2tGtxEkm4KD1eEh+8pBHuZBZ6AXU=;
        b=NFeCZaDrXWdfo7O7NbHMgdEKFEiHiI4VddXianK8gldWjXYbocxUWtq5zclV9ezLjz
         arOEew4lQtI0uTeWXaTj1czHjpDeNMOYgp7eUGvJRZYN2jrF7FLOObjinAtSnNzWcayF
         6gBkEEIZLrBEO4MERq8yi6v1Mv36yxrXDKcq3nrtOdiUGElckWabsfSwCPXcwtoj75ei
         5EKV3ifhSiQZNKQXynxhyohu7My6Q3xuCpf3PU7YOC5ojLYVTh/mNNDtcN/ommlyzpzm
         rCqZ5s18quP+jEbVIxho27WuY5KB5QcPSfBW9OHWSqsELC6dqjHFuhJemMfeGjxVoB1X
         Q80Q==
X-Gm-Message-State: AOJu0Yynm0HPxiw1LZib50hrxGAExBWQG9ctuOJ5NY2rT5yHpQo3UMDR
        it7Pk5zJi3+SXvKMpchmslhN5A==
X-Google-Smtp-Source: AGHT+IHiPr6yjry1eOi32qemWdUt8KSs5Y4FRrVUY+L6LPMW/8uikqG4J6/IPV1vKIwXV6zuvnYF/Q==
X-Received: by 2002:a17:902:76c5:b0:1bb:c06e:647a with SMTP id j5-20020a17090276c500b001bbc06e647amr443590plt.53.1694747420577;
        Thu, 14 Sep 2023 20:10:20 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090322c700b001c0a414695dsm2285725plg.62.2023.09.14.20.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 20:10:20 -0700 (PDT)
Date:   Thu, 14 Sep 2023 20:10:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] xen/efi: refactor deprecated strncpy
Message-ID: <202309142009.DD5AE193@keescook>
References: <20230911-strncpy-arch-x86-xen-efi-c-v1-1-96ab2bba2feb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911-strncpy-arch-x86-xen-efi-c-v1-1-96ab2bba2feb@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 11, 2023 at 06:59:31PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> `efi_loader_signature` has space for 4 bytes. We are copying "Xen" (3 bytes)
> plus a NUL-byte which makes 4 total bytes. With that being said, there is
> currently not a bug with the current `strncpy()` implementation in terms of
> buffer overreads but we should favor a more robust string interface
> either way.

Yeah, this will work. Since this is a u32 destination, I do wonder if
strtomem_pad() would be better since we're not really writing a string?
But since this is all hard-coded, it doesn't matter. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> A suitable replacement is `strscpy` [2] due to the fact that it guarantees
> NUL-termination on the destination buffer while being functionally the
> same in this case.
> 
> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested
> ---
>  arch/x86/xen/efi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/xen/efi.c b/arch/x86/xen/efi.c
> index 863d0d6b3edc..7250d0e0e1a9 100644
> --- a/arch/x86/xen/efi.c
> +++ b/arch/x86/xen/efi.c
> @@ -138,7 +138,7 @@ void __init xen_efi_init(struct boot_params *boot_params)
>  	if (efi_systab_xen == NULL)
>  		return;
>  
> -	strncpy((char *)&boot_params->efi_info.efi_loader_signature, "Xen",
> +	strscpy((char *)&boot_params->efi_info.efi_loader_signature, "Xen",
>  			sizeof(boot_params->efi_info.efi_loader_signature));
>  	boot_params->efi_info.efi_systab = (__u32)__pa(efi_systab_xen);
>  	boot_params->efi_info.efi_systab_hi = (__u32)(__pa(efi_systab_xen) >> 32);
> 
> ---
> base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> change-id: 20230911-strncpy-arch-x86-xen-efi-c-14292f5a79ee
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
