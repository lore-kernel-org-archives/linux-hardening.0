Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4214C947B
	for <linux-hardening@vger.kernel.org>; Sun,  1 Oct 2023 07:44:13 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB72C2
	for <linux-hardening@vger.kernel.org>; Sun,  1 Oct 2023 00:44:11 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id mr7WqrKgVBuYSmr7WqgwKV; Sun, 01 Oct 2023 09:44:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1696146249;
	bh=Lh4Gb5zv5Lb8ZWaUBSVtVqXkD3aAwWj7aSRzIFudknA=;
	h=From:To:Cc:Subject:Date;
	b=tARfd9pL5l6goRYfpkXD4TKuCYNR9qfYDZclZw2NvhvzAI+6L1i/4samAyFBMaPqA
	 keFShjXpLMdUxQJLMBQE9F0nMNs8RC+WNlUr4mhQ3RCNAtmmjGRFMhembtafGCGiwN
	 IzUX2Xav5NVCBinR1CnJxRnvNoivk6mwZP9xCIRORrRXCiw62bIPTYwn9sV7/F1VWl
	 uWiknbsaq/hJbJ9U2dV5iufGtW1YI6XsfsaXEzrOrBB+sDkpa8zCh4uXtmS/kuJ6Lf
	 QPjOrtfjXWuYsTC1xHnwSC15nQZBrmP0Xwc8fDzvKhuA3h0OAti6wtH5cjNLen9CrV
	 rx8jRh5pe69xQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 01 Oct 2023 09:44:09 +0200
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] mtd: rawnand: rockchip: Use struct_size()
Date: Sun,  1 Oct 2023 09:44:04 +0200
Message-Id: <481721c2c7fe570b4027dbe231d523961c953d5a.1696146232.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use struct_size() instead of hand writing it.
This is less verbose and more robust.

While at it, prepare for the coming implementation by GCC and Clang of the
__counted_by attribute. Flexible array members annotated with __counted_by
can have their accesses bounds-checked at run-time checking via
CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
strcpy/memcpy-family functions).

Also remove a useless comment about the position of a flex-array in a
structure.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is part of a work done in parallel of what is currently worked
on by Kees Cook.

My patches are only related to corner cases that do NOT match the
semantic of his Coccinelle script[1].

In this case, struct_size() was not used to compute the size needed for the
structure and its flex array.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
---
 drivers/mtd/nand/raw/rockchip-nand-controller.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mtd/nand/raw/rockchip-nand-controller.c
index 5bc90ffa721f..596cf9a78274 100644
--- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
+++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
@@ -158,8 +158,7 @@ struct rk_nfc_nand_chip {
 	u32 timing;
 
 	u8 nsels;
-	u8 sels[];
-	/* Nothing after this field. */
+	u8 sels[] __counted_by(nsels);
 };
 
 struct rk_nfc {
@@ -1119,7 +1118,7 @@ static int rk_nfc_nand_chip_init(struct device *dev, struct rk_nfc *nfc,
 		return -EINVAL;
 	}
 
-	rknand = devm_kzalloc(dev, sizeof(*rknand) + nsels * sizeof(u8),
+	rknand = devm_kzalloc(dev, struct_size(rknand, sels, nsels),
 			      GFP_KERNEL);
 	if (!rknand)
 		return -ENOMEM;
-- 
2.34.1

