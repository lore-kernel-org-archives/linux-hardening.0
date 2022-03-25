Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A31C433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 25 Mar 2022 05:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347598AbiCYFcp (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 25 Mar 2022 01:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243776AbiCYFco (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 25 Mar 2022 01:32:44 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61940C5595;
        Thu, 24 Mar 2022 22:31:11 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C4BCD68B05; Fri, 25 Mar 2022 06:31:08 +0100 (CET)
Date:   Fri, 25 Mar 2022 06:31:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] usercopy: Disable CONFIG_HARDENED_USERCOPY_PAGESPAN
Message-ID: <20220325053108.GB5204@lst.de>
References: <20220324230255.1362706-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324230255.1362706-1-keescook@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Mar 24, 2022 at 04:02:55PM -0700, Kees Cook wrote:
> CONFIG_HARDENED_USERCOPY_PAGESPAN has been mostly broken for a while,
> and it has become hard to ignore with some recent scsi changes[1].
> While there is a more complete series to replace it with better checks[2],
> it should have more soak time in -next. Instead, disable the config now,
> with the expectation that it will be fully replaced in the next kernel
> release.
> 
> [1] https://lore.kernel.org/lkml/20220324064846.GA12961@lst.de/
> [2] https://lore.kernel.org/linux-hardening/20220110231530.665970-1-willy@infradead.org/
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

I'd prefer to just remove the code, but this is better than nothing:

Acked-by: Christoph Hellwig <hch@lst.de>
