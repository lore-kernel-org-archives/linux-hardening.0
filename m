Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D19742A94;
	Mon, 31 Mar 2025 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743441552; cv=fail; b=OogD+jdI5kIPvZ8zVxyF8ZudideZcJso9n1goSSi/iHN29oqzVSwERqg2AqBkGtWZYXhlMOixu6bUb0ajOkE/RDo6d+J5QEllbvVmQcly09nbbpasxAvPEmVl7DSA+CEd/nMBNQm0PIcqVuhqZBW9xEP5i+N/yp8S2YiamO+iCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743441552; c=relaxed/simple;
	bh=r7rkbX612GBzOEwOQbcn/lT8ErrywXOvOCqpXutnMHg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=huuHSMtgbObUUUa0G8vQftr94wwWWr69qzicjHwkRNKS3NdsfSBxzJ40EyZSx8kGosuRVOqffBgVcrHhj3cGnNiXTQqSsm09POmosRaZANyJ9ZTPp9RY5l4GahdWKvvMJKedVaUd40aGT/qI8SO5E/nlwjdmQ7qjPRRACZHDfRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RIw6FQJn; arc=fail smtp.client-ip=40.107.95.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RIw6FQJn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oC6rujEphLfkWjWp5stVloInzCPDtNthiqkRbI0FjWSb9xX1iW5hZGT62gtzBv1INfFYfZHk4LyzmxxyUlG/ldHOPFSUwIhzCQ9a6EcPS1wDFecoY/g3rVorp6VDKKgBD8d+qEnkpslZYJP8xckf5EZ0DwfR5m+usU2xcb3GxmGqSvVKm1JVpI1DrqgWvp2s4w5lErQxZaMEAO2i9SYDRoKND5+bo9htanW/ux1dn8GmIXIl+6RQcxnGeeTIgKN01aLqNez8Fs3/7s36SuhL0kp7yZQC+V+25elx3qWqL2rJ9qne9lvO2BGRkn5TnLm0AU3jHtt+Qx6y6pLJyVteBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msdUo3wzjzr8XFwzKi5515/1w+Y5mSvWR+VVIcgmn0c=;
 b=s4G5KRdUh2LGGhO131M9xhln4H5FFnFQrzRtDbxkM1JVFf8nA5S8Mb28J4f3Phw9TK1BkysGcbiu2ZfdonyESX2ktPRA/LhMRl7KNFXtF65YmSsjz5n/nh3YMI3D/+Sq4yUbmXt+MSypPxmY93p5HFg1Id3cGlbvLhnwhugmYJ5ZXPU9A+Vl58uiByNtZbrenO4tzN3FaJxBZWktfR7e43JiIHsBd0E2YhbzgE0EM2MofXvPa4pd7v8vJWmGgxJJSHhjlOmeU+eXCsYM2zSE5zFpMV/wMw8aelQqTZ9lFoPO0Uqu+0Av0GmT1mYy/idetJyQBnrEQ8vnEPA/tcRNzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msdUo3wzjzr8XFwzKi5515/1w+Y5mSvWR+VVIcgmn0c=;
 b=RIw6FQJn1u2Fs7E1lIvDYyFu9xwVDJE0/gYyQr2uc+9sbph0yfUH7ygsnDPVx4sW82lKsZWFXRtCjN0Z/CWOwn25qJm44iJM6ncIXRAPCuz9Llbwq+UjTOQiUAOzV/oZ62p2TFMxKbXaVuMiX96yzuTmpjcshd/AQNf+72wRTqG0tux2daL1JYfSnO0VyC5j7cKErYbpVzesaaiwKX5SbD9PfSx76ig/kraceH08Pw9Fz4l9s2Y/rH7xRjYEB0EhKsPouEVjSG/C21PGm/XXAdie6YRmj1u/WWaF2apyoZCjdMByhJapr1pFc+RuXwHlrUoVZy6ZHJahXXjzm/7FIQ==
