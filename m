Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011030.outbound.protection.outlook.com [52.101.65.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159112367D1;
	Thu, 11 Sep 2025 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757605520; cv=fail; b=gNcPbRb+fic1ygq9nozjiEKHERMbZxZEkofqPqOit45Ishzm3YVs2ZVY+UsPh/4vzpDOTEDUUTanLUlRMF4/giu8alH2MDLiJNtRHDGXleN+6plkCWQCuQnu4cVRnyQ25pIiP2xI5eJUYu4BG4M5B5Cknu4Hio/9C2tRW0zuC88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757605520; c=relaxed/simple;
	bh=4hDrgHEppKIFiUk+TsSNBeZ0F52IfN9YOmQwXc/ZmUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g53KLOIMC+1/bGrL67xQfWRAeR8sU0/2Vgk8Hi9uUxmzAFgJO+DUygKH8+QKK//dMUPCjl58cyqOmJ1Iwmc0lTXlNJoMc1Bh6+J0GT61b2oNdnntIGTVkib4ChvImXD/nbPEAlJ/dkzeiUGb3GsN1ZqpcWWhfvQIZh/WwtBw7c0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LhXp7Jw5; arc=fail smtp.client-ip=52.101.65.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LhXp7Jw5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0Ze0e7IM84R6Tn+Y70xlaBcgIQxdpA9i0Cft1zHI7Deu09koWPX+2+b136e+OU959UGFjCcw0HIPnAjLl+We2hU4d2TVootuu3SD7fgtIBZFoYTUy3+HAGdNWfhxA3ekNpy6/eBYYvCtvWQYz29GEREKHYfcTPO/jsWMC33gRt+dHhf4aLy/saraT0jV2JjhZO93rAcAjN2f+XeXbxE83Ccv+PGFw1Vno6NPWgrJQr083sRh9mbclvuGJKStwDlyZMKipZq+BQIpSze+cfpJRUJSy91zjxxPFU6lTMA7CTX7+CHtjD8THKyVF9cAg4RWCTPZ9b5kLQ+noQ0cr77Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cINv/udmgtuTTEOKrs7SoB7Ia9D02il6wXx13KN5AQY=;
 b=iSuQvNK9KtvAkp4W3OwyApxtOHZdM3zXs6aAtOIKMIT0mDFYcniwPIedfybb4gkzuY4dtVTG8tIm1AYsUAv8hXf/3rYiAsAaoL4h7UBxayjm5REz08PCxDt7Q+CZseUpRa/uMsbS1MU3dEd0CxSf0CcZSqQKuPcvwpGaNpt99qZRYOa7oBGoENxqiLByZEn5I7LWM0BDqvD8xekNKfYKedQLuxyQrR9Ghvd+dAvzWKifkdv3cVY3MdzoUwA+5CArgJQKzFwTg4Ino1nZG9JqlnuZD03PWArW/FWm+xPXEQlu+ewptn/IyhH+GweG51ZI1T8slpwYLp62JEQv87wryQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cINv/udmgtuTTEOKrs7SoB7Ia9D02il6wXx13KN5AQY=;
 b=LhXp7Jw5T/zROzHlCUmyTXGlUPRhLUPRx27+ZsuloMXzvhbZrGUHITeNgy7cbRdS0TOS7bDdopvW1H/TMPVmdn3u1OsHpXKVOQI4vsdLeGXwjgBmh1E/GmLm4OkaGtzS9PkVu3lW+10on4yZkXuOrroUPzm3WBFoZhQEFEQypZANMTBkBDao3XzLAukf+hC+hMSvJlTPxn4RiIr7I5xhlOaAQWkbh9i5MHApaLFtupNy5582znxOemr3ztq4ASBKC6PCksXzHqhPRqzjpFPv6WBSBkI3izW9PhwyLgBsM9J3mQ/wLxAtv8PYBftkRyhL0AtLScZS+65POxxrGq/cUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by PA4PR04MB9710.eurprd04.prod.outlook.com (2603:10a6:102:268::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.33; Thu, 11 Sep
 2025 15:45:10 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9115.015; Thu, 11 Sep 2025
 15:45:10 +0000
Date: Thu, 11 Sep 2025 11:45:01 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>
Cc: "git (AMD-Xilinx)" <git@amd.com>,
	"Simek, Michal" <michal.simek@amd.com>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"kees@kernel.org" <kees@kernel.org>,
	"gustavoars@kernel.org" <gustavoars@kernel.org>,
	"jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
	"Goud, Srinivas" <srinivas.goud@amd.com>,
	"Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
	"manion05gk@gmail.com" <manion05gk@gmail.com>
Subject: Re: [PATCH V6 2/2] i3c: master: Add AMD I3C bus controller driver
Message-ID: <aMLufaWnrhPxVyxm@lizhi-Precision-Tower-5810>
References: <20250910112954.553353-1-manikanta.guntupalli@amd.com>
 <20250910112954.553353-3-manikanta.guntupalli@amd.com>
 <aMGtdFxlXRanIAuM@lizhi-Precision-Tower-5810>
 <DM4PR12MB6109FB1956E8AC4979DFE85A8C09A@DM4PR12MB6109.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB6109FB1956E8AC4979DFE85A8C09A@DM4PR12MB6109.namprd12.prod.outlook.com>
X-ClientProxiedBy: SJ0PR03CA0160.namprd03.prod.outlook.com
 (2603:10b6:a03:338::15) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|PA4PR04MB9710:EE_
X-MS-Office365-Filtering-Correlation-Id: 34e39de2-be7f-4934-39ec-08ddf14a308e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RKaj94N+4rG6z0cK/Kt7NZwGevQHOvisLHleqBlInbdj87Pvvm1Jdgs0o+YI?=
 =?us-ascii?Q?bKHw839tYudyHBZw70kgKmStK7R2rzGWRdust8PduYXzRz4cS5hBSCcqUr2D?=
 =?us-ascii?Q?gmdd/s+n3p5eukrI8INP4wfD4WxSHZJ+889NfByjOw/zlf47CgF/o/JKzcZX?=
 =?us-ascii?Q?Gvn1v5Q4ZmTFAkLiTiYSPbLt7br2v+quWXIvOEkqlegJmJhnvA3WnvuDIreL?=
 =?us-ascii?Q?XoucsHjaXsjc9rs0qRT8/n8cQU9oLZru+u+EBI92CTjL870mMs6hNnoCDvNN?=
 =?us-ascii?Q?2LyrlHwpImZfeH+4W3eitr/nzOS0WrBb9dYJCGBowPM3oLKOKbah/00kTTRn?=
 =?us-ascii?Q?WDqgb1QPO/fw0DST+t+E62B/nlqYYPpGLX38v+NK2Pd7P/kl/0eOSMtTy3D8?=
 =?us-ascii?Q?9eRtijCKFZmxLRbSgfMqYT2lHg3kP1txqcDJ2Ah7Qp+rQ/67rqrk1dxBcBgv?=
 =?us-ascii?Q?AJ0AX/5SEITrymoBlhrjRVfPg9Qx3BJPFAHofEHs9Sd8wh8UkMhRmRglAH5s?=
 =?us-ascii?Q?7HViUHZGH9N1clLHDZJMjwMg5UryPfWybwYCTLOTocSdAK+HPYA5fjT6fxp2?=
 =?us-ascii?Q?+8tJ21fDpfhynamoawurH6Z8WyEHD48Lf7ZvonjM4yblcXoRpzNifaM3VLi2?=
 =?us-ascii?Q?tiy5gjhGWa+Gf8BHqS6bW7+1PVdCsmiL68nPVDy/nT99fer1XOaq7eSFMq+O?=
 =?us-ascii?Q?0vbkmrTOzWch+3/Jo7bR1L2RpP1Rq1kTx3R2uCmIIhzY+Q3WN1mYae4BARsS?=
 =?us-ascii?Q?5eXBRpl9Z4dHJI3a023qLXIjAcUhMV7nHctcUzeqeAjfWHuRxF6QWKgMTHOP?=
 =?us-ascii?Q?v0xcakn/K2Qu+X5YkotoqbnrWC5FGnETJ5EyVLaNHuz3EbHVEAgUgQlmLYFv?=
 =?us-ascii?Q?mDcsga/dMOh9y1Hw2YQIZZKiT0D3dGohvg3Md4ZW3+941z4RRo88idKVoAxN?=
 =?us-ascii?Q?L7XTegD9p0Kly0YHnbd7JR2Ac7waARoKFBjWbNQ9vMYXlMECN0dFek8ZqsMB?=
 =?us-ascii?Q?Hz++Ift+6KP8gDrIwWRQyYA0ylxnh+k8gw6hS5LsashwLB5ggbnL1gcPoJJL?=
 =?us-ascii?Q?ISA4pbPmEgKRDX4MBamLdtCaaKTgsJbYjWcEPs7jjKjsxZQcWUNZQjv7lcX3?=
 =?us-ascii?Q?ahkgDIuFhKia8+t6DaLyLNDxHq5Cps45TvQW8t43qc0gu54hL8Y3pyyl7e7Y?=
 =?us-ascii?Q?JOJKrXAsux51F+tK4RwOM72yz3wFGsRLO5aYsTfl8kCei00neuymhW8pR+sY?=
 =?us-ascii?Q?FNbvQP3IXjllR/u8KHvtGBptVfpMnsyRZJJ0fvto/vErY9Y77d92FHD4cTYo?=
 =?us-ascii?Q?h5INRhw7VQUHU6D4ZcHduMOB02Jh+30wbNEz6CFwCRogey/WlnaJ1Nrp4jP5?=
 =?us-ascii?Q?MNKm/Ujhdn5pZaGV/rS5imGdM1xuWr2ApQmQp/A7nkU4Qh2mYk2BNIxA6ryq?=
 =?us-ascii?Q?39CzURtCh8Qp0Fm9kHTVkV9OtaDXZUGY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jhV7LtfPgI+nRw1qfDSWvgupw4qvkzdHo6HO/U/Rg9ENuCz7Tr7q5PUbenkq?=
 =?us-ascii?Q?CVAq64v5MvZjkaMS6pMEwwUP8TimXQ2PajQW9r7bG0zWDwB+5spZEYlYwQnU?=
 =?us-ascii?Q?VY5epi49/MzTOn81O751vbjm20gonAMDb9i+gCUkWSCMnYaqwR4OiGTH/lRm?=
 =?us-ascii?Q?tSkDd6gUSSY0RtWsE3VTja6p1Rp4s+OWAJSevH7mL9pR7LlOLUY6KpkbMJI7?=
 =?us-ascii?Q?NqdJGkZah7OC3r0OzI0d+Ykuaw4X6jV36YL7YRcAYHWodoD1IIxxTtFEaXQe?=
 =?us-ascii?Q?my9/hIQGu4QMy1g6PuEX+nzenOYDOYmpgaP/gqtEhGNKt9Z2nv0vvig6v0RI?=
 =?us-ascii?Q?wYlZp2TmS6Y66uBVH7IuhnWydUE3SmnehTyh622IZTTaNFrVjdClHg7Oy+7Z?=
 =?us-ascii?Q?QsBsMU/Bug6d+N00BegGW81emCfKrhkbSuAM9QFPeDdkrJcjF/14XO7G1eUK?=
 =?us-ascii?Q?5NiO29PadHNLcGR2ssz4n1eeV0KqHJyLfU+Xe+W9MbdjcV6mn7Hfn0hVdI71?=
 =?us-ascii?Q?q/CiVMU3eD0Jn1LBi/5aW6q0f1V1WTD4OwQ7YtK/h6WQMj3whbkXggq8sXTV?=
 =?us-ascii?Q?QAEOnbsr+nmDdhnbacmQ1SDx/ch3lYt+P0038ED5uctz4tfpv/xyHqQ5oYKI?=
 =?us-ascii?Q?/vZIiQ0+nSHe2ir72ax30VaU6W1yjVP2UpCnpdeSZBNTCTVjfkkOjJeTMlVc?=
 =?us-ascii?Q?b++TwM0YOjHiQGpy6TXyssbxKW+pncNoxfqBH+nU1i3Do+Rhko5TV8oFJWWY?=
 =?us-ascii?Q?77aCsHSyYnbrD5bBO4ZXbZ7pz9Of5MHzDToGxLROkqMn6pEG/k2uobN+1Eas?=
 =?us-ascii?Q?2O9OYkBzUhbUVGobt7pPA+Kvf+4q+T8Id2mZ4yaeFJiWXd9DcDf+Algb+z/g?=
 =?us-ascii?Q?t1icQ/wVhVtcffUAypB9x0C2cJ/c5Gtgwj6ZO8ipJfOLFrVHMLEEVRJaumU4?=
 =?us-ascii?Q?fcvWMUIuSQDznNJYsU2YOeKlpqPkoyPtQ8h1whLBjLBeC/4WMc5CYbcvOcPR?=
 =?us-ascii?Q?vBuYiQEvF7XuEvU0F8v/LLjsaxJZi3wTjZljdL46dw6fVz+J4G9vQPc7SlAk?=
 =?us-ascii?Q?yO1FWsLMHb9aOIJ2hQ9qXa9s5f8tzYBSrAdwk9xPQD5GaWhV5UQNUnUdCZ+M?=
 =?us-ascii?Q?Z6Po1codHDowuxmMo1fW1/sd3Lj+hGZAcU1FtQl6GmsUcV0beirWPoKKfhRN?=
 =?us-ascii?Q?93BG4vOZff771natrOc6dglqs3qXbJyrHTYsJ1CPRPFjfNYOW+iE4T0PED5i?=
 =?us-ascii?Q?1E8nt3EPUc9Bo5tZrDgV/9FYEw0s6973yYRbjaPGH4p9htCm9/fyzINBgmH3?=
 =?us-ascii?Q?vjtrEaQ0GL4RjMo8dvvAPEfKfu5gk/C8DiL9K/ReGq8ibyJiTGSJ2gBa0orM?=
 =?us-ascii?Q?yq0Sn+qMiiHC8dViDl3PRbKxNNSgG2FKEsWHHUxq7cvqC0BENtT3/QZCMI3r?=
 =?us-ascii?Q?ncxCD/ok3umFnrzSynwWHV27uGhVZxc5rUbbgWE3jlrp8HnyknJl63pah1N7?=
 =?us-ascii?Q?ZQYlKpaUaZXqwMDoBZn0bcWuCNtAopTFlXJgEClYjREoWBj3F3mzZNkvDNTq?=
 =?us-ascii?Q?FAulvamHjyXW9NQGE0G1o74cu2cKeKJydi9DoZKL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e39de2-be7f-4934-39ec-08ddf14a308e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 15:45:10.5020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KbR39cXPY6Cf3xRzh0C3d7tYmTEeb1MnIMR/sz5biIqPZ0qS/K9KDNEI+Zfc9K+72lKtt9TrIBvxeAAJXoqKCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9710

On Thu, Sep 11, 2025 at 06:07:59AM +0000, Guntupalli, Manikanta wrote:
> [Public]
>
> Hi,
>
> > -----Original Message-----
> > From: Frank Li <Frank.li@nxp.com>
> > Sent: Wednesday, September 10, 2025 10:25 PM
> > To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
> > Cc: git (AMD-Xilinx) <git@amd.com>; Simek, Michal <michal.simek@amd.com>;
> > alexandre.belloni@bootlin.com; robh@kernel.org; krzk+dt@kernel.org;
> > conor+dt@kernel.org; kees@kernel.org; gustavoars@kernel.org;
> > jarkko.nikula@linux.intel.com; linux-i3c@lists.infradead.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > hardening@vger.kernel.org; Pandey, Radhey Shyam
> > <radhey.shyam.pandey@amd.com>; Goud, Srinivas <srinivas.goud@amd.com>;
> > Datta, Shubhrajyoti <shubhrajyoti.datta@amd.com>; manion05gk@gmail.com
> > Subject: Re: [PATCH V6 2/2] i3c: master: Add AMD I3C bus controller driver
> >
> > On Wed, Sep 10, 2025 at 04:59:54PM +0530, Manikanta Guntupalli wrote:
> > > Add an I3C master driver and maintainers fragment for the AMD I3C bus
> > > controller.
> > >
> > > The driver currently supports the I3C bus operating in SDR i3c mode,
> > > with features including Dynamic Address Assignment, private data
> > > transfers, and CCC transfers in both broadcast and direct modes. It
> > > also supports operation in I2C mode.
> > >
> > > Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> > > ---
> > > Changes for V2:
> > > Updated commit description.
> > > Added mixed mode support with clock configuration.
> > > Converted smaller functions into inline functions.
> > > Used FIELD_GET() in xi3c_get_response().
> > > Updated xi3c_master_rd_from_rx_fifo() to use cmd->rx_buf.
> > > Used parity8() for address parity calculation.
> > > Added guards for locks.
> > > Dropped num_targets and updated xi3c_master_do_daa().
> > > Used __free(kfree) in xi3c_master_send_bdcast_ccc_cmd().
> > > Dropped PM runtime support.
> > > Updated xi3c_master_read() and xi3c_master_write() with
> > > xi3c_is_resp_available() check.
> > > Created separate functions: xi3c_master_init() and xi3c_master_reinit().
> > > Used xi3c_master_init() in bus initialization and xi3c_master_reinit()
> > > in error paths.
> > > Added DAA structure to xi3c_master structure.
> > >
> > > Changes for V3:
> > > Resolved merge conflicts.
> > >
> > > Changes for V4:
> > > Updated timeout macros.
> > > Removed type casting for xi3c_is_resp_available() macro.
> > > Used ioread32() and iowrite32() instead of readl() and writel() to
> > > keep consistency.
> > > Read XI3C_RESET_OFFSET reg before udelay().
> > > Removed xi3c_master_free_xfer() and directly used kfree().
> > > Skipped checking return value of i3c_master_add_i3c_dev_locked().
> > > Used devm_mutex_init() instead of mutex_init().
> > >
> > > Changes for V5:
> > > Used GENMASK_ULL for PID mask as it's 64bit mask.
> > >
> > > Changes for V6:
> > > Removed typecast for xi3c_getrevisionnumber(), xi3c_wrfifolevel(), and
> > > xi3c_rdfifolevel().
> > > Replaced dynamic allocation with a static variable for pid_bcr_dcr.
> > > Fixed sparse warning in do_daa by typecasting the address parity value
> > > to u8.
> > > Fixed sparse warning in xi3c_master_bus_init by typecasting the pid
> > > value to u64 in info.pid calculation.
> > > ---
> > >  MAINTAINERS                         |    7 +
> > >  drivers/i3c/master/Kconfig          |   16 +
> > >  drivers/i3c/master/Makefile         |    1 +
> > >  drivers/i3c/master/amd-i3c-master.c | 1009
> > > +++++++++++++++++++++++++++
> > >  4 files changed, 1033 insertions(+)
> > >  create mode 100644 drivers/i3c/master/amd-i3c-master.c
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS index
> > > 1af81124bba3..ff603ce5e78d 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -11693,6 +11693,13 @@ L: linux-i2c@vger.kernel.org
> > >  S: Maintained
> > >  F: drivers/i2c/i2c-stub.c
> > >
> > > +I3C DRIVER FOR AMD AXI I3C MASTER
> > > +M: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> > > +R: Michal Simek <michal.simek@amd.com>
> > > +S: Maintained
> > > +F: Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
> > > +F: drivers/i3c/master/amd-i3c-master.c
> > > +
> > >  I3C DRIVER FOR ASPEED AST2600
> > >  M: Jeremy Kerr <jk@codeconstruct.com.au>
> > >  S: Maintained
> > > diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
> > > index 13df2944f2ec..4b884a678893 100644
> > > --- a/drivers/i3c/master/Kconfig
> > > +++ b/drivers/i3c/master/Kconfig
> > > @@ -1,4 +1,20 @@
> > >  # SPDX-License-Identifier: GPL-2.0-only
> > > +
> > > +config AMD_I3C_MASTER
> > > +   tristate "AMD I3C Master driver"
> > > +   depends on I3C
> > > +   depends on HAS_IOMEM
> > > +   help
> > > +     Support for AMD I3C Master Controller.
> > > +
> > > +     This driver allows communication with I3C devices using the AMD
> > > +     I3C master, currently supporting Standard Data Rate (SDR) mode.
> > > +     Features include Dynamic Address Assignment, private transfers,
> > > +     and CCC transfers in both broadcast and direct modes.
> > > +
> > > +     This driver can also be built as a module.  If so, the module
> > > +     will be called amd-i3c-master.
> > > +
> > >  config CDNS_I3C_MASTER
> > >     tristate "Cadence I3C master driver"
> > >     depends on HAS_IOMEM
> > > diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
> > > index aac74f3e3851..109bd48cb159 100644
> > > --- a/drivers/i3c/master/Makefile
> > > +++ b/drivers/i3c/master/Makefile
> > > @@ -1,4 +1,5 @@
> > >  # SPDX-License-Identifier: GPL-2.0-only
> > > +obj-$(CONFIG_AMD_I3C_MASTER)               += amd-i3c-master.o
> > >  obj-$(CONFIG_CDNS_I3C_MASTER)              += i3c-master-cdns.o
> > >  obj-$(CONFIG_DW_I3C_MASTER)                += dw-i3c-master.o
> > >  obj-$(CONFIG_AST2600_I3C_MASTER)   += ast2600-i3c-master.o
> > > diff --git a/drivers/i3c/master/amd-i3c-master.c
> > > b/drivers/i3c/master/amd-i3c-master.c
> > > new file mode 100644
> > > index 000000000000..cd9d85a0be80
> > > --- /dev/null
> > > +++ b/drivers/i3c/master/amd-i3c-master.c
> > > @@ -0,0 +1,1009 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * I3C master driver for the AMD I3C controller.
> > > + *
> > > + * Copyright (C) 2025, Advanced Micro Devices, Inc.
> > > + */
> > > +
> > ...
> > > +
> > > +/* timeout waiting for the controller finish transfers */
> > > +#define XI3C_XFER_TIMEOUT_MS                       10000
> > > +#define XI3C_XFER_TIMEOUT
> >       (msecs_to_jiffies(XI3C_XFER_TIMEOUT_MS))
> >
> > Do I missed your reply? I have not seen
> > https://lore.kernel.org/linux-i3c/aL7+Urm4NB9kwOwQ@lizhi-Precision-Tower-5810/
> >
> > If you need define two macro for it. Need unit XI3C_XFER_TIMEOUT_JIFFIES to
> > avoid confuse.
> Sure, I'll update the macro name to XI3C_XFER_TIMEOUT_JIFFIES to avoid confusion.
> >
> >
> > > +
> > > +#define xi3c_getrevisionnumber(master)                                             \
> > > +   (FIELD_GET(XI3C_REV_NUM_MASK,
> >       \
> > > +              ioread32((master)->membase + XI3C_VERSION_OFFSET)))
> > > +
> >
> > ...
> >
> > > +static void xi3c_master_wr_to_tx_fifo(struct xi3c_master *master,
> > > +                                 struct xi3c_cmd *cmd)
> > > +{
> > > +   u8 *tx_buf = (u8 *)cmd->tx_buf;
> > > +   u32 data = 0;
> > > +   u16 len;
> > > +
> > > +   len = cmd->tx_len;
> > > +   if (len > 0) {
> > > +           len = (len >= XI3C_WORD_LEN) ? XI3C_WORD_LEN : len;
> > > +           memcpy(&data, tx_buf, len);
> > > +           tx_buf += len;
> > > +           cmd->tx_len -= len;
> > > +   }
> > > +   cmd->tx_buf = tx_buf;
> > > +
> > > +   /* Write the 32-bit value to the Tx FIFO */
> > > +   iowrite32be(data, master->membase + XI3C_WR_FIFO_OFFSET); }
> >
> > i3c_writel(readl)_fifo() did similar things, why not use it?
> >
> > Did you miss my review comment or I missed your reply?
> You have missed my earlier reply on this.
> The helpers i3c_writel_fifo() and i3c_readl_fifo() rely on the CPU's native endianness,
> whereas in this case the FIFO should always be accessed in big-endian format.
> Hence, we cannot use the common helpers directly.
>
> For reference, here's my previous reply:
> https://lore.kernel.org/all/DM4PR12MB6109F6D5D032723C675472448C0FA@DM4PR12MB6109.namprd12.prod.outlook.com/

Sorry, can you improve i3c_writel(readl)_fifo() to support endianness? I
think not only you have this kind problem in future.

Frank

>
> >
> > ...
> > > +
> > > +static const struct of_device_id xi3c_master_of_ids[] = {
> > > +   { .compatible = "xlnx,axi-i3c-1.0" },
> > > +   { },
> > > +};
> > > +
> > > +static struct platform_driver xi3c_master_driver = {
> > > +   .probe = xi3c_master_probe,
> > > +   .remove = xi3c_master_remove,
> > > +   .driver = {
> > > +           .name = "axi-i3c-master",
> > > +           .of_match_table = xi3c_master_of_ids,
> > > +   },
> > > +};
> > > +module_platform_driver(xi3c_master_driver);
> > > +
> > > +MODULE_AUTHOR("Manikanta Guntupalli <manikanta.guntupalli@amd.com>");
> > > +MODULE_DESCRIPTION("AXI I3C master driver");
> > MODULE_LICENSE("GPL");
> > > --
> > > 2.34.1
> > >
>
> Thanks,
> Manikanta.
