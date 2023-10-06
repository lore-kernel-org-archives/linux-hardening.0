Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EF743687
	for <linux-hardening@vger.kernel.org>; Fri,  6 Oct 2023 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ce2kSLvT"
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE56C122
	for <linux-hardening@vger.kernel.org>; Fri,  6 Oct 2023 13:17:31 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2773af0c5dbso1915325a91.1
        for <linux-hardening@vger.kernel.org>; Fri, 06 Oct 2023 13:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696623451; x=1697228251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=44cFvtKqMAZFN6/2W4HaH3hNmYSsLMnAgOIOpwVomfM=;
        b=Ce2kSLvTFnCAoxEyE+73FFor074Illg7hBYKvjSCBx5BsA4SPxRHzXNfZEscBFObB7
         8CnkQkQTGQ74zGxOL6xzZzzSQvqotpH/8iSyVSP7A3udZjmTBv6+RgkpYQUy1BVTQNwV
         KLSRVd7WCTFHmXCoJymafz8uN06rx+NcVmelY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696623451; x=1697228251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=44cFvtKqMAZFN6/2W4HaH3hNmYSsLMnAgOIOpwVomfM=;
        b=FyHSa/8aatPFjbjsuZKfMy4tunlTm6RVMcLWO87LWg/STF+FYFQ3uIgLUKsJjWWNfl
         64cveJcx7HuOck5+Bm9fMABr+/Bwbr+6n1IFz1yifKW1Nhb5eOOwmNO55TFjvAlk6ak4
         /y73SxwvLQfRuy/DNC0m7w4yhbXtRbuwDKXK6nMz3WqW+h0uX3Zig8K/2yDfFSQOVJMF
         uVFHhwuJ2UdbQjRbezi2F4+TNPGmnra6dORTE1jMiTI3qKVOjp9UaXeAfIfBFWKvdOU8
         cPaX6UAmjosKydax64WeMlyd8n4Qw+j0xoJFiKgJYkIFfiEZ/cC63IY/QBQZ6Rn0GRGm
         VAEQ==
X-Gm-Message-State: AOJu0Yzm1GvlH5hNEVav40mNATZga7ilBOCicNmt2GrDD/j6iwI5SMFi
	N6lZ976XQMbLl8xJyVR01/jVgw==
X-Google-Smtp-Source: AGHT+IE8lO1ha8XBa5ezgrgQtzWsAVLftgkmKffd4oVNSVoxQYbXsRdlq6o27BW5+g4zJ9hXC4kqeA==
X-Received: by 2002:a17:90a:e98c:b0:268:414c:ff3 with SMTP id v12-20020a17090ae98c00b00268414c0ff3mr9383030pjy.23.1696623450927;
        Fri, 06 Oct 2023 13:17:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id rm10-20020a17090b3eca00b0026d214a2b33sm5865157pjb.7.2023.10.06.13.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:17:30 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Kees Cook <keescook@chromium.org>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Thierry Reding <treding@nvidia.com>,
	Roger Quadros <rogerq@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Chuanhong Guo <gch981213@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Li Zetao <lizetao1@huawei.com>,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] mtd: rawnand: Annotate struct mtk_nfc_nand_chip with __counted_by
Date: Fri,  6 Oct 2023 13:17:28 -0700
Message-Id: <20231006201728.work.750-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1866; i=keescook@chromium.org;
 h=from:subject:message-id; bh=wj52WE7CwlsQ2BB8Uem6TW+tv4z8geFWBQTRgq+pZr0=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlIGtYrtnPKsIg2iO4Dd3ybiJdrRew0N9KKrFWo
 eR191/wOjuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZSBrWAAKCRCJcvTf3G3A
 JjxZEACEq9RQuj5y0ShuaIfEUoej7S27zHMK5VDww5pUKfNkAzMupLwYOh2Yk6q7ltkpvX6IuWW
 ROopZqHz/SA0ETIcIKxfWi6DKM+3eaNFCK84JR573dTGlnCvAQEuzLRPoHp7gYUAc1voMXNV4Eb
 onEUUeNpgaVY1gO+a5QuSTDx1ZFLJpzhHf9AyuEJ1j4o4W7ftzF5ZOrXwh3m2AEcdNudTDX8sdt
 TZ2xWMWVUU96nOJ351JSEB2DYIQc9B6G2zPFUxsa5FcaCAn76Tll91uRAEcrn8ZIJUwEGFlZccG
 XWqPoVBzHp4HNxPVdE800NRDNHXVtIZ/7j43uOZPXxRzgdoIcKqScm6sbIAbXp0R1EmfwoYAwfW
 Nu4VRs3Ar1aLm0xV82hvR3gW6mSSiRLFzRxzj/fl415Q98XkwErnfKjkEmrFO0ox6U9JjwMM4Om
 gXE59HAKzBYeWuaGTg8Prfd706WGU9dX+bcmHkGhSjZi9/s5cjyliCYIlKW3SZ5/r8eVDT7U5eM
 Ul6QML+ml7X3z4kkuuJ+h/wDqoXcal+zei2gPVUMcumoxLw1LIC01d6WE/KJ3P8ubWfTWyLJmjp
 13WmQW8lobfY1U0km8vVLpbpnjq3XkQP3rmrzLF282/rrCfukJH1zYa43nf6BLyjap2Bi6hSY66
 4Z3lS7/ Aj1sqFAQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct
mtk_nfc_nand_chip.

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Cai Huoqing <cai.huoqing@linux.dev>
Cc: Chuanhong Guo <gch981213@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Li Zetao <lizetao1@huawei.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-hardening@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/mtd/nand/raw/mtk_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/mtk_nand.c b/drivers/mtd/nand/raw/mtk_nand.c
index 29c8bddde67f..60198e33d2d5 100644
--- a/drivers/mtd/nand/raw/mtk_nand.c
+++ b/drivers/mtd/nand/raw/mtk_nand.c
@@ -130,7 +130,7 @@ struct mtk_nfc_nand_chip {
 	u32 spare_per_sector;
 
 	int nsels;
-	u8 sels[];
+	u8 sels[] __counted_by(nsels);
 	/* nothing after this field */
 };
 
-- 
2.34.1

