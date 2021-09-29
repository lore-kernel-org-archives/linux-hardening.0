Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF88C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 29 Sep 2021 19:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D57E613DA
	for <linux-hardening@archiver.kernel.org>; Wed, 29 Sep 2021 19:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbhI2Tiz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 29 Sep 2021 15:38:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229561AbhI2Tiy (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 29 Sep 2021 15:38:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0993B6142A;
        Wed, 29 Sep 2021 19:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632944233;
        bh=hG01tp3xR3wwWbXfzZU/TjmioAfC3aePsndJLpcDZxs=;
        h=Date:From:To:Cc:Subject:From;
        b=BZ3/fqeqaG1UxY9Yp0Y91bH/c2vnEe/7xZWubdckxn/xubdqQn6AbZtQvMoUpkGeG
         6iHBRBqkoToAeyplUm2q8jfr3HB3F9nRnY/Qp0d+yYB7F5R//X+PgmPNpBpKLi58uj
         cQTdzVRiHmwVX2VSgETnmzCLzaXN1X7Y/9vy100WxqEzrRdDmzsDRio3wn53ZoA7OJ
         8g3m2h6SS0DqCXDsondCrpSzNIPbXFDHeLP94Nuv9jWrLHxWm3K5WcvdD84LxEDa0I
         PvHMHyRp/677oKw49gCTq2gzlpvziRXXxfmt2GXOAu+wN1wQPBOKJAwF+j4KKv+M22
         fSIp5h+RGwceA==
Date:   Wed, 29 Sep 2021 14:41:18 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] staging: rtl8723bs: Replace zero-length array with
 flexible-array member
Message-ID: <20210929194118.GA340431@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

One-element and zero-length arrays are deprecated and should be
replaced with flexible-array members[1].

Replace zero-length array with flexible-array member and make use
of the struct_size() helper.

[1] https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays

Link: https://github.com/KSPP/linux/issues/78
Link: https://github.com/KSPP/linux/issues/160
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/staging/rtl8723bs/include/osdep_service.h | 2 +-
 drivers/staging/rtl8723bs/os_dep/osdep_service.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/osdep_service.h b/drivers/staging/rtl8723bs/include/osdep_service.h
index bde415db4114..cf96b5f7a776 100644
--- a/drivers/staging/rtl8723bs/include/osdep_service.h
+++ b/drivers/staging/rtl8723bs/include/osdep_service.h
@@ -113,7 +113,7 @@ struct rtw_cbuf {
 	u32 write;
 	u32 read;
 	u32 size;
-	void *bufs[0];
+	void *bufs[];
 };
 
 bool rtw_cbuf_full(struct rtw_cbuf *cbuf);
diff --git a/drivers/staging/rtl8723bs/os_dep/osdep_service.c b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
index 2d630ecef08b..d6bddf7b08e8 100644
--- a/drivers/staging/rtl8723bs/os_dep/osdep_service.c
+++ b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
@@ -274,7 +274,7 @@ struct rtw_cbuf *rtw_cbuf_alloc(u32 size)
 {
 	struct rtw_cbuf *cbuf;
 
-	cbuf = rtw_malloc(sizeof(*cbuf) + sizeof(void *) * size);
+	cbuf = rtw_malloc(struct_size(cbuf, bufs, size));
 
 	if (cbuf) {
 		cbuf->write = cbuf->read = 0;
-- 
2.27.0

