Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010033.outbound.protection.outlook.com [52.101.84.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DE9270575;
	Wed, 10 Sep 2025 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757523329; cv=fail; b=mz3HotP0Bl7WOz/ORpilKnRpuJa5+GRvYn1mdfyZS3OQ3tbldPStsROQs5tAHTcwpqmNsxB9uOYMjClRToAgjhJxNbPgG8tSgJkOJfPSPSvRtoZZ3TMbCUWh+NlSPz8I0+2h9QRZusuGQSnDN4aPrFaWnURovkN5B+cq1K7/6/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757523329; c=relaxed/simple;
	bh=wdAb5KZuS8dge113OPS3p8T+aGZSh0K5AAVEH6Cp9oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PCFo5SeSiYePBbp6lvTX1XDbY9kTvKVs6zGG8b+eapwRkv98X8JOB08WbwamUawHczCiFX7/7LacxJ1KmPC7gYtBk99/lSmaI2dgMyqwC+9FIOd8XwhGa7BbSeG3vPURjcGNIzVwFI3d5YsG14AZquvcI4rrUCfM1rsd8b7K93E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cOtwBlqJ; arc=fail smtp.client-ip=52.101.84.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cOtwBlqJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFgaGCauxJJNqNXIDnZQvjJ+AZwhPuwBAPuDbvxuB2/oO1zkR6r/ft3Mv8tWfdDs5Vtr2yMDLuA0waU1gcdu8GLLTwnJQ6McQXZVM5edp9VpcUsNc4PEVlipdDWp21iqEGvTvmkdLvGyTPohvU6Xt0aACnoGhvyb1AmWDzPinAsnzN48/y044mTpJvaOkRQ04aP6z4KKj3mmJn6E8iGzT+A/NWM1qUuJ4hwK6A/0NOZJ76vWOWxGOPUkxL302ODL0oIMz81KXcVv7R97sH6DliL80OyCtf1Rnr5fCPVanh/u/t4NCrqFhe3m7jQOZDHklI1N4aH2vdN2ddgJowQmUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zg+HAgrD+dRIWf4B/En+15T8+4Bcxhzf0N9UsSGzJzc=;
 b=PvebZ7UrrP08QNB9LMVegyODDh5pK2x/Wjq/ru2y0EIzK8cs0VPs74pmkG/Ei9hN2mPFy275rmcr/A50V+TPU/4tOf9xK1lr8KdDmldB1kuFbNV+3lQw/QgYXaFp7GLGaoW2g7HbxBXhekPSxZI67cCq7fIsHktybzNo50PMHNAPdh7m+BSm2tHbtNRUEOj1xHA+Vcj/zwDDpiwmy4RjuJ1DZ1KVYu9szyFgUwYJH54beu5GrmpNXP0C8DQSfokkpX4f/MBXNhILrX5IjFnZ45ERT0MXSTin9RPZtGXfm0yyyFMTAlm5b29LJyYNHAlrR+ivWfsg3CpvKIk7HKgPFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zg+HAgrD+dRIWf4B/En+15T8+4Bcxhzf0N9UsSGzJzc=;
 b=cOtwBlqJJJbkdAYn0CwkNxkrotHw2Nkpj6FoTuLqcEAk/P8+wI44HR9J/5D+SPGbk+F0xnNOZIJcn68ZIw2nTjZo7OHOaoVrvtm4XfXlNShdu7UIwdyPzDrf2GmRv/+wS340LXX1AOKwBp9wrPswoaYVWlF+2oom9jssfuv0XYeSCPLKP2GLrZkv07a4815bWN/E0Lao6swSTR1CYMkP7hTXhIAXEDrAcHrv1XpVUCcBU+X771NK98xCqAp0yvNedn7kEEKVeoJ6yr1lI0eZ8ZiLSZGEdPcccHnV5IPJXfIUaahlQ/H/9+QVRjPMtmFtuIib8RoWg5cdbLnAF0pkbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DBBPR04MB7867.eurprd04.prod.outlook.com (2603:10a6:10:1e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Wed, 10 Sep
 2025 16:55:24 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%5]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 16:55:24 +0000
Date: Wed, 10 Sep 2025 12:55:16 -0400
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
Subject: Re: [PATCH V6 2/2] i3c: master: Add AMD I3C bus controller driver
Message-ID: <aMGtdFxlXRanIAuM@lizhi-Precision-Tower-5810>
References: <20250910112954.553353-1-manikanta.guntupalli@amd.com>
 <20250910112954.553353-3-manikanta.guntupalli@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910112954.553353-3-manikanta.guntupalli@amd.com>
X-ClientProxiedBy: PH1PEPF000132F1.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::34) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DBBPR04MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fbb4f1f-5158-4dbf-83ad-08ddf08ad606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8MlwqIILRozSB6QM5SlUwoKd2aKT1GrA2y73sSdDkZFINlOakVT2DgQd+cwI?=
 =?us-ascii?Q?ryo/sB4FC/zI2fSje8Vx/g8uwLq/lq2hn/WTkCWp7sTof6LPUtPl3ap3oUqS?=
 =?us-ascii?Q?fsUGwngfwEqsQD6pv4PFiJjjvjUY/+G3LJC4TifaDGxIxIKcTePh2pUx7Zo/?=
 =?us-ascii?Q?os2QjYei3GvU273OqCJjU5A0rXKMw2ZVi1xQlCUyKBtp0UB++MUpHM+25dBv?=
 =?us-ascii?Q?OPxCUqZr2RmWZCzMdkBNH3mKqFhgaobHb9jz5OsPNEmt0eUSFkY6DR0EAXfQ?=
 =?us-ascii?Q?AlQsncyqJBRybcie8pisWBai8I7gw9QDdk0UI/leTJuCeRCprWPjVMkwPM6w?=
 =?us-ascii?Q?GVEJ7jJmAu8A4aKexyexIe0nk7w5W5dX05hRQio6uu9gzSWkzd/ZNYaKSCNg?=
 =?us-ascii?Q?hZ9l3mAIs0xFy6xshEZcvPV+4SMmEazMewepkV8orPj/wyhlWvlBsv2MbjZu?=
 =?us-ascii?Q?pml18Nw9dIy2UKu7J1Sa8fSXhJUIpOKijYOmeeIn3iC/A38g9zoBYZ17mDWK?=
 =?us-ascii?Q?C3V+gaiExsgwOP+4zlK+2IteJ/H5sYWO/NFATSws6hS5DWEkcigT9EmWPDV8?=
 =?us-ascii?Q?ZCfvreBsfTT0/Vkfsch9PFyvEoJ2H6wh8kV3D13s8NPgU+QEJs/w9OekSpAZ?=
 =?us-ascii?Q?+hPO+B92VCaIlyvB+w4qdB9TDDSI+QiWtj7/eT5CQpfepBk50RfIjl4U6+XZ?=
 =?us-ascii?Q?JYsLXqMaR+mxXN/FitEE+tXeZTneiF6i2cXba6Xd4s+uxHRcyhzvbnydPrl1?=
 =?us-ascii?Q?lGpnLs1TDxdhk3LmrLHxnnqcm+EE36WP15scrvtUznUu5iLpZ+YsydMnyB+L?=
 =?us-ascii?Q?HhYUVd1LK8CPf6bTbfymNocN2EIfKayKU2BXY4TnY3MEXRv7XJtjhj4Sx7nN?=
 =?us-ascii?Q?jKD7YCx0DjY25WQq4VwbN2KrCsQxwEELKW3tQVj8rWgwxNlLRWI2XGVZq7UD?=
 =?us-ascii?Q?S4kpS02BabjuNjHk3tlOmj3fLiuYuGX569GluOzKhOHm2DlDOL/vFL552dP2?=
 =?us-ascii?Q?EtAkm59Mu2KVz8AZUBd+68sg85O2xg/vvEQzy+0BbZ6DzN+1e9C2izcwX4sk?=
 =?us-ascii?Q?IoJx5B6Bs2pzHFNJkG6p0pRx5YWXhz57feKzrGCC8rrzAPkwtuaJlp23npJC?=
 =?us-ascii?Q?G/9S3BLg1IazTUVdtZCzrcncczw98YPoycIfT4/5Ov9XJkVJa8ERAvT+vr3l?=
 =?us-ascii?Q?QF224Lw04xKS+N8e8WR/J4hWjKmu40MnC3dDmF64S4PxsV5Am47O6jGpsssT?=
 =?us-ascii?Q?wMJtF9f3Ak3dQGXFCWNInNLF+DwF+MVal6E86k8YAY6mxvNOvC89ASMR6kwe?=
 =?us-ascii?Q?3J/5l57T/16iRTDvLlLrn/lYmp/zrC9dj1GYGB8ILxrOpP81cfI2jbdPXM8K?=
 =?us-ascii?Q?t6jK85oVL4IykSjJ0bOzT+Sob4EBHwZvlWyRd45PaS7qiTe9za/xFS3Bfu4B?=
 =?us-ascii?Q?ieZj7Prm1Ek=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8ttn3rinyP+I19ZkOpHKmIRp0anzyGW6T6hz/91KGF4jom/HnYvPvtSMh7jS?=
 =?us-ascii?Q?e+B5GcYRa9rdoJAxYoqXeIYGqn+dMqmobqD8ATu2sFN6zmaSfGhA0ZPck/BZ?=
 =?us-ascii?Q?14H31UZrRdKQws7imD23o5KNWpAtKPKXcJNoGiiLhql/HVbLNScK2RAZY+7H?=
 =?us-ascii?Q?hwmFLBdH/drIGXaNmto4kmxsdgRf4n0bSzLQcQJsZucOYxssTU9xGvw2UzOs?=
 =?us-ascii?Q?UGWMLvhF90oWFZzhdf7RBiZoIfRzQRcwC+JamKtg3NAeRrWhMgEIXoXfz34P?=
 =?us-ascii?Q?BydHuOEk2yZmOSQ5ESDrtHy0IedQrMag1cP3u+2N34wo0icHGT+h+8V7bCKt?=
 =?us-ascii?Q?xNWo8AHdfLwhcykb6hwm4Wjo9rwtOHQWG+uLYtDAt1koUFtVjKPAVKBcXyon?=
 =?us-ascii?Q?tkm8wtv3BC5V8lNquonCd66n70n6OYYU/UEiZ6B47BbbEchaeTowuqUGoAh9?=
 =?us-ascii?Q?hAB0Xml7N4EWi9q4i3CEtFCYpFcsD39M4WCi4LsEdv31F79aYQsPSIRJuXXU?=
 =?us-ascii?Q?2DKvuxStGzMMK5VJcQK+W0XPI9NQndlsa7tl7y8co2kgYrS3yf2FR/TswSao?=
 =?us-ascii?Q?jQaa2h5pGvyBXpItgowtJEXlFahn7+hNU5LEcZCe5YQ5/faRLbABBID1rqlM?=
 =?us-ascii?Q?j520mOkOw9Jw2Zgpfr92U3onLVQRcEQcJZk6m/aOOA4kEOK7H4/WNmXT25MA?=
 =?us-ascii?Q?HRc92HLu7xwo9Khs6X2bN+8lYxovZ5lW9kfNk2p/T8pHik8YHCkiQGyms21j?=
 =?us-ascii?Q?nqe26FC/DqUozi6paon5lgxWKshwvibMGTv6eE4SC/r/FDhLiCmVvp3Wb77w?=
 =?us-ascii?Q?ueC5zqjCmwIprxfvH/hKhrCpzkDpJR50odn6d59b/U+iTr/XQhQzeyWqlb5W?=
 =?us-ascii?Q?LvFEPgm+rjMstTQsjpPfmIvJuAB7kMdG+qIrivvBLViwG5Ak1w3XKE1IusCC?=
 =?us-ascii?Q?SBkYGPtgt+Yqis4R+nEKCbyOoLwziHRImI7LP3t9KgqYls4fLGZyCrDBr6wn?=
 =?us-ascii?Q?9KUWVERTn2q3vasZ7ZM/+VjtDtpDXK7/j1WunpBki1n6D1p50HSsp89k/Vs8?=
 =?us-ascii?Q?nxlQ/DnFSLRDJUbjaDac+ldPY2DAffZMejO/19nJ3s8XQf1qtom4E9CljsG7?=
 =?us-ascii?Q?GPCJKyA7xlCKrGdVJ0NqVs3mayIjnUBDCCs/clxEGKRlXf28smws45LikDd8?=
 =?us-ascii?Q?jE1pV2587fCqDK+fmZLNCy9/Hqnhqyi56NzA7FWMsgWyNWELyvxwsJmMH+uI?=
 =?us-ascii?Q?s4jb6w+IgyG/xMdv5Ggax27R6lXI3fVAHbFHGF8fxxYX8UbuLoIkmBEFToRZ?=
 =?us-ascii?Q?6kB7u4xrqjJU8Rw3o3/PHs/lfYGaDB91jM92x9VfaKgolkSpS6ommIio8+kC?=
 =?us-ascii?Q?lJ4LaFo7PGpl2ivUDVmLfYQVt/AXJhCEZXoLWwng0fVAG8ppOBA2MRq+qadv?=
 =?us-ascii?Q?NhlZCSXEeSoVeEi46tdu2Rz6OdMDY1W52+AgzoNttk5vADedIPmb+i1boeD6?=
 =?us-ascii?Q?rFCNYtm2dIMGiPb8VThmvTCo0w/yfOvJswijNzf3qOEzN+G/NHyu42nsSxWj?=
 =?us-ascii?Q?vnB1OqfSjHRKO96WgdKhErSynSM1bdZzzFzXNkSF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbb4f1f-5158-4dbf-83ad-08ddf08ad606
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 16:55:24.5498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvUClU+F9COVPJNeJ3x8zfWF3+SBpVSNMEulpfm80ASaFE0f8gibz5QqYB3a/FqcVV5tZ5GzmVGAGfFv8qtCvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7867

