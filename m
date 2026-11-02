Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793656141;
	b=XrtUrnv8riQF1HfoamlVf6cL5pShSu6UXaD5fKz0pjtUu7rRVcs0LYN05QKRX8XDaAPX
	 ZM2svjJ69ozrOj6Ab2Fwg7Frrkjqrae+bKEqmb0/cbeT9m3GhAFUEDxI4/NCMnCfOgDVu
	 aBxORKyN0rLFn8qvbARzQ8dLBuzj/MudlBH6onahwwhs3i14VRqjMcinCOEjkUbHLc5w5
	 sR43La6ImePDwu7cA6CTdMxbbWCKGhHNwzHgziJ706qg+pATqwBaIPvj5Te9zoCOcvymO
	 WKZsX7S4d6ECst4pL9PAfnJG4Vc9FGPSBqrk9lgZFRhrW5RJPv09ntm/4UMxE9uxpug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656141;
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
	bh=U8PmvHLmml3DjzXlp9kooyIfMOohE/6OccL0w7N3AGI=;
	b=BJhUIuobKBe8ect0qCsUOzyLeJEALlWcSZT293bxpfGPyuAjI8/tQbtDom2e3+Dr7OE0
	 HGaYmiBvwHveMv9Y+qMA3OsXeh7piEYBrnWN2zIY7bLUW60oRXIYYkzjPmTQ+eNBXEdsJ
	 fHPh2Lgynmfb0ffKPK92w7fSbIWR3LDhAczvTR9tThXvoikKtqzbeIW86j2agk4XedFbu
	 vzDqAIpUECqi07JY6gIOoMTEDERE36NA2bDAekWMMrIUUTTW3oS9kubL1EGq1xyj05UPR
	 rFU0xp4msZj2za1qFPXs5urqMvTxcN3aZgwcN4IR0t2mbkYcZwrY60VOAQjniFYrbsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=j5J1U9yk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.33
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011033.outbound.protection.outlook.com [52.101.70.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16570606A329;
	Mon,  2 Nov 2026 21:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16570606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=j5J1U9yk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRctDTX9MXscpD9l4zkAp5RgEI0bqsvqWP48erRI6UgPjJ02xHJvMncG1Uc6OBIgH6kqTSOMC6VXUUvi1ml6Iz2ReBRNBQwFRDBou8pm79hNOgDcJN1wbim1C8syjoKxcEAv3bCSermPuV1S+EQEQBFyA/tOyhZurOQvaBHKD7u9JSUqvtpdxxdn0fE/SQDY+RZXpGlNUmfqLCqpTlQdwwflvQNXN+i1Ga2D4cCEvEamYGUCGuvwNqzZGjjPC+EoA3WDuXrexhq/V58J8fIA6K208yMO9tIN/jLV1iE6qvpnSPB77/twmNDvMYGUx7oqG2OLNW4eyTtrc8/NkrhmcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8PmvHLmml3DjzXlp9kooyIfMOohE/6OccL0w7N3AGI=;
 b=FUp5QTJJqT2YroDpURKqZQcrHVJFzt/ebEdsU34fAhYgVpq1Lkh/L/kjkCWi6N1PoMQzW8EBLunaXp3Ps2xaRdqKQ+vTmE+/AJFJg+UHQWobnXuD6GD+M0tJMw8ATbvICpY2k/bdN0fzX6P6LUqmoxpQZ7nJkUlZOdc6XoX24PqMZ4Y0PonEqd5bIFrR+X77XGL4vlcZpJOsxVOkeehkor8MnQdNgxmMMtJ1fWJQKoo5OWG0JaMy819p0wCwpXFOMXx/jEOKOGdOP3ec5+NPAmo8WwNB/y9PqjKqV3No21H6oyeIbDvdpSn5n3K1u/DN1UU2PBrOA5LT5caY1IfsJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8PmvHLmml3DjzXlp9kooyIfMOohE/6OccL0w7N3AGI=;
 b=j5J1U9ykg1+veS6vEqykwR1OZT8byXvZCsUmLmwjVMePgmpew9/ZtKqriyeZe1XBTI5TTG/sF1ySxzCnb8QbRWD0hp+f416dVh1lG3zyeLUW7w0SNt8eCBNPrYrK3FXt8prSI9rEahRIw90tzDVmSDCyjQ+ZCI3SQLbSXnj20360ZsGQcgrSzVq+F9HTKYeeM/nuf7rw4i8WWxMQ+5mE0XkJzyQUNE0lBEQp09z3jf0Pc7ab1ByjSXjI9tBp+vveNoG/Jlu0hTD+HkC8Fkj3V+0G1u8EbyJEjebOlyAGDubpJjRxJqlbpI/syXTjXJjOG+vCMmQbw9Jr0u3ND8f47A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by BR2PR04MB363639.eurprd04.prod.outlook.com (2603:10a6:2c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 21:48:57 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 21:48:57 +0000
Date: Mon, 2 Nov 2026 16:48:47 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Junyi Zhao <junyi.zhao@amlogic.com>
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
	Kelvin.Zhang@amlogic.com
Subject: Re: [PATCH v2 2/2] dt-bindings: i3c: silvaco,i3c-master: Add Amlogic
 A9 support
Message-ID: <aukFP7holuhVE7Vl@lizhi-Precision-Tower-5810>
References: <20261102-a9_i3c-v2-0-0c474bfccffa@amlogic.com>
 <20261102-a9_i3c-v2-2-0c474bfccffa@amlogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102-a9_i3c-v2-2-0c474bfccffa@amlogic.com>
X-ClientProxiedBy: DS7PR05CA0069.namprd05.prod.outlook.com
 (2603:10b6:8:57::21) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|BR2PR04MB363639:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc03a17-e0b8-4db2-116a-08df392b1897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|19092799006|4143699003|261021123027099003|11063799006|56012099006|261009223027099003|261028144727099003|261026121527099003|261022105027099003|261026140227099003|261021121427099003|10067099003|22082099003|18002099003|261102123227099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	RBh4hbbBuYTWbUKqrp2/fqZXt0glzI/vVT1WQ9AWITSDeAoLJFAAthDUnjWN4uDm2HhanzAiiRCsi9pJHiSQNKFlb6fRFWDhOfF6QM1C2MZ0VBBJVy/NPhHCwdRtix5vlFLQZIbPTWc9Wo+GbxTW4Bb7rPAeajAdaIFC4aF0aJT4GWf6b0eP+ky3k/b2+CpmA7GeeULQ9CfyRwpz02X5+/KWFI+2xJYRJLFNNVMhj+cJ8u6VWWCWUmO+aTNmY4zGtmVOtAXUXbe6yL5kDIvShyKfxl8nU6dQB+6HhKo5K5tlb4UJF5df95O9yk6wO3hpu+MEdVSeY+OfjeZNr/v/L/ouPziWR0bA1qQOD2S03S1M5c5wmfn8oHKdCLX5EO85iprN5upsp6Tn0PHYDZTDoSRkRjdWpM5SfnLElcGhMWkvgZPGfkNQVvug1dwB/ACxIEKF7fOdTMrO5teOQqYhMYwmmbSTlzGwEt3V0WRvcZBgkWVTV8Z3UJjqxHRGmfSspPRHZ8tAnEwpUA7dxmBYfySENPPk6g3j5XseWdDbAEaVPVhgsvvy1VdONxQz6cV7ULg4Zj43sLFX0EEGOqhPC2CeT3KrybIIVB9X/qveDQszghi3edA56XZaHxqTUVrGyNWSfZ38LUrTIJvJrE7r2PuSCiAqJw/lLW4/E2H6Npw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(19092799006)(4143699003)(261021123027099003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261026121527099003)(261022105027099003)(261026140227099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(261102123227099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y1Y6kY2C1vJvMOt5rYrOm2M7P9pWCKgszJ0uXUo88s3C9Vb9VOHqWA1WsRM2?=
 =?us-ascii?Q?IyhornJq61Wr8QDXbJc5MPKvDEnUTzpyNBYyGC9Bw9S2mCO8+Dt73+bqvP8J?=
 =?us-ascii?Q?77Awga7e7Pzw0B0foluHPjCBjlJNNE5vEFq84FHJLLgaTfDERWt7b/f6Ib7E?=
 =?us-ascii?Q?MN4qeqJbOPzmP4klfpWcb7A1uyDjTPesnJnefp0dtcBTbokjJmLx3OlgRrSG?=
 =?us-ascii?Q?XxFHay2PbHw8V2ohqCL8Ti0REOrPxR3lCUWqurE3NuNH9e0FG/NdUHz4JsnK?=
 =?us-ascii?Q?fVVTw9KyrqnJzzpBOoanpFqO6dtuYiRo85HWh3k9Xec6vQIHk5a9JXh+iqdO?=
 =?us-ascii?Q?W195lxp3NiaG6SDLyXNASRslxmJx1U7mHMo/HNyj4H7/llWwQ6HYNCplQVqw?=
 =?us-ascii?Q?QW5jJ+KEW7HhDUwKccOgLJbVNJ2dzib8cx4WCFbroGBEH9++h2sxG+Led4IW?=
 =?us-ascii?Q?ubv2RlQK7xZLV9uxQsNFhc/e58hVClYBmS5CbHk8XREl4Mju+qXs6KpGXkAZ?=
 =?us-ascii?Q?VevQJnlx4CfhTIPCVMoifnZ/w2Vg2zBdc9Fe20ztvjhANIqSwmE18WrQKlXL?=
 =?us-ascii?Q?/0nPaCh62efd/tgyMp1BckhVnRjFsQOTNZ97AthBviPpUD+jFSka4RPGBf+4?=
 =?us-ascii?Q?KKbtmUQ0zvDvMJVuYhvXH1GKO7ZUhOEm1fX8P89SVEjSC5ZNt/QKDg52ZCja?=
 =?us-ascii?Q?/W/XuKorm0WUTfot5bNWZffXWh+NX2x7v0OE4p4vwW1cNrCrnlmSytHsPUWW?=
 =?us-ascii?Q?phIKeR6/F4Uayy5ebB9/LT2Y04WTBTeL4JkIN+/uAjXl6dA+Wz167ROESccg?=
 =?us-ascii?Q?x+E1GwzeKqYUKcUf6FjNeuqLtGAtMPeDZcm9asmilvUPJcphld1Ex6ftLMcj?=
 =?us-ascii?Q?FsTV4iUtf0zOnMv9pUZpTcqA9ZKp/NQiQGvuRwh+ZCvHk9ILD3cTIIIJ9a1h?=
 =?us-ascii?Q?Jujk94E9lgh/pD9oHLmr96/3kdFjMvLKlgp+I/fEC+9tQvTE2oVI/vpW9lOg?=
 =?us-ascii?Q?dGydOCczL0IkcIbZAu1ZN8IklL7gS+EecEluc60dcLWM35BpZUZctr0R6H/C?=
 =?us-ascii?Q?6gILjowO2P7WdSC5R28w2pUyqJ4uvxm3wEleIYJI7wn4kmjObpb7n74zKtUy?=
 =?us-ascii?Q?CsrqtWFnTAAdXddh7WOGQAucdJUL/JdVUb+3Q60h+OH2rJnhTQaJpPNwAM6y?=
 =?us-ascii?Q?NK6IWhtxZ6+dV0GOJ015L75tLyzZJmQN8jIi6J9HZJ34O0zKLKWc/S2VqBNP?=
 =?us-ascii?Q?RgNlTIT3jQMRusCollWG/Imi0tt2xX9b+7sYqmqgpk83ho8KiF+opLTTuuC0?=
 =?us-ascii?Q?TXMfN0YfLVEXOBSiOtAmDI7RJ+9BMhfs5+vuxgDh8WI/BBauhjAC2SvUdB3+?=
 =?us-ascii?Q?9UQeJe8mj4nxwNGYQkteUd6BLglhwLcmVA1i+6JIprKVit7a3HAFVIuk1TKM?=
 =?us-ascii?Q?x5pco3AS/bsaKT+TCdlbYC5D7T9Tr8X+0D2EXLOOUb7qraiKj6IzaZvZ3KXm?=
 =?us-ascii?Q?yBqF2ul5K8zU1PKlSNogLZUCJaHQAx1tYa+mMZssYBROSjaCVnC6lD7rOIlP?=
 =?us-ascii?Q?aUl6jWbdjqRPnJhzqBoCnSSE3Yb2I18oye7Vx/PdRgDoyKhyeEAFdeOOgDmh?=
 =?us-ascii?Q?AhKKHyyx5k5tZ1eJKLI2wi45kNdKLxvxt6Gez31K4Gcq9IeqV3Q2Tol2Ooyx?=
 =?us-ascii?Q?FKNYcAkoe/CVwNhn9d9kthq9AbLZ8Xxh11b1cJBURdQn++CY0CSSI1N8fgxC?=
 =?us-ascii?Q?jCWnUZTEwfslQWDbp2OxaYp4/lvSFRCGmvqoBjrjZX1gI8QYtPoZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc03a17-e0b8-4db2-116a-08df392b1897
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 21:48:56.9515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hP/rbmvauUj9d9W0j422TJa64YDCSbvf6XtB7qK71e2LDTA5PlxwkR9MWkwuSkEeNm0xaSRvANul63Ypi6k3pd3/iLvZYiuuYMakJYjA7zo0QKPQc7GIdDpXZNHyw9Cv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR04MB363639

On Mon, Nov 02, 2026 at 07:05:40PM +0800, Junyi Zhao wrote:
> Amlogic A9 SoCs integrate the Silvaco I3C IP with two controller
> instances:
>
>   - amlogic,a9-i3c for the EE domain, which takes two clocks,
>     "pclk" and "fast_clk" like the NXP variants;
>
>   - amlogic,a9-ao-i3c for the Always-On (AO) domain, which exposes
>     only "pclk": its bus clock is generated by an internal divider
>     located in the controller's own register space.
>
> Allow both compatibles with the "silvaco,i3c-master-v1" fallback and
> enforce the per-variant clock counts.
>
> Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
> ---
>  .../bindings/i3c/silvaco,i3c-master.yaml           | 24 ++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
> index 853092f75..de1fdec65 100644
> --- a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
> +++ b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
> @@ -19,6 +19,8 @@ properties:
>            - enum:
>                - nxp,imx94-i3c
>                - nxp,imx95-i3c
> +              - amlogic,a9-i3c
> +              - amlogic,a9-ao-i3c
>            - const: silvaco,i3c-master-v1

You have drvdata for it. Needn't fallback to silvaco,i3c-master-v1

Frank
>
>    reg:
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
> @@ -72,12 +74,30 @@ allOf:
>              enum:
>                - nxp,imx94-i3c
>                - nxp,imx95-i3c
> +              - amlogic,a9-i3c
>      then:
>        properties:
>          clocks:
> +          minItems: 2
>            maxItems: 2
>          clock-names:
> +          minItems: 2
>            maxItems: 2
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: amlogic,a9-ao-i3c
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
>
>  unevaluatedProperties: false
>
>
> --
> 2.42.0
>
