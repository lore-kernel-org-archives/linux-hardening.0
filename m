Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9EBC433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 21 Jan 2022 10:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbiAUKr3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 21 Jan 2022 05:47:29 -0500
Received: from mail-am6eur05on2051.outbound.protection.outlook.com ([40.107.22.51]:49690
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229828AbiAUKr3 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 21 Jan 2022 05:47:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzzbHePSQ4VeNCZ6WFtTozfCtAdyHz6YMMxJHN87ECA=;
 b=yh8yqUu2/6u5C8KW0xEq5qIyVoftUnOXJAZo4sWlNEBe85On+pAZC/6NfA1FwGwStBOK6sRIrLCT4vmv9tX1Agypjnvf/H8pruc+OFwKvQkZvN4LEUxuPnfjiCT4iVXL7ckD3kL9v249dx63JCAnO2rQODbSa0zXq8PL2BVPKJE=
Received: from AM7PR02CA0029.eurprd02.prod.outlook.com (2603:10a6:20b:100::39)
 by DB9PR08MB6636.eurprd08.prod.outlook.com (2603:10a6:10:250::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Fri, 21 Jan
 2022 10:47:25 +0000
Received: from AM5EUR03FT062.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:100:cafe::54) by AM7PR02CA0029.outlook.office365.com
 (2603:10a6:20b:100::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Fri, 21 Jan 2022 10:47:25 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 63.35.35.123) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT062.mail.protection.outlook.com (10.152.17.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.14 via Frontend Transport; Fri, 21 Jan 2022 10:47:23 +0000
Received: ("Tessian outbound 826a6d8e58c3:v113"); Fri, 21 Jan 2022 10:47:23 +0000
X-CR-MTA-TID: 64aa7808
Received: from 4c9ef0c1dae6.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0A5D6D8F-9032-42C1-B4FF-46DB3C008684.1;
        Fri, 21 Jan 2022 10:47:13 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4c9ef0c1dae6.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 21 Jan 2022 10:47:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4z/HvU/t2heWglEO756TJr76Zxa1i9DQnNBvAtOZznNjQwYJHn39oACGgTYuHkvrwPAobLfXS/hG6kRQfLXpJ7eFLKdYLU6dhpc2RCtSlrB6u6RPspE7RTb+2+gZTB61TaZkE+4fAOpHgdXF/W3aD7ge+xhJZe2olL4tbe5ZGFcvPORlUxbMLamQylSxVsmAdTpM6GxkZmspjlePvnzl5Pbciagkk6H3Tl+c9ajq+rE2LMghQ8jt7+RJ/M417pKyyGR8fMPvukOeYvPZDI+nyHrE7ex07eertI+XgvOqUyhrQQXOmeZSBA+rZ/LCIbcRiG8rjbyT0lIK0tD3abBmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzzbHePSQ4VeNCZ6WFtTozfCtAdyHz6YMMxJHN87ECA=;
 b=QRAhNzK5KGmkJFSUm/NJF+Md8xCayRzQp95ngQMx4HX/FwZECUaXnXpcaHfbnvkEMaGFsiT8Aj/tmLbrdk7xvR2gYEpYlpX3Sb8a3uNWAMrttnbzkWqKNQkRLrBxCNaDUtMOdGU1IOqvAQlhVxP93qTL/d8iku4DctTSTTWATzok1h7TWDFJyxUa+3Rosx2wTMVGmylHx2gEmbZ0OhiFZyaWzYfCKjkoe2EWyeezb5TG0Qa+C4PTOGC8D4dYgDLTWC++4MMmjNgmRbcyTLS334ps3RzXFYXRkzJ0NDvPRDT0ZNwwr24Jm6pXRGEJ/++fJ+l6mBzxVGjwAfTVoi6u7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzzbHePSQ4VeNCZ6WFtTozfCtAdyHz6YMMxJHN87ECA=;
 b=yh8yqUu2/6u5C8KW0xEq5qIyVoftUnOXJAZo4sWlNEBe85On+pAZC/6NfA1FwGwStBOK6sRIrLCT4vmv9tX1Agypjnvf/H8pruc+OFwKvQkZvN4LEUxuPnfjiCT4iVXL7ckD3kL9v249dx63JCAnO2rQODbSa0zXq8PL2BVPKJE=
Received: from PAXPR08MB6926.eurprd08.prod.outlook.com (2603:10a6:102:138::24)
 by VI1PR0802MB2560.eurprd08.prod.outlook.com (2603:10a6:800:ad::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Fri, 21 Jan
 2022 10:47:09 +0000
Received: from PAXPR08MB6926.eurprd08.prod.outlook.com
 ([fe80::69:f417:b4df:c313]) by PAXPR08MB6926.eurprd08.prod.outlook.com
 ([fe80::69:f417:b4df:c313%5]) with mapi id 15.20.4888.014; Fri, 21 Jan 2022
 10:47:09 +0000
From:   Kyrylo Tkachov <Kyrylo.Tkachov@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
CC:     Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Richard Sandiford <Richard.Sandiford@arm.com>,
        "thomas.preudhomme@celest.fr" <thomas.preudhomme@celest.fr>,
        Keith Packard <keithpac@amazon.com>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>
Subject: RE: [PATCH v6 1/1] [ARM] Add support for TLS register based stack
 protector canary access
Thread-Topic: [PATCH v6 1/1] [ARM] Add support for TLS register based stack
 protector canary access
Thread-Index: AQHYDVyTu09SEowbika0K1U793GypKxtTTSw
Date:   Fri, 21 Jan 2022 10:47:09 +0000
Message-ID: <PAXPR08MB69262E195F0EAAC0B3B85B47935B9@PAXPR08MB6926.eurprd08.prod.outlook.com>
References: <20220119174353.213723-1-ardb@kernel.org>
 <20220119174353.213723-2-ardb@kernel.org>
In-Reply-To: <20220119174353.213723-2-ardb@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 6DE65E8E52B4B1478C7D067D8F8CF9D6.0
x-checkrecipientchecked: true
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: a3396004-9d36-4bf0-bf95-08d9dccb6856
x-ms-traffictypediagnostic: VI1PR0802MB2560:EE_|AM5EUR03FT062:EE_|DB9PR08MB6636:EE_
X-Microsoft-Antispam-PRVS: <DB9PR08MB663668CAC2C9ED59F760A9FC935B9@DB9PR08MB6636.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: YWYnYRX3U7E5hdDHG7mzYC2n1eEKJwnB1dvIvLTnMTmvyawSU+MsJW0HIxX4CVmvAzCJkG26lLN69LJDCfsy9fz8g4LaKYUczo8QdVh2j8KWaaqukn4baSCZ6YReMr0XDWFGp3jCrifbSZDhTiIUqkXp6tgv/Cyf0+iLF7rvGzH48gFPU52V6AS0e5Il5SBN5d2lCfM0Cc+jADrVCF14dIOS5gbUDECtXDVMhPATDlXplILBKXLK+uVEJp4Zl5XPF4s1SuoCxgdOG/RrqFLrSLqp/eGh27S3HyPR8yertDuZnzTl+hawE0+bPs6GATkqjo+JoZ9Nw90N5f/awQBy79kwvCeB2++y2DSwxBQAQWMWLeMPx/J8FhBKbCsVmu/xWIN7Nw8LcrK4h3/W4HsUDChlTm1dE1EfoJiRGxl1A8R0PAL7W9n96oN5cGrY+yzqh1pPnucV5Igx+Y3ymmOl/wbgboF0hxcrAE1O4HYj12igMb4V7uS+QWTmOrZcDTgR+VU2ipel7eVjOaIFQoVapUo6n+hkfU09nH7SWo3PZnMmrA3qxC27xyD9CfTTCSsCzXXbKYe/EWcpaOAr29Wrex8rmFYQScHOlBRzkIlckPWc0yA39i2K53C8aqlbIbSUyU5U+x1+sRXdJHmRvJ/RdMotYmIR/FGMDlXITCFKfeQddLYJ2FwZ9I+a/3kizNsspLVxaadcIa+VmgmK7kou+0pvLQbi7mmCKQ2Ia0PxIeWQks/MSh1+/s4fUW7FWqZbFKTZ1Xm6cfXAHlZv+pFHBQJJsczaxTfu7EpJ8l3Jx2vc8GBMBFcqltxp+YGqy5O6Dxuc1B4GOQE58ZQ0DLOPAg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6926.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(30864003)(54906003)(86362001)(186003)(66446008)(66476007)(64756008)(66556008)(55236004)(66946007)(33656002)(83380400001)(5660300002)(84970400001)(110136005)(508600001)(26005)(55016003)(4326008)(8936002)(7696005)(9686003)(71200400001)(2906002)(6506007)(53546011)(76116006)(38070700005)(52536014)(316002)(122000001)(38100700002)(8676002);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2560
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT062.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3caf67a8-c8dd-4160-d364-08d9dccb6009
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3BZhQDdu8lv/UaMuxQISwrT2QynRUU5pv0ciyffg46sShPb1+gmcHsMEinY/QrebyL3pGr4oBB+lfiKsSRxLrPGl6MrKnaWMY4vrHb9kgfj87gzySgkBJzEHCdvAT4m3UsZg+ob2FVDO/f3C409J8kMbLlNakLBkE3zlnZeWmPyhrzMsp3RW/MUkitnzOxOKbTQKW20uxOH9w5fjHr+qNpkngxV3IcFTBz6ewQQNPvAf9wxx3oYLWDsE6d7lkLSb8OhXqBk/1oZjshBDgEDqIQ96h6hIQpJU1Oh5zIfII+AaqwA5vrGWfjrwAzlNoTvYhxkGjyUpFQcTM4/bcPrq8BOc0JPkchCvyzXBQ1MjOaOrJyPBmSvjYd7KWAABcKUYzo43h7CzLmIauJTrBQEIc01rp83c2OUPVXoKmATMeGLXZbF6xDXVgVrth7FFx2oAkWNf2n6mFeSAFtRaplNdSTd+JBpHcheE97nXyoTNeiezw10SgLY48DqPpxXACXioOP2GJ0mbYNfiKMybEbSgjcInR8QkleY0tRVqzSwanOopaZER8DT7LuN8kdCJWFwPrJBJijVTIUd6mzx7MGrdSof2wwpPJ9yQoRRkTIaJnfemHLDX4q4i/RXJ7xKimVgdG5al9lVsBzkmjLIRU5uSVL1s1BdyhpqvBR6M9l9JYwngZ6r/Uf+x1Dcqcdgju8FEKnr7xHvxfqofFKmXTCw4gQbvWx9gXSCbVZ/W5+6ZDCJNe0PdFurk/h75Pcecety9UF9qW0F5iZt9c8o6mVOeGROQgVZT14kwt2h0s1QMN9PWKrvKIqjgiLpSJJj0r7uZ3YYt41LaUvBw6Pe10uktwA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(316002)(9686003)(47076005)(110136005)(36860700001)(54906003)(4326008)(83380400001)(356005)(8676002)(70206006)(70586007)(55016003)(82310400004)(81166007)(63350400001)(33656002)(84970400001)(6506007)(53546011)(8936002)(52536014)(966005)(508600001)(63370400001)(86362001)(26005)(186003)(2906002)(336012)(30864003)(5660300002)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 10:47:23.5914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3396004-9d36-4bf0-bf95-08d9dccb6856
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT062.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6636
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

> -----Original Message-----
> From: Gcc-patches <gcc-patches-
> bounces+kyrylo.tkachov=3Darm.com@gcc.gnu.org> On Behalf Of Ard
> Biesheuvel via Gcc-patches
> Sent: Wednesday, January 19, 2022 5:44 PM
> To: linux-hardening@vger.kernel.org
> Cc: Richard Earnshaw <Richard.Earnshaw@arm.com>; Richard Sandiford
> <Richard.Sandiford@arm.com>; thomas.preudhomme@celest.fr; Keith
> Packard <keithpac@amazon.com>; gcc-patches@gcc.gnu.org; Kyrylo Tkachov
> <kyryo.tkachov@arm.com>; Ard Biesheuvel <ardb@kernel.org>
> Subject: [PATCH v6 1/1] [ARM] Add support for TLS register based stack
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
> 2022-01-19 Ard Biesheuvel <ardb@kernel.org>
>=20
> 	* config/arm/arm-opts.h (enum stack_protector_guard): New
> 	* config/arm/arm-protos.h (arm_stack_protect_tls_canary_mem):
> 	New
> 	* config/arm/arm.cc (TARGET_STACK_PROTECT_GUARD): Define
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
> gcc/testsuite/ChangeLog:
>=20
> 	* gcc.target/arm/stack-protector-7.c: New test.
> 	* gcc.target/arm/stack-protector-8.c: New test.
>=20
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Thanks. One final bit. Given that you're using the Signed-off-by tag this m=
eans that you're contributing this patch under the DCO rules.
Can you please confirm that you intend to contribute this patch under the r=
ules in https://gcc.gnu.org/dco.html
If you're happy with that I'll push the patch for you.
Thanks,
Kyrill

> ---
>  gcc/config/arm/arm-opts.h                        |  6 ++
>  gcc/config/arm/arm-protos.h                      |  2 +
>  gcc/config/arm/arm.cc                            | 55 +++++++++++++++
>  gcc/config/arm/arm.md                            | 71 ++++++++++++++++++=
+-
>  gcc/config/arm/arm.opt                           | 22 ++++++
>  gcc/doc/invoke.texi                              | 11 +++
>  gcc/testsuite/gcc.target/arm/stack-protector-7.c | 12 ++++
>  gcc/testsuite/gcc.target/arm/stack-protector-8.c |  7 ++
>  8 files changed, 184 insertions(+), 2 deletions(-)
>=20
> diff --git a/gcc/config/arm/arm-opts.h b/gcc/config/arm/arm-opts.h
> index c50d5e56a181..24d12fafdec8 100644
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
> index cd55a9f6ca54..881c72c988bd 100644
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
> diff --git a/gcc/config/arm/arm.cc b/gcc/config/arm/arm.cc
> index 7825e364c01e..c192894ff33e 100644
> --- a/gcc/config/arm/arm.cc
> +++ b/gcc/config/arm/arm.cc
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
> @@ -3176,6 +3179,26 @@ arm_option_override_internal (struct
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
> +
>  #ifdef SUBTARGET_OVERRIDE_INTERNAL_OPTIONS
>    SUBTARGET_OVERRIDE_INTERNAL_OPTIONS;
>  #endif
> @@ -3843,6 +3866,9 @@ arm_option_reconfigure_globals (void)
>        else
>  	target_thread_pointer =3D TP_SOFT;
>      }
> +
> +  if (!TARGET_HARD_TP && arm_stack_protector_guard =3D=3D SSP_TLSREG)
> +    error("%'-mstack-protector-guard=3Dtls%' needs a hardware TLS regist=
er");
>  }
>=20
>  /* Perform some validation between the desired architecture and the rest=
 of
> the
> @@ -8108,6 +8134,23 @@ legitimize_pic_address (rtx orig, machine_mode
> mode, rtx reg, rtx pic_reg,
>  }
>=20
>=20
> +/* Generate insns that produce the address of the stack canary */
> +rtx
> +arm_stack_protect_tls_canary_mem (bool reload)
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
> +  return gen_rtx_MEM (SImode, reg);
> +}
> +
> +
>  /* Whether a register is callee saved or not.  This is necessary because=
 high
>     registers are marked as caller saved when optimizing for size on Thum=
b-1
>     targets despite being callee saved in order to avoid using them.  */
> @@ -34075,6 +34118,18 @@ arm_run_selftests (void)
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
> index 90756fbfa3af..60468f6182c3 100644
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
> +   (set_attr "conds" "unconditional")
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
> +	(unspec_volatile:SI [(const_int 0)] VUNSPEC_MRC))]
> +  "TARGET_HARD_TP"
> +  "mrc\\tp15, 0, %0, c13, c0, 3\\t@ reload_tp_hard"
> +  [(set_attr "type" "mrs")]
> +)
> +
>  ;; Doesn't clobber R1-R3.  Must use r0 for the first operand.
>  (define_insn "load_tp_soft_fdpic"
>    [(set (reg:SI 0) (unspec:SI [(const_int 0)] UNSPEC_TLS))
> diff --git a/gcc/config/arm/arm.opt b/gcc/config/arm/arm.opt
> index 587fc932f969..e342a0df4def 100644
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
> +
> +TargetVariable
> +long arm_stack_protector_guard_offset =3D 0
> diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
> index 58751c48b8e9..e7c9400c0ccd 100644
> --- a/gcc/doc/invoke.texi
> +++ b/gcc/doc/invoke.texi
> @@ -821,6 +821,7 @@ Objective-C and Objective-C++ Dialects}.
>  -mpure-code @gol
>  -mcmse @gol
>  -mfix-cmse-cve-2021-35465 @gol
> +-mstack-protector-guard=3D@var{guard} -mstack-protector-guard-
> offset=3D@var{offset} @gol
>  -mfdpic}
>=20
>  @emph{AVR Options}
> @@ -21355,6 +21356,16 @@ enabled by default when the option @option{-
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
> +canary accessible via the TLS register. The option
> +@option{-mstack-protector-guard-offset=3D} is for use with
> +@option{-fstack-protector-guard=3Dtls} and not for use in user-land code=
.
> +
>  @item -mfdpic
>  @itemx -mno-fdpic
>  @opindex mfdpic
> diff --git a/gcc/testsuite/gcc.target/arm/stack-protector-7.c
> b/gcc/testsuite/gcc.target/arm/stack-protector-7.c
> new file mode 100644
> index 000000000000..2173bc5a35a0
> --- /dev/null
> +++ b/gcc/testsuite/gcc.target/arm/stack-protector-7.c
> @@ -0,0 +1,12 @@
> +/* { dg-require-effective-target arm_hard_vfp_ok }  */
> +/* { dg-require-effective-target arm_arch_v7a_ok } */
> +/* { dg-do compile } */
> +/* { dg-options "-march=3Darmv7-a -mfpu=3Dvfp -fstack-protector-all -Os =
-
> mstack-protector-guard=3Dtls -mstack-protector-guard-offset=3D1296 -mtp=
=3Dcp15"
> } */
> +
> +#include "stack-protector-5.c"
> +
> +/* See the comment in stack-protector-5.c.  */
> +/* { dg-final { scan-assembler-times {\tstr\t} 1 } } */
> +/* Expect two TLS register accesses and two occurrences of the offset */
> +/* { dg-final { scan-assembler-times {\tmrc\t} 2 } } */
> +/* { dg-final { scan-assembler-times {1296} 2 } } */
> diff --git a/gcc/testsuite/gcc.target/arm/stack-protector-8.c
> b/gcc/testsuite/gcc.target/arm/stack-protector-8.c
> new file mode 100644
> index 000000000000..ea5ef3211678
> --- /dev/null
> +++ b/gcc/testsuite/gcc.target/arm/stack-protector-8.c
> @@ -0,0 +1,7 @@
> +/* { dg-require-effective-target arm_hard_vfp_ok }  */
> +/* { dg-require-effective-target arm_arch_v7a_ok } */
> +/* { dg-do compile } */
> +/* { dg-error "needs a hardware TLS register" "missing error when using =
TLS
> stack protector without hardware TLS register" { target *-*-* } 0 } */
> +/* { dg-options "-fstack-protector-all -Os -mstack-protector-guard=3Dtls=
 -
> mtp=3Dsoft" } */
> +
> +int foo;
> --
> 2.30.2

