Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010036.outbound.protection.outlook.com [52.101.228.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295AD25D537
	for <linux-hardening@vger.kernel.org>; Wed, 26 Feb 2025 05:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740548194; cv=fail; b=tyc7SBSV70EQDltRi2SRPjo4olsKtSRJmbLTbTT2KALzfS69hElPzoye5JUZKq1liHgL4PAW/xrTn7fWnF5bIA4GZop6RrBdFj3H42pboLoAHjGr8lzCrlrLPDS/wOT42LMGd7zCHOAn5WJOuLbM3jzy1WJEbk1dfyII6CaAung=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740548194; c=relaxed/simple;
	bh=EesT7WLpW/dS8hG3K0Mmmldp/hPnrUGnFusQZDh7eRs=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=NVjwAuIbqKTX9ZpSAhlugJ3Ie3i2LsmmaFjYiGMXvSZenzloOR1UfYy0XmG5H8TQgq1K5AAzMwBUllsvXB+xnLXIz4QrvvqMBEknNjGvBn+DEd0tHqJPcLo81CwcHK6x6nsjm9/c1H1YtpPp3pfWuQrkwgweBeyfyfHANLe1jTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=edTV1Y9V; arc=fail smtp.client-ip=52.101.228.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="edTV1Y9V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUpfYxuwL0FEouX2poCcuEQXd2pil6oAC4J9Ul3jxFzeqqh2RIsmnlZi5bcNCwfV9MzD/FXBm14b/IwnXAXd5Iy3G0aHlAg9ZDPM/pA7Gr2F8KpC3ueKa1lurK1girMeFK2v3iyWeVDMzMCeCbzmszNTftx1dEc6NBe4CwatKGG3QMyVLpgzF1Uos75fr/xDy1oI4+U3KbE+6qrlXPiR7a0ksuykfyFy/re6Q0obxz+S08838bG4tS1gYD4/u7Rah0Rtv9MifE7r0uepkNzXbUIUQLxtXV15hrdzkKJOYEfTIYOtiD6jCU1i+sRyuXNq7zfFuycZingEsKFf9GadmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvlDMHIhByruSXy9GJa6HUDz/XVwIH9tPXQyJuEVjx0=;
 b=FPLj2f8rvRUR8jkNEpUDEpC2HxEETVGh9gA2JqdzAG5h28HvO3GmjqVwuBqif7g4A4HfUUgcLQCRyOwDveSP9WMdNsljp+DA0LX7W1fmve6yIQ+YX6ZgPJ+Nt59RnFGrgTDPdbDZN6TE2qyOiHeghhjin4ZFXx0ZIlkXlBwLnHTT5YDJsEAb32EXnWwzaIfdAjIcgjPytxklfX5Bi9PtJrxpNN86Zesm7qCrixqGYUyjoXwQPBqKxvv+hIEobSeTtKsWgQcGQDdse1xHgmLdzRnZTVWSCs5aA62j+pcci6VXws6Hk5aa2rOHVScEDpjRKFQpzpMvL0Adj7FtUnUM8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvlDMHIhByruSXy9GJa6HUDz/XVwIH9tPXQyJuEVjx0=;
 b=edTV1Y9Ve7OSl67YB05Q1C+O8MnlBZ1Z7nMew05PCIVLPbOeLqRjmi3LFMTISUWTW7sr4tQAGNm9xOURlLnHxZgpVbi7DMRPhzFe10v7ryUdMPh+4jOLnHaTXUYn+RN8mbFrTrEM6eE8oMyjALHQfvez4d33HJZ0aYePTMiqXVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYAPR01MB5404.jpnprd01.prod.outlook.com
 (2603:1096:404:8030::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 05:36:30 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 05:36:29 +0000
Message-ID: <87jz9d6zdu.wl-kuninori.morimoto.gx@renesas.com>
To: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 10/10] lib/string_choices: Add str_attach_detach() helper
In-Reply-To: <87y0xt6zgn.wl-kuninori.morimoto.gx@renesas.com>
References: <87y0xt6zgn.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 26 Feb 2025 05:36:29 +0000
X-ClientProxiedBy: TY2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:404:a6::14) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYAPR01MB5404:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cd63ab9-4bb7-4f27-ae6b-08dd5627854e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JFGRhIw9I6uoxMu5jAjuUUCTv5G+tk8z49OVPQYY8miM2mDruysi54gDrHm5?=
 =?us-ascii?Q?esVmhi/BjSWcSbm5SAC7i90JZm0XhtH9oJH0HJ4ROjLfaGFyjR0scxwym9dl?=
 =?us-ascii?Q?0djrkI2UrKmnTgoRDJ6PUU2jG8d0oXJJd04jSLvquMT7zC6bpB75wnTTvndF?=
 =?us-ascii?Q?MIZwkj/qmhFshD1Z1NEW+UXeDagRj+w2dxu3/tkM3ecZq97GXrCIMKcj/6Zf?=
 =?us-ascii?Q?g11Hk2qr1sN1Hf99C0zbIPddrpJYpqGCOKwGPPAfAsG95/1PTswqCV2hx0ey?=
 =?us-ascii?Q?b4OlxQy373yr4jVf1IFbLpi10raWU7HywJylM+4laXF5STmalzfigPNDgIDY?=
 =?us-ascii?Q?QexTkR5uuV+eVHr5lHJfYpLJ/nJtviBeLwzaM2ktq0/5rPloQtBLy/7dxNlt?=
 =?us-ascii?Q?9ETXupMGEsMWr6N5CMEH6G1xijwBEK0qnKQ0tG5E7ZFVpI5SH+KUwxTWFKFp?=
 =?us-ascii?Q?XZrQ2iU6qmeF4IM1tBLHpSbO9dZHc/Z7nX4xj5wBlGJI7ir+X38AkU2SCGWN?=
 =?us-ascii?Q?1KZr4+yXRXCIbBIKzxaJ2wsQcRTtR4fAcijlB7CIvszIZ+vcnMILmxfxCDy1?=
 =?us-ascii?Q?f0g28EgGbmK8V8XD3oWNL9EYiqNbrwI9DFLm5pADWNvsdPQJg7UbH4PdlnOL?=
 =?us-ascii?Q?OO7++x327/ctnYd69dAgS5u9iMbz31Ytr/NRBYPtQOogw6GjbhkZQVdN3JAV?=
 =?us-ascii?Q?6IglVTZOfAPylVJhJmxSg0PqMQJxx8dGcxuPtHbzk69To18d4EYHS01Pc0K0?=
 =?us-ascii?Q?btDn/m4G1UeaF+y4gwJTJ8KgQ2AsT+CEoq7jDN3SBIh6lLHCgiR8oqThHD5x?=
 =?us-ascii?Q?m9BwXxIjmEiPTYq9xUNq8v1dC31iCw4+a+T51wB6SiETBFy58o0JgnX+fCLN?=
 =?us-ascii?Q?P9L2+8ccJEX9Kvsmrhaqw8iju7LCxfBE2V1BXTVtIgPbz3+OGzIevLGywePW?=
 =?us-ascii?Q?6Z8bvWrXUA+PyO0Hd4F+JZONgqa4p9mg1NhWue2VbbTF06iWmFiFiQDfWbwf?=
 =?us-ascii?Q?LRt59JZH/MKQ+Kx3f+TWFw2yrP9Hxhw1FHMvGZ6PWPr82m87riDknfXrNUs5?=
 =?us-ascii?Q?ewgzfY+HTrcAM99siRfoJlZll/nRzqDqDQTbEDW1WMq2Q2COKIHvcmyU2Wol?=
 =?us-ascii?Q?P9xCCVtislXw57GKG5b+EoBdSsEQsAPotrZeVr+ob0o4/4lIid5a5d+aR1Un?=
 =?us-ascii?Q?+pn4KBrsqY3Mn7YRD/Z+nYGLoR9hAAXeq0g/+wszgSdITvCVm2JN7OledTgH?=
 =?us-ascii?Q?eJZppBwhGyinNHR3zxozMi9/WjBhZFoKoWZpqCld/Z1Ik3dmFYmbDT/qRi2W?=
 =?us-ascii?Q?mB2faGvCxnHlp9pctXXpPCabtb09Gh8+ipzls8a4kivETMBhXAgzQ04vFkJC?=
 =?us-ascii?Q?0bHonvyO4w8NGrKUXzBVAJzDo04WEDoMcoU1yXNxwaARas4aAX6eZTs2450P?=
 =?us-ascii?Q?zcsBz9ytdek99tEQyFTCobduB18QnaeO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XCWpnsbuc/04kavf4F6STfHQ9cuOTSrrK+ICTXtGzLnid0HU+fOJQWr9B7LN?=
 =?us-ascii?Q?ktg67KFJxbHUl+EmFvKpPl+OkpiVzhufVN4UQenopY6SHaFYxoV3miP+M/Bg?=
 =?us-ascii?Q?rAjhuLsG66GAjvmCXacwQD35qL2x0X778KRBQEE9Fn7ax3qY4yWmAdDoVQgU?=
 =?us-ascii?Q?Gie6z5UEXBCP1DBmPyM+3aYOsO2gzhn9vMiqPelOM+wbROzPgfyF5rMRJ1m0?=
 =?us-ascii?Q?ntqP8E+EYw5sVgXC86CPvc+ga6yLNR38hPbSMq1tiNfsE15TygYu6bfaZyOL?=
 =?us-ascii?Q?9+y9DPj1zy1m9tvNdSPgetmay+yT0xTTWMSTsx4NuNiP/JcLmiHTgkaJAVtu?=
 =?us-ascii?Q?8uJtYRLLkXV9PCxM5dATqp/u9LIElH+Iv55wbWPx6yNsIR/qzI7tUGimlvwr?=
 =?us-ascii?Q?eGhFIAnS3/VtOSIn6tT4MxBXjKn3Uk5E/H/ENhcQl+MBKTz1yaHWYSAs3IsN?=
 =?us-ascii?Q?+bw0yi+VY6goUpND/TxuAHQvbdRa6SfACxsPJ88x1ya5hi0V0bPpNctrGchc?=
 =?us-ascii?Q?Ls7vmpSW7/9yyik9jr67/45YPikPNVNwELvMBaf+jQu94/St09ZjmjGcw8dL?=
 =?us-ascii?Q?j56ytTXzjmxmW6RXwA41x/yOiseeaUgiDqtK00aoFrn/a5F96pDS6zaQRnBv?=
 =?us-ascii?Q?kwptowWj7BVAmIV9W5G73i9bwaezA3S5DfI8d+knBkDv5BxGiV6U7Wqv4oSl?=
 =?us-ascii?Q?tyPYFcIKKK+GQZS/FLc4F0kqw+F0cSOzt2rtcazYScx1wtCLMkVeWd3qEFBF?=
 =?us-ascii?Q?Ek4sd13+vOlkl+cQKDYZ3OdixsAbk/ufRXHIcHkJRJy5nLYdeCe7rESup74m?=
 =?us-ascii?Q?xV3WmzJS8ozDTRFUeLaKUtFWkewbXejIWyOAcxoxhPd2fkq2L6Kwt5rW8L9G?=
 =?us-ascii?Q?P66j8XI8HtrdbECwR1YeQxJZlbsA/1JVoW2phBf5+xysxgsGWB12PMManZ1S?=
 =?us-ascii?Q?+CH6EEOt0uibjLqvq7vy54oY9KameOA6Yw08Xe/+cr7/GmG0pOKowVo662rV?=
 =?us-ascii?Q?CVlsuyLrWpRXB7iopmfcsrnuhi2EziLNeY1pP+QOA3Z3557kFvWFmtHXQ8aW?=
 =?us-ascii?Q?sRJD/5DyGo9AkwODDQSCoqgmLrZRqRGxyhlmlJFtYClRAp+onBUx268nO3Bh?=
 =?us-ascii?Q?LAfFIRjiLjdepp/aIe43qXbWCCa18mBha1VXRMrIC55o+JxBGm2i4k40H7nr?=
 =?us-ascii?Q?78NPx0s52irs9dUnOdERSj5Tq3YGSqCZjbWMyPVvAyrJnws2DZT+5V0r7UTB?=
 =?us-ascii?Q?qsKX28AM6viXdOk0r5Rlk0+LoqF4nSy051VzbVET6gSIoTaeXM7yZ2euucWA?=
 =?us-ascii?Q?cCar67BnVQO4WwxUkx9+JqxogfUZGkHzw6+hnRVIteUlzQwUo3+e54oE9bcY?=
 =?us-ascii?Q?Bjn+3ktfhQqqG7LGODgvzU78MuKyCIxfs2J4dHmZv6RoI1zFDBomKz6TThMc?=
 =?us-ascii?Q?igR967BpIbdJnsRf30L8vW2oTPDUvzFJFceRJlzGMe/TGFw18beyJMm+TMPQ?=
 =?us-ascii?Q?sWUA8HWohCfAGnr/TklMyUDlZtsuyO4GYeM6UdhsgyDGCcbORnakUUEGWm9M?=
 =?us-ascii?Q?dzui6SrQzFXH3HU7/pxz3YiVC+PcKudxkSocwxZUkw+luhZI7GYuqcog50XN?=
 =?us-ascii?Q?eOkrbFNSsGJ9A8s6spQSjz8=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd63ab9-4bb7-4f27-ae6b-08dd5627854e
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 05:36:29.8192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdV2M6SqqeCGE+cVEJd2lWll8D1C1UYFeVtJx2qbgtorDhNxNCzR6n0LxSS56P2O8hXnTgh05J+5lailwQeq9/IMKklD+R2By+UM8R5m+lQ9KIXOEliO2ofGCHysg3dw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5404

Add str_attach_detach() helper to return "attach" or "detach" string
literal.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 include/linux/string_choices.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index 82c5927d50a9..12b26cb5ca6f 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -125,6 +125,13 @@ static inline const char *str_kernel_user(bool v)
 }
 #define str_user_kernel(v)	str_kernel_user(!(v))
 
+static inline const char *str_attach_detach(bool v)
+{
+	return v ? "attach" : "detach";
+}
+#define str_attach_detach(v)	str_attach_detach(!(v))
+
+
 /**
  * str_plural - Return the simple pluralization based on English counts
  * @num: Number used for deciding pluralization
-- 
2.43.0

