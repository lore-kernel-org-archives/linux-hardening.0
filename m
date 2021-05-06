Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5D8C433ED
	for <linux-hardening@archiver.kernel.org>; Thu,  6 May 2021 18:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2D2661154
	for <linux-hardening@archiver.kernel.org>; Thu,  6 May 2021 18:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbhEFSZd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 6 May 2021 14:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbhEFSZb (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 6 May 2021 14:25:31 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3679BC061574
        for <linux-hardening@vger.kernel.org>; Thu,  6 May 2021 11:24:31 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id u20so8247541lja.13
        for <linux-hardening@vger.kernel.org>; Thu, 06 May 2021 11:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jEv5tsbty+v8OeQ9wP03mPApi7oS9HlG3cJxYfgNoiA=;
        b=cwWL6QfDfsK88627ETLN1flWqt9CgqYpMKMsnTfLYNl1q4lygFb0rZq1Lz0VwVsmrT
         AA9L6aOYWLWc8zfj+wGu+fTRyHCLoBzinxwLZ+RovMH7d0BzrMTIS/1t+Z5Na/ZsVpBS
         tPXeVSy7MvRWsvD3T64Pg72keOq3vST+61MvG326ReMWUIXXORBy8AI/uBrqCi0PujKV
         TrLfh6Xr7Tybx8Sza9TaTAeui8kUskm8BNtjkWdjkBwW1l53PKDohLZKu6PoGynPeHxs
         DzifD5lCoEgDClyS4w0wbpYYhUuq4kjnledeOK+gUfjx/j7/OLGYWNY51QaQj9vIvbYe
         lVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jEv5tsbty+v8OeQ9wP03mPApi7oS9HlG3cJxYfgNoiA=;
        b=coOwC7gdGGJMvhqI2elegcO3WRo46NQJWAzwvRUYE7esPiKtdqoEjJkyh+OdeuR+7Z
         y3HoVYkp1totEhUCOd9WWql+AL7WeGZvMebVjynUi8FPfUNuwbwFiUawQrzB5azDl6Wp
         YVfgcEh7E/GIQAd+eRRw+wU2o3TQUAk8uYtwlYAxtnQRFCJMPOo4doikwaMDh+0uWzzD
         KFafF9/IfAHx+d0BrrfOp41r5A+7KlQWYBz2xkCblcnrbpXDY5UWf8R3OWCRMaMjbpx9
         vQEVWIOYC3clQKBwVrJhVgVj5usbKFHx5OQS3srpxo0lfZ3hALrzxqC5Op73d+VCl11w
         gqzA==
X-Gm-Message-State: AOAM530QypWLPKbN/RU3HEv6iljQolCVP66Hi5nYx4A9xPbtcq33D0tZ
        la1R+kJqrlq+Y+5R7SOhHxHxBA05oQ7ZRG6oM+jQ4w==
X-Google-Smtp-Source: ABdhPJzy4hau3Y+ImQptMqxd6yvrIolm3ihuACWllTQt3Q7HCocEB90y1lMX8Lc4gL3EwqVc0U2JKjjqKX4V2//PC5c=
X-Received: by 2002:a2e:b5cd:: with SMTP id g13mr4757099ljn.0.1620325469530;
 Thu, 06 May 2021 11:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210505003032.489164-1-rick.p.edgecombe@intel.com> <20210505003032.489164-6-rick.p.edgecombe@intel.com>
In-Reply-To: <20210505003032.489164-6-rick.p.edgecombe@intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 6 May 2021 11:24:18 -0700
Message-ID: <CALvZod7ieLEObX0y-7X+_zMwaVN5o0P-ZwZVLqCAK5ytQrNs9w@mail.gmail.com>
Subject: Re: [PATCH RFC 5/9] x86, mm: Use cache of page tables
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linux MM <linux-mm@kvack.org>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com,
        Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 4, 2021 at 5:36 PM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>
[...]
> +#ifdef CONFIG_PKS_PG_TABLES
> +struct page *alloc_table(gfp_t gfp)
> +{
> +       struct page *table;
> +
> +       if (!pks_page_en)
> +               return alloc_page(gfp);
> +
> +       table = get_grouped_page(numa_node_id(), &gpc_pks);
> +       if (!table)
> +               return NULL;
> +
> +       if (gfp & __GFP_ZERO)
> +               memset(page_address(table), 0, PAGE_SIZE);
> +
> +       if (memcg_kmem_enabled() &&
> +           gfp & __GFP_ACCOUNT &&
> +           !__memcg_kmem_charge_page(table, gfp, 0)) {
> +               free_table(table);
> +               table = NULL;
> +       }
> +
> +       VM_BUG_ON_PAGE(*(unsigned long *)&table->ptl, table);

table can be NULL due to charge failure.
