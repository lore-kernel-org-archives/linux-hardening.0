Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3976CC4332F
	for <linux-hardening@archiver.kernel.org>; Fri, 11 Nov 2022 20:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbiKKUOR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 11 Nov 2022 15:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbiKKUOQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 11 Nov 2022 15:14:16 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25172E9ED
        for <linux-hardening@vger.kernel.org>; Fri, 11 Nov 2022 12:14:15 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id h193so5186808pgc.10
        for <linux-hardening@vger.kernel.org>; Fri, 11 Nov 2022 12:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CzfuirqUexa4OrUP6aM1ldAHfjduol2fhAGQPIMhaNg=;
        b=eiMN91hnPXZQzawWYNQtt2JbgJX4zONo3XXA2vHKrwUDAZM35OEnfRYlvN5dnWnHK3
         pjLnnizKKu4ocjX9ODiE3DPWno1mHG1fttmdmWfyUh8rGHcRgmCdXnDpnak17egxCSpg
         lGr2Lz2VD1IMD9rcdGZMZuwgOUP314MaWeyXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzfuirqUexa4OrUP6aM1ldAHfjduol2fhAGQPIMhaNg=;
        b=0b4MnxJvykAl/+XW7gdc9EappSE42HLG5X/SMw8e66bubjmsXeyr/T9K2N0NdscXaR
         nVGiOUoQJl52KAn1Hrk2WPQiyFv71+AO+QlTqz568BaSGUEqs2MPQV/iGX7+dEdnqDH2
         uirC+bUeIZ60Pkxp5xPKaAgPYUy7uGy0oRSrhjK3sZSBI/FdsYgwqRLNPl6eICU9Igrb
         OA1yUfYyKRTa1cu+lIQ+6gTzvxWzuXr/HPOXaCLBLWXnxA8u72lkhu2QA0Us+ZZR+xj9
         IV6zrczaFwLSEhkEbcFOA0OtBHActA4QVpwdu//Wf+xPUZ2ZHMkuOuIolc3z9U7E+GvV
         1jDg==
X-Gm-Message-State: ANoB5pkOfIlm88PugzTTLusldG4ZyiKgDh3+QkolFAa4RTmDeb3H+BZz
        AfTwS4WYwD13I5q33oyTLJ9V3A==
X-Google-Smtp-Source: AA0mqf7dRnhsd5f6m0AWWkQi2sWwEKci8En1oXPzGRb7yjL8j7GgD9if6YefVSBseGMxJjBYOXq8yQ==
X-Received: by 2002:aa7:99c5:0:b0:562:3add:37e1 with SMTP id v5-20020aa799c5000000b005623add37e1mr4169347pfi.80.1668197600735;
        Fri, 11 Nov 2022 12:13:20 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c188-20020a624ec5000000b0056be7ac5261sm1951559pfb.163.2022.11.11.12.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 12:13:20 -0800 (PST)
Date:   Fri, 11 Nov 2022 12:13:19 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Fangrui Song <maskray@google.com>
Cc:     Pedro Falcato <pedro.falcato@gmail.com>,
        Rich Felker <dalias@libc.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>, sam@gentoo.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] binfmt_elf: Allow .bss in any interp PT_LOAD
Message-ID: <202211111211.93ED8B4B@keescook>
References: <20221111061315.gonna.703-kees@kernel.org>
 <20221111074234.xm5a6ota7ppdsto5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111074234.xm5a6ota7ppdsto5@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Nov 10, 2022 at 11:42:34PM -0800, Fangrui Song wrote:
