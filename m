Return-Path: <SRS0=C0P2=DI=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAFBC4727C
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Oct 2020 15:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 104BC207F7
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Oct 2020 15:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601565597;
	bh=ZoWJIt7tW81VESqtsxKPRRDnGuYfZzDylCo+K+tvRks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iAnuQRdn8i8IqBzTijihre19jdiNZ5Qi7d1wcmnnkNXy5WRDMSBqXN2XkgEn1FyX5
	 22+c9487eK0bo7k3yRRuCuTP5cuyTyVAIgjpryGYVhj91psyZ8E7Sq1lOttMohMOZp
	 gCZRQuBE1TnqzhYIe3X1OOkPETV3jQscawZbMEgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732516AbgJAPT4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Oct 2020 11:19:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732410AbgJAPT4 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Oct 2020 11:19:56 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05F0F207F7;
        Thu,  1 Oct 2020 15:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601565596;
        bh=ZoWJIt7tW81VESqtsxKPRRDnGuYfZzDylCo+K+tvRks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IzqzfHEhgWUe0fqq82zQG/SZhoH0zH3JdKuhdJ5FFO6oyna4DB2rBg/AlsK322Zyc
         4yN/7A3EhimttE1706T95hQX7/PosYbSnWDLilAyaBPaGzsmmvAJ73sTt/D+NG8aYH
         wujJNPsFEZ+XS0O4Cccjha9xj+f/ed9zRSEPVt8M=
Date:   Thu, 1 Oct 2020 10:25:42 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hardening@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 2/3][next] lib/stackdepot.c: Use flex_array_size() helper in
 memcpy()
Message-ID: <186e37fe07196ee41a0e562fa8a8cb7a01112ec5.1601565471.git.gustavoars@kernel.org>
References: <cover.1601565471.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1601565471.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Make use of the flex_array_size() helper to calculate the size of a
flexible array member within an enclosing structure.

This helper offers defense-in-depth against potential integer
overflows, while at the same time makes it explicitly clear that
we are dealing with a flexible array member.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 lib/stackdepot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index c6106cfb7950..683b6a8ddade 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -135,7 +135,7 @@ static struct stack_record *depot_alloc_stack(unsigned long *entries, int size,
 	stack->handle.slabindex = depot_index;
 	stack->handle.offset = depot_offset >> STACK_ALLOC_ALIGN;
 	stack->handle.valid = 1;
-	memcpy(stack->entries, entries, size * sizeof(unsigned long));
+	memcpy(stack->entries, entries, flex_array_size(stack, entries, size));
 	depot_offset += required_size;
 
 	return stack;
-- 
2.27.0

