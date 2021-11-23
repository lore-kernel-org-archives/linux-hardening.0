Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3665BC433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 23 Nov 2021 10:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbhKWKzY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 23 Nov 2021 05:55:24 -0500
Received: from mail-am6eur05on2081.outbound.protection.outlook.com ([40.107.22.81]:47648
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234186AbhKWKzX (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 23 Nov 2021 05:55:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ej5QKd8p4vpHDiUi2LkJZFoOtdnoozMNtbCP+P98BOA=;
 b=Bt50T1v6CzJukv8da8Aa97fCMe3ZvrDwIY1UUSV7YB2nmCcUHnN0IEodLcacQOO6ADv8v6RknkuKxgFO6pZxab/0Ac1laa3pd2BYfdFg636+J3O3I46Ti2c1M5fa0XMHtHLFdIERFFZQ5w5a7mrxwue+rnm381oHo0DVZCtXex4=
Received: from DB6PR0301CA0025.eurprd03.prod.outlook.com (2603:10a6:4:3e::35)
 by VE1PR08MB5197.eurprd08.prod.outlook.com (2603:10a6:803:106::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 10:52:08 +0000
Received: from DB5EUR03FT057.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:3e:cafe::2e) by DB6PR0301CA0025.outlook.office365.com
 (2603:10a6:4:3e::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Tue, 23 Nov 2021 10:52:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT057.mail.protection.outlook.com (10.152.20.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19 via Frontend Transport; Tue, 23 Nov 2021 10:52:07 +0000
Received: ("Tessian outbound 1cd1a01725a6:v110"); Tue, 23 Nov 2021 10:52:07 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b2545be9ddb229c3
X-CR-MTA-TID: 64aa7808
Received: from 5d4cc37c249e.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B0FD904D-80C5-45BC-A8B4-5492B860D105.1;
        Tue, 23 Nov 2021 10:51:58 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5d4cc37c249e.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 23 Nov 2021 10:51:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrsALtPVeqJhvmWoQ4lCCRY0BQc/R8lCBkMdq3BHiBEoY3T/ZewhZsUhlkj4SveBQxcyBztpkgD7iWq2b98DaXCT4R9NFpTo/mbfFXNyhGi+Ge0CArMzuF1DHfPCcynMkHujErjs4g+JTPxaGhvmwoR8QOJtiqMGlSKQwhsuBKUP6EzPDdqzuwfWGETPJcbBeoaiA+369FNSRv6k8LVWp8I+c5yX5AO1VHmpM4FglQqs3upqNHgjdSqKdBQMHBPfty59Lbp7j0sJEXnNhPV/gLv5MRjo55KbfXYnD3LuMZPYefe1caA1SfedygqfJczEbeeyLhx4VptaRyzC5OAGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ej5QKd8p4vpHDiUi2LkJZFoOtdnoozMNtbCP+P98BOA=;
 b=bW8rMd8+7wL2NVALHw/eeSdDn3HT2cfc2X1kvcn5/Ib60HytyLE+m1oSYbThOCZPw+JbyCeGyWIEQIZnbg0Jn/RoecDGpP6SiJ2VbZ9ICoc0RL4CiEZeoK7a5XRscCW7L00t6uQA8yxYoO/S/uB9wq3G6xD9Wad/7yXOwQ1mCyy0/s7SyQW4TnLxyfi1i/uT4efus8BBbwzFk3H7SOXP83ET+nx7NmXtTeAsva9edxhFNkI5n/ZdhplBByi5lTRyuobvAQotZF0wRmP9NtejsAsb+/GJSz97bKMruFA8Sfsr6DbADKP2+nUrRkEFQoFvVCsHuobgbTmzlw1xK8NDBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ej5QKd8p4vpHDiUi2LkJZFoOtdnoozMNtbCP+P98BOA=;
 b=Bt50T1v6CzJukv8da8Aa97fCMe3ZvrDwIY1UUSV7YB2nmCcUHnN0IEodLcacQOO6ADv8v6RknkuKxgFO6pZxab/0Ac1laa3pd2BYfdFg636+J3O3I46Ti2c1M5fa0XMHtHLFdIERFFZQ5w5a7mrxwue+rnm381oHo0DVZCtXex4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by DB9PR08MB7195.eurprd08.prod.outlook.com (2603:10a6:10:2ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 10:51:56 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::198d:f67e:761b:ce0d]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::198d:f67e:761b:ce0d%3]) with mapi id 15.20.4713.025; Tue, 23 Nov 2021
 10:51:56 +0000
Date:   Tue, 23 Nov 2021 10:51:49 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] [RFC][PR102768] aarch64: Add compiler support for Shadow
 Call Stack
Message-ID: <20211123105149.GM1982710@arm.com>
References: <20211102070616.119780-1-ashimida@linux.alibaba.com>
 <20211102130413.GS1982710@arm.com>
 <fb3b7de8-7494-3190-1684-34fcbe9e1aa5@linux.alibaba.com>
 <20211103120047.GU1982710@arm.com>
 <7937172c-3b1a-ffca-59c5-d75b73e5e3a7@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7937172c-3b1a-ffca-59c5-d75b73e5e3a7@linux.alibaba.com>
X-ClientProxiedBy: SA9P223CA0016.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::21) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
Received: from arm.com (217.140.106.53) by SA9P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Tue, 23 Nov 2021 10:51:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3365b80-a40a-4060-dddd-08d9ae6f4b46
X-MS-TrafficTypeDiagnostic: DB9PR08MB7195:|VE1PR08MB5197:
X-Microsoft-Antispam-PRVS: <VE1PR08MB519728DBF770ACE0E3BC93D4ED609@VE1PR08MB5197.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: FKEs8GFi0E2wQ97opiRPg3qdMJk9SMtvfFZ54w9A13NlfmGhXkzmUadXgd4H065EAJSKaUe+KoqYFBIU9U7N+j1nlP7iAqK88YYXxLsL30mu+ZqG8Lvhmhtsio0JZteASQrpXGb3CoxYncOj7H4meeXYhoCEk/Vxu95QQx2rl1g4Erbx3Gf+xoXWA6fvG2bGNNtQKJxvgCz56vRSp4vNHdqU+eooQwrMYZD+ckiz5EqwmNQ19YdCsGwVGJHeegQuq2mjpuU2L0GCa8PKgLuQZWM5pIVg5ZP4RRSR1f+hFBEACsuqzZmpS4Mxf5uqZKXztAikDCKt05Im2kfPHS4I0f4vhrYZ3zXINhqjMUjTEKyRb0z9D5u0n4YrL/kffZFu4XNAsgbtojxPqFkrlM69VME6b/zjqak4HvBqq7J6ic7suMToyXVgxwM48/o/TJ8aivuZ40SqeNkgU6YGBKmN7KPCCUaGurArKjU70OvPrci65AUBVNOO8Sg5vlZZPyAJ6mFayIcni+dNhzS6R39eWwi/YxUTXznnvCzSFnqddGrjSKj8Ul7/PSs40Z9x2PsgiLqFk+q/ORsJHg3MuPMdfuVCcuaJfR7xlcrg5+5F2P/mrfoySuKinLA5VHp+wa+kdHCnKRpOEB62dNi81syo8yDkR1ZmqKoCrt8kVbvG9n3lI9VpGvVIG1lIJPbA2XJVOChKjaDEe1k1mOyjRqcykjYt/JXY1VbW31P4cT3s5rSRVJDSRgLJIhHWUS5ceYtOmUkLDO6NkaV/lSoLB0J9TiFEsT5jJCamGcOFXYnvZU0z9M37CwcDslRkqCQbTKR4NifxpFJRzva0h45iWl5FBA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(6666004)(1076003)(5660300002)(186003)(52116002)(8676002)(66556008)(53546011)(55016003)(956004)(66476007)(966005)(44832011)(33656002)(38350700002)(86362001)(2906002)(38100700002)(8936002)(66946007)(26005)(4326008)(8886007)(2616005)(316002)(6916009)(508600001)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7195
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT057.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 917e7768-f4c9-4ca4-9540-08d9ae6f4498
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EALElB+WgTx1I1haKshSwRBooZ5CNTYjuQ4+ZHBbaDqhNV2UF9Q2lYAqb/tIxBJzG6DoKT+iDT4I35vkXY/ec0ArlJB1g7MrkiqyY8g3j+2/Fiy0MY8wsgDP8qkyJmwn95g7wR5vr7g9L0yh6TRibNZNw7bUtinklY0eHQQwq988gyvGxI8gSqKJO2+BRwl8Yn2bEySipUpkMfmBVo2I5l3jjYwFGrVzKOX2ikRfP6J6fv1vNfFrWKqdfjRJIkfhT6j559ZNEMT5ORsXYaHvb60ds/IbbOIvIM9hbYWYnP9MPA/1VzZv0TdBSe3RFRPnQ8Y7mGfj94tavtL+FdvKxdU5W2w1HYdGmdzPb/oiXgML63LV39hZfdhojClFBPwsMLNHLniWsf0bzwZUcCzX+lO46RXZcdDx4R0uY02oTKYWEgY4ztEscVQTU9zbE7G3wBYajz1xwaUKNkhyOnPU24HnK1nEa53U/yWjR8GcU2icNU/UpyJZsiz+4vQsmrHwAkqDaxCPHJm92K3PNzZ8efKU6/KWMfwr7FLKCujbiobbKQQYUSxzTK/eTRXvcmm624Di/dcjbeETNJVUZ6+PM1wyRmoYUKVPQNLNDSyir8Z0a1hY/LAUoMHbMtY7beQQYpa1s43ob6D1tdduFnLiCxkZ3upQxwZAIKcjGxdE6LSpKY5UgVxqluTQ1OzUe3N9oQsUBE16XtFTUfaaMrz3d1MuqD8QDlx/ju/mc7nwvu17VepQ3a1BpdRCPiSi1DaSk9b7YMiCmsXDxQLPm4lhXkzYvqCXgsP9zYHuuV/hvTAav4NJT4tY4YUx3Mx3+60cCmDr8ao85B3qt3v/bQHYvw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(508600001)(966005)(6666004)(70586007)(83380400001)(36860700001)(8936002)(26005)(1076003)(2616005)(33656002)(82310400004)(86362001)(70206006)(44832011)(316002)(186003)(2906002)(336012)(53546011)(47076005)(6862004)(8886007)(8676002)(36756003)(81166007)(356005)(956004)(5660300002)(4326008)(55016003)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 10:52:07.7084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3365b80-a40a-4060-dddd-08d9ae6f4b46
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT057.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5197
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The 11/23/2021 16:32, Dan Li wrote:
> On 11/3/21 8:00 PM, Szabolcs Nagy wrote:
> > i assume exception handling info has to change for scs to
> > work (to pop the shadow stack when transferring control),
> > so either scs must require -fno-exceptions or the eh info
> > changes must be implemented.
> > 
> > i think the kernel does not require exceptions and does
> > not depend on the unwinder runtime in libgcc, so this
> > is optional for the linux kernel use-case.
> > 
> I recompiled a glibc and gcc runtime library with -ffixed-x18 enabled.
> As you said, the scs stack needs to be popped at the same time during
> exception handling.
> 
> I saw that Clang is processed by adding
> ".cfi_escape 0x16, 0x12, 0x02, 0x82, 0x78"
> directive (x18 -= 8;) after each emit of scs push[2].
> 
> But this directive has problems when executed in libgcc:
> 1)context->reg[x] in uw_init_context_1 are all based on cfa, most
>   registers have no initial values by default.
> 2)Address of shadow call stack (x18) cannot(and should not) be calculated
>   based on cfa, and I did not yet find a way to assign hardware register
>   x18 to context->reg[18].
> 3)This causes libgcc to crash when parsing .cfi_escape exp because of 0
>   address dereference (* x18)
>   (execute_stack_op => case DW_OP_breg18: _Unwind_GetGR)
> 4)uw_install_context_1 does not restore all hardware registers by default
>   before eh return, so context->reg[18] can't write directly to hw x18.
>   (In clang, __unw_getcontext/__unw_resume will save/restore all hardware
>   registers, so this directive works fine in my libunwind test.)
> 
> I tried to fix this problem through a patch[3], the exception handling
> works fine in my test environment, but I'm not sure if this fix is
> ppropriate for two reasons:
> 1)libgcc does not push/pop all registers by default during exception
>   handling. Is this change appropriate?
> 2)The test case may not be able to test this patch, because the test
>   environment requires at least on glibc/gcc runtime compiled with
>   -ffixed-x18.
> 
> May be it's better to rely on -fno-exceptions for this patch first? and If
> the glibc/gcc runtime also supports SCS later, the problem can be fixed
> at the same time.

i did not look at the exception handling in detail (that's
difficult to understand for me too).

to use scs, non-default abi is required anyway, so not
supporting exceptions sounds fine to me. however it should
be documented and ideally enforced (-fexceptions should
be rejected, just like -fno-fixed-x18).

i assume the linux kernel does not require -fexceptions.

> 
> PS:
> I'm still not familiar enough with exception handling in libgcc/libunwind,
> please correct me if there are any mistakes :)
> 
> [1] https://github.com/llvm/llvm-project/commit/f11eb3ebe77729426e562d7d4d7ebb1d5ff2e7c8
> [2] https://reviews.llvm.org/D54609
> [3] https://gcc.gnu.org/bugzilla/attachment.cgi?id=51854&action=diff
> 
