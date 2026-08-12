Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012055.outbound.protection.outlook.com [40.107.200.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B3B43E06F;
	Wed, 12 Aug 2026 12:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537416; cv=fail; b=FszwHfiaq/f2enlgVS5FGQmITISylqYLoqxgG64ujcemMao+Gx0SDXy3ra033AQAF3LfsDamlW+YcVqBBZsKtUES8nI+bsoxOtaPnSJCbmlNCgJ5b7tyWE/qTqTChAPHaZVXPwvBTYk5lyHRyGv0JCtzS/REhXuyFT3o6Q6fJu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537416; c=relaxed/simple;
	bh=nTQN8tuch2U9VVLCXdtsw+vsid1t9nC17kxDX53G9Yk=;
	h=Content-Type:Date:Message-Id:To:Subject:Cc:From:References:
	 In-Reply-To:MIME-Version; b=iPI+OwSNYk7mzNcaLmlEOgMpJau5Pek2NbSe/gjh9BrWwQbW/WMpEkb3ogH49lgUlKA+H97t8mjtUDsEVzf/dW8qpIvAWbNjrhkvDZBZlSc2SiB/sJOz/qP5tjCrdQLwAKhO2D4qpbSbWYarsF4Q+gjeKQSh7AgLJ12BtabKb5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SzrInda/; arc=fail smtp.client-ip=40.107.200.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SzrInda/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPw6F0mDqUVUdUkjL4oEwHUCwaEr+J14WWnOiWpoVV7+KZQWlg7OC24NCAUkK9eygw1wQc9oGiDGKv7BLLqIjTlgdm7UmT1EA34XXVG7CIE6LkQFn0ZVonHgODFp2xLuxyPuIdf5iusmdph8wxKcQoPrdrKMHBjBF1uGiMOjwbtVTfI25JP5/cSkNqwAg2Cd7wUuD/7ayx+a9Arr/b7ca1DzLHdz9lZG8SSk82F/qhqXrNtMbuhJQP6mV6ZvXm0tNH+mxnBfeu6aqGKDIGo4yqqp1uaNtBftAwL3egpqSc2uOG47GqSCWlEj3M7ciIxItljx4I4lZ3hMqrwZsl9yWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysHMXh+OphuU9nSb5q4wK3oNLoFW1/ieVbk1zEskU8k=;
 b=nt0TPtvdG/NhS/gvjvXM9ugwPO2eW8mVC5RLG7CfjTo4APEqw2VBCYAH/Evk+Ozq/Uyn8YfJBosrZoXvbqNSEbr1N7X7RQUNbfXyAlbklZ5Iet/DFmZf+i6TiAzmrcwf7UHVcdkmZvJTyAlao7i3hfry+3DPhD2Og2AnBIzxmWwALNsXBaGDxryNzW8RuR7tntQWManhlcLw+Aw2Z1Y/U5S69xpQViPgWWuU5E5jLbIFBoqwI29KmQOWUB12cPahZGUkXN/NPuIXdNI4Ys+l/plCRaNq3vgPPCND/Oj2Xe3mW9TzS7oseFzAgRZTh73w52lE08s3Dz/DZDuVfPwRMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysHMXh+OphuU9nSb5q4wK3oNLoFW1/ieVbk1zEskU8k=;
 b=SzrInda/5H6fhL7v2TEF5zyVw4rO4bh5jori6ojKuQgX2aF8aTICAYXdhQ1rGMPg9kZlgyYrI+7VzC1bM+jhUpgGwYzfEp0e3aWjk/HmSgHZMaUMSNSOOUe7TQDxpwwJtrJf8gfng4HmbhoHn+kyUQBErmia2fnFvu5kDsnBtZqqtP7u7HpoLkL199ixxZrgpGz1XUrA60lvM1RwW8I2hl04r63ieIROgggwQ2YewXDS/XPJkaFk403F51AAuoG49oQsF4zWv+ocQy2u4kbom8W0AFxeJJXQB0cFSAMtiqZSPk/9XDSbNmnHNVf849YaF88Ull364R5F0xBDaxEG/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9)
 by CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Wed, 12 Aug
 2026 12:23:24 +0000
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97]) by SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97%3]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 12:23:23 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 20:23:17 +0800
Message-Id: <DKMYNI96TQM8.3OMDZZZA5BGU3@nvidia.com>
To: "Ashok Raj" <ashok.raj@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/3] ACPI: APEI: GHES: Refactor Grace decoder helpers
Cc: <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
 <tony.luck@intel.com>, <bp@alien8.de>, <guohanjun@huawei.com>,
 <mchehab@kernel.org>, <xueshuai@linux.alibaba.com>, <lenb@kernel.org>,
 <kees@kernel.org>, <gustavoars@kernel.org>,
 <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "Kai-Heng Feng" <kaihengf@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20260724122054.36162-1-kaihengf@nvidia.com>
 <20260804122318.88193-1-kaihengf@nvidia.com>
 <20260804122318.88193-2-kaihengf@nvidia.com>
 <anUpAigVklVNG7ij@hu-ashoraj-lv.qualcomm.com>
