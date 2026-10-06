Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010027.outbound.protection.outlook.com [52.101.69.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D304D3DC4D7;
	Tue,  6 Oct 2026 08:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791274753; cv=fail; b=Pc0Nib0YbgYY6j8by0Tur0tFLEz5sUqi53WR9DNQcUdzkQMl6pi2zgrDW1Sxi9EaiccSbecocAH+SAUm31Vbi9l1hyNa5SuYhfimGwd/jo0MDLvh9/M/lk94zCwt4x55D4ePfsnog2tSK3UIC/VnbOInY418kSjv2YMDRTa52iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791274753; c=relaxed/simple;
	bh=So4mg7oVwQx+KJrbOi+HPdHw2KTrV3W76oNFMaSBda4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UgQkaJORGUgirCRZFuSbbmTo9CQtYK0jsBOTw1c0nnt0DkcQwntSNnAfyLgErhz5+v/dj7iWCFqny6X43cydwYACcrlcqxWh78YgkoFpdv9qF/3Io8lxX8oFF3qgWbRMDXjCbxM/CcIu/Ms/HwkWzmV3Q+6rO6p7t4T5FR+qREw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LAxjV/0z; arc=fail smtp.client-ip=52.101.69.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LAxjV/0z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljjVFipCA9Vmsoh3AELrut9Df5WkcB9U6NUbZeJq+uZVx7u21hsyikFF9HYxHgpBSFo+Be0sk9ntC7yui058A/2ZDcK5wL34luEdfGM3t/FxQbqEOofxGDvnikP3UtoDJLnrKXBNnK935zO/0U6/vxO+GUGGBf7CIZzq7DfYuzPjnGaUNn7vldHoP933Ko8zg/eUnUS7Sj1sny5bD7SUKvvbyvpDO4yo0FpfG2c5BjA2PXMeWwwMhTsenfa+a4EmCo2N7Ws1eoWrhLyx3HlIqaN7GC8eaE6Ad8qR/z1O5Lje+HSX1m98CPoJSTHATG8epwXFGOULaA+lN3kfH6W0+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRzNkkSp+X4qVCV/3gi28dTbhxG3vpTRtxd7swhK/s0=;
 b=wpwNl8XWnQ31jd8O8/J+erKCguEKpT75/cU+6PL4xSktivkHYOe38zDb7z+H+NemUszpszt5QbnWDUvf9fhs+rPdOkpj9BeNQJaEMbW+vwaLSVUUdJjDEqPyskCKH/P7o4+r4oZuRXPGSlT3wlHwJ0rEmnAoo6wGMLskUagr69lxrDL1Dd5GDuvbIJqNQ1xPJQHhUiNlJ3YRMVDq2F+7qo92SMFox3w3+RgqplvW3Shx8/kD+xsjYGaJocamw9ev8D9y360oApEtCJfrgQCmFPvGPQMvZhiDdC5BmC74LjGyul3bZWR3CeKRCDQ/mfup/+mJK9Zy6pMs7XzpVORPcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRzNkkSp+X4qVCV/3gi28dTbhxG3vpTRtxd7swhK/s0=;
 b=LAxjV/0zXncXuUPyKlp4W9Lgy416tLVrk81ECSs4iHNgZ6aD2VtkZKfXBj7Z0zhXo6F0dh9ZfMVly5HBBQcC3d3KlaaQRdwXeNgCyC8hT7TSnA1vNLxNobeLdV/06QN9Pe3l7UOAgU9lyR+1qiG9d4uy0wJAPZOhFFtg2UtvEew4sKOSikOxIWBAbHi4idK5cQPE++mTgc+5h/4tmzv+BbWXFL3/+IK9SbFktMqD188uRW75IvLhLsJv9PIEwS+zfRiTiKInXtLbXBxx+JufNxEW5dreBhd+kxQNgOoFsyrVLt+VNVggeR6NMAEXLQnypOMGwBzuIDCXN8u2ggitWQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA6PR04MB11910.eurprd04.prod.outlook.com
 (2603:10a6:102:516::16) by GV1PR04MB9198.eurprd04.prod.outlook.com
 (2603:10a6:150:29::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 08:19:04 +0000
Received: from PA6PR04MB11910.eurprd04.prod.outlook.com
 ([fe80::d3f0:3c24:f717:4989]) by PA6PR04MB11910.eurprd04.prod.outlook.com
 ([fe80::d3f0:3c24:f717:4989%6]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 08:19:03 +0000
Message-ID: <7fde4308-f177-4031-bca0-de576ce69a7e@nxp.com>
Date: Tue, 6 Oct 2026 10:19:01 +0200
User-Agent: Mozilla Thunderbird
Subject: [PATCH v10 5/9] media: Documentation: uapi: Add qcom-camss ISP params
 documentation
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260925-camss-isp-ope-v10-0-2622411034cb@oss.qualcomm.com>
 <20260925-camss-isp-ope-v10-5-2622411034cb@oss.qualcomm.com>
Content-Language: en-US
From: Antoine Bouyer <antoine.bouyer@nxp.com>
In-Reply-To: <20260925-camss-isp-ope-v10-5-2622411034cb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8P251CA0026.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:2f2::17) To PA6PR04MB11910.eurprd04.prod.outlook.com
 (2603:10a6:102:516::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR04MB11910:EE_|GV1PR04MB9198:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f054540-2649-4000-c4a6-08df23827ba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|19092799006|7416014|23010399003|366016|921020|6133799003|18002099003|22082099003|3023799007|4143699003|11063799006|10067099003|56012099006|260925021311599003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info:
	jiVyHB8jwQYbUnCo8v1RO7vGL7522VhflhtEfqoHWeQq+BDJjYQpQ5Zs/Iqr8shGClVce7Bge33zhWDB1IWbQ7l78QSJkzsnPKAjTe0lx5H5UOksIdeIa4AEaJRFFgJ4H8/5iXyzmr4vXtEGA5uEThMQRLpGBgBfpWxcJc/3SUEOKsez8N6oL63QFC0oPcBG9voGxrdcKSWiWs9a3Qee96iGNCR88wXrRB1BLPzcedkEHTN44TOrcKjJreSdHYwVV9I7FO0KiNsl+72F8r64ua3YfVRgXdDIgwN5xPxNxEv+7wBAA630zM7opIiPCmISLOrEqQDJ+XqtTXVvSyS5hamHimhdVk89ezKB9oXLuSXyvCbRT/g1hQZMVGuBeIsu7SQlCjhvh4L2c7cEOG4cvC2GIRIctCoECCSLrCM/2RoK5/m4QuhJQXsOepeqn2tH3sIqQAf7IxRJkiiZiVDHqPjUgrAtqq8Bql6QNDX/VJdQ/OasFFipph8pV7FKSkfgxcermC3N1ufojU/mzI11Gon9gGRUAeFT1zhamBENr6DuTpSCBrpVTFb64tJTZ9bA5/jm1YsmS4qoldBc346nbbCka5Qk9PSqCsxTEouesDmGH9D/W56BzRjfQ5RHjJ7zdUCH3zZxyGYWZVz/lqhQdZBQQ3662Isp/I12/bTTCjo0JYRv/qe6N2h4zUjcdeG/qn5TbHctrnjrk/xCswWgJA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11910.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(7416014)(23010399003)(366016)(921020)(6133799003)(18002099003)(22082099003)(3023799007)(4143699003)(11063799006)(10067099003)(56012099006)(260925021311599003)(260925021911599003)(260925022911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTJycTB5NjVaczVmZXNIWUR2Z3dNR2FiZXpvdE1yZGh3MG1TaG9adkozWnAz?=
 =?utf-8?B?VkgzR1lhdXJvczg3Y2N3V2NlVnI4UFZwQmVmWi8yYmFiVUI2ZlF4akIrNTI1?=
 =?utf-8?B?bk5qK0R3TmU4SWtNcjc3cHZkV3pOTFBrTWltOEViMjJObWxVQjBMVHhzQW1F?=
 =?utf-8?B?dk51aEhFVW1jREpjK29ONXVpNXlJMjk3MXhVcmt4ZllXQSt2S1JkSmd1UmxG?=
 =?utf-8?B?TXhhOUV4a3VrUXNLUWJJd00rSTJIYjk4YmM1M3o2U3F1R05yNkdUK1RFWmto?=
 =?utf-8?B?Wnh6ZHU1R2l0TDBCZnlhVFlBVy9zbUx3STlnZ0o1Q3VCYklYeHVud2FzdWxi?=
 =?utf-8?B?UVplejJMSzZMV24rbU9FQXNjaGdzWlhaTUd4bXhqK3E5MzFxM3dBWEdhM1Bk?=
 =?utf-8?B?YjI0R1l1QzAwekhRczNtUFAvYnJXQ0pmQ2VkZHRHZGwzSjRnZVFlMDlQZGhh?=
 =?utf-8?B?VEVjcDJZUzQzR0JmZUdLTDVTdnhIaDM3Wjkvc0Z6QlJzMUYySC9uT3NDSFpH?=
 =?utf-8?B?c0wwcmVCNkY5azJnZXFSdUZramtmaEJFWG4yaFZONFRnUkZYQjZncGxtenVi?=
 =?utf-8?B?b01FSGtKR096bGs0amJSUHpNcjN5RUExRStNU0NtQWY4T3ZScGRiOWFtbjlB?=
 =?utf-8?B?SE9EbEF2OFNBTVM2ejQ3TnVTZ0VZNzh1a01pSmlIeTY4eTdWM0RjejRQSG9v?=
 =?utf-8?B?U1BlTENROEw3eURkNDI2YlduSEZYQU03ZFQ0OTF2TisrVHI3K1BhM3BXTE5P?=
 =?utf-8?B?ZXk3eXM3U3J6cTBMQ09wSTJnKzdwdnVNSUZqV3A4Q3hmYUZQR0xHelVhVEtH?=
 =?utf-8?B?bEFhaWNNWFVJQTRqVjJHZ2hQTGtMczZpWklvWUk0bExGYk9HekYvRnVEZVpL?=
 =?utf-8?B?bnc0cGE0aVQvVkk3Tkt5SXlCeXYzNGZtNDdPa1VhTTJ5NXJlV1l6VWZRRTg5?=
 =?utf-8?B?N2JiVTU5QUlZN3I1cXE2eVVXOTNyZmlYNWp4VXRBdjNLNGVRNmNWTVFUekdK?=
 =?utf-8?B?MjBSdXlkUDl1N2pzMDVUS1BQTkI5WFN2RGlobXlJRm10eUxzZFVycVJHU0FF?=
 =?utf-8?B?ekVqSmd4ZkZWOW9mY0JBTDBjR0JoR1ozalJmWW5La1NoeVBhaHpBT3hodThQ?=
 =?utf-8?B?blFQbnRybUNHRTNsYWRnL0E1SXM0c0VHQllwNjFZd3VTYnNxYVhtRG50a1BT?=
 =?utf-8?B?OXVBMVlBbDBlZlV0MHBBaFFyTWdJL0JTUk9lMXBHUnF1cWRLN29PWTZYYmdK?=
 =?utf-8?B?QTQzMmJuM2xGSnVvbFhnTnpoQnk3enlMdFU0TFFZVUt3anNRV1FMWm10M0lt?=
 =?utf-8?B?a3RYNzZNcy91dzNkenhpUWgwaUY5amlZNTFDbTc2RnlVOVlRdzZLZXB2L1JP?=
 =?utf-8?B?dHlQSUp2UGFBbVZidEQ4d3pFYmpTTldPUVdOcVNSUFFySTBrR3R2SjVlL1k0?=
 =?utf-8?B?ZDBiVkZSaENxV1Q5bDJsWVdTT2Mxb1hIanNaanBJMnRVVDZadDJROHA3MXFY?=
 =?utf-8?B?ZFhpQWdXd09UY0xmUWtqZEg5NFR5a2ZuTFNHR3luS3lHN0paeWd2YzNxS0ZY?=
 =?utf-8?B?ZmN3MHNEcEwrQkJkWGVDMVArK3hFWkZhUXNWcVpUTkhMWDBqakNoQ1FMRC9M?=
 =?utf-8?B?NUJ4UDZidTJreTBOMGZVL3VkeXFGdlg2VDUxL0p1L2p0VGd5MThZOUd4aXdp?=
 =?utf-8?B?a3I2UjEwSFhYSnQ5QktGMVo4NDVlOFJ4MHF1czRPVkliWHBCNUhxZ2hQY0Zh?=
 =?utf-8?B?dnhQK1B2RkU3TUtBZ3dwcXF2SS9NcHBUSEt2OE1PZkJhdlBRWGZUNHN4NXU2?=
 =?utf-8?B?bUdPVURqL09PZVluQXpEekFNUTFReVoxVm93US9tZFFkbHpRbkJ2NlBFQlVx?=
 =?utf-8?B?QndvTE56SFNqWnZUOWFqcFJaOXVwaktFOGZGcjB4bXFZS1FKNVAwMW9DZjNk?=
 =?utf-8?B?SERmN2lsU0hDdUkzZ08zY1NUMGFGbHAxbVRmK1hXOW9HUGFkK05Da29iYXYy?=
 =?utf-8?B?MWFaeUcwR0tjMWpiS0lXcnhZTWV5cit2c0d4aDBaKy95NytmWlVYT0xzbDg4?=
 =?utf-8?B?MUUvdUJMUzVVMzhLeG5pOEtiZjlOY3NBVnlUaGpqdGNKbW5PZzVJcG8ybFVx?=
 =?utf-8?B?dHN0b0MzMW9jZllDN2U5OVF4YjEyZVplVzNPOUFrK0NNYkZQeUo2QXN6WWtZ?=
 =?utf-8?B?enJoNGJHc0RaYjQ4VHBaVXM3U1B5Uno0d3JRRVRiNTNLc0xZTFJPSFlHcWls?=
 =?utf-8?B?VGJHU1dRQUxmWW4yVG81dnRYeDdLb09ZV3psaXMzMWJuNEN3RnE3SkNwcWI5?=
 =?utf-8?B?blRIazBveXNNSWF4Rk1aYWpabVI2K1pBQ3EyNzFCYW1zMldadUNGdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f054540-2649-4000-c4a6-08df23827ba5
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11910.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 08:19:03.8565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vF0lo+gIVWsE+CIIhNPWSjLCfbDedSF28sbktcckrSsn3oM8uWPQQA8tWXk2QrDlfrOFQY9AIHaDcez4qyZog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9198

Hi Loic,

On 9/25/26 11:09 AM, Loic Poulain wrote:
> 
> 
> Add documentation for the Qualcomm CAMSS ISP parameters metadata format
> (V4L2_META_FMT_QCOM_ISP_PARAMS). The format is built on the V4L2
> extensible ISP parameters system, with per-block structs defined in the
> qcom-camss-config.h uAPI header, and is designed to be shared by any
> CAMSS ISP engine exposing a parameters metadata output video node. The
> Offline Processing Engine (OPE) ope_params node is the first consumer,
> with additional engines expected to add their own parameter blocks in
> the future.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>   .../userspace-api/media/v4l/meta-formats.rst       |   1 +
>   .../userspace-api/media/v4l/metafmt-qcom-isp.rst   | 147 +++++++++++++++++++++
>   MAINTAINERS                                        |   1 +
>   3 files changed, 149 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/meta-formats.rst b/Documentation/userspace-api/media/v4l/meta-formats.rst
> index b5455229837e707c24e134438d5e2fd12cb3bf37..25b46af4d9f7faab37000076c530e9aad5b4a076 100644
> --- a/Documentation/userspace-api/media/v4l/meta-formats.rst
> +++ b/Documentation/userspace-api/media/v4l/meta-formats.rst
> @@ -20,6 +20,7 @@ These formats are used for the :ref:`metadata` interface only.
>       metafmt-intel-ipu3
>       metafmt-pisp-be
>       metafmt-pisp-fe
> +    metafmt-qcom-isp
>       metafmt-rkisp1
>       metafmt-rppx1
>       metafmt-uvc
> diff --git a/Documentation/userspace-api/media/v4l/metafmt-qcom-isp.rst b/Documentation/userspace-api/media/v4l/metafmt-qcom-isp.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..2f3654a9ba897d0d1481d38a7117be8e84b1a99e
> --- /dev/null
> +++ b/Documentation/userspace-api/media/v4l/metafmt-qcom-isp.rst
> @@ -0,0 +1,147 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. c:namespace:: V4L
> +
> +.. _v4l2-meta-fmt-qcom-isp-params:
> +
> +**************************************
> +V4L2_META_FMT_QCOM_ISP_PARAMS ('QCIP')
> +**************************************
> +
> +Configuration Parameters
> +========================
> +
> +The ``V4L2_META_FMT_QCOM_ISP_PARAMS`` format carries image processing
> +configuration for the ISP engines found in the Qualcomm Camera Subsystem
> +(CAMSS). It is passed to a metadata output video node using the
> +:c:type:`v4l2_meta_format` interface.
> +
> +Rather than a single struct containing sub-structs for each configurable area
> +of the ISP, parameters use the :ref:`v4l2-isp` parameters system, through which
> +groups of parameters are defined as distinct structs or "blocks" which may be
> +added to the data member of :c:type:`v4l2_isp_params_buffer`. Userspace is

`v4l2_isp_buffer` can be used now, which is common for both parameters 
and statistics buffer types. `v4l2_isp_params_buffer` is kept for 
compatibility with legacy drivers. But now, common structure should be 
used instead. CC'ing Jacopo who helped on the common structure introduction.

> +responsible for populating the data member with the blocks that need to be
> +configured by the driver. Each block-specific struct embeds
> +:c:type:`v4l2_isp_params_block_header` as its first member and userspace must

This is also valid for header structure. Now you can use common 
`v4l2_isp_block_header` instead.

> +populate the type member with a value from :c:type:`camss_params_block_type`.
> +Populated blocks must be placed consecutively in the data member, and the
> +combined size of all populated blocks must be set in the data_size member of
> +:c:type:`v4l2_isp_params_buffer`.
> +
> +The set of supported blocks depends on the CAMSS engine consuming the buffer.
> +The block definitions themselves are shared across CAMSS ISPs; currently the
> +Offline Processing Engine (OPE) is the only engine consuming them, through its
> +``ope_params`` metadata output video node. Additional engines and blocks may be
> +added to this format in the future.
> +
> +A block carrying ``V4L2_ISP_PARAMS_FL_BLOCK_DISABLE`` bypasses the
> +corresponding hardware module. Any other block updates the module's
> +configuration and leaves it enabled. Blocks omitted from a buffer keep their
> +previously programmed configuration and enable state; until userspace submits
> +a block for a given module, the driver's default configuration applies.
> +
> +OPE processing pipeline
> +=======================
> +
> +The OPE is a memory-to-memory engine that reads a Bayer RAW frame from its
> +``ope_input`` node and writes a YUV frame to its ``ope_disp_output`` node. The
> +parameter blocks configure fixed-function hardware modules that the frame data
> +passes through, in the following order:
> +
> +.. code-block:: none
> +
> +        Bayer RAW in            RGB domain                      YUV domain      YUV out
> +        (8/10-bit)   +------+   +------+   +------+   +------+   +------+   +------+   (NV12/NV16/
> +         ----------> |  WB  |-->| DEMO |-->|  CC  |-->| GLUT |-->|CHROMA|-->| DSC  |----------->
> +                     +------+   +------+   +------+   +------+   |ENHAN |   +------+    NV24/GREY)
> +                                                                +------+
> +
> +The stages, and the parameter block that configures each one, are:
> +
> +.. flat-table:: OPE pipeline stages
> +    :header-rows: 1
> +    :stub-columns: 0
> +
> +    * - Stage
> +      - Module
> +      - Parameter block
> +      - Function
> +    * - WB
> +      - CLC_WB
> +      - :c:type:`camss_params_wb_gain`
> +      - Per-channel white balance gains and black-level / pedestal offsets,
> +        applied to the raw Bayer data.
> +    * - DEMO
> +      - CLC_DEMO
> +      - *(none)*
> +      - Demosaic: reconstructs a full-resolution RGB image from the Bayer
> +        mosaic. Always enabled; not configurable through this format.
> +    * - CC
> +      - CLC_CC
> +      - :c:type:`camss_params_color_correct`
> +      - Color correction matrix applied in the RGB domain.
> +    * - GLUT
> +      - CLC_GLUT
> +      - :c:type:`camss_params_gamma`
> +      - Per-channel gamma correction curves (256-entry LUTs).
> +    * - CHROMA_ENHAN
> +      - CLC_CHROMA_ENHAN
> +      - :c:type:`camss_params_chroma_enhan`
> +      - RGB to YUV color transfer matrix.
> +    * - DSC
> +      - Downscaler
> +      - *(none)*
> +      - Chroma (and, when required, luma) downscaling to produce the requested
> +        YUV subsampling, e.g. YUV 4:4:4 to 4:2:2 (NV16) or 4:2:0 (NV12).
> +
> +The input node accepts 8-bit and 10-bit packed Bayer RAW formats (for example
> +``V4L2_PIX_FMT_SRGGB8`` and ``V4L2_PIX_FMT_SRGGB10P``). The output node
> +produces semi-planar YUV (``V4L2_PIX_FMT_NV12`` / ``NV21`` / ``NV16`` /
> +``NV61`` / ``NV24`` / ``NV42``) or luma-only ``V4L2_PIX_FMT_GREY``. A
> +configurable stage is bypassed while its block carries
> +``V4L2_ISP_PARAMS_FL_BLOCK_DISABLE``.
> +
> +The following example populates an OPE parameters buffer with a white balance
> +and a gamma correction block:
> +
> +.. code-block:: c
> +
> +       struct v4l2_isp_params_buffer *params =
> +               (struct v4l2_isp_params_buffer *)buffer;
> +
> +       params->version = V4L2_ISP_PARAMS_VERSION_V1;

so as common version: V4L2_ISP_VERSION_V1

There are multiple occurrences in your series. But I only highlight some 
of them.

Best regards
Antoine

> +       params->data_size = sizeof(struct camss_params_wb_gain) +
> +                           sizeof(struct camss_params_gamma);
> +
> +       __u8 *data = params->data;
> +
> +       struct camss_params_wb_gain *wb =
> +               (struct camss_params_wb_gain *)data;
> +
> +       memset(wb, 0, sizeof(*wb));
> +       wb->header.type = CAMSS_PARAMS_WB_GAIN;
> +       wb->header.flags = V4L2_ISP_PARAMS_FL_BLOCK_ENABLE;
> +       wb->header.size = sizeof(struct camss_params_wb_gain);
> +
> +       /* Unity gain on all three channels (15uQ10, 1024 = 1.0) */
> +       wb->g_gain = 1024;
> +       wb->b_gain = 1024;
> +       wb->r_gain = 1024;
> +
> +       data += sizeof(struct camss_params_wb_gain);
> +
> +       struct camss_params_gamma *gamma =
> +               (struct camss_params_gamma *)data;
> +
> +       memset(gamma, 0, sizeof(*gamma));
> +       gamma->header.type = CAMSS_PARAMS_GAMMA;
> +       gamma->header.flags = V4L2_ISP_PARAMS_FL_BLOCK_ENABLE;
> +       gamma->header.size = sizeof(struct camss_params_gamma);
> +
> +       /* Identity curve (pass-through, gamma 1.0) */
> +       for (unsigned int i = 0; i < CAMSS_GAMMA_LUT_SIZE; i++)
> +               gamma->glut[i] = gamma->blut[i] = gamma->rlut[i] = i;
> +
> +Qualcomm CAMSS ISP uAPI data types
> +==================================
> +
> +.. kernel-doc:: include/uapi/linux/qcom-camss-config.h
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3a19da74d00c9dfb48e900df71a86d4686d3ec2c..b5593f814b60fcbcd88f4b4aad25880d19825dc0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22363,6 +22363,7 @@ L:      linux-media@vger.kernel.org
>   S:     Maintained
>   F:     Documentation/admin-guide/media/qcom_camss.rst
>   F:     Documentation/devicetree/bindings/media/qcom,*camss*
> +F:     Documentation/userspace-api/media/v4l/metafmt-qcom-isp.rst
>   F:     drivers/media/platform/qcom/camss/
> 
>   QUALCOMM CLOCK DRIVERS
> 
> --
> 2.34.1
> 
> 

