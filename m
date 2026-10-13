Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010038.outbound.protection.outlook.com [52.101.69.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6B754B1DB;
	Tue, 13 Oct 2026 21:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791928790; cv=fail; b=iYCrHU57rkR5BGp3quLZoIxbZeQWUpiw7at9X33g4RdrJbGNeXyLDDttp3WubLEBhCBdTAMTzgX/gnEj3q0v5PMLetknD7oj/CkgLM/0eU2mjHMFNoB5MMOnfbJuWxerElAlWLNIGd2BpRCxXmV0Rmm2CEplkCqJ2BKeRe895vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791928790; c=relaxed/simple;
	bh=Y02WAg9LkfZrWNA+yr+r/LEs+bB8gG44YFIg1oZt3jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QpfNJUYUN8rs8j4qp2nEIxgcn1jjFA8PPeBDI2ry5c6yNtNIAcmwCbWMOuyYstGGyt+ZRu/F/AToctp2g+5L3a6RWcvyhSTF7Z1bLTpTtlvg8YADcdqFHgwvj9kFNIQAPAyIuIsOAYKRrVUh+i8/T2bSx/X4MrxQ2dcLis17JI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=tRmUfM1s; arc=fail smtp.client-ip=52.101.69.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tRmUfM1s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LU/cj1MwpCoIWPXkaPefEwFRqbzDIZaqae297G0b9ou1rLtwfN+ioL4Gz94TO/XXlj1J4NEwbSSPz7mM6YqGPD2qHTLijulci9fn8QLXp1eEzjO3Ks35CROtV7gs/mpSLflnrxv3aWt27YvlgQr0KN4+w9zXmJ6M1SOb/ouvEatyijURFI1adHn8USzz+v3fon02KitosmVy5rgamwI3UrPt9RYAm2yryhMBkwOJzHSO+cK1VrCKm1VC39Pe1WWbkRCPP7Pi0ygm9ODylw9DeV5iBx/gheSJ9e4dNAZviG21qLPzo90+ADqd96gxbxoJZjA74nxBshBThYUzrK1G+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nhe/wjFUoCvty8LtSdiyp7x3mNmPZQcjb6dPJtToQNQ=;
 b=CkPsaf9vlMlC+JQc3NDJjy3EQrDqTxfGr2Ca0ui7DMZjgIhBfxUViY3jjGXKDIWEg9G5Hnv0hc448VmKGTBHoPdbmWXj14HegM/xPfL4NI2sAX9w52lQYGYi305iwVkIctjusoHfese0cAKXRG3DCFDsOkGCeCYl1LuKzsurB4qNNSDx+bffsp6g1zwihE+TvwQIwz2O0hJjTyK66GYhoKJw6WVh0yZlFWUV4qmk8FDTPARlTqYLIbJwfBiRaXxkVWo9zQjVFKyvBDvN73xPN8Gs8z6x7jh04kR9u3ZGSID4B2NwlA8uoITJmrdlDQdoJSIbqrQU0qtZ6Ks5zd6ndQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nhe/wjFUoCvty8LtSdiyp7x3mNmPZQcjb6dPJtToQNQ=;
 b=tRmUfM1scQAZE4kGRfewVK0N2fg64nFWz0GGL/bP0OoRqFqaScoPoVjk6lnjrbrNroh11sjy0JP1xZVK+T6/MwXoARrxw6j7R0WYb5Lv6nBRjM0w0eoIT1zqKm28IycgkbnvgN+dchmDRpYCTdd4544bKv6LuCrrS62RMEz6hbjKYamv/ZqSfbvW7uQOHStRiSLi+uoDdEdb9EkU4WC2mZddeYOlbXWDEE1c1l5OydUUNp6CsuOsdSIRWue3Q1CrIbHokXE6afz4BXxxO1ym7A0a6i6xr3sWPJnBLJ41+MyMl+GkISbRSvPxiErNj8R5OR5K5ZMZiCYhNmXkQY4psA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB9701.eurprd04.prod.outlook.com (2603:10a6:10:300::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Tue, 13 Oct
 2026 21:59:34 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 21:59:12 +0000
Date: Tue, 13 Oct 2026 17:59:05 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Lizhi Hou <lizhi.hou@amd.com>,
	Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Michal Simek <michal.simek@amd.com>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be|_ptr)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v2] dmaengine: xilinx: xdma: use kzalloc_flex()
