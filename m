Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DD7C433F5
	for <linux-hardening@archiver.kernel.org>; Wed,  3 Nov 2021 12:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55CD561051
	for <linux-hardening@archiver.kernel.org>; Wed,  3 Nov 2021 12:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhKCMDr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 3 Nov 2021 08:03:47 -0400
Received: from mail-am6eur05on2085.outbound.protection.outlook.com ([40.107.22.85]:35424
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230304AbhKCMDq (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 3 Nov 2021 08:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rHGSgK/ooSMreFeFmzAfiuBeuUIM7LJUUIgNznFeAI=;
 b=LkXvl8ggskmSoe/JYUEIGhp62kJOmlwqrpxnYnYeQyFiGA2oOxBHT5uVVD24yj6iT3SDNy8Xtroz7NKnp8AHNx5h1MIv+jehs/NGsHS6YuyTw9iVgKfuILIqd3+hY1iPoLoHXXEOTCpKbrAzB3kHX2PrRdBwAP4gYhcvpEuA+5Q=
Received: from AS8PR04CA0109.eurprd04.prod.outlook.com (2603:10a6:20b:31e::24)
 by AM6PR08MB3303.eurprd08.prod.outlook.com (2603:10a6:209:40::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Wed, 3 Nov
 2021 12:01:07 +0000
Received: from AM5EUR03FT055.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:31e:cafe::91) by AS8PR04CA0109.outlook.office365.com
 (2603:10a6:20b:31e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Wed, 3 Nov 2021 12:01:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT055.mail.protection.outlook.com (10.152.17.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.14 via Frontend Transport; Wed, 3 Nov 2021 12:01:06 +0000
Received: ("Tessian outbound 7b0bcc4a550a:v108"); Wed, 03 Nov 2021 12:01:06 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e3821f2e90e209e0
X-CR-MTA-TID: 64aa7808
Received: from d65a494aedbd.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 08AE44E7-4C8C-4BC7-8B1D-3FD45A113D58.1;
        Wed, 03 Nov 2021 12:00:57 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d65a494aedbd.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 03 Nov 2021 12:00:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUI5kE3AGDO1Z6VW9Rq1kYeMH5VjCba4ixaoxVI6yfXVmHZfrQpcmqQhqPKCtF6smd5PHrl5qBXF1pDbjiC2Rdkox1Q89OFyCb0r5Zk6S0TYIQTUgwgah8DEfumCLUh0JklSDb3RcmTofqQxvhPQd+QJX8MS7dyfCjZ678JFfHbkMG1iOAzwcAof0Ee2DnW+Ij0gIEqDhWt96CMBI+prsMPUmOdaEZFqYrdhdseBt7pjXNoxGx0iEIxYEyCnVIlNDODNLIqzbZ1o8KdmvXnlNnwkuS5z0xZTB+E0Qnfvvt6jeEnlRVFgplyr6XArZ/O2qG4QHd4HLK0zIas0XP7ZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rHGSgK/ooSMreFeFmzAfiuBeuUIM7LJUUIgNznFeAI=;
 b=T2ZV49J9yN89bpQ2gk2aqVw9AdojJ2C0VHqV/Bd7bHiOSpxX1QQJp5gmXNEWQ+xMn3CbCeJwoi6paRP+1P1ntdMP9Zhr5qVQPqEBJcYsBPZ+X/W4w1GZ0mqFmh9gGti0tc//nTjWpjZl8+u8EwDxhknahM1p/dbe4kj6i/CHDcbzt863OPVwN/4m5K6h0ZL1IQaDYVSrBHp8hnBKQHAG2Hh2H5L+m93hsyauGZnsMpRFYLwdi5ydx/RtM0lSwp4ez8dFMMmb4Uq1S/1coqnSRyo6odG6PM9DXOhX8I93RyTEBn/l7637uaa0zv/Y4DdnTTcIEcC7SFVyHEndonICUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rHGSgK/ooSMreFeFmzAfiuBeuUIM7LJUUIgNznFeAI=;
 b=LkXvl8ggskmSoe/JYUEIGhp62kJOmlwqrpxnYnYeQyFiGA2oOxBHT5uVVD24yj6iT3SDNy8Xtroz7NKnp8AHNx5h1MIv+jehs/NGsHS6YuyTw9iVgKfuILIqd3+hY1iPoLoHXXEOTCpKbrAzB3kHX2PrRdBwAP4gYhcvpEuA+5Q=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAXPR08MB7172.eurprd08.prod.outlook.com (2603:10a6:102:20a::19)
 by PA4PR08MB7484.eurprd08.prod.outlook.com (2603:10a6:102:2a8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Wed, 3 Nov
 2021 12:00:55 +0000
Received: from PAXPR08MB7172.eurprd08.prod.outlook.com
 ([fe80::d95d:b295:e2ad:3902]) by PAXPR08MB7172.eurprd08.prod.outlook.com
 ([fe80::d95d:b295:e2ad:3902%7]) with mapi id 15.20.4649.019; Wed, 3 Nov 2021
 12:00:55 +0000
Date:   Wed, 3 Nov 2021 12:00:47 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] [RFC][PR102768] aarch64: Add compiler support for Shadow
 Call Stack
Message-ID: <20211103120047.GU1982710@arm.com>
References: <20211102070616.119780-1-ashimida@linux.alibaba.com>
 <20211102130413.GS1982710@arm.com>
 <fb3b7de8-7494-3190-1684-34fcbe9e1aa5@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb3b7de8-7494-3190-1684-34fcbe9e1aa5@linux.alibaba.com>
X-ClientProxiedBy: SN4PR0501CA0114.namprd05.prod.outlook.com
 (2603:10b6:803:42::31) To PAXPR08MB7172.eurprd08.prod.outlook.com
 (2603:10a6:102:20a::19)
MIME-Version: 1.0
Received: from arm.com (217.140.106.51) by SN4PR0501CA0114.namprd05.prod.outlook.com (2603:10b6:803:42::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.6 via Frontend Transport; Wed, 3 Nov 2021 12:00:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bf464f3-30ea-49a8-fc28-08d99ec19e2f
X-MS-TrafficTypeDiagnostic: PA4PR08MB7484:|AM6PR08MB3303:
X-Microsoft-Antispam-PRVS: <AM6PR08MB330312FD584908353E9FAE57ED8C9@AM6PR08MB3303.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: IBt8iFwVz/R6v24bCTmX3Yb0qmQY/uct4TM2TLYGCW8sL/Gu6EVqCaLGqHgBj6nXRAZZhZwS3UoYOiXitETGtDRCVgDlVmEIrvbsNHntKDU0EmIidhqesdJsKvxP7MjCWE/Dk8SlICK0ukfxNh5/kmNDNPTGDQBM+QxQGTa87MopcvzNAabU+dyoGXdMZdCJYsIBqwwlS+acSz/TnevfJN+jhjt/WV3RmAjtgU7UNFQXv552Wz86hbm8QszisQuLnUHqG/udDdDF/Y0lPoc33D4JMx5UZIfM6U4SJ/j1+dMZ4XUCWhDqld0Nh2bl5yS+ZRNIGanoS7kzJGkRkzk5C/k9LbODt2I3YtP8w6VzkW2LjyK70ma6KsSqBzq70hevEdomdhdKbRyWoirBiALj6+RIfDiPdmkjKSaYHbzSXcm4coAnXmSfrtxBuC2qenLvdbtkegg4MDZRGxvoikYN9fOqV6/mk80IpsdhK3hdEStgC7rpbDRF7yww+N5JzTw7Ic3EIrO2M4P3XMUZ27X7kkG/x+lFIyZzyoXmre/cyAlnKPiCvYjzT/YQQTVentaZPpIxyV/1Tv76l71gX7v83pPqmpoD0Lax83iVIerB+Eb2u8rF7EsgyEui8lR2UHxPIeC3ga4gy/dx+hzHRm9yFr08J0BkHKXD3GDf0X1PF1e5D3exnvLgwFyVNEMtyTvX8YS/fN3S8JQIRLuk2oGhgTNMnj0Xno/3WDGygfLDneCXzerSu4hzmdQ0tSNvds2UKp1m6040VkgYnqouahF/YS3HoQlLAz26dJVWHZEY8leXhpkLnjzmnYR8s7PQEFWJQ0PsfYh0F1BR0hK+QX0uzQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB7172.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(8886007)(33656002)(4326008)(8676002)(6916009)(2906002)(52116002)(66556008)(1076003)(956004)(66946007)(86362001)(5660300002)(55016002)(8936002)(6666004)(7696005)(38350700002)(44832011)(2616005)(53546011)(36756003)(83380400001)(26005)(966005)(186003)(316002)(508600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7484
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT055.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 80722e4f-571f-453d-e87d-08d99ec19735
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uaYCwvx0ruN5zpbPpsXi0ufsn/oYOOru1bsPcUn+E4sX2ZwFvb1GMU2Wgggd+tFbszPlXNjOwKICK+v2CRCcFP9TKhpC+THqnpJu3Zm7TbD+YK9P4vjcteiGfPFjUTvb5VCnSwjE8uRhkPEVeSWRYSyb2LvYU0gU0BK0+GYl+0HAE9BQlmtpp0jSz55HChgJM/ei1rn5izXR0od825rv9tuBTijBdWPULM0TiYPahTqN89MU/QEq6CI86C0A6WY9fHoLuxWa+bB3VRRLmrkm75xUSRx+7hfyze2ED9EX74dEb4xbbJej0sq3AlNvRiJ1Q3wB1E0BDDfei7gWPa5GsJWyTHW34A/x00csMh/VQjOvJUhAflX0K7QqDnsIyZlAohobVcHucNAMRNPTL4+4h8QAnWQXpYdvcUHqob/18/ITbyEWEZ6Rgna3kTjmmsqmCodqdd+Q3nU88gQnQ4IRCy0AbaRD909OFQpVmd2s0Fe/wOrv+0PCro5lTt0YYnFPrzWtY6WrMYQoesKzTvjMhK3SLGTn6miVn0VPJ8cZP6UmiFKFyFMJermRWWMaFGEid5mv9MOZU+YxoRUYXdwWx+l31/mfidlv8zIqjY6HutCRngZQPqUAyNxddbJD8CouDvtVEARIepHBYBB45MYWBZ/PcBr4bFyAJ+Go03UKAX2Vd/wjji0CAfLT4L66xRf5KEkJRfzoXFR+wjEEW8vo3hR5vpAG1ETkR6O5BkPERAGGrVpo3ZuXJ15oNejxit+R61ufr/pyAwKYGOJO6Zwcyn1D8DnTdDPLeTVsztmPFMgKf6AZA24+Fp4Wgy4+25Jcx4vhIkkmJ2qzVyarn358Rw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(36756003)(53546011)(7696005)(8886007)(2616005)(55016002)(1076003)(956004)(966005)(5660300002)(81166007)(356005)(44832011)(336012)(6862004)(508600001)(33656002)(82310400003)(316002)(26005)(47076005)(186003)(6666004)(2906002)(70206006)(83380400001)(4326008)(36860700001)(8936002)(8676002)(86362001)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 12:01:06.8897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf464f3-30ea-49a8-fc28-08d99ec19e2f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT055.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3303
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The 11/03/2021 00:24, Dan Li wrote:
> On 11/2/21 9:04 PM, Szabolcs Nagy wrote:
> > The 11/02/2021 00:06, Dan Li via Gcc-patches wrote:
> > > Shadow Call Stack can be used to protect the return address of a
> > > function at runtime, and clang already supports this feature[1].
> > > 
> > > To enable SCS in user mode, in addition to compiler, other support
> > > is also required (as described in [2]). This patch only adds basic
> > > support for SCS from the compiler side, and provides convenience
> > > for users to enable SCS.
> > > 
> > > For linux kernel, only the support of the compiler is required.
> > > 
> > > [1] https://clang.llvm.org/docs/ShadowCallStack.html
> > > [2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102768
> > 
> > i'm not a gcc maintainer, but i prefer such feature
> > to be in upstream gcc instead of in a plugin.
> > 
> > it will require update to the documentation:
> > 
> > which should mention that it depends on -ffixed-x18
> > (probably that should be enforced too) which is an
> > important abi issue: functions following the normal
> > pcs can clobber x18 and break scs.
> > 
> Thanks Szabolcs, I will update the documentation in next version.
> 
> It sounds reasonable to enforced -ffixed-x18 with scs, but I see
> that clang doesn’t do that. Maybe it is better to be consistent
> with clang here?

i mean gcc can issue a diagnostic if -ffixed-x18 is not passed.
(it seems clang rejects scs too without -ffixed-x18)

> > and that there is no unwinder support.
> > 
> Ok, let me try to add a support for this.

i assume exception handling info has to change for scs to
work (to pop the shadow stack when transferring control),
so either scs must require -fno-exceptions or the eh info
changes must be implemented.

i think the kernel does not require exceptions and does
not depend on the unwinder runtime in libgcc, so this
is optional for the linux kernel use-case.
