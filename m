Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6333C4332F
	for <linux-hardening@archiver.kernel.org>; Tue, 18 Oct 2022 02:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiJRCJN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 17 Oct 2022 22:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiJRCIn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 17 Oct 2022 22:08:43 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F248E788
        for <linux-hardening@vger.kernel.org>; Mon, 17 Oct 2022 19:08:30 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id f23so12478371plr.6
        for <linux-hardening@vger.kernel.org>; Mon, 17 Oct 2022 19:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8o/3L/7nu8yqSqN2t7ynhTHNqc6zN3rpINeuVtJh23c=;
        b=Ejf9T48sPy2SQkDkKO3qeRvLhxySNSJCnDu6Xwwm0S7fucUsPGGdILc95lmBN0JR7m
         gYaf/SfNGV6HQ6L9OtG6dvMIzzfhmlStyUx496rhLALi/gn3WEbiVIF9qqOQOYX3a6PM
         SssrKHd8ghM4DgybtJLu0nA1WEx8YJwQquFFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8o/3L/7nu8yqSqN2t7ynhTHNqc6zN3rpINeuVtJh23c=;
        b=KKNnGG8+WGYpinApcsB9VnipFdvtQgYmGJAeqXMmBfNSzhplf3FnQrjnmzeJowRQHv
         goU2bKF/ZlYvvQpWQ76HNd68NLkh669Aid9kRFWd5rwmw8xZQWMvB1bM4Sn9H+PCrQND
         wMUs9HY0fLL4Y/p2KlyBqzQAKTneEgIUlGqVEMKAunEWNdXWHsLPLFKtYTum8XEqYuJp
         6zfzX9Kup24CABY9+gRXDkWDAXAT1TLVbjdpqSTGXrmoG7nI9aliz9RsKYhqpQ/drii4
         kHyQRSKu/726RXH0tFrAQtKPlsmTLil/FLtOTlJhGih9pchgY0C36FSFp8+UPgcPYdk8
         FBGg==
X-Gm-Message-State: ACrzQf2EEae7Z1+8oaeisFNNJx1rCXZ/lw8T+A2a9Fc/+3ehYpgLPmmG
        G7t9L/k+cXWWBAPDYjAwxYGRY6zBGxbh4A==
X-Google-Smtp-Source: AMsMyM6J95gTGuLusRFaCvMsJ0bdX7wowAFXXKCq11iWsbGo/OW/s7BeFJ9B9qNpiVJe61pC54CP5w==
X-Received: by 2002:a17:902:d484:b0:17f:7437:565d with SMTP id c4-20020a170902d48400b0017f7437565dmr630248plg.154.1666058898335;
        Mon, 17 Oct 2022 19:08:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d4-20020a631d04000000b00460d89df1f1sm6797003pgd.57.2022.10.17.19.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:08:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-hardening@vger.kernel.org, Nick Terrell <terrelln@fb.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] pstore: Use size_t for compress/decompression type widths
Date:   Mon, 17 Oct 2022 19:08:11 -0700
Message-Id: <20221018020815.2872331-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018020519.never.337-kees@kernel.org>
References: <20221018020519.never.337-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3370; h=from:subject; bh=d80Gw6VCQNtp9Ez6pYN9gROZhqnl6PYG6krL4B0B4o4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjTgqMos88G1DeCsiRQXnCR4zXLwb9UDI3ISAB1F4o GocmFImJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY04KjAAKCRCJcvTf3G3AJn12D/ 0aQ1ZAKOJEY9arwChs4OA2uRV6oYgtpEV0Vqbf1CrNEqoszswyKm83dWZjIsQfDaPkTVXUrt6AaAZh KhXqXry8mtOn2Q/8OvPkeiux7ChBtIMTyYzbb82dVlxgiTZF/MbOh/O0HHOHy40gXWM4qC8UzEnbMP uhk/JxGuOJNsItMrrG+h+z4sr7eN16+mpbjEGqnMbyTm0CaT1zh3oLULl0eYluGQOlfKBIwygVuWf2 Zuca9gRFaF+R5kukMrkDAaS9RTJT8z3znNqCwGKh1Wi6/1JZxmNNmq0YraSEJOEEejK0oEX8GLE0JV EgMkXBbQSG0X5cLREwp7RRC7Ej5T6OuKJMVqAP8eONNDoYls82NtGDB0mQkPDTVj+0cRHNt/6CXt+H UKM6TqbO9HBC8iBW4iYp/pr78AHpecShCoGdvgewKjJUxkF32lHh92QjTaNhcWp5Y4a4PNIu4eM+0R KX+HxTicQMjInWMcHgBfKfROug3RZeANjLebFqVC2rvESIcgiUmevJTLRQ4tNu5MfD9uhLfMps8jfO HVPHeOiGO3p29tj9QsMNRBSnZ+k5O/qeR1Lk7NWTHbqJ94e7sTubSLZblRTgM7U3AGOUbEgSrNu7DB +e7GlQxFJ4q/mulBqu19pB7ZbgBQtp4qKvHdgqnzU5feIHA2nmD+MH+HY4MQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for adding direct library calls for zstd, refactor
routines to use normalized compress/decompression type widths of size_t.

