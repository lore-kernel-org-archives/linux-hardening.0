Received: from mo-csw-fb.securemx.jp (mo-csw-fb1800.securemx.jp [210.130.202.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A9E1A304A;
	Tue, 31 Mar 2026 02:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.130.202.159
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774924971; cv=fail; b=dPSfPhcdiFh7WX38d8aiJwFHFZKXa5flTQwOROsClq3FF3maJBa/tpwTRG6J8PI7i2EJzSFNSukPzGIzJ9PGPpmZ3ZMWFGtA6kVX/biNoW0dCcam7UAmNoByH/uSAxlckCgsENI6w7EGsIT5lP3B1p9+DkW9LekeqgZ9iZCHhuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774924971; c=relaxed/simple;
	bh=g+yFWPaS8N8sCwO3vQev2xbAP+tGQO9pAQSONhi8718=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BcJFKUDV3X9YeWIMJNbgRs7iFf6aTLn8mzvRGGpfNyQx0cWOY0bXrRbG76279pJc7GaTGuwgZs/ZQ8Cv9FXmHY7YoKWn5TuIoCKVbnfx25e9FNd2Mx6FprFay6T9QOTBMDLtoBE7R51iVFMoI3pHpjgl9Lm2LPpY/6HfnPcuQUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba; spf=pass smtp.mailfrom=mail.toshiba; dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b=RAXOwcmI; arc=fail smtp.client-ip=210.130.202.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b="RAXOwcmI"
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1800) id 62V16qGi2378153; Tue, 31 Mar 2026 10:06:59 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1774919154;x=1776128754;bh=g+yFWPaS8N8sCwO3vQev2xbAP+tGQO9pAQSON
	hi8718=;b=RAXOwcmIO6jcV1LhGJLNok1Ty2k3oscaoGKApshQH0G6VWVxsoi5XD4oFzpl5z3vBAJ
	+/J4OWfUAvQNol+hMRjGCu5nR0sVksbrTU0l90FW2+eUSs7fNNUOUPzpQn7OKqX6it8bueIcvO+UM
	cxa9KIHtcAhzBmHk4WaiurhACoUbsR6uf/uUlSz7COhNUKmISpZBTq1W/xx4bMPX9BAhhlcWoFXbl
	e7MUmZPgdwBSdwFdSOYkTtfG6ChA+oFobf+e/1oGhHV7cAvwWETGyom9y0ogjR3M6aBaYOrUB5aiD
	B/oaONTpAq/k5N2kBRcdkdNGniLhU/4QHSCX6D16yBNg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 62V15rLu3435177; Tue, 31 Mar 2026 10:05:53 +0900
X-Iguazu-Qid: 2yAc1FwxhVmvYajACQ
X-Iguazu-QSIG: v=2; s=0; t=1774919153; q=2yAc1FwxhVmvYajACQ; m=mHG58P59dgiVna2ERqrBb+dT27+VoQT6uCZFKeWZdXk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fl90c15ZHz1xnk; Tue, 31 Mar 2026 10:05:51 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIFOR6pASflmqXvlV+gEoi74b1j7VBub3i1NLO9g3d89D78TyPQzFNOHtZdlZjU22tM9D4sO6+JxSVWKasn0KOUJxb5B3ErDbNOH7PS98yDid1d4EEQbDEwjC6MbhEHAaU94jEGxfxB+M3gJulgy/ftUHgBh6kHs0aS5PkLBcyojI2hUYUpaW7NgQtw6dP2ZL+zdECdlpqB9XC844d/BvBa5tSLaaOFKmWx2gVQf33GCZ9BIzIPdtTIiB1/Z1xjMEvHS3hVaYfhwww5VojYc+7jqMyPUKEJIssMou9IL0q6b9oIu6SrJh9XwZrvsr/laOH4TGBMFfdjWcBunJciHcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3Wxl/l406jXkuYeb1L7n0ae8ENrvOFiJ4MKclBv7uo=;
 b=ltWS2cmeZSSuM6UaS4FAn22K50JQa0zVFY7U3DUSeWNSbLc4TQ3m63iJb8/y9IRzchtFy383IfA1k+F2HJS2vROl4LxRIm0iOWB66iXdNlc8Wj9rO8IYZAY5STQ55rwKnRcuwhKZ2DGJdD1gtqinu1eBFS8fdLzhlNKr/Gi2GYCdiflVU2vlR3leOWQOdoO+nt0MMniNDliXNTscAlBc+n/ScmseqVr+D1lUPE7r0vfKyeKwrkUODqI0Mys2HgcIQnZzxYjUnqpWuza7EUafJRhEJfy/hBxD1tcfb0hNireNqH3H+tMT2Q5+PAwLKQs/beiQ5yYXBlQoE5x32CAX4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <rosenp@gmail.com>, <linux-clk@vger.kernel.org>
CC: <mturquette@baylibre.com>, <sboyd@kernel.org>, <kees@kernel.org>,
        <gustavoars@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] clk: visconti: pll: use kzalloc_flex
