Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F9DC433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 26 Oct 2021 18:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F33A60238
	for <linux-hardening@archiver.kernel.org>; Tue, 26 Oct 2021 18:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbhJZSjd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 26 Oct 2021 14:39:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230225AbhJZSjc (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 26 Oct 2021 14:39:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D25DF60E05;
        Tue, 26 Oct 2021 18:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635273428;
        bh=1xQXVhbF8/BGLuvjiPQZc83KtW2+s7akCS60PQNrPZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g30x3pZvp/LbCs0Ax/nHYsd74I1JEAOKbTMArMvXnNkfibGEYWkLJSFx4Zytob6Bl
         F1iMT7y2fiD6zrj/XCf6jOAgGtDVvBg5gxOJcaZMoMO6MCAm4MmSWUh7cNAbG0hsWp
         ki9rEZgjxnq43vVD/BUU2qEJX3Evz4S9ttVDkFK5xVQsAiZq/r0lA/ptW4GANCPQmO
         raVqRcux30VB2ahlzI9+PnTXjazdX0SySkBbWjXHYc1MDw4zw2Xo5ABQvPpKr6Afoi
         koSXsza+Ospt210rf7g2WHLxvkljZOkaszX1Tkkr38o4AWaSI2FRkH0Wty5/q27pIJ
         iGjvwPiqXqKPQ==
Date:   Tue, 26 Oct 2021 13:42:01 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Haren Myneni <haren@linux.ibm.com>,
        linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] powerpc/vas: Fix potential NULL pointer dereference
Message-ID: <20211026184201.GB1457721@embeddedor>
References: <20211015050345.GA1161918@embeddedor>
 <97c42e43-15b9-5db6-d460-dbb16f31954d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97c42e43-15b9-5db6-d460-dbb16f31954d@linux.ibm.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 18, 2021 at 02:09:31PM -0700, Tyrel Datwyler wrote:
> On 10/14/21 10:03 PM, Gustavo A. R. Silva wrote:
> > (!ptr && !ptr->foo) strikes again. :)
> > 
> > The expression (!ptr && !ptr->foo) is bogus and in case ptr is NULL,
> > it leads to a NULL pointer dereference: ptr->foo.
> > 
> > Fix this by converting && to ||
> > 
> > This issue was detected with the help of Coccinelle, and audited and
> > fixed manually.
> > 
> > Fixes: 1a0d0d5ed5e3 ("powerpc/vas: Add platform specific user window operations")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Looking at the usage pattern it is obvious that if we determine !ptr attempting
> to also confirm !ptr->ops is going to blow up.
> 
> LGTM.
> 
> Reviewed-by: Tyrel Datwyler <tyreld@linux.ibm.com>

I think I'll take this in my tree.

Thanks, Tyrel.
--
Gustavo
