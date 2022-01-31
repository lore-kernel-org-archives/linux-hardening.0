Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC06C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 31 Jan 2022 19:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376468AbiAaT1s (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 31 Jan 2022 14:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359799AbiAaT1l (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 31 Jan 2022 14:27:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEDFC061714
        for <linux-hardening@vger.kernel.org>; Mon, 31 Jan 2022 11:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zAIKK08Tys6NkLC1tOuXVqp66nRrGOyO0fBWLyvmg9Y=; b=T+rJwx3QXKyIM9LTF9r16Zcr0t
        Y3Xphd22uXctgfTZTTPKZuHwgwi0x4L1NJkbtcRuyejTcJNQ4RrlUNybGug4NsAxxEeEoiaOq9Aa9
        kBp23Y9Nr5ptVymGh5n84YkhbVGWMf3Pqq8gIQoRJU3vcRMAAvYQfkUMK2OoZ+XNESlC8g0vqmze4
        uoTnZOWB3vV4XPPS6h1UjJXbUMSEWduoCIwRlksUj8Qc1h3W5rF/ss0AC9tYNMDrOiNGBEzdU7Yji
        ainlZ4X9T3vJcRakoc82iY3TKRDHgDok5zd4/BUWKuIFyR/oxcs8HBfpebyGooG6VbzYz/hmNjwq1
        /X9N/D6g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEcKt-00ATke-Cg; Mon, 31 Jan 2022 19:27:35 +0000
Date:   Mon, 31 Jan 2022 19:27:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 4/4] usercopy: Remove HARDENED_USERCOPY_PAGESPAN
Message-ID: <Yfg4J63vdl8S0pG2@casper.infradead.org>
References: <20220110231530.665970-1-willy@infradead.org>
 <20220110231530.665970-5-willy@infradead.org>
 <2858cfa9-2329-6da9-82b8-643f29d548e6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2858cfa9-2329-6da9-82b8-643f29d548e6@redhat.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jan 31, 2022 at 03:27:02PM +0100, David Hildenbrand wrote:
> On 11.01.22 00:15, Matthew Wilcox (Oracle) wrote:
> > There isn't enough information to make this a useful check any more;
> > the useful parts of it were moved in earlier patches, so remove this
> > set of checks now.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> 
> Very nice cleanup IMHO
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks.  I'm thinking about adding another check.  If the order-0
page has a non-NULL ->mapping, I believe that is enough to determine
that it's a page cache / KSM / Anon page, and as such is guaranteed
to actually be order-0 (and not part of a postive-order allocation
without __GFP_COMP set).  But that would require a bit more auditing,
or just throwing it in and seeing what breaks *whistles*.
