Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B08BC433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 10 Nov 2021 16:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C98161205
	for <linux-hardening@archiver.kernel.org>; Wed, 10 Nov 2021 16:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhKJQI3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 10 Nov 2021 11:08:29 -0500
Received: from mail-db8eur05on2080.outbound.protection.outlook.com ([40.107.20.80]:64993
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232281AbhKJQI3 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 10 Nov 2021 11:08:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiRUYd83deTC4uwl6/WT8Cut3nlDG2zJEMEF/alxC6A=;
 b=DDz2qrTTR0tj/uAm3AWScsc6bdROe2+wiUtgn1q1HdJBbqByDkatlrcF924B7N3cx70aRQLt0i1Krru6iLm+pNZo8BqpvZQQNxnHTwsci+FKW1txWP4dB60Q0PvEjbbW1hBj2KekbKFqbepXmnxMvf9eYGCZWMjYq7PJaI8uG+c=
Received: from AM6P195CA0065.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:87::42)
 by DB8PR08MB3995.eurprd08.prod.outlook.com (2603:10a6:10:b2::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Wed, 10 Nov
 2021 16:05:37 +0000
Received: from AM5EUR03FT052.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:87:cafe::b7) by AM6P195CA0065.outlook.office365.com
 (2603:10a6:209:87::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16 via Frontend
 Transport; Wed, 10 Nov 2021 16:05:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT052.mail.protection.outlook.com (10.152.17.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.14 via Frontend Transport; Wed, 10 Nov 2021 16:05:37 +0000
Received: ("Tessian outbound 6ebd41198c5d:v108"); Wed, 10 Nov 2021 16:05:37 +0000
X-CR-MTA-TID: 64aa7808
Received: from f1047ce5eb1f.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 694D92D4-1E07-4063-A12D-405F98E87BE6.1;
        Wed, 10 Nov 2021 16:05:32 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f1047ce5eb1f.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 10 Nov 2021 16:05:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1I+sPwAN2WVXHVBI/h11uUSm1Kt/ebLMMntW88bx+tjQ5HGW5v0KFicgBw3eAQK2nTb9F4KreN8KHC6g6XvKlv7A3+39tLces8zmF/H2eAlXwB2XYHI9KB7vEQwF2T5ZPWXPz0AXZJ59aO8FBfk7xULowXB2BEnA4+5F/HUpMOO1lPbEHaHfvyRkBKSBPLwlFjXbOFlmfSXcp5FykMRjPkpVLey0TJGiqdRJDIkWk8iBqpmSSjrcsDJFUemggZDibqTRN7E+fNgb3SJCWxvUp4j9mc1VuNjwMSt0zTRDZWBgHa8kH5dAvNzocB8KrUgf+lzdQECu9ZiJ6/F9ThrPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QiRUYd83deTC4uwl6/WT8Cut3nlDG2zJEMEF/alxC6A=;
 b=KDsaMSgAKljZ52/Nnaj2b73DuTbgEPb+vLCchPcAqkgnGOnmUr1hPqPWr8Y+xUx8vatAruJyESkiupLharKriWGmTbpYu08+kbGFbZJ/5Pt/DzYuKsmkwWbHnPIt2YHOVHTrOfO8T65L4eJIHijZ7/aSfVHXSHSPjZRspK5+7+JGbOGoEcWATI32ZVbrpiOyzdYFLlalbCF4I62vsfUpGZ9iUWV/k1jdp2aw2LXBPPF6r4due2ct2gf98L1fSdJqbKJ1QlOhIjGyj57rSmOTrDtGPOZTsrpPe3b7BfWAfv7+U3GnqZQl8A9gQrjU0kpZ9EPSB8hc+mVV/9iYxnctlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiRUYd83deTC4uwl6/WT8Cut3nlDG2zJEMEF/alxC6A=;
 b=DDz2qrTTR0tj/uAm3AWScsc6bdROe2+wiUtgn1q1HdJBbqByDkatlrcF924B7N3cx70aRQLt0i1Krru6iLm+pNZo8BqpvZQQNxnHTwsci+FKW1txWP4dB60Q0PvEjbbW1hBj2KekbKFqbepXmnxMvf9eYGCZWMjYq7PJaI8uG+c=
Received: from PAXPR08MB6926.eurprd08.prod.outlook.com (2603:10a6:102:138::24)
 by PAXPR08MB6494.eurprd08.prod.outlook.com (2603:10a6:102:154::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Wed, 10 Nov
 2021 16:05:29 +0000
Received: from PAXPR08MB6926.eurprd08.prod.outlook.com
 ([fe80::c020:b94e:19ee:c82f]) by PAXPR08MB6926.eurprd08.prod.outlook.com
 ([fe80::c020:b94e:19ee:c82f%7]) with mapi id 15.20.4649.019; Wed, 10 Nov 2021
 16:05:29 +0000
From:   Kyrylo Tkachov <Kyrylo.Tkachov@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        Richard Sandiford <Richard.Sandiford@arm.com>,
        "thomas.preudhomme@celest.fr" <thomas.preudhomme@celest.fr>,
        Keith Packard <keithpac@amazon.com>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>
Subject: RE: [PATCH v4 1/1] [ARM] Add support for TLS register based stack
 protector canary access
Thread-Topic: [PATCH v4 1/1] [ARM] Add support for TLS register based stack
 protector canary access
Thread-Index: AQHXy+8j3V1YkLsbWUm6VB0NqJqReqv899Gg
Date:   Wed, 10 Nov 2021 16:05:29 +0000
Message-ID: <PAXPR08MB692650A8960680FCBFA8051893939@PAXPR08MB6926.eurprd08.prod.outlook.com>
References: <20211028112703.1120709-1-ardb@kernel.org>
 <20211028112703.1120709-2-ardb@kernel.org>
In-Reply-To: <20211028112703.1120709-2-ardb@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 76FB50EE3FB07E4DBEA0FB73B514023C.0
x-checkrecipientchecked: true
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 161eedbd-289d-4226-f1bc-08d9a463ef9a
x-ms-traffictypediagnostic: PAXPR08MB6494:|DB8PR08MB3995:
X-Microsoft-Antispam-PRVS: <DB8PR08MB3995C4A23D520BEA309D50B793939@DB8PR08MB3995.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: NeS5FJYd17b4YmC9WzgZnoiQJqPdryMmbu/PCDgnDmrpmyQ42KvBWDY8uUOThCZI8MaDII7Qy8BI7lMcE/RRvk+xH7whnEsgHIvKX+KghgENjLGGnw75D8wviaYgnnVKS5v4vsP8HmVOYMkbPYgyWCHYDbbSiPZ+GEKT9U3bhCAM65wI2ZWNpYq2Z5uzR4TArItqPCdKUhGb9n2VIIncW/nZrb5SwFhcOycxjY3oQ/G1evvCdG9weRakKBtksZx+zBiQjD6ZDZ59tvM8ddGSxpRZP4BASCm2C/rf+lJ/UfdEYHKE0eK+H7ZepAvkWi0hnieqEx0IkvjEcSh8vwY/Vn9BLs2GFc+ey1qIwcr0HBZrqITPksSLQUpEwBn/1uS+Lu8SiIUQGFouccQxNXg0F7I3RM4HK7Lt/hoKGKPNyS66Xvxb6ARmLcgLSAweGny9oNGIfo5hz4Xy/hKoVy9vFx5vobBHkxvpREV7lqUWJmvVFu41UIXZZgYzIPXJ8dVZcLG5DGm+Rqc0ZCIruDXfwcGKZjWQlpGPAwfbYawv42dykzDF9Y8joRSW5uZOletgjongP7PFwfr8T32E86bsP/hcYVG4W6CS8M4QlIHcKPJ+r0d2ub2k6vGAeG7ZLeNwsG2yek+FxGwEMUtROFnLKm78ed/Mou9BYErwHtVlY4x9bNfdFWiGHE6x5ad0n3WnWwmjAjIdwuR59v2vAB7NPDBl02/gcsXPw1UzvVXSRILX3NQNUiYRPHPBxWZXJLAa0aVsCqKYxGCWHVSF7EMVfcNN0/NM8D/jpTqZfp7m5K7ZEkVDad9HWusUlvrqCm/cS1rUzq4Lt2NlnYxtE8XxLQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6926.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(508600001)(55016002)(4001150100001)(54906003)(66946007)(316002)(53546011)(110136005)(9686003)(64756008)(66556008)(6506007)(66476007)(66446008)(52536014)(83380400001)(71200400001)(966005)(38070700005)(8936002)(76116006)(86362001)(5660300002)(122000001)(38100700002)(2906002)(4326008)(7696005)(26005)(30864003)(8676002)(186003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6494
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT052.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8745eb83-f553-4e84-af5e-08d9a463eac0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: byzJJHb20KeYoVEY1v4TEx1Kbh3R/zTCQklhYzTf1is+dG55Z6DDRYsP8MHgiz0ohc1ujIinMr1dmzHwxuizCr6ad4QLIvE0+D5tvzERIuR7OP8/UbdWdylc+uCMoweE2bf6+/DbE/cTdRhKrYHgPgIkCGUJr+SyWSDejapJUqendfC2Q/V26mwyBuyrNoxGmQ2IVq8xOXxlJECspqV7KkSmgwNcELetgd5SURrPbEV7RJH0oPa1gRWKJScZAZHRr20tkay1OObJmlKdecc03wY7rwJvTbxaZ9BUbVtRmN+nPXyfGEAptof8g1wEFkB7PLx2TqniS7evNT3m49bhY+LzobXjGNtup2HuMM0Uf1MI5CmymMuldJY3nAWtJILA3WctYVQb1IjzhL1J73MXP3i2V0eS7sRceqn33jzU/qpT8Z4eqQqh+33LxEqCQfnBV5DDwmV8QCWtxURwxvNIfWv7K15R9A4bwOHfMdzt+90Uvjd2dDYax+NMSDQe9KR9oMQHQpf34QDCI7ntu/6sb7NTyHBtp5oKKCjA42oqPQ+U0l/Wg9B9F1oddQ0iuCFD9XdJ44KbhjApbdUKuggVGUnFvzqsdxZM0eNVRMKiFttVS4VZJQsPl2BPgtuabzvcOsiOmTcn1OADWbZY8Hi8pjF6n+HzsDZPgEY4Kqqbpqqd65JzkqqXfJK66p9LMZ9rF2dAB9AvaTDMh1YYWD82eRfAUa1900jD83ETjdGr+eWDsQXJvTM1Qfhgf0dc6Ldm3dr+h+13FMKP8I/Nkw72fm291N1LIY8sUr+v3eiJqOGEvZPkgMTbOJk3PNmL+jNWb4ICbC0iKZogb2CsDYDzuw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(54906003)(8936002)(52536014)(110136005)(966005)(5660300002)(70586007)(70206006)(26005)(6506007)(508600001)(2906002)(4001150100001)(82310400003)(7696005)(8676002)(55016002)(336012)(186003)(47076005)(81166007)(356005)(33656002)(9686003)(86362001)(36860700001)(30864003)(4326008)(316002)(83380400001)(53546011);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 16:05:37.7563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 161eedbd-289d-4226-f1bc-08d9a463ef9a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT052.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3995
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Ard,

Thanks for working on this, comments inline.

> -----Original Message-----
> From: Gcc-patches <gcc-patches-
> bounces+kyrylo.tkachov=3Darm.com@gcc.gnu.org> On Behalf Of Ard
> Biesheuvel via Gcc-patches
> Sent: Thursday, October 28, 2021 12:27 PM
> To: linux-hardening@vger.kernel.org
> Cc: keescook@chromium.org; Richard Sandiford
> <Richard.Sandiford@arm.com>; thomas.preudhomme@celest.fr; Keith
> Packard <keithpac@amazon.com>; gcc-patches@gcc.gnu.org; Ard Biesheuvel
> <ardb@kernel.org>
> Subject: [PATCH v4 1/1] [ARM] Add support for TLS register based stack
> protector canary access
>=20
> Add support for accessing the stack canary value via the TLS register,
> so that multiple threads running in the same address space can use
> distinct canary values. This is intended for the Linux kernel running in
> SMP mode, where processes entering the kernel are essentially threads
> running the same program concurrently: using a global variable for the
> canary in that context is problematic because it can never be rotated,
> and so the OS is forced to use the same value as long as it remains up.
>=20
> Using the TLS register to index the stack canary helps with this, as it
> allows each CPU to context switch the TLS register along with the rest
> of the process, permitting each process to use its own value for the
> stack canary.
>=20
> 2021-10-28 Ard Biesheuvel <ardb@kernel.org>
>=20
> 	* config/arm/arm-opts.h (enum stack_protector_guard): New
> 	* config/arm/arm-protos.h (arm_stack_protect_tls_canary_mem):
> 	New
> 	* config/arm/arm.c (TARGET_STACK_PROTECT_GUARD): Define
> 	(arm_option_override_internal): Handle and put in error checks
> 	for stack protector guard options.
> 	(arm_option_reconfigure_globals): Likewise
> 	(arm_stack_protect_tls_canary_mem): New
> 	(arm_stack_protect_guard): New
> 	* config/arm/arm.md (stack_protect_set): New
> 	(stack_protect_set_tls): Likewise
> 	(stack_protect_test): Likewise
> 	(stack_protect_test_tls): Likewise
> 	(reload_tp_hard): Likewise
> 	* config/arm/arm.opt (-mstack-protector-guard): New
> 	(-mstack-protector-guard-offset): New.
> 	* doc/invoke.texi: Document new options
>=20

How has this been tested? The code looks mostly okay to me, but the rules f=
or patches require a bootstrap and run of the testsuite:
https://gcc.gnu.org/contribute.html#testing
If you don't have access to an arm machine, the GCC compile farm may be of =
use: https://gcc.gnu.org/wiki/CompileFarm

In terms of tests, like Qing says we'd like to see some additions to the te=
stsuite.
These would go into the testsuite/gcc.target/arm directory.
You can grep for "mstack-protector-guard" in the testsuite/ directory to se=
e how various targets test this functionality and copy/adapt some tests for=
 arm.

> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  gcc/config/arm/arm-opts.h   |  6 ++
>  gcc/config/arm/arm-protos.h |  2 +
>  gcc/config/arm/arm.c        | 55 +++++++++++++++
>  gcc/config/arm/arm.md       | 71 +++++++++++++++++++-
>  gcc/config/arm/arm.opt      | 22 ++++++
>  gcc/doc/invoke.texi         |  9 +++
>  6 files changed, 163 insertions(+), 2 deletions(-)
>=20
> diff --git a/gcc/config/arm/arm-opts.h b/gcc/config/arm/arm-opts.h
> index 5c4b62f404f7..581ba3c4fbbb 100644
> --- a/gcc/config/arm/arm-opts.h
> +++ b/gcc/config/arm/arm-opts.h
> @@ -69,4 +69,10 @@ enum arm_tls_type {
>    TLS_GNU,
>    TLS_GNU2
>  };
> +
> +/* Where to get the canary for the stack protector.  */
> +enum stack_protector_guard {
> +  SSP_TLSREG,                  /* per-thread canary in TLS register */
> +  SSP_GLOBAL                   /* global canary */
> +};
>  #endif
> diff --git a/gcc/config/arm/arm-protos.h b/gcc/config/arm/arm-protos.h
> index 9b1f61394ad7..d8d605920c97 100644
> --- a/gcc/config/arm/arm-protos.h
> +++ b/gcc/config/arm/arm-protos.h
> @@ -195,6 +195,8 @@ extern void arm_split_atomic_op (enum rtx_code,
> rtx, rtx, rtx, rtx, rtx, rtx);
>  extern rtx arm_load_tp (rtx);
>  extern bool arm_coproc_builtin_available (enum unspecv);
>  extern bool arm_coproc_ldc_stc_legitimate_address (rtx);
> +extern rtx arm_stack_protect_tls_canary_mem (bool);
> +
>=20
>  #if defined TREE_CODE
>  extern void arm_init_cumulative_args (CUMULATIVE_ARGS *, tree, rtx, tree=
);
> diff --git a/gcc/config/arm/arm.c b/gcc/config/arm/arm.c
> index c4ff06b087eb..6a659d81a6fe 100644
> --- a/gcc/config/arm/arm.c
> +++ b/gcc/config/arm/arm.c
> @@ -829,6 +829,9 @@ static const struct attribute_spec
> arm_attribute_table[] =3D
>=20
>  #undef TARGET_MD_ASM_ADJUST
>  #define TARGET_MD_ASM_ADJUST arm_md_asm_adjust
> +
> +#undef TARGET_STACK_PROTECT_GUARD
> +#define TARGET_STACK_PROTECT_GUARD arm_stack_protect_guard
>=20
>=20
>=20
>  /* Obstack for minipool constant handling.  */
>  static struct obstack minipool_obstack;
> @@ -3155,6 +3158,26 @@ arm_option_override_internal (struct
> gcc_options *opts,
>    if (TARGET_THUMB2_P (opts->x_target_flags))
>      opts->x_inline_asm_unified =3D true;
>=20
> +  if (arm_stack_protector_guard =3D=3D SSP_GLOBAL
> +      && opts->x_arm_stack_protector_guard_offset_str)
> +    {
> +      error ("incompatible options %'-mstack-protector-guard=3Dglobal%' =
and"
> +	     "%'-mstack-protector-guard-offset=3D%qs%'",
> +	     arm_stack_protector_guard_offset_str);
> +    }
> +
> +  if (opts->x_arm_stack_protector_guard_offset_str)
> +    {
> +      char *end;
> +      const char *str =3D arm_stack_protector_guard_offset_str;
> +      errno =3D 0;
> +      long offs =3D strtol (arm_stack_protector_guard_offset_str, &end, =
0);
> +      if (!*str || *end || errno)
> +	error ("%qs is not a valid offset in %qs", str,
> +	       "-mstack-protector-guard-offset=3D");
> +      arm_stack_protector_guard_offset =3D offs;
> +    }

The arm target supports a bigger diversity of configurations than aarch64. =
Do we need to error out here if the user tries to specify the option for ta=
rgets like M-profile, Thumb-1, older Arm architectures etc?
If you want to gate all this on TARGET_32BIT that will restrict it to A32 a=
nd T32.

> +
>  #ifdef SUBTARGET_OVERRIDE_INTERNAL_OPTIONS
>    SUBTARGET_OVERRIDE_INTERNAL_OPTIONS;
>  #endif
> @@ -3822,6 +3845,10 @@ arm_option_reconfigure_globals (void)
>        else
>  	target_thread_pointer =3D TP_SOFT;
>      }
> +
> +  if (arm_stack_protector_guard =3D=3D SSP_TLSREG
> +      && target_thread_pointer !=3D TP_CP15)
> +    error("%'-mstack-protector-guard=3Dtls%' needs a hardware TLS regist=
er");
>  }

We can use the more compact (&& !TARGET_HARD_TP) check here instead.

>=20
>  /* Perform some validation between the desired architecture and the rest=
 of
> the
> @@ -8087,6 +8114,22 @@ legitimize_pic_address (rtx orig, machine_mode
> mode, rtx reg, rtx pic_reg,
>  }
>=20
>=20
> +rtx
> +arm_stack_protect_tls_canary_mem (bool reload)

New functions should have a function comment describing the arguments and r=
eturn value.
See other functions in this file for the recommended format.

> +{
> +  rtx tp =3D gen_reg_rtx (SImode);
> +  if (reload)
> +    emit_insn (gen_reload_tp_hard (tp));
> +  else
> +    emit_insn (gen_load_tp_hard (tp));
> +
> +  rtx reg =3D gen_reg_rtx (SImode);
> +  rtx offset =3D GEN_INT (arm_stack_protector_guard_offset);
> +  emit_set_insn (reg, gen_rtx_PLUS (SImode, tp, offset));

You can write this more compactly as:
emit_set_insn (gen_addsi3 (reg, tp, offset));

> +  return gen_rtx_MEM (SImode, reg);
> +}


> +
> +
>  /* Whether a register is callee saved or not.  This is necessary because=
 high
>     registers are marked as caller saved when optimizing for size on Thum=
b-1
>     targets despite being callee saved in order to avoid using them.  */
> @@ -34054,6 +34097,18 @@ arm_run_selftests (void)
>  #define TARGET_RUN_TARGET_SELFTESTS selftest::arm_run_selftests
>  #endif /* CHECKING_P */
>=20
> +/* Implement TARGET_STACK_PROTECT_GUARD. In case of a
> +   global variable based guard use the default else
> +   return a null tree.  */
> +static tree
> +arm_stack_protect_guard (void)
> +{
> +  if (arm_stack_protector_guard =3D=3D SSP_GLOBAL)
> +    return default_stack_protect_guard ();
> +
> +  return NULL_TREE;
> +}
> +
>  /* Worker function for TARGET_MD_ASM_ADJUST, while in thumb1 mode.
>     Unlike the arm version, we do NOT implement asm flag outputs.  */
>=20
> diff --git a/gcc/config/arm/arm.md b/gcc/config/arm/arm.md
> index 4adc976b8b67..d31349cd2614 100644
> --- a/gcc/config/arm/arm.md
> +++ b/gcc/config/arm/arm.md
> @@ -9183,7 +9183,7 @@ (define_expand "stack_protect_combined_set"
>  		      UNSPEC_SP_SET))
>        (clobber (match_scratch:SI 2 ""))
>        (clobber (match_scratch:SI 3 ""))])]
> -  ""
> +  "arm_stack_protector_guard =3D=3D SSP_GLOBAL"
>    ""
>  )
>=20
> @@ -9267,7 +9267,7 @@ (define_expand "stack_protect_combined_test"
>        (clobber (match_scratch:SI 3 ""))
>        (clobber (match_scratch:SI 4 ""))
>        (clobber (reg:CC CC_REGNUM))])]
> -  ""
> +  "arm_stack_protector_guard =3D=3D SSP_GLOBAL"
>    ""
>  )
>=20
> @@ -9361,6 +9361,64 @@ (define_insn "arm_stack_protect_test_insn"
>     (set_attr "arch" "t,32")]
>  )
>=20
> +(define_expand "stack_protect_set"
> +  [(match_operand:SI 0 "memory_operand")
> +   (match_operand:SI 1 "memory_operand")]
> +  "arm_stack_protector_guard =3D=3D SSP_TLSREG"
> +  "
> +{
> +  operands[1] =3D arm_stack_protect_tls_canary_mem (false /* reload */);
> +  emit_insn (gen_stack_protect_set_tls (operands[0], operands[1]));
> +  DONE;
> +}"
> +)
> +
> +;; DO NOT SPLIT THIS PATTERN.  It is important for security reasons that=
 the
