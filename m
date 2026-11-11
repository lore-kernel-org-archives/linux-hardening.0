Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794399987;
	b=eg8gAGLnAyRrRU+jkhNJFHQ3Ralx3x4MxRTx9S4vhyOOLoMR8Xuwz9a1k/3Tb7I0Dfq7
	 W7qg7oy4DZI1nlbUi/P8Nb2x4dHN+8nXfEEG4m71OL+qzWqFys1FeIf6p0WUsVJ07SwLf
	 z/Rcs5wK1gguA2Lx+TEcW/19fGhWDo/160gq0qJsANHiGh2wTtlQABTFP87l9LTTvA1YU
	 nYINZ/bq79FPWZX6nnMOqAZACR5XBnLBAD7sZyi3lZwDmf9xAWO9nv1fRfHeFYJpQKNcb
	 dQElMVfWPvFliMAIQbHNLCEBAFls7r7Ka0+iqd5hCXnjq+bNfUqXnF8Adj+ge+fh87A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399987;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=7OEJCbfxrUbcODrSRv5dsl+pF68ImpksWA67+DmswZo=;
	b=w1wn9As9qAkFIxXRZx6HR3giFOKbaV0hnrH2dhhHy7a5JsS4bAmKlllWs1i/6CwRYuxp
	 oo6eMujY5pY5UbPEiZS4Ts2fA1HVS7y0SQKKvuBEAp2V/GRJ/RFlVaRq1NVsERdeGHFwj
	 UjcSAT8bQh+O0V+jhH7Ug4Fqp4YpnZeFBh5ZNhv/rAuvKUiDiVhbRbBpLTB7R8QDP9ncG
	 xOuyV86BZU71kfql7hKD6LhcG7dV+3twTeSN8QwuJeKiMJMbSLGcBxhHSW+x7f8jyKN6I
	 MJMw/iI4xnyOVlA5Vf+fSNFIzHuPpSbjdKFipgI/+Fl9YnCtuwKVbEsmEEKBaquuKTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=KlTkS8vn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.28
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011028.outbound.protection.outlook.com [52.101.125.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6D4606A321;
	Wed, 11 Nov 2026 12:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B6D4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=KlTkS8vn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfoyZH7jVdCUj8M7nUsd4z97QWFA0UPZAbRSGVpPSWcO10HjbkFl3SR5yTiXlEldxfBR+Ylnff7Fgmt96sGbg7eYUt0MJJkcYpI3xTmAMl6kP+jlxlbsYA+dqtDMU2puINBfgg24MvWOTpkTAWy1AXQHIisys0LuqLJGtethe3+IAe+sLaMDdf76OkwxEwUvLabCSXcPfcerAsQFqpLsspPVPk2aEPKy3KH/tfqu9PoWBOhy6fkPH+3PnAGtFYCkfg+ffyKinj79LorkxvRqm/Rqs7JI6QkLCR1zrAH6LYOTFRcy9wOms1GLyD8CkwvTSjv8x5acllmn3Gndc69IEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OEJCbfxrUbcODrSRv5dsl+pF68ImpksWA67+DmswZo=;
 b=lBR9It8QU+c6rgQ1JwW1dmbKYlKtBnrgypOzSh1+Yo6JT/OrcnmyXPA2X2LBD11JCy8iIEuVPXWrEmnZtebfls/JZ5m8auJM9V3oQIbqbPWZbvKskApAopGSMmHqfvFs5rv8qXIEJdH6y1An7x/TjSaIu7iowZ+g/eRYixE/XUmR5Jow+zivGBzcqIzWD2ndtpP/0mMPG/oagLJs6wxAST5IkNSu1k1pIJTl6tAZ2NQ+7dit1ZCJHzj6ZpTm3KDYAitdfbJtgh9RzQT8iMrioiDhRA6Ynr2200omtXuBLWYDIRImoRCCl2uD18HNGQ/Luokvty8hsMFVSN8yj4O1iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OEJCbfxrUbcODrSRv5dsl+pF68ImpksWA67+DmswZo=;
 b=KlTkS8vn2WXQSTCeXlZmgFBhJIWwrnAUfvh/OitQZMisvUxwJEfew3ghwy86MGnAKcOt30ZvpYC4NCIReKZhxFhIYwFaa/5rwmmTfswj7/+8lQMa0FzIIV4YLNUj5BHEyxYKda3Enl0I0Bt4gY+h17DYu0dnh7TBrQFWe/Dh2CA=
Received: from OS3PR01MB8667.jpnprd01.prod.outlook.com (2603:1096:604:19b::10)
 by TYWPR01MB8448.jpnprd01.prod.outlook.com (2603:1096:400:173::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 12:26:23 +0000
Received: from OS3PR01MB8667.jpnprd01.prod.outlook.com
 ([fe80::a7ca:1a29:beab:1921]) by OS3PR01MB8667.jpnprd01.prod.outlook.com
 ([fe80::a7ca:1a29:beab:1921%6]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 12:26:22 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>, Mark Brown
	<broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
CC: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Kees Cook
	<kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: soc-core: reset rtd->num_components after
 allocation
Thread-Topic: [PATCH] ASoC: soc-core: reset rtd->num_components after
 allocation
Thread-Index: AQHdccuOsAA6locRR066fyQ4tpayTrcozB/A
Date: Wed, 11 Nov 2026 12:26:22 +0000
Message-ID:
 <OS3PR01MB8667A9EE17B225F351946D6D85712@OS3PR01MB8667.jpnprd01.prod.outlook.com>
References: <20261109102536.357134-1-ghidoliemanuele@gmail.com>
In-Reply-To: <20261109102536.357134-1-ghidoliemanuele@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB8667:EE_|TYWPR01MB8448:EE_
x-ms-office365-filtering-correlation-id: 52433a69-a772-42ac-2806-08df3feeff5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|38070700021|10067099003|5023799004|11063799006|56012099006|261022105027099003|261026121527099003|261026140227099003|261021121427099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 SUTHuWCFK5HAYTH4uJvPu9+ddVzXl8vr4wGJcko3AKHcl5ZAqbY3q2kHwPQHu2HyvWJuPqNijnuVKpknRWKcOltn9FyFvzxCMitAplOlYpdELwh00ToL4dy2br3A9YP2s9zC8pLrGvHp/1gHrCvD9NoLQ4C77mxHiuRzO62mEa7ZbxNFRF3PQ+m8lGqdhqAa4jMQUbE+Xz4NRCNHI/lYuQwYpn7YufQolPB8f3vhbgOZ24quNn9ZCPowGZFx58QBn22EQra7I/927z6EX4kX58aINSrlLuBiukaU8h+JCIqohxDc5iPhQK5zWUDhJOLlNufDyiDDuDMiWTTOuOPMnzyedPL2HlrL840nk4UQ97pm6/CJkzP4wCFcccg8J1T9r7wk/UDfgV3zXpRcvmWJIYIDG3FjQTnYRBqiLZlHlMYAegvvs1udm4IkrJ2ap/qYFjBSA7gx4n76Yff2ravQaclwA69r6QTx8BopfGI/274paC3sLHwwz/dtzoxQp4hHkbZLdHqQ2WwyCInDaUlTY2dOS2YbsEZxFas+/eOuElzcNynrOlvxPWtULsBIl2ho9v/V5LY4eflzO955vSNrF4NchNPoDXGNJ5IWNImkSMvnfzN5wV/VU2pAHWEU1G7TyabPZBorFme1Bf7Foif/4r038bjjYX/g1KWDP52i4+iE2Eylgq1BB2317tGUSDe/PFsJy0EXvTZuFym1YVHwgp2HozX62OsgWdoJ/guNxn8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8667.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(38070700021)(10067099003)(5023799004)(11063799006)(56012099006)(261022105027099003)(261026121527099003)(261026140227099003)(261021121427099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?t2Ty9+cQM1uMWQuVlScK4QlqzBEjGKQkuS55BaLRtDWdB0wMJfXyZddK6LNx?=
 =?us-ascii?Q?g2vVXWuN7kVTr6VZJMhQWlgwhru0LHCKEGPpdqFhBwhUJcWbpjHhK7BLRBq0?=
 =?us-ascii?Q?r/hRdrY2WPQK6yolg3HZYTW10rK0Ng10Y3fbhurA2Eh7y/vDsiHXe83O3W/e?=
 =?us-ascii?Q?UDXt86RyzvH3fXWf5+YcryVHz5VoSGv3pRJfcdIQNULXGUL3N+K1V/k4jDtH?=
 =?us-ascii?Q?Rcw+Ui8rveMseyIF2jwQT4wxgBOwFVVeW1usgvgwBL7euQq67OZp+li/2N52?=
 =?us-ascii?Q?CqyX96mqfDJlfqRCOyJvMne1uMfzggS246AKsDyFQeNx7stsmCTA64lTUk7X?=
 =?us-ascii?Q?g3cfiVNOJhV5UXTUbwS0GUf8TdzH3XK3jH93rApSM9BRhlcdXiOBjzbGLgV9?=
 =?us-ascii?Q?aiM5+jNvHU+3hinALkDi41L1aUqzqUruW7ewKIowWfp2E5AwZ16KI4oU8GjD?=
 =?us-ascii?Q?CqL8SLeGc6l5mOGx2zXxcLCArt/z515ByHzyNOQSR2wmHO7ZLz5/BuajFc5P?=
 =?us-ascii?Q?Lg45ib42yGcL+YMKjYL8Nf0O1I//OPpIMIepVCKL0d2jCogva7NyzXRoSILc?=
 =?us-ascii?Q?IgE2oHVzFd2v8uw+1g8yPG2K+JY/z98EV84x1NIhmTGwqXGzz/Px4qVMy14g?=
 =?us-ascii?Q?gBZuJjiAeVAYheqt7wcYbyjV6l7EfzYSWlOFoalvgJCAjDhba+ussw4qbWna?=
 =?us-ascii?Q?aIGf2rWuNMRIRCzNGsXuq6b1Q2aBm2nKjlBLODtTvQWzX0I7gLCRUwLPu+pL?=
 =?us-ascii?Q?d+W26mx0QzvW7nAOE/f4CSn0sJUScLBfX4mS8DvVF9BSdFkqqbeRzU6wMIUt?=
 =?us-ascii?Q?ZltNafOIAqqF3tQdUtg+cg3j7GpxkCrl0qZOlJlENm1uueyc8cDHl9tOLAoh?=
 =?us-ascii?Q?FlY69rqMrxIaobuEqqU6dnvn7ABHBDMGt6LK1n8CBP3Ba9UYlwsnvSaASVtY?=
 =?us-ascii?Q?iVgW1ACAN9rgzE5k/9sSx34nW/f5l9tR0o8Dve1WHtPGQpbYazG3ZYrx+BSE?=
 =?us-ascii?Q?5xVBslm0obVJ8QYuzuzIy2saPeWvd/cxsY2xEp/YSxBHmBW8GvlIVfDx/F98?=
 =?us-ascii?Q?GL1JbG/2tGZhUUd/Gy3STQccNx9bshBEcI40dCKB47+6wPJpTLIZ6MvK8KWe?=
 =?us-ascii?Q?bNd9dv7aw91nWDeDc7UtTL520cGd2gXDBBfHyeyazgSppDngfgZmymY2V/pc?=
 =?us-ascii?Q?iss5Z3gXrb7bUXFLTYHjR7gC37eogTzWEGEiYiNnke1sVcUE9gUkRHDbQhrp?=
 =?us-ascii?Q?7+obfcit+7IlcBCh0iT8Oun0JfPuFYw7xUNojFLtmsbuhV8RyBincjYxI3wQ?=
 =?us-ascii?Q?qr4LP3V9asroL3o2BVmlg2RIdVn08z6hIy3sp0Kfp5D5tOkXK1tnfYDrCaXl?=
 =?us-ascii?Q?mtOXi31BE5eqCjnqRTN++d02ZojjEE7gMgtzuP3JPl6p1vgx2y34qujREKqG?=
 =?us-ascii?Q?Tdc1o8XkJZ8N6jeeRwt7pD4L85/fqmNduSw6z2Pr8DmHQr3JHr+q2OU4p+4O?=
 =?us-ascii?Q?RHWlP4kOlj2ReJfyiuAU80D5ZJ+c7l45TIpJTd16OwxF7mMWexG7FwRImt8K?=
 =?us-ascii?Q?upT1GD2mHmfiSP941stZDAOutCnpH4qc71KrWGzeHvMS8qwsR2CdeqgngUTh?=
 =?us-ascii?Q?prcyet8O3B/LHn7pUkQqwApzDWGsVWTbcUlsbKaYFT1apviccTHUPukbh/Nc?=
 =?us-ascii?Q?iyM1ulRnsD8G+WEnSQl0B1rlCDFmwJ5afQbN35u4RLv5ip6PNFguO7qu28j7?=
 =?us-ascii?Q?0AhU8DO7/FjdanK2j0GyzaA6DeVUtyYEaD5PMfHUp2qc0oTNmvrA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8667.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52433a69-a772-42ac-2806-08df3feeff5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 12:26:22.8237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4MY5t6cTAZzoCqhxRuqWCkycKi6m/NHJxVPA/PcVr9H874sIZlYF4pl7Gr3FH0xX8bQ57PLDCvjoaCdGoW3bLN2KthhRzG8xu4nmZFGDeB4QF93z9+qUJYR02jpeXSCl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8448

> From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
> Sent: Monday, November 9, 2026 12:25 PM=20
>=20
> Commit 4dd10fbbeb9c ("treewide: Convert devm_kmalloc() family to the
> devm_kmalloc_obj() family") switched the snd_soc_pcm_runtime allocation
> in soc_new_pcm_runtime() to devm_kzalloc_flex(). components[] is
> annotated with __counted_by(num_components), so when the compiler
> provides __builtin_counted_by_ref() the allocation now also sets
> rtd->num_components to the number of allocated slots.
>=20
> snd_soc_rtd_add_component() fills components[] one entry at a time and
> expects num_components to start at zero. Starting from the allocated
> size, for_each_rtd_components() stops at the first, still NULL, entry,
> so the runtime has no components: they are not probed, no controls or
> user-visible PCM devices are created and the card registers empty,
> without any error message. In addition, each added component is stored
> past the end of components[]. On the tested board these stores still
> land in the slack of the kmalloc bucket that devres rounds the
> allocation up to, so KASAN does not report them.
>=20
> Reset num_components after the allocation.
>=20
> Seen on a Colibri iMX7D (simple-audio-card, fsl-sai, sgtl5000): the card
> is listed in /proc/asound/cards, but /proc/asound/pcm is empty and
>=20
>   amixer: Unable to find simple control 'Capture Mux',0
>   aplay: main:850: audio open error: No such file or directory
>=20
> Tested on that board with v7.4-rc2 built with GCC 15.2 (first seen with
> GCC 16.2): the failure is there without this change; with it, playback,
> capture and the codec controls work again.
>=20
> The root cause analysis, this change and the testing were done with the
> help of an AI coding assistant (Claude Code, Claude Opus 5.5).
>=20
> Fixes: 4dd10fbbeb9c ("treewide: Convert devm_kmalloc() family to the devm=
_kmalloc_obj() family")
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

We also hit the same bug on several of our SoCs, although with different
symptoms.

Unable to handle kernel NULL pointer dereference at virtual address 0000000=
000000060
Hardware name: HopeRun HiHope RZ/G2H with sub board (DT)
Workqueue: events_unbound deferred_probe_work_func
pc : mutex_lock+0x20/0x4c
lr : snd_soc_dapm_add_routes+0x28/0xa0
Call trace:
 mutex_lock+0x20/0x4c (P)
 hdmi_dai_probe+0xa4/0x1d0
 snd_soc_pcm_dai_probe+0x64/0xdc
 snd_soc_card_bind+0x568/0xb60
 snd_soc_card_bind_call+0x64/0xd0
 snd_soc_register_card+0xcc/0x100
 devm_snd_soc_register_card+0x14/0x20
 audio_graph_parse_of+0x228/0x2dc
 graph_probe+0x7c/0x94

With this patch applied on top of next-20261110, RZ/G2H, RZ/G2M, RZ/G2N,
RZ/G2L and RZ/V2L no longer hit a NULL pointer dereference in
hdmi_dai_probe() and the sound cards now register properly.

Tested-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

