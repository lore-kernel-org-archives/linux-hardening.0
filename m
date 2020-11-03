Return-Path: <SRS0=r0eN=EJ=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4106CC55178
	for <linux-hardening@archiver.kernel.org>; Tue,  3 Nov 2020 15:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF729221FB
	for <linux-hardening@archiver.kernel.org>; Tue,  3 Nov 2020 15:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="MuHw3TlN";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="MuHw3TlN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgKCPFz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 3 Nov 2020 10:05:55 -0500
Received: from mail-eopbgr80089.outbound.protection.outlook.com ([40.107.8.89]:41445
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727986AbgKCPFB (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 3 Nov 2020 10:05:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9wYgp+L8m5kvL9WmXlglilDVYKdhLJxZF/3QRzui7Y=;
 b=MuHw3TlNUxdFtRfKBFDlIyVYIzbRNjmOy0qdG4oqEcRH4oDLOB8sHq0DvBvamKhMwAT0JlXBA9YXOFwViC8w0+HLa7DHkElXrG2t0VcUimj2UEQ4Lt/XO3/RtPbJNtR36kmFtVoT5EsGOBmntZ4DnJ1I6n8dN3VQj+lSIW1xJng=
Received: from AM6PR04CA0037.eurprd04.prod.outlook.com (2603:10a6:20b:f0::14)
 by AM6PR08MB4721.eurprd08.prod.outlook.com (2603:10a6:20b:c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 3 Nov
 2020 15:04:55 +0000
Received: from AM5EUR03FT010.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:f0:cafe::e1) by AM6PR04CA0037.outlook.office365.com
 (2603:10a6:20b:f0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 3 Nov 2020 15:04:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT010.mail.protection.outlook.com (10.152.16.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3520.15 via Frontend Transport; Tue, 3 Nov 2020 15:04:55 +0000
Received: ("Tessian outbound d5e343850048:v64"); Tue, 03 Nov 2020 15:04:53 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6132eefc32d8919c
X-CR-MTA-TID: 64aa7808
Received: from b35da5167037.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id EEC80A33-2B2F-4E34-9B39-6B8A03504C12.1;
        Tue, 03 Nov 2020 15:04:16 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b35da5167037.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 03 Nov 2020 15:04:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZH3n9KkTEvUqifvMrz7b+oLpaxo6Pe5YqfoVSv+vVrlxnL2fK0sDt8yLJrOapCBoJskAbxi1j+k+V/zn5ouD4otOqETuPUgq/6re9AndCTPmmgyEUC6sgtF+Ka9Vdg6148Ms56TbTFMgO2sbWRqHUs/QCxGHcFWHf1LyDiJGPOueoPkZxWyXUCEdUDdltmXGzaLW/vFPsTnLMK/AjSKjmo7fExCDOpPO/5/J5h590WarFOeBOIiFdAn2ybJEoMEM1hv0XI4dypFM9xNH0TTSbHdhGXcxNZcT9J40dOiDvCe4tDg0FtTq7xP6lscQdUEJH/ewF+uL2OwLQHVjP80Vpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9wYgp+L8m5kvL9WmXlglilDVYKdhLJxZF/3QRzui7Y=;
 b=Ou7YRRvH494eVJBdu/nHPi6/m7e7BIvaXIjNuTEzWIZmR97sFxu+o16xw6OL05lHyXVho2hUb8sZaBiIH1PkFaW694Z2hH/J+cezVyndVWL32qDyw5IUvCqqcLM/Ph1op/cXY8IiPA1Ag7gEvHAAJteOq7DpjmutUmhjjvUCiWKOUhfZjP8ZDgQZTFNtx2fWvt5agR5aI58s6NUfHRvefjI3nx+qgly6F5OD2KDd33i4KkpqEfPsH9Jj4BMTRLjLEaXhmcTFWrR+4WkVtt4l9QTGIy/aDz2sKo+NauFoljiqGuaQ6yWquTD/5dfHk22WIgsa4OOpfk6GNLKsqvRPbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9wYgp+L8m5kvL9WmXlglilDVYKdhLJxZF/3QRzui7Y=;
 b=MuHw3TlNUxdFtRfKBFDlIyVYIzbRNjmOy0qdG4oqEcRH4oDLOB8sHq0DvBvamKhMwAT0JlXBA9YXOFwViC8w0+HLa7DHkElXrG2t0VcUimj2UEQ4Lt/XO3/RtPbJNtR36kmFtVoT5EsGOBmntZ4DnJ1I6n8dN3VQj+lSIW1xJng=
Authentication-Results-Original: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com (2603:10a6:102:87::18)
 by PA4PR08MB6095.eurprd08.prod.outlook.com (2603:10a6:102:ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 3 Nov
 2020 15:04:14 +0000
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::2904:edcf:b299:f792]) by PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::2904:edcf:b299:f792%3]) with mapi id 15.20.3499.032; Tue, 3 Nov 2020
 15:04:14 +0000
Date:   Tue, 3 Nov 2020 15:04:12 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/4] elf: Move note processing after l_phdr is updated
 [BZ #26831]
Message-ID: <20201103150412.GA24704@arm.com>
References: <cover.1604393169.git.szabolcs.nagy@arm.com>
 <7b008fd34f802456db3731a043ff56683b569ff7.1604393169.git.szabolcs.nagy@arm.com>
 <87r1pabu9g.fsf@oldenburg2.str.redhat.com>
 <CAMe9rOpmiiBEZqLz-94_MEwgRky+EUsfd=X6Ue30H2c9R=dSKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMe9rOpmiiBEZqLz-94_MEwgRky+EUsfd=X6Ue30H2c9R=dSKQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [217.140.106.54]
X-ClientProxiedBy: LO2P265CA0103.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::19) To PR3PR08MB5564.eurprd08.prod.outlook.com
 (2603:10a6:102:87::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.54) by LO2P265CA0103.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Tue, 3 Nov 2020 15:04:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d16c2055-140c-40aa-c32d-08d88009d2df
