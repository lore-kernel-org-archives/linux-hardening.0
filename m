Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F0EC32771
	for <linux-hardening@archiver.kernel.org>; Mon, 26 Sep 2022 17:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiIZRnn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Sep 2022 13:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiIZRnO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Sep 2022 13:43:14 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76C0FAFC
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 10:11:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P88ESZIounCyOxLDUrP+xqLhzFfg0MFTfZFGz8s4mjccrLLpEARgoEnM/lF07qVRSXRTKMvOekRb8Kd+FZsUyvolXO9OrLfAI1H8zuQZE9AbDgsbnio6VR+/7HK4aN3rXqQnz7qOt/p6GClTRpTA72ZFjsQxPlACWJwAgHwYNdZhPJMDRA3gsWF+iiVnP0ZNf0mGapxSszAmknIo+m+xnTdXyhBLcKRshMzXcT8WQ1m60H0XGoG53x7byGB/O9FQ37+ZY63oJC7Z5ATROX1zTPW+dVHVD7ydyRPaNmZOsVwUPTnhBlkdvJTJXptmtyXAxCy9NaozBO7gr5nrJxaZ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/U+juHUYlHn3nKfyUHOLDSBk308quRviC89HnSiKiM=;
 b=bdeFfqaPX3dHozzoXJ5ZFktcTVzkLIreU4j+YOkdhurTvN/VMrKkDKv7laFRUZhh+omDeBnv1lCLb1Lbct9QnhLi3C8rnIt/NouN5RNGA1fIKN11LZia63MSXxYWimZqx8FBIPL4DYDnCK6kVFfa/ss9KJvgIsk7Xolp5A4COTyAq0JcPGeCxnyAi6pDPqMMMxSJPFIqTY0UNt3RgyE61WXH6OZI3OkKqmCMKRmg4oCdu1w0gHqlFYSa6Ojwx5cl8X8UbbovAoHNmBYGALM7ytM9PejeRLNAi3mQa9cJ5FRToXxel5Ltupg9PZJQrph+Uvhcv1FRprgJkmXxZyNtww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vu.nl; dmarc=pass action=none header.from=vu.nl; dkim=pass
 header.d=vu.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vu.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/U+juHUYlHn3nKfyUHOLDSBk308quRviC89HnSiKiM=;
 b=KVD/TTiPNpTpTa5g7jc5TrfHu51Ip0rt07sEWJe5UaXdDUMQC6YyGKmbDMJb/HLRNGohARGA1yQ283JADFLert4VGNllEZuN/DJIZPpLaFYd8f02Ubpqqu16EJeaMDu4Qmo78+FV317bHnuApCMapCq/9yjTXrPJCN70fq/LlKchn6CYfFw9GUB6Sx/tUpOzOSHKCJYDpNxeR8MfcvncyfTQZK3pRDjwD3AsAKti1L8G7kgF/FqrXN+ILTmkPtQXUCtFUFToO8y+E3Zwb/RzDHrTK2oQO3yzvnViY5cGXRdQXtp7BpvpBk5uTkUzBngwR7YQnOvgBYcG0KPbzKKPKQ==
