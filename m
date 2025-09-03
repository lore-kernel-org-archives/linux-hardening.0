Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013027.outbound.protection.outlook.com [40.107.162.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75062DAFC3;
	Wed,  3 Sep 2025 14:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756909692; cv=fail; b=T7HlTiAfqb4E96OPcFlvDbcHjjx6ruvljl0rv8Ri3YQURuSzulgUGqIhuAkFNLSr4SKWK9SYygKPeYd5XBOPut1xwXhfq/QlCk5FKcHpgcoPJc2+hibu0pu+BaRk+EuIXeRwXE5060G8vCCqTQQIG37mHDlBbD5bTVnvlBNkv5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756909692; c=relaxed/simple;
	bh=I+KWfV6pqZMNAxTuRQ/b+YmDm6pp0UDqqWW+c9BMU8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cRKqXWTZ9ZiXM2ydF6NoqeEmYHfYQ80nQ5L/QQfdW22GZBJ40nyMAHWwcNN+X2DrQbsYq+wR8dFZF3tYSpQYbK0IKsq9UlMGfPBKBJqZoiA7ausqWqwPTgM87FVlg0iGzV0Fj+GwzNTusQfpIPTZEdTEyXG/yxNwCN+LcWq0rP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G3WNN/db; arc=fail smtp.client-ip=40.107.162.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G3WNN/db"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lEjDjiWP2nOfpaQG4qekd2EYdYqHJMMkkyWDKlBqPg32uYxaJcsWWWnbx3nbozywqrVlsyajlclSHxjavGQPVk+AaI4Q6cRDl/o81vwnBWRdGjDYloNIEChJrW2R2bIHnYkt73Kzm5Uk3z3KcnThilDqGCwkS9+n7aHjXZPIreCXwsF7baM9KDqRe4G5X+cb7KnAobdmlda81N6mS9pEFQGbVDmu3tIo7sxNXlNy/VFJe3Y4e6pCaXV0m6Wnu/Oo+RkYG4+XVELeMJtZH3s+j8esJ9ZHKer/BS7UUfhlOac1vxqlspYYkoWth7LnJbjfaFT11vBLlAgOeehFkNptfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYuLpsyKjvb+t38yBcDIYEiLw49YqMJq3mMxFMb+97U=;
 b=qrH1779q0dE7TsjnR7TV0w7c7P1fidaHqaZOQ13+VyyvyvniKbBwrMgE+bl6um2oENEOrmXl3iuVeYNpK9diIYncmEQF6AaOYQjMTHpMQNg0zFYFlzJJjDDSuWhpMooOuuXq5K6ocu5EClvbMDpE/jYiOh5yuqKSrQJ+Kc3pK+B3kLKcPxlXm3NmIvCZDfqQwYDm4teqwTzDrMO/OreCbM8SvpzWPF9/+L32nPWcFkq8l0Nmd2VeLZWBMxnp8pMbrTXa7D+mDgr6cBH4Xrdo13IcrrhMiOClqZtCy89ai2C2DyC2nhaAEbKFTBSC/IAPEHaZUZtmeX48QWWwNGGiew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYuLpsyKjvb+t38yBcDIYEiLw49YqMJq3mMxFMb+97U=;
 b=G3WNN/dbVkRRzQQz+x+n2QTbUnZyJPDDN3iS8BdDaPVZ597cykpNKmzZEXxISEOwhs0LOhk8cUEYMvOtbwfW20Cs6cVVtlk140H/hHx6le8h/IARETs//1MyDtUWkUChDam2rtPuQUV1/oEKvuhAkJhHIphdbQWTDO5FDfFV5Aoko+EF2piC4h+NcHQBG9DJIA/MVCL2Ri9dZRWG0CwXZdUs09QG3vI81G5zDBhNzDrwBcKxM3FvLmuC+EiOYvRKiWJ8lgde5i2oxx8Pl7ROrxKoll34vCUxSaZLqLdU8LipJhVcDpK/Tmg6/ACmBTlG6QdriQhSio8khYMSBXBj6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM8PR04MB7299.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 14:28:05 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 14:28:05 +0000
Date: Wed, 3 Sep 2025 10:27:56 -0400
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
Subject: Re: [PATCH V2 2/2] i3c: master: Add AMD I3C bus controller driver
Message-ID: <aLhQbDjeoEukMgpy@lizhi-Precision-Tower-5810>
References: <20250829171327.2590730-1-manikanta.guntupalli@amd.com>
 <20250829171327.2590730-3-manikanta.guntupalli@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829171327.2590730-3-manikanta.guntupalli@amd.com>
X-ClientProxiedBy: BY5PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::32) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM8PR04MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: b367c0b5-3e9e-4654-f833-08ddeaf618bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|52116014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5MYhoIQFH3xtKrPTXrL7O2IgnUw9lL99EKVv2iMI2xQLatQuOe1jRd46NICF?=
 =?us-ascii?Q?fxDDoZwkh/mqegVj3hHrWkM4yw5ilxCsPd0KA69qUcK+W0CxxTsZ9Og/sAVN?=
 =?us-ascii?Q?9YrjDEYGabsRkYR8ok493hWDBIdZUkZTQbQRJMWIXrD1k6GEipDmXzN1lIbQ?=
 =?us-ascii?Q?MswkUeyHLY6hDPkIHMFauhmV1reMLfPCGohSQeK5m/mBty9fIboHi8xHV/vC?=
 =?us-ascii?Q?splgBIp3mPXEF/5g0iqcUf5oXDZ3a0VorzCLJ4uV296SLrMYkWOi55u+096X?=
 =?us-ascii?Q?ckqdmT+hzcgF+pQIwFXa4W6us0gIJ3jZ1JFIx5Ksr8hjWd+QnPUEZcT1r9os?=
 =?us-ascii?Q?c+3PHSUHteVfQaqU5DYrt3itiEK+1oqsWwuk++IjBGML8qUpb2WPh+ycFzK+?=
 =?us-ascii?Q?vDhQSDxyhWXhqdE/wE3L/IgEMcKdEAmWIfVHZAQzdJomhDeYTD8XH6lMjrqw?=
 =?us-ascii?Q?fC2J5O197jsENTbdXFi3wQQ3rFK3L5yM+MgeNEcMooy2yqnDmw5mAfj/3U+1?=
 =?us-ascii?Q?lD4Jbr0Ezr4YSGU9t5Zh9R/XvY8pwojzI06r125okUqqJJPtc+HlszZEgO6r?=
 =?us-ascii?Q?2/aK5x//9nRM5PygaCHiYZ56g68+JSC9XEi+2xy9FHH3hVSEimc6j8lZStNJ?=
 =?us-ascii?Q?RJl6u86w3nSyrNh2OccLifBMCwZqsi8EfBUsncKjd0v2wRvsEMAPmpXxAgkP?=
 =?us-ascii?Q?JRK6QWHryrJh4F/aIKpmc5ta/9kDI7WVvvvbbHj1XexBfLvY4aAe5lZ1eFpA?=
 =?us-ascii?Q?TGSY1gDmXhLualGaSyFRFUoCy6AMjYVVqYQPpR2zHB228QofvTPfhB+xfpjs?=
 =?us-ascii?Q?5URVWtPTRfRtk0JBz/fLTTQWR6+ikTQsPJRVxAMPhBTmcJEaSEzOkzjOnz/p?=
 =?us-ascii?Q?Xpst19bvgYizSKozWg81uKGpdrd4KuSu7U7AMeDyljJDGXN4HcIjULs7xaiz?=
 =?us-ascii?Q?copYQc0KMJFiAg5gcBsDyzr138razU4kEXSEOFjoAA1bPHvn5PCUx2aEkT+o?=
 =?us-ascii?Q?gcHFkqvoZAK57Uiya6SsD11isLjdJ6w0mH1o29DpYECfhvpKv1uQ8Vh4jrFp?=
 =?us-ascii?Q?h2cWC6XUMTnUsWFTkkkprVE+GAC2095zq3A0U9MjIx974bs8f9FVlma8uOAQ?=
 =?us-ascii?Q?vjJIqSo1G8EnVlt6NDavI1FyWLHvFOdwyVCkmlmV7RWTyF8W7fqOgLAxVHx5?=
 =?us-ascii?Q?IlyOj17Sm1lKPVO2WhAHu6f6Yf/0NR5PlF/QTYzFDkO59iAHwxY31gAK8jlD?=
 =?us-ascii?Q?gMsV6t9FOdhpSLzHarGG6buVVpOwZrxINyrOqU/dI2XcTJBApnfoaHtl+dNG?=
 =?us-ascii?Q?JOqcyLNVhQDTwHXnjWtaiXdUfbrpQ0om/gu28dJFtszYLhBcjWYYCGeXSfNo?=
 =?us-ascii?Q?BgSp0dFxrGW3rgmRHxF6ZVrR6TEM7pdodKNDwmbizXv+6IqIsG47GeB6Q55T?=
 =?us-ascii?Q?QYW509Ry24V7ty7XW8U1fo4mSAcVrJeApjW/yCn1f/OqbmM61J1sCQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(52116014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N2wB/SyeD0N45U08BqsRfwinX8OieIAuNIc6SzoQthVtvNhXQ7zxQaI5N6aV?=
 =?us-ascii?Q?wT70z6ijDVsnY1o/feOoo3kCUYArP+QAdD18/GqAGxzE0+uo6oGperGQC6GH?=
 =?us-ascii?Q?HUt6saE6OQ2n7d+UF8ZqHsCdAvWkkhIkG3kkiL01S/sEMIqt/dWk4vznODy/?=
 =?us-ascii?Q?Bg4qwNQwp32clUhm4RU9sMvP3D2BebG6x1CyMeCSvFkFSc8D8lgkEJzHwylc?=
 =?us-ascii?Q?Z6gja/N/3Y7qPODBGh+6g6nLTXOCcp3J0+XwoL4TW+Kq6jgEHsMzvQTFp0RB?=
 =?us-ascii?Q?QH9DOr2XwDbOlPxTr3R47tNp40vZEGtTqObaAuQDgbgjbtZecoLB10XqKs4C?=
 =?us-ascii?Q?uyi9tMZovgCoLiqh9TEeScreW0uuL66B/euEoWglESQG7BoWhsyINmyGJMIv?=
 =?us-ascii?Q?2UVEcBq8bHDGmdegVOEwyJcrPUmDaoZAIWXGzGmoAyElkhSKX2ZTUIGF/cdU?=
 =?us-ascii?Q?KzlMLipImkbDBmcQXjaUEGQsoeYaWuQOpbA9ooKqmvpMY08A57MY9GrvIgg4?=
 =?us-ascii?Q?KKCEtCdw26C25VvbKlwG7f0dkZHfqROSUW3LbwodWjKivPYv7c0U3oKJbT18?=
 =?us-ascii?Q?M5g75WedaojTsKRQaOHWFgNmynyVLE2hhnjMtjmiczTWRI4Ifk+qRBMlP95S?=
 =?us-ascii?Q?Idkl3eejT/KmkVpRcD+kUSRj9mriSIJcUYR2LG94KVeGS1bSjGcZn/xww+Ig?=
 =?us-ascii?Q?/MDHc8zFTaohOJ77b06U1q0VauRvJiAyrNhSHUYzw45VbQib3YXe2Oc2Y2cJ?=
 =?us-ascii?Q?nHqYwH/6jStEGoY46Gzam+iVsuC1s3JjHQZl4p6suFLM1rRojMG/s2HQeLRa?=
 =?us-ascii?Q?A+FBlAdL0M5mLo+raz23FYvwwm1gNXlamGzDFPY7MlNZ13OL/UlzaEWuMYiU?=
 =?us-ascii?Q?MEaWiXXnqdxeX+NYu3zQmEbn6OY3ixMAAw7hs3hw7oq+pIcJl7PqxAnMIhAh?=
 =?us-ascii?Q?49rHRW0CdBLhqHdAkw4Jwpg03PyxHMj4DLGP3XM/4xIkYksu670JKbbcFQia?=
 =?us-ascii?Q?+q1Fzt7aMjaFsOwIbOefOaCkXu8QZd5LjxR9ATYCP9KVNSntWNXk07ZJP53w?=
 =?us-ascii?Q?JxREcoVulyu0cYNLGIs2MXH7M9dVb5yUE8KLP7Nq+GAXMNEM52s1XAkAyhUX?=
 =?us-ascii?Q?cD4yE4Quf/8rg5UTdZTyYP/S3zeDWoTm13jJUalrmF8VzLxVe4i488KB63GZ?=
 =?us-ascii?Q?e1BkZa7uXoOthvHuk44GfKEqGnv24sVrqFG34bKjx1uhngGfS3+/vHs85xBT?=
 =?us-ascii?Q?XaJkLBIP/BZTJvqJ2dIBgvPHTNZi0TmwkTQ2fVBnJJ0hP74MgMgHlOwPcu/Y?=
 =?us-ascii?Q?oql0K2MspPeKl162nzzDszV0rJQXL3cxvc5zk4EhMC4/hMX82eXaW/i/zTDo?=
 =?us-ascii?Q?IhfjQ4ftsfcTyvF9pWKeTOkbTYCHboT6bOwF+QsMc6Rk0fkTEvg2hw7amC1d?=
 =?us-ascii?Q?G9BHvGkVCoN0U2qv3E3p8SkOBTJwuX+3rQf8QQUth1wFg08B5iD9fgpLBFvy?=
 =?us-ascii?Q?1yWUrVHEKwc4qSX+u6jGY/JPpNxRecYy6cCdqjFQBtA92Dl4iypsXPmb4y5/?=
 =?us-ascii?Q?3K0Kir++wgVULJ5t+mw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b367c0b5-3e9e-4654-f833-08ddeaf618bc
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 14:28:05.7758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jp5oTCQP6N+bYVJR5JXYBbd+18qjgr3vWqXazbzA+kBBchkmqQcG9xMIZsELTHZju/hgjSyQ3SEfc6xGWUGcBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7299

On Fri, Aug 29, 2025 at 10:43:27PM +0530, Manikanta Guntupalli wrote:
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
> ---
>  MAINTAINERS                         |    7 +
>  drivers/i3c/master/Kconfig          |   16 +
>  drivers/i3c/master/Makefile         |    1 +
>  drivers/i3c/master/amd-i3c-master.c | 1009 +++++++++++++++++++++++++++
>  4 files changed, 1033 insertions(+)
>  create mode 100644 drivers/i3c/master/amd-i3c-master.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0cb9e55021cb..28ee1554cb0b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11416,6 +11416,13 @@ L:	linux-i2c@vger.kernel.org
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
> index 77da199c7413..a77d288d2464 100644
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
>  	depends on I3C
> diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
> index 3e97960160bc..c0167aa1f1b3 100644
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
> index 000000000000..f74febe4d17d
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
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/i3c/master.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/ioport.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/unaligned.h>
> +
> +#define XI3C_VERSION_OFFSET			0x00	/* Version Register */
> +#define XI3C_RESET_OFFSET			0x04	/* Soft Reset Register */
> +#define XI3C_CR_OFFSET				0x08	/* Control Register */
> +#define XI3C_ADDRESS_OFFSET			0x0C	/* Target Address Register */
> +#define XI3C_SR_OFFSET				0x10	/* Status Register */
> +#define XI3C_CMD_FIFO_OFFSET			0x20	/* I3C Command FIFO Register */
> +#define XI3C_WR_FIFO_OFFSET			0x24	/* I3C Write Data FIFO Register */
> +#define XI3C_RD_FIFO_OFFSET			0x28	/* I3C Read Data FIFO Register */
> +#define XI3C_RESP_STATUS_FIFO_OFFSET		0x2C	/* I3C Response status FIFO Register */
> +#define XI3C_FIFO_LVL_STATUS_OFFSET		0x30	/* I3C CMD & WR FIFO LVL Register */
> +#define XI3C_FIFO_LVL_STATUS_1_OFFSET		0x34	/* I3C RESP & RD FIFO LVL Register */
> +#define XI3C_SCL_HIGH_TIME_OFFSET		0x38	/* I3C SCL HIGH Register */
> +#define XI3C_SCL_LOW_TIME_OFFSET		0x3C	/* I3C SCL LOW  Register */
> +#define XI3C_SDA_HOLD_TIME_OFFSET		0x40	/* I3C SDA HOLD Register */
> +#define XI3C_TSU_START_OFFSET			0x48	/* I3C START SETUP Register  */
> +#define XI3C_THD_START_OFFSET			0x4C	/* I3C START HOLD Register */
> +#define XI3C_TSU_STOP_OFFSET			0x50	/* I3C STOP Setup Register  */
> +#define XI3C_OD_SCL_HIGH_TIME_OFFSET		0x54	/* I3C OD SCL HIGH Register */
> +#define XI3C_OD_SCL_LOW_TIME_OFFSET		0x58	/* I3C OD SCL LOW  Register */
> +#define XI3C_PID0_OFFSET			0x6C	/* LSB 4 bytes of the PID */
> +#define XI3C_PID1_BCR_DCR			0x70	/* MSB 2 bytes of the PID, BCR and DCR */
> +
> +#define XI3C_CR_EN_MASK				BIT(0)	/* Core Enable */
> +#define XI3C_CR_RESUME_MASK			BIT(2)	/* Core Resume */
> +#define XI3C_SR_RESP_NOT_EMPTY_MASK		BIT(4)	/* Resp Fifo not empty status mask */
> +
> +#define XI3C_BCR_MASK				GENMASK(23, 16)
> +#define XI3C_DCR_MASK				GENMASK(31, 24)
> +#define XI3C_PID_MASK				GENMASK(63, 16)
> +#define XI3C_SCL_HIGH_TIME_MASK			GENMASK(17, 0)
> +#define XI3C_SCL_LOW_TIME_MASK			GENMASK(17, 0)
> +#define XI3C_SDA_HOLD_TIME_MASK			GENMASK(17, 0)
> +#define XI3C_TSU_START_MASK			GENMASK(17, 0)
> +#define XI3C_THD_START_MASK			GENMASK(17, 0)
> +#define XI3C_TSU_STOP_MASK			GENMASK(17, 0)
> +#define XI3C_REV_NUM_MASK			GENMASK(15, 8)
> +#define XI3C_PID1_MASK				GENMASK(15, 0)
> +#define XI3C_WR_FIFO_LEVEL_MASK			GENMASK(15, 0)
> +#define XI3C_CMD_LEN_MASK			GENMASK(11, 0)
> +#define XI3C_RESP_CODE_MASK			GENMASK(8, 5)
> +#define XI3C_ADDR_MASK				GENMASK(6, 0)
> +#define XI3C_CMD_TYPE_MASK			GENMASK(3, 0)
> +#define XI3C_CMD_TID_MASK			GENMASK(3, 0)
> +#define XI3C_FIFOS_RST_MASK			GENMASK(4, 1)
> +
> +#define XI3C_OD_TLOW_NS				500000
> +#define XI3C_OD_THIGH_NS			41000
> +#define XI3C_I2C_TCASMIN_NS			600000
> +#define XI3C_TCASMIN_NS				260000
> +#define XI3C_MAXDATA_LENGTH			4095
> +#define XI3C_MAX_DEVS				32
> +#define XI3C_DAA_SLAVEINFO_READ_BYTECOUNT	8
> +
> +#define XI3C_I2C_MODE				0
> +#define XI3C_I2C_TID				0
> +#define XI3C_SDR_MODE				1
> +#define XI3C_SDR_TID				1
> +
> +#define XI3C_WORD_LEN				4
> +
> +/* timeout waiting for the controller finish transfers */
> +#define XI3C_XFER_TIMEOUT			(msecs_to_jiffies(10000))
> +#define XI3C_XFER_TIMEOUT_MS			10000

Only define one TIMEOUT should be enough

s/XI3C_XFER_TIMEOUT/(msecs_to_jiffies(XI3C_XFER_TIMEOUT_MS))

> +
> +#define xi3c_getrevisionnumber(master)						\
> +	((u8)(FIELD_GET(XI3C_REV_NUM_MASK,					\
> +			readl((master)->membase + XI3C_VERSION_OFFSET))))
> +
> +#define xi3c_wrfifolevel(master)						\
> +	((u16)(readl((master)->membase + XI3C_FIFO_LVL_STATUS_OFFSET) &		\
> +	       XI3C_WR_FIFO_LEVEL_MASK))
> +
> +#define xi3c_rdfifolevel(master)						\
> +	((u16)(readl((master)->membase + XI3C_FIFO_LVL_STATUS_1_OFFSET) &	\
> +	       XI3C_WR_FIFO_LEVEL_MASK))
> +
> +#define xi3c_is_resp_available(master)						\
> +	((u8)(FIELD_GET(XI3C_SR_RESP_NOT_EMPTY_MASK,				\
> +			readl((master)->membase + XI3C_SR_OFFSET))))

Are you sure need type force convert at above macro?

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
> +/**
> + * struct xi3c_master - I3C Master structure
> + * @base: I3C master controller
> + * @dev: Pointer to device structure
> + * @xferqueue: Transfer queue structure
> + * @xferqueue.list: List member
> + * @xferqueue.cur: Current ongoing transfer
> + * @xferqueue.lock: Queue lock
> + * @membase: Memory base of the HW registers
> + * @pclk: Input clock
> + * @lock: Transfer lock
> + * @daa.addrs: Slave addresses array
> + * @daa.index: Slave device index
> + */
> +struct xi3c_master {
> +	struct i3c_master_controller base;
> +	struct device *dev;
> +	struct {
> +		struct list_head list;
> +		struct xi3c_xfer *cur;
> +		/* Queue lock */
> +		spinlock_t lock;
> +	} xferqueue;
> +	void __iomem *membase;
> +	struct clk *pclk;
> +	/* Transfer lock */
> +	struct mutex lock;
> +	struct {
> +		u8 addrs[XI3C_MAX_DEVS];
> +		u8 index;
> +	} daa;
> +};
> +
> +static inline struct xi3c_master *
> +to_xi3c_master(struct i3c_master_controller *master)
> +{
> +	return container_of(master, struct xi3c_master, base);
> +}
> +
> +static int xi3c_get_response(struct xi3c_master *master)
> +{
> +	u32 resp_reg, response_data;
> +	int ret;
> +
> +	ret = readl_poll_timeout(master->membase + XI3C_SR_OFFSET,
> +				 resp_reg,
> +				 resp_reg & XI3C_SR_RESP_NOT_EMPTY_MASK,
> +				 0, XI3C_XFER_TIMEOUT_MS);
> +	if (ret) {
> +		dev_err(master->dev, "AXI I3C response timeout\n");
> +		return ret;
> +	}
> +
> +	response_data = readl(master->membase + XI3C_RESP_STATUS_FIFO_OFFSET);
> +
> +	/* Return response code */
> +	return FIELD_GET(XI3C_RESP_CODE_MASK, response_data);
> +}
> +
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
> +
> +static void xi3c_master_rd_from_rx_fifo(struct xi3c_master *master,
> +					struct xi3c_cmd *cmd)
> +{
> +	u32 data;
> +	u16 len;
> +
> +	/* Read from Rx FIFO */
> +	data = ioread32be(master->membase + XI3C_RD_FIFO_OFFSET);
> +
> +	/* Data extraction to rx buffer */
> +	len = cmd->rx_len;
> +	if (len > 0) {
> +		len = (len >= XI3C_WORD_LEN) ? XI3C_WORD_LEN : len;
> +		memcpy((u8 *)cmd->rx_buf, &data, len);
> +		cmd->rx_buf = (u8 *)cmd->rx_buf + len;
> +		cmd->rx_len -= len;
> +	}
> +}

Check i3c_writel_fifo() and i3c_readl_fifo(), which do the similar thing.

> +
> +static void xi3c_master_write_to_cmdfifo(struct xi3c_master *master,
> +					 struct xi3c_cmd *cmd, u16 len)
> +{
> +	u32 transfer_cmd = 0;
> +	u8 addr;
> +
> +	addr = ((cmd->addr & XI3C_ADDR_MASK) << 1) | (cmd->rnw & BIT(0));
> +
> +	transfer_cmd = cmd->type & XI3C_CMD_TYPE_MASK;
> +	transfer_cmd |= (u32)(!cmd->continued) << 4;
> +	transfer_cmd |= (u32)(addr) << 8;
> +	transfer_cmd |= (u32)(cmd->tid & XI3C_CMD_TID_MASK) << 28;

Can you use GEN_MASK to avoid hardcode 4, 8, 28

> +
> +	/*
> +	 * For dynamic addressing, an additional 1-byte length must be added
> +	 * to the command FIFO to account for the address present in the TX FIFO
> +	 */
> +	if (cmd->is_daa) {
> +		xi3c_master_wr_to_tx_fifo(master, cmd);
> +
> +		len++;
> +		master->daa.index++;
> +		cmd->is_daa = false;
> +	}
> +
> +	transfer_cmd |= (u32)(len & XI3C_CMD_LEN_MASK) << 16;

And 16 here.

> +	writel(transfer_cmd, master->membase + XI3C_CMD_FIFO_OFFSET);
> +}
> +
> +static inline void xi3c_master_enable(struct xi3c_master *master)
> +{
> +	writel(readl(master->membase + XI3C_CR_OFFSET) | XI3C_CR_EN_MASK,
> +	       master->membase + XI3C_CR_OFFSET);
> +}
> +
> +static inline void xi3c_master_disable(struct xi3c_master *master)
> +{
> +	writel(readl(master->membase + XI3C_CR_OFFSET) & (~XI3C_CR_EN_MASK),
> +	       master->membase + XI3C_CR_OFFSET);
> +}
> +
> +static inline void xi3c_master_resume(struct xi3c_master *master)
> +{
> +	writel(readl(master->membase + XI3C_CR_OFFSET) | XI3C_CR_RESUME_MASK,
> +	       master->membase + XI3C_CR_OFFSET);
> +}
> +
> +static void xi3c_master_reset_fifos(struct xi3c_master *master)
> +{
> +	u32 data;
> +
> +	/* Reset fifos */
> +	data = readl(master->membase + XI3C_RESET_OFFSET);

you mix use readl and ioread32, can you keep consistence?

> +	data |= XI3C_FIFOS_RST_MASK;
> +	writel(data, master->membase + XI3C_RESET_OFFSET);
> +	udelay(10);

udelay() may not include MMIO operation, it may delay less than 10us.
suggest readl() before udelay() to make sure value reach XI3C_RESET_OFFSET.

> +	data &= ~XI3C_FIFOS_RST_MASK;
> +	writel(data, master->membase + XI3C_RESET_OFFSET);
> +	udelay(10);
> +}
> +
> +static inline void xi3c_master_init(struct xi3c_master *master)
> +{
> +	/* Reset fifos */
> +	xi3c_master_reset_fifos(master);
> +
> +	/* Enable controller */
> +	xi3c_master_enable(master);
> +}
> +
> +static inline void xi3c_master_reinit(struct xi3c_master *master)
> +{
> +	/* Reset fifos */
> +	xi3c_master_reset_fifos(master);
> +
> +	/* Resume controller */
> +	xi3c_master_resume(master);
> +}
> +
> +static struct xi3c_xfer *
> +xi3c_master_alloc_xfer(struct xi3c_master *master, unsigned int ncmds)
> +{
> +	struct xi3c_xfer *xfer;
> +
> +	xfer = kzalloc(struct_size(xfer, cmds, ncmds), GFP_KERNEL);
> +	if (!xfer)
> +		return NULL;
> +
> +	INIT_LIST_HEAD(&xfer->node);
> +	xfer->ncmds = ncmds;
> +	xfer->ret = -ETIMEDOUT;
> +
> +	return xfer;
> +}
> +
> +static inline void xi3c_master_free_xfer(struct xi3c_xfer *xfer)
> +{
> +	kfree(xfer);
> +}

why not direct call kfree()?

> +
> +static int xi3c_master_read(struct xi3c_master *master, struct xi3c_cmd *cmd)
> +{
> +	unsigned long timeout;
> +	u16 rx_data_available;
> +	u16 data_index;
> +
> +	if (!cmd->rx_buf || cmd->rx_len > XI3C_MAXDATA_LENGTH)
> +		return -EINVAL;
> +
> +	/* Fill command fifo */
> +	xi3c_master_write_to_cmdfifo(master, cmd, cmd->rx_len);
> +
> +	timeout = jiffies + XI3C_XFER_TIMEOUT;
> +	/* Read data from rx fifo */
> +	while (cmd->rx_len > 0 && !xi3c_is_resp_available(master)) {
> +		if (time_after(jiffies, timeout)) {
> +			dev_err(master->dev, "XI3C read timeout\n");
> +			return -EIO;
> +		}
> +
> +		rx_data_available = xi3c_rdfifolevel(master);
> +		for (data_index = 0;
> +		     data_index < rx_data_available && cmd->rx_len > 0;
> +		     data_index++)
> +			xi3c_master_rd_from_rx_fifo(master, cmd);
> +	}
> +
> +	/* Read remaining data */
> +	rx_data_available = xi3c_rdfifolevel(master);
> +	for (data_index = 0;
> +	     data_index < rx_data_available && cmd->rx_len > 0;
> +	     data_index++)
> +		xi3c_master_rd_from_rx_fifo(master, cmd);
> +	return 0;
> +}
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

Does existed helper function i3c_writel_fifo() handle this?

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
> +static int xi3c_master_xfer(struct xi3c_master *master, struct xi3c_cmd *cmd)
> +{
> +	int ret;
> +
> +	if (cmd->rnw)
> +		ret = xi3c_master_read(master, cmd);
> +	else
> +		ret = xi3c_master_write(master, cmd);
> +
> +	if (ret < 0)
> +		goto err_xfer_out;
> +
> +	ret = xi3c_get_response(master);
> +	if (ret)
> +		goto err_xfer_out;
> +
> +	return 0;
> +
> +err_xfer_out:
> +	xi3c_master_reinit(master);
> +	return ret;
> +}
> +
> +static void xi3c_master_dequeue_xfer_locked(struct xi3c_master *master,
> +					    struct xi3c_xfer *xfer)
> +{
> +	if (master->xferqueue.cur == xfer)
> +		master->xferqueue.cur = NULL;
> +	else
> +		list_del_init(&xfer->node);
> +}
> +
> +static void xi3c_master_dequeue_xfer(struct xi3c_master *master,
> +				     struct xi3c_xfer *xfer)
> +{
> +	guard(spinlock_irqsave)(&master->xferqueue.lock);

Add empty line here.

> +	xi3c_master_dequeue_xfer_locked(master, xfer);
> +}
> +
> +static void xi3c_master_start_xfer_locked(struct xi3c_master *master)
> +{
> +	struct xi3c_xfer *xfer = master->xferqueue.cur;
> +	int ret = 0, i;
> +
> +	if (!xfer)
> +		return;
> +
> +	for (i = 0; i < xfer->ncmds; i++) {
> +		struct xi3c_cmd *cmd = &xfer->cmds[i];
> +
> +		ret = xi3c_master_xfer(master, cmd);
> +		if (ret)
> +			break;
> +	}
> +
> +	xfer->ret = ret;
> +	complete(&xfer->comp);
> +
> +	xfer = list_first_entry_or_null(&master->xferqueue.list,
> +					struct xi3c_xfer,
> +					node);
> +	if (xfer)
> +		list_del_init(&xfer->node);
> +
> +	master->xferqueue.cur = xfer;
> +	xi3c_master_start_xfer_locked(master);
> +}
> +
> +static inline void xi3c_master_enqueue_xfer(struct xi3c_master *master,
> +					    struct xi3c_xfer *xfer)
> +{
> +	init_completion(&xfer->comp);
> +	guard(spinlock_irqsave)(&master->xferqueue.lock);
> +	if (master->xferqueue.cur) {
> +		list_add_tail(&xfer->node, &master->xferqueue.list);
> +	} else {
> +		master->xferqueue.cur = xfer;
> +		xi3c_master_start_xfer_locked(master);
> +	}
> +}
> +
> +static inline int xi3c_master_common_xfer(struct xi3c_master *master,
> +					  struct xi3c_xfer *xfer)
> +{
> +	int ret, timeout;
> +
> +	guard(mutex)(&master->lock);
> +	xi3c_master_enqueue_xfer(master, xfer);
> +	timeout = wait_for_completion_timeout(&xfer->comp,
> +					      msecs_to_jiffies(XI3C_XFER_TIMEOUT_MS));
> +	if (!timeout)
> +		ret = -ETIMEDOUT;
> +	else
> +		ret = xfer->ret;
> +
> +	if (ret)
> +		xi3c_master_dequeue_xfer(master, xfer);
> +
> +	return ret;
> +}
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
> +	xi3c_master_free_xfer(xfer);
> +
> +	for (i = 0; i < master->daa.index; i++) {
> +		ret = i3c_master_add_i3c_dev_locked(m, master->daa.addrs[i]);
> +		if (ret)
> +			goto err_daa_mem;

see comments in svc-master-i3c.c

/*
         * Register all devices who participated to the core
         *
         * If two devices (A and B) are detected in DAA and address 0xa is assigned to
         * device A and 0xb to device B, a failure in i3c_master_add_i3c_dev_locked()
         * for device A (addr: 0xa) could prevent device B (addr: 0xb) from being
         * registered on the bus. The I3C stack might still consider 0xb a free
         * address. If a subsequent Hotjoin occurs, 0xb might be assigned to Device A,
         * causing both devices A and B to use the same address 0xb, violating the I3C
         * specification.
         *
         * The return value for i3c_master_add_i3c_dev_locked() should not be checked
         * because subsequent steps will scan the entire I3C bus, independent of
         * whether i3c_master_add_i3c_dev_locked() returns success.
         *
         * If device A registration fails, there is still a chance to register device
         * B. i3c_master_add_i3c_dev_locked() can reset DAA if a failure occurs while
         * retrieving device information.
         */

I think it also fits your case.

> +
> +		pid_bcr_dcr[i] = FIELD_GET(XI3C_PID_MASK,
> +					   get_unaligned_be64(pid_bufs[i]));
> +		dev_info(master->dev, "Client %d: PID: 0x%llx\n", i, pid_bcr_dcr[i]);
> +	}
> +
> +	return 0;
> +
> +err_daa:
> +	xi3c_master_free_xfer(xfer);
> +err_daa_mem:
> +	xi3c_master_reinit(master);
> +	return ret;
> +}
> +
> +static bool
> +xi3c_master_supports_ccc_cmd(struct i3c_master_controller *master,
> +			     const struct i3c_ccc_cmd *cmd)
> +{
> +	if (cmd->ndests > 1)
> +		return false;
> +
> +	switch (cmd->id) {
> +	case I3C_CCC_ENEC(true):
> +	case I3C_CCC_ENEC(false):
> +	case I3C_CCC_DISEC(true):
> +	case I3C_CCC_DISEC(false):
> +	case I3C_CCC_ENTAS(0, true):
> +	case I3C_CCC_ENTAS(0, false):
> +	case I3C_CCC_RSTDAA(true):
> +	case I3C_CCC_RSTDAA(false):
> +	case I3C_CCC_ENTDAA:
> +	case I3C_CCC_SETMWL(true):
> +	case I3C_CCC_SETMWL(false):
> +	case I3C_CCC_SETMRL(true):
> +	case I3C_CCC_SETMRL(false):
> +	case I3C_CCC_ENTHDR(0):
> +	case I3C_CCC_SETDASA:
> +	case I3C_CCC_SETNEWDA:
> +	case I3C_CCC_GETMWL:
> +	case I3C_CCC_GETMRL:
> +	case I3C_CCC_GETPID:
> +	case I3C_CCC_GETBCR:
> +	case I3C_CCC_GETDCR:
> +	case I3C_CCC_GETSTATUS:
> +	case I3C_CCC_GETMXDS:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static int xi3c_master_send_bdcast_ccc_cmd(struct xi3c_master *master,
> +					   struct i3c_ccc_cmd *ccc)
> +{
> +	u16 xfer_len = ccc->dests[0].payload.len + 1;
> +	struct xi3c_xfer *xfer;
> +	struct xi3c_cmd *cmd;
> +	int ret;
> +
> +	xfer = xi3c_master_alloc_xfer(master, 1);
> +	if (!xfer)
> +		return -ENOMEM;
> +
> +	u8 *buf __free(kfree) = kmalloc(xfer_len, GFP_KERNEL);
> +	if (!buf) {
> +		xi3c_master_free_xfer(xfer);
> +		return -ENOMEM;
> +	}
> +
> +	buf[0] = ccc->id;
> +	memcpy(&buf[1], ccc->dests[0].payload.data, ccc->dests[0].payload.len);
> +
> +	cmd = &xfer->cmds[0];
> +	cmd->addr = ccc->dests[0].addr;
> +	cmd->rnw = ccc->rnw;
> +	cmd->tx_buf = buf;
> +	cmd->tx_len = xfer_len;
> +	cmd->type = XI3C_SDR_MODE;
> +	cmd->tid = XI3C_SDR_TID;
> +	cmd->continued = false;
> +
> +	ret = xi3c_master_common_xfer(master, xfer);
> +	xi3c_master_free_xfer(xfer);
> +
> +	return ret;
> +}
> +
> +static int xi3c_master_send_direct_ccc_cmd(struct xi3c_master *master,
> +					   struct i3c_ccc_cmd *ccc)
> +{
> +	struct xi3c_xfer *xfer;
> +	struct xi3c_cmd *cmd;
> +	int ret;
> +
> +	xfer = xi3c_master_alloc_xfer(master, 2);
> +	if (!xfer)
> +		return -ENOMEM;
> +
> +	/* Broadcasted message */
> +	cmd = &xfer->cmds[0];
> +	cmd->addr = I3C_BROADCAST_ADDR;
> +	cmd->rnw = 0;
> +	cmd->tx_buf = &ccc->id;
> +	cmd->tx_len = 1;
> +	cmd->type = XI3C_SDR_MODE;
> +	cmd->tid = XI3C_SDR_TID;
> +	cmd->continued = true;
> +
> +	/* Directed message */
> +	cmd = &xfer->cmds[1];
> +	cmd->addr = ccc->dests[0].addr;
> +	cmd->rnw = ccc->rnw;
> +	if (cmd->rnw) {
> +		cmd->rx_buf = ccc->dests[0].payload.data;
> +		cmd->rx_len = ccc->dests[0].payload.len;
> +	} else {
> +		cmd->tx_buf = ccc->dests[0].payload.data;
> +		cmd->tx_len = ccc->dests[0].payload.len;
> +	}
> +	cmd->type = XI3C_SDR_MODE;
> +	cmd->tid = XI3C_SDR_TID;
> +	cmd->continued = false;
> +
> +	ret = xi3c_master_common_xfer(master, xfer);
> +	xi3c_master_free_xfer(xfer);
> +	return ret;
> +}
> +
> +static int xi3c_master_send_ccc_cmd(struct i3c_master_controller *m,
> +				    struct i3c_ccc_cmd *cmd)
> +{
> +	struct xi3c_master *master = to_xi3c_master(m);
> +	bool broadcast = cmd->id < 0x80;
> +
> +	if (broadcast)
> +		return xi3c_master_send_bdcast_ccc_cmd(master, cmd);
> +
> +	return xi3c_master_send_direct_ccc_cmd(master, cmd);
> +}
> +
> +static int xi3c_master_priv_xfers(struct i3c_dev_desc *dev,
> +				  struct i3c_priv_xfer *xfers,
> +				  int nxfers)
> +{
> +	struct i3c_master_controller *m = i3c_dev_get_master(dev);
> +	struct xi3c_master *master = to_xi3c_master(m);
> +	struct xi3c_xfer *xfer;
> +	int i, ret;
> +
> +	if (!nxfers)
> +		return 0;
> +
> +	xfer = xi3c_master_alloc_xfer(master, nxfers);
> +	if (!xfer)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < nxfers; i++) {
> +		struct xi3c_cmd *cmd = &xfer->cmds[i];
> +
> +		cmd->addr = dev->info.dyn_addr;
> +		cmd->rnw = xfers[i].rnw;
> +
> +		if (cmd->rnw) {
> +			cmd->rx_buf = xfers[i].data.in;
> +			cmd->rx_len = xfers[i].len;
> +		} else {
> +			cmd->tx_buf = (void *)xfers[i].data.out;
> +			cmd->tx_len = xfers[i].len;
> +		}
> +
> +		cmd->type = XI3C_SDR_MODE;
> +		cmd->tid = XI3C_SDR_TID;
> +		cmd->continued = (i + 1) < nxfers;
> +	}
> +
> +	ret = xi3c_master_common_xfer(master, xfer);
> +	xi3c_master_free_xfer(xfer);
> +	return ret;
> +}
> +
> +static int xi3c_master_i2c_xfers(struct i2c_dev_desc *dev,
> +				 struct i2c_msg *xfers,
> +				 int nxfers)
> +{
> +	struct i3c_master_controller *m = i2c_dev_get_master(dev);
> +	struct xi3c_master *master = to_xi3c_master(m);
> +	struct xi3c_xfer *xfer;
> +	int i, ret;
> +
> +	if (!nxfers)
> +		return 0;
> +
> +	xfer = xi3c_master_alloc_xfer(master, nxfers);
> +	if (!xfer)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < nxfers; i++) {
> +		struct xi3c_cmd *cmd = &xfer->cmds[i];
> +
> +		cmd->addr = xfers[i].addr & XI3C_ADDR_MASK;
> +		cmd->rnw = xfers[i].flags & I2C_M_RD;
> +
> +		if (cmd->rnw) {
> +			cmd->rx_buf = xfers[i].buf;
> +			cmd->rx_len = xfers[i].len;
> +		} else {
> +			cmd->tx_buf = (void *)xfers[i].buf;
> +			cmd->tx_len = xfers[i].len;
> +		}
> +
> +		cmd->type = XI3C_I2C_MODE;
> +		cmd->tid = XI3C_I2C_TID;
> +		cmd->continued = (i + 1) < nxfers;
> +	}
> +
> +	ret = xi3c_master_common_xfer(master, xfer);
> +	xi3c_master_free_xfer(xfer);
> +	return ret;
> +}
> +
> +static int xi3c_clk_cfg(struct xi3c_master *master, unsigned long sclhz, u8 mode)
> +{
> +	unsigned long core_rate, core_periodns;
> +	u32 thigh, tlow, thold, odthigh, odtlow, tcasmin, tsustart, tsustop, thdstart;
> +
> +	core_rate = clk_get_rate(master->pclk);
> +	if (!core_rate)
> +		return -EINVAL;
> +
> +	core_periodns = DIV_ROUND_UP(1000000000, core_rate);
> +
> +	thigh = DIV_ROUND_UP(core_rate, sclhz) >> 1;
> +	tlow = thigh;
> +
> +	/* Hold time : 40% of tlow time */
> +	thold = (tlow * 4) / 10;
> +
> +	/*
> +	 * For initial IP (revision number == 0), minimum data hold time is 5.
> +	 * For updated IP (revision number > 0), minimum data hold time is 6.
> +	 * Updated IP supports achieving high data rate with low reference
> +	 * frequency.
> +	 */
> +	if (xi3c_getrevisionnumber(master) == 0)
> +		thold = (thold < 5) ? 5 : thold;
> +	else
> +		thold = (thold < 6) ? 6 : thold;
> +
> +	writel((thigh - 2) & XI3C_SCL_HIGH_TIME_MASK,
> +	       master->membase + XI3C_SCL_HIGH_TIME_OFFSET);
> +	writel((tlow - 2) & XI3C_SCL_LOW_TIME_MASK,
> +	       master->membase + XI3C_SCL_LOW_TIME_OFFSET);
> +	writel((thold - 2) & XI3C_SDA_HOLD_TIME_MASK,
> +	       master->membase + XI3C_SDA_HOLD_TIME_OFFSET);
> +
> +	if (!mode) {
> +		/* I2C */
> +		writel((thigh - 2) & XI3C_SCL_HIGH_TIME_MASK,
> +		       master->membase + XI3C_OD_SCL_HIGH_TIME_OFFSET);
> +		writel((tlow - 2) & XI3C_SCL_LOW_TIME_MASK,
> +		       master->membase + XI3C_OD_SCL_LOW_TIME_OFFSET);
> +
> +		tcasmin = DIV_ROUND_UP(XI3C_I2C_TCASMIN_NS, core_periodns);
> +	} else {
> +		/* I3C */
> +		odtlow = DIV_ROUND_UP(XI3C_OD_TLOW_NS, core_periodns);
> +		odthigh = DIV_ROUND_UP(XI3C_OD_THIGH_NS, core_periodns);
> +
> +		odtlow = (tlow < odtlow) ? odtlow : tlow;
> +		odthigh = (thigh > odthigh) ? odthigh : thigh;
> +
> +		writel((odthigh - 2) & XI3C_SCL_HIGH_TIME_MASK,
> +		       master->membase + XI3C_OD_SCL_HIGH_TIME_OFFSET);
> +		writel((odtlow - 2) & XI3C_SCL_LOW_TIME_MASK,
> +		       master->membase + XI3C_OD_SCL_LOW_TIME_OFFSET);
> +
> +		tcasmin = DIV_ROUND_UP(XI3C_TCASMIN_NS, core_periodns);
> +	}
> +
> +	thdstart = (thigh > tcasmin) ? thigh : tcasmin;
> +	tsustart = (tlow > tcasmin) ? tlow : tcasmin;
> +	tsustop = (tlow > tcasmin) ? tlow : tcasmin;
> +
> +	writel((tsustart - 2) & XI3C_TSU_START_MASK,
> +	       master->membase + XI3C_TSU_START_OFFSET);
> +	writel((thdstart - 2) & XI3C_THD_START_MASK,
> +	       master->membase + XI3C_THD_START_OFFSET);
> +	writel((tsustop - 2) & XI3C_TSU_STOP_MASK,
> +	       master->membase + XI3C_TSU_STOP_OFFSET);
> +
> +	return 0;
> +}
> +
> +static int xi3c_master_bus_init(struct i3c_master_controller *m)
> +{
> +	struct xi3c_master *master = to_xi3c_master(m);
> +	struct i3c_bus *bus = i3c_master_get_bus(m);
> +	struct i3c_device_info info = { };
> +	unsigned long sclhz;
> +	u64 pid1_bcr_dcr;
> +	u8 mode;
> +	int ret;
> +
> +	switch (bus->mode) {
> +	case I3C_BUS_MODE_MIXED_FAST:
> +	case I3C_BUS_MODE_MIXED_LIMITED:
> +		mode = XI3C_I2C_MODE;
> +		sclhz = bus->scl_rate.i2c;
> +		break;
> +	case I3C_BUS_MODE_PURE:
> +		mode = XI3C_SDR_MODE;
> +		sclhz = bus->scl_rate.i3c;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = xi3c_clk_cfg(master, sclhz, mode);
> +	if (ret)
> +		return ret;
> +
> +	/* Get an address for the master. */
> +	ret = i3c_master_get_free_addr(m, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	info.dyn_addr = (u8)ret;
> +
> +	/* Write the dynamic address value to the address register. */
> +	writel(info.dyn_addr, master->membase + XI3C_ADDRESS_OFFSET);
> +
> +	/* Read PID, BCR and DCR values, and assign to i3c device info. */
> +	pid1_bcr_dcr = readl(master->membase + XI3C_PID1_BCR_DCR);
> +	info.pid = ((FIELD_GET(XI3C_PID1_MASK, pid1_bcr_dcr) << 32) |
> +		    readl(master->membase + XI3C_PID0_OFFSET));
> +	info.bcr = (u8)FIELD_GET(XI3C_BCR_MASK, pid1_bcr_dcr);
> +	info.dcr = (u8)FIELD_GET(XI3C_DCR_MASK, pid1_bcr_dcr);
> +
> +	ret = i3c_master_set_info(&master->base, &info);
> +	if (ret)
> +		return ret;
> +
> +	xi3c_master_init(master);
> +
> +	return ret;
> +}
> +
> +static void xi3c_master_bus_cleanup(struct i3c_master_controller *m)
> +{
> +	struct xi3c_master *master = to_xi3c_master(m);
> +
> +	xi3c_master_disable(master);
> +}
> +
> +static const struct i3c_master_controller_ops xi3c_master_ops = {
> +	.bus_init = xi3c_master_bus_init,
> +	.bus_cleanup = xi3c_master_bus_cleanup,
> +	.do_daa = xi3c_master_do_daa,
> +	.supports_ccc_cmd = xi3c_master_supports_ccc_cmd,
> +	.send_ccc_cmd = xi3c_master_send_ccc_cmd,
> +	.priv_xfers = xi3c_master_priv_xfers,
> +	.i2c_xfers = xi3c_master_i2c_xfers,
> +};
> +
> +static int xi3c_master_probe(struct platform_device *pdev)
> +{
> +	struct xi3c_master *master;
> +
> +	master = devm_kzalloc(&pdev->dev, sizeof(*master), GFP_KERNEL);
> +	if (!master)
> +		return -ENOMEM;
> +
> +	master->membase = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(master->membase))
> +		return PTR_ERR(master->membase);
> +
> +	master->pclk = devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(master->pclk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(master->pclk),
> +				     "Failed to get and enable clock\n");
> +
> +	master->dev = &pdev->dev;
> +
> +	mutex_init(&master->lock);

devm_mutex_init()

Frank
> +	spin_lock_init(&master->xferqueue.lock);
> +	INIT_LIST_HEAD(&master->xferqueue.list);
> +
> +	platform_set_drvdata(pdev, master);
> +
> +	return i3c_master_register(&master->base, &pdev->dev,
> +				   &xi3c_master_ops, false);
> +}
> +
> +static void xi3c_master_remove(struct platform_device *pdev)
> +{
> +	struct xi3c_master *master = platform_get_drvdata(pdev);
> +
> +	i3c_master_unregister(&master->base);
> +}
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
