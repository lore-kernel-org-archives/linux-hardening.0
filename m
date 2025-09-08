Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013059.outbound.protection.outlook.com [40.107.162.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9496D1EF36C;
	Mon,  8 Sep 2025 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757347425; cv=fail; b=Viag0+dQbEMqyJrdm1vhcamk8UYYJf78IidNxd7AvJN2K6MRKp1kWlYYGpcc5T4b1yPmhP8GLGT5CAN6xg+B/X5y+lGfXA+GdWg41fTlDRGINz9PIQUiW+riSu5f2eoJJLvAqh2MrdN973UksB+O+/Oj9DKVidX8Z+dacDQFGbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757347425; c=relaxed/simple;
	bh=v8lkqZYM2JhvJWq7dNrGlswF64lwe5bwUmN4WiWt8og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d0f0NP/xfbNbYmN/Rb0zY0uinif6eJy7N1R8xFerxIYBm6+ZFdtWRRwllcFbvPfICJ4gEVSuBn31qHHTRcUmWKA020h3mZQueWvqKK7ihNwQT8EyQG+bTxkBZA7oKCzW/neIYNAyQtrY2kYP72owkkGZg5m3HbhbwiOLDJTNnzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ck8SgqKT; arc=fail smtp.client-ip=40.107.162.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ck8SgqKT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpefY43boaV6Nd3a0t87zn+xQwijIT4d+NWSydDCTUW8erW2qxaZMSbrVEkzT1As02zLZXDQlKBtt7EBbZiHP1jsBSGfjpy1Tsp3HM5eDCl0rL2xX+VT6XZP5I0LBmkxmnwY7UhfHGlCZMOLFWLQO7Mv1vOU3pkWM50btB74MahpwZXoxwB2SX3oLoLVZGUCUEqKd8qu1zjM+cydFPyE8S0VDPlkO8Em3+xG1s0QaWTk4S2UID1WJRQTxQAqdvIhBn34T/XbTM5IM6ayieIRe5DoQOLgSZ1yhrGoJmelFaJAR0g37pi7oFYX4SAhNqfyTcAWlbA07mE5fN9I55aESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkG7/422jgq3TVaD6uXYj/Z7nCypY4LJlbK7nYatbPA=;
 b=PJn0eNAXtjAIeQGSwVf6IEXLWg0+UNAAj/4/89DI827FR5K4SuYWRvECj5bCISE18V47yFJ1c99bO19xMufytrQFlPAMEJk2iiJNbOGKdtMlVqA4LDWkNp7hCrrCnvwUiLCxKL1LQdEZkuYCLDWu5VI4QZH3KL0J11+1Fw5+RTa1BPv4UuwSt4NUMPoxhR7J7zaSChLdWbQLpblbQaOM4oEpRtd+10Bxg/Ypa3qnkDA7Pio2zI3v9qLDFr9Cr+eBhfPzPisYpSd1/BFg3EwBTH5RT8aT4GF1zCHECZsDGlhKm5v23lpHsH1BzTY8pnOdvcrVzQnX7O65ENbGw/r6Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkG7/422jgq3TVaD6uXYj/Z7nCypY4LJlbK7nYatbPA=;
 b=Ck8SgqKTUffOSRzs8mO1rrOqmNex2bn1UCKwcJb4PHb+XE1qMHpCWvNKoPn8+NSLE/x/LY5k7TskOMieFLhSziWoVhX7iexYxeJAnOhgdhxJPABYXkS1SLSH/sDHsW1mAsoRZXcDS/9pTLZ9CgLy9OqX02kJFaIzh4A53JZpMhp7PJ8zIybYmfvAHPo5cboUDKAnAobTGcKcZsdSXRTCW4KSWIAH/zO32HAE3PFe2IRtiIjuTx9D6c+bmr+RZAhswwyPBGEFsC+wPtcTF+EacMZTBdACD04jqZ8Tt2RRox1HjkhCmxJ6cfzywzebKMJcw9Zy5QzIkVdJH7LKHketlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB7669.eurprd04.prod.outlook.com (2603:10a6:20b:29b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Mon, 8 Sep
 2025 16:03:39 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%5]) with mapi id 15.20.9115.010; Mon, 8 Sep 2025
 16:03:39 +0000
