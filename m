Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2503C433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 16 Sep 2021 02:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6DF5611C6
	for <linux-hardening@archiver.kernel.org>; Thu, 16 Sep 2021 02:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhIPCGD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 15 Sep 2021 22:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbhIPCGD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 15 Sep 2021 22:06:03 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D20C061574
        for <linux-hardening@vger.kernel.org>; Wed, 15 Sep 2021 19:04:43 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id k65so9720631yba.13
        for <linux-hardening@vger.kernel.org>; Wed, 15 Sep 2021 19:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tz6piMeU5SmaffRbNmnfnHu1gxXBC9YCGjCvKu8dEbk=;
        b=XkrIPrRzEz2KMMyLG5dI7T+y/swRc8XV0Khbp57pyuTJX1Nz53Sy5wYFxxasrmPF+W
         XWX4DCY05NF0GjPvXZ7Ep35ASUa9bHnP+CiwvErWytJWGYSp+uEb3kahqmCSwe8eks3k
         hNvCuVF9Hrf0lJBsPeORLejCy7RsF2K5fwMf4v0o0FuhpX/k/i8/yFhv4S936uYarThx
         s57VeJJ0vlnR4Lv9n9XZHyx7v6C8YXOAFY7mBHQqKmybfx/9OxwiGmoBRvL9hbWgBn62
         Q21W/Elc3EZWmj52qEGdeHVUotFvcdY1knESEwSSod+16kOQ6XuSDFQjnJgafr2AnxmF
         ToTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tz6piMeU5SmaffRbNmnfnHu1gxXBC9YCGjCvKu8dEbk=;
        b=ZRWTm/57koVPbuHGrgVrAAGzaLSsJV/s5bzznaMHUENQKDaxQ/FrlMBgimwwHurTQR
         zb28WhnutfDsRGcKLtF4l9eqGHxTI1+S3THS6YnBCY5Z1eeifasogS6hmtod5BPTzNgF
         vpCapTurZjfdDEYgMXRtOfnqm0kA9DALlKHT0ANt3MWvIQDiyX3vabvK49t7GZPIQH9C
         sGNBpQyanpixfZ/5FBEoFX7EcQMDHXn16i/ezv0JNqqTI+zslXqf70baej7+LWLmCZDi
         +lZhSYO6hCGQNWl1H1bRTuqM3Ns1fXi+hjV9LS5jhEN937QtvhrmhOpxLr1dPaSyleqe
         YjXA==
X-Gm-Message-State: AOAM531YT3IhjUOujYRUIkpRDZYz/tXbz497lwg3Mlwnsg4uCdoWHXjI
        7PykpWTscrvHLl9Qhlu85TaN789oDurRMCcxZm+cOPmV6fs=
X-Google-Smtp-Source: ABdhPJx72GnacP9xthd9U/wXYrT459EEqrVhb1oa3QdSt9K3KHRK7tf+FRk49IS71Z/jfNvAPJl53stO99zV+UfTWBs=
X-Received: by 2002:a5b:f43:: with SMTP id y3mr3940004ybr.45.1631757882872;
 Wed, 15 Sep 2021 19:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <CACzsE9qr6QK_Xm6yVXT061sxR9SXaeFx5fkjiNAXFBFr6WDQOw@mail.gmail.com>
 <CEAW7GNXW96H.18ANPMC01JA2C@wrwlf0000>
In-Reply-To: <CEAW7GNXW96H.18ANPMC01JA2C@wrwlf0000>
From:   Jordan Niethe <jniethe5@gmail.com>
Date:   Thu, 16 Sep 2021 12:04:31 +1000
Message-ID: <CACzsE9qmjABva6-RB5HVciB7tJ-XdD2=-cLFoxjh5UG9fyOJNg@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] powerpc/64s: Initialize and use a temporary mm for
 patching on Radix
To:     "Christopher M. Riedl" <cmr@bluescreens.de>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 16, 2021 at 10:40 AM Christopher M. Riedl
<cmr@bluescreens.de> wrote:
>
> On Tue Sep 14, 2021 at 11:24 PM CDT, Jordan Niethe wrote:
> > On Sat, Sep 11, 2021 at 12:39 PM Christopher M. Riedl
> > <cmr@bluescreens.de> wrote:
> > > ...
> > > +/*
> > > + * This can be called for kernel text or a module.
> > > + */
> > > +static int map_patch_mm(const void *addr, struct patch_mapping *patch_mapping)
> > > +{
> > > +       struct page *page;
> > > +       struct mm_struct *patching_mm = __this_cpu_read(cpu_patching_mm);
> > > +       unsigned long patching_addr = __this_cpu_read(cpu_patching_addr);
> > > +
> > > +       if (is_vmalloc_or_module_addr(addr))
> > > +               page = vmalloc_to_page(addr);
> > > +       else
> > > +               page = virt_to_page(addr);
> > > +
> > > +       patch_mapping->ptep = get_locked_pte(patching_mm, patching_addr,
> > > +                                            &patch_mapping->ptl);
> > > +       if (unlikely(!patch_mapping->ptep)) {
> > > +               pr_warn("map patch: failed to allocate pte for patching\n");
> > > +               return -1;
> > > +       }
> > > +
> > > +       set_pte_at(patching_mm, patching_addr, patch_mapping->ptep,
> > > +                  pte_mkdirty(mk_pte(page, PAGE_KERNEL)));
> >
> > I think because switch_mm_irqs_off() will not necessarily have a
> > barrier so a ptesync would be needed.
> > A spurious fault here from __patch_instruction() would not be handled
> > correctly.
>
> Sorry I don't quite follow - can you explain this to me in a bit more
> detail?

radix__set_pte_at() skips calling ptesync as an optimization.
If there is no ordering between changing the pte and then accessing
the page with __patch_instruction(), a spurious fault could be raised.
I think such a fault would end up being causing bad_kernel_fault() ->
true and would not be fixed up.

I thought there might be a barrier in switch_mm_irqs_off() that would
provide this ordering but afaics that is not always the case.

So I think that we need to have a ptesync after set_pte_at().