Message-ID: <as6pqTKcHpSSjY7b@lizhi-Precision-Tower-5810>
References: <20261005192621.99880-1-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005192621.99880-1-rosenp@gmail.com>
X-ClientProxiedBy: PH7P220CA0068.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB9701:EE_
X-MS-Office365-Filtering-Correlation-Id: deffa7e7-b588-4ced-4c1d-08df2975375b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|1800799024|7416014|376014|366016|6133799003|18002099003|10067099003|22082099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	bnfgbVYxeW3nRqg/+3G1yjTlpnt1qrMIgVkhMeo3dzugHtPse72mzg/sDeZGUH79dbTn0za6mixSK+281bjKelsVhPeygRuOfrTOZji3/6A4jHxezfhvP5X28sq11WYaC2l+ujtb5kzzdcegexKyEFXLkdArLYvk39HY+soNNrm0swF57f3AAMYLiZdj6+z+9E/ici8qqZecJ/NIRPMgSR8yy1NJKiUmNQpYpvQjy0JqI15vBRQ3cKxEVXqq9wxRfsklHmHHUDCWwoScSZUydYH3kwOO7uOh6y3YiRNzyEVHL1pwdVr6r1oq9v0sobYesTIHR8iU+GhXZe9P2yGghw5VxREbPNeVwFnPVri/PQQ+kXml7+SC37M6/dfcnD/G4elFKADKb1geJ5knwRUrFJldYGX0VieUrOyzctEkO2+8v4gNOORkkPGwpTcLowBT3bqSMJS/Esb8mFLrSrpJfDBVKsTH4ga6tJsc2S1SqqFtw7JbFzpYpDgrYhHw56XW7eqvESHqm+2nmKGskNUhaLqOCSTNqlfwH8XsygFR7vLPo2g9J/WUi6gVjqR7jR+YjKZ7/YdkFYs5xWX0CT6gm19pVmBHmbpykXkI3ZzYdwWk3jRX9pawopHbxgb4lhkHdIltTFLK5TcmVQ3I8bYH22e5I9ibNfK7Eg/BCigHjbI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(1800799024)(7416014)(376014)(366016)(6133799003)(18002099003)(10067099003)(22082099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KOIBMBRmCo4/6O4KvWNrKY30vr2xgML9acGGSvrzbOTnKpiO1eqF5hFpihiF?=
 =?us-ascii?Q?ihEJN+Mn7e5MaTcS3LLLWhMKslQbaVcdGbK2Y0qQLK5bCIuQz8yWhX7SuEYt?=
 =?us-ascii?Q?/SuFU8mSn9i0cri7nSgVkKzdqYDn33SFqcXOI6cjPO7o4rTIkgpKC66DXNA9?=
 =?us-ascii?Q?JXb7jRqSQJqrYrWRuBK5aiF9QjTM6+R5itUybp/Bx6HPnkOAZMsux429/Z+v?=
 =?us-ascii?Q?8b3jCLGfDsK4AlkQj5WLQLehoFB5N5BVld7cop84sjCbOY1VV9cvzE38EKrQ?=
 =?us-ascii?Q?eUWrrytnphGPdHqLAFrP4hmjWvtOW63S8hHMS/7blK3kVqD9OWRqcHGUc1cT?=
 =?us-ascii?Q?iPWZqPMMpT6XC1Y9dOZ72XMeaTY0fkmAU2+0Uu5SDMs1hHvSigCQvYDWSz2K?=
 =?us-ascii?Q?cSjAaS4vDYbQ7mslUcp94P4qMnllD5ttO9jSalgqvgtwFBdP0fdBIcpOy4AM?=
 =?us-ascii?Q?Zy+uu/a9+2zNemSSQ8M4TzJuo1qcBFHq1BQTgb4dlB4c7aUuq4R+RX3f7tLG?=
 =?us-ascii?Q?q2ndl6/kOlmDDBiolqjqFP2KRqzWo7It6AtTJRL1geszR3ilFyhzCrYy5V7M?=
 =?us-ascii?Q?5kpqThqPFG2CzR0C5NUU22Rsi39hfT2jamLCdRZAJfid1D+Iw4Gj3BV6Xpmk?=
 =?us-ascii?Q?wuFwMA5xtkZUPtyRfKnDJeyn0fV1a3nh7Cvj0YedHlqXyDbZ8kTGD+vR0fqC?=
 =?us-ascii?Q?/aUs4L4pBdtJBEJelLa25v1MyvK3KOYmWHCu6oWhWB/O03PaVN9uMdR1A1/w?=
 =?us-ascii?Q?IxZ5Cxo4Bx1HGusiDY1JxfjDW3c9+4X0OJS1HlFk9SLjr6tRCinZWuKXwrzB?=
 =?us-ascii?Q?WfHv9j0OEuh3BQDWWSbbeK6ZC6ErYVzxH35TdX8L3mZkD6upuDrrH03bLiD+?=
 =?us-ascii?Q?Sli1HsjCQxYnNlAWfKoLuvf4KKHUKji4Ki24FdDW4Zv/RkLhCnQWIB69mcdk?=
 =?us-ascii?Q?YtwvT4Fzingab9fmYip8EtA9PwoOVH7y2AxU/Q4l1zCMnTsi9FRAMYmM4lDN?=
 =?us-ascii?Q?QmxiG2Qw7CeH6btJ5hTdrqHKNSqowMxrGg01EpDamXViQmhQg+3dj8cUbYij?=
 =?us-ascii?Q?HEaBAf2KOX7JasT7rhUktGR5U/brf4F+6NRv6AcrnRIpUf9ov/wJLpbMPGFC?=
 =?us-ascii?Q?RT4kGi9DUnomkURZRXy6GTjbNvlSjjit8JQdlS+01fVSMll69b3taRegxent?=
 =?us-ascii?Q?BkJW/ezPqgeMvo3XSDuX9nxLwTiiqoWfhx35/pO4nJqU4ShJV579Gz8vLWH3?=
 =?us-ascii?Q?4kW6InFYmf8NBDP5Isak1s2Z0gIORosCTZuptrNVqcm6KhnwCjaFa+kZOFnt?=
 =?us-ascii?Q?RkLmxOaH2MhIsB/uxkrBvCz+eMaUH2YCaWx/Lf17mvkxV+6nwPJP8zK7Uf1e?=
 =?us-ascii?Q?fckACr4q4aF5J5+DbZp4gGNWXklaC3u1bvVVutwAaaEXeXwZEmTJe9Gtc1lj?=
 =?us-ascii?Q?EqHd75r5ng2P3etwr+/KaeWWaWd1KBXSH/DbSJ8e/Hzn1+Ycz0Q7urwhsuIF?=
 =?us-ascii?Q?vZvc+d6SLsxnig8f200OkyDH7XhF+hCneLry5SQPE3kS1D+nxzDuN+RBj+9F?=
 =?us-ascii?Q?/xEAIL4PrIBk3j8bueNRi04egYGXDr9VeROXsEt5JEQnThCktJxKAxwja0gN?=
 =?us-ascii?Q?KU1Zl5uqj2U49Zgk9287WUXmCp8wMiVH9oqRW85eBrn2L1aowppyaTw71tJs?=
 =?us-ascii?Q?ptyedckg0x67hJ7DPI+cs0N/fCOMS/ul9YSpNCKC6p0YvgaIeq0M+mA6smyD?=
 =?us-ascii?Q?7LAGdzMrSd99yRg9E+78ZYYzwXqK40Aq09o9jnJefz4Bj3nEgCfT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deffa7e7-b588-4ced-4c1d-08df2975375b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 21:59:12.8400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: laGg/n4MJ5J5sBuP7vr6M53hNn0UB86t5p2kOhwYverJPZthI5eUwfASPe8Mdk0o/hicAbXcYPXUYi7mm41GZmS06F/eNYWNVupo5m9GkTZeRCR2ykxZSCFLyzottKIP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9701

On Mon, Oct 05, 2026 at 12:26:21PM -0700, Rosen Penev wrote:
> Change desc_blocks to a flexible array member so the descriptor and
> its block array are allocated together, removing one allocation and
> its error handling.
>
> Add __counted_by for extra runtime analysis, and set dblk_num right
> after allocation which is already done by kzalloc_flex() for GCC >= 15.
>
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/xilinx/xdma.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> index 8d4a5d14e8db..16d202722245 100644
> --- a/drivers/dma/xilinx/xdma.c
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -81,7 +81,6 @@ struct xdma_chan {
>   * @vdesc: Virtual DMA descriptor
>   * @chan: DMA channel pointer
>   * @dir: Transferring direction of the request
> - * @desc_blocks: Hardware descriptor blocks
>   * @dblk_num: Number of hardware descriptor blocks
>   * @desc_num: Number of hardware descriptors
>   * @completed_desc_num: Completed hardware descriptors
> @@ -91,12 +90,12 @@ struct xdma_chan {
>   * @period_size: Size of a period in bytes in cyclic transfers
>   * @frames_left: Number of frames left in interleaved DMA transfer
>   * @error: tx error flag
> + * @desc_blocks: Hardware descriptor blocks
>   */
>  struct xdma_desc {
>  	struct virt_dma_desc		vdesc;
>  	struct xdma_chan		*chan;
>  	enum dma_transfer_direction	dir;
> -	struct xdma_desc_block		*desc_blocks;
>  	u32				dblk_num;
>  	u32				desc_num;
>  	u32				completed_desc_num;
> @@ -106,6 +105,7 @@ struct xdma_desc {
>  	u32				period_size;
>  	u32				frames_left;
>  	bool				error;
> +	struct xdma_desc_block		desc_blocks[] __counted_by(dblk_num);
>  };
>
>  #define XDMA_DEV_STATUS_REG_DMA		BIT(0)
> @@ -255,7 +255,6 @@ static void xdma_free_desc(struct virt_dma_desc *vdesc)
>  			      sw_desc->desc_blocks[i].virt_addr,
>  			      sw_desc->desc_blocks[i].dma_addr);
>  	}
> -	kfree(sw_desc->desc_blocks);
>  	kfree(sw_desc);
>  }
>
> @@ -276,26 +275,22 @@ xdma_alloc_desc(struct xdma_chan *chan, u32 desc_num, bool cyclic)
>  	void *addr;
>  	int i, j;
>
> -	sw_desc = kzalloc_obj(*sw_desc, GFP_NOWAIT);
> +	dblk_num = DIV_ROUND_UP(desc_num, XDMA_DESC_ADJACENT);
> +	sw_desc = kzalloc_flex(*sw_desc, desc_blocks, dblk_num, GFP_NOWAIT);
>  	if (!sw_desc)
>  		return NULL;
>
> +	sw_desc->dblk_num = dblk_num;
>  	sw_desc->chan = chan;
>  	sw_desc->desc_num = desc_num;
>  	sw_desc->cyclic = cyclic;
>  	sw_desc->error = false;
> -	dblk_num = DIV_ROUND_UP(desc_num, XDMA_DESC_ADJACENT);
> -	sw_desc->desc_blocks = kzalloc_objs(*sw_desc->desc_blocks, dblk_num,
> -					    GFP_NOWAIT);
> -	if (!sw_desc->desc_blocks)
> -		goto failed;
>
>  	if (cyclic)
>  		control = XDMA_DESC_CONTROL_CYCLIC;
>  	else
>  		control = XDMA_DESC_CONTROL(1, 0);
>
> -	sw_desc->dblk_num = dblk_num;
>  	for (i = 0; i < sw_desc->dblk_num; i++) {
>  		addr = dma_pool_alloc(chan->desc_pool, GFP_NOWAIT, &dma_addr);
>  		if (!addr)
> --
> 2.56.0
>