Date: Mon, 8 Sep 2025 12:03:30 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: git@amd.com, michal.simek@amd.com, alexandre.belloni@bootlin.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	kees@kernel.org, gustavoars@kernel.org,
	jarkko.nikula@linux.intel.com, linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, radhey.shyam.pandey@amd.com,
	srinivas.goud@amd.com, shubhrajyoti.datta@amd.com,
	manion05gk@gmail.com
Subject: Re: [PATCH V5 2/2] i3c: master: Add AMD I3C bus controller driver
Message-ID: <aL7+Urm4NB9kwOwQ@lizhi-Precision-Tower-5810>
References: <20250908112117.205270-1-manikanta.guntupalli@amd.com>
 <20250908112117.205270-3-manikanta.guntupalli@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908112117.205270-3-manikanta.guntupalli@amd.com>
X-ClientProxiedBy: SJ0PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::28) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB7669:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e3d6805-e2e2-442a-8d96-08ddeef1465d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|7416014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VsYjdIxXYQhXHnBcpyKR9TcJQgjEBv2OBIkFHSguCNsNzAuWxh9CzpGJozez?=
 =?us-ascii?Q?LZEqCKhhMaCcc0n3fRVUMCingRO7bR0nsLUFccmparGG0410mauZlZubwyae?=
 =?us-ascii?Q?MgpDrCVrk5lKlYVDSXr327WYLDF7eFrt2nTZVGHuFP4GC+gPXfmu3Sb43TtT?=
 =?us-ascii?Q?M/S+OpF1aiTAuBaY6zJG2poZszVDdPgfAIuyg4pFOZKBUDgY88zT6iFGIk/X?=
 =?us-ascii?Q?Er1hTtCupdadisI7AHMVQUze+OZo5vcOdQlFPyThnzhMFjCRYwSSl61gLapF?=
 =?us-ascii?Q?zrFsSksIuWYQhKy8tAIeWEEQv63/Gk4yYKOXePjLft3UfsgqFnPqhsU1G1Ac?=
 =?us-ascii?Q?LqJpVfXldYoXatKHjRPk/bOAHQQmBdqaR0/CXKwdRr+JKCst8CFLDEpz4EP7?=
 =?us-ascii?Q?d7FurxxlrDCiEHZWT8ISj4AUHb6oeNvLjKKLnF4qG+6S4WP0HlTaF6p3OnYU?=
 =?us-ascii?Q?LH1Dji12zoKXCqCR1DVGE02Av+stGAIXVZmIf5A6nNp2aU/xgeSEpddMhBjw?=
 =?us-ascii?Q?pI2nm05bzTV3eNCIezmKLWMaWFeiHIShUvGgzKpF6Ai6UmWIAAXsgM0Hg4+u?=
 =?us-ascii?Q?Tlx1lqd75WGO87odvX3f1KS+PXk//qNiJ2EtRqMBtkPWfSiGLtoPcnODnNgi?=
 =?us-ascii?Q?SiNh+isHHasOMTuIqYsYzYvp+SO/YA/n/WMqwkGiSgZwymUwBrJptTqINQAU?=
 =?us-ascii?Q?BmcTsBo2f7geOLGNeqyNe3GK9WQFwcoIGQFgDgUs17UdizkqWE40sintVqWS?=
 =?us-ascii?Q?9DrsZHU7fWgvF251Nn3GT7V5Ma+o/L8EYNhAAc9vWYjUUAqf7g238Tuxr0qa?=
 =?us-ascii?Q?I1e9+lcJ9Hz6qNHli2a2tQNu7bAjK93wJeixMc8VboceCgNO7oSz/xEBi8U/?=
 =?us-ascii?Q?BBXw3KGuUujry+pBEe9MLO7N4R5++9yS3NyyG51efcbHqVbOSeO0r6fh9oIr?=
 =?us-ascii?Q?GBWVXXhxjPERGQWCTaWLSh4UMm8vM8E6Bqk61FC8p60w/y7ZjEFkMdoqH5Uv?=
 =?us-ascii?Q?IGSDyf5E5t8jY2fPZPcyJ4OQacLy24N/I5GVzty0gSgpYGSSVKrFEcYnOzRS?=
 =?us-ascii?Q?3HzowiITp42B+6FigaeemxUZBFmSbqflRPfLQQfd0qBzSvDaquwl+fpmw4Sf?=
 =?us-ascii?Q?MDPd/hc9pM8jPM/gYIurKoHCYpSIIHCAkAyPaGtSDr3Raam4QK+vz4M6WYBn?=
 =?us-ascii?Q?MSTtAe6UgRRR+BBFfIPHFjbWsbrivXqmrn5dZy8Ey735h57IK5SkswnmmqSd?=
 =?us-ascii?Q?vgSTSMFeUeQD/sxIWUYraIMNfD8i84q7rYgmBoX0+FHxewyfW3EjGB8iMHX2?=
 =?us-ascii?Q?RpNpZ0Wd4qVYbj2E2n5qrugep4bzYHJT6/KeRz3EKZm2l4AIryAeSgSXzOKe?=
 =?us-ascii?Q?r3PS3/FIfYPOioc0oX8Ynb2zyQCu+BUVqmrC70c3xr35BOrWtm8wqbEe2paM?=
 =?us-ascii?Q?YSuMruvoen6uS+mn4uxi1h2CpwCVOdiBysRSscFfLdNk5UHr7xJ4GA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(7416014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ML1yZH0bevkFKm0I+VQrxavU02R3x+C0/K8jv4YqAz0gkO3Dw85tosjTR+lE?=
 =?us-ascii?Q?9wwoqCGyX+sAcwU1Lj6nY7DTE5LyieHQz04XLs0lPzaHourO0azspg3vntoR?=
 =?us-ascii?Q?Q+ITRR1HmjHNpAKxoAJmqzSajIcQ83is5g32CL4pe7jvvFkygItpJWvNY20n?=
 =?us-ascii?Q?8KFum8I//lfKWvBmLuCMUXxF0RkHNr+o49g8c7ogxmE/6Ho55Ykw0oFgys6y?=
 =?us-ascii?Q?dJO/mif/Y6CiGEdm9FQIN2w6fHGF8pRoWA2qdb36bs6ZygzWGuYv3zmEvnjR?=
 =?us-ascii?Q?oq0Xpsa0gx9noWvwnEQiwFHoEehvHWgL+crlmojYi1VkK1AMWVhZxGRXEj2T?=
 =?us-ascii?Q?SNySFlse0+upz1IyhYyPZBWLnu+mHX/xLurES9cX/kzpf0J9IgaNojnoOhLK?=
 =?us-ascii?Q?5w52XKfywJQQKkoeZgqyuScheW+63aueQHfIUTzmFosEa+e0sdq/Jdr1p4e/?=
 =?us-ascii?Q?MiV+XY/yYImIt2ej3XC2K50SwwcpzMlD2FtEMvQZ05hmGBUL9jpasaOxa58H?=
 =?us-ascii?Q?n250Vi2kqi1GqrhF/XV2QGMSlbZBRIyeSJOh76Rq2SmDTQ1WYUPRps91eHKl?=
 =?us-ascii?Q?4CApev3sP94+krXelludkK8YP6NyaOyFZ1ICW1mmILTTNDrSBAy06BpcopK8?=
 =?us-ascii?Q?ud6H9FZ/dDPODuhy54efPkaXHsJ2happhdCKRAig+OuyiBAepKoio7eu6DAD?=
 =?us-ascii?Q?vB4cGZVm047GRkPlBny82agFEBaDwAx/CPmQbz0ARtIBOnIWkbU9tg7zVmMy?=
 =?us-ascii?Q?tEhibInprA2m/MLTW1+Z19L+JAe1gJ0RvmNG3tK51KU6dE9FCxe3PTwV8cey?=
 =?us-ascii?Q?Rerr78NafD1J7fkQsGXn81eClMfq5sJ9yF8A4b6EHK2kIlQ8UCOdTKcee662?=
 =?us-ascii?Q?b/v+JZR1OvbNAWiLOlKb8xWWb5vEKKhK0F7/aHeZ7CWwxN7kRB3VD8Q6729r?=
 =?us-ascii?Q?4rr3AOWxg6nry5aOiqROKMpGPURFYpwQWtpw+MJcvmj0XvyD3SqoC9Ci6G/k?=
 =?us-ascii?Q?Er9RUl34ykYp0t5tGeMGj5osjwkzHttFvl5ysGmEE91gpx1E0SwXEdAtuKwz?=
 =?us-ascii?Q?kTCIBYgYqOT+ORd8GchF7GUXgMJfb0beWiVo4nQT+v9uY5CxfPjocNFATvKC?=
 =?us-ascii?Q?GgoizCR3J8JmPqWM4SvHcKioP7cYA/YKzqpGqbNyP8hvYe3doaN+xJXomfQn?=
 =?us-ascii?Q?qFzcPwOZtmAun4StbaX1F5rXQdJozDi78QRrnFIPEypH4cBZmCPqG3f+fTGD?=
 =?us-ascii?Q?qmCW/98pgJV39Rc2btCzWqZDlpnQIBMGAdcj0wsGIvqnupkHzFokXqs0nFtl?=
 =?us-ascii?Q?YMPbvafZIx756H9tFOMDRu5l6HOTXL8Ndm7EMKNrvOrq8M6leGgxiPBLUfRZ?=
 =?us-ascii?Q?qX0ByUbAX4VTXKoBVq7/s8g/Z5jtHR58mJ47chucT3VUSo2FIUjoAoVR0RTx?=
 =?us-ascii?Q?zfRtMNBNSKIraCdRwgjIrwOEeUF0hRaXkIRib9Q9PtK8xL6LAfFoG4WdmTPv?=
 =?us-ascii?Q?4EURRYtPqwipgUE9wjo2lYepWoljufXNcJZZr6+pshdZ7KUwQcCNy6w/BJVG?=
 =?us-ascii?Q?taN4brOVM2G6033Eyjo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3d6805-e2e2-442a-8d96-08ddeef1465d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:03:39.5776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/uoxEptzk5+Myh6AlNYpgsTWtRpZWHS1UauhYoZgM/AWfOYXnai9Zb+4KFArPgQv3KrYhTwjdEMvoKzTKP4Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7669

On Mon, Sep 08, 2025 at 04:51:17PM +0530, Manikanta Guntupalli wrote:
> Add an I3C master driver and maintainers fragment for the AMD I3C bus
> controller.
>
> The driver currently supports the I3C bus operating in SDR i3c mode,
> with features including Dynamic Address Assignment, private data transfers,
> and CCC transfers in both broadcast and direct modes. It also supports
> operation in I2C mode.
>
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> ---
> Changes for V2:
> Updated commit description.
> Added mixed mode support with clock configuration.
> Converted smaller functions into inline functions.
> Used FIELD_GET() in xi3c_get_response().
> Updated xi3c_master_rd_from_rx_fifo() to use cmd->rx_buf.
> Used parity8() for address parity calculation.
> Added guards for locks.
> Dropped num_targets and updated xi3c_master_do_daa().
> Used __free(kfree) in xi3c_master_send_bdcast_ccc_cmd().
> Dropped PM runtime support.
> Updated xi3c_master_read() and xi3c_master_write() with
> xi3c_is_resp_available() check.
> Created separate functions: xi3c_master_init() and xi3c_master_reinit().
> Used xi3c_master_init() in bus initialization and xi3c_master_reinit()
> in error paths.
> Added DAA structure to xi3c_master structure.
>
> Changes for V3:
> Resolved merge conflicts.
>
> Changes for V4:
> Updated timeout macros.
> Removed type casting for xi3c_is_resp_available() macro.
> Used ioread32() and iowrite32() instead of readl() and writel()
> to keep consistency.
> Read XI3C_RESET_OFFSET reg before udelay().
> Removed xi3c_master_free_xfer() and directly used kfree().
> Skipped checking return value of i3c_master_add_i3c_dev_locked().
> Used devm_mutex_init() instead of mutex_init().
>
> Changes for V5:
> Used GENMASK_ULL for PID mask as it's 64bit mask.
> ---
>  MAINTAINERS                         |    7 +
>  drivers/i3c/master/Kconfig          |   16 +
>  drivers/i3c/master/Makefile         |    1 +
>  drivers/i3c/master/amd-i3c-master.c | 1014 +++++++++++++++++++++++++++
>  4 files changed, 1038 insertions(+)
>  create mode 100644 drivers/i3c/master/amd-i3c-master.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1af81124bba3..ff603ce5e78d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11693,6 +11693,13 @@ L:	linux-i2c@vger.kernel.org
>  S:	Maintained
>  F:	drivers/i2c/i2c-stub.c
>
> +I3C DRIVER FOR AMD AXI I3C MASTER
> +M:	Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> +R:	Michal Simek <michal.simek@amd.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
> +F:	drivers/i3c/master/amd-i3c-master.c
> +
>  I3C DRIVER FOR ASPEED AST2600
>  M:	Jeremy Kerr <jk@codeconstruct.com.au>
>  S:	Maintained
> diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
> index 13df2944f2ec..4b884a678893 100644
> --- a/drivers/i3c/master/Kconfig
> +++ b/drivers/i3c/master/Kconfig
> @@ -1,4 +1,20 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +
> +config AMD_I3C_MASTER
> +	tristate "AMD I3C Master driver"
> +	depends on I3C
> +	depends on HAS_IOMEM
> +	help
> +	  Support for AMD I3C Master Controller.
> +
> +	  This driver allows communication with I3C devices using the AMD
> +	  I3C master, currently supporting Standard Data Rate (SDR) mode.
> +	  Features include Dynamic Address Assignment, private transfers,
> +	  and CCC transfers in both broadcast and direct modes.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called amd-i3c-master.
> +
>  config CDNS_I3C_MASTER
>  	tristate "Cadence I3C master driver"
>  	depends on HAS_IOMEM
> diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
> index aac74f3e3851..109bd48cb159 100644
> --- a/drivers/i3c/master/Makefile
> +++ b/drivers/i3c/master/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_AMD_I3C_MASTER)		+= amd-i3c-master.o
>  obj-$(CONFIG_CDNS_I3C_MASTER)		+= i3c-master-cdns.o
>  obj-$(CONFIG_DW_I3C_MASTER)		+= dw-i3c-master.o
>  obj-$(CONFIG_AST2600_I3C_MASTER)	+= ast2600-i3c-master.o
> diff --git a/drivers/i3c/master/amd-i3c-master.c b/drivers/i3c/master/amd-i3c-master.c
> new file mode 100644
> index 000000000000..fb768680df45
> --- /dev/null
> +++ b/drivers/i3c/master/amd-i3c-master.c
...
> +/* timeout waiting for the controller finish transfers */
> +#define XI3C_XFER_TIMEOUT_MS			10000
> +#define XI3C_XFER_TIMEOUT			(msecs_to_jiffies(XI3C_XFER_TIMEOUT_MS))

