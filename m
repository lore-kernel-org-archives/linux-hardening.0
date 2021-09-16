Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7CEC433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 16 Sep 2021 00:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91938610A6
	for <linux-hardening@archiver.kernel.org>; Thu, 16 Sep 2021 00:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhIPAmT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 15 Sep 2021 20:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbhIPAmT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 15 Sep 2021 20:42:19 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C3CC061574
        for <linux-hardening@vger.kernel.org>; Wed, 15 Sep 2021 17:40:59 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4H8ytd6T7YzQjym;
        Thu, 16 Sep 2021 02:40:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
Cc:     "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>,
        <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v6 4/4] powerpc/64s: Initialize and use a temporary mm
 for patching on Radix
From:   "Christopher M. Riedl" <cmr@bluescreens.de>
To:     "Jordan Niethe" <jniethe5@gmail.com>
Date:   Wed, 15 Sep 2021 19:45:24 -0500
Message-Id: <CEAW7GNXW96H.18ANPMC01JA2C@wrwlf0000>
In-Reply-To: <CACzsE9qr6QK_Xm6yVXT061sxR9SXaeFx5fkjiNAXFBFr6WDQOw@mail.gmail.com>
X-Rspamd-Queue-Id: 0FFAF1813
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue Sep 14, 2021 at 11:24 PM CDT, Jordan Niethe wrote:
> On Sat, Sep 11, 2021 at 12:39 PM Christopher M. Riedl
> <cmr@bluescreens.de> wrote:
> > ... 
> > +/*
> > + * This can be called for kernel text or a module.
> > + */
> > +static int map_patch_mm(const void *addr, struct patch_mapping *patch_mapping)
> > +{
> > +       struct page *page;
> > +       struct mm_struct *patching_mm = __this_cpu_read(cpu_patching_mm);
> > +       unsigned long patching_addr = __this_cpu_read(cpu_patching_addr);
> > +
> > +       if (is_vmalloc_or_module_addr(addr))
> > +               page = vmalloc_to_page(addr);
> > +       else
> > +               page = virt_to_page(addr);
> > +
> > +       patch_mapping->ptep = get_locked_pte(patching_mm, patching_addr,
> > +                                            &patch_mapping->ptl);
> > +       if (unlikely(!patch_mapping->ptep)) {
> > +               pr_warn("map patch: failed to allocate pte for patching\n");
> > +               return -1;
> > +       }
> > +
> > +       set_pte_at(patching_mm, patching_addr, patch_mapping->ptep,
> > +                  pte_mkdirty(mk_pte(page, PAGE_KERNEL)));
>
> I think because switch_mm_irqs_off() will not necessarily have a
> barrier so a ptesync would be needed.
> A spurious fault here from __patch_instruction() would not be handled
> correctly.

Sorry I don't quite follow - can you explain this to me in a bit more
detail?
