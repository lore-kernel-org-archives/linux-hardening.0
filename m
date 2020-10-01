Return-Path: <SRS0=C0P2=DI=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C26C4727E
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Oct 2020 15:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 242BA208B6
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Oct 2020 15:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601565496;
	bh=C1g2lbWgPruQ9q68vkl9h0FKVYg6uIHEENbJQbM+XYs=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=0HI5s1rWyk99ppBbBNofXKM3Pt9pgurOQrcyup/C62lAYy0mIcc0nLUWnuaPndCOs
	 Uz62l180mPW7gt5VsNYUDCPAsDFXS3Koha/CjLs+81yQgNDNUBAPW956UAiSDDf301
	 lgDx50NUZkeIfAnBHXjImYGtiJTZovThV4OVjKxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbgJAPSP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Oct 2020 11:18:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732346AbgJAPSP (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Oct 2020 11:18:15 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC743208B6;
        Thu,  1 Oct 2020 15:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601565495;
        bh=C1g2lbWgPruQ9q68vkl9h0FKVYg6uIHEENbJQbM+XYs=;
        h=Date:From:To:Cc:Subject:From;
        b=u5dzNynD+rMiVUnmOdaakt5UV4WBYYwCqBuZONYU1XHpdfTZuNRtN5xUeuU5bZVab
         SgWaecBsDRWXsAA99uE+OpNDqFUAKYXFzlrojnIiiP6crnmdt3HVUzfYPcHtikXy6I
         u/TdXOikyKvu1ZYTUQJKlP8sxgGMsIrpjxb208cg=
Date:   Thu, 1 Oct 2020 10:24:01 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hardening@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 0/3][next] lib/stackdepot.c: Replace one-element array with
 flexible-array member
Message-ID: <cover.1601565471.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

This series aim to replace a one-element array with a flexible-array
member. Also, make use of the struct_size(), flexible_array_size()
and array_size() helpers.

Thanks
--
Gustavo

Gustavo A. R. Silva (3):
  lib/stackdepot.c: Replace one-element array with flexible-array member
  lib/stackdepot.c: Use flex_array_size() helper in memcpy()
  lib/stackdepot.c: Use array_size() helper in jhash2()

 lib/stackdepot.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

-- 
2.27.0

