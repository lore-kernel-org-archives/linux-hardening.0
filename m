Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012037.outbound.protection.outlook.com [52.101.66.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9544C36CC83;
	Tue, 26 Aug 2025 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223778; cv=fail; b=Ep1671zfsMye520FmpM/GR1rlbvuXvo5EtzP8Gnrd6AC4xtiPn6FhMk2725f+3FnSPLViDagrXd1XhmMi3esw1AM2fExNDQVZ/oueXdCCA0Ub8ZazPKKJrfeCPZpC3BJ3CIDPSUK6/odR7gaOHkUpcKvnW30MThpHPSf7ILyDIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223778; c=relaxed/simple;
	bh=/6QyV2d7cJAGIcfDe10PQf9jpA7K9eTq0SEHopTwTq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k6AzMuq2vxpLO1FGm0Xb77JzgsvVVI5Xk8yMdF+rfB/yhuLNTxwpH9i4qHIfTvdzCw4vV59CQYJCzxm3dzqrmdV60ZyJrGQJF4N2KHoFpENs9Jp5WNJtvlH93hHWCIr+UZNEvJcKejBxJvHLg5b7EjtB0yrlXuXFaEwxClATfj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JA0cJALd; arc=fail smtp.client-ip=52.101.66.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JA0cJALd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbH5uAqw865lDJWLvu3HE4iXSUfC/6sz6vaLpeQqvEvNi1K9xN355sMrYoEjIQlmpotV5XOwTDKb20lilEIOE19TLIkvuTV2RKdk4yP9S4HzBg/qsPjs4CDvIYV+sjvHgdHLGBqaAqugcobMJ1nQuYjdK7sczwObIJRmfSomm2JF3FxmqRezmkbDY1LVosfFvpmRxiFtlQ01L6DhTtwD7xc3vIt/vB0D/cA3ptrhp5UJpL7fU4WdWIVHFqMzJQBXgm62NIvra3sT84+TQGL1HmcYuA5QVkVLQBtlQqr2+If1u+Vl4ItNK5qIJJ999bRrgQnYyu/FCya6TLWJvGP/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LP9e0mARoGxpI5y8Ofnytj+d6FhtikldcdRwhy68bHI=;
 b=f2CiwoaFfJ1L8vOQiarGbgm3iKLX1U9R1N3ZFZ/5n5LLh109/G1wAf7f0aIHH5CNM6gHeb0Gz3To43mm+Ot5irVe0OlA6rHdcgsJPHvR745TAQCBZfq1ogfLG9NeodMIqFNeonjLOiLtxzAztFLEuECNQvsutBzPYD60dizCXdt5j8CmtEfqWD9ecJES06q8OpiSWcezyO0jqaIixKB6tDS8jhh7XDZqtYEa/A9EU/DJh0AfpLVcIJx0utBpHTXc8py4YcUcWL2elrt9juuLUbqWWDrFKFE0u7e36uPHL3rkiSoLMomQI6bYrqtWztQJuP9GimcXrE8hzJrFH4XyBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LP9e0mARoGxpI5y8Ofnytj+d6FhtikldcdRwhy68bHI=;
 b=JA0cJALd9busUr63nsjX18mxqQBHdFks5S1NTT3wpDHDz1/PmBZH64gQ/6iXL4oMxHqWnAeWR+/TtrE7P/PQ+EY8OnqrtNJjqoG+wPUQvhfhuVR4ujLsA5oWB8jG2KldT8DKXCQI5wwoampmlmLtKj/AM9wkAEoRclgjJeImxT8VnFELmqofvqm/kU22N1VLbUe5skG8gcxZFJ3yVmskSQ3j1hIp2tJJKR65rS77ET7ZwRRBbJfhOQpiZQHLgWciULfIYPvdlXWp3fJ0/oeLFxgbA3jIGRvWslGkpF2sUca24Vnl2rPHK906bhOfHrj8ROv2sQMePLqU+WbPDpYILA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB7591.eurprd04.prod.outlook.com (2603:10a6:20b:297::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Tue, 26 Aug
 2025 15:56:10 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Tue, 26 Aug 2025
 15:56:10 +0000
Date: Tue, 26 Aug 2025 11:56:05 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, gastmaier@gmail.com,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v7 0/2] Add ADI I3C Controller
Message-ID: <aK3ZFSQ9FUwuxT12@lizhi-Precision-Tower-5810>
References: <20250818-adi-i3c-master-v7-0-f7207902669d@analog.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-adi-i3c-master-v7-0-f7207902669d@analog.com>
X-ClientProxiedBy: AS4P192CA0007.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::19) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: 859854f1-aa81-452e-780c-08dde4b9138b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|19092799006|38350700014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mReCQ31SIrdMH0uL28TTnZ7kHdI+fXvIVvbBfm0IHy55UEEJoaPSfd1IHgF4?=
 =?us-ascii?Q?I8NzTjgV4eZwv2+Zus+lnjMorGrZMyl8Q9IenGAEKKNokcDq0r1SR5WVbAOn?=
 =?us-ascii?Q?8tWPBvxl7UHatWEJWprfZ8Cf0plQKb/WCGU4aXBoFyWlc7ke5Ky0VPMlRdhk?=
 =?us-ascii?Q?yAXUiYug2gqqsS1f0AU4zBGdekVYJMqsH6yaltiCqQ+7dk+RSN/RKnzs2GpZ?=
 =?us-ascii?Q?5uTsrGWlFiKhvKucnkk9Uc1g1YrjWiIeMqKjMyeVkQYk0zZsXnAanefY52Fv?=
 =?us-ascii?Q?vLwgr6NY2/OiHZBNixKe6aBrvgSVlx8ZeUthgNMLHbhs/nePCjSiMv/BPmC+?=
 =?us-ascii?Q?fLqVNMWZui51hphJDYjh1OO+tV22aTokARmioQPJBMc0HrmB7tPW5Zt8ByPY?=
 =?us-ascii?Q?dV7o0ZtoalKOz6uandoEFgjtPIkEfV2xdtfWp3cCHra2qdxypfqAJRu9cmuc?=
 =?us-ascii?Q?bwyU5YJFbp9ayR60VAw5rhAMkpPki/zSTYNoA5ny6BAntb8mZLNVzxwz0bIu?=
 =?us-ascii?Q?4VgSs6B1Pr3z4XjgFirUUDfQ86cEoBQ5v737gNdzPHuAuCtiVfZRNgK0pDr2?=
 =?us-ascii?Q?ffh7d0I8leWorUZ5nk4XadDf7FrLLHu1gTpoxwtgcpmkse7Wc539vUJvy7eR?=
 =?us-ascii?Q?naC4ZXQoDbIFb+o/ig+soitn1lmG7JQB7AWm83CGNtO/5uNtvbj0LCP5yM8k?=
 =?us-ascii?Q?ZWqbp4lDkKsvqk0RTe5JTMT3tq+pxueNUexf9KTARbpo+EIdL8FjVrD9k3+R?=
 =?us-ascii?Q?7FlLRk4pCjLEnHsEtG+E9Dg11hgdR0O1Tp1wyCBs6eaTspJ+LUgy88X2kIx2?=
 =?us-ascii?Q?f9hxgbKyE6uUXUFVoaWnrBsyo7YJRCjriHjSRdAnlOkL59HIeit2pMmu9+ZX?=
 =?us-ascii?Q?LuPUiXd6/LsbVzTbtJpxLee5msghxoVTxJrwFHAdLTBxfVrn9WU1Cdl0Jr+l?=
 =?us-ascii?Q?svfkgqqXA4jlYl8cPbrnMmxiXXYAzO3yONrDcsozsCLwTBuEBquCqPUQlJac?=
 =?us-ascii?Q?BKSW/b4kf6IXEmACrmt96uianRsRJtg1E1KDC+04VyXumdllEx8UuUEVlOMZ?=
 =?us-ascii?Q?t4AKPJVsW3/u5F4yRz6s3yCfe3U1kj4MGD+ymyeLy1+IEmF/LVQI6ICZoRkp?=
 =?us-ascii?Q?V1378xdeiEFAH7/KtZBbkWesNHlX9DfYXnMHIpHLH+/AAPSdOUUNSeKg9RD0?=
 =?us-ascii?Q?HVThZXktCRWS2+AhSXuy1MapBtH/ZGocHADTtcwYEa7F7o+TQGzPpT5fVrkP?=
 =?us-ascii?Q?FmZ0ptc7P00Gey+ftwZND0NltYPuk4UurqNvpz4S69DOCeFjXG2aAfLZ5YAi?=
 =?us-ascii?Q?t5jU1QR0s1qoDRVv/5/11LdeOmihNos6xSAW19c5PO1/BlC0Tn1VSSL5j1dk?=
 =?us-ascii?Q?XWAqOXlPJMNDs8h56phMlvretCsdbWsanx9DstXFqpkdX8f/1mngj2QacPPk?=
 =?us-ascii?Q?0ZZtoHObtGk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(19092799006)(38350700014)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kgNlUQfTLa2pLfocTo+H57UW0/GgqPdH9kLJgeoKNYMixMFH1tl3vS5HJD28?=
 =?us-ascii?Q?Gk5nTJqCt7VPRvZeYtjrAKj6zk2EFLsIamMhpiKtvGg+BLaxE2bsHFnu+DIR?=
 =?us-ascii?Q?O5dpyfrXb5fRCzhmcpLRFF8SlwecFxVF2HsbBRDLNtPeZlhy9hkGqxbp76PG?=
 =?us-ascii?Q?2cdjcOH0DTbkF/dwWveVNXs6Le6bQE1wkIjcoaHfB0hLWqvct4EL4Lr37WeS?=
 =?us-ascii?Q?9KxOHNJVE8s9K94rSZo6PpijGKTeU6ZWZI6JsSxB00ZdIVhIyLBsBrA5QLjw?=
 =?us-ascii?Q?7TNIRlGAYPWwuULRwLE+tx+qB1cGteNSy1/FKztnRpZz8e39gsnHHKG3NQPN?=
 =?us-ascii?Q?1VIpOAkIfcmXCnmoLRe3r64jWJvYBBa3Kz9YL2X0pAhzuyq3WRy9j219dsPU?=
 =?us-ascii?Q?ZaSUfx0xc2TOOtWpPK5nPqREkeAlU0QU5izrQtjhrb9c6TWWsTjQzGqkj2uM?=
 =?us-ascii?Q?s2sXT5ZCATn8uqADDB+4y7aa/c2Q8iN/O80J15oQy9Z+MpxgUErRefwePAE1?=
 =?us-ascii?Q?qw26O3i1Ar1aEQ2FAupZsYDH/fkV8eQtpcuELaawOK8yh6fxUbW1T3BNIdMt?=
 =?us-ascii?Q?NfhMCo3ITKY1tnjGIqMnc6Ae1mn3uFVZKAjecaYXbumkrdDvGGnQTTdhxKzy?=
 =?us-ascii?Q?sltBXb9Rtc/PCBV92tHrRZSnjV2XbSHRV4gg/qgEgzsVZoyt2yZyKPYSwwqk?=
 =?us-ascii?Q?lIZF1j/HsevglLZ7cdxZC0qFWFckInruhTQrbncRWZmArrzAgjIuknG40HQ2?=
 =?us-ascii?Q?VxBBEVGK4ACs+zTdImSd1nr5vvqGaS6YiEqeiWKW28nnAZHNfX0H44soAWxD?=
 =?us-ascii?Q?tW7TWO6SNL3jhS1rdV5gr5mTlanjGhZl1M4mlJ87dpwFaPZsWx+kLW12HMOc?=
 =?us-ascii?Q?jXl64Nyj23FgCVT7b6PdOO7rfcnFA/6H+QC7VKiBvzKSlcskh0DKQcAYgkXl?=
 =?us-ascii?Q?SkeB2dFS0pI0Fx6v9Sn69ECgfIPOTT2oVs4uUh2TI3mzSHRTL34StW0TAD2t?=
 =?us-ascii?Q?fS7ylA9dkVEAfEjVLfDjdPBhAhlyGX6ZD3Jvb/Fvm17WOuSYM1z9O2Z0p+vq?=
 =?us-ascii?Q?p3+A3jAayJIGio9lWdns9h0Xq7yorQqNPbpWydtKaj84selVlmBq/nswJ0Ch?=
 =?us-ascii?Q?VP3JzTf4fnCYGM8WhlVLb3pKAZT+rul4ALnqxYtm6vnIP3mfHHy2K5Kd19wz?=
 =?us-ascii?Q?dgwOkGz83VEa46fhg6yAdgMxvTL6XTPfOT8jBIJbrLliNdPwn2uyXDOikwdc?=
 =?us-ascii?Q?s1rsoXuts1UrdAZrVqLoZTLHb2JYQND1e9yT8dlZAwek+nYfvqIZYto1Qj8l?=
 =?us-ascii?Q?tjtKo0ttNBWHAjkiH66TSqtszGJDtNOua7ePtb1kGqEChwxSaeREUOf5MFDi?=
 =?us-ascii?Q?EyEItYuscbcj4fPQlInrouWbiSz9Ds+2ddvkVA3lA3PXpWNUj3qrdRc6akwf?=
 =?us-ascii?Q?bnyAOTBTgidwu8/W5NmbM+1Na7D6NE23I9faG2icEBHERgbyZXXJsqmvn2Yt?=
 =?us-ascii?Q?tRhyCNsJxgrAEzGoT+HiDiWNarqusnyy8lZZpLvXFl3n1aR+WaoT6ttYGjHb?=
 =?us-ascii?Q?SOchX/TBh5rlvdDz/Vo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859854f1-aa81-452e-780c-08dde4b9138b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 15:56:10.7680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0iWtfaWCx0oK0Gp79uVkdL1Y74wYcnL6o1xDb/lJC352wLbxbt7pvC0ThVFo8+MTTRJ50mgujMrhg+Ed09ahMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7591

On Mon, Aug 18, 2025 at 01:51:12PM +0200, Jorge Marques wrote:
> I3C Controller is subset of the I3C-basic specification to interface
> peripherals through I3C and I2C. The controller RTL is FPGA
> synthesizable and documentation is provided at
> https://analogdevicesinc.github.io/hdl/library/i3c_controller
>
> The main target for the I3C Controller IP is low-cost FPGAs.
> In this version the driver supports IBI (only the MDB), I3C and I2C
> transfers.
>
> The IP Core is versioned following ADI's open source HDL guidelines
> for devicetree bindings and drivers described at
> https://analogdevicesinc.github.io/hdl/user_guide/contributing.html#devicetree-bindings-drivers
> in summary, follows Semantic Versioning 2.0.0, with the dt-binding suffixed
> by -v<major>.
>
> If necessary, the contents of
> https://analogdevicesinc.github.io/hdl/user_guide/contributing.html#devicetree-bindings-drivers
> can be replicated to a file in a different series, similar to AMD Xilinx
> at Documentation/devicetree/bindings/xilinx.txt, but as adi.txt or
> similar.
>
> Depends on https://lore.kernel.org/linux-i3c/20250622-i3c-writesl-readsl-v2-0-2afd34ec6306@analog.com/T/#t

It is already in v6.17-rc1. You can remove this depends.

