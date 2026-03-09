Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011005.outbound.protection.outlook.com [52.101.70.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC9A274B39;
	Mon,  9 Mar 2026 06:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773038952; cv=fail; b=Vz9/wQfpHP0PZ48DTb14dHWV9C1OZQ0rS3u306++wb2E1uXu/TqpNQRlmZXaYXddq0P9IL8bUfNB6b+IzHIkBZAuDhSfPqzr3ZSB0LJgcs3YNkoO82Y5ht6U0+TAqfin9R/c0h/8puNo3HIpkXXV+mx91zcqy8Z20/zXm1vKZrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773038952; c=relaxed/simple;
	bh=Gvkz6z/J1iEcIwmkmYC1SsrmTEb4mEaAlihWYZY0lGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WvXXXrbVd7QMX5wVzrH11h4QfIiwjQevylFmI2Iacx3AVRNw7753AMxzc+gjvj64Say1V5B3kBh7qWV5WdE35w6u3aKwfJtRffu7mtVPWQOsxM+w7fevWNbtFr5i7uSJHLbpgeXxqrAvo1DbF3AuxGAGfNZbCUpyU4vLpbpGGuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=hSlCY1sY; arc=fail smtp.client-ip=52.101.70.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="hSlCY1sY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ana9S4hrWBDe1PlkvOKc+tqmLpuHkoXJnObRWuzNWTr/G3JlJkhNIx/bj0Kzka8jH2YPGrLcKW+O5Wy1vn23XHHa+n+lAg6rWni9iev1v9t76DmhyzHhr2NbyMhutqQrtX1/HbsV1/aQ1jP1oS3ILLUCuZOL+h5IZ2lEwhFR1viXpE/yBj0CNoY/NhVEukXUECHhUY+KdvUWOzb+w6v+f5i3mJ/d+gtz8dqcSI0DEg+WMmH0JWDZijX97XO5D8bpC8kDn7u69J/3hmROIOyoLuGJ/uHBMKT4nqKM56FDntu1A6Ycw7mwhOAVUcvUWyhMTdJMC0rTSqHj/hApY+Pnzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVVXAnIRVaSxFm5PMF+o7ZkokKwZJQ09G10aHMWjxe0=;
 b=uoBzFHHyf4cgp1ZwkvwkQAapI/1a0ZEfNXhUsx3WY7nSUCBLin8Avex7GvCIUOu6SiqpOTnWGSb5msO2Kgm1iHEo3PsD3lGt7VehIq35ERPUd72gOZqcDGA1zUMyfcQfyJpHtIpLClxchuxhCbP+b/8lYNjmYMDeIJp6W585lFsDMAcdFCNzPUsgVD0qLiI5x8fz8Hp/6kYAGuH0V7rKShL+2aXbjQwA4s6vHWEkap5EWw5/4tIDrTpTKcnFGVs+jP59rKGd+T6biAOw1umkZAnyrvsjdaUWoW+H7mS5uuuz9HqRqjExp8E4e141fvszn1dMuSl026/nRUzsTp1drw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVVXAnIRVaSxFm5PMF+o7ZkokKwZJQ09G10aHMWjxe0=;
 b=hSlCY1sY9QMv5oit4Sj3oSwV5jMCnxedne7tJUpnH5drQ+l34WThQzP1PuyXPgpKn+2N9cruT+erPy/1cCpmxQEmWHirc36/UpzBxFOKEBjVVOtBRgutYjFbcPU7LlqGHtSsVaAH00KUmdgi8I0iQHt4ZQkcM+L+zw+sneCduYsimFjMnb/bErnxDjOjUiPfDAjhaqGbSIbbQNs7swreMgRITWCSom0b/MBU2OkNAaK4M7yiUtnoqJcp+3j6K0zMf/2UhbLEtKq3Ldfjin5fz3+I8mQlaRn+1rrLvMGYXsa6x5XXNGUbaYb1zhUGFFsIk/CqmTsD/45zrY9ySKaPmg==
Received: from DUZPR01CA0264.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::20) by GV2PR10MB6209.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.22; Mon, 9 Mar
 2026 06:49:03 +0000
Received: from DB1PEPF000509FE.eurprd03.prod.outlook.com
 (2603:10a6:10:4b9:cafe::51) by DUZPR01CA0264.outlook.office365.com
 (2603:10a6:10:4b9::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 06:49:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509FE.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 9 Mar 2026 06:49:02 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 9 Mar
 2026 07:51:29 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 9 Mar
 2026 07:49:01 +0100
Message-ID: <70cf60db-52df-481c-881c-5b63959876d6@foss.st.com>
Date: Mon, 9 Mar 2026 07:49:02 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/2] phy: miphy28lp: add COMPILE_TEST
To: Rosen Penev <rosenp@gmail.com>, <linux-phy@lists.infradead.org>
CC: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	open list <linux-kernel@vger.kernel.org>, "moderated list:ARM/STI
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open list:KERNEL
 HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b"
	<linux-hardening@vger.kernel.org>
