Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA101C433F5
	for <linux-hardening@archiver.kernel.org>; Wed,  5 Oct 2022 21:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiJEVlG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 5 Oct 2022 17:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiJEVk6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 5 Oct 2022 17:40:58 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA5382751
        for <linux-hardening@vger.kernel.org>; Wed,  5 Oct 2022 14:40:54 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n7so16656629plp.1
        for <linux-hardening@vger.kernel.org>; Wed, 05 Oct 2022 14:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=MItuJ5U/2RAuamrpV6dJrOpoREvF5mLnZAeERt7QUpU=;
        b=IQUOC6y4QS/1LJfIO+vG9o/CPBWD5e54SmOeTeyrJqB6bUYuF0izwbTdMi7bA1J1Fh
         etQiUuUCnWoLZd2GRHYSN3n0ZVwtGhvz8IM8aFScPktSnV+HZdTW0vKVHQzxhNZrXgYt
         2c+lRPRD9wMtrAxCwbIS29NXosETEHd/8d+YI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MItuJ5U/2RAuamrpV6dJrOpoREvF5mLnZAeERt7QUpU=;
        b=lZR4R6Ilu+Mvma1dHRkqGrKNhbMjhe6zOG7KYi7NnHCK8c2N8H7r1yb4XFPyeQ+BKh
         X+mW9+U4rsO+a8zN7vxIPLgCsKumFVH3XvUscW5FUAlOx708j3wlZguiUSlqjaCbtxD8
         DOcrilKYlAg7k9gH5mOaasSfBd7W1SOgNMSvz6uQrprYq75K+6Sq31RS8s1sJ21GcCkc
         xiIvz0qnOVpVB67xIVyTKJ6jlQt3r1w8IWBmeubyN9bB/uCdm9gFe6aDeavA9MwIrRfo
         SzgZRx42yfMlePNC6SHf+4RQKRoC6rWB0rCOS96e/2YCj8O0SY3EhOzNRWqzL1EnSsV7
         Q11Q==
X-Gm-Message-State: ACrzQf3VAmS5I73OKVjNTkfRNpwAgSN0ITe6dg/CMp1EC9WUKkcL5QF3
        epK7U8uv8PUx9obQF1v0C5Ga+NcjRY4FEg==
X-Google-Smtp-Source: AMsMyM7cSL26dSE3CXWoQ0qiFwm2O0CzjBvcZF7agSSDbSM5ddrspprFf7/dzHuJM87kAkSbDlUzxQ==
X-Received: by 2002:a17:90b:4b11:b0:202:998b:71b1 with SMTP id lx17-20020a17090b4b1100b00202998b71b1mr1809685pjb.208.1665006053997;
        Wed, 05 Oct 2022 14:40:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e29-20020a63501d000000b004582e25a595sm220201pgb.41.2022.10.05.14.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 14:40:53 -0700 (PDT)
Date:   Wed, 5 Oct 2022 14:40:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] mm/pgtable: Fix multiple -Wstringop-overflow
 warnings
Message-ID: <202210051107.720F1F835@keescook>
References: <Yytb67xvrnctxnEe@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yytb67xvrnctxnEe@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Sep 21, 2022 at 01:46:03PM -0500, Gustavo A. R. Silva wrote:
> The actual size of the following arrays at run-time depends on
> CONFIG_X86_PAE.
> 
> 427         pmd_t *u_pmds[MAX_PREALLOCATED_USER_PMDS];
> 428         pmd_t *pmds[MAX_PREALLOCATED_PMDS];
> 
> If CONFIG_X86_PAE is not enabled, their final size will be zero. In that
> case, the compiler complains about trying to access objects of size zero
> when calling functions where these objects are passed as arguments.

The main point is that a zero-length array isn't considered to have legal
storage by C -- strictly speaking, a compiler isn't wrong to complain
about this (and it has in the past too, for this code):

