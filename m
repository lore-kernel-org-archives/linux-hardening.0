Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0605E30D418
	for <linux-hardening@vger.kernel.org>; Tue,  8 Sep 2026 03:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788836672; cv=none; b=l112WzTicHTeLgQQxjeCYy7DeYhweZZD2BNlvKYoSiHJh8kqZ4zY6f5PoMWhDZ9/DcHCZVzIGiQr6+9mDp5fbtct+9JpCtTYecmHgSNeuEGMSdc+gq3anKr+FUsnRpZsH8Iyk5FrLcV7RtjAHrJ6ZQgYAjASF6rfJeUbl34xOUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788836672; c=relaxed/simple;
	bh=1qe/woO8zybzb2TQkYQIHvFXXqzfTTIqj6TrnoCsGjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lG/fEpEt/BeLmcI9V08QxeFJmzx7OWeFoHJJftX1hrM5VwaThkA1Rajv1w5p4HwV9/fAb06IyeQYlLPbSOAG9w8j1pwJh0FBktvPY30AehRG3DHL1OZ3vfaJ7AIQDA+GhMb5eWLC+G6EaP2a/dEDJQ+FybES3TPBazSaWH8zea4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=B2cmRG0j; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="B2cmRG0j"
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id 3ddTxS9S5usRS3m8FxStHm; Tue, 08 Sep 2026 03:04:23 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id 3m8ExjY1AadLA3m8FxnJz3; Tue, 08 Sep 2026 03:04:23 +0000
X-Authority-Analysis: v=2.4 cv=Aqzu3P9P c=1 sm=1 tr=0 ts=6a9f7b37
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=Zo5euW2OAAAA:8 a=n92-qV7Ugmv0IUIatOIA:9 a=QEXdDO2ut3YA:10
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ROkla2LJMX0VNuCHtg9QFZ/+ccIHOqOJ+aiWXH5j+Wc=; b=B2cmRG0jj/RpW8XaSFuEKy3O89
	piPvZVZNJ+5qzM4fhvfgTASBPxFXrgRhnANgg9Or4iCoBqgmsfVS4Nk3nhJKkXUKgiun44WJzMFIt
	KQLiAb9fGxWE45Y1Y4PZIqANCLUE6eoeB5qjpqOxeSL2U5xXz5M/hnsX4LNL9AHIISasRxRIcmpW+
	WL96KXpF+GDNeo7pYhjxrpremSG+vnR0i7e08dMpP4PaDWgcCuIttot/Sf1fR4BxwHihWglIo5GMo
	qq2CldcCkowHLiQkqm5VPCqOBurtUmre+eeJBKXzO16BydJJKYRzwU6avRuBaH1qc32UwnXMOJCs0
	29VUuOnA==;
Received: from flh4-125-195-69-90.tky.mesh.ad.jp ([125.195.69.90]:57288 helo=[10.203.100.33])
	by gator4166.hostgator.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.5)
	(envelope-from <gustavo@embeddedor.com>)
	id 1x3m8D-0000000257t-2CoX;
	Mon, 07 Sep 2026 22:04:21 -0500
Message-ID: <b5f44a35-52d8-4197-ac85-73bb9dd0d11c@embeddedor.com>
Date: Tue, 8 Sep 2026 12:04:16 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: ipq-cmn-pll: Assign .num before accessing .hws
To: Aamir Ahmed <elb12345@hotmail.co.uk>,
 Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luo Jie <jie.luo@oss.qualcomm.com>,
 Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
 stable@vger.kernel.org
References: <AS8P251MB0001B905088748016A0965F1C8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <AS8P251MB0001B905088748016A0965F1C8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 125.195.69.90
X-Source-L: No
X-Exim-ID: 1x3m8D-0000000257t-2CoX
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: flh4-125-195-69-90.tky.mesh.ad.jp ([10.203.100.33]) [125.195.69.90]:57288
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMXHeDDcKaYmSBrBs72tijV6VGX33qDH3RrPU4Qfqx3anbL3vBwoZTcuAcGqzL/SCyBV9z8Fr7M//gtXIwQzCavaOMF7WviikxAO8D4QPx06tCCftBYR
 4i6rp7056JK3NJ7hrmgJE+djVx94Xvl7RdIKHAsVoUbI/dtmqabZ6k26pWur8FFtGwD4OmMgDiP77oRExRKQzrzwgDK9REq4/sOv7lcaWY4tJMAPOrwn7rC4