Thread-Topic: [PATCH] clk: visconti: pll: use kzalloc_flex
Thread-Index: AQHcvNhVoBnA9y4g9EmSR0/IQttWs7XH2qCw
Date: Tue, 31 Mar 2026 01:05:49 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481865057C575A7D58BA7955CD53A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260326042317.122536-1-rosenp@gmail.com>
In-Reply-To: <20260326042317.122536-1-rosenp@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB14582:EE_
x-ms-office365-filtering-correlation-id: 03419357-8d6b-4211-8bc7-08de8ec1a5a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 
 nCWk98Z6z7ZAFb5oCzIWiX+1XP8obo1G28jGr9kBCiXa7tdrLYG+DoWHCBHXhoam0qo0e9jA4njKHSu7sRJ953qEr+2+QWfddYq+siZ0s0C9XOthRAA3zd6jzyWGDaYfZdOvcYwkbsQj7pWjZ86VMrnNpOVoSM2D/Ug6h8oDPh+w12RCxirMTrdihqjG4pLwoPokzgeJXuIR3PYs9a+kZ+PDOr0JJWYAW8mSzUk6bOokEjByfAG9M24fe2FDihmfAlXNUIh2AAMy1OeOFSWg7YWUPn3znVwZwc7iYWz9uBidoZ09F5c6cfPa5nR092HUM5G8lSrquHeUwJtBYd5Fwmdyl9Cqr+fM0RFQeQ/5/aMoerj23GAAJvr68SSAQN3YAY+rvG0EmCrHzxY8ttRep7zSq1cCEet0bVXF+8o6QBXDM+blmueUhELTvxwcstoj0ZqKVEYg0463uX+ItPPaxyOqlXrLStb8Zcrpae8PSSdGKJHm4bGSAnjqEyWcZzAZ4v2jQyLQuBHOst1zN+60aMdog0HWrqQkuODZoMeyQWVdrkiEBlDN5rdr7rYZ90JcUvvx5ZOaK9OlY0+bwXf3mtzO3vZTMxiNKJ/d6V7I2o2wvplw+R7hbfDpk8GUYbRmyIuBeqbElkddVxMwdPrU1EBrXmggyNrijdp9+rB4DvjsKQxpz1b6wel2RHv826YP2zIrvMrUNAds6ow6xXuvDXDkKXmLCs7fYinWEyKjH3er05ofMjOj8Zhl5LXaxoevcn6O4zRxf6GPUm/w+MFm/s4B6cevRtsr+tRQrnOaVNE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZWNrL24yTTV4bGxnQ2FnWk54RE5ZZW93SGx6aWxpSlIvU3RIWnFPVDla?=
 =?iso-2022-jp?B?RkJPK21PTEFnd3Yyc0FaRllOWEpSeXJhWlRrNWlMeGcyUHptcVJmZ05K?=
 =?iso-2022-jp?B?UE5BS3dvK2NsNW5oZ0xhc0E3cmFvb25GWFlTeGxuU1ZJT3lRWDkxSEsz?=
 =?iso-2022-jp?B?VXNBMXhneXlodDFOYmFEZzBuMVBnWEQyZ1hKcXYzOEYrdGJ2WjYraFlU?=
 =?iso-2022-jp?B?ZWxQaVFrTE1Mc1JvQm1MenQwUndlUUVCajByKzlzNHNqN3hKb3gxaVF0?=
 =?iso-2022-jp?B?YzFOVVZsb1FkTVR4S2FZbWhtTTcyNlhldElidnJtSDAwalRCTFVSaVNX?=
 =?iso-2022-jp?B?VksyeVFUdkFrT0svWnkwN3VXdXlJb3NCaUJSMnc5dGI3M1dnay9Na2pS?=
 =?iso-2022-jp?B?cHYvL2RjZE8wKy9pSXR0ZHgwcWpMeEk1K1RkaVBySGM2SWJpR1JhL1c4?=
 =?iso-2022-jp?B?QnJMY01aaGVOZi9iVUl0MlBpb2tlRVFaZDI2T2kzM204ZENFdlRSeER5?=
 =?iso-2022-jp?B?QTBvUVpPc2ZCRGlIenZjZTBTVHc3UEYyNDhrbTZGeTVTdmpDTFZNcHFw?=
 =?iso-2022-jp?B?VjdHVEQ2Y3JnclRmZFN4d2k5ZHdXb0tDZkxFdk96aTNwMTdDOGZpRkYx?=
 =?iso-2022-jp?B?R2ZKVVpFUCtBdnRoY1RVMmdMd2YrcStKdFRsRE05Y3FLN1g5VUdWV3c1?=
 =?iso-2022-jp?B?cWhnVXA4OGFMM1RMOFdZMWtUTy9TRUZKOTZVOFpxM2lYL1VGUHZWd3dE?=
 =?iso-2022-jp?B?UG9NYXFpYU9rL24wbWZkYjFlaDFuZlRuaEQ5UGFBWVA1RVRPOWkvSHhm?=
 =?iso-2022-jp?B?c2Q0L1h6UVNraTFIc043V3hrekJIOWtIdVFONzI0Qk5aYmxaa1g2dUd1?=
 =?iso-2022-jp?B?c1ZrYkRDMWFhMnVzN29oUlZRbFVTUXllN09BdW5MYmxQQlZrM3VucE0r?=
 =?iso-2022-jp?B?OTdhNkFkMDVXdlF0SEJBQkd6bndlRUpZc21uaENtdWtQRVczMlNpQ21P?=
 =?iso-2022-jp?B?MzdVSCs5YXJzY21aR3dBMUZtZzRjUCtJOGV5dVBPeGRiTUp2N2ZQdmRC?=
 =?iso-2022-jp?B?WjEwQXVHY3lnQWRqVGNBU1c3Wk4yVnlZNGRUTVU1QnpuVStLakxTeDVj?=
 =?iso-2022-jp?B?dWtZRklkcFNUcVA0MS94a3lkeDA3azNJS1JiUEtQckRyWnplRkZDQ1pP?=
 =?iso-2022-jp?B?VTkvM25pWnlONzlQNkcyVWQ2NnZxb2V4emlGSEI2ak1BNmFRZTd5aExO?=
 =?iso-2022-jp?B?NVIzcmlDNmZJZUlaZ0R4d2FZeUpuMGVoS0ZiMkJNSGdRNnNGT3JTVGVW?=
 =?iso-2022-jp?B?MFZVTm5yS2U1Mng2dXVyWENIeCtTQnJPanFkaUltMnp3WlVYc0ozcFZp?=
 =?iso-2022-jp?B?YXExSHNzR3B3c1YwaHdFTVFjRG52aStZYU00QjlMc0cvcTJPb1VKSDhC?=
 =?iso-2022-jp?B?WjAzV1RTNlJ2cXhBblY1QlVrU0ZVNzRSY1E4dEllRXFvYm8wOVFVTFVa?=
 =?iso-2022-jp?B?dEF2ZnZaejV5YlZZQnNyeVR1M0JwdjFjU3k1WG1MRmxyaUxRZktTMDNj?=
 =?iso-2022-jp?B?b0JkNWoyb2l6OWp2VXh3V1BHc0lndzZDUkwzMDdZRnEvT0d1eW92TFVm?=
 =?iso-2022-jp?B?SjlSTEtrSjIzTzNPVTlRQXh2OGhRSkVRYTlWejdMRmMwSTVBNmh2TVhJ?=
 =?iso-2022-jp?B?N1cyL3ZuZmw0V3JjMWduSGlkTlBHOE5iUTBlOEIzUy9CR0hLN2FveEdP?=
 =?iso-2022-jp?B?cll1VitxaEcrdm5UTmZMaEVXSC94WHh5RWhuODdRNFRYSTZiekwvbjkw?=
 =?iso-2022-jp?B?eExodXdta2FKVTBlVkdDQ05lNUh1bGg3bis4NUhOWWtFU1dSTDFXNEd5?=
 =?iso-2022-jp?B?T1pwMXdrdTNuZnFvajd0RktYTVVYaFdzbFdhcVJJV3lrQXFWWXE3Z2ND?=
 =?iso-2022-jp?B?bXcyT3NvamZpek9zelFzb1NiWmM3WkordS9TT3pLdWszWEgvdTZNSEFy?=
 =?iso-2022-jp?B?KzRSRGU0dlJTN0R6R01EUzhaMEVaZDF2TEtvUkt4S1U3RFdSTFJLajhZ?=
 =?iso-2022-jp?B?NU1zYUNNYnpSWWY4a3NxTnZtQzZrSHBBQkN5QU4rTXJIbVJxWWtBMldi?=
 =?iso-2022-jp?B?M2RaOUY2S0g1YVo5dFVueE1uOGRkTzRMeVVUN1FiM1BTb0s3b0UxQzY2?=
 =?iso-2022-jp?B?Z3lvRHBOMFJqUmVsa0c0TmEyd2FOUE9PMnJEd1NsVFlvdTdUMnZYeVND?=
 =?iso-2022-jp?B?ZEEzWWZTR1NidWt5S0dxRVQ1Mk5mcEtrU1kxKys0eVpGcGVXSDREM1JZ?=
 =?iso-2022-jp?B?MlU0dHFjVFN0eFhGMHlpS1ZOcFVmaTdobTVLemZ0aHc5dCtUcGc5Uzcy?=
 =?iso-2022-jp?B?QTc2djArdk1Lc0VpaVBteEhkSG93RnRTQjVSZG1ramZ5eUw4aDNlNU5F?=
 =?iso-2022-jp?B?Vm5vUU1JZkFCY0pQWmp3amdKY0ZteHcyNlpNaEd1clRjRWNnU3hvOXc1?=
 =?iso-2022-jp?B?TmhOclpBSmxFRXRxQlluMTUrUXBSUlZLdHFWeTNBTTdXRE1SUzJLS05B?=
 =?iso-2022-jp?B?YmNVSUdNTT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	c/3r+xmuar4k4twsaQekfvuoFW8bqqgf80t7HPzln0tGGFVtMmWoqbaQQcvzb83z98/Sr7PpvId0p1TQ50Qvdx3E+Yrt1HyPLZ/gRBp+XsUaRDvSNBJxtsPosB2y0nKo+kAebgS0ab3waw6kuTwh2ehi2sxQVKJrFEvOb9tpANHXueDJI7Ig5djuxYMnsB/A41mzC/NM05qdDjxK5iiE+ithNscD1iknhk9OuiOi1GuP9ZEejFrjKNvadgS26Q+bVKfW/+4Pbh2Mm7+cWmho2e86KC5/nwIP8AeofA8b3/zUihyBfqClRxrG2sQ6DUZkzr6fBIosmnFFspc5pNY9QQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03419357-8d6b-4211-8bc7-08de8ec1a5a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 01:05:49.2213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WdlETIVMgD8hTscbVJbuyU4h3c5T4GQ3+sT457UFd+31bCaGk4OaIGBwpTYarlHSl6J5VB9JkXdh3FKPjfm+le+shrJOvGvhn0bqjLV1tt+CCfuf5wR09a9sezcnmLPe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14582