commit 733b439375b494e8a6950ab47d18a4b615b73cb3
Author: Jorge Marques <jorge.marques@analog.com>
Date:   Tue Jun 24 11:06:04 2025 +0200

    i3c: master: Add inline i3c_readl_fifo() and i3c_writel_fifo()

    The I3C abstraction expects u8 buffers, but some controllers operate with
    a 32-bit bus width FIFO and cannot flag valid bytes individually. To avoid
    reading or writing outside the buffer bounds, use 32-bit accesses where
    possible and apply memcpy for any remaining bytes

    Signed-off-by: Jorge Marques <jorge.marques@analog.com>
    Suggested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Reviewed-by: Frank Li <Frank.Li@nxp.com>
    Link: https://lore.kernel.org/r/20250624-i3c-writesl-readsl-v3-1-63ccf0870f01@analog.com
    Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

>
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> ---
> Changes in v7:
> - Edit cover linking guidelines to ADI IP Core versioning.
> Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml:
> - Extend second clock description to explain relation to synthesized topology.
> - Link to v6: https://lore.kernel.org/r/20250717-adi-i3c-master-v6-0-6c687ed71bed@analog.com
>
> Changes in v6:
> - Format 0x05C undercase
> - Link to v5: https://lore.kernel.org/r/20250715-adi-i3c-master-v5-0-c89434cbaf5e@analog.com
>
> Changes in v5:
> Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml:
> - Use semantic versioning major field for dt-binding compatible, with
>   the format adi,<ip-name>-v<major>
>
> adi-i3c-master.c:
> - Rename MAX_DEVS to ADI_MAX_DEVS
> - Encapsulate REG_CMD_FIFO_0_DEV_ADDR var
> - Reorder struct adi_i3c_i2c_dev_data fields
> - Start addr at 0 instead of 8 at adi_i3c_master_get_rr_slot
> - Minor rework on adi_i3c_master_handle_ibi to most logic out of the
>   lock. Even if length is 0 (BCR[2]=0), the mdb field is extracted and
>   written to the slot buffer. Since the length is 0, the written data
>   doesn't matter.
>   In a future update with additional bytes support (e.g., bits 31-23),
>   len would be incremented and an IBI FIFO would be read.
> - Version check against first stable release, major v1.
>   Driver+RTL features updates affect the minor field, therefore check
>   for major == 1.
> - Link to v4: https://lore.kernel.org/r/20250626-adi-i3c-master-v4-0-3846a1f66d5e@analog.com
>
> Changes in v4:
> Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml:
> - Add -1.00.a suffix where missing
> - Extend clocks descriptions
> - Add minItems to clock-names, to match clocks
> - Use header in example
>
> adi-i3c-master.c:
> - Regmap:
>   - Add new controller info registers (dyn_addr, dcr, bcr, pid)
>   - Always decreasing fields
>   - Add line break between registers
>   - Reformat REG_DEV_CHAR_BSCR_IBI to use easier to read FIELD_GET,
>     FIELD_PREP
> - Read controller info from regmap with explanation comment
> - Use linux/fpga/adi-axi-common.h macros
> - Use __counter_by macro on ncmds
> - Use __free macro
> - Use new i3c_writel_fifo and i3c_readl_fifo macros
> - Rename bytes to buf when nbytes is present
> - Use scoped_guard instead of spin_lock, spin_unlock
> - Reformat loops to read fifo status, use while single line alternative
> - Drop adi_i3c_master.max_devs, use MAX_DEVS directly
> - Use devm_clk_bulk_get_all_enabled, dropping clock name match (CHECK_DTB does it)
> - Init spin_lock
> - Init list head
> - Link to v3: https://lore.kernel.org/r/20250618-adi-i3c-master-v3-0-e66170a6cb95@analog.com
>
> Changes in v3:
> Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml:
> - Small reworking of the description
> - Add -1.00.a suffix to compatible
>
> adi-i3c-master.c:
> - Misspelling
> - Remove REG_CMD_FIFO_0_LEN_MAX since it is a HDL parameter
> - Use adapter timeout value for I2C transfers, as in
>   https://lore.kernel.org/linux-i3c/aEBd%2FFIKADYr%2F631@lizhi-Precision-Tower-5810/T/#t
>
> - Link to v2: https://lore.kernel.org/r/20250606-adi-i3c-master-v2-0-e68b9aad2630@analog.com
>
> Changes in v2:
> Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml:
> - Move allof
> - Rename clocks to axi, i3c
>
> adi-i3c-master.c:
> - Update license year
> - Rework regmap to use FIELD_GET, FIELD_PREP
> - Reformat regmap to have FIELDS after REG, prefixed by reg name.
> - Add overflow safeguards to cmd, tx fifos
> - Fix macro related macros (mostly erroneous `| ~BITMASK`
> - Use guard macros, remove goto.
> - Simplify daa logic
> - Replace devm_clk_get with devm_clk_get_enabled
> - Solve 64bit->32bit warnings on x86_64 systems by casting to u32
> - Immediate clear irq request flags, then handle it.
>
> - Link to v1: https://lore.kernel.org/r/20250604-adi-i3c-master-v1-0-0488e80dafcb@analog.com
>
> ---
> Jorge Marques (2):
>       dt-bindings: i3c: Add adi-i3c-master
>       i3c: master: Add driver for Analog Devices I3C Controller IP
>
>  .../devicetree/bindings/i3c/adi,i3c-master.yaml    |   72 ++
>  MAINTAINERS                                        |    6 +
>  drivers/i3c/master/Kconfig                         |   11 +
>  drivers/i3c/master/Makefile                        |    1 +
>  drivers/i3c/master/adi-i3c-master.c                | 1019 ++++++++++++++++++++
>  5 files changed, 1109 insertions(+)
> ---
> base-commit: 51963783b876a2f493a3eac0ea9eba271cb6809a
> change-id: 20250604-adi-i3c-master-2a5148c58c47
> prerequisite-message-id: <20250622-i3c-writesl-readsl-v2-0-2afd34ec6306@analog.com>
> prerequisite-patch-id: 5443f14ca82fc08593960fafdb43488cce56f7d9
> prerequisite-patch-id: 647084f5fe09f4887f633b0b02b306912a156672
> prerequisite-patch-id: 6f582bb2ef1aafb66f26c515a19d5efa06ab8968
>
> Best regards,
> --
> Jorge Marques <jorge.marques@analog.com>
>
