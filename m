Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB66C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 19 Jan 2022 16:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243524AbiASQyn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 19 Jan 2022 11:54:43 -0500
Received: from mail-db8eur05on2065.outbound.protection.outlook.com ([40.107.20.65]:39336
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1356236AbiASQyi (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 19 Jan 2022 11:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9S1515fp81q+Y1k82mrwpdiyk0Oi5cLPMzm2uWV2Yck=;
 b=ycl0OJraQ088Pq8XJT4FkRra/o5eL0CPuznEdRhRJX1iR2AXc7RtxD0Pmdayd9d+Nmd26yNBWidJfN2+5lQt+IvbMS9jAEdH4p3Y0HqM/vGC+TLXcp7224G7Wwf/xKhwmD7tsKtiYVzSs/YauGWXc96M75onNf6IEzikLsfsLKE=
Received: from AS9PR06CA0053.eurprd06.prod.outlook.com (2603:10a6:20b:463::15)
 by VE1PR08MB5663.eurprd08.prod.outlook.com (2603:10a6:800:1a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 19 Jan
 2022 16:54:34 +0000
Received: from VE1EUR03FT063.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:463:cafe::4) by AS9PR06CA0053.outlook.office365.com
 (2603:10a6:20b:463::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Wed, 19 Jan 2022 16:54:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT063.mail.protection.outlook.com (10.152.18.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 16:54:34 +0000
Received: ("Tessian outbound 63bb5eb69ee8:v113"); Wed, 19 Jan 2022 16:54:33 +0000
X-CR-MTA-TID: 64aa7808
Received: from 2fb58d0beae7.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 52A5CE42-813A-4D10-ADEC-1B3955988631.1;
        Wed, 19 Jan 2022 16:54:25 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 2fb58d0beae7.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 19 Jan 2022 16:54:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8BL7wQSXwNm30l2h5Cz+HAkT18IJrh6bkSjkxbeY1fihXLIB9aVMWdzDRDkZeKhCaZvZhLAlYzhBz4g035zraORpkEeQqTgK7SThiEGquR7Ivn15h0pLiyr8aCy14PaDuKm3SYEPp371dSa47hArFJcwlNOm0aERA5ZGoxGhfo15KHsi39Ojp5aByQHVR9+hD2W4ndU2sWhskAQCKZ42OEdvCXOfZ9WgWk8brMdWyC8jRfzSw8BO8L3WC0AqyLmVPd4cyjO8tY5kaeWXpvwU7ioqA8F5gBsG4l5GXFAExjaxqCDT9hQU/iatthaFlFxrpGT5VQIJujhtongHRzc7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9S1515fp81q+Y1k82mrwpdiyk0Oi5cLPMzm2uWV2Yck=;
 b=a7+knQ+SZ5W4wcpJoRtgqrkTGnzhlmnwk5Am5SC5T630T7mP+PhyEuRsTGytf7rWADSlpd6MLGBU1iefPRzQAQI/wlFRjX76TewveWFZkRx7zFT+wqAvY26VgxXyEG9X1eHHzWfN/oEuu8sXyNfh8cixdIsQui6k0aohCyEeYDmCvPLLVGiIBZDFv+EzQNEBCYsy2sDdpbiWMAC9+FYt/To9u/CTZtSKNDDuNQyCH63XnbI5X/gcTP7mkV1BZJV2KXA8dL2CLvkkuFHI+TwwR275xvfxUMR2zC6rTCzA9tzKMoxz3RQZ/eB8zg9zwQLikIF/1kak9dp7TnvNT1LIow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9S1515fp81q+Y1k82mrwpdiyk0Oi5cLPMzm2uWV2Yck=;
 b=ycl0OJraQ088Pq8XJT4FkRra/o5eL0CPuznEdRhRJX1iR2AXc7RtxD0Pmdayd9d+Nmd26yNBWidJfN2+5lQt+IvbMS9jAEdH4p3Y0HqM/vGC+TLXcp7224G7Wwf/xKhwmD7tsKtiYVzSs/YauGWXc96M75onNf6IEzikLsfsLKE=
Received: from PAXPR08MB6926.eurprd08.prod.outlook.com (2603:10a6:102:138::24)
 by AM8PR08MB5811.eurprd08.prod.outlook.com (2603:10a6:20b:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 19 Jan
 2022 16:54:20 +0000
Received: from PAXPR08MB6926.eurprd08.prod.outlook.com
 ([fe80::69:f417:b4df:c313]) by PAXPR08MB6926.eurprd08.prod.outlook.com
 ([fe80::69:f417:b4df:c313%5]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 16:54:19 +0000
From:   Kyrylo Tkachov <Kyrylo.Tkachov@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
CC:     Richard Sandiford <Richard.Sandiford@arm.com>,
        "thomas.preudhomme@celest.fr" <thomas.preudhomme@celest.fr>,
        Keith Packard <keithpac@amazon.com>,
        Kyrylo Tkachov <kyryo.tkachov@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>
Subject: RE: [PATCH v5 1/1] [ARM] Add support for TLS register based stack
 protector canary access
Thread-Topic: [PATCH v5 1/1] [ARM] Add support for TLS register based stack
 protector canary access
Thread-Index: AQHX2kuGMUD7whG3aUqzPNI4TN02lqxq8mFA
Date:   Wed, 19 Jan 2022 16:54:19 +0000
Message-ID: <PAXPR08MB6926FE903EA44E733D82CE6493599@PAXPR08MB6926.eurprd08.prod.outlook.com>
References: <20211115180410.5272-1-ardb@kernel.org>
 <20211115180410.5272-2-ardb@kernel.org>
In-Reply-To: <20211115180410.5272-2-ardb@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 4A8BA74E57ABBF48A6714D56EF2AA2A1.0
x-checkrecipientchecked: true
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: c31c2814-0c73-406f-8683-08d9db6c5ebd
x-ms-traffictypediagnostic: AM8PR08MB5811:EE_|VE1EUR03FT063:EE_|VE1PR08MB5663:EE_
X-Microsoft-Antispam-PRVS: <VE1PR08MB5663162231EF16BA44FCA22B93599@VE1PR08MB5663.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: D45Esvmcr8CTT05ALD29J4nkHj/5MCZxf9lYACxbg6BGhc06oN7l7Xxhoi08rCSxNQn6vEXL+pLRwIF0vwNv76Xp2iIkvG/MxoGlxQ6zqlLxVq3IOprXiR7WWvJwdkaZ//sl8eXVcj9HZuOq+AAjhBNRn3O4ROW9jrVrMIRgJOPQrXrXrJ75GzvTo2uY6k3GhyUCjLsa/8gZvPf+e8c2Rixfvgg1CugMG3Ltxqn0Wc5XmLgZMLdP/zmko40HpWxTgnaIXLkA1huOsS5bpMPMvYXjMdeG1DLbuMYwHXQ2x0+rJwHRRZLKuOFAdkij0gKX7/D9lPquA/2TB+/bdEBYoF9L5EXCdxwC6pOvZl0f+QcF8UxAO8P3idzVBoFtUvne8xsezWMV4Tan9JRZZxRSp/Jih6EGbZxOP8BUXkivlRVqNXIE36EziJQF7zeFamqKKlmITh+Mp8StbObcp2kzaHBXuzeYdmb4VT+IILqiNvPbD3t/cE5cIlLuru/eaG3rCWacUnJN2UtCyoOjdE/SP59QLO5DMpPxtuG10MRoUrSJ7yscRCC6waRpM/PKpGce4FKFBWZ2pFV5j6THqriOkIOdTT4JC1FQRJt1NH8WfaXb8cr7F84YVsThTDa3/yM1OPVqcsuLV+RsrQHnQxlOrbkzFiobf64P+7Bk1rA/bVVHMK2LoJ3FFifgq4rp6OqXJ3diyZ2KBidEUZApJfmjl6KvHaW1VL2ZsH6srz5z+33khFyyyGq3xsPTeqxROp5OjrHEFiqZTNdsgaiauEHDjJOndxJu2fatxHgeFBOWIHfUckniERLod+JJT4ENTVCl5T1ihhqhT3nI6q9w45rMog==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6926.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(4001150100001)(71200400001)(66556008)(64756008)(66446008)(66476007)(8936002)(9686003)(66946007)(76116006)(2906002)(33656002)(316002)(186003)(30864003)(84970400001)(5660300002)(4326008)(86362001)(26005)(52536014)(38070700005)(54906003)(55236004)(53546011)(6506007)(38100700002)(122000001)(508600001)(83380400001)(110136005)(7696005)(55016003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5811
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT063.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: bf00c43e-16a2-4c24-23aa-08d9db6c55fa
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZmHu3vd1eIq1ZSOrkRfAP8EsnkQYLaGWxyXZ+IETjlEGYvuTYMkFrfOLxtjp3TSNEPKbFvzV1a5H6yNeAwBIpeyLuLkb3EajGYQGGP/VbxChPyudec8VVheslPkZEqc9ln2+JF3hPb8MmWCHobeMrqVMvN4ks/Y3hjoWzM0XkR45NyQHw1krBF8ANloI3z1QfkCIK0nnzlDzv0nkw5ultdQwcsw0ZT4sO6meAonf88iMm8SOu+dgD33NiRq0YO11qKh5uBD1E9kVMxOLQqBotA/KgShHY195QX0W69bPf0Qw8pIfLs9m6sP6nQEuJzKdIpy9L4krtqHg7k1y/M34v+t38Fc0PXkA8tQ67QYQteyrozFeUDX5QUEqTUJXKpjUZE15lKZcvkjXAR1Lihzr6QhaekirQpGW/TjpTG29S5mr4AOYfsjNTL++IUN7b5b4oBz/RWekVSvwwfZPDMj7RUVuk7DViAaX3PQSOsM+X+WnOrQ7rfxTABjCd81XilbJGWnn4YnUYUUH2fbMrj6rLc19zX30gaFqbdnQ4Psyv0k30ohdkT0eDnX2WQ/RdI2fdGjhod2i0SWDUBtHWPc1Qi7dTolWrWu2XhXxr/X4Y0ysQxQuqrWc0WZ2lKTAFV82az2KTfVUutntAtw5PJhMo07xv/Y/pUy6m9begJQSUb2BRL3ZxkCorZZmWO/HSietELnMn6awcPfSSHSDjFTA6zUmmOcEG6IjR+t1RI5HxxtMWo8gEZ0TzUC+guxCkDfGqnWGqY4S/NN1gfcTW/WZA9Gp6ypDH1eN4kwvTpoasw6PuVQn0nawvw1uWVZls9T1B112kJxZiZ1goASNeQ5leA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(6506007)(53546011)(30864003)(81166007)(7696005)(4326008)(33656002)(4001150100001)(2906002)(86362001)(36860700001)(9686003)(316002)(54906003)(110136005)(47076005)(508600001)(70206006)(70586007)(82310400004)(356005)(8676002)(8936002)(26005)(84970400001)(52536014)(5660300002)(336012)(83380400001)(55016003)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 16:54:34.0659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c31c2814-0c73-406f-8683-08d9db6c5ebd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT063.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5663
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Ard,

> -----Original Message-----
> From: Gcc-patches <gcc-patches-
> bounces+kyrylo.tkachov=3Darm.com@gcc.gnu.org> On Behalf Of Ard
> Biesheuvel via Gcc-patches
> Sent: Monday, November 15, 2021 6:04 PM
> To: linux-hardening@vger.kernel.org
> Cc: Richard Sandiford <Richard.Sandiford@arm.com>;
> thomas.preudhomme@celest.fr; Keith Packard <keithpac@amazon.com>;
> gcc-patches@gcc.gnu.org; Kyrylo Tkachov <kyryo.tkachov@arm.com>; Ard
> Biesheuvel <ardb@kernel.org>
> Subject: [PATCH v5 1/1] [ARM] Add support for TLS register based stack
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

I've tested this patch on an arm-none-linux-gnueabihf target and the result=
s look clean.
Have you tested this patch with a kernel build as well? (since the function=
ality is intended for that use).
If so, the patch is okay but please rebase it and repost so that we can com=
mit it taking into account....

>=20
> 2021-11-15 Ard Biesheuvel <ardb@kernel.org>
>=20
> 	* config/arm/arm-opts.h (enum stack_protector_guard): New
> 	* config/arm/arm-protos.h (arm_stack_protect_tls_canary_mem):
> 	New
> 	* config/arm/arm.c (TARGET_STACK_PROTECT_GUARD): Define

... this file has now be renamed to arm.cc and...

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
> ---
>  gcc/config/arm/arm-opts.h                        |  6 ++
>  gcc/config/arm/arm-protos.h                      |  2 +
>  gcc/config/arm/arm.c                             | 55 +++++++++++++++
>  gcc/config/arm/arm.md                            | 71 ++++++++++++++++++=
+-
>  gcc/config/arm/arm.opt                           | 22 ++++++
>  gcc/doc/invoke.texi                              | 11 +++
>  gcc/testsuite/gcc.target/arm/stack-protector-7.c | 10 +++
>  gcc/testsuite/gcc.target/arm/stack-protector-8.c |  5 ++
>  8 files changed, 180 insertions(+), 2 deletions(-)
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
> index a5b403eb3e49..e5077348ce07 100644
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
> index 4adc976b8b67..45a54d63f5b3 100644
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
> +
> +TargetVariable
> +long arm_stack_protector_guard_offset =3D 0
> diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
> index 6070288856c0..13bebbcbf0fb 100644
> --- a/gcc/doc/invoke.texi
> +++ b/gcc/doc/invoke.texi
> @@ -816,6 +816,7 @@ Objective-C and Objective-C++ Dialects}.
>  -mpure-code @gol
>  -mcmse @gol
>  -mfix-cmse-cve-2021-35465 @gol
> +-mstack-protector-guard=3D@var{guard} -mstack-protector-guard-
> offset=3D@var{offset} @gol
>  -mfdpic}
>=20
>  @emph{AVR Options}
> @@ -21099,6 +21100,16 @@ enabled by default when the option @option{-
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
> index 000000000000..874648060d8d
> --- /dev/null
> +++ b/gcc/testsuite/gcc.target/arm/stack-protector-7.c
> @@ -0,0 +1,10 @@
> +/* { dg-do compile } */
> +/* { dg-options "-march=3Darmv7-a -mfpu=3Dvfp -fstack-protector-all -Os =
-
> mstack-protector-guard=3Dtls -mstack-protector-guard-offset=3D1296 -mtp=
=3Dcp15"
> } */

... These dg-options can cause fails when the test is run with undesirable =
multilib options.
These tests should have a guard something like before the dg-options
/* { dg-require-effective-target arm_hard_vfp_ok }  */
/* { dg-require-effective-target arm_arch_v7a_ok } */

Thanks,
Kyrill

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
> index 000000000000..bcb2f6b82bdf
> --- /dev/null
> +++ b/gcc/testsuite/gcc.target/arm/stack-protector-8.c
> @@ -0,0 +1,5 @@
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