Hi Rosen,

Thanks for your patch.

> -----Original Message-----
> From: Rosen Penev <rosenp@gmail.com>
> Sent: Thursday, March 26, 2026 1:23 PM
> To: linux-clk@vger.kernel.org
> Cc: Michael Turquette <mturquette@baylibre.com>; Stephen Boyd <sboyd@kern=
el.org>; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B
> =1B$B""#D#I#T#C!{#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Kees =
Cook <kees@kernel.org>; Gustavo A. R. Silva
> <gustavoars@kernel.org>; moderated list:ARM/TOSHIBA VISCONTI ARCHITECTURE
> <linux-arm-kernel@lists.infradead.org>; open list <linux-kernel@vger.kern=
el.org>; open list:KERNEL HARDENING (not
> covered by other areas):Keyword:\b__counted_by(_le|_be)?\b <linux-hardeni=
ng@vger.kernel.org>
> Subject: [PATCH] clk: visconti: pll: use kzalloc_flex
>=20
> Simplify allocation by using a flexible array member and kzalloc_flex.
>=20
> Add __counted_by for extra runtime analysis. Assign after allocation as r=
equired by __counted_by.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Acked-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro
> ---
>  drivers/clk/visconti/pll.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/clk/visconti/pll.c b/drivers/clk/visconti/pll.c inde=
x 6fd02c4b641e..ca29d12f9316 100644
> --- a/drivers/clk/visconti/pll.c
> +++ b/drivers/clk/visconti/pll.c
> @@ -21,9 +21,9 @@ struct visconti_pll {
>  	void __iomem	*pll_base;
>  	spinlock_t	*lock;
>  	unsigned long flags;
> -	const struct visconti_pll_rate_table *rate_table;
>  	size_t rate_count;
>  	struct visconti_pll_provider *ctx;
> +	struct visconti_pll_rate_table rate_table[] __counted_by(rate_count);
>  };
>=20
>  #define PLL_CONF_REG		0x0000
> @@ -255,10 +255,6 @@ static struct clk_hw *visconti_register_pll(struct v=
isconti_pll_provider *ctx,
>  	size_t len;
>  	int ret;
>=20
> -	pll =3D kzalloc_obj(*pll);
> -	if (!pll)
> -		return ERR_PTR(-ENOMEM);
> -
>  	init.name =3D name;
>  	init.flags =3D CLK_IGNORE_UNUSED;
>  	init.parent_names =3D &parent_name;
> @@ -266,11 +262,13 @@ static struct clk_hw *visconti_register_pll(struct =
visconti_pll_provider *ctx,
>=20
>  	for (len =3D 0; rate_table[len].rate !=3D 0; )
>  		len++;
> +
> +	pll =3D kzalloc_flex(*pll, rate_table, len);
> +	if (!pll)
> +		return ERR_PTR(-ENOMEM);
> +
>  	pll->rate_count =3D len;
> -	pll->rate_table =3D kmemdup_array(rate_table,
> -					pll->rate_count, sizeof(*pll->rate_table),
> -					GFP_KERNEL);
> -	WARN(!pll->rate_table, "%s: could not allocate rate table for %s\n", __=
func__, name);
> +	memcpy(pll->rate_table, rate_table, len * sizeof(*pll->rate_table));
>=20
>  	init.ops =3D &visconti_pll_ops;
>  	pll->hw.init =3D &init;
> @@ -282,7 +280,6 @@ static struct clk_hw *visconti_register_pll(struct vi=
sconti_pll_provider *ctx,
>  	ret =3D clk_hw_register(NULL, &pll->hw);
>  	if (ret) {
>  		pr_err("failed to register pll clock %s : %d\n", name, ret);
> -		kfree(pll->rate_table);
>  		kfree(pll);
>  		pll_hw_clk =3D ERR_PTR(ret);
>  	}
> --
> 2.53.0