X-MS-TrafficTypeDiagnostic: PA4PR08MB6095:|AM6PR08MB4721:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB472141745CE59167DF5D4A56ED110@AM6PR08MB4721.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: qlWbCorgoT6LSd807f7NozlhXqrSHxdp9DMXUIsVemtCZZ8BiD1mE0SkBKGJ7OFsYpu5wkQIHkxOaDX2B82MLQw196q+5oob+HBZSLnktrbKDcyRgcgUd0KIlvP2MXf63bmczzXeLJ8PRuERkQCyWowzAxHaRu0p2b0dRAdo/m2oD+GnJDdgviRILA3FvNWvzSmVX/IAxtZEZc2lNXH2n6LjHnWnsb8px37Mp0IB5qhn/hdWEqCwrx+A9X69m8mw/qS7MyvRdfSH9glOOtZm+f7R2absgBTAlgEULgZ2xn1qAmu3QeCj6PMGXMSrmDGSQWGB4bWRDTXFtFE+e3ORTaSM8pidCk0XbobXJ8ruUiC91MZLsczHIDTCZLuMEM17IMo0t8On7TiZlk24WPqUMA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5564.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(396003)(346002)(136003)(366004)(966005)(26005)(1076003)(5660300002)(6916009)(478600001)(186003)(316002)(54906003)(53546011)(8676002)(52116002)(36756003)(7696005)(83380400001)(2616005)(86362001)(2906002)(8886007)(16526019)(44832011)(8936002)(956004)(4326008)(7416002)(66946007)(55016002)(33656002)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: yoQcH15wDaLzHWNuTnNDRlSwEWVSNNy+BOiy+tKDItE4Ptl7Ii+jquJq8zNgb0H8LXtQzANLis5KyMHQ9xstCa/0vFpAU3qYeDkwNoF8iahh6mHqEVSeuznNaU3bvzV6ZfwscEyP8kLDPa8uQniOn1teHL6bHaGWkC47AcccLe+Ddy7m+7U6/HT0rHOdFFrmBw9ahSoXstKO/SDZnKzVrjhON4fpKDnn8OrXQNDxaLXidiPVpm9xMzxHC8+ElXRcc9/RAhQ849zWTEmwMashvQvI33mvBXhxooovysPNELvP/mn+VpgY0K3AjtZhJLmbJvfZra/QMJg266edz5M8Zd+hBszZXQcAtDVwOxWeui53qyoX3zG2SW1P3F3XqCDVxxOsK6ScS/WA8c1BY9ff89p21U6RQ3GsAtt/GSD3oqcW2+pSGf5k6DZFeMzx76RtVM2LB12ORHJNJfFBP+l4L9W+FbaYprwOR9U9iqTD2CQLrdw9h3plWmcu23sWLC7XZdLFQfaq+ZnLSyFcpqBUgzLGfR9mTMmP2pH2TuiXj+kSbJGnDMEgG0EhyonKqJKcc78jyy7s/aILxNTw0rluWmnqyjYg6Ajo2lNTT9Xiiv9D9MzDkTKF/0B3v4fELBQoNIorIQkRjd+vZvrFJrLBCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6095
Original-Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0392ab01-5aa7-471d-a031-08d88009ba49
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hcld4YfsaPBQT3Dpp0Ew4ZcMPM6S4cS8lun1omCqCls7cAp8uAEuaZqrzXbKZnN9mOOd048fCGbElP7+BiLzH4DcqC5osmOXW5mh4DRl/UCIc2KMSYratHcslnuP7tYeFFZQKE0q4OIyo7gFdpqgNUhhv32WjhpYAL+o2TVdb9D4YzvfO4gwz1oYP2p0+MmfNj3TuvmULWXxmwvFii6Iy/4yXr8vjto1Qh8QNnITn/Diaa2DN0FlF9n8OQ1zo5Oh6p9vrv3dxconFxFiy8H9A75pCpUyG40fSwmtEwZMJop8lwxe6451BbEjtIKPAi4bnz6aYA+fGL4nhXvCxhaiPny3I4egM4uLt6zkhEMvPGVD4F/jO6NtZVYH2LzWXW+PbrZjOBf2WHfhi1uOgt+3WjjZds7u+BW8NHnOUVftqilq6bg1OpQs6ZY4whFuk/bN6ZVdiuiyJpjfBeCiO6wfFQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966005)(83380400001)(36756003)(70586007)(8676002)(70206006)(1076003)(26005)(86362001)(4326008)(44832011)(186003)(54906003)(53546011)(2616005)(8936002)(956004)(478600001)(8886007)(5660300002)(16526019)(966005)(82310400003)(55016002)(33656002)(6862004)(450100002)(47076004)(7696005)(81166007)(336012)(356005)(2906002)(316002)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 15:04:55.2596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d16c2055-140c-40aa-c32d-08d88009d2df
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4721
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The 11/03/2020 04:36, H.J. Lu wrote:
> On Tue, Nov 3, 2020 at 2:38 AM Florian Weimer <fweimer@redhat.com> wrote:
> > * Szabolcs Nagy:
> >
> > > Program headers are processed in two pass: after the first pass
> > > load segments are mmapped so in the second pass target specific
> > > note processing logic can access the notes.
> > >
> > > The second pass is moved later so various link_map fields are
> > > set up that may be useful for note processing such as l_phdr.
> > > ---
> > >  elf/dl-load.c | 30 +++++++++++++++---------------
> > >  1 file changed, 15 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/elf/dl-load.c b/elf/dl-load.c
> > > index ceaab7f18e..673cf960a0 100644
> > > --- a/elf/dl-load.c
> > > +++ b/elf/dl-load.c
> > > @@ -1259,21 +1259,6 @@ _dl_map_object_from_fd (const char *name, const char *origname, int fd,
> > >                                 maplength, has_holes, loader);
> > >      if (__glibc_unlikely (errstring != NULL))
> > >        goto call_lose;
> > > -
> > > -    /* Process program headers again after load segments are mapped in
> > > -       case processing requires accessing those segments.  Scan program
> > > -       headers backward so that PT_NOTE can be skipped if PT_GNU_PROPERTY
> > > -       exits.  */
> > > -    for (ph = &phdr[l->l_phnum]; ph != phdr; --ph)
> > > -      switch (ph[-1].p_type)
> > > -     {
> > > -     case PT_NOTE:
> > > -       _dl_process_pt_note (l, fd, &ph[-1]);
> > > -       break;
> > > -     case PT_GNU_PROPERTY:
> > > -       _dl_process_pt_gnu_property (l, fd, &ph[-1]);
> > > -       break;
> > > -     }
> > >    }
> > >
> > >    if (l->l_ld == 0)
> > > @@ -1481,6 +1466,21 @@ cannot enable executable stack as shared object requires");
> > >      /* Assign the next available module ID.  */
> > >      l->l_tls_modid = _dl_next_tls_modid ();
> > >
> > > +  /* Process program headers again after load segments are mapped in
> > > +     case processing requires accessing those segments.  Scan program
> > > +     headers backward so that PT_NOTE can be skipped if PT_GNU_PROPERTY
> > > +     exits.  */
> > > +  for (ph = &l->l_phdr[l->l_phnum]; ph != l->l_phdr; --ph)
> > > +    switch (ph[-1].p_type)
> > > +      {
> > > +      case PT_NOTE:
> > > +     _dl_process_pt_note (l, fd, &ph[-1]);
> > > +     break;
> > > +      case PT_GNU_PROPERTY:
> > > +     _dl_process_pt_gnu_property (l, fd, &ph[-1]);
> > > +     break;
> > > +      }
> > > +
> > >  #ifdef DL_AFTER_LOAD
> > >    DL_AFTER_LOAD (l);
> > >  #endif
> >
> > Is this still compatible with the CET requirements?
> >
> > I hope it is because the CET magic happens in _dl_open_check, so after
> > the the code in elf/dl-load.c has run.

i believe the note processing and later cet magic
are not affected by this code move.

but i did not test this with cet.

> 
> _dl_process_pt_note and _dl_process_pt_gnu_property may call
> _dl_signal_error.  Are we prepared to clean more things up when it
> happens?  I am investigating:

yeah, this is difficult to reason about.

it seems to me that after _dl_map_object returns there
may be _dl_map_object_deps which can fail in a way that
all of dlopen has to be rolled back, so if i move things
around in _dl_map_object that should not introduce new
issues.

but it is not clear to me how robust the dlopen code is
against arbitrary failure in dl_open_worker.

> 
> https://sourceware.org/bugzilla/show_bug.cgi?id=26825
> 
> I don't think cleanup of _dl_process_pt_gnu_property failure is done
> properly.
> 
> -- 
> H.J.

-- 
