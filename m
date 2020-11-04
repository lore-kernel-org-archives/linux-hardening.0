Return-Path: <SRS0=8UcS=EK=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6227C2D0A3
	for <linux-hardening@archiver.kernel.org>; Wed,  4 Nov 2020 16:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DDE920786
	for <linux-hardening@archiver.kernel.org>; Wed,  4 Nov 2020 16:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="0zC723ce";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="0zC723ce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgKDQIq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 4 Nov 2020 11:08:46 -0500
Received: from mail-eopbgr40070.outbound.protection.outlook.com ([40.107.4.70]:25061
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725889AbgKDQIp (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 4 Nov 2020 11:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJg9LWxDkBqnTvXChI+dbRR+BoThaIHNKZbwLF8Ms3s=;
 b=0zC723cewfcZxK/Ds/FXDZpof6cO/Hh8yNma4NeWPzeu5kIz7j6obZLSEwkAetJgt9W9zE2HNV06JHbpo3pA8iok5tji9vcXoBHAgtrbUBQNYEyrPhW5Me4oSn7uhho9LNP/oWes1i6Sxc7G6o+jrhuJGpKjeptTjtc8cGXBe+o=
Received: from AM6P194CA0013.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:90::26)
 by AM0PR08MB3906.eurprd08.prod.outlook.com (2603:10a6:208:100::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 4 Nov
 2020 16:08:38 +0000
Received: from VE1EUR03FT035.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:90:cafe::cf) by AM6P194CA0013.outlook.office365.com
 (2603:10a6:209:90::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 4 Nov 2020 16:08:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT035.mail.protection.outlook.com (10.152.18.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3520.15 via Frontend Transport; Wed, 4 Nov 2020 16:08:38 +0000
Received: ("Tessian outbound c579d876a324:v64"); Wed, 04 Nov 2020 16:08:38 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 39b346bc75defc7a
X-CR-MTA-TID: 64aa7808
Received: from c3d3e2315817.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3AFA5A81-4790-4BE2-85B7-956DDF15DEDF.1;
        Wed, 04 Nov 2020 16:08:14 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c3d3e2315817.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 04 Nov 2020 16:08:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0zsXIb4N7EK8iQDeOIDuoGZkEpTJVGmTJKb+4LjlSICxQc6GqAtPkm3lG7s09uNmnih1QecLUYHbis0RkZG1SANz0tWj4yreSSYYgDgCzSUAI7UkXMKGrvxpipQhZFiYDeZxvhrcczmi856MQmpVUOLCInqRXYXyalsrvoE3F17e2q6gf/UYD4t+bGQPfNeLja0WTHqFvcY/3p27O1KCEzzrUHAMh26gu8d8ZJniQIOkDuldk5aK5zDcZ85jdjx5jqk/nfQWKzXAJE5/EATZr7Pa7EYS8Dc/h03TsBPQW3+CRMLWL5wtNgEXkss/ms4KzQRbSfeH5P67Hus5Hb8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJg9LWxDkBqnTvXChI+dbRR+BoThaIHNKZbwLF8Ms3s=;
 b=frLO5qBnBud3Um6RPY/JFE+loA/Jbe1r+JVDnqKefVRQ+okz6NzOYl5y4Z3OXRnTWvXeCKbqjViwKKemvXDr1FRp60X+C6es6fp7Hr4z2Mx6YlPY8ODg4envsH+tl7ibxKaeKuL9b6+QZb3PKOi9GP+3sgSy6IsIaGmNeZ7dg4UgnoC+jMA3UFNkDjVT0cU6hFzWUFPn2i1EcxZ+tbXwIMmPn7ecv4upJ+dYNjkORy+YYMezh64QZ5GEGeHwGWhdmlAwMs+NcqDrrxSdk+MKhr+ieCQkkMtFd4hAwL8FKGxfZlYLvmi4r/gS0ema/jdyMPEh6U7nW1Aa8SRSRiC4+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJg9LWxDkBqnTvXChI+dbRR+BoThaIHNKZbwLF8Ms3s=;
 b=0zC723cewfcZxK/Ds/FXDZpof6cO/Hh8yNma4NeWPzeu5kIz7j6obZLSEwkAetJgt9W9zE2HNV06JHbpo3pA8iok5tji9vcXoBHAgtrbUBQNYEyrPhW5Me4oSn7uhho9LNP/oWes1i6Sxc7G6o+jrhuJGpKjeptTjtc8cGXBe+o=
Authentication-Results-Original: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com (2603:10a6:102:87::18)
 by PA4PR08MB6110.eurprd08.prod.outlook.com (2603:10a6:102:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Wed, 4 Nov
 2020 16:08:12 +0000
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::2904:edcf:b299:f792]) by PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::2904:edcf:b299:f792%3]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 16:08:12 +0000
Date:   Wed, 4 Nov 2020 16:08:10 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Florian Weimer <fweimer@redhat.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        libc-alpha@sourceware.org, Jeremy Linton <jeremy.linton@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/4] aarch64: avoid mprotect(PROT_BTI|PROT_EXEC) [BZ
 #26831]
Message-ID: <20201104160810.GD24704@arm.com>
References: <cover.1604393169.git.szabolcs.nagy@arm.com>
 <20201103173438.GD5545@sirena.org.uk>
 <20201104092012.GA6439@willie-the-truck>
 <87h7q54ghy.fsf@oldenburg2.str.redhat.com>
 <d2f51a90-c5d6-99bd-35b8-f4fded073f95@gmail.com>
 <20201104143500.GC28902@gaia>
 <f595e572-40bc-a052-f3f2-763433d6762f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f595e572-40bc-a052-f3f2-763433d6762f@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [217.140.106.54]
X-ClientProxiedBy: LO2P265CA0140.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::32) To PR3PR08MB5564.eurprd08.prod.outlook.com
 (2603:10a6:102:87::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.54) by LO2P265CA0140.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9f::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Wed, 4 Nov 2020 16:08:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 62b946df-1f90-4b69-356d-08d880dbe425
