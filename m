Return-Path: <SRS0=DAdQ=DP=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEF0C43457
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 17:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9584221FE
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 17:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pd6VXGVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732035AbgJHR1C (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Oct 2020 13:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbgJHR1B (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Oct 2020 13:27:01 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F4EC0613D2
        for <linux-hardening@vger.kernel.org>; Thu,  8 Oct 2020 10:26:59 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id p13so6647400edi.7
        for <linux-hardening@vger.kernel.org>; Thu, 08 Oct 2020 10:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NK/SL9W3DmzutM+WXBbWy3ollYdvMFEoNGZZc0Sd0N0=;
        b=Pd6VXGVE8CSWBlYfJc2ci7thQfj4LljK+DJhu8w6e8FcVdLdk3U/YZwGom/AXGVXtj
         Ggz2o+eCvr/JNTnw6z/RhM0wt8xenIB7IzJ6KG7ZwbDB7DFRfSRLf1/dfvPz+8QWjOIS
         Z9+hbKEICkevSo1xsnaRO+OTbvh604S+XCOqB91gp0sa6gC7k036dd/UzxZkADvIydKr
         kr4pA7X/Jh0ssBN4lsprAf89fNIC664UtfgczHQJ/JhSfnrMj3ZGhLElRO6iQ8kkK/ft
         01IFeZNFutVsBpnGIrn/d6l8xGiyrNOvLxNOEp5wCZWeetFdsV3pIAhK8/pMaGCiM5Y3
         TwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NK/SL9W3DmzutM+WXBbWy3ollYdvMFEoNGZZc0Sd0N0=;
        b=bCRe3Uk0Q+/fiGGx++Bw4viCaHc1KlBlIhiP6h2nlqgP1Mo7ExwYM63/28BxYzPKEb
         gu2dzsrOfroc6tBfvzlJSuAa8j7L5WZjtKbdyED05UOgkukVh5B/qHOZI6mwACLE7bxx
         FM3wUrbGitNWiLtNyzuRPNF5Oy7zbJzX2At2/GQRzFlI4Y4Z0hBqy3YcfmudUyjJLB1d
         V4HnibSaPgy3oYQ2FAMJvUO+bNQMwJb5DpC6eoFq5juQNkuBvc+fCWKWq8ovVqTzub/G
         K4bn6D+rfVCyJ9hPV/t7xFCTu03xbBq+Co86DyP2B6ljEnR+IqFbEYgzZfOeS3reO63z
         SImw==
X-Gm-Message-State: AOAM531eTb18miansocpmnRlJXi1YMVWe8PmLBwS5C97KlC8hRsTal80
        rHjUTEh4+E14Nvwf+xvljlhggbzLjs3Ax/bB7ZVF3A==
X-Google-Smtp-Source: ABdhPJwCRvJlPe3HTKxjHpBOw8YuPBCkXh9yxNGN84Y0S8cA9Jio+pxXOUqkXJ4XuStzFAbxLOl3TqmmcZhcBjeb0oA=
X-Received: by 2002:a05:6402:32f:: with SMTP id q15mr10185170edw.230.1602178017731;
 Thu, 08 Oct 2020 10:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20201008165408.38228-1-toiwoton@gmail.com> <CAG48ez1OU9PFQ06mf4L59SEmi6Vwxnao8RuVXH=dCiyMhqVwYA@mail.gmail.com>
 <20201008172300.GL20115@casper.infradead.org>
In-Reply-To: <20201008172300.GL20115@casper.infradead.org>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 8 Oct 2020 19:26:31 +0200
Message-ID: <CAG48ez3-uvDXL7-WBapEJMHrkXYpnAw=AgbP2evOZgNMFWKy-A@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] mm: Optional full ASLR for mmap() and mremap()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        linux-hardening@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 8, 2020 at 7:23 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Thu, Oct 08, 2020 at 07:13:51PM +0200, Jann Horn wrote:
> > And for expanding stacks, it might be a good idea for other
> > reasons as well (locking consistency) to refactor them such that the
> > size in the VMA tree corresponds to the maximum expansion of the stack
> > (and if an allocation is about to fail, shrink such stack mappings).
>
> We're doing that as part of the B-tree ;-)  Although not the shrink
> stack mappings part ...

Wheee, thanks! Finally no more data races on ->vm_start?
