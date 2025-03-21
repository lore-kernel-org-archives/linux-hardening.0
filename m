Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE3CB664;
	Fri, 21 Mar 2025 05:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742534846; cv=fail; b=vDR/x0p0wKRjVMWY7Er6uUsWWPBVl+yD7jGsW4L6Dx3oyyIfvUzzUn/cqQ924Ed/bFnZ1hOC37QJvy5qKY5ZRkYABepyLX39n68iZCHFut11W+5g8JuoFpAEtzwlL0AMAXR7dTUMAmljseniVo+BzY92/cE74f3QzJS0f6puP5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742534846; c=relaxed/simple;
	bh=r02zmA6/j2pmJ97pctzGtm/uKeXGnsPKq52ta2mzTbA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KV2xhthBcNSQvCynxXjmSj4q1okqgVkT5Ljg7sFdxt7yCMd0g76DgQ2ns565cs8Wy8ziDiE56ysyn++RxxgvcKjKKFkOpd990icg4/xdqYpDKfG5Hi7JJbywXTwDlr/NHaHoonaifytz5YwUDzdVlpBnG4rA9I/wh1swVj1YaIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l2aB2qpQ; arc=fail smtp.client-ip=40.107.96.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l2aB2qpQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYA50OOlLMSCrc8NhFc5bi5Jj8tMkSZ3b0xwNzhVLLJ8aArQ0mLrOr0wO8USXFLQjDNSOw7nVX+LwsGtRUpPROKUUtQtuNF0xWabnHMVCRQth1xZSrnxRNXzIUBruXI92BQ6dnwisiI/7SHmZDeypyZnCXFcuWMOh1bLmnwFhU+OiPAk8dXQFw6tqZjVIgvmf7JoQQ40DZ25vZyb51jx5qbt5CCcVvEd9MQUZG7Tv602XT8AkYU48X6DXE3hjSqFdmG7oBX4ZwSDyDvbiwsj3q9PUS1hmaTAPNDtfwiZt7XXEtlTM+NwBvAY52ZrnHweGDA/vtsoXQIuIS2QWjTAIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWe4i/o/emgIU7KiUTXmsXGJjkkR9LPYZ+BbJq3N7u8=;
 b=DrxJF7SI9gJbYZPdez0TT3n2mpznFFZzlTzgo6rbDV3NqRnIR84MguWwHiSn4LSumHg9cnKFW9aFpRUXUexzDdPHwXm9RMNaG77ZX4glEnoNfsGOVFtj0JcYxaEvsck1Hqkw9fPBSUfJ6AsK6qNuBplQUqhz6B7w58iNqgSVDlMPPq9woUgG/DVA7VcW8eHa+jK7dEV7Lospe8kotYNg2upaLuXHKey0ow1+bYfNhlSlUldrSHWQw9BCXa66PqOA+EwP75K6vdBXKbUnDAyFEZ1R0GyD1gMt83ozl01FAAbVYJ9yoDVb4u17SXPZfOI0vawM17yCSCERxllqa5xp4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWe4i/o/emgIU7KiUTXmsXGJjkkR9LPYZ+BbJq3N7u8=;
 b=l2aB2qpQA7MC7xMe8rtF0dnQW769LgmtsdgZC5F5o0BXdfRyUBm5VFDthPkUjjrJPfFFPhU9zTKA57KFEwokHWFq1LgzFWqoghUPm5FqSDyNb5zgc6Fl6nfhx+bHo9reKlg/P2zdMYbvML99G72qwpDtu8MOsg89FF748JMfket4wOkIL7SoL6cZHA0upz16s6xTQyiltYTxcu1ciHROjGIibakmvtaa9pJ4gpK7WbMDMjAi9JzihNHuH7UCSgqxQIClMN29kDNPxHHSa2QX15Cd1zJQWnIqH1WuSyBRe384BANKuoOQfUSK64dA8Je/tNWcQ+YLggmTcFskR9el2A==
Received: from PH1PEPF000132F7.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::3c)
 by IA1PR12MB8553.namprd12.prod.outlook.com (2603:10b6:208:44e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 05:27:20 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2a01:111:f403:f912::2) by PH1PEPF000132F7.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Fri,
 21 Mar 2025 05:27:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 05:27:19 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Mar
 2025 22:27:13 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Mar
 2025 22:27:12 -0700
Received: from willie-obmc-builder.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Mar 2025 22:27:12 -0700
From: Willie Thai <wthai@nvidia.com>
To: <andrew@codeconstruct.com.au>
CC: <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<dkodihalli@nvidia.com>, <gpiccoli@igalia.com>, <joel@jms.id.au>,
	<kees@kernel.org>, <krzk+dt@kernel.org>, <leohu@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<maryang@nvidia.com>, <openbmc@lists.ozlabs.org>, <robh@kernel.org>,
	<tingkaic@nvidia.com>, <tony.luck@intel.com>, <wthai@nvidia.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: arm: aspeed: add Nvidia's GB200NVL BMC