static void pgd_prepopulate_pmd(struct mm_struct *mm, pgd_t *pgd, pmd_t *pmds[])
{
        p4d_t *p4d;
        pud_t *pud;
        int i;

        if (PREALLOCATED_PMDS == 0) /* Work around gcc-3.4.x bug */
                return;
...

But gcc has gotten smart enough to say "you can't pass this as an array
because it doesn't actually exist". No amount of inlining, etc, helps
because it's strictly looking at the function arguments and the local
storage declaration.

Note that this is basically one of the last warnings generated by
-Wstringop-overflow -- many of the other warnings that were fixed as
part of getting this option enabled have been real bugs. We want this
warning enabled, even if it's a bit more strict than some code is happy
about. :)

> Fix this by sanity-checking the size of those arrays just before the
> function calls. Also, the following warnings are fixed by these changes
> when building with GCC-11 and -Wstringop-overflow enabled:

And with GCC-12 too.

> arch/x86/mm/pgtable.c:437:13: warning: ‘preallocate_pmds.constprop’ accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
> arch/x86/mm/pgtable.c:440:13: warning: ‘preallocate_pmds.constprop’ accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
> arch/x86/mm/pgtable.c:462:9: warning: ‘free_pmds.constprop’ accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
> arch/x86/mm/pgtable.c:455:9: warning: ‘pgd_prepopulate_user_pmd’ accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
> arch/x86/mm/pgtable.c:464:9: warning: ‘free_pmds.constprop’ accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
> 
> This helps with the ongoing efforts to globally enable
> -Wstringop-overflow.
> 
> Link: https://github.com/KSPP/linux/issues/203
> Link: https://github.com/KSPP/linux/issues/181
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

BTW, this should be considered "v3", and include links to the history:

v2: https://lore.kernel.org/lkml/20220509194541.GA91598@embeddedor/
v1: https://lore.kernel.org/lkml/20220401005834.GA182932@embeddedor/

> ---
>  arch/x86/mm/pgtable.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index 8525f2876fb4..5116df6a308c 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -434,10 +434,12 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
>  
>  	mm->pgd = pgd;
>  
> -	if (preallocate_pmds(mm, pmds, PREALLOCATED_PMDS) != 0)
> +	if (sizeof(pmds) != 0 &&
> +			preallocate_pmds(mm, pmds, PREALLOCATED_PMDS) != 0)
>  		goto out_free_pgd;
>  
> -	if (preallocate_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS) != 0)
> +	if (sizeof(u_pmds) != 0 &&
> +			preallocate_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS) != 0)
>  		goto out_free_pmds;

The alternative to this is to make the originally suggested change
from v1: change the pmds argument from an array pointer to a pointer
pointer. That situation is considered "legal" for C in the sense that
it does not have a way to reason about the storage. i.e.:

-static void pgd_prepopulate_pmd(struct mm_struct *mm, pgd_t *pgd, pmd_t *pmds[])
+static void pgd_prepopulate_pmd(struct mm_struct *mm, pgd_t *pgd, pmd_t **pmds)

With the above change, there's no difference in binary output, and the
compiler warning is silenced.

However, with this email's patch, the compiler can actually figure out
that it isn't using the code at all, and it gets dropped:

   text    data     bss     dec     hex filename
   8218     718      32    8968    2308 arch/x86/mm/pgtable.o.before
   7765     694      32    8491    212b arch/x86/mm/pgtable.o.after

Given that result (fixing a warning and reducing image size), this look
like a distinct win.

Reviewed-by: Kees Cook <keescook@chromium.org>

Note, we can add this change:

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index a932d7712d85..b311e4aa42fc 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -299,9 +299,6 @@ static void pgd_prepopulate_pmd(struct mm_struct *mm, pgd_t *pgd, pmd_t *pmds[])
 	pud_t *pud;
 	int i;
 
-	if (PREALLOCATED_PMDS == 0) /* Work around gcc-3.4.x bug */
-		return;
-
 	p4d = p4d_offset(pgd, 0);
 	pud = pud_offset(p4d, 0);
 

Which would get us to even more lines removed:

  1 file changed, 13 insertions(+), 9 deletions(-)

:)

-Kees

-- 
Kees Cook