Cc: Tony Luck <tony.luck@intel.com>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/platform.c | 47 ++++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 1f01c4b904fc..210a4224edb4 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -155,17 +155,24 @@ static bool pstore_cannot_block_path(enum kmsg_dump_reason reason)
 }
 
 static int pstore_compress(const void *in, void *out,
-			   unsigned int inlen, unsigned int outlen)
+			   size_t inlen, size_t *outlen)
 {
 	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS_CRYPTO)) {
+		unsigned int crypto_outlen;
 		int ret;
 
-		ret = crypto_comp_compress(tfm, in, inlen, out, &outlen);
+		if (inlen > UINT_MAX || *outlen > UINT_MAX)
+			return -EINVAL;
+
+		crypto_outlen = *outlen;
+		ret = crypto_comp_compress(tfm, in, inlen, out, &crypto_outlen);
 		if (ret) {
 			pr_err("crypto_comp_compress failed, ret = %d!\n", ret);
 			return ret;
 		}
-		return outlen;
+
+		*outlen = crypto_outlen;
+		return 0;
 	}
 
 	return -EINVAL;
@@ -297,7 +304,6 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 		char *dst;
 		size_t dst_size;
 		int header_size;
-		int zipped_len = -1;
 		size_t dump_size;
 		struct pstore_record record;
 
@@ -327,11 +333,11 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 			break;
 
 		if (big_oops_buf) {
-			zipped_len = pstore_compress(dst, psinfo->buf,
-						header_size + dump_size,
-						psinfo->bufsize);
+			size_t zipped_len = psinfo->bufsize;
 
-			if (zipped_len > 0) {
+			if (pstore_compress(dst, psinfo->buf,
+					    header_size + dump_size,
+					    &zipped_len) == 0) {
 				record.compressed = true;
 				record.size = zipped_len;
 			} else {
@@ -563,10 +569,25 @@ void pstore_unregister(struct pstore_info *psi)
 }
 EXPORT_SYMBOL_GPL(pstore_unregister);
 
-static void decompress_record(struct pstore_record *record)
+static int pstore_decompress_crypto(struct pstore_record *record, char *workspace, size_t *outlen)
 {
+	unsigned int crypto_outlen = *outlen;
 	int ret;
-	int unzipped_len;
+
+	ret = crypto_comp_decompress(tfm, record->buf, record->size,
+				     workspace, &crypto_outlen);
+	if (ret) {
+		pr_err("crypto_comp_decompress failed, ret = %d!\n", ret);
+		return 0;
+	}
+
+	*outlen = crypto_outlen;
+	return 0;
+}
+
+static void decompress_record(struct pstore_record *record)
+{
+	size_t unzipped_len;
 	char *unzipped, *workspace;
 
 	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS_NONE) || !record->compressed)
@@ -591,11 +612,7 @@ static void decompress_record(struct pstore_record *record)
 	if (!workspace)
 		return;
 
-	/* After decompression "unzipped_len" is almost certainly smaller. */
-	ret = crypto_comp_decompress(tfm, record->buf, record->size,
-					  workspace, &unzipped_len);
-	if (ret) {
-		pr_err("crypto_comp_decompress failed, ret = %d!\n", ret);
+	if (pstore_decompress_crypto(record, workspace, &unzipped_len) != 0) {
 		kfree(workspace);
 		return;
 	}
-- 
2.34.1

