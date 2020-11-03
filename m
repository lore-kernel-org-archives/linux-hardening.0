Return-Path: <SRS0=r0eN=EJ=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C004C2D0A3
	for <linux-hardening@archiver.kernel.org>; Tue,  3 Nov 2020 10:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE5F3206F1
	for <linux-hardening@archiver.kernel.org>; Tue,  3 Nov 2020 10:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="yYXYdIAc";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="yYXYdIAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgKCK0N (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 3 Nov 2020 05:26:13 -0500
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]:12124
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727857AbgKCK0J (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 3 Nov 2020 05:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9IJavFSnLVyxgelY1q3iBNMxsZVKwWSfeObLsze7Gc=;
 b=yYXYdIAc4FOA5a7hA3AL74ba+QFhbHpF4iQGggi0zpa2IVwGrSL5KxAp5AoLLrqFUTqjU79qiJUn4+qxKCPjXvyuyOnNg0WVPm3IQp9dOsbhaM3/lN0tMMMsSUiaDFPzVtWTR2UuOpweumhPHBuug4//DuZ8y20xOgkmlfLpKTM=
Received: from DU2PR04CA0014.eurprd04.prod.outlook.com (2603:10a6:10:3b::19)
 by AM9PR08MB6289.eurprd08.prod.outlook.com (2603:10a6:20b:2d7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 3 Nov
 2020 10:26:05 +0000
Received: from DB5EUR03FT040.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:3b:cafe::5d) by DU2PR04CA0014.outlook.office365.com
 (2603:10a6:10:3b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend
 Transport; Tue, 3 Nov 2020 10:26:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT040.mail.protection.outlook.com (10.152.20.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3520.15 via Frontend Transport; Tue, 3 Nov 2020 10:26:05 +0000
Received: ("Tessian outbound 68da730eaaba:v64"); Tue, 03 Nov 2020 10:26:05 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 938e218c014de032
X-CR-MTA-TID: 64aa7808
Received: from 16d8a73bd160.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7506EF37-D79D-4E3F-8893-D75F5BE78EC4.1;
        Tue, 03 Nov 2020 10:25:57 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 16d8a73bd160.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 03 Nov 2020 10:25:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTJMPAFsv3JLr2epKsgUmW9kq9CMh/QF4jyqrSDll0NAiUxylJFjYSza1i0W/ZoRKfL0MR3RdMXQ+NH6a8JUotpVBt+Hd7rE33hTHlT9cFyqjgUYjOPcZqlBXHIy6n85Rr6KS0R01Cw9YLXjeZFaC+sG4tLvxr4zI5jgFJmIJ/PL8vjC6ndUAG55VfsJ/cF1ePKMhb5sVGweHSZ1RkNd49u3ahfKc0im9oGvXZn2D7MwQPvTt2TjEeys8Y5pmhVahseGp7ySHMNgO4dhMb33/B8H974Dmiy5WEpAgO8jQmVk5RGk6AQaqSjJIJ1FtntuYBQx7EE1RgmXjpV2JrwIHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9IJavFSnLVyxgelY1q3iBNMxsZVKwWSfeObLsze7Gc=;
 b=HGgwyQSYx2PH/lgMWjO4HbAQoyItXJvpo+XkH3A6HV1Td2PUmokssCjDFkjsnjBiyA5zNdgORHsY421Wc/cR6oNLJvGuPfaJBOS4dbjkPzGGMZGC97THKnRBHZyQr66Kq0BF1kIOG8SQyOjBWPm1ymlRtUN25Vmu7pb4LrtycBQGq/zW+MWQma1b8M2FwAMOW7qwNWyPvzCon3UBKhQkyqls8Y6UQilV1Y2oII0Ly6BKBLHE6KSsLkAgapVSW33uLfNJVvyp3JjJ/p8OzQK/+xPZMPJLeSPie0qzS+eNq+7to9zA3276RCFASLUwvIxDDSOk7Sp1QHu2A+vxWXpxPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9IJavFSnLVyxgelY1q3iBNMxsZVKwWSfeObLsze7Gc=;
 b=yYXYdIAc4FOA5a7hA3AL74ba+QFhbHpF4iQGggi0zpa2IVwGrSL5KxAp5AoLLrqFUTqjU79qiJUn4+qxKCPjXvyuyOnNg0WVPm3IQp9dOsbhaM3/lN0tMMMsSUiaDFPzVtWTR2UuOpweumhPHBuug4//DuZ8y20xOgkmlfLpKTM=
Authentication-Results-Original: sourceware.org; dkim=none (message not
 signed) header.d=none;sourceware.org; dmarc=none action=none
 header.from=arm.com;
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com (2603:10a6:102:87::18)
 by PA4PR08MB6285.eurprd08.prod.outlook.com (2603:10a6:102:e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 3 Nov
 2020 10:25:52 +0000
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::2904:edcf:b299:f792]) by PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::2904:edcf:b299:f792%3]) with mapi id 15.20.3499.032; Tue, 3 Nov 2020
 10:25:52 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     libc-alpha@sourceware.org
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org
Subject: [PATCH 0/4] aarch64: avoid mprotect(PROT_BTI|PROT_EXEC) [BZ #26831]
Date:   Tue,  3 Nov 2020 10:25:37 +0000
Message-Id: <cover.1604393169.git.szabolcs.nagy@arm.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [217.140.106.54]
X-ClientProxiedBy: SN6PR2101CA0025.namprd21.prod.outlook.com
 (2603:10b6:805:106::35) To PR3PR08MB5564.eurprd08.prod.outlook.com
 (2603:10a6:102:87::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (217.140.106.54) by SN6PR2101CA0025.namprd21.prod.outlook.com (2603:10b6:805:106::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.6 via Frontend Transport; Tue, 3 Nov 2020 10:25:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1cdce98f-1a27-4274-ea03-08d87fe2dee3
X-MS-TrafficTypeDiagnostic: PA4PR08MB6285:|AM9PR08MB6289:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9PR08MB6289EE3B44CB905368676D81ED110@AM9PR08MB6289.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Stsu0KlIb4lIVOOruG4jS/t9+9pc1OmBNb73BCLh7fhi7Eq5PJQRKF+kJfjIpfgkKldLCchS08mJH89qcjTCa94WZmJKYsoTQo4YM9atfd9kDqX4or4wsrgxzkMhMb15Vgo57AWo9SQU9jlXQhztf4+JiVgGgY0ZYTzBEalByDd/DSOowhbD1lc/puItWGJVsDwPyH1cI1q2pfWOJpiwSX5/1tWrO7Ef22XFKNj2n+g+OXBSFf0BvokqMmiQAZgTuZOZIzB70XO43zwO4iaIBjXPr3GPOLH3NEeSKy2I6SrXNJd+dZyx1VEhlRJs85Q8+jk/i7DZSN+e8/d3N7VVEo3zStlheFVdm8/RuuSlbNvNRVB05X+VmxnbGV9ImcGWcxyhBBgy5fkigVi9NBadCKfh8buFP/hzqgYiAwk/c7Q=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5564.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(6506007)(36756003)(186003)(54906003)(478600001)(8936002)(6916009)(52116002)(316002)(4326008)(16526019)(26005)(69590400008)(86362001)(5660300002)(2616005)(44832011)(7416002)(956004)(8676002)(66476007)(66556008)(6512007)(83380400001)(6486002)(2906002)(6666004)(66946007)(83133001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ZG0YhZU+otW5WO1ZgGeP4bqhUY0GXSksmxb9xYXof6TK25jFOavZyghJWuZ6wReEOVND03gBsMTpx20GXHnTGUKCblEBQEXg3waQNclQwWD7kg1pWbuN73oAuTYn1Um5FPNgjeWbiHDv2QBdMFTQk9Ats9GjwcEoqwukcmn5Zpc0VuUoGrooI4F/3hsFfjigrSP0eRbVRWoOFLXk4P1m4Lolq4l0an6stCFOvQZ4gcJgw0u4Ok5KcNqn0U0Zze7N3gofdU3p3cahfRHwqwAllZ9OzcWM71lh87pYiNxLTAu1dHhWKjDjMxiz0ElGb5GjVEj3YA1SLBuFxFOY7SKeqk894akYEWQaTA8l1JTXDJluYefX6ISDKBESqIQGYG/VBfHF+jODLt3+DAQQ7QOdycqwq9anjkgWH7oJSSryrNBZoYZ9I9AVKunvx/kQgYtj77EmQM7caDNLhZYmR4V9rtxqi8tCfT0kDy8TGlU8lnywohF5v9BBEy3YP8stsNwQYOGBzTXeJrFcsD4UU+S2xjjL7U33782oqTfscN6E6bI6aU2lTdlLQVNkJbSKVE2JpF+Xgl1fTFzTqKLsfbqdkZ7oPQsEoFsj0+XvQNapUkA76Kx7iRRXEomOY3YqJqF68laEI2I+8qpfnBfgl94EZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6285
Original-Authentication-Results: sourceware.org; dkim=none (message not signed)
 header.d=none;sourceware.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT040.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: ec11855b-163b-432a-ee29-08d87fe2d6e5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XPhMnM+tOeoG9KHOpcGpO+7NrxKkFJ2LdhoqRPTGOqTk5Sw/RvTjeGduq/FzeeFlMbLXHHQNhxPO7AeyQrus4Zelb3WDfOn3jZJl8JDrEe9dKP//cSaL4zi4GjHFeEAl0b/cW7jL3trky+ssht0SzL0eQO8lDSVhgnxL2WSMU+mnNms8v3TNAuTw8LTuySwz1WCLgftovBOOn3d3e+lYNobyEpEp8rUWHb8YIYXcSNnH2PJi1DU9FctPF5sWMDtHKgb9GH+h4KxXQnJW4UNOmzMMefQCOQS+GgkH1UjDcXNCaOZOBwJnD8JLE/oatAkEMscwTiAjwlc0acDdwyYLBbP/kpydXL2/Th4MwBVZ/qSBAvwlR/qqNcyaMQGUHCY/etHHCVSm8lr53q57NKYCxgIieWQqJA4g30D7onC+Je41RvKaZXNSroEdLZ7fgT30wxoFcM2Ic5+D4cWlORvTtQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966005)(8936002)(6512007)(83380400001)(4326008)(34206002)(54906003)(47076004)(316002)(6666004)(450100002)(2906002)(70206006)(70586007)(82740400003)(356005)(6506007)(16526019)(186003)(82310400003)(26005)(81166007)(36756003)(86362001)(6486002)(478600001)(956004)(8676002)(2616005)(44832011)(69590400008)(5660300002)(336012)(83133001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 10:26:05.1640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cdce98f-1a27-4274-ea03-08d87fe2dee3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT040.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6289
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Re-mmap executable segments instead of mprotecting them in
case mprotect is seccomp filtered.

For the kernel mapped main executable we don't have the fd
for re-mmap so linux needs to be updated to add BTI. (In the
presence of seccomp filters for mprotect(PROT_EXEC) the libc
cannot change BTI protection at runtime based on user space
policy so it is better if the kernel maps BTI compatible
binaries with PROT_BTI by default.)

Szabolcs Nagy (4):
  elf: Pass the fd to note processing [BZ #26831]
  elf: Move note processing after l_phdr is updated [BZ #26831]
  aarch64: Use mmap to add PROT_BTI instead of mprotect [BZ #26831]
  aarch64: Remove the bti link_map field [BZ #26831]

 elf/dl-load.c              | 38 ++++++++++++++++---------------
 elf/rtld.c                 |  4 ++--
 sysdeps/aarch64/dl-bti.c   | 46 ++++++++++++++++++++------------------
 sysdeps/aarch64/dl-prop.h  | 17 +++++++-------
 sysdeps/aarch64/linkmap.h  |  1 -
 sysdeps/generic/dl-prop.h  |  6 ++---
 sysdeps/generic/ldsodefs.h |  5 +++--
 sysdeps/x86/dl-prop.h      |  6 ++---
 8 files changed, 64 insertions(+), 59 deletions(-)

-- 
2.17.1

