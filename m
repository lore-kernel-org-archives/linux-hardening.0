Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140EBC433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 27 Sep 2021 15:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA7FF60E94
	for <linux-hardening@archiver.kernel.org>; Mon, 27 Sep 2021 15:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbhI0Pco (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 27 Sep 2021 11:32:44 -0400
Received: from mail-eopbgr40078.outbound.protection.outlook.com ([40.107.4.78]:28838
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235184AbhI0Pcg (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 27 Sep 2021 11:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImOsG1w8WWZ8PcEniYFPLLrux+62JmUG/kHcqEhY2oc=;
 b=5TCpJROtwdeYswvnccGFF3IRqUfB3t2xCGbCTqiJOx8BPgxOPoo5Fm25C9KSi07Z6MYBVjDJaH/z5Ubw5H9XDm1U4QyKToury7qq4AwfbSdppJHL+4GQg06WN1ZasJMGXb6jJ85MKBUWmnmq/2+O4C21qRczUmG2Rdu2sKmvqCQ=
Received: from DB9PR02CA0011.eurprd02.prod.outlook.com (2603:10a6:10:1d9::16)
 by AM9PR08MB5972.eurprd08.prod.outlook.com (2603:10a6:20b:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Mon, 27 Sep
 2021 15:30:56 +0000
Received: from DB5EUR03FT011.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:1d9::4) by DB9PR02CA0011.outlook.office365.com
 (2603:10a6:10:1d9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.17 via Frontend
 Transport; Mon, 27 Sep 2021 15:30:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.33.187.114)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.33.187.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.33.187.114; helo=64aa7808-outbound-2.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-2.mta.getcheckrecipient.com (63.33.187.114)
 by DB5EUR03FT011.mail.protection.outlook.com (10.152.20.95) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13 via Frontend Transport; Mon, 27 Sep 2021 15:30:56 +0000
Received: ("Tessian outbound 0e48c0de19a3:v103"); Mon, 27 Sep 2021 15:30:56 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 51dd7f62de5821d3
X-CR-MTA-TID: 64aa7808
Received: from 0e48d0915ece.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6C1114FC-7C8A-45E0-BBF1-467F5EAE268B.1;
        Mon, 27 Sep 2021 15:30:43 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0e48d0915ece.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 27 Sep 2021 15:30:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b42x1fOAQRZY/u45n1vvW/4w+7UV3qXq3B5pzQGcug8TbJJQq1RwCz4EtPRM1rx8GX7UCDUwVX0wYzbWcGjvtSTa2uXw92zsc4Y7X0YHZjiRuB8Z8PpNaB1QWl0gClwi5NPFHGY1xVwj6llWwBWt6QCb3bldridt0hu6VvOjAmQacqtzljZpylR26dmKydldeBJ/dsZknEBdnLovxo+BBa3mLRv8nIw4BiexcWm/pXLnAda0AaUrAPi19O6YKMgLMFP9tteRrcOIYXHjnIReMHJs3xRaq2HrD8B6E9EcHtyXWo7rWIUO4NaKGxXPDW0etqhsDY/LwvK4nrEAKkyIgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ImOsG1w8WWZ8PcEniYFPLLrux+62JmUG/kHcqEhY2oc=;
 b=b/vcIPtLYuUZc6tgSVQPa0GppWYVEeTOGUrzpbEQM4Th5sqYc0j/DYA2OM8RcPWpwIx+iEIN8c/4Xc2t+jOlvX/hoAr5/EsOHDPy6Slwu1otPYfRfiaBYsRHbcrbyiXSPPHMKH4D2eQthACHFnK7XvmObmEqaGRjL7rHpY2VLRCq47xaHMgBScUxsNghNXItUlfG48dr+zJ6b1BITXLyXx4rnZTaWyztpMYI5oJG6Bc5xrqx6hZVvc6zD3badje+YQ1l4t6SsWZyhXQepbDj3XT0JaNllx0+lFqRsvEsJX4ElfbKU037ACKkXF/kZDZt7lVdspyAJh8lZN5th5TVHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImOsG1w8WWZ8PcEniYFPLLrux+62JmUG/kHcqEhY2oc=;
 b=5TCpJROtwdeYswvnccGFF3IRqUfB3t2xCGbCTqiJOx8BPgxOPoo5Fm25C9KSi07Z6MYBVjDJaH/z5Ubw5H9XDm1U4QyKToury7qq4AwfbSdppJHL+4GQg06WN1ZasJMGXb6jJ85MKBUWmnmq/2+O4C21qRczUmG2Rdu2sKmvqCQ=
Received: from DB9PR08MB6460.eurprd08.prod.outlook.com (2603:10a6:10:254::18)
 by DB9PR08MB6763.eurprd08.prod.outlook.com (2603:10a6:10:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Mon, 27 Sep
 2021 15:30:41 +0000
Received: from DB9PR08MB6460.eurprd08.prod.outlook.com
 ([fe80::edb3:cc65:f2e0:203c]) by DB9PR08MB6460.eurprd08.prod.outlook.com
 ([fe80::edb3:cc65:f2e0:203c%8]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 15:30:41 +0000
From:   Ross Burton <Ross.Burton@arm.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] scripts/gcc-plugins: consistently use HOSTCC
Thread-Topic: [PATCH] scripts/gcc-plugins: consistently use HOSTCC
Thread-Index: AQHXsMIs1bZyVW+fwEWHPae7z6NPnau4AhUAgAAWawA=
Date:   Mon, 27 Sep 2021 15:30:40 +0000
Message-ID: <C0C655F0-638B-4795-B56E-8B7118BD547B@arm.com>
References: <20210923152811.406516-1-ross.burton@arm.com>
 <163243252379.3933826.2645114887075876479.b4-ty@chromium.org>
 <d2b6c3d1-45a6-5820-cedf-28390ffcc8cd@gmail.com>
In-Reply-To: <d2b6c3d1-45a6-5820-cedf-28390ffcc8cd@gmail.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.53.21091200
Authentication-Results-Original: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=arm.com;
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 5433e5ce-e20e-4766-b37f-08d981cbccfa
x-ms-traffictypediagnostic: DB9PR08MB6763:|AM9PR08MB5972:
X-Microsoft-Antispam-PRVS: <AM9PR08MB597283AA063259CADA8604D3E8A79@AM9PR08MB5972.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:1417;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: tlR8/UeWkanV/HfpHgV+plldxKu7Ltg01hfVqRJXXI0kyNNW5/AGSV7zzNxY+IXxBZGy43mVDjozbCcSu6v3J1qn8BQ3+FMc+KstMYuMIMRDWQS7A7kE7w7B3fwazkdyMF1aPKZYE6peHUfodI45GrvIvpDhoIEzdpPfeiNz8vJ0ELkEKKKhpKk8w0co8nZH2X+ttQ5BXOKL0QPiKHwFwOeYd/c0YvAtTqJml9olEZf0D6mINKechGiHpKbaxoSVPA+5V1LXmdoFE7pQA7a0Hh1NvQB0lJ3mYeMSdY+4mtxYBMaQvYanLKYZ3l8OYt2C8NkwfbOHa31kfJ8VBXP15ZkKLvu9MocM4A+7KUyY60hRCX6HUwf20KHE8H7CeW2j8WoYG7kyqyNlA/85bk+4uKCa1YwboIinUe5RZtJsAGK3sjPLYqmsppEFp50V8fShwEENDtFy4qvWCqmOPxvXkHmZr8SeSFBgMJ8iGs+xY+ZSinHYU5RfzdsrqhdJGY8MJs1vxGOeItmKJNM8wx1YbfVWbmI/1x3eFOv1UfSKR4vc50szbtFutDcqi6GaTpy4SXEvxJis5kwXN9kzQjFcW1Eq9jYd6AuFF6dmdoLwRAuZfguEsoHayPitMvdp4N+H8EBQsxElCKsJ4uKa1A1+x60Vn/pjQZYR+Z8fXF8CLCgPQnhY08yso9CK5rUNei7i2mrqe/IgNqrK5gmRSbVeOOWs390yHJeA3OeksYIvflM=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6460.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(2616005)(186003)(83380400001)(6506007)(316002)(8936002)(76116006)(6512007)(66446008)(66556008)(64756008)(110136005)(38070700005)(33656002)(26005)(91956017)(66476007)(71200400001)(66946007)(2906002)(86362001)(508600001)(5660300002)(4744005)(8676002)(38100700002)(36756003)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E340B9C5A904BA46838FD4E813E59337@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6763
Original-Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT011.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: c4048bf2-2b78-4a7d-c28f-08d981cbc3b1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gY4uPdo/+91iKzBNwuKseOjnDqj215yHV9HZTIXO+dwwCx5usJ1BFFZ0cWge/97FmfBol6ylWE1LauoifdPYFpuGyvsqrI4KrbHZ+fl6Iw22QprCNy2WyWgih6GDXvRLzt4AOR57tQs940oFC4ef2niPkALlA27HCdSETJejNcWIAvd/izWfUoCB50DXOFxu6AyEHITeR/ojrvA1ualZogiLvOONI7/ztC/rfmU/0/0of3rbFSHqIgR3FKhxr/8RXntfX5vrqvq+YOc9vjdU/dEpU+OEzV0z0mfis2HqJNfnX2l3EU5TCxyzMsI5lnwzsS4PLsL/EYsEpfBnBfZQ20+Aa7PxurffzTpvcLH3iaMIggspAMS6nmj+DrGj05JuSVbYsQFTkHgrSOVF001kTW8FCiDwekm/oqbDWeDZXr8XTLVd28CBuladeTpGdgj8HcMlqy5o1YdYz2m+bY6vEQfwMySlDh8vajCfug/BXndXzXm09x51wnBu8C+pFByWoDoQB0KCchaivMoHgypXurkl2YNHQYbY7j3yM8Quuhu9uy00YOWzJwmWtctp8GaOVmYlwPR2qJlM8KdF4+IYbXVRcibQVoqXMB1wMw6W8Glz7CXrFPFTrOkSHSzCYeIBx4gqnW9edMxvbvC41VVnTurUzWN6DH2nRhAqSHhlWhCWth2G2S6k+AuDDMWNyYP7NNuWxm/bVb9H+TjvZaEiXg==
X-Forefront-Antispam-Report: CIP:63.33.187.114;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-2.mta.getcheckrecipient.com;PTR:ec2-63-33-187-114.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(86362001)(36860700001)(2616005)(33656002)(8936002)(336012)(316002)(186003)(36756003)(47076005)(2906002)(6512007)(82310400003)(83380400001)(4744005)(6506007)(70206006)(356005)(70586007)(26005)(508600001)(6486002)(450100002)(110136005)(81166007)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 15:30:56.6867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5433e5ce-e20e-4766-b37f-08d981cbccfa
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.33.187.114];Helo=[64aa7808-outbound-2.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT011.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5972
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

PiBJJ20gZ2V0dGluZyB0aGVzZSBlcnJvcnMgd2hlbiBjb21waWxpbmcgQVJNMzIga2VybmVsIHVz
aW5nIHRvZGF5J3MgLW5leHQ6DQoNCkhtLCB5ZXMsIEkgdGhpbmsgSSBtYW5hZ2VkIHRvIG1pc3Vu
ZGVyc3RhbmQgc29tZXRoaW5nIGFuZCBmaXhlZCBvbmUgYnVpbGQgd2hpbHN0IGJyZWFraW5nIGFu
b3RoZXIuDQoNCktlZXMsIGNhbiB5b3UgZHJvcCB0aGlzPyAgSeKAmWxsIGNvbWUgYmFjayB3aXRo
IGEgdjIuDQoNClJvc3MNCg0KSU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMg
ZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBi
ZSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVh
c2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUg
Y29udGVudHMgdG8gYW55IG90aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Ig
c3RvcmUgb3IgY29weSB0aGUgaW5mb3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91Lg0K
