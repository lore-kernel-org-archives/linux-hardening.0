Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013023.outbound.protection.outlook.com [40.93.196.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2EE239594;
	Thu, 18 Dec 2025 19:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766084802; cv=fail; b=lIDxevqYCN9TguhSKKEgA1rGCrwtK//7M+EELwz2FZfIHkhY9xY9a/Y2xaPFL+l2901qjnnNEAGnCVg13aSoDyocQv1u0xmkjFU0kukSiJoU1cyRjxTYAiIVMUwZ+GzJRrZEy0txgttkN3nLceiY8H9+Gqaxip80cW80i9mm+Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766084802; c=relaxed/simple;
	bh=ok5sGxDZ/Lotlm6giwAsuLyRsQj5z/mAPu6qsSULFkU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGuwKt8+DRHIHvdNFGDpsMmVuGEMpFidnaEExAnmajncf/yC8ReVLStjt6a+FhYKPrmt94DbmNPIF/TgNV5OvPLW0KA6o9g+E7ajxbh8yT3W3w/xRh0S59bHv5+Hm0S/CXSPTD48/xS4pKwXlwBkJoLIhfCIggQ6C+pS10YKesQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rW1NzNKD; arc=fail smtp.client-ip=40.93.196.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rW1NzNKD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zgl4X1XUS77ZiFAThMu9FD6tenU0Ou/oPNoKpaWaLIns6kRqk7H2ymKWj4kM6xQ7xMrZVFq+Cb2nbPv7WcxCHorZCZOpKnF8sRv5ow/y8k//R0UaKXxJYfBbcjI1/4qu2b1GeaQHgQHsiHfOWW1OGFX/55ws2K4/BGzOru6aXTSSzuNTv9eQlEpjTmlL91K9ED/3sscAv5Uiv9DdSPSt0y9Fu4lPCngRwlSuzdEGcxIreu+Ya08yKgg/4ljTAVNQcFZKMjmcQ73K/CAZH9TEJRGs4A9z5MUS1pBOlC1kiaKoTpU6ce6bjhHN3hyMhaj7RJ2/0VrJEWx3QZGIJxeLCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4ZWrplrKjhn1wiOYK1o6hkrsh+RZtZMd0Vjrhy0H+U=;
 b=FK6KPl4njxjpRP4DG3Mf5K/ubTd5sDNr2Fwy6Nn4Br9WzMtwgGGZ57HmvwSTsk/7NZ3ft8f2D+APiD8j1Ws4kMNv34IRA6kHRx95fi/BjreNz3QG3rouYBFae//vxzsmnnmwEXZv8yeD+/mJukw3xJpzQWVfEDwuRtib25ye0gfwFVXUsa7uHlYxiwR3i5kKUH/R0Im/qUq3OSAhwXxdAhUDkKFBqnQGE75fusDDM2YsGSWAwJ1d/ILZUHbWZCbfZvKvhgrstTMAuXVwpG+ZPzzLmxpngF0p8ArUJllmaqRAlFpF5tQoJ/mDMePEWywAbY5/C7pfqPkxCF+AFxCk5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4ZWrplrKjhn1wiOYK1o6hkrsh+RZtZMd0Vjrhy0H+U=;
 b=rW1NzNKD3/gHU2Mxx3e/uEej1hpFloCrxP00T2ATUzQTmMSS0tTErF/3YTZRGoBrqdYyCdxzKbRJFncvuZIQXGslG92T2VptoPmiZgIVo/KfA4jTXvYnzk1KJHawL4CKnk4u2jPtfOrEqh2OZaVIIEQBRzvAEYY2Pt9sEOhfG20=
Received: from BN0PR02CA0057.namprd02.prod.outlook.com (2603:10b6:408:e5::32)
 by DS0PR10MB7512.namprd10.prod.outlook.com (2603:10b6:8:165::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 19:06:33 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:e5:cafe::ab) by BN0PR02CA0057.outlook.office365.com
 (2603:10b6:408:e5::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.8 via Frontend Transport; Thu,
 18 Dec 2025 19:06:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 19:06:32 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 13:06:27 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 13:06:27 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 18 Dec 2025 13:06:27 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BIJ6RIw3861637;
	Thu, 18 Dec 2025 13:06:27 -0600
Date: Thu, 18 Dec 2025 13:06:27 -0600
From: Nishanth Menon <nm@ti.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G.
 Piccoli" <gpiccoli@igalia.com>, Andrew Lunn <andrew@lunn.ch>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
	<linux@ew.tq-group.com>, Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH v4 2/2] arm64: dts: ti: Add TQ-Systems TQMa62xx SoM and
 MBa62xx carrier board Device Trees
Message-ID: <20251218190627.4nun3fduu6z6yyl3@tingly>
References: <cover.1762775119.git.matthias.schiffer@ew.tq-group.com>
 <0079cc291c78b94068f3d8c59df103e951247acc.1762775119.git.matthias.schiffer@ew.tq-group.com>
 <d13a95659bdd1c840dfaa46afd6d8583f1b7c88f.camel@ew.tq-group.com>
 <671625aa-f5da-4e34-9c8c-7a1da282aa5e@ti.com>
 <637f14d1c77c2a1d19f7ea221addbbea51392bd9.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <637f14d1c77c2a1d19f7ea221addbbea51392bd9.camel@ew.tq-group.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|DS0PR10MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: 4efbd111-8d0f-4345-2b09-08de3e688e84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ygfnB3FR0ekFDbCrMFZrI46Q/AvEgqcUGEKQWurVcGqRFDa12lqfeUt1C+ru?=
 =?us-ascii?Q?oZdH0ngxtDQ1EXjeCjN74oK49Cg8xTdVIt4s42Q0J+hxH21FqH36F44xTFFF?=
 =?us-ascii?Q?sgrVBwOXRqxMdW8eHm/2GFZKOf6MLNg1u/4JqnhGvzGFsZHCgB5OTbZFlbD/?=
 =?us-ascii?Q?3rv4P0F6v0paCb1tYF/QWA7dHYG/JFy/hPC+GFeWwmRDyAYx+OoMQTIJ3SEr?=
 =?us-ascii?Q?KeHNz3r16POPBmkkFpkmgba3yM1hF3cV18flHyie6+gzyyOYMgLPqWd5cY10?=
 =?us-ascii?Q?5ocJpfScy3O24J9V4jAOfM0RuCSDyLxXNFTUAjuEV6hgOXKfTuK9DJ1gVWcM?=
 =?us-ascii?Q?DSx6kdiC6Ojn7ydCHJr73uAMDmTJ6Ak6WykRIo/8ZCaeobnpyqnhEOSY0gOu?=
 =?us-ascii?Q?9TH2zGmEbr4fOiS/9F04rIxG9vpZZ7OVoPFIxoAYUOJA0eHe//7PvM4VDUep?=
 =?us-ascii?Q?rZN9owEZKchL2oNN58WFuYUKmP4eWgGG9bWU3/kIx0s254xVcXnwuUxK15pz?=
 =?us-ascii?Q?v5zU5zjng/VPL2mA12D/JZXUR4U/dmU1XnLjlKp5OrS/ETWuWfz726Eqnbfd?=
 =?us-ascii?Q?l0j+b9cHtSCWnV3zT6h7U09bHyWKwPtSwuT+7hUDa70sAgdc09s/dokGy8ft?=
 =?us-ascii?Q?PmqMV1kpOOt7iKRVOb+t2H7EKRuKgSR8zfGBa6mu+0vCdbS+aLiu+m/9gWsm?=
 =?us-ascii?Q?yvYOaRyHsCfIy7/+XTufwRPy0llW/dcZd8RE2CrOB1jFOnubelQ+nwuh76Jc?=
 =?us-ascii?Q?tbp67+jt0Oy6TER7nBV4SeoUWZluZAyvHNnFUwXVkUjALqX8dtcHXkPAAM2w?=
 =?us-ascii?Q?djkFsJVX+fATcfo3aMRWByrqpu1037MB5xEfpWaihh/Y5shLJOQ3uuy5Bo17?=
 =?us-ascii?Q?vIEiAMCcF5zSMH6aCQZ8hTCyc0+Grwh3b0R8R+AkENLjJQEVZ5J3WOGyx+vN?=
 =?us-ascii?Q?DCBMnQnqX9Tt1k5UWZd3mi/FfGaKfki4rj40N6QI8SwMGI+/0J5U+KYgoN1s?=
 =?us-ascii?Q?9Cjgr6xIHU/qhvUqqaKQAvYw+4oTIKT/FCawjDh0SvBPV5Z2vLNYoWgqfCnu?=
 =?us-ascii?Q?V+0D7FOzew/mZvomE7kg4CV/Jb6s7kajERmbktiahaS5M35PskKkZZWV+hWh?=
 =?us-ascii?Q?ZptN/eBrCYxuEBR6+LsRLzQfo4exLQskk9gtAtMeL5ObrDLW6VRD39Wy9jGU?=
 =?us-ascii?Q?U2Ne+AcZId5iafJ5Dy0FjqVEaPzhtZyIlkvrOzIcXG1pEwGojb6cdwEsMtWC?=
 =?us-ascii?Q?WeqifYD/yBIzJQXx/rQObheDTrdhwiqgnWJFhmht7sBRO0Rb94kwI1hQRUpb?=
 =?us-ascii?Q?jlVk5XKYDnZgMcqeBrLI7IxbrSe84IWGarM1BiU1wV+7+AwA94BycyK+M9Wv?=
 =?us-ascii?Q?OCmyvLoR4AOOr4ClFGsmqCoUn5nbHXMz5A3qc9Jd1aUnn78dsY7s0rJRzh1r?=
 =?us-ascii?Q?gvThkHFgtjwuzIqrte2AnSMGHLK1XExmU6d14wJ0K95mIAp9IhrfNbwQ2fC8?=
 =?us-ascii?Q?zyLhVHaZe8Cct1awMyA5HCt2UX+mUTnFeiVmsPFRcGtzlq00K2z4XLpV4IGo?=
 =?us-ascii?Q?JypOrBNbaRQIM7miuMg=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 19:06:32.0625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efbd111-8d0f-4345-2b09-08de3e688e84
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7512

On 10:10-20251217, Matthias Schiffer wrote:
> On Wed, 2025-11-26 at 10:47 +0530, Vignesh Raghavendra wrote:
> > Hi Matthias,
> > 
> > On 25/11/25 15:32, Matthias Schiffer wrote:
> > > On Mon, 2025-11-10 at 12:49 +0100, Matthias Schiffer wrote:
> > > > The TQMa62xx is a SoM family with a pluggable board connector based on the
> > > > TI AM62x SoCs. Add DTS(I) for the AM625 (2x Cortex-A53) variant and its
> > > > combination with our MBa62xx carrier board.
> > > 
> > > Hi Vignesh,
> > > 
> > > do you have any further comments? Can we get this in for 6.19?
> > > 
> > 
> > Oops, this somehow fell through the crack, my apologies!
> > 
> > I have already sent out the PRs for v6.19. Sorry, this would need to
> > wait for v6.20 cycle.
> > 
> > [...]
> > 
> > 
> 
> Hi Vignesh,
> 
> will these patches by applied for v6.20 (if there aren't any more review
> comments)? Should I resend them?

Yes please, Please resend after rebasing to latest next. Vignesh and I
switch picking patches, so the v6.20 window, i am picking them up, will
be good  to repost them so they appear in my private patchworks for me
to track.

Please note that there are additional checks in place so, will be good
to rerun dtbs_check prior to posting.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource
