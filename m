Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE56C433B4
	for <linux-hardening@archiver.kernel.org>; Wed,  5 May 2021 08:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31AB761155
	for <linux-hardening@archiver.kernel.org>; Wed,  5 May 2021 08:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhEEIir (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 5 May 2021 04:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbhEEIio (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 5 May 2021 04:38:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B5CC06174A;
        Wed,  5 May 2021 01:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jK0moekqG1xhMRv7+xXp4lJk9jp8uiNxobgiWKXh+5A=; b=jkvUVKohOf8O1K994UUXsnu1Gj
        pAAaW1jnaye2Wb2MFj/ciaGL47PIcPViHLq0CnU333G/XawQNPK0MV6jmzZ4iyBgSQMki6+TDvuy3
        hBUKvCswsLWem6snP55iS3jVqkke/+1gG137r3Igj/sdeN6oBGiR5ejHqcP/5OYtpMBlxQlB0WvYZ
        XUmLfDJtEqZ3rlw81tUS47E6aBsOEjpbYfbPZzqkON39WlzByDrdH6PpKXhyVLiOTqB/200jKL5pv
        RtP0WEXVcHu+1wVhJHtq1jJEiB5kNS5Dmu64OI+dtC1CWvHBIwfvdgtby5nCAAbOX0JIxQC66ZV60
        1Vbtr6cA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1leD2B-000eI4-25; Wed, 05 May 2021 08:37:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 710D93001CD;
        Wed,  5 May 2021 10:37:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 57BA52D6DCEF9; Wed,  5 May 2021 10:37:29 +0200 (CEST)
Date:   Wed, 5 May 2021 10:37:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, dave.hansen@intel.com,
        luto@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com, ira.weiny@intel.com,
        rppt@kernel.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/9] PKS write protected page tables
Message-ID: <YJJZSdVoP6yBbIjN@hirez.programming.kicks-ass.net>
References: <20210505003032.489164-1-rick.p.edgecombe@intel.com>
 <202105042253.ECBBF6B6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202105042253.ECBBF6B6@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 04, 2021 at 11:25:31PM -0700, Kees Cook wrote:

> It looks like PKS-protected page tables would be much like the
> RO-protected text pages in the sense that there is already code in
> the kernel to do things to make it writable, change text, and set it
> read-only again (alternatives, ftrace, etc).

We don't actually modify text by changing the mapping at all. We modify
through a writable (but not executable) temporary alias on the page (on
x86).

Once a mapping is RX it will *never* be writable again (until we tear it
all down).
