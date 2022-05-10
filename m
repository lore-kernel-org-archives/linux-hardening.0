Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB183C433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 10 May 2022 03:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiEJDlx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 9 May 2022 23:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235689AbiEJDlm (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 9 May 2022 23:41:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B15921824
        for <linux-hardening@vger.kernel.org>; Mon,  9 May 2022 20:37:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B25DB81AEC
        for <linux-hardening@vger.kernel.org>; Tue, 10 May 2022 03:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A64C385A6;
        Tue, 10 May 2022 03:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652153863;
        bh=FT1lNXjVudXrHCOQvlF/y7rn0xd5iMFFhyFSFgCjpK8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i7mp2aVnHO4vcEj4mBltGUfoGij1uuMJVZCX9l9QX/uC7NbDvWvqoMlDvRCEft3dZ
         1jnk2UYARlP0RJ/Zru5mnO2/xVPCJQODn/vgiagQ4+wTUxNTgB01HTAd4R8KOMu4m1
         B+CwEerU2QJUc/d7dJlZr3QcDx8Ig8PUYlmQ2aEI=
Date:   Mon, 9 May 2022 20:37:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/4] mm/usercopy: Check kmap addresses properly
Message-Id: <20220509203742.0f4adfa4004e51e66c1c9a20@linux-foundation.org>
In-Reply-To: <20220110231530.665970-2-willy@infradead.org>
References: <20220110231530.665970-1-willy@infradead.org>
        <20220110231530.665970-2-willy@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, 10 Jan 2022 23:15:27 +0000 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> If you are copying to an address in the kmap region, you may not copy
> across a page boundary,

In the source, the destination or in both, and why may we not?

> no matter what the size of the underlying
> allocation.  You can't kmap() a slab page because slab pages always
> come from low memory.

Why not?  kmap() does

	if (!PageHighMem(page))
		addr = page_address(page);
	else
		addr = kmap_high(page);


