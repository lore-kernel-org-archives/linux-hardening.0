Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB2FC433EF
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 13:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64BF2610A0
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 13:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhKBNHK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 2 Nov 2021 09:07:10 -0400
Received: from mail-eopbgr00068.outbound.protection.outlook.com ([40.107.0.68]:33347
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231176AbhKBNHJ (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 2 Nov 2021 09:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eh/ILFuNvz1p7SNxtxytEPWbgjZ/8c2EAbcRlkS5Y3w=;
 b=1MdgN07+/gG6Qr2xXIopcFTCsrLNjag+JLrb6dSEqzCVumgpxc4FpKcBiFVnFKlOyG7EnuccEXGsm01WylkLYFE9HUkG6TICVs7Pb6EdeeMq1gVchmcI30Jw2Udim0CPlIup355XvVfn42rXx1AHXRLj1ZsMQ4JNbAr4eHJk3/w=
Received: from DU2P251CA0017.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::16)
 by DB6PR0801MB1688.eurprd08.prod.outlook.com (2603:10a6:4:3a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.18; Tue, 2 Nov
 2021 13:04:32 +0000
Received: from DB5EUR03FT041.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:230:cafe::18) by DU2P251CA0017.outlook.office365.com
 (2603:10a6:10:230::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Tue, 2 Nov 2021 13:04:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT041.mail.protection.outlook.com (10.152.21.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.14 via Frontend Transport; Tue, 2 Nov 2021 13:04:32 +0000
Received: ("Tessian outbound 7129402754f2:v108"); Tue, 02 Nov 2021 13:04:32 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 80c253363ea0b186
X-CR-MTA-TID: 64aa7808
Received: from 5a0e1f992dfb.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 74C76405-B3B2-4DB2-8394-555AFDA622D2.1;
        Tue, 02 Nov 2021 13:04:25 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5a0e1f992dfb.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 02 Nov 2021 13:04:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xz5wY3zAU8Hf5DSIxQ2n0j4As0T+eqJGHujl9ugqCy1AAFfgudO1XrWeaCXD1IOv5l+Dlb0ObLPB/MpMcXmOed+Af0jGftcYQIDStDpYVtqkpyn1t6o1zonrub3Fie1DvZn4tcTBysRITU+5hHhOJ+bP0fAuh/81ahrLC8kTizmO7iK5dWc/vG++adHa56+9MKp3euml1Q+SbZoVx4xWx8l5RcRYuxvFD3jiQFQEkPmfe84amgCv2at+bSsp+5GsLgXerO5bAB7MfJiQqICJ+bBHJX1EbSUVAvAaSg55sQCkfyHdWt3MTZLYzuerYKxbNVAKoIfPweG/W0MSvzk7dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eh/ILFuNvz1p7SNxtxytEPWbgjZ/8c2EAbcRlkS5Y3w=;
 b=gPrPBbCo0X3ruZmsMblTRQlEhlam2qCkzt0R9QvYpB37LSvHrFjnehMy+Iis+ggulEF5CL8fdZPuiJNgJKM+gezUZiQO8b/PQj5Sdx2xxPuw2U90HlhuAnkBBooV4qXrmu5uP5XrIK4934eQGKIU1wANkZwJSPXbUSmRyq4hIkGTJJ7IGno3e+x0kQ3JfMF7bVnDvM7IdsPTn1nUB93y6FZV6ithk3PoJjbDxB+dXzRuLoVLICrWYPzDR5szFWirOIUIcS/1SIRVvFHEzVCHT9EPcSJoZzeTvXVpqEjzL+wgfFSTVaW/a4FQKEZqzctcdoRjSQ2+arhXX8rYrBuhjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eh/ILFuNvz1p7SNxtxytEPWbgjZ/8c2EAbcRlkS5Y3w=;
 b=1MdgN07+/gG6Qr2xXIopcFTCsrLNjag+JLrb6dSEqzCVumgpxc4FpKcBiFVnFKlOyG7EnuccEXGsm01WylkLYFE9HUkG6TICVs7Pb6EdeeMq1gVchmcI30Jw2Udim0CPlIup355XvVfn42rXx1AHXRLj1ZsMQ4JNbAr4eHJk3/w=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by DU2PR08MB7272.eurprd08.prod.outlook.com (2603:10a6:10:2d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 13:04:15 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::3540:178b:3f0b:4d9e]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::3540:178b:3f0b:4d9e%3]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 13:04:15 +0000
Date:   Tue, 2 Nov 2021 13:04:13 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] [RFC][PR102768] aarch64: Add compiler support for Shadow
 Call Stack
Message-ID: <20211102130413.GS1982710@arm.com>
References: <20211102070616.119780-1-ashimida@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211102070616.119780-1-ashimida@linux.alibaba.com>
X-ClientProxiedBy: LO2P265CA0142.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::34) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
Received: from arm.com (217.140.106.52) by LO2P265CA0142.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9f::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Tue, 2 Nov 2021 13:04:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98019504-6284-40be-e82c-08d99e014fe2
X-MS-TrafficTypeDiagnostic: DU2PR08MB7272:|DB6PR0801MB1688:
X-Microsoft-Antispam-PRVS: <DB6PR0801MB16886B50DDE438A9DF2CE8C8ED8B9@DB6PR0801MB1688.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: n7UlxqTzwzvdrz59FpcDsyy+ds73HeQUzfh6ahpzuMGaDSsIC/R9mDLyhgfKnwfGy4iK4IJ1iMsAl546mLUl6LhA4b8LKaVv2qIEgERK5Q95AWIlE6q5A/xmF6jB3boHzIjOC/wZZQs6U/oJzC7Ev0XrUV0UcGb05IDxPXofXhEfgFzEOzlEyh/vnQhbT4vvqTrEmdqi9JeWk4TW5xgu1LxOTPhi0+2g/UnWn7x/ug8HIHNw67ku/hbSazRnLbKuf0dwy7cmO6bY+Jb4A8qLZwFwJunt3A1wr8GSrPIDZGtrskvCN/FpL8VDkuz3F9jXV31OGijtHv7ZIHtSVJdn9gxR0fyz8w1Ce5qnMkagPnD3VPBJHJaMOHmRnW++X7hZt9eOOXKsK4mxdpvCGqibkAR074IwVR9i1X2ME6BitkdkO+3tKQtiBqo7MdfPUp7DjQPILhT0yCOX4761A2HZ+rhQJ4WRlJPY5pCHB8S3lQRem/9laui0F4WRCGQhWi39cCvXCVR0x/TDNgHV7BJd6TxOsPfY0HC4JhvFkuJVIdEk1XKK3ktfSYkPAViwN8n4EI9SNNu2xzxpcPJ+ckwhUymDgi4oYc7yIURL6O30JVlJGW6if5zQKNStNPmExM9vDI6FLiGGxK6wrBXnMuBGU44bmXBmOx3YjUBPIqqtPVmQXpzztWs7OxIX7ADbLWJ3zHdYbITEdO7DLX542XBv+xUy+1o+U45y9cVZWxpX4u4TzFGz143vWZ+sZpUGIu7hkr2BKG+bnR1+ltBXfqLFKhl6E0ofSTNlIOCkodBw7NJnmuByL8VjJU2F3NDSiRlX
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(44832011)(26005)(316002)(1076003)(6916009)(956004)(5660300002)(186003)(2616005)(83380400001)(8936002)(36756003)(8676002)(33656002)(38350700002)(38100700002)(55016002)(4326008)(30864003)(66946007)(7696005)(66556008)(66476007)(8886007)(86362001)(52116002)(508600001)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB7272
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT041.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 59d50b3a-9e70-4224-87a1-08d99e014597
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +/ALWm1ogw3hsjuFolpnoX142iWHubcNPNOqKRZ+0xY45MFcyDhz19phih+OD0WuOOPLAVKNtTCqo2S1iQtM15ubUXmNWdkwTpU02l8UaSbQ00MdSoJjAk1Iic6WdpZPXr5tTQU0pDDI7Xa7+KrRJ0+AaTjwocaVwtlglL09SsiZ1HqsGlI/7JJ85bM4FIdHYhc/E7aSyg5dWC3Pbr9BH0BlJDewCQIdSOkU4Sr32jsWVEB63ap4p45rHUrNlp30gNZz0TrfoMtjkNArO+CFKmErdft7J6jEx71rQD+zhn+Yj4rwQOdQQ54MDt0SjiI+lZyCIEblX2c7fVxjAZE14CE4g50u/Jud2kqtLs5fv28nzOnmtLOaLbe4SBQzQT+blTUEwtsVSYeYS2XfCBur8Jwj79ZFxfSsZgTgQiUKhIzI+jqPGegR8Ek8k+lpML0xkd+InD2OYkU6HDPjTwlGHvhqmKvhcHGs1j2k8fuwN7YDNpWMxbIWvukdiJxkU3KU5ruXex7wcMPoKYgv2fkVr7uTIQpuPxFQXcNAVWVuGNcf75rZ3E535xxfkcGfZKliH29LRqFDVwLfidV9yi48Rfs8z0d/Sw3V8zx13Fu061iQ+PhBfUa06L4t/3+6h3WM2K4Fr8jsMXzedDDjCKRDefggTxNNyx1sFiXBtMt6O2rzPID/eZCGQokQVJTM268lcAy2/t9S5uo2k3qtU3yh78q1PoMCYl2W5uvSybueP42jmoIj/eDThhBZClHxFWrPTyIs61LlNxWfALL1/QzUPX10PQoEHXWsHeSvPxJTL+0ci+6dmrWQ9nLkNThp16Oy8Z4cEzozMXOh6dJHCwyPcQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(966005)(83380400001)(26005)(33656002)(82310400003)(1076003)(81166007)(316002)(356005)(6862004)(508600001)(55016002)(8886007)(186003)(36860700001)(47076005)(8676002)(4326008)(30864003)(2906002)(5660300002)(8936002)(7696005)(70206006)(44832011)(336012)(956004)(2616005)(36756003)(70586007)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 13:04:32.1972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98019504-6284-40be-e82c-08d99e014fe2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT041.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1688
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The 11/02/2021 00:06, Dan Li via Gcc-patches wrote:
> Shadow Call Stack can be used to protect the return address of a
> function at runtime, and clang already supports this feature[1].
> 
> To enable SCS in user mode, in addition to compiler, other support
> is also required (as described in [2]). This patch only adds basic
> support for SCS from the compiler side, and provides convenience
> for users to enable SCS.
> 
> For linux kernel, only the support of the compiler is required.
> 
> [1] https://clang.llvm.org/docs/ShadowCallStack.html
> [2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102768

i'm not a gcc maintainer, but i prefer such feature
to be in upstream gcc instead of in a plugin.

it will require update to the documentation:

which should mention that it depends on -ffixed-x18
(probably that should be enforced too) which is an
important abi issue: functions following the normal
pcs can clobber x18 and break scs.

and that there is no unwinder support.

the abi issue means it is unlikely to be useful in
linux user space (even if libc and unwinder support
is implemented), but it can be still useful in
freestanding code such as the linux kernel.

thanks.

> 
> gcc/c-family/ChangeLog:
> 
> 	* c-attribs.c (handle_no_sanitize_shadow_call_stack_attribute):
> 
> gcc/ChangeLog:
> 
> 	* config/aarch64/aarch64-protos.h (aarch64_shadow_call_stack_enabled):
> 	* config/aarch64/aarch64.c (aarch64_shadow_call_stack_enabled):
> 	(aarch64_expand_prologue):
> 	(aarch64_expand_epilogue):
> 	* config/aarch64/aarch64.h (TARGET_SUPPORT_SHADOW_CALL_STACK):
> 	* config/aarch64/aarch64.md (scs_push):
> 	(scs_pop):
> 	* defaults.h (TARGET_SUPPORT_SHADOW_CALL_STACK):
> 	* flag-types.h (enum sanitize_code):
> 	* opts.c (finish_options):
> 
> Signed-off-by: Dan Li <ashimida@linux.alibaba.com>
> ---
>  gcc/c-family/c-attribs.c            | 21 +++++++++++++++++++++
>  gcc/config/aarch64/aarch64-protos.h |  1 +
>  gcc/config/aarch64/aarch64.c        | 27 +++++++++++++++++++++++++++
>  gcc/config/aarch64/aarch64.h        |  4 ++++
>  gcc/config/aarch64/aarch64.md       | 18 ++++++++++++++++++
>  gcc/defaults.h                      |  4 ++++
>  gcc/flag-types.h                    |  2 ++
>  gcc/opts.c                          |  6 ++++++
>  8 files changed, 83 insertions(+)
> 
> diff --git a/gcc/c-family/c-attribs.c b/gcc/c-family/c-attribs.c
> index 007b928c54b..9b3a35c06bf 100644
> --- a/gcc/c-family/c-attribs.c
> +++ b/gcc/c-family/c-attribs.c
> @@ -56,6 +56,8 @@ static tree handle_cold_attribute (tree *, tree, tree, int, bool *);
>  static tree handle_no_sanitize_attribute (tree *, tree, tree, int, bool *);
>  static tree handle_no_sanitize_address_attribute (tree *, tree, tree,
>  						  int, bool *);
> +static tree handle_no_sanitize_shadow_call_stack_attribute (tree *, tree,
> +						  tree, int, bool *);
>  static tree handle_no_sanitize_thread_attribute (tree *, tree, tree,
>  						 int, bool *);
>  static tree handle_no_address_safety_analysis_attribute (tree *, tree, tree,
> @@ -454,6 +456,10 @@ const struct attribute_spec c_common_attribute_table[] =
>  			      handle_no_sanitize_attribute, NULL },
>    { "no_sanitize_address",    0, 0, true, false, false, false,
>  			      handle_no_sanitize_address_attribute, NULL },
> +  { "no_sanitize_shadow_call_stack",
> +			      0, 0, true, false, false, false,
> +			      handle_no_sanitize_shadow_call_stack_attribute,
> +			      NULL },
>    { "no_sanitize_thread",     0, 0, true, false, false, false,
>  			      handle_no_sanitize_thread_attribute, NULL },
>    { "no_sanitize_undefined",  0, 0, true, false, false, false,
> @@ -1175,6 +1181,21 @@ handle_no_sanitize_address_attribute (tree *node, tree name, tree, int,
>    return NULL_TREE;
>  }
>  
> +/* Handle a "no_sanitize_shadow_call_stack" attribute; arguments as in
> +   struct attribute_spec.handler.  */
> +static tree
> +handle_no_sanitize_shadow_call_stack_attribute (tree *node, tree name,
> +				      tree, int, bool *no_add_attrs)
> +{
> +  *no_add_attrs = true;
> +  if (TREE_CODE (*node) != FUNCTION_DECL)
> +    warning (OPT_Wattributes, "%qE attribute ignored", name);
> +  else
> +    add_no_sanitize_value (*node, SANITIZE_SHADOW_CALL_STACK);
> +
> +  return NULL_TREE;
> +}
> +
>  /* Handle a "no_sanitize_thread" attribute; arguments as in
>     struct attribute_spec.handler.  */
>  
> diff --git a/gcc/config/aarch64/aarch64-protos.h b/gcc/config/aarch64/aarch64-protos.h
> index 768e8fae136..150c015df21 100644
> --- a/gcc/config/aarch64/aarch64-protos.h
> +++ b/gcc/config/aarch64/aarch64-protos.h
> @@ -893,6 +893,7 @@ void aarch64_register_pragmas (void);
>  void aarch64_relayout_simd_types (void);
>  void aarch64_reset_previous_fndecl (void);
>  bool aarch64_return_address_signing_enabled (void);
> +bool aarch64_shadow_call_stack_enabled (void);
>  bool aarch64_bti_enabled (void);
>  void aarch64_save_restore_target_globals (tree);
>  void aarch64_addti_scratch_regs (rtx, rtx, rtx *,
> diff --git a/gcc/config/aarch64/aarch64.c b/gcc/config/aarch64/aarch64.c
> index 699c105a42a..5a36a459f4e 100644
> --- a/gcc/config/aarch64/aarch64.c
> +++ b/gcc/config/aarch64/aarch64.c
> @@ -79,6 +79,7 @@
>  #include "tree-ssa-loop-niter.h"
>  #include "fractional-cost.h"
>  #include "rtlanal.h"
> +#include "asan.h"
>  
>  /* This file should be included last.  */
>  #include "target-def.h"
> @@ -7799,6 +7800,24 @@ aarch64_return_address_signing_enabled (void)
>  	      && known_ge (cfun->machine->frame.reg_offset[LR_REGNUM], 0)));
>  }
>  
> +/* Return TRUE if shadow call stack should be enabled for the current
> +   function, otherwise return FALSE.  */
> +
> +bool
> +aarch64_shadow_call_stack_enabled (void)
> +{
> +  /* This function should only be called after frame laid out.  */
> +  gcc_assert (cfun->machine->frame.laid_out);
> +
> +  if (crtl->calls_eh_return)
> +    return false;
> +
> +  /* We only deal with a function if its LR is pushed onto stack
> +     and attribute no_sanitize_shadow_call_stack is not specified.  */
> +  return (sanitize_flags_p (SANITIZE_SHADOW_CALL_STACK)
> +	  && known_ge (cfun->machine->frame.reg_offset[LR_REGNUM], 0));
> +}
> +
>  /* Return TRUE if Branch Target Identification Mechanism is enabled.  */
>  bool
>  aarch64_bti_enabled (void)
> @@ -8810,6 +8829,10 @@ aarch64_expand_prologue (void)
>        RTX_FRAME_RELATED_P (insn) = 1;
>      }
>  
> +  /* Push return address to shadow call stack.  */
> +  if (aarch64_shadow_call_stack_enabled ())
> +	emit_insn (gen_scs_push ());
> +
>    if (flag_stack_usage_info)
>      current_function_static_stack_size = constant_lower_bound (frame_size);
>  
> @@ -9066,6 +9089,10 @@ aarch64_expand_epilogue (bool for_sibcall)
>        RTX_FRAME_RELATED_P (insn) = 1;
>      }
>  
> +  /* Pop return address from shadow call stack.  */
> +  if (aarch64_shadow_call_stack_enabled ())
> +	emit_insn (gen_scs_pop ());
> +
>    /* We prefer to emit the combined return/authenticate instruction RETAA,
>       however there are three cases in which we must instead emit an explicit
>       authentication instruction.
> diff --git a/gcc/config/aarch64/aarch64.h b/gcc/config/aarch64/aarch64.h
> index 2792bb29adb..1a83875dec8 100644
> --- a/gcc/config/aarch64/aarch64.h
> +++ b/gcc/config/aarch64/aarch64.h
> @@ -100,6 +100,10 @@
>     generating stack clash probes.  */
>  #define STACK_CLASH_MAX_UNROLL_PAGES 4
>  
> +/* This value represents whether the shadow call stack is implemented on
> +   the target platform.  */
> +#define TARGET_SUPPORT_SHADOW_CALL_STACK true
> +
>  /* The architecture reserves all bits of the address for hardware use,
>     so the vbit must go into the delta field of pointers to member
>     functions.  This is the same config as that in the AArch32
> diff --git a/gcc/config/aarch64/aarch64.md b/gcc/config/aarch64/aarch64.md
> index 1a39470a1fe..8e68a6f793d 100644
> --- a/gcc/config/aarch64/aarch64.md
> +++ b/gcc/config/aarch64/aarch64.md
> @@ -6994,6 +6994,24 @@ (define_insn "xpaclri"
>    "hint\t7 // xpaclri"
>  )
>  
> +;; Save X30 in the X18-based POST_INC stack (consistent with clang).
> +(define_insn "scs_push"
> +  [(set (mem:DI (reg:DI R18_REGNUM)) (reg:DI R30_REGNUM))
> +   (set (reg:DI R18_REGNUM) (plus:DI (reg:DI R18_REGNUM) (const_int 8)))]
> +  ""
> +  "str\\tx30, [x18], #8"
> +  [(set_attr "type" "store_8")]
> +)
> +
> +;; Load X30 form the X18-based PRE_DEC stack (consistent with clang).
> +(define_insn "scs_pop"
> +  [(set (reg:DI R18_REGNUM) (minus:DI (reg:DI R18_REGNUM) (const_int 8)))
> +   (set (reg:DI R30_REGNUM) (mem:DI (reg:DI R18_REGNUM)))]
> +  ""
> +  "ldr\\tx30, [x18, #-8]!"
> +  [(set_attr "type" "load_8")]
> +)
> +
>  ;; UNSPEC_VOLATILE is considered to use and clobber all hard registers and
>  ;; all of memory.  This blocks insns from being moved across this point.
>  
> diff --git a/gcc/defaults.h b/gcc/defaults.h
> index bb68d0d1a79..0f1719a3bb5 100644
> --- a/gcc/defaults.h
> +++ b/gcc/defaults.h
> @@ -1172,6 +1172,10 @@ see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see
>  #define PCC_BITFIELD_TYPE_MATTERS false
>  #endif
>  
> +#ifndef TARGET_SUPPORT_SHADOW_CALL_STACK
> +#define TARGET_SUPPORT_SHADOW_CALL_STACK false
> +#endif
> +
>  #ifndef INSN_SETS_ARE_DELAYED
>  #define INSN_SETS_ARE_DELAYED(INSN) false
>  #endif
> diff --git a/gcc/flag-types.h b/gcc/flag-types.h
> index a5a637160d7..c22ef35a289 100644
> --- a/gcc/flag-types.h
> +++ b/gcc/flag-types.h
> @@ -321,6 +321,8 @@ enum sanitize_code {
>    SANITIZE_HWADDRESS = 1UL << 28,
>    SANITIZE_USER_HWADDRESS = 1UL << 29,
>    SANITIZE_KERNEL_HWADDRESS = 1UL << 30,
> +  /* Shadow Call Stack.  */
> +  SANITIZE_SHADOW_CALL_STACK = 1UL << 31,
>    SANITIZE_SHIFT = SANITIZE_SHIFT_BASE | SANITIZE_SHIFT_EXPONENT,
>    SANITIZE_UNDEFINED = SANITIZE_SHIFT | SANITIZE_DIVIDE | SANITIZE_UNREACHABLE
>  		       | SANITIZE_VLA | SANITIZE_NULL | SANITIZE_RETURN
> diff --git a/gcc/opts.c b/gcc/opts.c
> index 4472cec1b98..e94f316fb85 100644
> --- a/gcc/opts.c
> +++ b/gcc/opts.c
> @@ -1308,6 +1308,11 @@ finish_options (struct gcc_options *opts, struct gcc_options *opts_set,
>      sorry ("transactional memory is not supported with "
>  	   "%<-fsanitize=kernel-address%>");
>  
> +  if ((opts->x_flag_sanitize & SANITIZE_SHADOW_CALL_STACK)
> +      && !TARGET_SUPPORT_SHADOW_CALL_STACK)
> +    error_at (loc, "%<-fsanitize=shadow-call-stack%> not supported "
> +	      "in current platform");
> +
>    /* Currently live patching is not support for LTO.  */
>    if (opts->x_flag_live_patching && opts->x_flag_lto)
>      sorry ("live patching is not supported with LTO");
> @@ -1994,6 +1999,7 @@ const struct sanitizer_opts_s sanitizer_opts[] =
>    SANITIZER_OPT (vptr, SANITIZE_VPTR, true),
>    SANITIZER_OPT (pointer-overflow, SANITIZE_POINTER_OVERFLOW, true),
>    SANITIZER_OPT (builtin, SANITIZE_BUILTIN, true),
> +  SANITIZER_OPT (shadow-call-stack, SANITIZE_SHADOW_CALL_STACK, false),
>    SANITIZER_OPT (all, ~0U, true),
>  #undef SANITIZER_OPT
>    { NULL, 0U, 0UL, false }
> -- 
> 2.17.1
> 