References: <20260306222457.8400-1-rosenp@gmail.com>
 <20260306222457.8400-2-rosenp@gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260306222457.8400-2-rosenp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FE:EE_|GV2PR10MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: dd51eac0-7205-4c79-8ffc-08de7da7f357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	0clEI7yc/JE6rXnjny8XrjhBfDL/+FgQM0u03TM9azAwqgxzTc+JOEVpPYO4KaLu02V0xQ6R23vqbYHiBdbmuwZTeGoDAFSQK+l/G8aD3srYtudhqOrJmAEAwwVleSbQ8OigCuLfRvZARx02QCFpt286C82t66III7QVuxM1fjytTvzAR+win59NUdm1BkkMz+HMuJkjjW890NxpebCYGXhbJgxhAcQUkAvI7vUaZh+8CLNpNP4VKi74gRw8H5i64UfdtE5OfPZH16fXNxI0NzhHiCHRw8WUiFUGxu695kfY16Gp5ZPt+wLTiOv/88GmKmVUFlCvtvRt/wgjsv2E2LDX17G/QsAco4YAAijYaSNOOTHEO5ILhj9zve8Oq66J9x+un2bwIC0kx7U5Gwe89MtvssMdAOwWb5hnMB1kaHZQ7YAF7CMfOLMMVgnnXEXG+L5cO/EQsvYQbT16NOC6CNgx7/FUayv6OvL+F/DvDAGiXNnMmq7shzypl/cGDzmGfr67wpVRjqAykE2gCpPMixalaAK9DY2gLkeH1MYVfQxmguc9x7a8JE/KBYWYEhj12pm4JEJbGjYYCrRussYu78Ek/hYKZKX4QXqzexwKV1s1UAt9ANC6V0Xd4XG0PWK/xNYibph5RHKgRZf8mlLbMzPdSdZuM1UXe1Qy+szahXGBMKO1vSfnL+M5Wt8mhfwgrqg9Bp93E/D1/NWQNHoOFN7wuBBG2mhprp+rPACQmf3/tMfxlmptEIn3suOzGLetJ/r2FwlMs6E5/JYGmsAd+g==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZWpd0lI+0oeLmU2iBRVe6HxgiYw6ztMYuhK2OSTGfywbKBC3F8mC7OCDRCHWHVRB+Z5FqIHo49bMLMbrVR2pcmzr9fKJGn7tsKRf485LU9iyYGsW5TU2jVA5p5UEHOZ8XVJS2CFKlJ6wB74Al1O98VMNOujMfq4KfIDMWU6GVRSDkzNVZaG2BrNS+2cVcw5yxe7Z2dhx16xfkEcjvdkxeiHSATBULOELMBFf0Rqv/NxnQxSa0EtOInSh2zdURzZjamHKG2UVYMypeddxOlIW2epD6z0lVN7x1+GWD7tsULLAIegM+akXTIptGGa0mi6j9sEoyIV8E8nQAeDtj4KFyhPt1Agw12j3otBJ5FBqKVVI3etCFCzv48uxbmPUyaWPi5bbn1wpJqPlzMflyPsfHZWN76PYCuizkGceVTHWg+JCECrnIu/ye88plS3U7oQ4
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 06:49:02.7733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd51eac0-7205-4c79-8ffc-08de7da7f357
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6209



On 3/6/26 23:24, Rosen Penev wrote:
> There's nothing special here to prevent compilation on non ARM hosts.
> 
> Matches every other st phy driver.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/phy/st/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/st/Kconfig b/drivers/phy/st/Kconfig
> index 304614b6dabf..49206185e563 100644
> --- a/drivers/phy/st/Kconfig
> +++ b/drivers/phy/st/Kconfig
> @@ -4,7 +4,7 @@
>  #
>  config PHY_MIPHY28LP
>  	tristate "STMicroelectronics MIPHY28LP PHY driver for STiH407"
> -	depends on ARCH_STI
> +	depends on ARCH_STI || COMPILE_TEST
>  	select GENERIC_PHY
>  	help
>  	  Enable this to support the miphy transceiver (for SATA/PCIE/USB3)
> --
> 2.53.0
> 

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
