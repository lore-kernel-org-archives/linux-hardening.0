Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE342C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 00:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90DB860EDF
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 00:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240398AbhJ0AQT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 26 Oct 2021 20:16:19 -0400
Received: from mail-sn1anam02on2084.outbound.protection.outlook.com ([40.107.96.84]:19332
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240388AbhJ0AQJ (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 26 Oct 2021 20:16:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABh9zPggONGurFOlHrUoQM9TA2AYwm2pfupTleW03sbhTURyDsg6sg9HbPVfVjT5Sa2W4JPrBqCg4ac28m38R8hq5S1sLg4cybybP67fZmpzaV4leI4P5yTPZbHFbunWLoe9Zu94jJCut1zoju4IkYgF1S+lN8LIWnek4HGjoPxTYkBDyU2ZEBpAAaZQ3DnI2TTMyZPBYIvXz5xgqSpQ6PzWRs3CX2A5T2NfJZf/IFvwneAaqHlzrMm4mAWAwuFg1VhhJ4k9iBQHZrQeruLpNUkZw45FsLB5VlnXEMQ6AzdZnYONEAiVBxlg0ZF3Ak83VuH2L0cxcEiFhDYnDAFuMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nneFbQ7bRtlq+uAj7MPgmyaFWI3TkWvPTRoGZAUaoGk=;
 b=hNTliiJkH4qwq+O4okoBGAx5+2AeH5HFV1HQDvvS8sF9RwcpKJt35argwjI97hNLOzp4H/RlqLUtSKr9EiscH5wrm8re0FluCuKYYr+n2FsXLnjeOKXs6SG4ClBrnW75W6vXJ/792Utaw2F0ElIq9aoyBJzZnnozW5REMWaAOsOfwxcEGHP/eHPk8pwWjrH1BlELt7FA/EWSigxVesoFl0XS66eZih2bRFz6WOQZPxhAZYRB4Oi+AzOIj+JobGrq1EnTNrI3TquI3RI06PEaJu46nQRvXLvnFV1cvM0/xIayrqQ5UehLgmxJSe/F3M7OPG781jqYOjtpIQNPzoJ3tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nneFbQ7bRtlq+uAj7MPgmyaFWI3TkWvPTRoGZAUaoGk=;
 b=atsDURpoZT+rBy/elgFTMlMrhsKVKGMver4yA6tmANcyl6F0liphEIGmQcRuIw/fKWRTRI/kQMT+9H3BpZsKtfkJT+SE+HPv1DXSnqWPjCk8tOg+9FwbkIurEAjV8p65jBNAC1/TdPZ1eki298sy+D4dGoqQZk2A7QRcsvlJJ3Fm7R5S8bcPD/JZHGW6QpLkrXZ1bU6EnZJUFhBc7UUNaOx5GAzInBSHO7Vwc4446wJD8ECQABg0XjRZny6Uy/d5JsKRlhIOt5erPXgJbH3QaIrj1WYSCMjUWqdEhWj81QHfXIvQPeQnmxPNuYIwmW+qwnw78+JOc0LJjH2xuWyDXA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 00:13:42 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 00:13:42 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Len Baker <len.baker@gmx.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvmet: prefer flex_array_size and struct_size over open
 coded arithmetic
Thread-Topic: [PATCH] nvmet: prefer flex_array_size and struct_size over open
 coded arithmetic
Thread-Index: AQHXyPzChVrZ24+VpEK7ak5rDkGCHavl/QSA
Date:   Wed, 27 Oct 2021 00:13:42 +0000
Message-ID: <b4c1c399-2332-e594-15e0-bd4883818c58@nvidia.com>
References: <20211024172921.4110-1-len.baker@gmx.com>
In-Reply-To: <20211024172921.4110-1-len.baker@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e8f9fe9-1390-481d-9ef3-08d998dea257
x-ms-traffictypediagnostic: MW3PR12MB4409:
x-microsoft-antispam-prvs: <MW3PR12MB440905B6F88F3E54F5045432A3859@MW3PR12MB4409.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3lsjIq7TM81mRKlK7GNwZF9Lq++hvnstqvf59bzUXa9Km2fMmxbvlDHifx0bWYq8ksSM12KpEZfn1VX1BG//O0eNDfgTTq+iFRdtPQY7enP+Nd/P96yNTpY5TZJ8lA7LqQ5mplnwT/hFEt2zo3k+lL/Xdb00TovKkeFUCholPRkm73V16uTrt141eGZuU7qlCgZfhvqhGjFT2jPva9IawUbavYjfCUZZaOT3tEC81oDG6qUqPzwI84nza9PIY8cfMr/s02r4Pm4da1cLcabNShK2W/ciInbKz7V2/2QLzdrXq2KfKh4GGLsNJt9Iu7FkU01eYUi53CCeQVRn0wWnoxMaydRr+E3jW1O/4domF6UZQciCGKK30bILosc7RiKmDWdnlI+q/ZMG+KNVxMz8pQrGXE5FhyraZB92LA0AnVFm/5M86sGOz5G2EuLizrUya/RxIvKLJh9CYg9fK6lj4ANuFos+PdG/Zd/HU7eIaKZLB89dfZOZwd+8QFbget6XVsmEnN8m/zkebK8cGd6hXmR3vmQbr9e0O2JjeQu6RBswH7LnVcGo9hGl4HQPZvp6X1h07WfNCuN0wRK7i/DBcBxCKsuvVbnPghTtpX3Wlky2yibdPHmQljEjBbAfd5Dsum2g07NwOhxEj44GtxUkOE1U8ecaL74m3+GAFjDNGyxbZKVFO/yyIp+3yzx1IEML3rTy47QFuRBKc6uCVLffGhdtF5qUcxLu/gHmbxQwa/fV7LUxdKrl9s67rtKgcsexNhtLYAe0fVIRQKIscm5+9XLwCDBXycZ4N7F3FBH4Cn9wYSa2ROUTzIIbPjv+bdesKlouGi/vuxKZYYnpve4dhylhjwGmAETuQcPpHB12pAI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(86362001)(54906003)(76116006)(4326008)(966005)(8936002)(66476007)(31686004)(508600001)(110136005)(5660300002)(6512007)(122000001)(53546011)(8676002)(71200400001)(2616005)(66446008)(64756008)(31696002)(186003)(4744005)(38070700005)(2906002)(38100700002)(36756003)(7416002)(6486002)(6506007)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmFmNVZXYWN3VnRmYXFubmFkbHJNRWxTMWVjeVNzdTJzb3E5azZKTDNKbGk5?=
 =?utf-8?B?Q2ErcS84Q09GRHYxZUVsRmJ3d3BjUlJUMFJHdWpOVVc1K1VtaWFnN1NMTUVZ?=
 =?utf-8?B?aDY3S0pQNkZxRUR5WkFuMGRITWVSZUpNZ0phdURwa0MrWE16d09rQzJLK0hi?=
 =?utf-8?B?TkNkWFphcDJhbWQ4b040WU5TbVJsbGsvVTV1YUw5N0x3cG1RZFd5UCtXSWxT?=
 =?utf-8?B?dHlFQmNENjJjUlNFVTNLdEp1ejlqNGJ0RVJUMGt2THhHTitGZ2tKOHJFUm03?=
 =?utf-8?B?VTgyU0xGN0lzbjljaVFKS0lINDFvMHRoaEtqdk4reGJ5SmZIaWhVdWRDMGZB?=
 =?utf-8?B?dSs0S1FJODk5WkRMODFiWTBvM29nZEl5clNLbjVFb2RJVG9hNEZ5YUlkWHJu?=
 =?utf-8?B?b1V6a0NCajVsc09pcDl4VC9kb2ZDb3FwRzkyWXBOclUvS3BNYmI2OXRXQjVL?=
 =?utf-8?B?UFhPR21NOVkrMDdtS2hSaEJDN3FMdVNlblliZFRBRW41bWN5WGpqNmtLZkxk?=
 =?utf-8?B?L3lDU1VQaURDM1BUd0VSeXliOTE4T3RhL29iU3hXU0JuM0dRRHA2U2k3OG9W?=
 =?utf-8?B?eCtzRWNaQU54bklORnpCdE5JMTZTdVduN1Y0OFovNFk4S282TFgxU3Q4WHJ2?=
 =?utf-8?B?MXAwQzBUdEljR0ZPZDVnUW9RT1hSUUQ3MVc4N2EvRVVnV3A2TnhBNTFOMjNM?=
 =?utf-8?B?aVVVeGlPK0NqRU1ZdFZjbDViUTFEUytaVitPM3NqT1ZnT2o2TlozWGR4SUd6?=
 =?utf-8?B?Wkx3NFdpZDdTa1NzU1BzZFUyZFlQQXVJNFFiY2VoN1RqamlwUGxYUlRMcldv?=
 =?utf-8?B?M2VOMmVPSURqWVZyT1ZNNGFIVjBqRWgxU0VhZk1nVG9NbkZldjJXVUhRSnJp?=
 =?utf-8?B?ZWlXWXMwdnVrZENKSGFJaDJhaU1yQ3dSdXNpZ2pXOTF1d3IyVEpYU1UwWHZX?=
 =?utf-8?B?U2QzMzBrWW45V2NLWmpXZUEyMWhPdkJSMUpLc3h3Sllvd1d6UzBGazBRYVpl?=
 =?utf-8?B?cm5SQ2l1SG5ZeFFQdzZxeXJkd3A5K1g4clNMdHRueWRmVWNlZ0gyaDZna1ox?=
 =?utf-8?B?K3FRclpnWjBKelZyc3I0UUE0dDlHUnl4YTk4RXRoNUZsUmJTNjQxZHlhczZt?=
 =?utf-8?B?V21jSGxkazl3d1hJa0pNckF0eEdlVnhvSjR1eHRkdm1ncW4wTXdtZzNWSit0?=
 =?utf-8?B?QjhBbUdKRjY5K2lIejEvYWNsNUx5STNlZXZnVDIyVWMrREdZcVNtTE1PQU9q?=
 =?utf-8?B?QVNqdk8vZDBCM2JKTXFmdU1ZU3hIcC94NG9FcS9lamlJZnEzR3FVaUdwbSty?=
 =?utf-8?B?NGFjUzdodWZvcmJRQkJPNzB5QmRWKzRMMncxcVlJV1g1TkZ6b01vNXFJSzAx?=
 =?utf-8?B?QVR0enRnSlJubHh1dEgzVEFnWjNWSWJLSXdremFHTlpnWFM0UVVQT0lhVG54?=
 =?utf-8?B?c1F2MHdMNWtETHdHOW8yK1V2b080Zjd4WHBhc3BtbDdQelJuMUN5bHJjV2tj?=
 =?utf-8?B?U0dpZWNmZERmbFFSQy91eEZlU0R5ZmJ3OVNsTW5kNkxaYUN6SE9LMlZOOFBn?=
 =?utf-8?B?amJhckhIeHJKaUJ4VDg0UFEreDgrd3l5U1pXU2J5cWJkVlFQaXE0QnZhbHhM?=
 =?utf-8?B?dXdhZEJwV0p6RWRGTHdNMkhUS3JoTXBncmlYMUxGeCsrRUZmaUwxeERaS0RV?=
 =?utf-8?B?L1pYNDN6azRVWStiWFNkMmNFZTJ5SFVIZ2pQRWpPSVZXMmhEN05hejU2MFV2?=
 =?utf-8?B?cFhsZk1wbUxqQnVrN3J1M0NOakZ1ajcrV0V1eHlJTVRCWHZpNWpkVVEyNi85?=
 =?utf-8?B?K1RmbjVMelprc00wczZqc1Ayb3FqMjFzMWw2ZFMyM2pyZHBUWGp0d3hjZ0Ev?=
 =?utf-8?B?eWxBRmNJZmdEbXRrY0VmaDE4S3IrK0tnc1RXZ0twUkZDazdaYnQ4TlV5Z1ds?=
 =?utf-8?B?K1NPTWtIUzBwazRZVEJTSTdkR1VEVEdPNUpsMm43ODZmZFNZMGRNMmJTb2NL?=
 =?utf-8?B?WHRqc1hjNnVNaDVTNG5SdWlqUmp3clZ6RWhENUMwUWJGTUJvY09PSjEwRVlN?=
 =?utf-8?B?NXM0ckpUQ2FyL2M4UWxWYmsrK0tYSXVZbEI0MnY0OUE5RUFhcE16VnFnRktr?=
 =?utf-8?B?Tjh3dml6RHAxU1R0NFhwQWYxcE12bmhybGNKSEN1K3NVc0RtR2tHSzUzN0sr?=
 =?utf-8?Q?csB/A8gSMda+0dZzT4fngqIdErUVbpnXUPkWQIe13Ufg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8955F4B0CF2CD5478FC0B4BBA71B0CCA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8f9fe9-1390-481d-9ef3-08d998dea257
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 00:13:42.2299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tipvyRK4jTUk+j8e+fYQZWKuI8EC0MwiShRgXZW6+gE7MGf2uvKOYlBBvBtjVMdPjxMMz6Bq3m52XA47CMOXcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4409
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

T24gMTAvMjQvMjEgMTA6MjkgQU0sIExlbiBCYWtlciB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWw6
IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBJbiBh
biBlZmZvcnQgdG8gYXZvaWQgb3Blbi1jb2RlZCBhcml0aG1ldGljIGluIHRoZSBrZXJuZWwgWzFd
LCB1c2UgdGhlDQo+IGZsZXhfYXJyYXlfc2l6ZSgpIGFuZCBzdHJ1Y3Rfc2l6ZSgpIGhlbHBlcnMg
aW5zdGVhZCBvZiBhbiBvcGVuLWNvZGVkDQo+IGNhbGN1bGF0aW9uLg0KPiANCj4gWzFdIGh0dHBz
Oi8vZ2l0aHViLmNvbS9LU1BQL2xpbnV4L2lzc3Vlcy8xNjANCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IExlbiBCYWtlciA8bGVuLmJha2VyQGdteC5jb20+DQo+IC0tLQ0KDQpMb29rcyBnb29kLg0KDQpS
ZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KDQo=
