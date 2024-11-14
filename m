Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495FE1AAE33;
	Thu, 14 Nov 2024 23:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731628521; cv=none; b=HvnepDiudbw67ZP7kQ9CFCjrR4psh/UUdUBteSoDMpDA5NBcq3yqcjbGkOO2sRK9m7R6wXNMeMqXKiskzCPPEy1yVdQit7MBzalG07EAfcj8x9QAeVfNUvnewoit1dC+OPGea0sMctKavrnXH/dJe+hW3ol2xIx/Vp2Yt62EZn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731628521; c=relaxed/simple;
	bh=zY7KhF5ZX6coU8ApPUSZ3x9v5eBGEmYIOjd4V8VjVMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uZ3q2fVWjFKh/x6c2g1B6K1QVWe1x/TJf5KaVueCi/TxkL3DibL4SKBi7gV42BSqIwRiUxhSSo2iRhCeRSvo1DPkriFDVm8ThBGXeK5y55D6yLjReiKVMfLB1KA6Mhxkr/Wq4Auhjx4OfUs4VYEc7ewKjNMevinHJ0VrFCY2BhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqrylpHT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqrylpHT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F74EC4CECD;
	Thu, 14 Nov 2024 23:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731628520;
	bh=zY7KhF5ZX6coU8ApPUSZ3x9v5eBGEmYIOjd4V8VjVMQ=;
	h=Date:From:To:Cc:Subject:From;
	b=lqrylpHTmcapjRxzWJzvgZOkZh7UczariR30ksY+iYDhhN24qABUl0bRslUOUj2MZ
	 Y6ypVn3YkCl5Yhcc/Xu0/pjf+Z70iyyPXiri33nQNC35wIi+eubEuV9/CRvbh+9Bnk
	 /g28Q8YTJVqzGiCWGvo3wipqJvQjrKxe+8nFuAW6Us2s8EVcdWyzMrCE+HboP5xB7J
	 b2Qce2D1Q5IQm0p906Ot2tKqC+IAD1iOPRE7OEQPUmIykJDR59x1gouWe4nnwrKjxr
	 xux7pc+o+xNbDRhGFf17mcRZLbBSrdDOmJi5LgLXsL+3dzJEtWMjwNgmQYGODr1gnX
	 +aqK10fhU3hJg==
Date: Thu, 14 Nov 2024 17:55:16 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Yinbo Zhu <zhuyinbo@loongson.cn>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH] clk: clk-loongson2: Fix potential buffer overflow in
 flexible-array member access
Message-ID: <ZzaN5MpmMr0hwHw9@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Flexible-array member `hws` in `struct clk_hw_onecell_data` is annotated
with the `counted_by()` attribute. This means that when memory is
allocated for this array, the _counter_, which in this case is member
`num` in the flexible structure, should be set to the maximum number of
elements the flexible array can contain, or fewer.

In this case, the total number of elements for the flexible array is
determined by variable `clks_num` when allocating heap space via
`devm_kzalloc()`, as shown below:

289         struct loongson2_clk_provider *clp;
	...
296         for (p = data; p->name; p++)
297                 clks_num++;
298
299         clp = devm_kzalloc(dev, struct_size(clp, clk_data.hws, clks_num),
300                            GFP_KERNEL);

So, `clp->clk_data.num` should be set to `clks_num` or less, and not
exceed `clks_num`, as is currently the case. Otherwise, if data is
written into `clp->clk_data.hws[clks_num]`, the instrumentation
provided by the compiler won't detect the overflow, leading to a
memory corruption bug at runtime.

Fix this issue by setting `clp->clk_data.num` to `clks_num`.

Fixes: 9796ec0bd04b ("clk: clk-loongson2: Refactor driver for adding new platforms")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/clk/clk-loongson2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-loongson2.c b/drivers/clk/clk-loongson2.c
index e99ba79feec6..7082b4309c6f 100644
--- a/drivers/clk/clk-loongson2.c
+++ b/drivers/clk/clk-loongson2.c
@@ -306,7 +306,7 @@ static int loongson2_clk_probe(struct platform_device *pdev)
 		return PTR_ERR(clp->base);
 
 	spin_lock_init(&clp->clk_lock);
-	clp->clk_data.num = clks_num + 1;
+	clp->clk_data.num = clks_num;
 	clp->dev = dev;
 
 	for (i = 0; i < clks_num; i++) {
-- 
2.43.0

