Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D0B4C8D
	for <linux-hardening@vger.kernel.org>; Sat, 21 Oct 2023 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Iv8iVbAF"
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC07DF
	for <linux-hardening@vger.kernel.org>; Sat, 21 Oct 2023 10:06:45 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id uFQvqTkB8Bo7OuFQvqjLbi; Sat, 21 Oct 2023 19:06:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1697908003;
	bh=uy9rKGXC9pVvC/rWHxA/Lky5Qfo0J4plguAT77M6c0E=;
	h=From:To:Cc:Subject:Date;
	b=Iv8iVbAFNffdrdJXskC8W3teIYrEDdSHlLmFpXJJKVhCWU6rdIP4bNTywwu2Dc/FM
	 Y6S3Xu3/rFa/RQdEaJh+doF8unrzOlIMUS6VJLvxV9iOMkvCoK/r/B2LeKOW+ghYzr
	 XPjVY5OLtgidLo3P1vhiyRBHQFs4ujVAGoJvXjqe7dTqNEMwiM5XpjI5Cs80BDv3lm
	 U++OHUfO1ukV7GT1irym5H8lcl3DG/GWKVu830HMVphWbWqBzcYxr4EpHUBRyFX9u5
	 PtUmBp65B94G5nhB2hgRwfTU+VA+jC8MPT8MWQq6dzryUOyRiam7yYqT5jDLMxKqVX
	 TTv62Wd8swC3g==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 21 Oct 2023 19:06:43 +0200
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: keescook@chromium.org,
	Robert Richter <rric@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sergey Temerkhanov <s.temerkhanov@gmail.com>
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Borislav Petkov <bp@suse.de>,
	linux-edac@vger.kernel.org
Subject: [PATCH] EDAC/thunderx: Fix some potential buffer overflow in thunderx_ocx_com_threaded_isr()
Date: Sat, 21 Oct 2023 19:06:34 +0200
Message-Id: <a787355ac896903935dd85ac96cddf1a0afa87af.1697903882.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strncat() usage in thunderx_ocx_com_threaded_isr() is wrong.
The size given to strncat() is the maximum number of bytes that can be
written, excluding the trailing NULL.

Here, the size of the 'msg' buffer is used (i.e. OCX_MESSAGE_SIZE), not
the space that is remaining.
The space for the ending NULL is also not taken into account.

in order to fix it:
   - call decode_register() before the snprintf() calls
   - use scnprintf() instead of snprintf() and compute, in the 'remaining'
     variable, the space that is still available in the 'msg' buffer
   - add a %s at the end of the format strings and append directly the
     result of decode_register() stored in 'other'
   - write directly at the right position in the 'msg' buffer when
     appending some data in the for loop.

Doing so, all usages of strncat() are removed.

Fixes: 41003396f932 ("EDAC, thunderx: Add Cavium ThunderX EDAC driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This is cross-compile tested only.
Review with care.
---
 drivers/edac/thunderx_edac.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index b9c5772da959..9544836dbd19 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -1111,6 +1111,7 @@ static irqreturn_t thunderx_ocx_com_threaded_isr(int irq, void *irq_id)
 
 	unsigned long tail;
 	struct ocx_com_err_ctx *ctx;
+	size_t remaining;
 	int lane;
 	char *msg;
 	char *other;
@@ -1127,27 +1128,26 @@ static irqreturn_t thunderx_ocx_com_threaded_isr(int irq, void *irq_id)
 				ARRAY_SIZE(ocx->com_err_ctx));
 		ctx = &ocx->com_err_ctx[tail];
 
-		snprintf(msg, OCX_MESSAGE_SIZE, "%s: OCX_COM_INT: %016llx",
-			ocx->edac_dev->ctl_name, ctx->reg_com_int);
-
 		decode_register(other, OCX_OTHER_SIZE,
 				ocx_com_errors, ctx->reg_com_int);
 
-		strncat(msg, other, OCX_MESSAGE_SIZE);
+		remaining = OCX_MESSAGE_SIZE;
+		remaining -= scnprintf(msg, remaining, "%s: OCX_COM_INT: %016llx%s",
+				       ocx->edac_dev->ctl_name, ctx->reg_com_int,
+				       other);
 
 		for (lane = 0; lane < OCX_RX_LANES; lane++)
 			if (ctx->reg_com_int & BIT(lane)) {
-				snprintf(other, OCX_OTHER_SIZE,
-					 "\n\tOCX_LNE_INT[%02d]: %016llx OCX_LNE_STAT11[%02d]: %016llx",
-					 lane, ctx->reg_lane_int[lane],
-					 lane, ctx->reg_lane_stat11[lane]);
-
-				strncat(msg, other, OCX_MESSAGE_SIZE);
-
 				decode_register(other, OCX_OTHER_SIZE,
 						ocx_lane_errors,
 						ctx->reg_lane_int[lane]);
-				strncat(msg, other, OCX_MESSAGE_SIZE);
+
+				remaining -= scnprintf(msg + (OCX_MESSAGE_SIZE - remaining),
+						       remaining,
+						       "\n\tOCX_LNE_INT[%02d]: %016llx OCX_LNE_STAT11[%02d]: %016llx%s",
+						       lane, ctx->reg_lane_int[lane],
+						       lane, ctx->reg_lane_stat11[lane],
+						       other);
 			}
 
 		if (ctx->reg_com_int & OCX_COM_INT_CE)
-- 
2.34.1

