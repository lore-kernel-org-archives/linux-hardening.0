Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172AFC433ED
	for <linux-hardening@archiver.kernel.org>; Thu,  6 May 2021 10:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5B87610D2
	for <linux-hardening@archiver.kernel.org>; Thu,  6 May 2021 10:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbhEFKy0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 6 May 2021 06:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbhEFKyZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 6 May 2021 06:54:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA92C061574
        for <linux-hardening@vger.kernel.org>; Thu,  6 May 2021 03:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y3XLcKmE5Afam3CXYxi4OxOBr7bdPJoC1pKdCFBRVaE=; b=BjZV0LfOC3qjlYrnTV7kSCZsod
        ajFER0c8YqYxysWnxFGjbofmsJyqYTSpmN85WOP4UCENH0VS4P3LpobFUP85NV/5GKFb3LxoAqg0i
        wEaCPEhGjvmvmLh/zLLr38pjToGMTotuZEMEg6+ISgv1UXj6zlfJhZL+i6OOwEGmq5zM3WSRLI2zQ
        b4ks9xWzZdR6HewaLA3csMfDm0axSqG1tHBpsc+m0lZ83rxJNASfIgncQfeoQ3Pp9+a0SR3P0Wzbu
        PNFrP471XEC/YGBafinFkXgaGG5eJIKhFQ2iMNEhTHIsn/azSlfA720xHGKcD+aM1Mqt3IM0ZodRu
        u2iu7CNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lebbS-001c0Q-HN; Thu, 06 May 2021 10:51:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0B5E8300103;
        Thu,  6 May 2021 12:51:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CB9FC2C328C4C; Thu,  6 May 2021 12:51:33 +0200 (CEST)
Date:   Thu, 6 May 2021 12:51:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Christopher M. Riedl" <cmr@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, tglx@linutronix.de, x86@kernel.org,
        linux-hardening@vger.kernel.org, keescook@chromium.org
Subject: Re: [RESEND PATCH v4 10/11] powerpc: Protect patching_mm with a lock
Message-ID: <YJPKNSNVf34a39qC@hirez.programming.kicks-ass.net>
References: <20210506043452.9674-1-cmr@linux.ibm.com>
 <20210506043452.9674-11-cmr@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506043452.9674-11-cmr@linux.ibm.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, May 05, 2021 at 11:34:51PM -0500, Christopher M. Riedl wrote:
> Powerpc allows for multiple CPUs to patch concurrently. When patching
> with STRICT_KERNEL_RWX a single patching_mm is allocated for use by all
> CPUs for the few times that patching occurs. Use a spinlock to protect
> the patching_mm from concurrent use.
> 
> Modify patch_instruction() to acquire the lock, perform the patch op,
> and then release the lock.
> 
> Also introduce {lock,unlock}_patching() along with
> patch_instruction_unlocked() to avoid per-iteration lock overhead when
> patch_instruction() is called in a loop. A follow-up patch converts some
> uses of patch_instruction() to use patch_instruction_unlocked() instead.

x86 uses text_mutex for all this, why not do the same?
