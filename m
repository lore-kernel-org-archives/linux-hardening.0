Return-Path: <SRS0=DAdQ=DP=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FDAC433DF
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 18:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 417EB2076E
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 18:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IRLUvU6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgJHSYi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Oct 2020 14:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbgJHSYi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Oct 2020 14:24:38 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C38C0613D2
        for <linux-hardening@vger.kernel.org>; Thu,  8 Oct 2020 11:24:38 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dt13so9474413ejb.12
        for <linux-hardening@vger.kernel.org>; Thu, 08 Oct 2020 11:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Borjchw/TSeW3kJDI9UKxpuNWct0CBHNGPaPSuEeWc0=;
        b=IRLUvU6KvCA9S8YqNRovWPVwdRX38O6TQeYHK3U+O1R156cyJO7W0l5DeI6ZC6WDUj
         8bAcQcTGuQ80kphRc7K57wpCXH02eMHVeEat+TbOJfRp2LGKVnvmlu7XCq/8P8Khf7LI
         fJp/AB1ZS/Cdp9N99hecl6fZ5uRXvRFDepWAUt/clMIL5Cl2cJPK8QdHb/v7jbFDnO/U
         JwoRHe6FM8obRsuCAyuye38uRj58FOZqbWKkQF8WMSCds5U7Ao9OAMAKC/5RUN012jmW
         3yRJKx6UGAWBwIHpmBzHrBr1BAHD+I2YkdymeW0lrwPbzXjcY7dv0vNOyIqSBCl4i7og
         Rekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Borjchw/TSeW3kJDI9UKxpuNWct0CBHNGPaPSuEeWc0=;
        b=Uyby9MW97rPnsYgcTEtES8DqqfdRikyKa77UapAxpIhmFgfaSFdLRpPF6mlZPC3ala
         rVYLvOOQQ3NKYh+Hi/SPz3UjNz+w8m9QPeGd0jIHIGGsQNE7wbCaKhcb6o68yd10hMb3
         /PZQlIt15wl6SroQ4/dd/Q1cRAYYrohGX/Xmd52BOhKbXQz6UyvfXaiEBiODXPGlEEdp
         aw4fco9lhk+jeip6dPAD02pByfgZ+J7OfoiFoXIgqC8za8/ow6QnCyZDiIi1pXYSqlkh
         QF72KjtRJ0/kO8rATHb5p9nwKtIaya0w3/HNSOvrO2ATPOZlLi9gh6CyW2iW0VzL6Q+N
         Gh9Q==
X-Gm-Message-State: AOAM530uemiRpSzc3VT4Y5uOUQiZAcXf1PfO5bfUu0kj21RkuT2SOzkp
        NLQnGb7e8vVW2wHqO6M6gX1sNHqcinotdGwRShK9IQ==
X-Google-Smtp-Source: ABdhPJzL2QX6JHv/YMDr/k6dMfOuCOooSIAnhsR97uRydnSAr6eU9VWguUWdd7kXmEHnUTejzMEO8wZSq7maWqIl8UQ=
X-Received: by 2002:a17:906:fcae:: with SMTP id qw14mr10420740ejb.537.1602181476510;
 Thu, 08 Oct 2020 11:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201008165408.38228-1-toiwoton@gmail.com> <CAG48ez1OU9PFQ06mf4L59SEmi6Vwxnao8RuVXH=dCiyMhqVwYA@mail.gmail.com>
 <3413d0c8-17c7-fbae-e5fa-74a918e61239@gmail.com>
In-Reply-To: <3413d0c8-17c7-fbae-e5fa-74a918e61239@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 8 Oct 2020 20:24:10 +0200
Message-ID: <CAG48ez2bDCEKxUdFUQ2MAkJgKi1zN+h46ypC2zNr0a1fp-FqWQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] mm: Optional full ASLR for mmap() and mremap()
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     linux-hardening@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 8, 2020 at 8:10 PM Topi Miettinen <toiwoton@gmail.com> wrote:
> On 8.10.2020 20.13, Jann Horn wrote:
> > On Thu, Oct 8, 2020 at 6:54 PM Topi Miettinen <toiwoton@gmail.com> wrote:
> >> Writing a new value of 3 to /proc/sys/kernel/randomize_va_space
> >> enables full randomization of memory mappings created with mmap(NULL,
> >> ...). With 2, the base of the VMA used for such mappings is random,
> >> but the mappings are created in predictable places within the VMA and
> >> in sequential order. With 3, new VMAs are created to fully randomize
> >> the mappings. Also mremap(..., MREMAP_MAYMOVE) will move the mappings
> >> even if not necessary.
> > [...]
> >> +       if ((flags & MREMAP_MAYMOVE) && randomize_va_space >= 3) {
> >> +               /*
> >> +                * Caller is happy with a different address, so let's
> >> +                * move even if not necessary!
> >> +                */
> >> +               new_addr = arch_mmap_rnd();
> >> +
> >> +               ret = mremap_to(addr, old_len, new_addr, new_len,
> >> +                               &locked, flags, &uf, &uf_unmap_early,
> >> +                               &uf_unmap);
> >> +               goto out;
> >> +       }
> >
> > You just pick a random number as the address, and try to place the
> > mapping there? Won't this fail if e.g. the old address range overlaps
> > with the new one, causing mremap_to() to bail out at "if (addr +
> > old_len > new_addr && new_addr + new_len > addr)"?
>
> Thanks for the review. I think overlap would be OK in this case and the
> check should be skipped.

No, mremap() can't deal with overlap (and trying to add such support
would make mremap() unnecessarily complicated).
