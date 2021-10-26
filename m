Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8CDC433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 26 Oct 2021 22:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D48FE610A0
	for <linux-hardening@archiver.kernel.org>; Tue, 26 Oct 2021 22:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhJZWdZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 26 Oct 2021 18:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhJZWdY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 26 Oct 2021 18:33:24 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA67C061570;
        Tue, 26 Oct 2021 15:31:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hf63f3HMqz4xbG;
        Wed, 27 Oct 2021 09:30:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1635287454;
        bh=XefSZASUt0Shq3/7ecZYzgnUVFy7rObUidTFXFQDrPU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=esTDXAO9VPl+gb2NPopWhgwRcoAKMImKj95UXpm2end2j9VxyW8qWOQExKFdCD2r3
         4a+mjM6PhzR1Dx7NnsaUdKC8A9h4hQH8QbVPjd0w64niF0gJtD2paXrzLs8gGsawPB
         5r24B/zV9OZLLbD5DXlXDGV2qQNPcx+t4qsHIlI0w/eZSBKNSktsUqTd548ZBrjqqb
         T5icJ4Tw5eSz+Vn8mjFyVNqqP2DygNPnzsYuRsql1asJwyp5nXjpt5mhkHuoVqt/R5
         1RGTLcyFsedb3kM/5vatFc5wmHDc+TE+SvCghW+DRTZvNfXBYMfBhO26O2selqltlS
         Z9O13Qfolda3g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Haren Myneni <haren@linux.ibm.com>,
        linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] powerpc/vas: Fix potential NULL pointer dereference
In-Reply-To: <20211026184201.GB1457721@embeddedor>
References: <20211015050345.GA1161918@embeddedor>
 <97c42e43-15b9-5db6-d460-dbb16f31954d@linux.ibm.com>
 <20211026184201.GB1457721@embeddedor>
Date:   Wed, 27 Oct 2021 09:30:53 +1100
Message-ID: <87h7d3beqq.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

"Gustavo A. R. Silva" <gustavoars@kernel.org> writes:
> On Mon, Oct 18, 2021 at 02:09:31PM -0700, Tyrel Datwyler wrote:
>> On 10/14/21 10:03 PM, Gustavo A. R. Silva wrote:
>> > (!ptr && !ptr->foo) strikes again. :)
>> > 
>> > The expression (!ptr && !ptr->foo) is bogus and in case ptr is NULL,
>> > it leads to a NULL pointer dereference: ptr->foo.
>> > 
>> > Fix this by converting && to ||
>> > 
>> > This issue was detected with the help of Coccinelle, and audited and
>> > fixed manually.
>> > 
>> > Fixes: 1a0d0d5ed5e3 ("powerpc/vas: Add platform specific user window operations")
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> Looking at the usage pattern it is obvious that if we determine !ptr attempting
>> to also confirm !ptr->ops is going to blow up.
>> 
>> LGTM.
>> 
>> Reviewed-by: Tyrel Datwyler <tyreld@linux.ibm.com>
>
> I think I'll take this in my tree.

I've already put it in powerpc/next:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=next&id=61cb9ac66b30374c7fd8a8b2a3c4f8f432c72e36

If you need to pick it up as well for some reason that's fine.

cheers
