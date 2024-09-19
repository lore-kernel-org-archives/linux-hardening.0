Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EA1197558;
	Thu, 19 Sep 2024 07:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726732319; cv=none; b=i/RjnVQsxngi9fAXXhnXoMLO1/1QqtjBErAcKs0yKr5b/h8OGBXl1n6FxvDXO7li2O9RJPhLbG/HkRmr8Mj4OMmC14UnfYpNv6UWeyLXsrIiKx1W53JzH5B674ERLuGVzNpOPH/65xQFL7TN+oIq7XKTH0gq7RSiVftr6Ws33J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726732319; c=relaxed/simple;
	bh=SgvktaSbY1wXb2zaTpAsjhTPg5SD8FBxz6PlEsvj4Us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rLykzZlSd/SXlzZlBHNtLg/Wn3BlZwbsUY2Hc7VSPOazUJMXGKrf/HWMT00eqsnVE4vlyetyjtheyX+7mEkEU+p7HI2WsXZL6gfDoHZiTOH61pxLYWEtuQa1AjSaqppsd/Q8EvfXyBEvH7isVuPIN1o5JbT4o6qTFTsQwS8Fw7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=E30YBvZx; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="E30YBvZx"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726732307; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lTcVeuscBw7CVeUwxMc63YO9Eu03zbMzzUDs/m4Pfds=;
	b=E30YBvZxHrwrGRLdT9QH6iKAVuCnrvbn7pK4Ztf5zTFNahObvJTtB+vqaHhvtiDe2Pc2fGdYVv7Gq2BtQICHj06nCy5+ZAvNY0v1FT3GVYnFelsbDmhBa5bFb42KhSbsJQ2NY0xlUzzzwVqgwgmBwbp1ASejB5h5btSIcDWTVEg=
Received: from 30.74.144.121(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WFGzjNa_1726732306)
          by smtp.aliyun-inc.com;
          Thu, 19 Sep 2024 15:51:47 +0800
Message-ID: <6a689c83-24de-4d3c-afc1-107439f66130@linux.alibaba.com>
Date: Thu, 19 Sep 2024 15:51:46 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/drivers/timer-sprd: Select driver on ARM and
 ARM64
To: Enlin Mu <enlin.mu@outlook.com>, daniel.lezcano@linaro.org,
 tglx@linutronix.de, orsonzhai@gmail.com, zhang.lyra@gmail.com,
 linux-kernel@vger.kernel.org, enlin.mu@unisoc.com, enlinmu@gmail.com
Cc: linux-hardening@vger.kernel.org
References: <TYSPR04MB70840448562705C21BA8DCCF8A632@TYSPR04MB7084.apcprd04.prod.outlook.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <TYSPR04MB70840448562705C21BA8DCCF8A632@TYSPR04MB7084.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/19 15:25, Enlin Mu wrote:
> From: Enlin Mu <enlin.mu@unisoc.com>
> 
> sprd timer is currently available on ARM and ARM64 based devices.
> Thus select it for ARM and ARM64
> 
> Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>
> ---
>   drivers/clocksource/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 95dd4660b5b6..296c5f664583 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -494,8 +494,8 @@ config MTK_CPUX_TIMER
>   config SPRD_TIMER
>   	bool "Spreadtrum timer driver" if EXPERT
>   	depends on HAS_IOMEM
> -	depends on (ARCH_SPRD || COMPILE_TEST)
> -	default ARCH_SPRD
> +	depends on (ARM || ARM64 || COMPILE_TEST)

I don't understand, if this driver is available on ARM, why ARCH_SPRD is 
not enabled on ARM architecture?

> +	default y
>   	select TIMER_OF
>   	help
>   	  Enables support for the Spreadtrum timer driver.
