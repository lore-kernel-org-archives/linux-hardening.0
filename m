Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9265C433E0
	for <linux-hardening@archiver.kernel.org>; Wed, 31 Mar 2021 04:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BE2B619A7
	for <linux-hardening@archiver.kernel.org>; Wed, 31 Mar 2021 04:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhCaEnX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 31 Mar 2021 00:43:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229959AbhCaEnV (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 31 Mar 2021 00:43:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 033256146B;
        Wed, 31 Mar 2021 04:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1617165801;
        bh=UdCoaA3sJ8z5N002h6jBT07ZBJSUx0gnuR107bZBVpc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xkXPTK9Nog2Z87eV20bMjEQJLSaujKYteiw04LKUJ1q3J9J/PSHnlAwcb1tKPbpSe
         FcUG4bWqb9nWrNZD0SnivRxpStr6FN6hpWhGu4AtKjpp/36ExgFXc4ZbmxzOiC7cGd
         roDtFBknoXmbF63G/OkEh0U9vL3aHwFwtNEsnJQo=
Date:   Tue, 30 Mar 2021 21:43:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] hfsplus: Fix out-of-bounds warnings in
 __hfsplus_setxattr
Message-Id: <20210330214320.93600506530f1ab18338b467@linux-foundation.org>
In-Reply-To: <20210330145226.GA207011@embeddedor>
References: <20210330145226.GA207011@embeddedor>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, 30 Mar 2021 09:52:26 -0500 "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> Fix the following out-of-bounds warnings by enclosing
> structure members file and finder into new struct info:
> 
> fs/hfsplus/xattr.c:300:5: warning: 'memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user_info' with type 'struct DInfo' at offset 48 [-Warray-bounds]
> fs/hfsplus/xattr.c:313:5: warning: 'memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user_info' with type 'struct FInfo' at offset 48 [-Warray-bounds]
> 
> Refactor the code by making it more "structured."
> 
> Also, this helps with the ongoing efforts to enable -Warray-bounds and
> makes the code clearer and avoid confusing the compiler.

Confused.  What was wrong with the old code?  Was this warning
legitimate and if so, why?  Or is this patch a workaround for a
compiler shortcoming?