On 9/6/26 05:48, Aamir Ahmed wrote:
> Commit f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with
> __counted_by") annotated the hws member of 'struct clk_hw_onecell_data'
> with __counted_by, which informs the bounds sanitizer (UBSAN_BOUNDS)
> about the number of elements in .hws[], so that it can warn when .hws[]
> is accessed out of bounds. As noted in that change, the __counted_by
> member must be initialized with the number of elements before the first
> array access happens, otherwise there will be a warning from each access
> prior to the initialization because the number of elements is zero.
> This occurs in ipq_cmn_pll_register_clks() due to .num being assigned
> only after the fixed rate output clocks and the CMN PLL clock have been
> stored in .hws[]. If registering one of the fixed rate clocks fails, the
> unwind loop under unregister_fixed_clk reads .hws[] while .num is still
> zero as well. With CONFIG_UBSAN_BOUNDS and a compiler that implements
> __counted_by (GCC 15.1+ or Clang 20.1+), this triggers an
> array-index-out-of-bounds report during probe, and with
> CONFIG_UBSAN_TRAP the first store traps so the CMN PLL clocks are never
> provided.
> 
> Move the .num initialization to right after the allocation.
> 
> Cc: stable@vger.kernel.org
> Fixes: f81715a4c87c ("clk: qcom: Add CMN PLL clock controller driver for IPQ SoC")
> Assisted-by: LLM
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-Gustavo

> ---
> Found while auditing the remaining clk_hw_onecell_data users that assign
> .num only after touching .hws[], following the fixes already merged for
> clk-s2mps11 (3e14c7207a97), exynos-clkout (cf33f0b7df13) and
> clk-raspberrypi (6dc445c19050). The audit, the fix and this changelog
> were drafted with an LLM assistant and reviewed by hand.
> 
> Compile-tested only (W=1, no warnings) on x86_64 with GCC 13.3, via
> COMPILE_TEST with CONFIG_IPQ_CMN_PLL=m. GCC 13.3 does not implement
> __counted_by (CC_HAS_COUNTED_BY needs GCC 15.1+ or Clang 20.1+), so the
> build only confirms that the change compiles; the sanitizer path was not
> exercised. I do not have the hardware, so this is not runtime-tested and
> no UBSAN report was captured.
> 
> Based on v7.3-rc1. Checked against the pending IPQ5210 CMN PLL series
> (v3, 2026-08-14): no changed lines overlap, and the fix is still needed
> after its first patch removes the unwind path.
> 
>   drivers/clk/qcom/ipq-cmn-pll.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/ipq-cmn-pll.c b/drivers/clk/qcom/ipq-cmn-pll.c
> index dafe8c1738d..a9abad9ff4e 100644
> --- a/drivers/clk/qcom/ipq-cmn-pll.c
> +++ b/drivers/clk/qcom/ipq-cmn-pll.c
> @@ -380,6 +380,8 @@ static int ipq_cmn_pll_register_clks(struct platform_device *pdev)
>   	if (!hw_data)
>   		return -ENOMEM;
>   
> +	hw_data->num = num_clks + 1;
> +
>   	/*
>   	 * Register the CMN PLL clock, which is the parent clock of
>   	 * the fixed rate output clocks.
> @@ -406,7 +408,6 @@ static int ipq_cmn_pll_register_clks(struct platform_device *pdev)
>   	 * is configured to 12 GHZ by DT property assigned-clock-rates-u64.
>   	 */
>   	hw_data->hws[CMN_PLL_CLK] = cmn_pll_hw;
> -	hw_data->num = num_clks + 1;
>   
>   	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, hw_data);
>   	if (ret)
> 
> base-commit: 654ae5d73c05bd2943d65636ce6cd0aa46e62f18