On Wed, Sep 10, 2025 at 04:59:54PM +0530, Manikanta Guntupalli wrote:
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
>
> Changes for V6:
> Removed typecast for xi3c_getrevisionnumber(), xi3c_wrfifolevel(),
> and xi3c_rdfifolevel().
> Replaced dynamic allocation with a static variable for pid_bcr_dcr.
> Fixed sparse warning in do_daa by typecasting the address parity value
> to u8.
> Fixed sparse warning in xi3c_master_bus_init by typecasting the pid value
> to u64 in info.pid calculation.
> ---
>  MAINTAINERS                         |    7 +
>  drivers/i3c/master/Kconfig          |   16 +
>  drivers/i3c/master/Makefile         |    1 +
>  drivers/i3c/master/amd-i3c-master.c | 1009 +++++++++++++++++++++++++++
>  4 files changed, 1033 insertions(+)
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
> index 000000000000..cd9d85a0be80
> --- /dev/null
> +++ b/drivers/i3c/master/amd-i3c-master.c
> @@ -0,0 +1,1009 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * I3C master driver for the AMD I3C controller.
> + *
> + * Copyright (C) 2025, Advanced Micro Devices, Inc.
> + */
> +
...
> +
> +/* timeout waiting for the controller finish transfers */
> +#define XI3C_XFER_TIMEOUT_MS			10000
> +#define XI3C_XFER_TIMEOUT			(msecs_to_jiffies(XI3C_XFER_TIMEOUT_MS))

