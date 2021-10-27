Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEBBC433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 11:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 327E861040
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 11:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239623AbhJ0LYI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 27 Oct 2021 07:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237212AbhJ0LYI (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 27 Oct 2021 07:24:08 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD142C061570;
        Wed, 27 Oct 2021 04:21:42 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HfR911HlKz4xbr;
        Wed, 27 Oct 2021 22:21:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1635333701;
        bh=mxhJiJHxAE3DqN+NxMq3fawT9A/Z2lD9DWzQe94QgD8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pJM+SS2ik7o+BzLNcB0GdrKDSrYG6qQUlvRlcWVfQprhCc23GZGzjXApzNnuK27vY
         H6+CwoBbUI5rq/StD16Wp9gLljy66Cy2t1jK3Hn44FR9N2KdvtBIFLoT1hFu4x3NzI
         0DcVej+SunyHb6jgahrvrhYStINA0rxGAy5hLsMiFKQkxf2zp2OMHMWL86MkeQWF+g
         +iwf8tAa7zpys+KMBOWAR00iKDWgB537E6fqe68rp350GFh9bjAgIhaPgwgA7915cj
         eW8VYeG1ESHe+3XrHVMfY+XNXIOtyGk06ZCOTjBHlJbYmldAPWbWTCx2FFJFX4AvFR
         7+zM4Ead586dg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Haren Myneni <haren@linux.ibm.com>,
        linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] powerpc/vas: Fix potential NULL pointer dereference
In-Reply-To: <20211026224016.GA1488461@embeddedor>
References: <20211015050345.GA1161918@embeddedor>
 <97c42e43-15b9-5db6-d460-dbb16f31954d@linux.ibm.com>
 <20211026184201.GB1457721@embeddedor> <87h7d3beqq.fsf@mpe.ellerman.id.au>
 <20211026224016.GA1488461@embeddedor>
Date:   Wed, 27 Oct 2021 22:21:39 +1100
Message-ID: <87v91iaf24.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

"Gustavo A. R. Silva" <gustavoars@kernel.org> writes:
> On Wed, Oct 27, 2021 at 09:30:53AM +1100, Michael Ellerman wrote:
> [..]
>> > I think I'll take this in my tree.
>> 
>> I've already put it in powerpc/next:
>> 
>>   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=next&id=61cb9ac66b30374c7fd8a8b2a3c4f8f432c72e36
>
> Oh, great. :)
>
>> If you need to pick it up as well for some reason that's fine.
>
> I just didn't  want it to get lost somehow. I'll drop it from tree now.

No worries, sorry I've been so slow lately.

cheers
