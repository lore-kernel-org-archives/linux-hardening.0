Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012000.outbound.protection.outlook.com [40.107.200.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E152E7378;
	Thu,  1 Oct 2026 06:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790835244; cv=fail; b=E4jokZXmVbarySeFPHdT2IA8/LQknMJwIWFhXpz+kqhUZ3DHAxNMS97PGTAtpZU6pusAU90T4dJi56B22da8p4uWIj/zX3mtY4r08OPp/iqvjWJFWtMGPikCdV1DsbRCqc28+bVwqO1YxMrR3yL+WBg0A0uaO7FT94U7FfYzoq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790835244; c=relaxed/simple;
	bh=FwCq25PbQQXjnRpHOiGJxIcyzqLAC58CBGaAFAz4+rI=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To:MIME-Version; b=Gv9iOt2fhTg7ceOk7MIZ7M9AiXnvzHVPxGLfhmlLeX6REV3vTZJidu7PPQOleHOuRWVeHW0M/Al/zpN6aFj1DAsNMkFWrAfYDHkukjmY8qSl1L7rjC3TOpHdU0NvuHTNmo7gM77XgqwXEInHLvK0UCcosVrE3t2IYXfxgOjYUu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tvE0yXkP; arc=fail smtp.client-ip=40.107.200.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tvE0yXkP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvgsUHRulLqK9osnkirGNwGOFyjH9r8zFkhZ701KhOyn3cRDbPFVAEJU/hO7owYbWy0wwyeVOOJTHHV5ePAZbNF7V3XhrBOczH7nXtetVJp3jSKpECQPqRyWqcvfK4K0GGAe7MesYZLOtaf1g895CiJMAEmp3p/RyOZyxhnNycNuZVBvrkgNGdTEZcpfFqk2LTyGvji1K5RhZM/Onqojp4QJTJYJgD4j4R6Tc164MhHwBBYE610slsw5E2Tj/pWbtMlVBtx26tAaNc/JZetSFhIPWF4JiJvoSd2BrHEItN5RRfFGSaJ3dvPpLWXJMLT4HtbkLbAE61C3wWxUuTL0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fmZ+60cZ0vzwZtSJFzIuASHU5ixn5a5APInx/xrgbM=;
 b=iyi3O11Qmm4bve8HCmg80lZ3jR7PNy/aF+AWbuHZw75RPx+RXmmpCoraxzJDpcNCKqslsBY//DXMVvUDc2/yO/DaKBdDNu9p7rt4+49pfUPaWxJWUTEseo/edKHISwDLqp9jzlMCN7u9WsdOlYkl1/zQgYsBlClNqbBTYLbNNncF+cEd/KIaIVdASdHypno4TP5u2JomCxDo3/oHW7tc2p3ocNK+m0OchNAXu9edF40rIsQQWfJa9yTs02V8jA+ZcApdnkes0PtvF66c59U8pQhMQfATFvsCJUSueGchH/ECmndDQHaoveMdBMh2a9DpgxJj57Bn+3m2Ujf4+zsvgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fmZ+60cZ0vzwZtSJFzIuASHU5ixn5a5APInx/xrgbM=;
 b=tvE0yXkPZGx+YtR0WKSVi1F2BSwXr2sk3lcQKANPPvXFusXeszQh9iQRUt2IPAt4AU6vHyzeS2yWfaNNzrzGeBkT42Cjg5rKHTbCMfWLPil5EAXrujNNgflcat7scrEnWsUJ2HTAHWzpjwSeWUSkiBKFzKrDTdeAn9ZOGqN0w7eUtwfwaULQwgFcEci9BQQvbramXb0We+fJaCMKBYCObhi/Y8KErXY+Mf35BAPUTCbGVha+UnU2RH1YAH6hLpG5a9Ct7tomTkJhOvQ05i6W9L/MLWsguDG40WRG+/sSwEAoq54wrsRLuEioR3/gk4pjPOAIgKRzc6u3bHqg1WLFXA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHAPR12MB999224.namprd12.prod.outlook.com
 (2603:10b6:610:302::6) by DM4PR12MB5724.namprd12.prod.outlook.com
 (2603:10b6:8:5f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 06:13:57 +0000
Received: from CHAPR12MB999224.namprd12.prod.outlook.com
 ([fe80::e6c2:bda3:91c7:9d17]) by CHAPR12MB999224.namprd12.prod.outlook.com
 ([fe80::e6c2:bda3:91c7:9d17%3]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 06:13:57 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Oct 2026 14:13:49 +0800
Message-Id: <DLTA3UZV3REO.38GIFKJFC8B58@nvidia.com>
Cc: <tony.luck@intel.com>, <bp@alien8.de>, <guohanjun@huawei.com>,
 <mchehab@kernel.org>, <xueshuai@linux.alibaba.com>, <lenb@kernel.org>,
 <kees@kernel.org>, <gustavoars@kernel.org>,
 <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Kai-Heng Feng" <kaihengf@nvidia.com>, <ashok.raj@oss.qualcomm.com>
From: "Kai-Heng Feng" <kaihengf@nvidia.com>
To: <rafael@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] ACPI: APEI: GHES: Add NVIDIA Vera CPER decoding
X-Mailer: aerc 0.22.0
References: <20260724122054.36162-1-kaihengf@nvidia.com>
 <20260804122318.88193-1-kaihengf@nvidia.com>
In-Reply-To: <20260804122318.88193-1-kaihengf@nvidia.com>
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To CHAPR12MB999224.namprd12.prod.outlook.com
 (2603:10b6:610:302::6)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHAPR12MB999224:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: ab01d7d0-ccb6-4836-2e80-08df1f832d9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|4143699003|10067099003|11063799006|5023799004|6133799003|3023799007|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rYaMsSwie2knk5mr6pmIL/0YeHQphOfsgn3oo0EYpqVzqs2lkcvQ7gR2YSWEqJU+uIwUtAUbc6f6Z4xEripQatKo78+J38/ER8Ql9U7Iv8TB/+4CS4DxWCoanfy9KmzCtwrCgL9rUkcs56OM8YwjdCun/s4qeUFo/8+xRqXplUBVWl6VoqxTzTBJDL+Sa/H+MvX1RzzyaW9QuTVnDqUfJpGwS2sqO3bFV7YP4qGYi8L2bgTiWwnBvnDMk6hwu5aZqt4ACIdrITyf23vDGHZ8US5bWS+1qOAAzy2dtNRud70071jDxR0OmYODL1Tmsg4d4F7hLiVWa8tQpQN9m9h+OutZDS4qgZl/AL1/75jF5cLMos76IeHcbqB/4pEogFIQEluOGRCmLIc7Bs4LFvheq3fT7rGZRHw0cwK52O8vHbbx7pYcJJKSWXkgNqtJRvUwSdoCp51KDkX/0kq/dV29FdEgJuB/qaaprCep+2zlSd/QjoKrfGI5EPbc+l9Mn+NpFBTBovVyo/T7Y5or+bPNSjd5PwVPLfyjzxUAJp1ZFUIGMtdD1nQqsNmrBbUvwFU1/sQwRtwZdE7T2+QppCPdDJeV52lhCxNk4/5oxgpumF+F2AE+ffI43Sc9j1yaWV7gatMKxyhE1LtS91ybKlY3ioIS3lnBLRNskpuBl2ytjAI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHAPR12MB999224.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(4143699003)(10067099003)(11063799006)(5023799004)(6133799003)(3023799007)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUJwbVdGQ0xRZUpROTYxQm5zVllac1JOSk0yNXhrZzFUSzl1RGdDZzUwWnhS?=
 =?utf-8?B?V0tPbGVIeWxNb1lFcmlnd0NNRmpzRFF4MGM2ZjFWenBQeml4WGt3TEcyL2Za?=
 =?utf-8?B?TERQemNzb0hhMlNjWFVVVVRtNExwUXRPM21QVlVscDIwQU04QjByU21Xb3Q3?=
 =?utf-8?B?NU1mT0xFMjRJb0QycXNuTUlsRW9qWTFqcEZpYzRJR0YxQXRjd1BlUDl5b3NB?=
 =?utf-8?B?RnBLYTdYYXlsMWNPZzh4Y1lJaUFPY0pyVyttS1NsS1BtbnpPRTBtdnpiN1RN?=
 =?utf-8?B?enpncFNNTEJpTmNNZkdQT2xZVStNSk1TZlB5cVhyNFM3NjgwcWNFVzdvcUxV?=
 =?utf-8?B?WmdYcG1CaEdWTDJweDFtSTNuQUdRRkhkM0N3VnJKcE4zMGFYZTlvQk11VWky?=
 =?utf-8?B?ZCtucUJubm0yeGxiUTFDT3k4WXY2Y1NLUlUxRzVNZHA2OS8ySmNUMzdRMDZU?=
 =?utf-8?B?aDRrZzlJcDdHYWNoeEt5SzljcHA5K0dJMVpmQlRSak0vYUdhUUhjN1dEdU15?=
 =?utf-8?B?OExqNS92K2F3QnZmTm53ZHpvRlB5N2FmQ2VvT3RDMC9ZK2tTcHZZY2MzbW84?=
 =?utf-8?B?aUcwd1VnUDhWZElGdi9ncERmbGlySzA5SS9aSnpNd2Y1VkUycHFJcE9lWEkv?=
 =?utf-8?B?NCthZzFYWmZ3bmJvNXd0SlNIN0xyb2N5NE9QTjNENEYyd2FBMmJLYUZlWklN?=
 =?utf-8?B?RWEvR0twNktpMUV5MEx1R0V1cnh6aS9zRGhCSEVCUzBCNkFNUWJ4Q0I5c05t?=
 =?utf-8?B?S1hSK3ErSCtCOURjMDQ1bnBpbldOM3pSa01relFuODFuS1lxelFhdzc0blcy?=
 =?utf-8?B?U21GaHp4blFnNGpnZXhsbDQ5UTViUkJOV1pZNVFOUEhKMzVVcUhxdGJrY3RC?=
 =?utf-8?B?SC96UmRSeHJoQ0VpZC9hUEl0azV5a0MxOVE2L2VoQytlTFJIa3lYYmFnTEdB?=
 =?utf-8?B?NHFET1h5cEJuZmdKL0ZYclY1ZEt3N1ZwUGR3RG1xZGxTRjJ4aXh0Wi9sWTNw?=
 =?utf-8?B?RmhjRnpkUldPdmEwVmU1TXprWUlYNjlmeXFQcXNqdUtSaUVhSFQ1QXFXdlJI?=
 =?utf-8?B?ZEdST1M4SFdZeUVveVFrVkZVcU51bTlPYWJmc3h2YndHendjakxFVUdmQWJ2?=
 =?utf-8?B?ZWx5S1crZ0NrVXllUFc2S1NtakFQMWhOS0gyZzlnYUxFMmVJZ0Y5SE41b25P?=
 =?utf-8?B?UUdZR1Q1ak1yQjV3dk1YU3NZdFdOZ3Q2U3VuQ3Y1OGRGdlBjSFRQcUgwUWdS?=
 =?utf-8?B?ZDdPY1VPaGx4ZVdMNXN3UlJXcnllR0w4SklTcjRiUkd5UXc5OUJYMmZqSW5D?=
 =?utf-8?B?Yit2bE52VGY2L1ArbElTTlBzOGV0bjBldHdJNlp2VElYMGxnOVRUVGt1OUNk?=
 =?utf-8?B?dXI4aVYrRFdKaWZ1cVZ1TDJrM2gxVDdJZ09LV0hIYUtKY3ZRdWR3Qm5WRXdG?=
 =?utf-8?B?L2xlUlBidHRGcnVOQ3VjZ253Wjg4QndMYjg4TVpseVV6Q1FOanROcGpkSFp6?=
 =?utf-8?B?L2o2Rlpnb3hFb1lwc3JFSXRaa2drdU5rUjhHM1FTdkZadW5RTkNxYmVzaWhw?=
 =?utf-8?B?ejZQb1E2bC91VFZtRDFQT3ZnMGNlVFNyMmlzWE9jZTlkakFvYkhwbVFTc1F6?=
 =?utf-8?B?MTFmOHBuQng0OXJHYlRLMGZob3lHVEtJaUx5ekZ3dG9aYVRxaDdLY1pXMjNO?=
 =?utf-8?B?TGJmNzFXbnQvR0svUVJabVR2UEpKQ2tRUjhZN2o0UUFuOURFQzFSTEJUL3BH?=
 =?utf-8?B?aG5QenI2V0VIdndzcXc0VE8wa2d0N0JmVEJNSkhFZnRTT0hkWndSWjJuOU16?=
 =?utf-8?B?NjZER3JlUWtsemRwdC9RamlDbVMxZzNVandYZWNQQmFYVlcwenBWZVpNN1ZI?=
 =?utf-8?B?S005MU5JMm1YaFhiWVBzYW54SWJnQnU1eFlMMm1EVG9adjJWcEVUbENlZ2lj?=
 =?utf-8?B?cU1KbVN3OU9mV1g0RFlpbDlIcmhzNUYzd0VGMHZ5ancwNlpGNmF4ZWRCQzIv?=
 =?utf-8?B?SWVhV3dyU0tsa2M1M1FjYjRvQzkycWpiV1FVRzlaNHltRmFUL3cwMmtINFE5?=
 =?utf-8?B?TlkwdFlBb1Q2UFZTMHdGYVM1M2cvcVNyaDlvUHdqeEM0YXpnazdtNEdFVE91?=
 =?utf-8?B?Y3JkS1I0VjE5L2FVTWVObVY2N1d5Zy9UeXlsSGNJdHozQ3IzbG03dk1BNGxW?=
 =?utf-8?B?bTdwaldpeDFHTUQwZ1JHbGI0cWNhYjhCZnV2SkgrMzdyam1nWnp2LzhmY0V2?=
 =?utf-8?B?ZXByaEdnYW10WGR5dHFQdHI5ZHdvQWVUSnFjdWxnd1R5bEk5aGY4YzJkbHMw?=
 =?utf-8?B?Wm1lUUpTVWM3V1RPaFZzaERwZnU2dlVPWlhQeFY0RUpiK0JmZWltUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab01d7d0-ccb6-4836-2e80-08df1f832d9d
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999224.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 06:13:57.7465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDadKqIdCNFDKLv/B37mmmBb2xH0GY6RxhsXVCdVVNFDX0yYeZMHmtL7Diwb2MQ3iR+xhFd4tRWQgXrCpnsl8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724

On Tue Aug 4, 2026 at 8:23 PM CST, Kai-Heng Feng wrote:
> The NVIDIA GHES driver currently decodes the vendor CPER section used by
> Grace systems. Vera uses a different section GUID and event layout.
>
> Refactor the Grace path into testable decode and print helpers, add the V=
era
> event decoder, and cover both formats with KUnit. The Vera parser follows
> the extensible CPU information and event-context wire contracts: it accep=
ts
> new minor versions and extended information headers, validates every one =
of
> the wire format's 0 to 255 contexts without allocation, and retains a val=
id
> prefix when a later context is malformed.
>
> Printing walks the validated raw context span a second time. It limits
> verbose output to 16 contexts and 32 key/value entries per section while
> still validating the complete record. Existing one-context output remains
> unchanged.
>
> The companion ras-tools series adds a fail-closed NVIDIA EINJ validator f=
or
> the non-fatal Grace CMET-INFO and Vera CMET-NULL samples.
>
> Changes since v2:
>  - Move EINJ tooling out of the kernel series and into ras-tools.
>  - Follow the Vera CtxSize padding and alignment contract while retaining
>    the legacy opaque-context encoding.
>  - Accept compatible CPU information extensions and validate the complete
>    8-bit context count with an allocation-free cursor.
>  - Bound verbose context and entry output independently, while reporting
>    omitted contexts and entries.
>  - Add wire-layout assertions, partial-context handling, severity-aware
>    diagnostics, and 52 Grace/Vera KUnit cases.
>
> Verification:
>  - x86_64 KUnit: 52/52 passed.
>  - ARM64 KASAN+UBSAN KUnit under QEMU/HVF: 52/52 passed.
>  - ARM64 GCC and Clang, built-in and module configurations, W=3D1: passed=
.
>  - ARM64 GCC full Image link: passed.
>  - ARM64 sparse C=3D2 with __CHECK_ENDIAN__: passed (one unrelated existi=
ng
>    arm64 vDSO declaration warning).
>  - Strict source checkpatch and git diff --check: passed.
>  - The raw live sections were decoded independently by libcper at commit
>    b83878a4aca9: Vera as an 80-byte CPU CMET-NULL event with one empty
>    type-1 context, and Grace as a 544-byte CMET-INFO section with 32
>    registers.
>  - Vera live EINJ: a real 80-byte CMET-NULL CPER from GHES source 8193,
>    event type/subtype 0, one 16-byte context, and zero entries (not the
>    firmware-rejection record seen with the old selector).
>  - Grace live EINJ: a real 544-byte CMET-INFO CPER from GHES source 896,
>    severity 3, with all 32 register addresses decoded in order.
>  - Both live runs reached the runner's PASS gate with empty tool stderr,
>    captured the raw tracepoint record, and restored every EINJ control
>    byte-for-byte.
>
> Kai-Heng Feng (3):
>   ACPI: APEI: GHES: Refactor Grace decoder helpers
>   ACPI: APEI: GHES: Add NVIDIA Vera decoder
>   ACPI: APEI: GHES: Add Grace and Vera KUnit coverage

A gentle ping on this series...

Thanks,
Kai-Heng

>
>  MAINTAINERS                                   |    2 +-
>  drivers/acpi/apei/Kconfig                     |   24 +-
>  drivers/acpi/apei/Makefile                    |    1 +
>  drivers/acpi/apei/ghes-nvidia-test-fixtures.h |  233 +++
>  drivers/acpi/apei/ghes-nvidia-test.c          | 1274 +++++++++++++++++
>  drivers/acpi/apei/ghes-nvidia.c               |  767 +++++++++-
>  drivers/acpi/apei/ghes-nvidia.h               |  109 ++
>  7 files changed, 2364 insertions(+), 46 deletions(-)
>  create mode 100644 drivers/acpi/apei/ghes-nvidia-test-fixtures.h
>  create mode 100644 drivers/acpi/apei/ghes-nvidia-test.c
>  create mode 100644 drivers/acpi/apei/ghes-nvidia.h
>
>
> base-commit: 848acc8ffe1b7cd5f1bf427b93069becfebc2c9d


