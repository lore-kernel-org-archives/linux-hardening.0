Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B0943687
	for <linux-hardening@vger.kernel.org>; Fri,  6 Oct 2023 20:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ULKnwnb8"
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684ED111
	for <linux-hardening@vger.kernel.org>; Fri,  6 Oct 2023 13:17:37 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-694ed847889so2244317b3a.2
        for <linux-hardening@vger.kernel.org>; Fri, 06 Oct 2023 13:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696623456; x=1697228256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SVW48+aAw5RrT5lkfRy3SJYTnhGkwarT0QT62F6zY44=;
        b=ULKnwnb8G0N3lbHYsw1zCXa+eYk4VmkMVui/kjGkhAmncYHkwlnhpKoD/fflMOPVP4
         kcTWJnkGVEZO743tx48QyvflU06THMOT/epv9UXja9O1nRJUwDSsS5iyBlpy8yLOCeSY
         ktT1bAv0qE7zg6MfJXt8jHC9feQeXTGKTGFOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696623456; x=1697228256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVW48+aAw5RrT5lkfRy3SJYTnhGkwarT0QT62F6zY44=;
        b=b8mmchFGx+gm3YyxbnP5JjeNGpQqsY5RWWz7uTu0QzPbX5Ltwjp7BvFq/oUta2ofCr
         xRXBKLdnf/c9dtJrn6L58/mXhBAHbGmKG53pDo+eCmPMVQFVfCcQyXRAAXzzo1CQRLxB
         wTfAQmd4PAl2k7hiECjuUR8XeLd0OkQsPfT+PLRSoHswnYEn7XEDytdAomVouID5Ls5F
         DsLDYbTBGgXSxlv5anmaoC2ENzqIOWUDXPwIjgFYK+fMNOkaR49WvfFXrzw/12D41egk
         FumbF17F5O+4uB9q5jw8glDuyzL4GF6unshSSBKCWGKEc962MjaeGYk/4C6M4ke2RtlO
         wNQg==
X-Gm-Message-State: AOJu0YwHASxguPNXF7PzdXbfmqGGejwPGvbOi00f6aUJSic5qE3BIlok
	aOzAzdGK8kot8G27L2GhffLTwg==
X-Google-Smtp-Source: AGHT+IGgULuRMAk+2xAiqAngtQMYH/45dfkfgIQakgeEwSnSB9Ck2fpTw3sOiYnEFueq2+Zw0HIj5g==
X-Received: by 2002:a05:6a00:1d89:b0:68f:c6f8:144a with SMTP id z9-20020a056a001d8900b0068fc6f8144amr8344041pfw.22.1696623456614;
        Fri, 06 Oct 2023 13:17:36 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g29-20020a63375d000000b0056c2de1f32esm3761746pgn.78.2023.10.06.13.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:17:36 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Kees Cook <keescook@chromium.org>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Roger Quadros <rogerq@kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Valentin Korenblit <vkorenblit@sequans.com>,
	ye xingchen <ye.xingchen@zte.com.cn>,
	linux-mtd@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] mtd: rawnand: cadence: Annotate struct cdns_nand_chip with __counted_by
Date: Fri,  6 Oct 2023 13:17:34 -0700
Message-Id: <20231006201734.work.060-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1719; i=keescook@chromium.org;
 h=from:subject:message-id; bh=v/mBW37FRWiHDbQSeKGRt7jHSIbBK2m2caz2GN2pAMs=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlIGtehhtNs4fsQLlK/idmpyBfIyy3VLPUCxgiM
 uN0LPqd+ImJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZSBrXgAKCRCJcvTf3G3A
 JkStEACSGTbTsp8zz1atoDGJhIXcLq7dkczKkpuqx43dYR8vq3nM6javyZ6DU7cAg2OhRoAplw0
 mA8jHnMFQixkl5LkbmCfoRytUqgJCK+dMCySAAPwBp9IItFtaqczmNI/I6/d/gDJvtqQQep0jSk
 PW0HSCeEDsFzX/CdW0t6C1dRPVu7gddhQI2dT1KUMTLPghKqCKjqgUrKfruh+yarpwMIKUmhV3X
 rklM4b718lqThCqUPASeb/zZeCoN3g+MQAmL5MM3Vf9Vtx780jFE4SHxFwk+do0CrYsWhTxO9a4
 8FNOJNfUrv8dasPXCafK9pQxYkzRE4lKjDlKWPbrzSfelocXGryBNFQPiOTkAkRMf3RqiNh2GCR
 z8QM/L+lmF4dv//gnu3oXL3ds1MRzA8FY5nKjYoduHvOOsVDQTEx+B+4XPa6vTmDxWk68HDhoOV
 CKOyMtZUCdXdo7dGXx+OhYtsFT/beclrvneNK+WXJJ8DAXpxRJYlmCGfmAV1/okr5oEOrE8U8ru
 cshkana+HpzpbJuzw28HhcouY+hWSF2Clzt6FUws6hL+evFTv6yEopyovGmCakC3k2VR5UMumZ7
 MvA//yU5JMxP7SDbF30UVevcNuhKSu2LoEBaAp4CJ4xAJzaBrUaKqgdOogIP6IIGac0nANokUqs
 9OfVz+T lNbq/PRA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct cdns_nand_chip.

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Valentin Korenblit <vkorenblit@sequans.com>
Cc: ye xingchen <ye.xingchen@zte.com.cn>
Cc: linux-mtd@lists.infradead.org
Cc: linux-hardening@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/mtd/nand/raw/cadence-nand-controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
index 034ec564c2ed..7d5ef7ffe0fe 100644
--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -526,7 +526,7 @@ struct cdns_nand_chip {
 	/* ECC strength index. */
 	u8 corr_str_idx;
 
-	u8 cs[];
+	u8 cs[] __counted_by(nsels);
 };
 
 struct ecc_info {
-- 
2.34.1