Received: from AS8PR09MB5927.eurprd09.prod.outlook.com (2603:10a6:20b:54d::14)
 by GV2PR09MB5868.eurprd09.prod.outlook.com (2603:10a6:150:79::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Mon, 26 Sep
 2022 17:11:30 +0000
Received: from AS8PR09MB5927.eurprd09.prod.outlook.com
 ([fe80::1d1b:8969:ca8e:7619]) by AS8PR09MB5927.eurprd09.prod.outlook.com
 ([fe80::1d1b:8969:ca8e:7619%7]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 17:11:29 +0000
From:   "Koschel, J. (Jakob)" <j.koschel@vu.nl>
To:     Kees Cook <keescook@chromium.org>
CC:     David Malcolm <dmalcolm@redhat.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: -fanalyzer thoughts
Thread-Topic: -fanalyzer thoughts
Thread-Index: AQHYyDecy3nYvGAVB0GMFAXGEsNT6a3yBZYA
Date:   Mon, 26 Sep 2022 17:11:29 +0000
Message-ID: <A6EF11A5-9048-41ED-B4B9-71C1F50578F1@vu.nl>
References: <202209140501.412181C969@keescook>
In-Reply-To: <202209140501.412181C969@keescook>
Accept-Language: en-US, en-VI, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vu.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR09MB5927:EE_|GV2PR09MB5868:EE_
x-ms-office365-filtering-correlation-id: 52252963-4e45-4afe-da2c-08da9fe22763
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4aQEQTznVInX6XcqXfETzYBI5ncn+sUYJOuKdRdHsdDdHJnJrH1yoDr2oBTPDdHaWNts44COk54k+TmWfsiZBP9cUIeWYlVEj0saf82RfhBCg7p8L6iLfzQRx0bdl/dQpwbWY2b1xYKTPwCFFBXJUQ6QdHCu9jDsJgKuOc/9LSIVw0TuoABlursQExzWOAtHdmC8we8jusAxfcytFx5mPiJRogW5XNziDWnTcWzxxg6Cp3a/yhfUjNZJLGu8fXVkWCEg02jhSe8RuC47Uq+E/d120Ho/znc1k/rp9JsPxK2lpBpUGork6kPdAIXtGZk9p4iI1WMnxZVlxIXFT0KVhQseIyxo2i/HKm/cZWKgnT/PoMYkvw1MvQQV8HQUcTnaHrRCTvTDjuCD6sz2/bKKvhHyy/yi5QM/Jea+8vWgMmHIfYHZa1Hmxw0zM1+00UeF74Dsl89/VNkjU/ZFTMmXCE5RZkaJ/pI+Z26C/brgGsXAoC2vcklG+tFQZM4wqJvI5PScYhc9vnqfL0QT76cdGsPvlMepcjccV3CVlb5OIdKJjizqkJaEKmJnH6A4A7YfOySjRc6adITi4YQlOOWxpnfFf7+cnVkGwjm2mxkjhniSoeUgZi6C9+wGuodnV2VEzcmm7mbyoNH6cj9e5s1zFmX/YkrID4IiKIZopuNDxgpFIzIsdVGvpHg8zDxyrj8fVUP8vqA7RiCkjFSHOU6a7VJdp5ZKL4Ut9AGDeqvwHq58987KdlLs8oEaiT6B2Z5V5c0zxgSZkqfyB7QGq8LUhLJW3G/aan4mvbv+RUAeNh+9e/6MJS+OElQ5WQwJnqfJdORSxoDAeY2xNzX0SwHq9cUyzgbf8Bhs6pWhTpFS4+g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR09MB5927.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199015)(91956017)(8676002)(71200400001)(41300700001)(38100700002)(2906002)(6506007)(966005)(38070700005)(478600001)(6486002)(36756003)(5660300002)(26005)(2616005)(6512007)(122000001)(8936002)(33656002)(186003)(41320700001)(786003)(316002)(86362001)(76116006)(6916009)(66476007)(66946007)(64756008)(66556008)(4326008)(66446008)(83380400001)(54906003)(15398625002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tt4JcUXavkiGPze5ufwvd+AvVAW1OD5xeHfso74KfogJ+EIQeSBphniVXC4x?=
 =?us-ascii?Q?XeXZcFQuKPsLQ5um7DWO0wIxWB0DyY1tefLVx7diI8unl+OkLbbQphxh3slm?=
 =?us-ascii?Q?VTlZ76BECQpP9iC9tnGQZ/+GuJIfQe3jxs1gI7tDmG83yGuEz1w08n2hN2IY?=
 =?us-ascii?Q?oJr3U+JOf8WgiJKaYcyj4CeQNON2TDciuFOq9KQP7FSomBZdMqx133sk7hX9?=
 =?us-ascii?Q?M1wM2gY1UmdV9BkAYfvb0rwwivzpEaSVqviU+00Jz2JRc3D+Mz66ICQORTZB?=
 =?us-ascii?Q?M/xqm2ySCaEnJE+BU8MD7YbFzaARoAX2bqTgZTySzp7fxkiXnouvWb3hkxRs?=
 =?us-ascii?Q?WpB0BQgovxjpLOBdtAeFGZKbTBCUl/8r/vj986cWSEd+qZJoy4Ks3cqMk7dI?=
 =?us-ascii?Q?BhsChl0oeSth0oWQydaxipzSrYhTc50tZ38kAZk3JgA2YyzAobbMjFhUIDMm?=
 =?us-ascii?Q?a/oa/h619014V4w0QrwwkTNFQw0YfWsefI99YKMGvp0TvYd6vrBzv1JrvQDl?=
 =?us-ascii?Q?MDmlYMYxVeePMWETXBoBZDKZm+RFKOs2qeB2+tCxYgEZNizLz5dDLS1/BvXm?=
 =?us-ascii?Q?TpVwdk2/+c4UOsA1eekZgsg1VW7d1QxnzzgMgKH6Zwrd7Nzt9sfQzVaeWgWA?=
 =?us-ascii?Q?OgIC1gbekguyTA2IFXMdS+kN7+082zQzycfrufyrlDDk1b+XY4uxYtNFbx+T?=
 =?us-ascii?Q?PKFBkXDZurEKKpikpC5u7/4EtgR2OKKAURd7tRBV8Sqwo2hdXpDhOkfprdmY?=
 =?us-ascii?Q?fwcDTUJaFhAbEQjIjtr7GlOFlGDdYwklfy+Di2zYzi9hK114Zyp/Y5wW1iek?=
 =?us-ascii?Q?IJyJkITNHrYZNm3QCXlio/RlgjR8yUlDCkJvJ24NYd3mHruUQGabRajN+xeR?=
 =?us-ascii?Q?wgTzPqTHM9HTY1njxxiMh/zaEIRcg+pB7+8gfYOdDBbvXbZa6LIgDT0jEPQF?=
 =?us-ascii?Q?S+Hw0Cg+EUoUCbj3XmSpI4p+9uyfWp0G2P4kivGYYp+ieF6XT7FBrIkoxQ3l?=
 =?us-ascii?Q?7us6hdNblDbo4UTzWs7OZWtGcTGk2wBBWpICb5XivfpCVXxuUcJ77BvQeT8t?=
 =?us-ascii?Q?TwBtoxr05u8DriOPhL10jwdqRD7ERij/jUBhRbxZs0vkRLmeVtJxfyUr6eSo?=
 =?us-ascii?Q?iXFcgNWeZkQsPjuTfmXPeH9kZiUFhwgDPGA0C70D5Uio6gUx4o/3o3IUxx+N?=
 =?us-ascii?Q?thngFDly9L5LP8hgYIUtI6cJzn/jEgGkevKVOYCcOTx4nluhkb88QoN8yZW3?=
 =?us-ascii?Q?OZw03acD8plwAppPCMmg+qYjK9OIEP1NJbKA/K/lwZMBvG0dfw9ynoGZNxJ0?=
 =?us-ascii?Q?LxVaseGUWZjMbpBZbKiqjgfyHPJ1veCWF2e5eNpj5raZrhZelgIdYKFKfVHi?=
 =?us-ascii?Q?uAOKLFuU7yt9WXgMGAJb4NBZoU4k7o2HLetm8Cgt7+2DEjpmbRJDSIHb0lQ4?=
 =?us-ascii?Q?RPoqRPGOgEBkBSkHOAOJZfNbbgW39jKNZ3mhHBxngGV+YYJ9WFtphIvSINBO?=
 =?us-ascii?Q?ASU4yNwk0Vm8yKlD6h/oJ0lNk2wd2mj/4oh+B1pQ7HiVMs2c9VSh2Q3MOPIU?=
 =?us-ascii?Q?xEYabkCSleCAFxiUMGyQN+3XGW3dRMtooXRUXB1B?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <97BACD076A01C149B1F6F22042D71543@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vu.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR09MB5927.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52252963-4e45-4afe-da2c-08da9fe22763
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 17:11:29.8001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462a9c9c-2da6-4bfb-b318-0f83043fe49b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R57pV7umHUxah7xBaDcZzGuSfvVrVnH4ndvKDgDseJ4Yju8c/h6ZFU46DS+cO60I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR09MB5868
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

> On 14. Sep 2022, at 14:43, Kees Cook <keescook@chromium.org> wrote:
>=20
> Hi!
>=20
> [...]
>=20
>=20
> The question I had was if you had seen this LPC presentation:
> https://lpc.events/event/16/contributions/1211/
> "How I started chasing speculative type confusion bugs in the kernel and
> ended up with 'real' ones"
>=20
> The authors used Clang's "Data Flow Sanitizer" and built a working
> taint/sink system that seems like it could be used for MUCH more analysis
> than just what they were looking it (as they hint at too).
> https://clang.llvm.org/docs/DataFlowSanitizer.html
> https://github.com/vusec/kdfsan-linux/commit/45614ee1a3a0d7b98c5cecb1b747=
184279bc615c
>=20
> I wonder if DFSan could be ported to GCC? It seems to overlap logically
> with some of the -fanalyzer work, but I don't know the internals for
> either, so I likely have no idea what I'm talking about. ;)

I'm not sure how much dynamic and static taint analysis would actually
share but I bet there are a few things that they would still have in common=
.

David, your talk on static taint analysis with GCC in the kernel was
really great!

I think the attributes you were talking about to mark
e.g. user controlled input (syscall inputs & user copies) is something
any taint analysis would benefit from! We added custom markers for this
in our linux repo fork but if they would be upstreamed any type of
taint analysis tool could benefit from them (GCC & CLANG: static &
dynamic analysis, or something completely else).

DFSan has max 256 taint labels if I remember correctly.
I believe this was also mentioned by someone in the audience:
Different taint labels, for example, for MSR reads, syscall arguments
& network input would definitely be useful instead of a generic __tainted
argument.

>=20
>=20
> Related, I wonder if LTO builds would help with -fanalyzer's control
> flow analysis? (DFSan requires LTO.) Getting the kernel built with LTO
> under GCC seems to be an on-going project, but no pull requests have
> been sent lately:
> https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/log/?=
h=3Dlto
> Maybe poking them from your side might help that get landed? I think
> people are interested in having LTO for the kernel for the performance
> gains it can provide.

I *think* DFSan (like Asan) does not depend on LTO, it can also run at
compile time. In our project LTO was helpful because it was simply
easier to run LLVM passes at that stage and we didn't have to
recompile when adjusting our passes (only relink).

Regardless seeing LTO also with GCC would be really great :)

>=20
> The second-to-last slide in my presentation (in the "bonus slides"
> section) has slightly more context about LTO and the kernel:
> https://lpc.events/event/16/contributions/1173/
> https://outflux.net/slides/2022/lpc/features.pdf
>=20
> Thanks!
>=20
> -Kees
>=20
> --=20
> Kees Cook

Btw this is the paper [1] I was mentioning that looked at an attack vector
on the hardware - OS boundary. It might have some interesting pointers
on what could be tainted except for system call arguments.

- Jakob

[1] https://www.ndss-symposium.org/wp-content/uploads/2019/02/ndss2019_04A-=
1_Song_paper.pdf