In-Reply-To: <anUpAigVklVNG7ij@hu-ashoraj-lv.qualcomm.com>
X-ClientProxiedBy: TPYP295CA0041.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::19) To SJ0PR12MB6733.namprd12.prod.outlook.com
 (2603:10b6:a03:477::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6733:EE_|CY8PR12MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: 9941402c-dae9-43d2-956f-08def86c80e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	9kwtuQyOrEx0tjis3m3UvSE2JFwfWX28rhp3o10Zv5/5xDMO/AU6oclTwySjnW+hUKfcfqjA8GffbK8aZxPHQLM55XvFLGn6wlOEQJHtHdSrtfT0EsXM+p5V0/7sA/wjw/EK2jXu46JE4IIQWu5TRHjelWzNplsvCNje7IhAnmLsVlFB/sGbKM6gVh8QmFQrnj6RkL5CtSjVCmGdlPXW5h8leHJdn/vp5g/XoPyB2BxDTUtXHUxUZYb0qPMjROsSIeIACpdaw8g9Vb95HvZVSaeO7S0iBqxnn9RaaabzH+GJKg3GIaC8zFKVCvKGfM+qZ1JMUILHWvQAF5aclSuuc1iwaSeEAPEOfKkokzCXVEMwKbHE101O2wea63ipHrnliF+H2d/ANgGbOK5ZrNfFMPIuYlbRyTahnzEIgApQzmUiTHMMi88eI6Y7422rjGpo92AH/ZqLURThtDivC2okDCLTYvjCfcrRdYB3f9+41JE4VYNTrM9lJlXj02jBkY44MPcbiK6rF2upJ7HuM/Lc31KOdd0a7tckuutz9q+Q7hzWpYuBGjAlALvsEtR+M7iCdYnGbXHWC83p3j6Ir8lqRPjxTjywEud/IR55uzfKkHeaxQBa2PEfTVzKncuVmwY41JEtCv13KkT6jnhHPxtcQTKVg2sw8l0oZmYgLPT3AXs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6733.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QklheU8xR1VWclFkdnlqbnVQYTV3NEdGM3JpQXFDN3BRNUk1QjBnNmZlVWps?=
 =?utf-8?B?d3NHUXp0R0pyS2RHcE9zM2tDOUtDTTJZL1dRd3ZDQ2EwL2tJdkVWVHlhODJJ?=
 =?utf-8?B?SWppUloybTc5bjhmeldiSllhYm9UQTJoU01TYnR4OFJhdzZyRUFWcWl4N09h?=
 =?utf-8?B?NGkxakdpSmxwNExQNk9vcURQV21nRFI5Rmk4dW5TRnJtamFDTFpaKzB0ZjV0?=
 =?utf-8?B?VjI1b2E3RUExMWxUcEc0Y1RqZDNMK2Qzb0NuN2lFQ0NGbUE5cHpINDRvVXlR?=
 =?utf-8?B?K05OSkR1MVEyRWtGNlBZZXd6MVp6VVJ5c3NCVk5TQTU3akk1OE8rdUdrNGtE?=
 =?utf-8?B?eHRDNmI4eUhPNUFNQy9oTnRBNTgzQk5rSWYyNjBnYkhENFdrOW5GdXp3eFkz?=
 =?utf-8?B?U1BhMFdGVksyNTEzUmV3dEJNdWJKaEFyMWxKelpRTTg2d08ySnV0dkhTRTdY?=
 =?utf-8?B?ZXVvUTJ2NWRYb1BpTzZsMXRBQ0Z2anRNSFlKWVBJMnJpa1pVdjhxL3dRc08z?=
 =?utf-8?B?N29hK2k4TVdqYUxNNU1xSzl2M1p3bjBpbThoQlVWenRTbUJHU2g3cjZLTW8x?=
 =?utf-8?B?Vmh3ZDRnQTR1ZEhxOHRTOWRJc3lFTEJaUzJQQkJXKzN5RUp3Z1p0MHpWY0U0?=
 =?utf-8?B?RXAvOXY3bDYwR1FIcHFNRG5pL3pxN0V4YnZJTWFJVllrY2pGby9MN1dFZFVJ?=
 =?utf-8?B?WWo4dW5QSHYzWVpMSFIzSVhmMXVVaUpTeFprZjVyUnlIYmZmQVNBSjJjUkFs?=
 =?utf-8?B?dUp2dXRGMGNFWlUremQ4R0Nld1NMdVZKRjRQVDVYMlcrN24xY3AzcVpQK2Jh?=
 =?utf-8?B?bGJIQUREamJubUNrODFEM0tXWEpRSnNJaUFTaG9PVjYzSk1scHBVSUphZDJL?=
 =?utf-8?B?eW9BZDl0V0pueWt0d2JQRUJzcHdvZmpzYk9NWWExTTl0TkJTcG1ZQVBnVXho?=
 =?utf-8?B?SEZMMExDOENCMitCekFZVFlsT0htNFNyb2VwL0U1SWFzRjIwd3BzRzFXTWp5?=
 =?utf-8?B?bGhXSTNlNEUvWTdhb29IRTlpRUZHZVhZTjBEbTNwUkc4M0tBQkdjNVd0TXUy?=
 =?utf-8?B?RE92cit6ZWtUVmFtVkdBVnhtbjdoUkNXMXJUc044SGZ6d25jY0lwL3hBbUdp?=
 =?utf-8?B?Y3M5SXZreTA0NlV6T1ovRzdxSUszNkduLzNyQTI2NTJaSWE4Ymo4bTlCVk5N?=
 =?utf-8?B?a1JLMlZNRzNTdUVDbHVyMFlNbjFQdGdYbUE4UGwvRFlYaEt2TnVyQUp3TFR4?=
 =?utf-8?B?VkRJVTQxeVR0QlFaaE96ZHRiZThDMGZ5dXhYa1JxQThQU1A5dXhLbko0cVRM?=
 =?utf-8?B?MEo4TXA5dDYxclp5elZwaU11WGRkUUh6QmhVTmFpUGxEZGp0UDRaVjFlZkhh?=
 =?utf-8?B?cmVYOVQ2T2RSR0hteEF2NmZNYVk1MnR3alVkUzFRVVBUUU92bnFTRjJqQ29N?=
 =?utf-8?B?V0xzOUxnQWtscGNYTjFsRkZKS0lSdjhnWERHQzJYcFZ4elBWdDNOZElyR1pD?=
 =?utf-8?B?OVYzakJhWml2YXZYdU53Y0h5bHZsckNteTB4VHRSSzRNaUNNeEdsY2NaUWRt?=
 =?utf-8?B?QXRHQlRPbUxHQnpqelpjYWhQclpSNVRId1hVUXV3MmVHWnQ3Ukd5NDhSYktD?=
 =?utf-8?B?SHJyb25TTDhDUUtnaDd6cmlSRW91ZGxzSnlhREJUQkZUSlYyTURMNTZ2ODli?=
 =?utf-8?B?RGQwODAwR0RNOEF3cU9nQ3RVbFkySFltOUJDYmV1T1I3emVyTWRRSjhmdFlV?=
 =?utf-8?B?S3hjN21aMFNMUElUZCtnWFpQM2haUm5vUUZKemljNEFPRWxKMmJOQy8yYzhq?=
 =?utf-8?B?RGlnbW40SXRyY0pnTWpQU3NQL2dEc0dlZUkyT1lvMmFEbFZOWFAyWE5QM243?=
 =?utf-8?B?OHRWTUs2YzdIancwamNSem1qQlZKMDBsWk04c1BZNm9NNzc2R2VCTFJLSnNS?=
 =?utf-8?B?QXdYR2ZQNnlBR21YeCtHdFZUM1ZhL3NBOVBlWWcwWEpJNzF0dXJJaDZSSDRI?=
 =?utf-8?B?UHkzN2hrYld0RU9jWklGWXc3cEwrTzdJOVJoanJRWjNQVklGSk4yb21VZnJ2?=
 =?utf-8?B?K2pUQTRURXNWUmpTVGgyWDR2cXo1OHJ0V0tSQWswdm8zK3hBelYzUTRqMUo1?=
 =?utf-8?B?ekpsS1MzUFg0MjZQZngvbmUvWGNzVDZWZDlydU56V2ZDNDM4bXd3eTUvVDlu?=
 =?utf-8?B?d2xRRW9hR2JMN1h3aTc1emgxeHhGb0JVUk9MamxFZXhGbmp4VnZHeWF6dWJp?=
 =?utf-8?B?OHRyWjN0ZEJ5M0Rua2trYStJNkpyeE1BSlFqYUZSQ1E0aVRwdEhwOCtONkZl?=
 =?utf-8?B?SCt5OTBFUnJjNjd6ZDNEcDJJVG1razNCUlEvc0l4VlRQckxCbHExQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9941402c-dae9-43d2-956f-08def86c80e8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 12:23:23.7671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8p0TYnBlJ+jmGe9jA22FWkx1QpgxsvCVz8l2nxzGug6gGT1mGhlSsWZb6vNNvIuZYuuaz4kMhmKTV6VcFzxKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7705

On Fri Aug 7, 2026 at 8:38 AM CST, Ashok Raj wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, Aug 04, 2026 at 08:23:15PM +0800, Kai-Heng Feng wrote:
>> Split the Grace CPER processing into a separate decode step and a
>> print step so the parser can be exercised by KUnit without a live
>> ACPI device. Introduce ghes-nvidia.h to hold shared types that the
>> Vera decoder added in the next commit will also reference.
>>
>> Parse the Grace wire payload with __packed structs and
>> get_unaligned_le*() for multi-byte fields, matching the Vera
>> decoder style. Reject nvidia_ghes_grace_reg_pair() calls with a
>> non-zero register count and a NULL grace_regs pointer, and
>> rate-limit Grace decoder diagnostics.
>>
>> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
>
> Hi Kai,
>
>> ---
>> v3:
>>  - Use __packed + get_unaligned_le*() for Grace multi-byte fields,
>>    including register pairs (Shuai Xue).
>>  - Keep __counted_by / struct_size; reject NULL grace_regs when
>>    number_regs !=3D 0; document the helper contract.
>>  - Rate-limit Grace decoder and notify error messages.
>> v2:
>>  - No change.
>> ---
>>  MAINTAINERS                     |   2 +-
>>  drivers/acpi/apei/ghes-nvidia.c | 160 ++++++++++++++++++++++----------
>>  drivers/acpi/apei/ghes-nvidia.h |  50 ++++++++++
>>  3 files changed, 160 insertions(+), 52 deletions(-)
>>  create mode 100644 drivers/acpi/apei/ghes-nvidia.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5114e6db7307..aa9c2ae58ac5 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19348,7 +19348,7 @@ NVIDIA GHES VENDOR CPER RECORD HANDLER
>>  M:   Kai-Heng Feng <kaihengf@nvidia.com>
>>  L:   linux-acpi@vger.kernel.org
>>  S:   Maintained
>> -F:   drivers/acpi/apei/ghes-nvidia.c
>> +F:   drivers/acpi/apei/ghes-nvidia*
>>
>>  NVIDIA VRS RTC DRIVER
>>  M:   Shubhi Garg <shgarg@nvidia.com>
>> diff --git a/drivers/acpi/apei/ghes-nvidia.c b/drivers/acpi/apei/ghes-nv=
idia.c
>> index 597275d81de8..e7cc912344fd 100644
>> --- a/drivers/acpi/apei/ghes-nvidia.c
>> +++ b/drivers/acpi/apei/ghes-nvidia.c
>> @@ -9,13 +9,18 @@
>>  #include <linux/module.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/types.h>
>> +#include <linux/unaligned.h>
>>  #include <linux/uuid.h>
>>  #include <acpi/ghes.h>
>
> One naive question, do these CPER decoding for vendor specific pieces
> belong in the kernel? Or you would manage them from user space?

I think so, since pcie-hisi-controller is already doing that. And I
think helpers like devm_ghes_register_vendor_record_notifier() is
designed for this kind of work.

Kai-Heng

>
>
>>
>> -static const guid_t nvidia_sec_guid =3D
>> +#include <kunit/visibility.h>
>> +#include "ghes-nvidia.h"
>> +
>> +static const guid_t nvidia_grace_sec_guid =3D
>>       GUID_INIT(0x6d5244f2, 0x2712, 0x11ec,
>>                 0xbe, 0xa7, 0xcb, 0x3f, 0xdb, 0x95, 0xc7, 0x86);
>>
>> +/* Grace CPER section wire layout (header without flexible register arr=
ay). */
>>  struct cper_sec_nvidia {
>>       char    signature[16];
>>       __le16  error_type;
>> @@ -25,84 +30,137 @@ struct cper_sec_nvidia {
>>       u8      number_regs;
>>       u8      reserved;
>>       __le64  instance_base;
>> -     struct {
>> -             __le64  addr;
>> -             __le64  val;
>> -     } regs[] __counted_by(number_regs);
>> -};
>> +     struct nvidia_ghes_grace_reg regs[] __counted_by(number_regs);
>> +} __packed;
>> +
>
> [snip]
>
> Cheers,
> Ashok