XI3C_XFER_TIMEOUT is not used.

> +
> +#define xi3c_getrevisionnumber(master)						\
> +	((u8)(FIELD_GET(XI3C_REV_NUM_MASK,					\
> +			ioread32((master)->membase + XI3C_VERSION_OFFSET))))
> +
> +#define xi3c_wrfifolevel(master)						\
> +	((u16)(ioread32((master)->membase + XI3C_FIFO_LVL_STATUS_OFFSET) &	\
> +	       XI3C_WR_FIFO_LEVEL_MASK))
> +
> +#define xi3c_rdfifolevel(master)						\
> +	((u16)(ioread32((master)->membase + XI3C_FIFO_LVL_STATUS_1_OFFSET) &	\
> +	       XI3C_WR_FIFO_LEVEL_MASK))

Are you sure that these force type convert is neccesary?

> +
> +#define xi3c_is_resp_available(master)						\
> +	(FIELD_GET(XI3C_SR_RESP_NOT_EMPTY_MASK,					\
> +		   ioread32((master)->membase + XI3C_SR_OFFSET)))
> +
> +struct xi3c_cmd {
> +	void *tx_buf;
> +	void *rx_buf;
> +	u16 tx_len;
> +	u16 rx_len;
> +	u8 addr;
> +	u8 type;
> +	u8 tid;
> +	bool rnw;
> +	bool is_daa;
> +	bool continued;
> +};
> +
> +struct xi3c_xfer {
> +	struct list_head node;
> +	struct completion comp;
> +	int ret;
> +	unsigned int ncmds;
> +	struct xi3c_cmd cmds[] __counted_by(ncmds);
> +};
> +
...
> +
> +static int xi3c_master_write(struct xi3c_master *master, struct xi3c_cmd *cmd)
> +{
> +	unsigned long timeout;
> +	u16 wrfifo_space;
> +	u16 space_index;
> +	u16 len;
> +
> +	len = cmd->tx_len;
> +	if (!cmd->tx_buf || cmd->tx_len > XI3C_MAXDATA_LENGTH)
> +		return -EINVAL;
> +
> +	/* Fill Tx fifo */
> +	wrfifo_space = xi3c_wrfifolevel(master);
> +	for (space_index = 0; space_index < wrfifo_space && cmd->tx_len > 0;
> +	     space_index++)
> +		xi3c_master_wr_to_tx_fifo(master, cmd);

Does common helper function i3c_writel_fifo() help this? look like logic
is similar.

> +
> +	/* Write to command fifo */
> +	xi3c_master_write_to_cmdfifo(master, cmd, len);
> +
> +	timeout = jiffies + XI3C_XFER_TIMEOUT;
> +	/* Fill if any remaining data to tx fifo */
> +	while (cmd->tx_len > 0 && !xi3c_is_resp_available(master)) {
> +		if (time_after(jiffies, timeout)) {
> +			dev_err(master->dev, "XI3C write timeout\n");
> +			return -EIO;
> +		}
> +
> +		wrfifo_space = xi3c_wrfifolevel(master);
> +		for (space_index = 0; space_index < wrfifo_space && cmd->tx_len > 0;
> +		     space_index++)
> +			xi3c_master_wr_to_tx_fifo(master, cmd);
> +	}
> +	return 0;
> +}
> +
...
> +
> +static int xi3c_master_do_daa(struct i3c_master_controller *m)
> +{
> +	struct xi3c_master *master = to_xi3c_master(m);
> +	struct xi3c_cmd *daa_cmd;
> +	struct xi3c_xfer *xfer;
> +	u8 pid_bufs[XI3C_MAX_DEVS][8];
> +	u8 data, last_addr = 0;
> +	int addr, ret, i;
> +	u8 *pid_buf;
> +
> +	u64 *pid_bcr_dcr __free(kfree) = kcalloc(XI3C_MAX_DEVS, sizeof(u64),
> +						 GFP_KERNEL);
> +	if (!pid_bcr_dcr)
> +		return -ENOMEM;
> +
> +	xfer = xi3c_master_alloc_xfer(master, 1);
> +	if (!xfer) {
> +		ret = -ENOMEM;
> +		goto err_daa_mem;
> +	}
> +
> +	for (i = 0; i < XI3C_MAX_DEVS; i++) {
> +		addr = i3c_master_get_free_addr(m, last_addr + 1);
> +		if (addr < 0) {
> +			ret = -ENOSPC;
> +			goto err_daa;
> +		}
> +		master->daa.addrs[i] = (u8)addr;
> +		last_addr = (u8)addr;
> +	}
> +
> +	/* Fill ENTDAA CCC */
> +	data = I3C_CCC_ENTDAA;
> +	daa_cmd = &xfer->cmds[0];
> +	daa_cmd->addr = I3C_BROADCAST_ADDR;
> +	daa_cmd->rnw = 0;
> +	daa_cmd->tx_buf = &data;
> +	daa_cmd->tx_len = 1;
> +	daa_cmd->type = XI3C_SDR_MODE;
> +	daa_cmd->tid = XI3C_SDR_TID;
> +	daa_cmd->continued = true;
> +
> +	ret = xi3c_master_common_xfer(master, xfer);
> +	/* DAA always finishes with CE2_ERROR or NACK_RESP */
> +	if (ret && ret != I3C_ERROR_M2) {
> +		goto err_daa;
> +	} else {
> +		if (ret && ret == I3C_ERROR_M2) {
> +			ret = 0;
> +			goto err_daa;
> +		}
> +	}
> +
> +	master->daa.index = 0;
> +
> +	while (true) {
> +		struct xi3c_cmd *cmd = &xfer->cmds[0];
> +
> +		pid_buf = pid_bufs[master->daa.index];
> +		addr = (master->daa.addrs[master->daa.index] << 1) |
> +		       (!parity8(master->daa.addrs[master->daa.index]));
> +
> +		cmd->tx_buf = (u8 *)&addr;
> +		cmd->tx_len = 1;
> +		cmd->addr = I3C_BROADCAST_ADDR;
> +		cmd->rnw = 1;
> +		cmd->rx_buf = pid_buf;
> +		cmd->rx_len = XI3C_DAA_SLAVEINFO_READ_BYTECOUNT;
> +		cmd->is_daa = true;
> +		cmd->type = XI3C_SDR_MODE;
> +		cmd->tid = XI3C_SDR_TID;
> +		cmd->continued = true;
> +
> +		ret = xi3c_master_common_xfer(master, xfer);
> +
> +		/* DAA always finishes with CE2_ERROR or NACK_RESP */
> +		if (ret && ret != I3C_ERROR_M2) {
> +			goto err_daa;
> +		} else {
> +			if (ret && ret == I3C_ERROR_M2) {
> +				xi3c_master_resume(master);
> +				master->daa.index--;
> +				ret = 0;
> +				break;
> +			}
> +		}
> +	}
> +
> +	kfree(xfer);
> +
> +	for (i = 0; i < master->daa.index; i++) {
> +		i3c_master_add_i3c_dev_locked(m, master->daa.addrs[i]);
> +
> +		pid_bcr_dcr[i] = FIELD_GET(XI3C_PID_MASK,
> +					   get_unaligned_be64(pid_bufs[i]));

you only use pid_bcr_dcr here, needn't dymatic alloc at all.

		u64 data = FIELD_GET(XI3C_PID_MASK, get_unaligned_be64(pid_bufs[i]));
		dev_info(master->dev, "Client %d: PID: 0x%llx\n", i, data);

Frank

> +		dev_info(master->dev, "Client %d: PID: 0x%llx\n", i, pid_bcr_dcr[i]);
> +	}
> +
> +	return 0;
> +
> +err_daa:
> +	kfree(xfer);
> +err_daa_mem:
> +	xi3c_master_reinit(master);
> +	return ret;
> +}
> +
...
> +};
> +module_platform_driver(xi3c_master_driver);
> +
> +MODULE_AUTHOR("Manikanta Guntupalli <manikanta.guntupalli@amd.com>");
> +MODULE_DESCRIPTION("AXI I3C master driver");
> +MODULE_LICENSE("GPL");
> --
> 2.34.1
>
