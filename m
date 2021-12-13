Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B38C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Dec 2021 23:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244254AbhLMXoj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Dec 2021 18:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238230AbhLMXoj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Dec 2021 18:44:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113BEC061574
        for <linux-hardening@vger.kernel.org>; Mon, 13 Dec 2021 15:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uJin+BCLmxeMCPBXrQe1gxuez7RnlARPC1yq1vuWq+U=; b=EAlcNNg+HMCMPRBN77+zGk+NPp
        fblGc7bsxpLYQ7Sb6Vd868jR5NvZTS71tkDpYiiN+T8sVpG311UgA2PIqAZRa1IfwfSrlkmweDybF
        f+hp5SpX3XdtNjHr2jbguBFlaH4OQz9f3ouuMQ2Wsh+jJVZjev9NC9o7W9EZ0hTpW43UE68Uc6r4t
        tmHWZrSjZewiz0LAOp8j6GD5gx64ffMnLYR1rXsuUFr7bY57d9UVYPAyppA1m9rrNxl4I59KN3Gvs
        JzAq19w/FQSmPlhV11Zm2Qxq6Jtceu14J1YdjbZmTIllUlSMUQj8aRPbV4WwemPBbdz0VY3p1pid5
        PxFwykbw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwuzh-00DG7f-SQ; Mon, 13 Dec 2021 23:44:33 +0000
Date:   Mon, 13 Dec 2021 23:44:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mm/usercopy: Detect compound page overruns
Message-ID: <Ybfa4RV4fRkgjh8D@casper.infradead.org>
References: <20211213142703.3066590-1-willy@infradead.org>
 <20211213142703.3066590-4-willy@infradead.org>
 <202112131249.0D2A4A2C7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112131249.0D2A4A2C7@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Dec 13, 2021 at 12:52:22PM -0800, Kees Cook wrote:
> On Mon, Dec 13, 2021 at 02:27:03PM +0000, Matthew Wilcox (Oracle) wrote:
> > Move the compound page overrun detection out of
> > CONFIG_HARDENED_USERCOPY_PAGESPAN so it's enabled for more people.
> 
> I'd argue that everything else enabled by USERCOPY_PAGESPAN could be
> removed now too. Do you want to add a 4th patch to rip that out?
> 
> https://github.com/KSPP/linux/issues/163

I don't mind ... is it your assessment that it's not worth checking for
a copy_to/from_user that spans a boundary between a reserved and
!reserved page, or overlaps the boundary of rodata/bss/data/CMA?

I have no basis on which to judge that, so it's really up to you.