Do I missed your reply? I have not seen
https://lore.kernel.org/linux-i3c/aL7+Urm4NB9kwOwQ@lizhi-Precision-Tower-5810/

If you need define two macro for it. Need unit XI3C_XFER_TIMEOUT_JIFFIES to
avoid confuse.


> +
> +#define xi3c_getrevisionnumber(master)						\
> +	(FIELD_GET(XI3C_REV_NUM_MASK,						\
> +		   ioread32((master)->membase + XI3C_VERSION_OFFSET)))
> +

...

> +static void xi3c_master_wr_to_tx_fifo(struct xi3c_master *master,
> +				      struct xi3c_cmd *cmd)
> +{
> +	u8 *tx_buf = (u8 *)cmd->tx_buf;
> +	u32 data = 0;
> +	u16 len;
> +
> +	len = cmd->tx_len;
> +	if (len > 0) {
> +		len = (len >= XI3C_WORD_LEN) ? XI3C_WORD_LEN : len;
> +		memcpy(&data, tx_buf, len);
> +		tx_buf += len;
> +		cmd->tx_len -= len;
> +	}
> +	cmd->tx_buf = tx_buf;
> +
> +	/* Write the 32-bit value to the Tx FIFO */
> +	iowrite32be(data, master->membase + XI3C_WR_FIFO_OFFSET);
> +}

i3c_writel(readl)_fifo() did similar things, why not use it?

Did you miss my review comment or I missed your reply?

Frank

...
> +
> +static const struct of_device_id xi3c_master_of_ids[] = {
> +	{ .compatible = "xlnx,axi-i3c-1.0" },
> +	{ },
> +};
> +
> +static struct platform_driver xi3c_master_driver = {
> +	.probe = xi3c_master_probe,
> +	.remove = xi3c_master_remove,
> +	.driver = {
> +		.name = "axi-i3c-master",
> +		.of_match_table = xi3c_master_of_ids,
> +	},
> +};
> +module_platform_driver(xi3c_master_driver);
> +
> +MODULE_AUTHOR("Manikanta Guntupalli <manikanta.guntupalli@amd.com>");
> +MODULE_DESCRIPTION("AXI I3C master driver");
> +MODULE_LICENSE("GPL");
> --
> 2.34.1
>
