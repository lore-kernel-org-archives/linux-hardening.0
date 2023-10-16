Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903D51A5A0
	for <linux-hardening@vger.kernel.org>; Mon, 16 Oct 2023 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OaZh3V0r"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B595CE6;
	Mon, 16 Oct 2023 02:29:04 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB9DC24000A;
	Mon, 16 Oct 2023 09:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1697448543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TuNlvIpMbf7XAhkSz7avcE0kB/TU7asqjzSOyPcOKqM=;
	b=OaZh3V0rsK90e4ilUI5miK/f+Lz5ZQ+hE1Q33BJcULlt6z/XTXo41wgmizD0KdSfi209Ek
	p0Cr5yKogYu/nL67vGtqi4qRPV3PB6PSiAswfhLp+ywFIdZ6cHmJ08gW4QD2jXZvkV0Vzv
	PU+UPl2f98Kyupf0XBmvd9XKf+aFCjHLcBcbPxsu8bULmgFc+EirZ6xHCwkZMvpyvH5Cfo
	5UgN47FOZEAke4AKyZ4j1KSleEIaehPb1aN/QzGrr8AisruQfFBY8NLcera/tE++ER0k8V
	Ai0x0hksV04y7nKXVMks4tAybjLgvWOFBtckTmja/GNFiifFGssiPL5jU3KgUA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Kees Cook <keescook@chromium.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Roger Quadros <rogerq@kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	=?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
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
Subject: Re: [PATCH] mtd: rawnand: cadence: Annotate struct cdns_nand_chip with __counted_by
Date: Mon, 16 Oct 2023 11:28:59 +0200
Message-Id: <20231016092859.289086-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006201734.work.060-kees@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'4c1f363777ac8fa7c54a408868b6f88c9795ef59'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-10-06 at 20:17:34 UTC, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct cdns_nand_chip.
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Roger Quadros <rogerq@kernel.org>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Yang Yingliang <yangyingliang@huawei.com>
> Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> Cc: Valentin Korenblit <vkorenblit@sequans.com>
> Cc: ye xingchen <ye.xingchen@zte.com.cn>
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-hardening@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
