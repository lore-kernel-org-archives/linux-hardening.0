Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFC0323E
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 22:54:48 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E6F19A;
	Fri, 22 Sep 2023 15:54:46 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 3330766072E7;
	Fri, 22 Sep 2023 23:54:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1695423285;
	bh=XiGG25R8t/0TrOGEzu39fvsV11Ywkve0IVC5a91JzE0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=It4tw2JOTdbzCUbYmG+IA8DGDqZRAPYLb8Fy7VdK6EVJChunRdm9MHcG+SDHfacDe
	 maXwbc4sZKmRset79M13WdN5MVEanMBDongHJlpuBeFmmXBBZJEeuAQrM0uRiLnrIJ
	 PYbovfyQZ3NOmVwTMQ35cS8ZDKWq/XtoiNvOIh1LNUP0hUJRhUxCYOsA2gYI/cRRyg
	 uqec9CBeg+PYlpt+BA+nxlOnJUIFhfAFHpk7Q36toGhqA8RHulsZx6ZFimi5YnyzAx
	 Dnolcukj2tfsDBWRpQKI2oltTzyyJJCavh2a5LUgEEdkdr0/gl+Os70/hDnEVS1H2W
	 wSQPVXCDF6pKw==
Received: by mercury (Postfix, from userid 1000)
	id 88CDA10611D3; Sat, 23 Sep 2023 00:54:42 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Kees Cook <keescook@chromium.org>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20230922175355.work.006-kees@kernel.org>
References: <20230922175355.work.006-kees@kernel.org>
Subject: Re: [PATCH] power: supply: axp20x_ac_power: Annotate struct
 axp20x_ac_power with __counted_by
Message-Id: <169542328254.1475988.11543607459604424867.b4-ty@collabora.com>
Date: Sat, 23 Sep 2023 00:54:42 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On Fri, 22 Sep 2023 10:53:55 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct axp20x_ac_power.
> 
> [...]

Applied, thanks!

[1/1] power: supply: axp20x_ac_power: Annotate struct axp20x_ac_power with __counted_by
      commit: 7daa3bd4b0b4de1446cd4e6a66bba022101ae9ee

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