X-MS-TrafficTypeDiagnostic: PA4PR08MB6110:|AM0PR08MB3906:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB3906066AC933227F7872701DEDEF0@AM0PR08MB3906.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: eRDvAKnvuUN8LSsaY7Wed5Jy2FTi/ucBB8twfl3xFU+SIZ/AFelWpXHFQET4VOr6KqPImnDEbx4ksgPf4ZLvut7UWzIKSr2XuBjWtofOK379Va0JU/SyxwYrj6cAqlxlBzR0VGZfbhWmKvmqqIYjHzYW7/9Xzpphn7rbrqilh6asnOncAUNiJJ00+BFgI0grGRqX/S+EAG4E2YnCA9DB19DHnFb9umAQ3T0Zl/yv98lYhVlTY8zp6pAe2/IrSxnBfqI0USfrx7Ab2TY84KYwTrbhuBrK0wCOdiVhQndJID2kHu+tggtc1YOjt7z0A+j6LF3HSy91BtBxLLmiH2hWiOMYx5bpVHO3MGcHLQirZsHbwQXQiutdtiK0HL65qz0hjRvx/E8VSZEXDYXc/cKH36t3WaFo8RDRiDcUFr6DKUT1OvVy4mhodjf6a0n8NYT0NHhMsknKcdMYVfoPlUZs1g==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5564.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(54906003)(956004)(2616005)(86362001)(5660300002)(8886007)(2906002)(8936002)(186003)(26005)(16526019)(1076003)(36756003)(7416002)(8676002)(44832011)(83380400001)(4326008)(316002)(52116002)(33656002)(66946007)(66556008)(66476007)(55016002)(6916009)(7696005)(478600001)(83133001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: scDUYs+Yv4uhYCKZH9t9N+P0Zngv37kPjysPacw5USUCg8sdv4MY5wce17g4H/965mY06CiOg6yfjhphz2w48k2b40y8e/NRLjuYRm5a9JQ4naV52kt/d5UuB9vJUocLBkbb0X6I2CTcxhwFrxLHbVBeyzPg1gsEFGqNvTJzvat5Ic0Wz/nYv1yE7YziY28j0YIVvPBlm/XtqE0ZNqbe+V1z7q8UeMEKIgl4LI2eTz+dbbqLG0ARHGzDKqEpoa5zFnhkPXa3/fPRBZYb3Bvhubhi9hWUxTIHOMHiRVGpBCJI2dX+fTA2TABqJB38GxVuhTezGFpwuZu6Xfa8LGvbOFIs8LXu9jLQztBP2UrTGnHHOIu6EcPICL5ts7Cbvk116jnxFnQtO0ejalv/uD/ZjrSSMwSYAVKoI6GCqByG3PwRFo9AmaoWGHXowPTM2jYtSTYJzQobyGSXjLVDHqwbCRMuA4WPUgLFyTlP1vaRyo97Irdm4dRzbfiS6th1gm+LfqKb6dS/oqEsWY5ErqasKeq61Ks6h/9fZ8QeUE2laxo74qQSpdGS7tpfBA/Qk4gBBEV8KK0Twh2Wb2RXINhxbr2JoqAbgdgc7rwoZJQBkJUYjslbg+spPA81TdaugJRNCrO2cCp9fuBBibSc/CvqXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6110
Original-Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT035.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 91106ac1-7a74-4046-cf5d-08d880dbd47d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z+54wLnDRiTrYCbq8MOAt1kEZn82tLIchwepX0iGtfqHPRIOGHST5U+9bW3oJImUVIowIhiY1q9c7ruegye6/UeKC59oY37oFvVYMO/A7WRSlmcqQkEL320vs6oNWmAjGk24yasedHPANzsRfWrvWXzHJa8/mVQhqBF4gjvD4w2xPTlJBABs8cB8piq5LfT/PrcdfWrrePZ+m6gWMXPYFgJBI2ct9F2oO+DWRDqpt7NIyVxXmTWzm2F3Pot19w/RzvTHPGkQY25RMQLMfUXSesNWdG4R8DE4LXxGCEyEYoY710rBlkPSNqRI2peUiXG2pTzeK4zppsU7J9VXdyh+SIR74OEjdBlvpZIAcq8FCm9rQj0coLtZFa6s4nYXGAu666TrEmsSfBpSkXYESvmeefTYu/ZEznfdmxAjUcH0gjUVm3Mt0HQdnwmWM4aaTxSksCoF0sHxa2wMnLwnIG/y7RmkZgcys87Lf3+qtxC88PJtmWgQPWhsNhHRMw0T6o2w
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(46966005)(33656002)(450100002)(1076003)(36906005)(6862004)(8936002)(336012)(5660300002)(478600001)(2616005)(956004)(83380400001)(2906002)(4326008)(44832011)(8676002)(8886007)(82310400003)(316002)(26005)(82740400003)(47076004)(86362001)(81166007)(54906003)(7696005)(55016002)(70206006)(36756003)(70586007)(356005)(186003)(16526019)(83133001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 16:08:38.5332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b946df-1f90-4b69-356d-08d880dbe425
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT035.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3906
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The 11/04/2020 17:19, Topi Miettinen wrote:
> On 4.11.2020 16.35, Catalin Marinas wrote:
> > On Wed, Nov 04, 2020 at 11:55:57AM +0200, Topi Miettinen wrote:
> > > On 4.11.2020 11.29, Florian Weimer wrote:
> > > > * Will Deacon:
> > > > > Is there real value in this seccomp filter if it only looks at mprotect(),
> > > > > or was it just implemented because it's easy to do and sounds like a good
> > > > > idea?
> > > > 
> > > > It seems bogus to me.  Everyone will just create alias mappings instead,
> > > > just like they did for the similar SELinux feature.  See “Example code
> > > > to avoid execmem violations” in:
> > > > 
> > > >     <https://www.akkadia.org/drepper/selinux-mem.html>
> > [...]
> > > > As you can see, this reference implementation creates a PROT_WRITE
> > > > mapping aliased to a PROT_EXEC mapping, so it actually reduces security
> > > > compared to something that generates the code in an anonymous mapping
> > > > and calls mprotect to make it executable.
> > [...]
> > > If a service legitimately needs executable and writable mappings (due to
> > > JIT, trampolines etc), it's easy to disable the filter whenever really
> > > needed with "MemoryDenyWriteExecute=no" (which is the default) in case of
> > > systemd or a TE rule like "allow type_t self:process { execmem };" for
> > > SELinux. But this shouldn't be the default case, since there are many
> > > services which don't need W&X.
> > 
> > I think Drepper's point is that separate X and W mappings, with enough
> > randomisation, would be more secure than allowing W&X at the same
> > address (but, of course, less secure than not having W at all, though
> > that's not always possible).
> > 
> > > I'd also question what is the value of BTI if it can be easily circumvented
> > > by removing PROT_BTI with mprotect()?
> > 
> > Well, BTI is a protection against JOP attacks. The assumption here is
> > that an attacker cannot invoke mprotect() to disable PROT_BTI. If it
> > can, it's probably not worth bothering with a subsequent JOP attack, it
> > can already call functions directly.
> 
> I suppose that the target for the attacker is to eventually perform system
> calls rather than looping forever in JOP/ROP gadgets.
> 
> > I see MDWX not as a way of detecting attacks but rather plugging
> > inadvertent security holes in certain programs. On arm64, such hardening
> > currently gets in the way of another hardening feature, BTI.
> 
> I don't think it has to get in the way at all. Why wouldn't something simple
> like this work:

PROT_BTI is only valid on binaries that are BTI compatible.
to detect that, the load segments must be already mapped.

AT_BTI does not solve this: we want to be able to load legacy
elf modules. (a BTI enforcement setting may be useful where
incompatible modules are rejected, but that cannot be the
default for backward compatibility reasons.)

> 
> diff --git a/elf/dl-load.c b/elf/dl-load.c
> index 646c5dca40..12a74d15e8 100644
> --- a/elf/dl-load.c
> +++ b/elf/dl-load.c
> @@ -1170,8 +1170,13 @@ _dl_map_object_from_fd (const char *name, const char
> *origname, int fd,
>             c->prot |= PROT_READ;
>           if (ph->p_flags & PF_W)
>             c->prot |= PROT_WRITE;
> -         if (ph->p_flags & PF_X)
> +         if (ph->p_flags & PF_X) {
>             c->prot |= PROT_EXEC;
> +#ifdef PROT_BTI
> +           if (GLRO(dl_bti) & 1)
> +             c->prot |= PROT_BTI;
> +#endif
> +         }
>  #endif
>           break;
> 
> diff --git a/elf/dl-support.c b/elf/dl-support.c
> index 7704c101c5..22c7cc7b81 100644
> --- a/elf/dl-support.c
> +++ b/elf/dl-support.c
> @@ -222,7 +222,7 @@ __rtld_lock_define_initialized_recursive (,
> _dl_load_write_lock)
> 
> 
>  #ifdef HAVE_AUX_VECTOR
> -int _dl_clktck;
> +int _dl_clktck, _dl_bti;
> 
>  void
>  _dl_aux_init (ElfW(auxv_t) *av)
> @@ -294,6 +294,11 @@ _dl_aux_init (ElfW(auxv_t) *av)
>        case AT_RANDOM:
>         _dl_random = (void *) av->a_un.a_val;
>         break;
> +#ifdef PROT_BTI
> +      case AT_BTI:
> +       _dl_bti = (void *) av->a_un.a_val;
> +       break;
> +#endif
>        DL_PLATFORM_AUXV
>        }
>    if (seen == 0xf)
> 
> Kernel sets the aux vector to indicate that BTI should be enabled for all
> segments and main exe is already protected.
> 
> -Topi
