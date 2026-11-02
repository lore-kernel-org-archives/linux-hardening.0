Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793655894;
	b=u7Tw4lKNJh5jukK9cSEq69pKQFJUHdRPGw992M1ncHZDwA+g+U3S+oN6j/NIEynNCjIe
	 kmwbfiGLm0xKPLYb6smF6OI3MyOqhaT4Y0muTzvkvVW7nQs1DZA7XmDoAkRRFKYeoxJ/X
	 BciVoB9vEQTpOLqh608h1Cfxor+UbxPdR5AxdyKWQX4L6nMUK5nDaCf0VUa9CX+h10SF+
	 o7A61i4Ri0jpQrvNXm0T9kEN+34t39VX2szIC5glKa3+JMYQMGw8J0EWJLHkHAvcjmmpP
	 eFLJdN/b7APlwORMh/ZpPXkGLATapOAa/kqDLZE4W3ZeLk9NNDFWaB4CWkTwuHd6r9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655894;
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
	bh=KowglsUGucuwN0s6uI9Bre+GD+nznBIhIiDQmxMQP1Q=;
	b=vv3YxwOVlVUOS+RXuhN2WlRa7oufJX4125C5bDQlZgyjFtJZreaHbWgfSL90ELBwU+6D
	 6aeQRxZ9hk3heXKiMtnCq0yQd/8aWEwz8VzZkAHvHQn8c6s8QgYoHrBFJ8UCLKtcnuQc3
	 WSm7pyzwZJO2a9q12aSOeCigPD9Xe4lTMnXWL+yqOf+TLZuTYYjh9M5v6TY6haX151CFu
	 kotP7x1L5BrhcuToeNtT+AaDYZZPrtTjRcWHj7zBNV7cfOtpNii0Oxa2EmBmFP8+5mmzl
	 ZaFYsQa1R1HeHDdV8WG3Ifvb34mUts3VT3zVU3hOhzIYGBf8CSiK5ZpkmdoIrYnpoug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=aVMO5DF6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.34
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012034.outbound.protection.outlook.com [52.101.66.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E43606A327;
	Mon,  2 Nov 2026 21:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85E43606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=aVMO5DF6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AmBUwJFeeZIpbE2nR06fxCjcT0lT7j+aUycy6Wct+p46avG7cofk/bYLFl/RCbp/iRBuKoU5M3ANNrZiLEdnunv2xt+nGO9v7zqoAjKYbqVuiKlhzDbcIdN+tTidxLVzVNGf3eUNg7/g8Sfoly/XalR2jmLeYynu89ssa+PhsIBVhCdjwN9o/72HLeoOR2nKOMiLA5OHW3o7xcobM3LhvqbeVDEw4MMazMSiq5LxDGsuag3T1eZtLcJQTtgg/FGz4qGKsAx6WYXsBO4aBVT3bC6h8UsMMvnjS0mJhzGcEqM2/yj4HK3SuiSjAnWAFOSx5aIkDS4JiTlYbHCJrhqSyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KowglsUGucuwN0s6uI9Bre+GD+nznBIhIiDQmxMQP1Q=;
 b=JNC1mawal2DGNoVihCd7nEeY9khtS+OqKsW6D1pSvplkBV5i/9kOnQ9MwoS5JjmlPpv7P9VuVb1XJeiHsqhQQmxAoXKhg2jIf8U0578kvQAm/TERiciX0PkyG6GjZWVmrB4HN61Tn2UTzvp7+dDFMP8WAo7YdHE3AdqzqGtXaYlqRTSGFahzz/oAt1DnFeQLZ5CXXYcSRnsHIE480x1lS+W40sKhVnHOn4b3qKPcXRqygHWt+aFzZHTMnX+ovv++b7dpMCegg/LfXUSmoyB/9UHq4Hjm8u+UyRbJKoGHTGYsh+m3cTToL+GW10qPZc8mXlM92B/6h2moBuk7AQvQeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KowglsUGucuwN0s6uI9Bre+GD+nznBIhIiDQmxMQP1Q=;
 b=aVMO5DF6VYbYhudMUfSPL6AuXN5VTOyPE2BX499mGGVYr/LPuEGcfmTurO7/TK3+BtYrvelYJYcSnMITsltqjVzbSIvmW+RPU2CIE1yercrO3cYaWJqqKUWvh55xxlPAiF8iZTlg9pu4qmWYV+oPR6cRY+Er7qCyHAUjwp7ogY+k22XdLxWoC7p1+9FhxJfjfgCK41bZ9cJJ4rn3Axt9w846njjZe/ly8aR4e2Om6oVjLtgrIJkkAxmAciWmhIalaHlVAUFkKy3Uf3dqf/hiujf+Hv51oZPBoxYVsQWsrYmA2GNvUNNrNWL/p1KPOUukh0HzBuhckWl5QgbAFRgHPQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM9PR04MB8555.eurprd04.prod.outlook.com (2603:10a6:20b:436::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 21:44:49 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 21:44:49 +0000
Date: Mon, 2 Nov 2026 16:44:38 -0500
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
Message-ID: <aukERgniLcU7BHeo@lizhi-Precision-Tower-5810>
References: <20261102-a9_i3c-v2-0-0c474bfccffa@amlogic.com>
 <20261102-a9_i3c-v2-2-0c474bfccffa@amlogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102-a9_i3c-v2-2-0c474bfccffa@amlogic.com>
X-ClientProxiedBy: PH8PR15CA0005.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::12) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM9PR04MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: bb48794b-c1d2-423f-16b8-08df392a8528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|19092799006|7416014|376014|22082099003|18002099003|261102123227099003|56012099006|4143699003|11063799006|261009223027099003|261028144727099003|261021121427099003|261021123027099003|261026140227099003|261022105027099003|261026121527099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Ggkj3DlZn+Pfpr5rZu2dxdkZjUMWV1JrL640BOAU4yibrMDG1GvUZDDSPQ/16viDb9jWWn6dgjEQlBUad4cunHe13k148uIcfHinD/BMzfGS0CwwdzFanz2MQXpvr12XY/rrfb7PedlBEXOiCtP1o54w1v9sHyq4f9EaXqkVzq7o7JndgD0bKZzBirYF+uWCBwHxA9Yy9IHqOOt0TgoUaFmO7bmRuH2MQ5JliaVaeqVuVWTJNY4iQs4GoQsHw7RHuNrD3UHK9GwcMLuVOcKRHoRpdR/rgsDg+oh74/PJqweK/edfCFHkTnx/ATRMVGix7b5Yf3XC6kY5jWP5OMlYX06Pu2a/m+f/AOEOaU9iUb/Uu7N3Dbd0WmwTMVMIGebPxFQXeZxg+V4qULkLINxet1eopR8Kn8JooRWKYuZdguEjDCl9HqX8MuR01A5CS2mRMNGGA4P1tXEfsWsq/W/xW8TC8hdb2wzxcCimhGWMAYjf7gnQo0l4QWkrW/ZpUCX7gn9iOg0upeOvQWNldsAMY/PfsiEIoAAWfW2B+22o2xVxKL/a6BeYKZPkr9gcLNS9NM0z9pW+UzsA72CHlOdB35ZfMp5KwrDsLtmAFVhHzXnwRhtSx70r9s+3H+5qWUAhxtlzQOBaww6bUOJsUGuwbm8fu4RN8DgI/cZVZySdGAs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(19092799006)(7416014)(376014)(22082099003)(18002099003)(261102123227099003)(56012099006)(4143699003)(11063799006)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261026140227099003)(261022105027099003)(261026121527099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?87q7JOvqJy14yzndaKTf5vtk50r5SzER1F88r0CdmliDAfrg+Hnh9ELX4s+W?=
 =?us-ascii?Q?rFH+j+U7KA2kJALEH/FvdcLaAOcBi1E8pU+Hfwp6A+DJWu7RS382sJF4UWRm?=
 =?us-ascii?Q?P3XbvHU5nOo8MjF/I8B8o7VR0B12rkAhe5ZXgmwTCuWsn6sq1WuzImVfRjmm?=
 =?us-ascii?Q?nH+h93tTVwCTGDh7AePuIsIjhi1RxaFlaPQp/B0cmWpdZ82GNYKxPHT2UznB?=
 =?us-ascii?Q?p9ed0T4JUh2FmGJ0KzuVJXIRFjNO3PvFULL6LfNEFuW/93R6hulKhNKShLw1?=
 =?us-ascii?Q?mbqxXe5YuTAgzqb2D//h2MjUek968pXXh1/BPaWS5rqqJPz8YhdeEtUWl6Rl?=
 =?us-ascii?Q?+nbxBUaBmT++wZurACqqf9h/Zf7IEygfvLtwuzZbmFBOMIxeof3ix2phKab5?=
 =?us-ascii?Q?wrFfS7dGzd1VNP1md0GABOPWcoEGJTQz4C7YZNr7IIp+DWQTr6J1bXc4Oxvr?=
 =?us-ascii?Q?Tl+qE++fuipmNyh1JPMfH4kxobRAYqTS5TPizaQFL2OWiQYSeogoHso5SICh?=
 =?us-ascii?Q?ox+zpJB3bQYC6vwm5a8HbssdbiFhLYkBPZfjxn0lOGU11onHG+TspsTvJ1CX?=
 =?us-ascii?Q?Te8McuCzegyFhV6fYItbSjc+lKq6ZQHa0pO25ThzVwWHN6UxTDaF1bFhu+W1?=
 =?us-ascii?Q?VzLDLBevHDrp9HiZQmFgSvPW0YPwbRhQmOVThyxSQJZaE9OcYkKZCZq8lRaz?=
 =?us-ascii?Q?jBTa84rrkIwao+uyXyt5R38Z0Uv4Mb88bIBxCrKxPAhIFbrJ308U1RC0z94s?=
 =?us-ascii?Q?X8/8CR5wtQ2tJk05knb5VTIfq7R4AMVtwBy1fmhkTzSoF9LMm4RS3KGAbtRS?=
 =?us-ascii?Q?fLhGCM7GfQUM30GsEf13Ey+qJsdb/tg7NUiGaCWvkgNZVtT49A8kBYIUtl1F?=
 =?us-ascii?Q?0dOOBKvBlhbyzjTd2Do32jLS3Dt73SsahtLGI0hhBW5KshW4p832dv+uQsxQ?=
 =?us-ascii?Q?mRg36HMWefUNkX1Wq/XiYy0vKBJCR2oGf63oidIC0bT8+SMW4CrBZd7nJHZN?=
 =?us-ascii?Q?jCFAJ6j1GUSh0D8enoCOfQnaPyjdb2q8QMJvbiP9oZnBECUqCqG+1PARUp0e?=
 =?us-ascii?Q?hPnA/BzY1ellcdEakdHUymD32iYUn6AZagmhtcFTYKPxmXBxDhJa3BTnDYvd?=
 =?us-ascii?Q?G1Xvdlb577srntWEVu62GMUHZnpXJrzogwlj2T4iIrRKT3vyY8px3ZrURlgt?=
 =?us-ascii?Q?qzZJDPQEYXksv6W5jHxPeI7NDJpjx6Lt95bcZlqEBy+Pn5tSnbMqx8F6A+hd?=
 =?us-ascii?Q?Xjf/K99Buq9q1IS2t27hl6LI79jOdyCoFncw6bYc531NXcRZu7WzeUqP5MQp?=
 =?us-ascii?Q?Q7w9EedU/HtJy0v47vvURI5DvM7RxQJhjLiYsDKknxhFvLE2KxwNgYMbxxWj?=
 =?us-ascii?Q?aX+3AR8xdkOZeMJPiy40BiMBPJfYnItFdh9vd/hglxn8r7Z7q/6wNoKH8R+Q?=
 =?us-ascii?Q?9N5wXrAcBAVccOymFGmkm0KJpO1kFt/YM2B23YLizGU8i26s88vblS8cb2f5?=
 =?us-ascii?Q?iT7yKzpjFIJ0Mo6Y62suv+4qmyRFz7gylhupA8hMeEo5/Bxc/CQyxPNd5u1Z?=
 =?us-ascii?Q?Y9R5b1jzsV921IE+vwNIYBlhgkhszPJdFsmHSzDkNEGNRERHcT6Hy3XCNJmK?=
 =?us-ascii?Q?xEFCYlb4sWdHoq7f0+uB2k76vsb3x28e53c2im4Cf7nv2ktfk6D5DnOsesjN?=
 =?us-ascii?Q?ty/aNr5gtlx4KQ5lOE4jckQwl4wyPTkwykh+nhuQxuI4kZ9uvjqZ90mmetIL?=
 =?us-ascii?Q?n41mdBh5XC4XcpabXTBIhjBP+SUmnUnQdcIuGgcuJ4+5tcAqASSZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb48794b-c1d2-423f-16b8-08df392a8528
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 21:44:49.5904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVDdpLbEmnIJ1kQOcflogArgHb1gI9rpme+YPLDgAKJ4bjXkVFvqNpHVBldAt5PihjNQF++yOb/4Z35tGIHEWAs8dkOPyB3ACpXLAlJEok9XFD4f0OLPixDct47HfOiY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8555

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

Nit: if respin, add empty line here.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
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