> +;; canary value does not live beyond the life of this sequence.
> +(define_insn "stack_protect_set_tls"
> +  [(set (match_operand:SI 0 "memory_operand" "=3Dm")
> +       (unspec:SI [(match_operand:SI 1 "memory_operand" "m")]
> +        UNSPEC_SP_SET))
> +   (set (match_scratch:SI 2 "=3D&r") (const_int 0))]
> +  ""
> +  "ldr\\t%2, %1\;str\\t%2, %0\;mov\t%2, #0"
> +  [(set_attr "length" "12")
> +   (set_attr "conds" "nocond")

I think this should be "unconditional" as we don't want the late if-convers=
ion pass to try making this conditional (though it'll likely stay away as t=
his is a multi-insn parallel anyway).
I know that the existing stack_protect_set_insn has "nocond" here, but I th=
ink that's wrong, and we can fix that separately.

> +   (set_attr "type" "multiple")]
> +)
> +
> +(define_expand "stack_protect_test"
> +  [(match_operand:SI 0 "memory_operand")
> +   (match_operand:SI 1 "memory_operand")
> +   (match_operand:SI 2)]
> +  "arm_stack_protector_guard =3D=3D SSP_TLSREG"
> +  "
> +{
> +  operands[1] =3D arm_stack_protect_tls_canary_mem (true /* reload */);
> +  emit_insn (gen_stack_protect_test_tls (operands[0], operands[1]));
> +
> +  rtx cc_reg =3D gen_rtx_REG (CC_Zmode, CC_REGNUM);
> +  rtx eq =3D gen_rtx_EQ (CC_Zmode, cc_reg, const0_rtx);
> +  emit_jump_insn (gen_arm_cond_branch (operands[2], eq, cc_reg));
> +  DONE;
> +}"
> +)
> +
> +(define_insn "stack_protect_test_tls"
> +  [(set (reg:CC_Z CC_REGNUM)
> +	(compare:CC_Z (unspec:SI [(match_operand:SI 0 "memory_operand"
> "m")
> +				  (match_operand:SI 1 "memory_operand"
> "m")]
> +				 UNSPEC_SP_TEST)
> +		      (const_int 0)))
> +   (clobber (match_scratch:SI 2 "=3D&r"))
> +   (clobber (match_scratch:SI 3 "=3D&r"))]
> +  ""
> +  "ldr\t%2, %0\;ldr\t%3, %1\;eors\t%2, %3, %2\;mov\t%3, #0"
> +  [(set_attr "length" "16")
> +   (set_attr "conds" "set")
> +   (set_attr "type" "multiple")]
> +)
> +
>  (define_expand "casesi"
>    [(match_operand:SI 0 "s_register_operand")	; index to jump on
>     (match_operand:SI 1 "const_int_operand")	; lower bound
> @@ -12133,6 +12191,15 @@ (define_insn "load_tp_hard"
>     (set_attr "type" "mrs")]
>  )
>=20
> +;; Used by the TLS register based stack protector
> +(define_insn "reload_tp_hard"
> +  [(set (match_operand:SI 0 "register_operand" "=3Dr")
> +	(unspec_volatile [(const_int 0)] VUNSPEC_MRC))]

The unspec_volatile should have a mode: (unspec_volatile:SI ...)

> +  "TARGET_HARD_TP"
> +  "mrc\\tp15, 0, %0, c13, c0, 3\\t@ reload_tp_hard"
> +  [(set_attr "type" "mrs")]
> +)
> +
>  ;; Doesn't clobber R1-R3.  Must use r0 for the first operand.
>  (define_insn "load_tp_soft_fdpic"
>    [(set (reg:SI 0) (unspec:SI [(const_int 0)] UNSPEC_TLS))
> diff --git a/gcc/config/arm/arm.opt b/gcc/config/arm/arm.opt
> index a7677eeb45c8..4b3e17bc319c 100644
> --- a/gcc/config/arm/arm.opt
> +++ b/gcc/config/arm/arm.opt
> @@ -311,3 +311,25 @@ Generate code which uses the core registers only
> (r0-r14).
>  mfdpic
>  Target Mask(FDPIC)
>  Enable Function Descriptor PIC mode.
> +
> +mstack-protector-guard=3D
> +Target RejectNegative Joined Enum(stack_protector_guard)
> Var(arm_stack_protector_guard) Init(SSP_GLOBAL)
> +Use given stack-protector guard.
> +
> +Enum
> +Name(stack_protector_guard) Type(enum stack_protector_guard)
> +Valid arguments to -mstack-protector-guard=3D:
> +
> +EnumValue
> +Enum(stack_protector_guard) String(tls) Value(SSP_TLSREG)
> +
> +EnumValue
> +Enum(stack_protector_guard) String(global) Value(SSP_GLOBAL)
> +
> +mstack-protector-guard-offset=3D
> +Target Joined RejectNegative String
> Var(arm_stack_protector_guard_offset_str)
> +Use an immediate to offset from the TLS register. This option is for use=
 with
> +fstack-protector-guard=3Dtls and not for use in user-land code.

This text should go (or be copied) to...

> +
> +TargetVariable
> +long arm_stack_protector_guard_offset =3D 0
> diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
> index 71992b8c5974..46d009376018 100644
> --- a/gcc/doc/invoke.texi
> +++ b/gcc/doc/invoke.texi
> @@ -810,6 +810,7 @@ Objective-C and Objective-C++ Dialects}.
>  -mpure-code @gol
>  -mcmse @gol
>  -mfix-cmse-cve-2021-35465 @gol
> +-mstack-protector-guard=3D@var{guard} -mstack-protector-guard-
> offset=3D@var{offset} @gol
>  -mfdpic}
>=20
>  @emph{AVR Options}
> @@ -20946,6 +20947,14 @@ enabled by default when the option @option{-
> mcpu=3D} is used with
>  @code{cortex-m33}, @code{cortex-m35p} or @code{cortex-m55}.  The
> option
>  @option{-mno-fix-cmse-cve-2021-35465} can be used to disable the
> mitigation.
>=20
> +@item -mstack-protector-guard=3D@var{guard}
> +@itemx -mstack-protector-guard-offset=3D@var{offset}
> +@opindex mstack-protector-guard
> +@opindex mstack-protector-guard-offset
> +Generate stack protection code using canary at @var{guard}.  Supported
> +locations are @samp{global} for a global canary or @samp{tls} for a
> +canary accessible via the TLS register.

... here as this is the actual user-visible documentation.

Thanks,
Kyrill

> +
>  @item -mfdpic
>  @itemx -mno-fdpic
>  @opindex mfdpic
> --
> 2.30.2