Date: Fri, 21 Mar 2025 05:27:12 +0000
Message-ID: <20250321052712.104446-1-wthai@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <585c2b050a44f4009b3a61cab69f800c88a0cf5e.camel@codeconstruct.com.au>
References: <585c2b050a44f4009b3a61cab69f800c88a0cf5e.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|IA1PR12MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b334aa3-0d8e-45e4-a8df-08dd68390d0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/BFd7w6qYybSixwtYLholfNEeUXI04hCCG6Xv39JK2EanSiRDJo2vrrkm0uO?=
 =?us-ascii?Q?t/jYdeUO1chAFXmbYeqImJ8hWgx+Y0piNtJSyAYpYb5mR+96n93cnhgUp2aO?=
 =?us-ascii?Q?P5FZwOsPhTjIPUoUV86NKogKbyk2W8CUf4/Rij+tsSbK9b04HoZr3ANFED5L?=
 =?us-ascii?Q?e70xY3f2Omxu5Mg6iARKuJXBEmaRBHygrxjaLuBAPzPfoIuuSnIPSpWY0p4o?=
 =?us-ascii?Q?o4WD1oY0B7fmu332KN1+a8ZYhbOQei4WstWKG9tj1194q0p8gIyzwWH9AaNR?=
 =?us-ascii?Q?RRojdyBmomAWFc52Hg0N1szqf3Qu6pKzeKaPUa3LsoQkHl2C5/H1jGfqTObK?=
 =?us-ascii?Q?LyfjpCX/mIVaxFfJOsREKwexk2JcCJ3Ev2VpCxKus7XmomjZHa4hlKyVDwoA?=
 =?us-ascii?Q?FJE0HZhUmtMvbXICvNMRUD/k54qJtaB0uxXIHRDA5fv5g7ZZQ+0jXzxUdgxw?=
 =?us-ascii?Q?izb1WMd0YY9yXX5RPjckQDH7XCS8gF8WOjmsyKfr6EKJFiroq6ZIUzjP7dNc?=
 =?us-ascii?Q?APcgc1IjKMfajaZXFG4bmXOUUGhUYwkmsMyvFyY542hgd1ZqTm3GJkxkBRQa?=
 =?us-ascii?Q?MqwmJiEh9T5jMHTfJMjNpNe+BspwsKzbUXk0YTI/SZE9wAzCgE+pIQkJo8Vh?=
 =?us-ascii?Q?oAEYx1OLteLFVXjOKUVIAmsbarbd3cwa4sNQ/bCMfppwBB1nJT2902FX/Gl7?=
 =?us-ascii?Q?Dlwrma5nEETqiFvZvPHDcy56LmWEuLTyP9yWSWji5LvhO7OcLAPJQ9NWYKby?=
 =?us-ascii?Q?m/G8ei79UWsFJDmjVo5kxq42Uzd40JtX0rHmjUVZHVbE3ANb0rP9uULnhonN?=
 =?us-ascii?Q?kulTVW/HWxuh8xA54AXISlFrtrkdMe/6OddwtDF3X4N0GT97MVKKHMpzHzIf?=
 =?us-ascii?Q?iZAIiMF/kH0CWLS/ZJxfrWhY+4KQ+YhSrGcDrQlqorDw8wP6senDJ0nZYORf?=
 =?us-ascii?Q?P3M+9R8HUciMASB67Og7CDpcptm9bqQfPF2dPg7O5rK0qYgGf6TbDysWFw6M?=
 =?us-ascii?Q?atUzO8SiEl/weSCVHm0o3vGQLBE0msISWJpJek1ScjMuzv8rKIZLaA4USEOB?=
 =?us-ascii?Q?V7HghJ5sYWAeajmyzWl58yItODN2y5LyPvjx1L5XWfrWLkzpGS1nc89nkdIo?=
 =?us-ascii?Q?+mEfybx6fdtIBCeWUxWGIz/Cut6dGJ+ysz9Ux79Y/1VbJ6DWMmcxERHu8n7w?=
 =?us-ascii?Q?3eMahbCpf3I1qlrOVBKJoKde7ob9lwBWznz6WIobS42DHd2PQbzH85p5iwrB?=
 =?us-ascii?Q?1y+jCB0/FvP927tlPMLM7bkfz7qY+QgxcaaRGeN5xghTpd9G/VDEi6cZZ+3d?=
 =?us-ascii?Q?jd8DtSoDRpWY3r19vXWRJBJvcuaT24F4fE+Av8JtFNFJzoJg/ziXbq0gqqfz?=
 =?us-ascii?Q?SArmMnm+xJpw2Qz0i9aA+vYqZRLaYBkjY1wFyL4CKOsPcy9FupzmvJDE9VxB?=
 =?us-ascii?Q?LcEvZOPpn+RUpvGY2IyLbGdo9N+DI0icRExlk6VRzRu8PMEom4gPoA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 05:27:19.7277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b334aa3-0d8e-45e4-a8df-08dd68390d0d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8553

> Hi Willie,
> 
> On Thu, 2025-03-20 at 16:46 +0000, Willie Thai wrote:
>> This patch adds a binding for GB200NVL BMC.
>> 
>> The GB200NVL BMC is an Aspeed Ast2600 based BMC for Nvidia Blackwell
>> GB200NVL platform.
>> Reference to Ast2600 SOC [1].
>> Reference to Blackwell GB200NVL Platform [2].
>> 
>> Co-developed-by: Mars Yang <maryang@nvidia.com>
>> Signed-off-by: Mars Yang <maryang@nvidia.com>
>> Link: https://www.aspeedtech.com/server_ast2600/ [1]
>> Link:
>> https://nvdam.widen.net/s/wwnsxrhm2w/blackwell-datasheet-3384703 [2]
>> Signed-off-by: Willie Thai <wthai@nvidia.com>
>> ---
>>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>> b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>> index 01333ac111fb..a3736f134130 100644
>> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>> @@ -98,6 +98,7 @@ properties:
>>                - inventec,starscream-bmc
>>                - inventec,transformer-bmc
>>                - jabil,rbp-bmc
>> +              - nvidia,gb200nvl-bmc
>>                - qcom,dc-scm-v1-bmc
>>                - quanta,s6q-bmc
>>                - ufispace,ncplite-bmc
> 
> Please order this patch first in your series, before the devicetree.
> 
> Andrew

Thanks Andrew for the feedback, will order the patches in v4.