Received: from CH0PR13CA0046.namprd13.prod.outlook.com (2603:10b6:610:b2::21)
 by SJ2PR12MB8036.namprd12.prod.outlook.com (2603:10b6:a03:4c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.52; Mon, 31 Mar
 2025 17:19:07 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::81) by CH0PR13CA0046.outlook.office365.com
 (2603:10b6:610:b2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.26 via Frontend Transport; Mon,
 31 Mar 2025 17:19:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Mon, 31 Mar 2025 17:19:05 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 31 Mar
 2025 10:18:58 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 31 Mar
 2025 10:18:58 -0700
Received: from willie-obmc-builder.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 31 Mar 2025 10:18:57 -0700
From: Willie Thai <wthai@nvidia.com>
To: <andrew@codeconstruct.com.au>
CC: <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<dkodihalli@nvidia.com>, <gpiccoli@igalia.com>, <joel@jms.id.au>,
	<kees@kernel.org>, <krzk+dt@kernel.org>, <leohu@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>, <robh@kernel.org>, <tingkaic@nvidia.com>,
	<tony.luck@intel.com>, <wthai@nvidia.com>, <harrys@nvidia.com>
Subject: Re: Re: [PATCH v4 2/3] dt-bindings: pinctrl: aspeed,ast2600-pinctrl
Date: Mon, 31 Mar 2025 17:18:57 +0000
Message-ID: <20250331171857.262649-1-wthai@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <d0f7003c22e19c8fc7617610043edc7be925a180.camel@codeconstruct.com.au>
References: <d0f7003c22e19c8fc7617610043edc7be925a180.camel@codeconstruct.com.au>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|SJ2PR12MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: d2824fea-25dd-4a5b-ca71-08dd707823e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?69GcHvvXw0bhH6IMfhhzrtqSF/fk50FFXR9doWMGF9yDG3qnM5uK742E5GUQ?=
 =?us-ascii?Q?ZGV65vcOBU/gXLEb3OAdNrBj6QF1zPmiCE5Uok9Q/2UB8OKZyH+10qqaJxNd?=
 =?us-ascii?Q?jMKSlnk/qEipOh/Nw7Edfi8AeBnyz4bFtqqYDeTA49oJAH79X/ZF9XELIkte?=
 =?us-ascii?Q?pHFllSv10b/f3S1xfQ23MDji7z6vjRL3HLey++q4m6bY5dbYM0SpesRvG6vD?=
 =?us-ascii?Q?StD0jvRO/pmtVDphF+rqiy/ISuIoE0e2ylKiyUs+sa7HnHg4saDYOm+OD38Z?=
 =?us-ascii?Q?jidakGUmUer96BXEwzjam/KV38gW3Jep8dFcZiv3toq1HXv9zYCB8AMiovXa?=
 =?us-ascii?Q?3rsn8qTM5CArjBFE7nzPvixIrCrOOz1Vr+1+9j16WuTfh6lpAxzbUc46Fkuj?=
 =?us-ascii?Q?6EQiiiF4YlYV0KkbDczmw+NKmvVWRwtJHqB4QGf0bEchqe+c1D2waLPvErm+?=
 =?us-ascii?Q?A+WIh+96RvjqdebJEWehzxaj6KTqC5nAGqBK02mbTdYuttEM9MgloPt4U4uf?=
 =?us-ascii?Q?8UXtVjabFigpg4pFv1nmBQC3kTPq7Uw+Jey8lLHTht93XTiTzUidw559KYNV?=
 =?us-ascii?Q?VXnzMjZCMpCWS5q5Z5iGBsfPSsK3sC0K4OmVYqkKjuYVDvjcEWfPDlpgWoGv?=
 =?us-ascii?Q?l69xQI7C6fDpCkiza0xixJxVpDfL62RA1Hlf+KFBIZJELMwmQi7Kzeh8pA+d?=
 =?us-ascii?Q?0WFaRjsjiEsJl4drbLgvbVffhrmq+7f3WYbruZrjskkC6Xan3ShO9lJIdpCm?=
 =?us-ascii?Q?Y4hEVaVtf73dQM6Ibbpo3lf+SoBCEZhrmT0sZKJ8B6ydMhqgx1GN9xt1bHAA?=
 =?us-ascii?Q?QasiZ3D+zXYcUolc5p7LSlgiZxq/Ko+jzQGGhbnhkZ8OReAJ7ytfEwnMXLdS?=
 =?us-ascii?Q?iTPI1aCXZ7sSRf0kF4KTjmOELok9LWI8yGqxlqhU0/O/EFV+iEPfLNuBGX72?=
 =?us-ascii?Q?jC5p29lEJf1vdl7F4qsurwdWMw0kZMFP8IfhayQiJjtcHZdiyan9/JgGWkGh?=
 =?us-ascii?Q?iOc/8/0gKKnOhmbve75c+cxPm4HZsF0ZFvLJfkBDqJDPRUXaxXuAfU5bomZG?=
 =?us-ascii?Q?gIs34tkS+EUhGmPGIJbCODf0RR6Rm9WSp7J/F+P2ZExQH3uCIaC+l4rV2ccc?=
 =?us-ascii?Q?V7QGjGQ/Ypnn+A2H4TQl9/t5sneLY8VGk31E5B3O9Jvo+SuFBUXOcJIATeDA?=
 =?us-ascii?Q?xzbivS58fCAfShaF/9KoBfr42+SrHFaDWNZfZrP1jda7ApTWVaUFsHhFdr30?=
 =?us-ascii?Q?qTZSb3xX/SQSvIKLVLcoXvsqfHt99Y+qqsSTs9LmZQuZLrtFQ8gyz7H9vHED?=
 =?us-ascii?Q?zOWf7POx9rQO6a2gxINUCPuKg+RH38jpDYrcvkuQQEuD0H2ratzD2txSeEJK?=
 =?us-ascii?Q?1JzCHdyV8SENYPSXXaOtr4PwlbLzC8/iINhJaqwxp+5qlNA9P5waSREUwxnN?=
 =?us-ascii?Q?pt1NEeezXfwmQddel4G2d1fTPskRj0ONhoWdq8ppgot1YQAXjEFYdMUK0gS7?=
 =?us-ascii?Q?RTTfetdPMPAMe//iab58wFdywqgwQUI5aGOB?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 17:19:05.5226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2824fea-25dd-4a5b-ca71-08dd707823e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8036

>> Add EMMCG5 enum to compatible list of pinctrl binding for emmc
>> enabling.
>> 
>> Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
>> Signed-off-by: Willie Thai <wthai@nvidia.com>
>> ---
>>  .../devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml      | 1
>> +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git
>> a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-
>> pinctrl.yaml
>> b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-
>> pinctrl.yaml
>> index 80974c46f3ef..cb75e979f5e0 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-
>> pinctrl.yaml
>> +++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-
>> pinctrl.yaml
>> @@ -276,6 +276,7 @@ additionalProperties:
>>          - BMCINT
>>          - EMMCG1
>>          - EMMCG4
>> +        - EMMCG5
> 
> What pin configuration does this correspond to for the eMMC controller?
> These groups aren't arbitrary, they correspond to the 1, 4 and 8-bit
> bus modes.
> 
> You may have added this squash a warning, but I suspect the pinctrl
> configuration in your devicetree is incorrect.
> 
> Andrew
> 

Thanks for your feedback !
We want to exclude AC5 pin in the default EMMCG4 pin group, because that pin is used for other purpose.
We define a new group called EMMCG5 as:
GROUP_DECL(EMMCG5, AB4, AA4, AC4, AA5, Y5, AB5, AB6)
The bus mode is still 4-bit mode.
Could you please advise if we can use the name "EMMCG5" ?

>>          - EMMCG8
>>          - ESPI
