Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com [74.125.224.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD41382F1E
	for <linux-hardening@vger.kernel.org>; Mon, 13 Apr 2026 17:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776102682; cv=none; b=LDAqSjD2x1lqEJ1PB/KA2hmMkqSYuS0kcJIdN/ygQosCHWLkYeX5p6SWnbKyeZTsM+OjW+V0SSBy2R6OKfomMTUir9C7MMJh30iA/HHeexseHX01ThnHddga2lXVnfLLt6X8YG4ZAbTpZr3F6jaVw9hTj41Ylhnm6Ilo9OQBv08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776102682; c=relaxed/simple;
	bh=93I+Xu+Ho0+KJ1Wx9pdA3mEt2KEaHAtZqLLThZJyPGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dMX67WXfUZlhL2Kn/f7AnM9j8sRMs4XLu2ECSXP8m+WSFjFqMHlup+Ybnn1go9Ckr8qKkc8ONnOqcTPss5xVmScJhWsgdD56PZT5E9prw3O9WHSE3iFiKT5RW9cmCA33wCoszwp0/0fm4kiIfw7UBu8N/JjeZL2J8dqqG9LSq8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XlRkKdQ9; arc=none smtp.client-ip=74.125.224.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XlRkKdQ9"
Received: by mail-yx1-f98.google.com with SMTP id 956f58d0204a3-64d5a7926cfso4230050d50.2
        for <linux-hardening@vger.kernel.org>; Mon, 13 Apr 2026 10:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776102678; x=1776707478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWKO9vDsSjUTJZzAKzLLCDdYMLbrt3D+hRWkiFgwafM=;
        b=qZI8EVjTaFg02ffvNIpjo0aQKpgghsg6mHab9ZTCwKHKmQodNMamnZ6UmNXfwUQ+vg
         ipQZvsSoLuEFYiajqphNxRjkSUyehgjvVqQ9bpnW+NLTaXD/Fg6N3WPfYYmI2+Qwaf2T
         z3a/OlcbGWHcRDIpm5fYonpZt1qY6wEY6XCDu75geK5RS0FX8PcLjtaUMR3kyo/Hs8wP
         VbkBnO6SUs9zxQnmNcKtqXSXgKOzrD9ItdFkXh1vBo/nbJQG5/eylD4kS35+OTgfr74f
         rfC4xs68VfSmi4aKhm69Aj49Exf68DmIxjQgDmdi8vzVpi01vK6Pg1zzqa20KhFqhdk7
         3Kgw==
X-Forwarded-Encrypted: i=1; AFNElJ+IzYQjaQkexpHrupyzoHYvpAOPgkWtbd4AKR3TnjnpUVJhGURK7ojgzHTWDb0i7bNZnxgMdoql+dFToJ4/xhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ5QvrlEIvDpOcDGlwfeBNSoRdx1OF8KxJuVXjRmLkTwq21uXg
	fadV1qvel3YFD/SYt8QxJjKYNU6vQnRgzqKpH/DX0yntnBHFPFmzj60hu0rIGMJtlkUPCF2Ikr1
	Gt0+K5e0A6bSoGxe2o08ZHDbKJVKnZcGvVlfjN6mKN5z8+nznMH8cXsQXRTtqwnMzQjDeLGk4bA
	JdGITzyi4Ij2OApaxv2mTBbUsG0bc23ALpqzP1p6ZAF2SH/j49qwTdz9xdK65gdMgBOkGlpfufu
	KamN9KmWLctMS+1znaygw==
X-Gm-Gg: AeBDiesH7nofvwW0cVhVbXEwSe8mTJ4IZphEwSkqTfiCWnUpambKGfaoYk52g/mxy04
	YgE1kbL6xvVB0OldX7ZddFCRcsy2Oq9yCOEI/cdM8OfKfRmXyIYvPx3CUzN/ziaI4Gl7BaROWtp
	IsUiLZ09qmDaRW9ePK3fZFgbRwga+0Y2YToWqAYoxfuMT5AXag8d+cUZuaFp8bN82G4MydodlRE
	5rK9d6cU/pXhVpOJZ2eyYfZQRzubHdc91MXfO6uBv6jwXfM5440M8j+jonRqnwDN/ZgT3BHhWa4
	rVopK/aM1Z9RC6oZEUVGHsZH2Y+0Zoevda3eoVXLV0NCj9z1s7YLd9fyrd8ILQ6BNWIcCd2J1Aw
	OtnvCGp1sNj/lpErv+OAQT0k2uMf+SAqn8YBXk8+2pqfjheS6jjYhXovjGY0dnmDf5qkjzFufCd
	TAPSRfu0gLFQRgJRc+zBLLaB0/+XhSvATfEiX2EJ44yjh001KQQU16NYQ=
X-Received: by 2002:a05:690e:4011:b0:651:c7b1:d1e2 with SMTP id 956f58d0204a3-651c7b1d29emr5179463d50.37.1776102678150;
        Mon, 13 Apr 2026 10:51:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-651c912e411sm235719d50.12.2026.04.13.10.51.17
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2026 10:51:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2d9da2559aeso3541965eec.0
        for <linux-hardening@vger.kernel.org>; Mon, 13 Apr 2026 10:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776102677; x=1776707477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RWKO9vDsSjUTJZzAKzLLCDdYMLbrt3D+hRWkiFgwafM=;
        b=XlRkKdQ9iB92WbrwWAW2P9tluHDOzsvsOlnCqWriOUx1IiGBJodpFCmwVx97vQa2ii
         FyRqdoKDjnWufsiz6UXrhiVwxgJ/q1DzdYmuZCJReeMAXsTfdUmD+vFERZiLYY8JJI1C
         LLwBPcEFeTRiQP5hzF0vxoPp+pohSPWpl8YgU=
X-Forwarded-Encrypted: i=1; AFNElJ89JxH0gpIUQh6NZ2Iy1eqmASTkHQnxtDpJpqIoLW9XKXGZgWzTj0JF8jhFUeIb/xz2hGTO8djN1EZp1sFeu6M=@vger.kernel.org
X-Received: by 2002:a05:7300:cb0e:b0:2ce:f3d7:221 with SMTP id 5a478bee46e88-2d589463e5cmr8023458eec.17.1776102676853;
        Mon, 13 Apr 2026 10:51:16 -0700 (PDT)
X-Received: by 2002:a05:7300:cb0e:b0:2ce:f3d7:221 with SMTP id 5a478bee46e88-2d589463e5cmr8023420eec.17.1776102676145;
        Mon, 13 Apr 2026 10:51:16 -0700 (PDT)
Received: from [10.14.4.141] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d562db64c4sm17140089eec.27.2026.04.13.10.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 10:51:15 -0700 (PDT)
Message-ID: <f8ea0484-6f6f-4426-aea6-fc45f566f692@broadcom.com>
Date: Mon, 13 Apr 2026 10:51:14 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: bdc: allocate phys with main struct
To: Rosen Penev <rosenp@gmail.com>, linux-usb@vger.kernel.org
Cc: Al Cooper <alcooperx@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260411041252.166816-1-rosenp@gmail.com>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20260411041252.166816-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 4/10/26 9:12 PM, Rosen Penev wrote:
> Use a flexible array member to combine allocations and simplify code
> slightly. No need for a branch deciding whether to allocate or not.
> 
> Add __counted_by for extra runtime analysis.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/usb/gadget/udc/bdc/bdc.h      |  2 +-
>   drivers/usb/gadget/udc/bdc/bdc_core.c | 20 +++++++-------------
>   2 files changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/bdc/bdc.h b/drivers/usb/gadget/udc/bdc/bdc.h
> index 2f4abf6f8f77..cc961161eb46 100644
> --- a/drivers/usb/gadget/udc/bdc/bdc.h
> +++ b/drivers/usb/gadget/udc/bdc/bdc.h
> @@ -409,7 +409,6 @@ struct bdc {
>   	spinlock_t	lock;
>   
>   	/* generic phy */
> -	struct phy      **phys;
>   	int num_phys;
>   	/* num of endpoints for a particular instantiation of IP */
>   	unsigned int num_eps;
> @@ -453,6 +452,7 @@ struct bdc {
>   	 */
>   	struct delayed_work	func_wake_notify;
>   	struct clk		*clk;
> +	struct phy		*phys[] __counted_by(num_phys);
>   };
>   
>   static inline u32 bdc_readl(void __iomem *base, u32 offset)
> diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
> index 438201dc96ca..4b16b85da450 100644
> --- a/drivers/usb/gadget/udc/bdc/bdc_core.c
> +++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
> @@ -487,14 +487,20 @@ static int bdc_probe(struct platform_device *pdev)
>   	int irq;
>   	u32 temp;
>   	struct device *dev = &pdev->dev;
> +	int num_phys;
>   	int phy_num;
>   
>   	dev_dbg(dev, "%s()\n", __func__);
>   
> -	bdc = devm_kzalloc(dev, sizeof(*bdc), GFP_KERNEL);
> +	num_phys = of_count_phandle_with_args(dev->of_node,
> +						"phys", "#phy-cells");
> +	bdc = devm_kzalloc(dev, struct_size(bdc, phys, num_phys), GFP_KERNEL);
>   	if (!bdc)
>   		return -ENOMEM;
>   
> +	bdc->num_phys = num_phys;
> +	dev_info(dev, "Using %d phy(s)\n", bdc->num_phys);
> +

This feels like a step sideways instead of an improvement IMHO. And we 
are also moving the allocation and dev_info() print. Is there a reason 
to change the ordering?

Justin

>   	bdc->regs = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(bdc->regs))
>   		return PTR_ERR(bdc->regs);
> @@ -508,18 +514,6 @@ static int bdc_probe(struct platform_device *pdev)
>   	bdc->dev = dev;
>   	dev_dbg(dev, "bdc->regs: %p irq=%d\n", bdc->regs, bdc->irq);
>   
> -	bdc->num_phys = of_count_phandle_with_args(dev->of_node,
> -						"phys", "#phy-cells");
> -	if (bdc->num_phys > 0) {
> -		bdc->phys = devm_kcalloc(dev, bdc->num_phys,
> -					sizeof(struct phy *), GFP_KERNEL);
> -		if (!bdc->phys)
> -			return -ENOMEM;
> -	} else {
> -		bdc->num_phys = 0;
> -	}
> -	dev_info(dev, "Using %d phy(s)\n", bdc->num_phys);
> -
>   	for (phy_num = 0; phy_num < bdc->num_phys; phy_num++) {
>   		bdc->phys[phy_num] = devm_of_phy_get_by_index(
>   			dev, dev->of_node, phy_num);

