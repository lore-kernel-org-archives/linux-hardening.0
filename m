Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011004.outbound.protection.outlook.com [52.101.70.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8762D7DD7;
	Thu,  1 Oct 2026 20:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790885933; cv=fail; b=cSsi5bj1FAiWc5U0I/mSa6RYHfn92xvbNIjXXsQmS+BUvQwAr+0nzfpqHor/HM4x+UalpHUCHuIdA2Epren4ufWyxhwdKlzh/Xvh33sn7Qvu7OVe2zUdT4eSLC7KGvz/4zXPz2G8OUmyUKQNqh2JC8EiIQgpUAuWuevkqLoc4lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790885933; c=relaxed/simple;
	bh=XlqycFX7BRLvDTZqHaMhHsntVGLnQhXjARDIXgq3hAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mICQlGCX3XbSJs1CICa8wTYi2c7nRgfuWs8XA+mWcVy9REW9P5id1CGo5/97IdQquC9naIKeO5b2WZ132NI0Ww07HMdw0XKmv1/GTEJ6pt+zN87rSSMz+7fZ7zCIHKFpEseCWGln2LjYPTJ2jrl7/Dy+UnLK/994ra4ei+lrNpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=LpAE1Jck; arc=fail smtp.client-ip=52.101.70.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LpAE1Jck"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1l4edCGWJMehggLRJk+29csVX0B0O+ycjeFyN3HJHmw33hBK0zWQeIhfsa0hgFCS2n1Pomt8mbQ1rLd+IWThSPNbVVXN4r7Jo+wgcNB5iqXnlWg8N6GOUVW1pVp8yULSceYg8rKiCsYFPt4HH1QfDRBP2jEEIrMIOYZ31j0kuVrtV+cqGvTC+8nR9o2Bl9CLaM0TT8714iYGg1XoFTBdFsgxsnyeKGOnBh9SOyPT6lrD3zT7caesP0IDHMrraQ3UYo4BtYmBhJmylddNY4bYgTFubMbqGNgHde1IAyT5d+tzj/Ff23Jbpw+GDcg/J13NjZXu/D4DdByzHFA7PuCuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jg75ChubgISakBD98xqbp4xzQUZSdPUM5Re71xWA8tg=;
 b=w7eqUhzeHeTFDS8KoCEVttpCq+Z+6wgWl11uYFIrQCz88pms2ghl9j7JG1hAPC8ciCOazczgDRtnm/LPYJUPQysjSlC7bQ7770iXmyxQchbNPuoZkOYwDnUrU5sa+v9O2qvmyOSj16Qt80/7YFWB9bOq/4mXyVpViUTLyNfwRFoEbAUsyvV3fnGQVehXH3cDKRJrUlVxr4neS1F9+z+YPZHLShs9MJCLCluT9FD6Td5asrB8lgjq4toWka5Q39PefJuHsQPUb0TbjSNq4oy4QbXuAmtU4ResT64mAGOxpIXln48+Q4ePlgFXiy9EoqYiDCyF3xNdmiQM3V4i8LBHmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jg75ChubgISakBD98xqbp4xzQUZSdPUM5Re71xWA8tg=;
 b=LpAE1JckcChYwbOXG38FiseEF6ixPXGF8WYceJaGPV8waez21NH0CJpdHvbyJliNaX5UezkHkNCJ555MlPNF/E7rsRt6+6d5/7kLwY3dxldDjgaJu3ZXqqgyokPFK2RwO6oZ9e0f5t+6sEYdv0F9VTf7p2TSifRpT1B1CGvPmiw6hZ8q90lqljK4DmMb2NrlDI+iScJB0ddE/NXdCtSoBaGzkBUVmUDDgQWx2qwU2+sCPsj7FRixIUZUhkinA3wHgBiERlOeAbjG0ooDkRxWk66cWlyRiS4tz/nwggdkU41rV9O6YXjejQ9hTQRhEnIsGQAt5AQHjWDkh6AfS+/8Gg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM7PR04MB6887.eurprd04.prod.outlook.com (2603:10a6:20b:10a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 20:18:41 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 20:18:41 +0000
Date: Thu, 1 Oct 2026 16:18:32 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: CL Wang <cl634@andestech.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	tim609@andestech.com, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] dmaengine: atcdmac300: Add driver for Andes
 ATCDMAC300 DMA controller
Message-ID: <ar7AGB9ZT6ipCACZ@lizhi-Precision-Tower-5810>
References: <20261001014503.786490-1-cl634@andestech.com>
 <20261001014503.786490-3-cl634@andestech.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001014503.786490-3-cl634@andestech.com>
X-ClientProxiedBy: PH7PR17CA0033.namprd17.prod.outlook.com
 (2603:10b6:510:323::7) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM7PR04MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: 34455a0e-852b-4dff-45ec-08df1ff92f3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|19092799006|23010399003|22082099003|18002099003|11063799006|4143699003|6133799003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	Wzi/u3wZcLK1V5KOEbpp97wbKZfPNXO1hvozwYaTgAJYHpHfUcpCsKf9v6kjU334AZUQixF1LJOvAnKJRlTsYITkA3UgZmkMerk5fcl3mZ2Dv++atzKjoVPaj+hg8Dqx9s7bDVXlL22LtCKe2STK7CmwyN75bB/03y0fC8JR3bV6H4uyBCw+SkbyYKYgHyGgPTnzo3ImhKHyXJuVGI235JSIxWUkaRIlIUBdyaU2RIfD+9Jn9wNU91tHeaskdna2qCpn5RGYrTGGBUL1aJbn25sHxXDZvn/TjSl6ETVDCBfw2IYNcvyDUE4bMw0sLz1niYK1plk5Y0L1Xv3t+oGi/eNQG7WyMZJxuEQpe92yTEGrxNM3Yhgu82tubByjl765tL6Kat8xSa16YCkCjPSbiALc9mvaDMSiArJu0zYIiw+kMFUVRYR/H3jdfpPu3hFAKB5Z+/16EaUgUQywLNXQWENaot4QEgc+E7rnNdQ+HZs+CITKM8CWUbs0Hilg+YkEqm9ygpLysvpJ2ib7Wsq/3hCVDihgXOE7/s8gtHg+6NHEIFsHmxRuwLJoF/PdYtl/Fdm/o9MpKIRTaBsoVUfetlfWkt/9neG9ipaJkYujRL1AC3tOK8Maf/aFocrDDB6SFke4cFzRbfyXi+2irdYRqqfGpLmqAYTl4YPBG9dlyag=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(19092799006)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(6133799003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/ByVbrI9rXhCebtFIFFpdJ9bdsainZA0EsxIktGzuT282hehGdewS9dFC6Cb?=
 =?us-ascii?Q?PDT29uB8hp6UPyvs6a5vMOdDj8lDtdaNX9nHeIHZTpyMGgBbgX9LSJU+Q+mo?=
 =?us-ascii?Q?kyAxDAzO29UbVRW/VuqIYCl4RhLP4XHbxSE33ai8Rt+2p5AFisX9QI2OdfUm?=
 =?us-ascii?Q?rje2qoTH+eeZghCj4ZsFKik7gnt/rasGIkUOLgpY9kkztVW9tmkHnolfsKLQ?=
 =?us-ascii?Q?XpTFUmRx0RT1Z1U7rx3feESaKK8T52jvsFuR1NzLYbKJC1OArf3YWbG9KvTJ?=
 =?us-ascii?Q?ufRrzlLY02jEcPCkloZT+QHiWaMh9L3Lj++gfwDeXkUmeXCnEoCnFsWzQc9A?=
 =?us-ascii?Q?lVNOmc1hkZ2n1a5udl8aKvC+VZQmLa6ZbGzl0GCb3V686OVfl/0H8cG/9y17?=
 =?us-ascii?Q?Uz+RCdPi0N2fZHrZvTOQ6zcbW4PWdBrYJbCWBCW8gw4d6ruQxiJRUuN7TS7i?=
 =?us-ascii?Q?PQH0+Oe5xJsghn81J4kxpvps53unZYacfJpDAOi3noy+G30JvEfYEl3jfE++?=
 =?us-ascii?Q?AStRlgWbA9caQRJgduECEOplSz9G0DsrMDg3RacExBYorykSDlSTKAk3Ulpk?=
 =?us-ascii?Q?X+5Zx54FlparxCzcVevfmISOQ5s73dF7T78OEYEXakOvtQmNYgxGIYkglEQq?=
 =?us-ascii?Q?9z/jakFf/jfNp+NQ1WWDXmOstlEJTxrrxahv4q4OFrK0KfXSypdxp1ZXIUv3?=
 =?us-ascii?Q?f9LDIajF5LGI514fKGBtXEZh/dj66ATBh58pcVwbsD6ZMIVtB7fXq1jV8bE9?=
 =?us-ascii?Q?a5d0O8DmxHRkwjrwMGNAii3hMvbIDEn8b/a7Tq6w/4wNfF/G0vaf5iF9m3Dm?=
 =?us-ascii?Q?brYRTkbKv4MUjTGKljNHZR5pDH2loiUeIkPmV30tC393eu2S6OCUZGTrIKtU?=
 =?us-ascii?Q?5UFpD7apKeY415hazBV70rZKJTkeGij8r3sB+uGurSHikD5bo+VVNQ4xb4Kh?=
 =?us-ascii?Q?EFA7cw7mx/E9XaIpkPMlEUAibHWewjIoh2IhIa+f7WEYGAC3t1b7lYqB0BJo?=
 =?us-ascii?Q?M/Emb3d49wSP1NoEpwEHOFc0lrShHZGf2Ihob4dBemRzNMXa4+lgXB9ZCBzI?=
 =?us-ascii?Q?oiG18Oo37af3tBw/TbqrEK33aAPNjM6kUC3RrdBFFjzigvC2OmtIVYTzEEEg?=
 =?us-ascii?Q?K28lOlmTEhWDEjX5bfbx2oav20Y+Vplx1xxiqEIjH+2Fe4qE6vTA4caIJw0G?=
 =?us-ascii?Q?UqT+u7OIa4qlD1jFG3z1WYXY350Gf9QhFf3Odk0DDLyxVccEAUyGrFAqP9Ba?=
 =?us-ascii?Q?O/nPsZhxSYJedYsw81pdkBtQxSalviMi6PQ2q2vCcIEiIHdeuzgtN1Mm8Mm2?=
 =?us-ascii?Q?zw2hB52oHaah7AZ8/Sv37HHdG4Xk9jVEFIAmojq42pTHCeDnirHJvtNcuvOH?=
 =?us-ascii?Q?zdEsL0XFQP65ui1fxEtUK1SljIM+HNpV//cvaUySDNyyoKfJr1e/G1Him8vK?=
 =?us-ascii?Q?shJUaX3p3tQdpK7K1o+gGFkpsphVBNLu7i+b1e04iz3uKZgoWo6RxNESyLJl?=
 =?us-ascii?Q?1lpMQkg4SLLlvykFUkMVm6RlvBNF7/46ODDJH66CyrsLZSDO00znDES4jej/?=
 =?us-ascii?Q?Krd1pkzuZ4FOUkLSlLFQALKLdwjOXaYzXEL9XgK0YOaIhYTuBSeHHqyFejmw?=
 =?us-ascii?Q?Yx2Sf7DUxZM+pf8ZANP6mbH4XG6DBMGMDk6im/g2Zl32bxjtrOwfZmk1+m3L?=
 =?us-ascii?Q?Nu7fCCcnUanYyrCO01MOuy+m+M+gmvRYXSrjLhoUTWVC5usij6DAybIzmBlJ?=
 =?us-ascii?Q?qpR0rojgf6PTc7TYHHXzdlkkyBFA1GEwyaWtddh9qhg+w3LYS1Aa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34455a0e-852b-4dff-45ec-08df1ff92f3b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 20:18:41.3169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8YxVBBz2+Zx1c97qVJAGn34jcYEaUEl+bEuLCJiqHofXU5mCr4b3TteQbP1D4SrbV0NMzO6nxeynJAmfCpMZgSSI+z7DXbrJ7DiLsNNzEHJehx/jONMMGLPDnIPPpab0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6887

On Thu, Oct 01, 2026 at 09:45:03AM +0800, CL Wang wrote:
> This patch adds support for the Andes ATCDMAC300 DMA controller.
>
> The ATCDMAC300 is a memory-to-memory and peripheral DMA controller
> that provides scatter-gather, cyclic, and slave transfer capabilities.
>
> Signed-off-by: CL Wang <cl634@andestech.com>
>
> ---
>   Changes for v8:
>     - Fold in fourteen further correctness fixes; no interface or binding
>       change.  Five of them answer findings reported on v7; the other
>       three findings from that posting are explained in the reply to it
>       rather than changed.  The remaining nine come from a review of the
>       whole driver.
>
>       Descriptor lifetime:
>         - Track cyclic mode on the descriptor rather than on the channel.
>           A cyclic and a non-cyclic transfer on one channel could leave
>           the flag set for the wrong descriptor and dereference a NULL
>           callback.
>         - Drop the num_sg field, which was written but never read.
>       Suspend and resume:
>         - Restore stop_mask when suspend times out, instead of leaving
>           every channel stopped for good.
>         - Start transfers that were queued while suspended.
>       Driver model:
>         - Do not offer the controller for unbinding.  A client holding a
>           channel across an unbind would run against devres memory that
>           remove() has already released.
>       Register encoding:
>         - Reject a DMA request line the request-select field cannot hold,
>           rather than truncating it silently.
>         - Keep the burst field out of its reserved range, which the
>           controller reports as an error exception.
>         - Refuse a transfer width the width field cannot encode.
>       Slave configuration:
>         - Clear the stored configuration when a channel is allocated, so a
>           client cannot inherit the previous one's device address.
>         - Accept a configuration that describes only the direction it
>           uses.  Requiring all four of the width and burst fields to be
>           powers of two rejected any client that fills in one direction,
>           and the transfer then divided by a zero device width.
>         - Reject a length that is not a whole number of device-width
>           units, which either transfers fewer bytes than asked for or
>           programs a zero transfer size.
>       Probe:
>         - Use struct_size() for the channel array, which is already
>           declared with __counted_by().
>         - Check the configuration register read, and refuse a channel
>           count of zero rather than registering a controller with no
>           channels.
>       Cleanups:
>         - Return a bool from the channel-enabled helper rather than a
>           value that is negative on a failed register read; pass a
>           register value rather than a bool to regmap_update_bits(); use
>           dma_cookie_status() directly.
>
>   Changes for v7:
>     - Fold in twelve correctness fixes found by review and confirmed on an
>       FPGA; no interface or binding change.  Interrupt path:
>         - Acknowledge only the status bits that were actually read, and key
>           the acknowledge on channel ownership rather than on in-flight
>           state the handler itself clears.  The old mask could drop a
>           completion that arrived while it was being cleared, leaving the
>           source asserted until the core disabled the line ("nobody cared").
>         - Use raw spinlocks for the state shared with the hard IRQ handler.
>       Termination and descriptor lifetime:
>         - Do not run the callback twice, or recycle a descriptor, when a
>           transfer is terminated while its completion is in flight.
>         - Initialise desc_node when a descriptor is allocated.
>         - Wait for the channel to stop without holding the channel lock;
>           the poll could spin 100 ms with interrupts disabled.
>       Suspend and resume:
>         - Move the PM callbacks to the late phase so clients terminate
>           their transfers first, and name the channels that fail to idle.
>         - Drain in-flight completions across suspend and resume.
>         - Do not restart an idle cyclic channel on resume.
>       Probe:
>         - Register the DMA device only after the interrupt and cache
>           coherency setup, closing a window in which a client could obtain
>           a channel through dma_request_channel() on an unready controller.
>         - Do not read-modify-write write-only registers.
>         - Name the device in the probe-time reset error.
>
>   Changes for v6:
>     - Rebase onto dmaengine/next; no functional changes from v5
>     - Fold the MAINTAINERS entry into this patch instead of carrying it
>       as a separate patch
>
>   Changes for v5:
>     - Update copyright year to 2026
>     - Remove redundant headers (init.h, iopoll.h, mod_devicetable.h)
>     - Move atcdmac_init_iocp() before of_dma_controller_register() in probe
>     - Change builtin_platform_driver() to module_platform_driver()
>     - Implement .remove callback to support safe module unloading
>     - Update Kconfig entry from bool to tristate
>     - Add MODULE_AUTHOR, MODULE_DESCRIPTION, MODULE_LICENSE macros
>
>   Changes for v4:
>     - No changes from v3
>
>   Changes for v3:
>     - Remove "andestech,atcdmac300" from of_device_id
>     - Replace deprecated tasklet with threaded IRQ using
>       devm_request_threaded_irq() and IRQF_ONESHOT to handle bottom-half
>       processing.
>     - Update locking mechanism from spin_lock_bh() to spin_lock_irqsave()
>     - Minor cleanups and correctness fixes
>         - Initialize descriptor pointers (first = NULL) explicitly
>         - Add missing headers (err.h, iopoll.h, log2.h, sprintf.h)
>         - Remove unused code paths related to tasklets
>         - Use builtin_platform_driver() instead of module_platform_driver()
>         - Remove "select DMATEST" from Kconfig
> ---
>  MAINTAINERS              |    6 +
>  drivers/dma/Kconfig      |   11 +
>  drivers/dma/Makefile     |    1 +
>  drivers/dma/atcdmac300.c | 1759 ++++++++++++++++++++++++++++++++++++++
>  drivers/dma/atcdmac300.h |  298 +++++++
>  5 files changed, 2075 insertions(+)
>  create mode 100644 drivers/dma/atcdmac300.c
>  create mode 100644 drivers/dma/atcdmac300.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c31b81eb42d7..2c48bb3053b3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1974,6 +1974,12 @@ S:	Supported
>  F:	drivers/clk/analogbits/*
>  F:	include/linux/clk/analogbits*
>
> +ANDES ATCDMAC300 DMA DRIVER
> +M:	CL Wang <cl634@andestech.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml
> +F:	drivers/dma/atcdmac300*
> +
>  ANDES ATCSPI200 SPI DRIVER
>  M:	CL Wang <cl634@andestech.com>
>  S:	Supported
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index ae6a682c9f76..dabd2c8cc94f 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -100,6 +100,17 @@ config ARM_DMA350
>  	help
>  	  Enable support for the Arm DMA-350 controller.
>
> +config ATCDMAC300
> +	tristate "Andes ATCDMAC300 DMA support"
> +	depends on ARCH_ANDES

|| COMPILE_TEST

make sure it can build

> +	depends on OF
> +	select DMA_ENGINE
> +	help
> +	  Enable support for the Andes ATCDMAC300 DMA controller.
> +	  Select Y or M if your platform includes an ATCDMAC300 device that
> +	  requires DMA engine support. This driver supports DMA_SLAVE,
> +	  DMA_MEMCPY, and DMA_CYCLIC transfer modes.
> +
>  config AT_HDMAC
>  	tristate "Atmel AHB DMA support"
>  	depends on ARCH_AT91 || COMPILE_TEST
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index 14aa086629d5..c8fffb31efc4 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_AMBA_PL08X) += amba-pl08x.o
>  obj-$(CONFIG_AMCC_PPC440SPE_ADMA) += ppc4xx/
>  obj-$(CONFIG_APPLE_ADMAC) += apple-admac.o
>  obj-$(CONFIG_ARM_DMA350) += arm-dma350.o
> +obj-$(CONFIG_ATCDMAC300) += atcdmac300.o
>  obj-$(CONFIG_AT_HDMAC) += at_hdmac.o
>  obj-$(CONFIG_AT_XDMAC) += at_xdmac.o
>  obj-$(CONFIG_AXI_DMAC) += dma-axi-dmac.o
> diff --git a/drivers/dma/atcdmac300.c b/drivers/dma/atcdmac300.c
> new file mode 100644
> index 000000000000..b67675647b36
> --- /dev/null
> +++ b/drivers/dma/atcdmac300.c
> @@ -0,0 +1,1759 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Andes ATCDMAC300 controller driver
> + *
> + * Copyright (C) 2026 Andes Technology Corporation
> + */
> +#include <linux/align.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dmapool.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/log2.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_dma.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/slab.h>
> +#include <linux/sprintf.h>
> +#include <linux/regmap.h>

Add empty line here.

> +#include "dmaengine.h"
> +#include "atcdmac300.h"
> +
> +static bool atcdmac_is_chan_enabled(struct atcdmac_chan *dmac_chan)
> +{
> +	struct atcdmac_dmac *dmac =
> +		atcdmac_dev_to_dmac(dmac_chan->dma_chan.device);
> +
> +	/*
> +	 * regmap_test_bits() reports a failed read as a negative errno,
> +	 * which every caller here would otherwise read as "enabled".
> +	 */
> +	return regmap_test_bits(dmac->regmap,
> +				REG_CH_EN,
> +				BIT(dmac_chan->chan_id)) > 0;
> +}
> +
> +static void atcdmac_enable_chan(struct atcdmac_chan *dmac_chan, bool enable)
> +{
> +	regmap_update_bits(dmac_chan->regmap, REG_CH_CTL_OFF, CHEN,
> +			   enable ? CHEN : 0);

Use regmap_assign_bits() will be more simple

> +}
> +
> +static void atcdmac_abort_chan(struct atcdmac_chan *dmac_chan)
> +{
> +	/*
> +	 * ChAbort is write-only: write 1 to the channel's bit to abort it.
> +	 * Do not read-modify-write, the read value is undefined and writing
> +	 * it back could abort a channel owned by someone else.
> +	 */
> +	regmap_write(dmac_chan->dma_dev->regmap,
> +		     REG_CH_ABT,
> +		     BIT(dmac_chan->chan_id));
> +}
> +
> +static dma_cookie_t atcdmac_tx_submit(struct dma_async_tx_descriptor *tx)
> +{
> +	struct atcdmac_chan *dmac_chan = atcdmac_chan_to_dmac_chan(tx->chan);
> +	struct atcdmac_desc *desc = atcdmac_txd_to_dma_desc(tx);
> +	dma_cookie_t cookie;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dmac_chan->lock, flags);
> +	cookie = dma_cookie_assign(tx);
> +	list_add_tail(&desc->desc_node, &dmac_chan->queue_list);
> +	spin_unlock_irqrestore(&dmac_chan->lock, flags);
> +
> +	return cookie;
> +}
> +
> +static struct atcdmac_desc *
> +atcdmac_get_active_head(struct atcdmac_chan *dmac_chan)
> +{
> +	return list_first_entry(&dmac_chan->active_list,
> +				struct atcdmac_desc,
> +				desc_node);
> +}
> +
> +static struct atcdmac_desc *atcdmac_alloc_desc(struct dma_chan *chan,
> +					       gfp_t gfp_flags)
> +{
> +	struct atcdmac_dmac *dmac = atcdmac_dev_to_dmac(chan->device);
> +	struct atcdmac_desc *desc;
> +	dma_addr_t phys;
> +
> +	desc = dma_pool_zalloc(dmac->dma_desc_pool, gfp_flags, &phys);
> +	if (desc) {
> +		INIT_LIST_HEAD(&desc->desc_node);
> +		INIT_LIST_HEAD(&desc->tx_list);
> +		dma_async_tx_descriptor_init(&desc->txd, chan);
> +		desc->txd.flags = DMA_CTRL_ACK;
> +		desc->txd.tx_submit = atcdmac_tx_submit;
> +		desc->txd.phys = phys;
> +	}
> +
> +	return desc;
> +}
> +
> +static struct atcdmac_desc *atcdmac_get_desc(struct atcdmac_chan *dmac_chan)
> +{
> +	struct atcdmac_desc *ret = NULL;
> +	struct atcdmac_desc *desc_next;
> +	struct atcdmac_desc *desc;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dmac_chan->lock, flags);
> +	list_for_each_entry_safe(desc, desc_next,
> +				 &dmac_chan->free_list,
> +				 desc_node) {
> +		if (async_tx_test_ack(&desc->txd)) {
> +			list_del_init(&desc->desc_node);
> +			ret = desc;
> +			break;
> +		}
> +	}
> +	spin_unlock_irqrestore(&dmac_chan->lock, flags);

Not sure why need manually manage free_list. Most likely dma_pool_zalloc()
is quick enough.

And why not use virt-dma?

Frank
