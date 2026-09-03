Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023127.outbound.protection.outlook.com [40.107.44.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C3D381EB8;
	Thu,  3 Sep 2026 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421332; cv=fail; b=VqYuK0qHiT8P66DMjgLD53buokMO6iljvDCvzLhiycxh8NcgLS3voBE2rWPIWDrpWvbK8zpH1+khWPeuooOpKR5EEGn58oNh3tSq+J+Fqav8PtQ/zH+rVM7UhEXJfjZ6PLR0O9ndU03Z/ivr6DD3eHhqtXOXh1XyLb4QCQHIHPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421332; c=relaxed/simple;
	bh=21Y5V7q+anVLnkDqRgrSM844Ky/Ahdrhyw/n/hIsAo0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=smqnnlGJrAcztczGpUE0KKhtYkoLJEUQiunrW+D0DfhAqW5MwDuxm0AdZR4T7J+REsxUSzj0C40uENPtyCnQYwjr62K5+pFNuO8oB2/ig3VWlaW4fXcQXZg4oeEZvORn8DAOlvt5Y5bQgGe5PzlKTYWe+6hTvtLeNEfUuLxtUmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=i1gZzXpR; arc=fail smtp.client-ip=40.107.44.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="i1gZzXpR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czdlml64KRGSg0tnE7zuwRgpKD9KUUZWcQoc2+ql1OIIPog1sDeY1bcrcfDpIM0ChTpMiP4o7zIsc39pnmjyyzTyLN6IbS1+vqk9kgBEaCbucp5z9rqo/8xJir2rxzGFCLbBjPErTk4jNwjwnHO92yJVUDAp+luo3rQ0dKt2GAeLifseYYfRInUQXDahqCQU+sotzgCScr0OFjurKQTS2QsnnjJdYcO7mzGV6ZTzG1JoqARFzq0DmlvPPatXdkVsaomh+AUqG2JWdBoN1XgKplASXtYRNWWQHvX8fizoAl/82y9674bHiQmyzfCOXT6X5f8lHDA+f7sVvlUHEF1v8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqlvDruJqYy23NDOTzURE8KzQWOgKafR8a6foB5tMwk=;
 b=Jsnq+tOB1d6nz/jmhaxnAfkKlPyJpc45FfhbyLqSxgGpuviNghTm66Fiis8jDbG8P2IF8JD/darWQv6Y3LjEbiytmyFtOV2adK2X6g6NzqkC8lZTZlTyI/pphpub80nT48vG/UT5RdK2LVnzIo0edq8nyrE7mz0XmzajQ6xvGheVkZN/gob1xzuO0ps2Ov7wonKXhxyR4AZwaAA6SDoSJR5GfHqj0QZyAVh1EjxS2ghlm8VPAx2bF89DNLc+PjLGbpCqpBi8rvgAumiywm7BzSUPdCCLXqu5AuoR+mKbVPDxfF2kRF/0erZiCKOSKaG2Z9abpHWz/M9CdOd+cZDdpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqlvDruJqYy23NDOTzURE8KzQWOgKafR8a6foB5tMwk=;
 b=i1gZzXpR8yOayYRkvPNJaefArtao7lTTIOg2wg4uh1rh6FIS4Ccsudph8mYwH2EzXvtZs+6XLctThCyeZyL6SOhopXjO9BH0nLH7gb4fITRp8pGk5kPxyiF9V+0jb28yOR+k0ZqNEh1TYo9HaH/WPtdAG9Eawrv9iu5h4tHUCnsS5VzkbNMHjRVoVD4Gsw9KtG3+3W0wIWmkbXux/eICQjpZKlCb54Xxa43F4/ywbgKrcFjOeg0SSEp7HDmTjSx/ZQcfz0KOjLK272VYfG8Xjv+M4YFzLMPTKS68cubRtUB0sDBfnh5mSeGB953EU1Aw9/O2wf8kOKofbck/iGnBXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by JH0PR03MB7446.apcprd03.prod.outlook.com (2603:1096:990:1b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 07:42:05 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 07:42:05 +0000
Message-ID: <369a2699-52fa-45ec-b55a-99f2a8fbca4f@amlogic.com>
Date: Thu, 3 Sep 2026 15:42:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/3] dt-bindings: dma: Add Amlogic A9 SoC DMA
Content-Language: en-US
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260903-amlogic-dma-v12-0-f769bc344056@amlogic.com>
 <20260903-amlogic-dma-v12-1-f769bc344056@amlogic.com>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <20260903-amlogic-dma-v12-1-f769bc344056@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: JH0PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:990:5::19) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|JH0PR03MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd65545-3ef7-4d02-7d75-08df098ed9bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|6133799003|11063799006|56012099006|4143699003|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	M1nEeNHXx7FPLM55pLB7K2aqiKxWmz4V4aMSZY5+tjwOs+ElFjjnqPQmFRn4QWKXNvPbl+mYs36uIuDDzYeAKUDcPNE1+3hzaUG5DFi4rlA3pqis3ulp7FyHsiP2L0uqXygoXtuQWjH44PyRVM4pWLNrvnioPLFHEgNcxxoLPnbdHJDNvlNXArGZ5teDR4VhiEkoFXdea4jPNLmAogGDmv10dO8g0MBo6lHEHDp9A0xkl01ESshNtsSZclJwp2f5s92st32Y5Xy3qU9u+t+zdKP/9cJ3eNiTiuLz/NINPNJAZUW9E3YmCG/+7b+uXT8pTQDiNy8Tyc5QsEPb3JE/4o+LRLnxXSuBij+AfPS8CN1lf325bRlzY9c6lz/Y0fz3mzntL0SzE7qlinvJ01CxNSHxYBbE+uGQ5nnnAQbT4DboDx+tcju3rLpCI02msYJ3oWSblMjoo3p6XM9Zl9afSJye3PNSCy4JbgYkgIpkc78DhNOShpgsLqIE6hf+Buv0YGHnsPZSSXbOy9kbKMTWY3ZL6/fcuod+fsFvyCm3Czf8G0vcmEPQik5yz3utIhvpOBUPxVZ+3Vq2+3JwEAFwJfEBg4nxfnpeagAJJ88q364rzOp8Yr5gxaSv4UhQ/mVY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(6133799003)(11063799006)(56012099006)(4143699003)(10067099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3RlaEF2RnpRWUZqZ3N0cTB2d0tUUStTT0NaSmtUWVVLazR6MFZHdjQzNVhu?=
 =?utf-8?B?TkcyN2FJaldGQW52U2ppRFNUT0c1d1ZvZ2F3bGdXYmwvcTlLanBpR05VaTQx?=
 =?utf-8?B?aVlVTTlGQ1hQMmxpRW5pcUpsQkRDN0Z1dG1CbGVrM2crc0hZR1pKQm5yaEwz?=
 =?utf-8?B?aFcrQnROVHpWdERIZXk2cmpHeTZSTTU5MDFtMjBSRzlPUVYwSXErMCtTdFZX?=
 =?utf-8?B?Z2lnK1QvbEhKMHpkWWRPK0V5YnpRY3NDYmowM0k2WE1xZGtxWVY5VU5aYnVK?=
 =?utf-8?B?b1NlS1BkbkpMQVBLcXYyRk1FMTNUOTBxZlpUaitDc1psNlRTV3hheUJZdGVk?=
 =?utf-8?B?RU8zNkxGeXpNMlZzY0hTVjJ3akMxR3dub1RjaFFUdE80OFNjOWpBTm5PUTFR?=
 =?utf-8?B?ZFd3QXlTRVpPRFNTd1FVYUlxcWJjR0loWkJhS0hvZjJkUS92MlZoMUFjNnAz?=
 =?utf-8?B?RHJDVXBONGljb2V5bkVKcEVGbW9ESFJ5UTBOYmFVQk85YUNtU1FhbHRQWGow?=
 =?utf-8?B?bkdVTno3bWlZcCtDOXFCMGt2WnhWZWFHNlM5YzFOM2E0QVFiZjlZTlRDbEkx?=
 =?utf-8?B?dDJKZGkya2RpeENzOVAzUTR2MDlEanhQRVFtQWNEKzNJbWt0NERBblM5UVpa?=
 =?utf-8?B?dzhKdVhmRysxd3NLMW03eUlsY241SWl4TDJGWWx6SVNXYit6UjBtaFdONjdr?=
 =?utf-8?B?VzlNZ2QybTdqRTUxWlB4TFhJQll3RUE2bVoxcFJCMzRJOGtPV1dMWnFvc09l?=
 =?utf-8?B?b0h3a2hZYWNISk1ybEFkSFpyWHRJSzhKL2tQN1M5S2puL2tBcWFmeGxsMnJ6?=
 =?utf-8?B?Sm5WWHFKKy9JTDZwSmFnZGxPeVlsdG4xVEhmZWd4S2VoZ1g3R0hGQ245KzVC?=
 =?utf-8?B?UHRqZ0ZKTm5hNmpidkpndnlPZlBOTnEzckMzN0dIQzF2WlE5MzZqbUN2djRT?=
 =?utf-8?B?aFIvbmQ3djBjT2lCbVI2YjJzNGtQL0Rwamt1Y2ZkRE55U2dBejRyaGxRNE1t?=
 =?utf-8?B?cEVVdlB1V0lWMjF6bGpXdlpkWXRDQTVUbmFhY0pOQVFsWFhBRkF3QXoybFpk?=
 =?utf-8?B?bDdGbkVqNys1d0hnZXdGbHhyM0hhVlROTGRibnhFL1pxcWVrODdGWXY1OGVa?=
 =?utf-8?B?L2JheFIzVFI1VmxHR3NKV015R0VSb1NwdFVRL3RYQlJwMG5aaGVpdUhOQ0ox?=
 =?utf-8?B?NytqQjc0RDduYTZ3QlRVVmY2RThYRSs2OEYrMWVoNXBYU0Fkd3JEYlUyanVY?=
 =?utf-8?B?bFVlNVBvZnE3UEkyK1VnZTh5cFBsbFVRMXpRQVUwL2NiUGd1eW93WjI2NmhB?=
 =?utf-8?B?QUlWMWFBbnEwc0czV1RzYmtOb3lsNktxNHZRYnVYN1dwbXVWSjNmTmlFa2wx?=
 =?utf-8?B?UHJwbFd2d2dpSHRyR1NTdFFFeUpLbjB2bjFJWTFWN1JlVStOY1hYNFZRdkQ5?=
 =?utf-8?B?czA4Vmg4dWlVZG9xY3IzWUtJT1hxRTQzanFWd3dUK0s3cUI2QVlCL3hPMkVZ?=
 =?utf-8?B?VnR1a3p4NjVBcHBXUkJmbmFyNFZ2TlYwNXlFdi9hRWdvUTBQSFM0VUdBRXRX?=
 =?utf-8?B?aUhTSUU2eTV5OHVmK0paclNsRVA1TlUvMXVLTFQrNTR2VkpOT2hzMS9FcmFm?=
 =?utf-8?B?Zndlb21SVWk4ME53MlV4bFBtSmNFUmpEaHVuSlFFK1JKcUcxb01jMnM2Rm9T?=
 =?utf-8?B?RjdzWVNRNENXZzlXdVVmOWxNNkRBRXVLSXc2QkxZZnQ1ajZOa29MTExKMWpz?=
 =?utf-8?B?dlIxNmllK0xmL0syQThjUjJxNVpnUXZqWFBraGN3QzhyVlU3MEo2Rml2UzAw?=
 =?utf-8?B?MFRmOExYWnBtcjErT1Z2ck9sNUtxZDFFRGcwd0RYY3hCVkRSMEJHOUhSMHdS?=
 =?utf-8?B?a0c5OE1sUnZlRG1qYVVOSzNCTzJWSHhQdXZFL3JqVkVSL1hIWVZValFLRVdB?=
 =?utf-8?B?VjlsZG1PclUrQjhkbmdNaVhkUWNyMU1MSTlpL2hjZFBJblFtblJ2eFdqYlRX?=
 =?utf-8?B?UjdQbG1EWWRaSG96VkdIVWdSMjM1Y2UzcjJSRXorZlpBaGYrUDB2amkzR1Zk?=
 =?utf-8?B?TzR5WndrWFpyUjRWRVdnWTRLK0lCbmYzY0xFVThzMkFiNVdRbnQybnNFNVVN?=
 =?utf-8?B?c1JhY214N24wVGNlaDdROE5NM25PRFppZmJmby9aT29SZzVtMHN3Q1NYWWd4?=
 =?utf-8?B?QjIyTWdyMkRvRkR2cDczS2NjV0tBQlFrbGpvRHExT1RzQXdlTVE4ZitlZnZR?=
 =?utf-8?B?czExZnhhYUE4ODdZSkNzM1BtbXlLWk83U1FaUjlkcUk0b2h6WHU1NTVXejBa?=
 =?utf-8?B?cVdOdWFXZTkwN1B3SmJCcGl5OFptYmxBVGFCdUMwNFZvemxLM2VPUT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd65545-3ef7-4d02-7d75-08df098ed9bb
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 07:42:05.3684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ICMt2QqjzPNKwLpiQG0L2WRzMb4dwwlTB1ImiYQ9n4R4gIWEg39Q8uhKGb2NJWJrTVCmmrAFTImTDeWWHm7qY6DWyaRdZ9R8G4RAeD1EwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7446

Hi Krzysztof,
    Based on the bot and Vinod's suggestions, I added a prefix 
"AMLOGIC_A9" for channel type. I didn't remove your Reviewed-by tag for 
this change. Is this appropriate?

On 2026/9/3 15:38, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao<xianwei.zhao@amlogic.com>
> 
> Add documentation describing the Amlogic A9 SoC DMA. And add
> the properties specific values defines into a new include file.
> 
> Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Xianwei Zhao<xianwei.zhao@amlogic.com>
> ---
>   .../devicetree/bindings/dma/amlogic,a9-dma.yaml    | 68
> ++++++++++++++++++++++
>   include/dt-bindings/dma/amlogic,a9-dma.h           |  8 +++
>   2 files changed, 76 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
> b/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
> new file mode 100644
> index 000000000000..3e1a4fba3047
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id:http://devicetree.org/schemas/dma/amlogic,a9-dma.yaml#
> +$schema:http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic general DMA controller
> +
> +description:
> +  This is a general-purpose peripheral DMA controller. It currently supports
> +  major peripherals including I2C, I3C, PIO, and CAN-BUS. Transmit and receive
> +  for the same peripheral use two separate channels, controlled by different
> +  register sets. I2C and I3C transfer data in 1-byte units, while PIO and
> +  CAN-BUS transfer data in 4-byte units. From the controller’s perspective,
> +  there is no significant difference.
> +
> +maintainers:
> +  - Xianwei Zhao<xianwei.zhao@amlogic.com>
> +
> +properties:
> +  compatible:
> +    const: amlogic,a9-dma
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: sys
> +
> +  '#dma-cells':
> +    const: 2
> +    description:
> +      The first cell is the DMA channel type(AMLOGIC_A9_DMA_TX or AMLOGIC_A9_DMA_RX).
> +      The second cell is the DMA channel index.
> +
> +  dma-channels:
> +    maximum: 64
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - '#dma-cells'
> +  - dma-channels
> +
> +allOf:
> +  - $ref: dma-controller.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    dma-controller@fe400000 {
> +        compatible = "amlogic,a9-dma";
> +        reg = <0xfe400000 0x4000>;
> +        interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
> +        clocks = <&clkc 45>;
> +        #dma-cells = <2>;
> +        dma-channels = <28>;
> +    };
> diff --git a/include/dt-bindings/dma/amlogic,a9-dma.h b/include/dt-bindings/dma/amlogic,a9-dma.h
> new file mode 100644
> index 000000000000..ea7c90063572
> --- /dev/null
> +++ b/include/dt-bindings/dma/amlogic,a9-dma.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +
> +#ifndef __DT_BINDINGS_DMA_AMLOGIC_DMA_H__
> +#define __DT_BINDINGS_DMA_AMLOGIC_DMA_H__
> +
> +#define AMLOGIC_A9_DMA_TX              0
> +#define AMLOGIC_A9_DMA_RX              1
> +#endif /* __DT_BINDINGS_DMA_AMLOGIC_DMA_H__ */
