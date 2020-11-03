Return-Path: <SRS0=r0eN=EJ=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B691C4742C
	for <linux-hardening@archiver.kernel.org>; Tue,  3 Nov 2020 10:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C471D22409
	for <linux-hardening@archiver.kernel.org>; Tue,  3 Nov 2020 10:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Cr4LTSGY";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Cr4LTSGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgKCK1S (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 3 Nov 2020 05:27:18 -0500
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:8357
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727186AbgKCK1Q (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 3 Nov 2020 05:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wlxmz1lsQy9ANT5hBuxauGpsVdR7Lp8VNGTXKRA7KP8=;
 b=Cr4LTSGYEETkHIILW5Sr0QH0FPLv/LPR1ukjESdzD5t7gHd815xjEsPcBP1rl1lPzcunwfqWkDWKHBpN9JGdA+xGKvhvGmpIz6BiLQGlbYZT6+I0jzzb4f0Kcx4dJ/0HXhRWboOU3qI4QcrwKnzcKWLl92RmPOO5TIW9GnB060A=
Received: from DB6PR0202CA0001.eurprd02.prod.outlook.com (2603:10a6:4:29::11)
 by DB7PR08MB3083.eurprd08.prod.outlook.com (2603:10a6:5:28::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Tue, 3 Nov
 2020 10:27:11 +0000
Received: from DB5EUR03FT020.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:29:cafe::53) by DB6PR0202CA0001.outlook.office365.com
 (2603:10a6:4:29::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend
 Transport; Tue, 3 Nov 2020 10:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT020.mail.protection.outlook.com (10.152.20.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3520.15 via Frontend Transport; Tue, 3 Nov 2020 10:27:11 +0000
Received: ("Tessian outbound 7c188528bfe0:v64"); Tue, 03 Nov 2020 10:27:11 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3d316982cdffdc9e
X-CR-MTA-TID: 64aa7808
Received: from b1f5d2e3f37d.6
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 4F3CA039-F721-4702-A008-0403DAB25079.1;
        Tue, 03 Nov 2020 10:27:02 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b1f5d2e3f37d.6
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 03 Nov 2020 10:27:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+UluvmSqw4nvycpam5RjdCFYFsWnhttU1aWyDR7YtfUC7HvgSDVDc7KsVhPveRHmZGuFOunqfBaalbjFaVTN9y91W9ADcl15l7Ez5UgNNrlQBGmEK16yEEkSBBW1wEvluOlk3lE7o/Baht6jG83UJDiiA3Od/bHxiHInIvpzRTd5O14EiP+qiweYl/ZMtg5KULe/J3W+7JNG1+w57kiy8YElIyOc3kC65thAdRLEZbS+IVQU+gVEJBKLeWBVm/SSNV39wQVDDPZrADO9/Gcjk/NL7ajxVPo1E1VhCWYGbDs15oVubLd9guZSOyfsG0dRoIEllNFm3NakMXKUylcoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wlxmz1lsQy9ANT5hBuxauGpsVdR7Lp8VNGTXKRA7KP8=;
 b=D6HbCd256X55B4SAy/+AeuY/bnjKLxmHM9Mpk5Kg/QA3VrlyyrStzVzjGHwZncP8/LFDH6AzC7nd4O1hRTRh0aqrHpk4I9OmmdYG9zm54EAIecZvcClJ2XRNrt72YjC/KdvNq9ZFhFl2G/3aICnkdfe8KOReJxgukY5wuzVVLHPhA8TNXPk1YXKzoQMf4MRxaBsweqCIlbd3ZdYSzaThb+oSqz6cgwCWYcu3NsNt3GdHQ2Dq4RS99266j57e1wdZ03tuletzOrA8Vsjug+EOvrpiDqjE89tAVvix2T9kUCL+rOEcBlazWup01oj0CC8+5IVvgb1ZzoxEv5E9/EFJqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wlxmz1lsQy9ANT5hBuxauGpsVdR7Lp8VNGTXKRA7KP8=;
 b=Cr4LTSGYEETkHIILW5Sr0QH0FPLv/LPR1ukjESdzD5t7gHd815xjEsPcBP1rl1lPzcunwfqWkDWKHBpN9JGdA+xGKvhvGmpIz6BiLQGlbYZT6+I0jzzb4f0Kcx4dJ/0HXhRWboOU3qI4QcrwKnzcKWLl92RmPOO5TIW9GnB060A=
Authentication-Results-Original: sourceware.org; dkim=none (message not
 signed) header.d=none;sourceware.org; dmarc=none action=none
 header.from=arm.com;
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com (2603:10a6:102:87::18)
 by PA4PR08MB6223.eurprd08.prod.outlook.com (2603:10a6:102:e8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 10:26:48 +0000
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::2904:edcf:b299:f792]) by PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::2904:edcf:b299:f792%3]) with mapi id 15.20.3499.032; Tue, 3 Nov 2020
 10:26:48 +0000
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
Subject: [PATCH 4/4] aarch64: Remove the bti link_map field [BZ #26831]
Date:   Tue,  3 Nov 2020 10:26:42 +0000
Message-Id: <4dadd9c101e32b17e927d56966c54e734ced21ab.1604393169.git.szabolcs.nagy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1604393169.git.szabolcs.nagy@arm.com>
References: <cover.1604393169.git.szabolcs.nagy@arm.com>
Content-Type: text/plain
X-Originating-IP: [217.140.106.54]
X-ClientProxiedBy: LO2P123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::32) To PR3PR08MB5564.eurprd08.prod.outlook.com
 (2603:10a6:102:87::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (217.140.106.54) by LO2P123CA0020.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:a6::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Tue, 3 Nov 2020 10:26:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97e34c2a-9521-4024-d3ca-08d87fe3068a
X-MS-TrafficTypeDiagnostic: PA4PR08MB6223:|DB7PR08MB3083:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB3083819546C193D1FDF914E5ED110@DB7PR08MB3083.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: GpX+9AZXL1rA7ftikTwlnVdsxsZ8r8ULLNyUhbJEF3b+g59pp2w1vUpuOQtaix5PB+Oe8OfQUlE+5t9cNv30edS+6vcbzyEkT3/s1n53GjV9n8I6pDyhJapu4YbJR0jyAhwIIJrEKa2FtZVczls7DlzvGEBJSswUiBulAwkw6akKhuy23qG2cPSZ1U1kWVML45l0aTvvyVPy3f2W+S7R5806A+X8nIdGtI3VSRjSip9N+EY1Z80NuKyhJSbzysn7BtONSOROKqSsdJd327BVL6YSBbllWAwVwTU8pqW6lB4hwRbYcegOfpElwQBmSTk1SkbafKYiZh71YPXwe/GTCBAvvnZPPRtXDnTMcG+9aJDFHGwYf2VIqtYpsnOk0Zti
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5564.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(5660300002)(2906002)(66556008)(6506007)(8676002)(66946007)(478600001)(54906003)(66476007)(6666004)(6486002)(4326008)(6916009)(6512007)(69590400008)(186003)(16526019)(2616005)(7416002)(36756003)(956004)(8936002)(86362001)(44832011)(83380400001)(52116002)(316002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: n+W63gGQDmjlTcHyctXjrchkrxCzFfRzkiydbGMpSLw2hRtMFazdpMP+Iy1+FQCGS21ZilzkcazqPBPKGXKR49RXI5GINqtDQYt1a7KHj5l7KAbJXHJMg6oBmidHtY8iTzEMrtBcxl95NPXJXgxhSbE2ON750mZ5mAPUiSsx8Bt/bzx2YnTnJAlNA0jtEZ6bXxcbNqXR8xdUJZGq/KxhKmzgSGORBApYDfzo22MjKU9ALwJC/UbKyYmR4Nw9cvXX06J2hDN3pKkqhjRaK8RDo/xemX0WVQJdQYU7VTJnUgfy/9mMpNk9gqEOrnbtgLlgSTzEU2IYgz6ZJbt3+cnK7H6F1TeLOcjvHZxgDbKtMwspq802M9fpu2R9hFCCamPuI/Vu+2uiqhokO1U7s9lj1Pk7pan8jS7v2FdonkNTrdsfDV644owsD00mDbG8db/rGHPjY+0DVUFHJsd52bvrRIgYhN2VO3EWhQ97sj2aYLYItX5d15gLjHLtSuSNRoZH8e1rU8cNWQIgNligY3hLe7tpRgBgrJixAmkxXNPXUmVkp9khH6FjCvmRg8C1ET+Ekp1T2mcu7JD+JryWeyZB0sVHKbwOW0H/ziOwXiRtXOwrxNzZhgpWsZnT8XrX2EpCx9hNFTTrhWKno/Iuz0F/OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6223
Original-Authentication-Results: sourceware.org; dkim=none (message not signed)
 header.d=none;sourceware.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: b2e1cbd6-8844-4c3d-f2f3-08d87fe2f874
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MuJHMd8xhDsqLojSzvZB2Zu1yymcW4SYi2MZY6PuziQBaLyvgaaepBxFzMsc+r+bwfBavEDloPR2D9bs+gisk0i5SJ/0K/wNLhjL2bXENQfeUQb9UdjCFroyGMsSkyJ5TJbFO13x3P0YpFFYIYYNkEKgHfRRzdbLxy8FWiOHg162d+88gTU6oI/ttt87hN7SKRmfAE4bWA/HI3am7CY69Y3AOpcZY4hvjRUtus0U3QyzefgMDZQPB9Jh57vQOInSf8x5P1w1A79DQurpCjZCj5z0FpUWeEqqqXeX4xgE1u93V1/liadSLqwlHivRaheaOSo/iLWz49Wl4rLA9rg/Ewm5EsncdIbPOTsqAJr7LaglSdfpUX+BwX3oZht6xhzAxLP+xPhwTrMtmIuBYqF7OfrOCWBLq58OS3d3/EMLeE66+8iMstR/dtJFLvu6Vc6s
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(376002)(396003)(46966005)(4326008)(82740400003)(2616005)(336012)(44832011)(186003)(16526019)(356005)(47076004)(8936002)(81166007)(6486002)(6506007)(956004)(8676002)(86362001)(36756003)(34206002)(26005)(6666004)(6512007)(450100002)(82310400003)(5660300002)(70206006)(316002)(478600001)(69590400008)(54906003)(70586007)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 10:27:11.6893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e34c2a-9521-4024-d3ca-08d87fe3068a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3083
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The bti link_map field is no longer necessary because PROT_BTI
is applied at note processing time immediately instead of in
_dl_open_check based on the bti field.

This is a separate patch that is not expected to be backported
to avoid changing the link_map layout that is libc internal ABI.
---
 sysdeps/aarch64/dl-prop.h | 5 +----
 sysdeps/aarch64/linkmap.h | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/sysdeps/aarch64/dl-prop.h b/sysdeps/aarch64/dl-prop.h
index 762bc93733..cf14381e4a 100644
--- a/sysdeps/aarch64/dl-prop.h
+++ b/sysdeps/aarch64/dl-prop.h
@@ -52,10 +52,7 @@ _dl_process_gnu_property (struct link_map *l, int fd, uint32_t type,
 
       unsigned int feature_1 = *(unsigned int *) data;
       if (feature_1 & GNU_PROPERTY_AARCH64_FEATURE_1_BTI)
-	{
-	  l->l_mach.bti = true;  /* No longer needed.  */
-	  _dl_bti_protect (l, fd);
-	}
+	_dl_bti_protect (l, fd);
 
       /* Stop if we processed the property note.  */
       return 0;
diff --git a/sysdeps/aarch64/linkmap.h b/sysdeps/aarch64/linkmap.h
index 847a03ace2..e921e77495 100644
--- a/sysdeps/aarch64/linkmap.h
+++ b/sysdeps/aarch64/linkmap.h
@@ -22,5 +22,4 @@ struct link_map_machine
 {
   ElfW(Addr) plt;	  /* Address of .plt */
   void *tlsdesc_table;	  /* Address of TLS descriptor hash table.  */
-  bool bti;		  /* Branch Target Identification is enabled.  */
 };
-- 
2.17.1

