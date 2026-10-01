Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013012.outbound.protection.outlook.com [40.107.159.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D400235E956;
	Thu,  1 Oct 2026 19:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790884645; cv=fail; b=MCnbC3bdMm7Rx6L/zWJepWwSMiNM6+kFghpzCCYSOQjKTJLuFBI+9FOP3p9t+d5FALzmlR4EhKyMUsUNbOv5zp5JHPnn1wKHK169ZctvpnMYaYyjbULmi9X+EWOgV8HzuE/N6t6x+yQw2pL07JYXAlO72Z/jOeZ9GhfrT1QDEz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790884645; c=relaxed/simple;
	bh=qru2g245di2IieRujSQpVCm2TAO/62lDerZmBaXo0Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WXHw1ziSrl2ylMrA6dZi6gzuEdvD4udp+oT96IHcQ+8J5yC9cEGUn1j/OyDfWV5wgJ+BWLSocVmfXVQsKwRiT2amW+89optrTMRPTSmmpXmW6kn6LRYljKk2P1cQiJQWRVlWPi9tORxdp+JDHLPohsV/qawegCpQvjYYidypTVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OCAUX5dN; arc=fail smtp.client-ip=40.107.159.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OCAUX5dN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GzRkC+lOykN2zL5eENDffg0YyQi8bUOSPvaWuafw5dGgfYtKYmqr0YIlzN60+pHbvx/t5/eAokMpDAoFsDXfSehYaYrHDDbB3oMQJviLEwI7Cy6uQ7ibyAemj9EoQVvKUsBOH4TRKnqrGGPwipEeuBFiIfIEoi+0lbU9bm7QJv8wDSgeEQcGZzfvcNyCiUBNElX3mHwJXFT6QJOFgazXn/xuBN/iVnNaKEueO6r2/2SO7M2vFtVZDb8A/Bi4zKOxRV5ToQ8II9KWU933MOpj6wmkhthgg++y6+56/7MdQDuTmO5UB7yeNZ3pnTkgbz3fPjknhwGC1FhqUH0gpz9zIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giE66s6LU4F2ezlTEqAK9bEkVNxS3iTwEALakrkKN4c=;
 b=Ik37nLxEI72CPBYyln7vYt3lWow+ELXl1yf8DGxbSVVV5R1T9L8JlEfWyEU/n2ugFi/mJf7Y55+I40SwZLaaSCsyTM6i5MdPaP4v/uv9Z2K0UvOJmIvJ7l+Y6RvKlrIsFPqulEmd3AJLieT0Y2clC5nSwHSQgpbYhrBqNzbnuBVKlJoeE13hcNKhJw3pg1TcmDi6ryukG7fp7u1WMBWjh9TpkY0/uvTMEJsrltDrUpY9rAVH7RbRncIsE3gZhJT7SwU3mPPwizUfyqafQoQRjwan0KlPvkA1AEBkKzhT94f1vDm42EOoJDrrt1rfatmfYBA+1I8Dm9J1Frxz+hOS+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giE66s6LU4F2ezlTEqAK9bEkVNxS3iTwEALakrkKN4c=;
 b=OCAUX5dNbxhKrCWjwIZdC2UdxAu9NX7CUS2sbcMSpaRrNE0D9TSHpyXXBGkqv0RqkwWJ2SGaDrDCqG2/yjDngtXSvn4JuD60U3JaQoClEkDoeGfFttVYe7zg6wKQrZuWD6z4Qu4ocWjJHYJhHeuDP9eo4ir/M15rTVf8tWVYn91oB/uI1Ju5Lp2TBF4MdPihGgHmfVSgT/P9lY3n2Y+D+Ic2y4U/XbdO0N9y7rKVWV0Ba2Zq7aLCxee74OvweiJ2FKj2feD0AKUdvYSeeaZ9a7C5botYXV7Pi6LRzGuPdw3n7PiLRwa4mqi+vR7swrg2Aqk7xaj+JCTq/2/Xz1dyuw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by MRWPR04MB12120.eurprd04.prod.outlook.com (2603:10a6:501:97::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 19:57:20 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 19:57:20 +0000
Date: Thu, 1 Oct 2026 15:57:10 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: CL Wang <cl634@andestech.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	tim609@andestech.com, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: dmaengine: Add support for
 ATCDMAC300 DMA engine
Message-ID: <ar67FuFDeVQe0-wp@lizhi-Precision-Tower-5810>
References: <20261001014503.786490-1-cl634@andestech.com>
 <20261001014503.786490-2-cl634@andestech.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001014503.786490-2-cl634@andestech.com>
X-ClientProxiedBy: PH8P223CA0026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::16) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|MRWPR04MB12120:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f195e06-7aca-41da-1afb-08df1ff633b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|19092799006|18002099003|22082099003|4143699003|3023799007|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	pD4U0FaBHnrahWgFn8in1BjR96oXxDCSXuzy4NwGva+CGCS698lMyQH/LZ+SWxesxT5MGsIym/CXPI/lA8Iut6Z4Ylq3PdVMdlpZxQuTaK5wgcud75xSj8mvAGNngbNIcZ5r/3YlUsblhcCSXbvQdohVqyqw9qyKyb+pT1/xXAKowLtojGVeMzY877Mvw3j9tOvdS7JuOByoHwf+vT9nvem2mZZlH1ZuQIBIEq7Ku1GRTmuOzxJaAceJWyUokJgrQQ1QJYU5ft1AQd0gHFYWhUEbLOkTaxEVtZmZAalaLtyeGDcTv4t+ocXqhyXA3xgHCwXy1MxqRI8OkRUP8jnM8EsDEuAD2R4QjXd/foeK65i7AUFZbwWGvMlQoCzq8h61HUT0zh0RQGYzUPG6hc4G2odTcxj5FsHwyWFIGGHueinse2nyvT5xUdoL7gqQJ7Mg7wkxyhnuqCYwmcJonC11qnKgt9ZUCd0wPutTHaWGCl2JipKzZLBTHon9e2448iq+XnxFzrs9Vd+Xds5puHkLvB4R6DvA7iMThMT+oFszFx4DMDrj3Zq2Tw12ubUj1aGG13wh4ZkvTfDM1fw2GyCZqnEk7f6NNcIW5lJDPmWBEeMRxPAdpXVL7yYOTB+JH0zo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(19092799006)(18002099003)(22082099003)(4143699003)(3023799007)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2wolP68/AotQh5Koe4uRMuzD3j2qqEtopxeSm8AWZ/XFbNMatCd4n0Ow5psa?=
 =?us-ascii?Q?0NPasXot+pTddbtYVWGMoR+bMfGZ9rGRJOEtGU5zlqgjlOlbJasNVZq6xGkk?=
 =?us-ascii?Q?xL4kcthl9DjDcV++dQyREmc0h9pny43TCVdt5DguKShw8EqIjJBfeAGcmZKJ?=
 =?us-ascii?Q?QZ2quBQnoUERWFzETmfUqVCJ3Zt5VHKfewyz8uu0RY9UsvuH377iUUAYmyDh?=
 =?us-ascii?Q?/Ojn0E6vzk5o2aqom3qqN88KnuQv/gP7nBS2jPaqs02RmbV8+uQ/Q7obuMOq?=
 =?us-ascii?Q?PnyYJfBhHPCPoY44cGCKFnWz1dfHPMlRuKeDZyfqxDBEHvmIbhjpEdRIR7nJ?=
 =?us-ascii?Q?zy6JmQdBxJ9aObW16bKFO7VnZUwz93YiEvIU/Io68m3IFqF5PbFkL7mi8kmK?=
 =?us-ascii?Q?L7I9gJKF8D6wSurbfrCruguEpJU36vU6lxdIJHtPxlADmM/eisQpEjlFISHR?=
 =?us-ascii?Q?oycn+GRMs4wHKMDFGCiCf9kIPr2uMZoZAcWVQ651NZZCGG5SFjzbyYSWNrHd?=
 =?us-ascii?Q?sZryU7p14mzqqB7dUTqNhUMidue6CNpB5ewLC//7Ojww/Vf/OQmLy24vVsRX?=
 =?us-ascii?Q?U6tQAjzDqSwRQS1adkjbzgpSnWSn9ZbVIVOug/zmXYrlJQ0a4tSe4KfWjgxq?=
 =?us-ascii?Q?oC5dx2JyPHTAKDRpRn1PZsxjN+daSgFRR6Yb6GgYXB7Puv/b8zrAC5OlgVxu?=
 =?us-ascii?Q?agcSSKaE7yoNDN1cvxkbB3ByT1atz21MFgILYe4xYJJtdcQ0srK7W52npMNs?=
 =?us-ascii?Q?dttjhbDnsrjapD5F/HM05S6DoJFinjsHVQ/Vw7UOc5kQ2Lq7C/X/msLrW3PH?=
 =?us-ascii?Q?x4zqguPCt5L0k4iTtsRSfozvaflH/erkGk8cSnfsdKC1wsbmFQNuvTq5Ez+8?=
 =?us-ascii?Q?ZyEF28QeVcREGKJiAFVh8uPrKsKoRaVQyB/SOmDUmF4Dbu8L2CttRfnihruK?=
 =?us-ascii?Q?+ecPYNLVm0wnJGYxziX4Wyy0vvt0AsQa8wmSgjw7KG7pVH95EE8sOt9u9qlK?=
 =?us-ascii?Q?+QVtF9jlsn+PqfmtE4ADw8RG+TZ7K2IS2YYvNvp3iG4ur7yCiBsrWAYorUvm?=
 =?us-ascii?Q?a13x0380QZszAWxkOzHG8nDPgQn6/E+8BW9Yl1WiQVwVVOM5zo3KpFwInis/?=
 =?us-ascii?Q?j77CP6CuMgfGNnNaRh8VsJmB2ntAN+0XJkDaxHVZVsOqfsxtSmPwhsq2wcxF?=
 =?us-ascii?Q?qaZJ1PLNmWSA5i+6VQqpt5ggoHzUSQStLRKKf/ZAx/gQl3iZvFmEjTaus6hF?=
 =?us-ascii?Q?CcU5pcv35/YH9IF93dXd0sEPX+BQe36PT/ATtMRflXPYkAuH8A8ZT8fd9E5e?=
 =?us-ascii?Q?3R2pr5Aj79M96oiFUgbveDi5azUMBt7O/6u09EVRwUaez07XY3Tqq3PeNHM0?=
 =?us-ascii?Q?UejpG+RA3Z5Qr9wYpCECEzjhiJzbVuKUaBb9KxdAAQDQ48HLnKWdB4oIGrQT?=
 =?us-ascii?Q?QtASDgibB6i9datbSs2vsXd24soOuv8GVelR1maJFcR3dBKYSyQx/6sgjyF9?=
 =?us-ascii?Q?X5HZTMt2t4uXAX8HE7hvvKGS32smVClT2GenfQGJ5e/22H+XLY2KutxA7SYT?=
 =?us-ascii?Q?gbKhxXGbYFSjRxkRmuiKnMLQVieC4ry9QVprtbmL6BguvaXwIfHXwm7QWnCM?=
 =?us-ascii?Q?7Ol9Bghs0ZeaQfV12iT0U8RAjU4HgcltMIoJ4inzDGHDwFOfPC20BcfgQpQg?=
 =?us-ascii?Q?EWVuEAP936Yk4Qrvl8NKAUbjZH7okU+p/WNp7MHvRhEMDVrOSMSmYnukW/6K?=
 =?us-ascii?Q?p7+s3UppfWlm5Wc5hnMua8r0h+P802pw2bJFSz7HQxf7kW0Xmn13?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f195e06-7aca-41da-1afb-08df1ff633b0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 19:57:20.2386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Ee1CQ0vXyLxkNU9BQywkK09cWES+MPcIBReWasQ0aGNgUKgSp4sDM5iE3DxOoYcoHs2m+u516iERsTVZMXNcZURPi0rTW47sXVGvUZ9r3IVhhYUzpsGqFbg+1vOWoR1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12120

On Thu, Oct 01, 2026 at 09:45:02AM +0800, CL Wang wrote:
> Document devicetree bindings for Andes ATCDMAC300 DMA engine
>
> ATCDMAC300 is the IP name, which is embedded in AndesCore-based
> platforms or SoCs such as AE350 and Qilai.
>
> Signed-off-by: CL Wang <cl634@andestech.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>
> ---
>   Changes for v7:
>     - Rebase onto the current dmaengine/next; no changes from v6
>
>   Changes for v6:
>     - Rebase onto dmaengine/next; no changes from v5
>
>   Changes for v5:
>     - No changes from v4
>
>   Changes for v4:
>     - Use items list format with descriptions for reg property
>       as suggested by Conor Dooley
>
>   Changes for v3:
>     - Rename DT binding file from andestech,qilai-dma.yaml to
>       andestech,ae350-dma.yaml.
>     - Deprecate IP-core-based compatible usage and align with
>       SoC/platform-based strings.
>     - Dropped Acked-by tag from Conor Dooley due to the above change.
> ---
>  .../bindings/dma/andestech,ae350-dma.yaml     | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml
>
> diff --git a/Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml b/Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml
> new file mode 100644
> index 000000000000..f040a2bf7d4b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/andestech,ae350-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Andes ATCDMAC300 DMA Controller
> +
> +maintainers:
> +  - CL Wang <cl634@andestech.com>
> +
> +allOf:
> +  - $ref: dma-controller.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - andestech,qilai-dma
> +          - const: andestech,ae350-dma
> +      - const: andestech,ae350-dma
> +
> +  reg:
> +    minItems: 1
> +    items:
> +      - description: DMA controller register range
> +      - description: cache control in IOCP controller
> +
> +  reg-names:
> +    minItems: 1
> +    items:
> +      - const: dma
> +      - const: iocp
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#dma-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#dma-cells"
> +
> +additionalProperties: false

According to Documentation/devicetree/bindings/writing-bindings.rst
ref to other yaml(ref: dma-controller.yaml)

should use
unevaluatedProperties: false

Frank
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        dma-controller@f0c00000 {
> +            compatible = "andestech,ae350-dma";
> +            reg = <0x0 0xf0c00000 0x0 0x1000>,
> +                  <0x0 0xe8000000 0x0 0x10>;
> +            reg-names = "dma", "iocp";
> +            interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
> +            #dma-cells = <1>;
> +        };
> +    };
> +...
> --
> 2.34.1
>