> (+ sam@gentoo.org from Pedro Falcato's patch)
> 
> On 2022-11-10, Kees Cook wrote:
> > Traditionally, only the final PT_LOAD for load_elf_interp() supported
> > having p_memsz > p_filesz. Recently, lld's construction of musl's
> > libc.so on PowerPC64 started having two PT_LOAD program headers with
> > p_memsz > p_filesz.
> > 
> > As the least invasive change possible, check for p_memsz > p_filesz for
> > each PT_LOAD in load_elf_interp.
> > 
> > Reported-by: Rich Felker <dalias@libc.org>
> > Link: https://maskray.me/blog/2022-11-05-lld-musl-powerpc64
> > Cc: Pedro Falcato <pedro.falcato@gmail.com>
> > Cc: Fangrui Song <maskray@google.com>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Eric Biederman <ebiederm@xmission.com>
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > v2: I realized we need to retain the final padding call.
> > v1: https://lore.kernel.org/linux-hardening/20221111055747.never.202-kees@kernel.org/
> > ---
> > fs/binfmt_elf.c | 18 ++++++++++++++----
> > 1 file changed, 14 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > index 528e2ac8931f..0a24bbbef1d6 100644
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -673,15 +673,25 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
> > 				last_bss = k;
> > 				bss_prot = elf_prot;
> > 			}
> > +
> > +			/*
> > +			 * Clear any p_memsz > p_filesz area up to the end
> > +			 * of the page to wipe anything left over from the
> > +			 * loaded file contents.
> > +			 */
> > +			if (last_bss > elf_bss && padzero(elf_bss))
> 
> Missing {
> 
> But after fixing this, I get a musl ld.so error.
> 
> > +				error = -EFAULT;
> > +				goto out;
> > +			}
> > 		}
> > 	}
> > 
> > 	/*
> > -	 * Now fill out the bss section: first pad the last page from
> > -	 * the file up to the page boundary, and zero it from elf_bss
> > -	 * up to the end of the page.
> > +	 * Finally, pad the last page from the file up to the page boundary,
> > +	 * and zero it from elf_bss up to the end of the page, if this did
> > +	 * not already happen with the last PT_LOAD.
> > 	 */
> > -	if (padzero(elf_bss)) {
> > +	if (last_bss == elf_bss && padzero(elf_bss)) {
> > 		error = -EFAULT;
> > 		goto out;
> > 	}
> > -- 
> > 2.34.1
> > 
> 
> I added a new section to https://maskray.me/blog/2022-11-05-lld-musl-powerpc64
> Copying here:
> 
> To test that the kernel ELF loader can handle more RW `PT_LOAD` program headers, we can create an executable with more RW `PT_LOAD` program headers with `p_filesz < p_memsz`.
> We can place a read-only section after `.bss` followed by a `SHT_NOBITS` `SHF_ALLOC|SHF_WRITE` section. The read-only section will form a read-only `PT_LOAD` while the RW section will form a RW `PT_LOAD`.
> 
> ```text
> #--- a.c
> #include <assert.h>
> #include <stdio.h>
> 
> extern const char toc[];
> char nobits0[0] __attribute__((section(".nobits0")));
> char nobits1[0] __attribute__((section(".nobits1")));
> 
> int main(void) {
>   assert(toc[4096-1] == 0);
>   for (int i = 0; i < 1024; i++)
>     assert(nobits0[i] == 0);
>   nobits0[0] = nobits0[1024-1] = 1;
>   for (int i = 0; i < 4096; i++)
>     assert(nobits1[i] == 0);
>   nobits1[0] = nobits1[4096-1] = 1;
> 
>   puts("hello");
> }
> 
> #--- toc.s
> .section .toc,"aw",@nobits
> .globl toc
> toc:
> .space 4096
> 
> .section .ro0,"a"; .byte 255
> .section .nobits0,"aw",@nobits; .space 1024
> .section .ro1,"a"; .byte 255
> .section .nobits1,"aw",@nobits; .space 4096
> 
> #--- a.lds
> SECTIONS { .ro0 : {} .nobits0 : {} .ro1 : {} .nobits1 : {} } INSERT AFTER .bss;
> ```
> 
> ```sh
> split-file a.txt a
> path/to/musl-gcc -Wl,--dynamic-linker=/lib/libc.so a/a.c a/a.lds -o toy
> ```
> 
> split-file is a utility in llvm-project.

Where is a.txt? Also, it'd be nice to have this without needing the
musl-gcc.

-- 
Kees Cook
