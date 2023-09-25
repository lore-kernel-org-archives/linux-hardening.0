Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998FB224F0
	for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 21:37:12 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B322124;
	Mon, 25 Sep 2023 14:37:11 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E7FFFF803;
	Mon, 25 Sep 2023 21:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1695677829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nuNfFTwUasE9driIawJgjbLk0jLXch2OluzLAsaE/Oo=;
	b=UovMQhtl5npjGodKIzL9u/KvUv8aWeHtFvX+u8fGIUglJQllI+5VwrY0rVTJFfL6/5QcSj
	gvIuEGVlhpNwD4zchohwb6MMpzwU3KlQVnM7YC5J7c7oU/TnznmQjvRPi7e0kI8vmywBiN
	ea67GNb5QS/0skIojiAIEOT7fMx+hwhoszV59romJYJOLy+VIRyZMC5nlR+p9jAF+XwZze
	IJvCTxbB+HJ/LXffrnCi3+Npn1rpBAxfqvo4nle0+T0EH2MNxewOY9A1I7dQbkT8txnDz2
	5JgVAKVva0xdUA4kbTX4gkm9BnqLtcQBhihCDvLDdMsAf20s/ztP3UTmuEJYng==
Date: Mon, 25 Sep 2023 23:37:08 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Kees Cook <keescook@chromium.org>
Cc: Nicolas Pitre <npitre@baylibre.com>, Len Baker <len.baker@gmx.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	linux-i3c@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] i3c/master/mipi-i3c-hci: Annotate struct hci_rings_data
 with __counted_by
Message-ID: <169567773739.243402.8781052948359275071.b4-ty@bootlin.com>
References: <20230922175019.work.129-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175019.work.129-kees@kernel.org>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On Fri, 22 Sep 2023 10:50:19 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct hci_rings_data.
> 
> [...]

Applied, thanks!

[1/1] i3c/master/mipi-i3c-hci: Annotate struct hci_rings_data with __counted_by
      commit: 751d377f0f7a09d6122de0e2232133524568c52b

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
