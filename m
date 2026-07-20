Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011022.outbound.protection.outlook.com [40.93.194.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72B93AA9E8;
	Mon, 20 Jul 2026 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784536666; cv=fail; b=EoZeJpdliZ7NKp8G4IDU+WiWuJQqLASwTLxYv+weZjnnh2tF28RaOkNMolzM5lKE4XSHUhEk8AuxNNkeRsppQJx8coIyKDJnW1GG6LsBmU7JXn2OPK35dKDxAgYrgg04LkBLNZdUIPYEJhUwRioqAlYcSDyF/yDRPFWCqb261a4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784536666; c=relaxed/simple;
	bh=bZqg8FMqhr40XRppDNgYCWfOv8BobMXeCHu1Shlg6Do=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To:MIME-Version; b=CbpGWdN2io/QSqGR9St4lD1o5vwaEFyBd5s+oVO+styF0bWeSZaOv0lkfbxlzNgtFbneyPTigwxttFvSwvgk7UuP4NlDPvrkepOOO9DDDekI5Ee8NDdAiDO8hCTCYR0ykBNUlyb3/5kCeBOoLjNcIsu0OkYEZuLqd1XxyGzKvOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cLAJmWFT; arc=fail smtp.client-ip=40.93.194.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cLAJmWFT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQsrrFD7/w3ypd8ssuTDdkPQd+PrBO+W17zA6kCmM0e/pgYkQZhBgZbVCFgOQSOhce85vpC2mBgc2by8K7QkihYLevT45LKPhmfdDpaiMuglbFMoK4NfI8RduAsula4a/0g5L0DRhqCLo3PihnIP5h2vpJexrj/+V2AH98+cTes1HyPeVuropF5Ishrry//Sr07xuahD9Dv6EPi1LxNuoXK7Iix/nFNDeufNqpdohgHJVKm4eZTIM9mXTig83jzuZjGbbEpn9oCEAa86SFLl8UOSEUvBGxvDe19/yLRvrE4SRMF5CT8zshjGbRa0Z/f0icLkCmB/FXqyJkIQiQ5AdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U46pCZ8UOVLWuLs55DaVuewZ+TqoYFClV83E3H/6Bd4=;
 b=RSMhPFVxOuDtIiZROZRwsNjVcF9p3XVo/h4Y/P4TZFhuu7Oro2iBVNCYYFs17f9gy+D7qNWXl3shocaOjr9GiAjl6wt6gHek7kxIjWQf8cpYDSI2PdBg5iQrQeIVivu2M1VxhmFx21J4mi9cLbAJNtwYxjCoxFkgsU3h+QwRv/HZYMOe33W7XGlTjA3Xt2geG68mJyUrx1VGggKDugOc4XW6f+U6eABN4+FK0+hmlylbONFx9BAmapn2KKSwwu8Or/AcvD2h32ywLZeCAhhVG80NptzaFIMt6UybwidTbrY5DU9NCmXQRJv75GSIOZbHs7if1mRUkEd9MFAE7zjQaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U46pCZ8UOVLWuLs55DaVuewZ+TqoYFClV83E3H/6Bd4=;
 b=cLAJmWFTGxmp38Dw6uLFPqaOKpn8Kquvlq4/lCucD4t/S0lpo75eIhcFnHx9w8hdZfVIpvzUqLFxzRK7tPOd+P8AhSFkcpxS4ckXAYZ64LakAwH+MiYtaPDv5rLLkm1pRnKuSYtjLdzdaKD+lg1W+mUIqtqhADH28LLFyPtktpZSBOOo2lokY8SkKuJRo/p83HCkEYN3wd2dKGA6tsjNLkp8kPR7j4aMXSLbpDpI2R1S0DKnoGX/+ogFvpshdJsKw0jl/qSiZxgby4blYp09d1/86veesqDdBGoPUSMsMTVdxqjSdWGLzwdiqcS2XaLltbapmiFfGGEX1/nw+A1+kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9)
 by LV1PR12MB999281.namprd12.prod.outlook.com (2603:10b6:408:3bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 08:37:42 +0000
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97]) by SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97%6]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 08:37:42 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jul 2026 16:37:37 +0800
Message-Id: <DK39G70DVR3S.UUEE4333DB9W@nvidia.com>
Subject: Re: [PATCH v2 0/4] ACPI: APEI: GHES: Add NVIDIA Vera CPER decoder
 and tests
