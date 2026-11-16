Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794845330;
	b=LtbK7RT9jXQmmBJ37KVdag+jbrmhtWGvJPJ/8ui5YxIuy9MK2TRYgGyU2IVKxeJ3K936
	 6ljdQ9ErPQng+PIbWdiUtemtWZdLEPUXGL4QcNWHC0mfPp5axNdVxOo/uV3wm62r4jmqt
	 vfYwSYvxiDEdxAtHQWsDnRpwLrOEQA6TPKFaXN64YUWxJ0jn3rXb/i3a64rMtafqgpERX
	 liSN6K0NIyizpYQTaPMmquAcwMTqPtRlYeWx3RRoV4gSuMr4UVwb6zjadKq8cwyOtQKnH
	 2q1Y7SZLWmeUgQWoA8pev7JW0tEU6jPz4j9JOm655sWS+R7dGq3LmRL4ajrgbg3s7Sg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845330;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=h6FHmHhHzzMvPtXvbSdom+CVxffOiyDk/za7HkqQb+A=;
	b=OGzqTpMqIaU/1j6ZbkFZZCfQdeF9Xi+YSisO6X/vMPZgueTwE54fLB6FrrBtAiOZk6EW
	 GcMZWzG1FcwXWTz7hMkg1imLTbZZK/6/ivxPK752STgNEQHuw7tabS5xEU2Zv06DbqRcn
	 3iH2nVHKdPIvIvZ5Yzsie5vacxRv13ln56IS7GXqFu5YYsirdMdAIWWsXNCaE3nQWPn8C
	 jk3wq9FiNX/L9YzgenDRaDQN/RjokuaXJc8oLOmBOp0iG3GB65EuqZqALQ4Mf5F8Kx/wS
	 V84yZ1ereJLu/yzxs1IvxmpqZY9uDTRu0Fi8M6wvbFNx9gPHzhTzbfQBPdGcrb4shkA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="s3cj/+v+";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.31
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013031.outbound.protection.outlook.com [52.101.72.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A660F606A32A;
	Mon, 16 Nov 2026 16:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A660F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=s3cj/+v+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8xVJMp/4sQuZfnMV3hTTyVX89kAUpBezTAjxnsnwXpQNAbQ7TNnakW4mk9v6JVkUTMFQ9EeE+R7Y2AC8Ydr1qz+SEcTSuJ62DXQqMhbjk30tErDEqMoyanSQ2B8dm4c2eiDgYiYY8JWOmoaXfA/L4uPSEuJvWSRRRSIXUmGyPAjCxWlHW5GabJ+nQ2iwWonviMXGPQSTorxiBPCxGF0APmYNz4ABJoRm9qwOWbMeEsNPfrlEUiPZcjfhvo+YHQUTi6LD5yrlYu6e4VYLZBaORi6JPUef+eVCT8BXk3x9r19nr9scDQ0j0Akaeuw2cnciLHoJz4Xi97unOkEko3WiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6FHmHhHzzMvPtXvbSdom+CVxffOiyDk/za7HkqQb+A=;
 b=MPMzqj0v6k8A39kOZlRgLv+OXniWzSTiGqYBY0S8ff6MZwHUCwC+hSa1X5L84ozf3nHcx/zwy0L8ipugCvbzd7UfhS6FOg7uMKI10l22WBfwEzz+Wj4X/h6ts8Zgmr9aqWxDO6/j0HbDcfvUOp6/7QbXJj4cmg5Iih3YcWFYJwQRGjAdR7hIg95nTeJHOB9bFJqbunXAE54iac2BOEW5ediAeuG3s6czVl2ai2wjuMTogCB9XFe4pdtQOQqysws+vFfQQT7zFl5CWiLznqB0Z/eTQu3/hUJ7LZaRpcuShVX55zeqN1VUOOhE/pMW1NMnNIOwoLpltxP05DbUa4xxaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6FHmHhHzzMvPtXvbSdom+CVxffOiyDk/za7HkqQb+A=;
 b=s3cj/+v+aGDCDsAGUDf46nmX5u/zDQfQiOVeSIGmB4nH9ektQnAHbeKuSVd92rCKIP6cLVgsyL6ujy0KzE5LOug0gD1dw8OTvigAaaVQ2NjyZ4v16hJiol1vXfcmKW/qo6iuSuRK7dRIjrIh1lkI7tJecECZQze/6jldkp17eRrMK/6/UAR6FixNRfqS9XWlp5TCQb4IUUvjuLVxYbpCNQ2VvEYYibd/jC/MRqWxTtCYazBMCzIOSVgMwG90EHGnAoZSGqXLNdPBgXboQZdPLZZKZGii37MN8ayCN/QBY8YZ+fIc1r5V1gWanQZ4+z7td1ve+wCEpbxF+IAFneU75A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM9PR04MB8068.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 16:08:45 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 16:08:45 +0000
Date: Mon, 16 Nov 2026 10:08:32 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: junyi.zhao@amlogic.com
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, imx@lists.linux.dev,
	linux-hardening@vger.kernel.org, xianwei.zhao@amlogic.com,
	Kelvin.Zhang@amlogic.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: i3c: silvaco,i3c-master: Add Amlogic
 A9 support
Message-ID: <avsqgJczFes-NV2F@SMW015318>
References: <20261116-a9_i3c-v4-0-3d3222b7128d@amlogic.com>
 <20261116-a9_i3c-v4-1-3d3222b7128d@amlogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116-a9_i3c-v4-1-3d3222b7128d@amlogic.com>
X-ClientProxiedBy: PH8PR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:510:2da::26) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM9PR04MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: 585169df-9af6-4013-f307-08df43fbe414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|19092799006|261022105027099003|10067099003|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261009223027099003|261026140227099003|261102123227099003|261026121527099003|261028144727099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Jt5EEIhKlp18UIkEx80N96ffo4w+GKpHRpsaPB96B0juXqtdVNNcjzRPbu1jEHHS6kOpOqE+X1S3OMqfHSUbbbX8TU235pgGkne6cXoG1+wnA6f+E2pN5+9H1qCclyZxmn1Ua+MCcsAbLcBNgiEzVQ8IW1QMO3eKQZAa6a2LpMCjUZ0Pe3kJR8yUjfPcGPxPDkhgRzq1in6LXKRFoK+qaoIn5i6mBx9WAvDFXdYOw7ibW8f6m8vWRzXpaiYwtadUvusrqucTrS0pyD2LfqtCAfqgm5MaOjJyIQCETuDpsEFAmBLHSyU9AMpGxIbx+dH8x/gm0PiOlaYGHWNqE6lGS34TDL9MDI419WVAjIr4xoqcJqbEunOF/1/8Sx7SBqbu5sBIZsFuys00NPu1CedtyMC8R1Xq9fas6M3dqusvmZGi40W1c5CleljUzb9lGCZVMmFmpDZzpSRHx0W9SBSULqHCO1dX3pD/eWlEJ2EewaJQLjAtPEwyn+c86tTSUQ9/3n/mboNf7DZcKivcnYNxNBLcMCaj7ZMiCkCSQV3uf2p6Pok4h67pOKRavauw+qgdJouo3hJ6QKVotMJz5MzVxgNEgJqPjy6NqB7DnHsqW7pFaT8PsR8Ke7RghThL/0sYZmFQkZNmInOuJAKHkI7QWrT5WjPgR98rflJyp14RJhc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(19092799006)(261022105027099003)(10067099003)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261026140227099003)(261102123227099003)(261026121527099003)(261028144727099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TBVEtnWBpNQh34n2qLv8yoluLDEShJylpgcWeU2Au9glWV39hnlN5xZsUR6t?=
 =?us-ascii?Q?93JCNKPGJMuZnRIsuWsw0VPl+XhnLTgaxjE71rbIwO0H64J6sV4hNOcvEaxp?=
 =?us-ascii?Q?tT2ZkSmD8UtT5qZhzbEQt+EHhiecBoZzYMQINLdUTpT4DSQnIr09X83ltkTv?=
 =?us-ascii?Q?VVIK3OZYNCNKLFaCeotI0wMdY8C8w5aknfwRQCazPkgAQKAforzSEh/qrqqw?=
 =?us-ascii?Q?OSHzO/zDyQuQDTqfeQBxrsySeiwcb3rKjoB5IaLBVW8A+YhqCuMHuHijawyy?=
 =?us-ascii?Q?UunwFRcnKYVui60wHwo+8EUOOh+pudqAUjShSMFc5WX+397YIqFdA5+8zIIZ?=
 =?us-ascii?Q?82fEL3EBiBGNe90WzT61zbpaL376yW2OWOF7LQyu5yKOxLUQNcfcjPrw3N3G?=
 =?us-ascii?Q?L/6KO9YFztX/f+liD9yT101J4cavGchR+PcWkQXQqtUbxfDm+GtbluB8Qo3u?=
 =?us-ascii?Q?qo+OEzjNqySLnln7hn6Ys2CXitSNFEbsPOB24BwVT2Y4nYpMS7EnWRYB7nl4?=
 =?us-ascii?Q?9Ga3ar0CAD0oMXdl9Kdf0R9eOYjWRquE3p+VmOMZ3aXLrrEhPvxo8fP3A3Uq?=
 =?us-ascii?Q?2fh1dvQ0/thcjC2oEAww6TSJku8QR5Mbz61+JBE1VzqMyYc8HVL9zl1h/1Q9?=
 =?us-ascii?Q?aNPXqsufcCQM/0pFVWbxJSdNwuM4WhaQ03aYcymfH9uTaUTNp3pe/srYYnbH?=
 =?us-ascii?Q?HSkd7jvABKhjnKZpF7bsgPZhCPHVkpAtFp/wqECdHQkBa7INsuZbSGRt1+oT?=
 =?us-ascii?Q?vhShB9YVMrScbpYHUC1GnmCEUD8iPeMJOnwumsMMaPaPxyP7fGJETJ7HGhMd?=
 =?us-ascii?Q?oz2eRDdT+U9TL4pGisPHWObmQeinjgd1+dxeDs7KPia/mhWvOaJCHc+a5UFq?=
 =?us-ascii?Q?O1crH0gCs1+knOGyrudu3BeyjlyNX5pNwCgm+SYdjv6/i8yerRl43DtmQZti?=
 =?us-ascii?Q?koycxPWnXFN0Sgj/xrXFovjHIkNRnEjKsq4NCT3hBRFhoj3mJnqAUaR0+7D8?=
 =?us-ascii?Q?xad0v7OQHJSPrCpJdR7cBnF8iEWJD16gA9xSFkTTPy+Pj1zkhkpD4BFwZQQ6?=
 =?us-ascii?Q?p7YeZdfEMMFxkfbuWI2Lc6yfvYLt/A3ehU19p386tpMsAQp0/IjikFX0im/W?=
 =?us-ascii?Q?Gu2DThF3z1dWMU24OnEZiIVSbzAVBQbTK/DiuFoXrasu8CJUWbtGtggg+Bwr?=
 =?us-ascii?Q?P+2INBoOqx2vHkjn57llDd3TfagqYG4InzDJPP02uAPIvYyv3GKgM5Ca/9Vo?=
 =?us-ascii?Q?HYqadLIh1+Hw97he3fatv3R6HnNYudlH+W9uFB7O5M6xJYi1GWlJLeXnNLUi?=
 =?us-ascii?Q?RHZt5YxLse4PiuasXxog3WxKgj1OHqco5gNKggpzr50SjwThaliMW8tERsDT?=
 =?us-ascii?Q?z7UcBlVGmPjuoKz7sIP0lJJgfcmnbtTlPRfOBFJ/j+MM0gkv/fl9f6LBx0rV?=
 =?us-ascii?Q?BhC9IlwdXrDdWR4tHMoeD7jbQHgIZA4rZSC7w/+ZHi+IqYPjrHfz18s99wL/?=
 =?us-ascii?Q?3LO7cUtPyo8q+UJyhfmXOhXTuMydeDRJyX6uqrEeBbWz5Rc9VoKyVVz187y8?=
 =?us-ascii?Q?Bdjoq+fN9uZ0C19AuboZ/ZBvIeGSXZinBHS9E0KMOXyneLkjiOURaKtP/6fX?=
 =?us-ascii?Q?L/t8CGEYv3BvgW8yoxmpuz2nAFJJQvV0jcpbFdJs5BFRdgJ4bI6xE2tYFGKi?=
 =?us-ascii?Q?2MXGu1UqmIaGY0roeTYRuIaWa+HIAyrUG7wr9df6pA6RcUrzrnppCPhzOlAQ?=
 =?us-ascii?Q?Aghf/yba/oEsZYU4CwVgiO+BNKclZnsAvBKtDOHy19RChEJsb8T5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 585169df-9af6-4013-f307-08df43fbe414
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 16:08:45.4599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+tiFN1N09qJxPNljZKtrr+cTtQEOG+SgFEbNIYAUlyAlmh5nEQV1TrQFYc4vZWOBuzZffrkIa+twQSWXCfP4/2O9vdTslucfpMQ46PzVS498eY3I/OQJ9B11zwm3yLw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8068

On Mon, Nov 16, 2026 at 06:49:29PM +0800, Junyi Zhao via B4 Relay wrote:
> From: Junyi Zhao <junyi.zhao@amlogic.com>
>
> Amlogic A9 SoCs integrate the Silvaco I3C master IP in two domains:
> the EE-domain instance (amlogic,a9-i3c) takes "pclk" and "fast_clk"
> like the NXP integration, while the AO-domain instance
> (amlogic,a9-ao-i3c) lives in the Always-On domain and generates its
> bus clock from a divider inside the controller's own register space,
> so there is no external fast clock and only "pclk" is exposed.
>
> The two instances differ from the vanilla Silvaco/NXP integrations in
> clock topology and required init, so the driver matches them by
> dedicated compatibles instead of the "silvaco,i3c-master-v1"
> fallback: a fallback would bind the generic driver data, which
> neither programs the fast clock rate nor handles the AO internal
> divider, and the variant would then fail to work.
>
> Add both compatibles to the schema without the fallback, following
> nuvoton,npcm845-i3c, and use per-compatible if/then conditionals to
> enforce the clock counts: two clocks for the EE-domain instance and
> one clock for the AO-domain instance.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  .../bindings/i3c/silvaco,i3c-master.yaml           | 26 ++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
> index 853092f75..d892d42be 100644
> --- a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
> +++ b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
> @@ -13,6 +13,8 @@ properties:
>    compatible:
>      oneOf:
>        - enum:
> +          - amlogic,a9-i3c
> +          - amlogic,a9-ao-i3c
>            - nuvoton,npcm845-i3c
>            - silvaco,i3c-master-v1
>        - items:
> @@ -28,14 +30,14 @@ properties:
>      maxItems: 1
>
>    clocks:
> -    minItems: 2
> +    minItems: 1
>      items:
>        - description: system clock
>        - description: bus clock
>        - description: other (slower) events clock
>
>    clock-names:
> -    minItems: 2
> +    minItems: 1
>      items:
>        - const: pclk
>        - const: fast_clk
> @@ -70,15 +72,35 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - amlogic,a9-i3c
>                - nxp,imx94-i3c
>                - nxp,imx95-i3c
>      then:
>        properties:
>          clocks:
> +          minItems: 2
>            maxItems: 2
>          clock-names:
> +          minItems: 2
>            maxItems: 2
>
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - amlogic,a9-ao-i3c
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +          description:
> +            The "ao" variant is the controller instance in the Always-On (AO)
> +            domain, which has no separate bus clock and derives the
> +            bus clock from an internal divider.
> +        clock-names:
> +          maxItems: 1
> +
>  unevaluatedProperties: false
>
>  examples:
>
> --
> 2.42.0
>
>
>
