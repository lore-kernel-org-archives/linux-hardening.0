Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AB5C43334
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 14:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385772AbiFMOuo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 10:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386088AbiFMOqn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 10:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C67E4C0E07
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 04:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655121148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gYcDF7UT29qm92ngPmTzR7cWefKdcM6Ju6JodAruFT4=;
        b=e4qVCvDjyVNzJKfbjLcWIt4nxk8nEJJBCjLFQoAUCsdeMCoXXR1wfZh7/ypjpEjv8p4PRs
        O9C+i1s4lAJcBlYWSpqvbI1is60XD/S8QhPo6SUWDRljBL6daM6NwFm7Z2MDMu/1IUX/8q
        RxkE+4Mc+jq3ShTQ40JPUzDea8bZNH0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-qalXPBk7O_mvIA9yu2gtQg-1; Mon, 13 Jun 2022 07:52:25 -0400
X-MC-Unique: qalXPBk7O_mvIA9yu2gtQg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADA9080B712;
        Mon, 13 Jun 2022 11:52:24 +0000 (UTC)
Received: from localhost (ovpn-14-0.pek2.redhat.com [10.72.14.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D2D0640C1247;
        Mon, 13 Jun 2022 11:52:23 +0000 (UTC)
Date:   Mon, 13 Jun 2022 19:52:20 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        Zorro Lang <zlang@redhat.com>, linux-xfs@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/3] usercopy: Handle vm_map_ram() areas
Message-ID: <Yqck9GUI8B7mUx4N@MiWiFi-R3L-srv>
References: <20220612213227.3881769-1-willy@infradead.org>
 <20220612213227.3881769-2-willy@infradead.org>
 <YqcKw4AxxvEWtLmS@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqcKw4AxxvEWtLmS@pc638.lan>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 06/13/22 at 12:00pm, Uladzislau Rezki wrote:
> > vmalloc does not allocate a vm_struct for vm_map_ram() areas.  That causes
> > us to deny usercopies from those areas.  This affects XFS which uses
> > vm_map_ram() for its directories.
> > 
> > Fix this by calling find_vmap_area() instead of find_vm_area().
> > 
> > Fixes: 0aef499f3172 ("mm/usercopy: Detect vmalloc overruns")
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  include/linux/vmalloc.h | 1 +
> >  mm/usercopy.c           | 8 +++++---
> >  mm/vmalloc.c            | 2 +-
> >  3 files changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> > index b159c2789961..096d48aa3437 100644
> > --- a/include/linux/vmalloc.h
> > +++ b/include/linux/vmalloc.h
> > @@ -215,6 +215,7 @@ extern struct vm_struct *__get_vm_area_caller(unsigned long size,
> >  void free_vm_area(struct vm_struct *area);
> >  extern struct vm_struct *remove_vm_area(const void *addr);
> >  extern struct vm_struct *find_vm_area(const void *addr);
> > +struct vmap_area *find_vmap_area(unsigned long addr);
> Make it "extern" since it becomes globally visible?

extern is not suggested any more to add for function declaration in
header file, and removing it doesn't impact thing.

> 
> --
> Uladzislau Rezki
> 