Cc: <julianbraha@gmail.com>, <linux-kernel@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-hardening@vger.kernel.org>, <csoto@nvidia.com>, <mochs@nvidia.com>,
 "Kai-Heng Feng" <kaihengf@nvidia.com>
From: "Kai-Heng Feng" <kaihengf@nvidia.com>
To: <rafael@kernel.org>, <shuah@kernel.org>, <kees@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260616034410.70675-1-kaihengf@nvidia.com>
In-Reply-To: <20260616034410.70675-1-kaihengf@nvidia.com>
X-ClientProxiedBy: TP0P295CA0060.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::15) To SJ0PR12MB6733.namprd12.prod.outlook.com
 (2603:10b6:a03:477::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6733:EE_|LV1PR12MB999281:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb835a5-116d-42a8-0a6d-08dee63a29f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|11063799006|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	gPaUmaVC6rb+Lxo1i6N4nOgy41EEFvNx6Q/NCcM4f8EnlXjekhzLAc/7EnORXyEZnGzVUwMLwetkFiFFZzrHyB67arHE0yAFWSudVot2nxN2asYvk/uNRF5pSvr26bQ0lmw7TSlRpEp9xAq8N3oQUZ8d6wtUJr1drvyOjCOkEeOaxNx3ghkW1vk8QyJsVtzLPCsuOJKCdJjdMjbQjH5L6fn55RRTYGm4bT3cJNPBZUWi17zOh6elweEYjO29N4RhRghsjwSoCZJQSkR1/LdtnOwbD44MfY/ZZt5Yal3NOjvfjVOkKXgzf3flDAcEf2GJ2hj+hT3CMIuoYYZKdP+mvRqZYIrWm0cVCihJKhl6gXXUt0M0XKzRzOIDMkMefkqoTUBQkfQJnNLjKt2CdVIxwF8BR7Gr6pVgwPHN1WNk9ue7nCd6A3N6WGcCDPQ+UQeZ4zSieFDd6bLInlRccPBdYkYswVMXOVzQzzwBCrgr+uqXjypwiIfS+IghbL3JeyLPKVLyte/y6HIlqZnUgiybJFn0YXRCzIRr9ckmxavf0rXsJfRq0cIOTTgLW7CQSjYUcMcWAFgZeVLvbt1c4vnvUGbXUxV3+qWtfvi838mUT9GMkix0WqecuB315we9U/72VxyW2bjHQGMttkOwGHvg2KlP2QnlR9bRaOavMB5ALwc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6733.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlppYzg5b205bG9GZWxqSm5rTEtuNFRoOGRhWHVRUnpTUXNHMk9DZnJid1Yy?=
 =?utf-8?B?N2NRQVo4R1A4a2JnZ0FDWlJyUGFCYW95STJwMk1wZUQ4c2ZzOVdLYnE5N01p?=
 =?utf-8?B?ZUczcWo1SGFwblkxcVJuT3lJcG8wZFlYN1JrcHEwN092TmlRTW9Zd2RrUlNE?=
 =?utf-8?B?N3BJNEpqS1NaN29kV095YnM2Q25MdU9wNjlKNkZTSzVsU3pXVk84WWYyTkR2?=
 =?utf-8?B?TCtFU2VTKzdNTjNheDUvM3Ivc2VNUVJhb3dxcSt4SFlndm5adk5BeDRuOXJo?=
 =?utf-8?B?eFpzWk5ORkdheXFRbm00MnV1Q1JvUlp5N0c1Z210RS83U3NuVWs2bnZqeXdU?=
 =?utf-8?B?K3A1MGRQdUZVOHpWOFB6UWVDYUdKY1Y0Z2lGdGpMYk9pNlZLZVVPWld2VFNo?=
 =?utf-8?B?czIyR2d5eWJkb2NlTDFxd2xwMHdBOVJ0cHQwcE1XZGM1ZFhpR3QzaHVvd0hC?=
 =?utf-8?B?Z3pBVmJqRzljQXRPTU9pQndabE9kOWFSQlJndnlMQmpIUkJ0dThhcW5uVTZk?=
 =?utf-8?B?OElXRXlFNzNEeUROQUFIWEZiQUwyYXRrZEtmNCtSdEZyQVlKTC9SeDBNY3BK?=
 =?utf-8?B?SFczYWp2WnFPc1didEt0TWkvWFVxbkpHQUNNNWtxcEl5alF6cjVraXlQTnNk?=
 =?utf-8?B?eUcwZjJOYWdGVUpJUVlYaExLUXRKUlJZNC92Ync5WnlaYkZNMEluWGpSTVlx?=
 =?utf-8?B?R3NMaWRzcnVEbHFCeTZaWDJsRFNRRVUyb3RJWURSUjdRVnk3YnpWbStYWFBH?=
 =?utf-8?B?eGZPVThwZW4xK2ZmMGw0SXk1bkJ4cDhwQVlVbk1ab0pTTzg5dGQwMkd3Y1l3?=
 =?utf-8?B?dVBLMEgvNlpMUUxlRjBXdE94ZFFkdndSK1Y2REt6UnU1bTRLL1oybWtTU1dv?=
 =?utf-8?B?Y1RDOHRDR1dvUnZ6WTRaWE1YWTZvRWhQY0phay9PWnVNeHJBTDBwNVlUV2N2?=
 =?utf-8?B?WlRVNE53bHB4V0dJUU5RQi9wM1RFd3loRTIrVE1FMzJaSXZncnRuTGs3WGRs?=
 =?utf-8?B?OERmdHpXU0t0alZPSFliZUhtSGFqVzg4UzQ5UmZNeGNlTnczQ0hiaUtTc1dB?=
 =?utf-8?B?YUFBd1pocHRmSyszNlVSeithTmg5NytseFQ0eWwwdnBMQ3lpMFNsVWlCUkk3?=
 =?utf-8?B?amIycTJXdWhlcTd4YWRqenZYRFdta3NPUkZVdmFQWnNkdWRBVGRhMWdXSGRr?=
 =?utf-8?B?RjZCSmt5ODh1d0dwdWRRUVc2QlI5SHlCWXlTeWdFVzJvdEJ2cllPMVFqS2ZD?=
 =?utf-8?B?NU9hVGpSOFJhU3BZdEZnOVdscDZ4ZjEyRnFOalJacW4vYWh3aTA4RUlCdmxj?=
 =?utf-8?B?OHB1S3AwMFBxOUVNYWV5d1AydE5HNWxmdFZvV1VVaU9yUnFFZTZ2UzNnYXNl?=
 =?utf-8?B?aEtNV3hNcFFnaE9LL0ZZaWoxZW1zdlFaYy80ZjRKTVJwanAwOXdvSk5oMVdK?=
 =?utf-8?B?TGFENHdCOS9yWmVMRzJpVllNMEhXb21RS0NxWVRsVERNbzBXcEVRRjJrRXQ5?=
 =?utf-8?B?SUdYbDRSRmdHSG9VaVFiUUtUMFQ1aGJFZTFFRUY1bFlBYUU4MjlkYUYzZkhD?=
 =?utf-8?B?bkFLT094aHVYaXgxeFVuK0FqclVzUk1xNlVhc1hIcnliRU5RZVJzY1lLWnNs?=
 =?utf-8?B?WVNJMXdFQ05ZOHhjeHZSbEd3U3QzRUNrTXFLUXNXaldTb21URTZPd1ZOUnRC?=
 =?utf-8?B?MHBWR2JhMXhTWTRleksybnFqZDN1QzFwcnNBd0hqUldPaUIrclJJL3lzYUJz?=
 =?utf-8?B?eWRzSFI1U25RdFNNVFVMTEo0MU1pUHVneXFhV1BXeEttYm1FQlU5ZVVObTJQ?=
 =?utf-8?B?WS9ZMTNmZFJGNVUvbDIyc3ZNcEJtL3BtSTRWdnBLditINUdPWEVVMndhbXZJ?=
 =?utf-8?B?L0JwRVlpYnVYMXNSRm5wY0JZNC93NENRelgyQkx2RnJlTVd3dFY1dzBrMzRU?=
 =?utf-8?B?ZWZpa3VHS0FjNFFzZHc4a2JOcFB5NnNGNzk4cnFJd1FsTVA1VFhVMnMrL0Vq?=
 =?utf-8?B?cHZqNlhQaHp4Ny9NY0dBUExSMmJicnVDKzhUOWNzTkYzUk9pOWpCMmNaS2Vs?=
 =?utf-8?B?bDJ5Q1ZRQ1FQTENncWFiRUVFTTBnOVkxZUtMWXdWelFTQzJnUVcxNG10b0Yw?=
 =?utf-8?B?eCsxck5kQUlLOG12a3Qya0p3ZVVzSFpWWXVUWWZzQVpOL1N5cGJtS1hKL2M4?=
 =?utf-8?B?YVVFQlZQU01UWWRpWTJCZHlUNVArYmNZc0tsUnpVVzB3Nks4amRzYllzdis2?=
 =?utf-8?B?MzM3VEt1WklhQVBISjFYenBEalVXcXpMdEQ1NGwzY3lMSnZDQ0t1dXI0NTVI?=
 =?utf-8?B?Y2dDQ1RwT05sZ0xQTWpnUUkzSkFXSzZSSmRLZnZHU0NoVUpaa05nQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb835a5-116d-42a8-0a6d-08dee63a29f4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 08:37:42.0995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JIkNZmNAeUT2bVoMuh/eQL//F8RxwqIu4d1lb0T87sCyIoEofn4D/MaPWFGvCwsbil9321JSKtevYAAR3YedqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999281

On Tue Jun 16, 2026 at 11:44 AM CST, Kai-Heng Feng wrote:

A gentle ping...

> Vera is NVIDIA's next-generation server SoC. It reports hardware
> errors via ACPI GHES using a CPER section format distinct from the
> existing Grace section. Without this series, firmware-reported errors
> on Vera platforms are received but not decoded.
>
> Patch 1 refactors the Grace decoder to separate parsing from logging,
> preparing it for testability and for sharing types with the new Vera
> decoder.
>
> Patches 2-4 add the Vera decoder, KUnit coverage for both decoders,
> and an EINJ-based kselftest for end-to-end validation on real hardware.
>
> Kai-Heng Feng (4):
>   ACPI: APEI: GHES: Refactor Grace decoder helpers
>   ACPI: APEI: GHES: Add NVIDIA Vera decoder
>   ACPI: APEI: GHES: Add Grace and Vera KUnit coverage
>   selftests: firmware: Add NVIDIA GHES EINJ selftest
>
>  drivers/acpi/apei/Kconfig                     |  17 +-
>  drivers/acpi/apei/Makefile                    |   1 +
>  drivers/acpi/apei/ghes-nvidia-test-fixtures.h | 233 ++++++
>  drivers/acpi/apei/ghes-nvidia-test.c          | 704 ++++++++++++++++++
>  drivers/acpi/apei/ghes-nvidia.c               | 480 ++++++++++--
>  drivers/acpi/apei/ghes-nvidia.h               |  63 ++
>  tools/testing/selftests/firmware/Makefile     |   4 +-
>  tools/testing/selftests/firmware/config       |   5 +
>  tools/testing/selftests/firmware/einj_lib.sh  | 189 +++++
>  .../selftests/firmware/ghes_nvidia_einj.sh    | 144 ++++
>  .../firmware/ghes_nvidia_einj_profiles.sh     |  46 ++
>  11 files changed, 1838 insertions(+), 48 deletions(-)
>  create mode 100644 drivers/acpi/apei/ghes-nvidia-test-fixtures.h
>  create mode 100644 drivers/acpi/apei/ghes-nvidia-test.c
>  create mode 100644 drivers/acpi/apei/ghes-nvidia.h
>  create mode 100644 tools/testing/selftests/firmware/einj_lib.sh
>  create mode 100755 tools/testing/selftests/firmware/ghes_nvidia_einj.sh
>  create mode 100755 tools/testing/selftests/firmware/ghes_nvidia_einj_pro=
files.sh

