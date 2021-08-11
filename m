Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C8EC4338F
	for <linux-hardening@archiver.kernel.org>; Wed, 11 Aug 2021 18:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1EC46101D
	for <linux-hardening@archiver.kernel.org>; Wed, 11 Aug 2021 18:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhHKSIB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 11 Aug 2021 14:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhHKSIA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 11 Aug 2021 14:08:00 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576EEC061765
        for <linux-hardening@vger.kernel.org>; Wed, 11 Aug 2021 11:07:36 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id t3so3705463plg.9
        for <linux-hardening@vger.kernel.org>; Wed, 11 Aug 2021 11:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=biCOyc5zjwp8UgiAEw5DCtCzrssqKWeZMERlP3hCQmo=;
        b=cnGuwp/rcSovo4qSL9gUyfcuHKJUBGgOE17Izgv7XOS9yYhPe57PE3HhW+bn/8sJg9
         2PIFXW05HL1i5Hz7hkSWuC0g1JixZFMD2oSzgmxzjVJRHvimLrai+mryeZipj2mjhzJ/
         4Ey9FHG6Un0Vvb8LqeEW2BM06r7oqcsHJ5ENE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=biCOyc5zjwp8UgiAEw5DCtCzrssqKWeZMERlP3hCQmo=;
        b=E8ALWEvfoi5ji0PJfXtcNvkUpbtHjTm9prFpu+wSzfww0zLvgdOBqdBuy+a2UV1zG+
         AApDM+w1MQnRVzeBWG55F2P/N2iUmDeugMd2gfMOi+AdrmnjTk1jneZoHX0Ma6w5KTGt
         fuDsTZriw20gWAc9h0t58yM5XZY+DPeKvGiCoqRhEBfKrupyH9xg6B7USuK48xMwWxvp
         6bTkSS7gys/vHxXfF+EbFofaGVdqlaC6PnyibmujGMFPYhUW+NQcK/OvleWiElH45sz5
         0EZRwr8D6bsRgBun6s12yr1lCNlhKPhH1Fi+3TchQoCPGytUqTU3bRtHARhE9/QNE4+B
         2BNA==
X-Gm-Message-State: AOAM533e+pIU4gUCvths/ZOJX9pRpbEJpO7PYBum4nmRsWTKX/T/YMNn
        X0UeHarDNeQdOgKSWtmsgwsC4+HVs5rrsA==
X-Google-Smtp-Source: ABdhPJyd21FEcXWllDtq5B+Dci0OC4IztnOEijz0GvcO3tSuSGfCcaDeDOMhAuGFpWKBiCP86naETw==
X-Received: by 2002:a65:40c4:: with SMTP id u4mr972pgp.186.1628705255831;
        Wed, 11 Aug 2021 11:07:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i5sm7407462pjk.47.2021.08.11.11.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 11:07:35 -0700 (PDT)
Date:   Wed, 11 Aug 2021 11:07:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Christopher M. Riedl" <cmr@linux.ibm.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, peterz@infradead.org,
        x86@kernel.org, npiggin@gmail.com, linux-hardening@vger.kernel.org,
        tglx@linutronix.de, dja@axtens.net
Subject: Re: [PATCH v5 2/8] lkdtm/powerpc: Add test to hijack a patch mapping
Message-ID: <202108111057.CC6F897@keescook>
References: <20210713053113.4632-1-cmr@linux.ibm.com>
 <20210713053113.4632-3-cmr@linux.ibm.com>
 <f933e9de-ff3b-aa5a-bb6e-55770d5ab868@csgroup.eu>
 <CDGVLP8OS8N9.13R0RIGJ1WJ8R@oc8246131445.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CDGVLP8OS8N9.13R0RIGJ1WJ8R@oc8246131445.ibm.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 11, 2021 at 12:57:00PM -0500, Christopher M. Riedl wrote:
> On Thu Aug 5, 2021 at 4:13 AM CDT, Christophe Leroy wrote:
> >
> >
> > Le 13/07/2021 à 07:31, Christopher M. Riedl a écrit :
> > > When live patching with STRICT_KERNEL_RWX the CPU doing the patching
> > > must temporarily remap the page(s) containing the patch site with +W
> > > permissions. While this temporary mapping is in use, another CPU could
> > > write to the same mapping and maliciously alter kernel text. Implement a
> > > LKDTM test to attempt to exploit such an opening during code patching.
> > > The test is implemented on powerpc and requires LKDTM built into the
> > > kernel (building LKDTM as a module is insufficient).
> > > 
> > > The LKDTM "hijack" test works as follows:
> > > 
> > >    1. A CPU executes an infinite loop to patch an instruction. This is
> > >       the "patching" CPU.
> > >    2. Another CPU attempts to write to the address of the temporary
> > >       mapping used by the "patching" CPU. This other CPU is the
> > >       "hijacker" CPU. The hijack either fails with a fault/error or
> > >       succeeds, in which case some kernel text is now overwritten.
> > > [...]
> > > +#if (IS_BUILTIN(CONFIG_LKDTM) && defined(CONFIG_STRICT_KERNEL_RWX) && \
> > > +	defined(CONFIG_PPC))
> >
> > I think this test shouldn't be limited to CONFIG_PPC and shouldn't be
> > limited to CONFIG_STRICT_KERNEL_RWX. It should be there all the time.

Agreed: if the machinery exists to provide this defense on even one
arch/config/whatever combo, I'd like LKDTM to test for it. This lets use
compare defenses across different combinations more easily, and means
folks must answer questions like "why doesn't $combination provide
$defense?"

> > Also why limiting it to IS_BUILTIN(CONFIG_LKDTM) ?
> 
> The test needs read_cpu_patching_addr() which definitely cannot be
> exposed outside of the kernel (ie. builtin).

FWIW, I'm okay with this. There isn't a solution that feels entirely
"right", so either a build-time requirement like this, or using an
exception for modules like this:

arch/x86/kernel/cpu/common.c:#if IS_MODULE(CONFIG_LKDTM)
arch/x86/kernel/cpu/common.c-EXPORT_SYMBOL_GPL(native_write_cr4);
arch/x86/kernel/cpu/common.c-#endif

I think neither is great. Another idea is maybe using a name-spaced
export, like:

EXPORT_SYMBOL_NS_GPL(native_write_cr4, LKDTM);

But that still means it gets exposed to malicious discovery, so probably
not.

I suspect the best is to just do the BUILTIN check, since building LKDTM
as a module on a _production_ kernel is rare if it exists at all. The
only downside is needing to completely reboot to perform updated tests,
but then, I frequently find myself breaking the kernel badly on bad
tests, so I have to reboot anyway. ;)

-Kees

-- 
Kees Cook
