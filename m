Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010057.outbound.protection.outlook.com [52.101.229.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D29B17E8E2
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 02:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054511; cv=fail; b=Ger58QRaK/XybRe6taPV8YEiJ5OVKZogAS4f0+sYGbLfCtPscySRrL40nqdHnk+YZaI/uo98INMj8c4Bx0RQlFhplmiTvXcQ4uiok9islvBGDAQKx7L7CnNCfr+uPqyerRJWzf16ffZBwkRWM73FtPK8s05to+tTEnwK4AqEaI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054511; c=relaxed/simple;
	bh=DZ8rscUDq6pD/SOjwN5VokznGlQIfboTivZgd0UItKw=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=dauHea8nUdO5F20TfJEJDTSHEFcCKjwEUg1RVN5Bwoa0N/KSr3CluJU3di3f4l+O+X1SGwhVAOVx5qfXvziRW5Kr4PHNwIPBYts8ag1Lca/vjR+RpcmpjbN4CMfk5I4p7U/z/kam4Nmo2BnI7rSnK6Zsmg2mCaGvs7Q5LEhXodU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=ggDYd4SW; arc=fail smtp.client-ip=52.101.229.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="ggDYd4SW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RdgI6X4Y1YBJr9uWF6gx7rfj3V5pWvEOj6MXmdSTn3dMv2xUZRE5fZwcBZLmMhPhwZHRv9C0idQsep2nndceiMw728Rs1I/JC8l0DEsfNuF2K9z3qa2Y4/qaMuuPbvHaXwnzrcwyMi0KCewmbU+/74sMjtmvCeN9kMB/OJ9z2rxNHIQAZ7NnQ91nUNAomZvXfDLUPjLDvuBp7c2q/cb1GJKlDO5+3E04kNwiJWcB/MAnCENQbyRj9FCauQANatPffY+mDQI87J9A691U4vxR8Fw8SHIPA8V2E4GZ82mGeMyxI4mC3LPpEajBbqCfYT6UL9/Jtt9FXvCEPOgugsH9uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFYhyDgaNAo9jxjlNGtA0Dy04jHjx0k70aJn4I+3mFI=;
 b=Iw9XKCGyBBOBff6I7GrqE6yEctHoWLprB/RkhUSx4qEXGUnkY1R1r7AdkW96fyn4UYOvVJiYE/WrUCwqMAxKC+k1ElIcnuxQBVqioZ0MpGOiafJKderNFLlC6G78zG1pLTLOwf9AmBkveduJF9WqfgLIn8oMepGkdY/tfzLEMksPbSq+EnsDNGkSArLHvhHipP3pUTXtuosDTBhuSA0yQq92n0xdvjUsZBEOXXe8UfjLtXTPU+mUURSLgNTsYuWZ1FgjafseUGDZw17SGzvksjg9EfW/wZkOgnlUoT+aJLKfOOy31NplmmgkLRcZyZPUzO4fCNMGlGcPqs7GzdMJVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFYhyDgaNAo9jxjlNGtA0Dy04jHjx0k70aJn4I+3mFI=;
 b=ggDYd4SWvvYtlEu6Qax9MYRCoGimV2bP1MaavM1oBjlDPi6yHG/4GyanmFgy017VXCY7WQaROktbjBLE82s1UkbZhdqkS84cSfhN9DTsLrnrP/3m7vbxgyOmLUADMCOX/cENUn4wv//BT4rjSIcDaZfOz0wJJ9AtYARmfmqi7/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYTPR01MB11089.jpnprd01.prod.outlook.com
 (2603:1096:400:3a1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 02:15:07 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 02:15:07 +0000
Message-ID: <87bjuhpmmt.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [SAMPLE] crypto: nx: pseries: use string choices helper
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
To: Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
In-Reply-To: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
References: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 4 Mar 2025 02:15:07 +0000
X-ClientProxiedBy: TYCPR01CA0059.jpnprd01.prod.outlook.com
 (2603:1096:405:2::23) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYTPR01MB11089:EE_
X-MS-Office365-Filtering-Correlation-Id: ee55e675-851e-40ae-29f6-08dd5ac2620b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X2dArbMQem4+qXl86INWd1ILpUYbhSNMLQg0/v9ikY3XqEKRGX1AvXW8pre5?=
 =?us-ascii?Q?71hc7hjLiBHlK7LW8aYVLbtooFQ9J94SeieniDpG/nESsS13J7BiunFpzd6o?=
 =?us-ascii?Q?b+Y2/q5q7gyyIfLoLg+PdTWYK30/Fl2zJ3pLHIWeujl8Qilpzh+zWfiPIjgA?=
 =?us-ascii?Q?i0FAtu5NAagqPUuV3MTiqtnBHcr4WgGslNb9JWiq0zX3beiATdbJ2ERj9sT5?=
 =?us-ascii?Q?P4fPaLiQxUV6rF5dj4rplcQSSVFVrCqSiF4GAr8w2bAMj0kGHduDuRJIK8aE?=
 =?us-ascii?Q?MSu/5PUftMTb5qPPISs4aNfmwykVVP6lBPMtxozMmJTTrsz7MuXxjxGfU16f?=
 =?us-ascii?Q?g5JWfmNrVRJXV3hRvMR88ga4Ly/EgjuSz3dN0gOQyRtmf6KHkCPlWlulb6rY?=
 =?us-ascii?Q?0GeLcbzPe1C2j6suop85O0OM75ODVO3A2XAHEoBOcqQFWo+W0HDdbEytBGWS?=
 =?us-ascii?Q?KPtSe6smlGyP/oFDpJMHwI3doyWs71Ohb2sr0Kphog7l+DXJhXB3QpDL1Iih?=
 =?us-ascii?Q?+3vS37ZYjaI6XpegZKdNNGb0s+fQRbPArhPfn60GuA2Zm5H/23gKuDOmhsxr?=
 =?us-ascii?Q?tdBipXlxRNZWLGL1JuFBs2oriRLhtz1wkJ/FdleP3+YeZrw6Dzq1wvAruKqC?=
 =?us-ascii?Q?329q9X/3KjLbGSgBz8XcyCb+/da1BaXuG8ozcI6/ga3kwzcIMKHRQ+zprrV5?=
 =?us-ascii?Q?0MLw5l/COKzpGeBwm4xyGyvUeapgP1Oem7uaMf5R42R+/BkTRIJCmTWotbAR?=
 =?us-ascii?Q?FNZ+7NE7gVFdZv7lr7Az6c8RSl7TSX4tmzVkI8q7xzNa9UNubFtnGpuLFU44?=
 =?us-ascii?Q?oJLarQRIIOSVXL4GASw/Gd8Xoi7O2m3qPK2zecYQBXWNzlT25e4tSuILJwv6?=
 =?us-ascii?Q?x5JFKFbFrjZiBk3MdjxVnVfvy1M+teWHpUJWQk/G+sW7akef18up9KZZ06E/?=
 =?us-ascii?Q?aY9NmzGOXLWZ3jjHkNctaL0J1HxCAx8ONq+km2dQVbCh6OayTPuuPGsdOSPE?=
 =?us-ascii?Q?q2mmInKFOVH4EIH7QLdiqEe8Hle/4Xy9wGouuW5hrsE+ovIkCwfL6UcBHUvT?=
 =?us-ascii?Q?BJPYVQAOHsN5pgMAHlpG9CU7t0GjosxmRAqyGXL2K/KIg0fnDyRmgVxFeO+n?=
 =?us-ascii?Q?tXwz8LbH1BDV+/IlgzumncMT46ICLeYbatah+Wmwwr/sB6tLRnanyUXRYPTP?=
 =?us-ascii?Q?NaCygdAip6u1DPGaI0ap35FGhKIBID78a9C6yXLq1tdpXd82vV+4+ZomvyuP?=
 =?us-ascii?Q?pUcF2INdYHGylimmuPLNNMVQxsv+sXwaPPbuzfaqcdgl10UwhwkmN3D1wtj9?=
 =?us-ascii?Q?uUybzxNZ/PjrjEwwi2zt1TGiQl0DNwKxYXorLL3dxg9RYCjgMffdx0ND+z+Q?=
 =?us-ascii?Q?NUb631HM5ICaNzqXY80gMBpjRS0XP5KZHMNwFa/p6GlATXPDnjy0MFzxqKwR?=
 =?us-ascii?Q?wszjnrUMrek=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oIS3uWGZJF0nInYwE2QRDeKK4O16Rf3NlUhG3fJ1wIfV33YAHVkUKdHnxjXW?=
 =?us-ascii?Q?nvtm4ewN59v/w0eidjc0+VpohZ37HOO+z2/YUFHpXjcsZoNanrMlYthndKH0?=
 =?us-ascii?Q?IBGztF+MwCxdo5Fq7kJamuLYqKKUvzXXdFHbMns47ZCYycRaolhDV/SCOiU+?=
 =?us-ascii?Q?J2Kw0pZVWSwCldHLeCVjYzztbwTbKnhbss0r6S1/llR1K0QLPVnJsiG3leap?=
 =?us-ascii?Q?tfK6iEX68gSyHcdJOkcP0/TdQIMvEQ+JA9fdt+TetuTsN0wAwRXIHfD9LAbS?=
 =?us-ascii?Q?UfCHV8fz8eSeRJ2znbDtlXdQCS7pmSZxOuqEaqq6/S9p1RGrt5mgBV0zJ6Qc?=
 =?us-ascii?Q?XSrJi/xZQFjNcodMSxc/1nF1BdTbcbOk7ePbDuPaWApsT3AOMKJFKbyXQ6Iq?=
 =?us-ascii?Q?3fw5sYrVCT/ayVVhcsd1yeQMpQxPRtOEN7X7cXRtGnJW83PxHOmqWXqhsYYr?=
 =?us-ascii?Q?FYMiNxznHbb5zvOxzVhY7EKzmtHK/w91zLxWduc1SW/j2H9X9DhE2cZmH5tA?=
 =?us-ascii?Q?VWx5JTuv11FUykvTJGlwQIan+v7sRQnxbZ5ET4zUBAl3QzxAhOPhRtAw1cD1?=
 =?us-ascii?Q?UuJL2z5ppENWe2A94+3dPqCqzZttrHZK81QeZC0PPexD+9ERibaoE/48Zw1r?=
 =?us-ascii?Q?3v29pWTvXuHY8KU4L4hjljQ3cM27eX0TYOAqoHdC7MydE6Sm2ONDzZWM9ok4?=
 =?us-ascii?Q?ui3eQYTBHpLfsh4DZsIns+JU5zurl3bo1OmPNiqrthoqfqYGe+qKvzR0lesW?=
 =?us-ascii?Q?W2ACBvTS2ToHA1Wk3ZNM+gFQ9LK0laFbCEjh2gUgeP4cwoBSsHXHEFd2GojM?=
 =?us-ascii?Q?bnrNRMqLovVqO+ueP4KRVXtUydEIhpe9ALwYutTH+4B1cwQxS8i6WoI+JyGn?=
 =?us-ascii?Q?Qpv6yUjsvV6gWBO1RgOxFd28oFPQBfqmmqKxWUSH/e/Lo4GMyOfVC4n4KOXv?=
 =?us-ascii?Q?wkJiLGs/VuwtLlfT0z3e9URUYub3E3v0ww93kVsCbT3I6zl9+1WROn7hKXUl?=
 =?us-ascii?Q?CVQAKPvJcyMsv8gFjOEDxX6vB8HyXsrijf3CJzNfCoryD1dMooQ/EnU1PLHA?=
 =?us-ascii?Q?G9ciwo2+UNcwdxlpb3m6qM6aVhmIhkQ/bddgtatP85/s6qp9w0BTYD3dJTJq?=
 =?us-ascii?Q?mC3fhChtZUjIofXtQA2qTAcnYQi63OznZiTldzEgbomx04onwwXKFd+imphu?=
 =?us-ascii?Q?zTYks3cOkVsxOcjnU9+sOU2p3GONWwmPZFSgX7HrZm+/aiywMD08m8VjCE8S?=
 =?us-ascii?Q?JSOIGOotNUsHU/cSzXu4EPuZHvxakU0vNDKV5OXDJVMR4jTrSiECy09OJKNw?=
 =?us-ascii?Q?o9J1RrrJsN+bscjfmu4/XNoCanQwVNzqK4x/LXc37h/TzFGjpOmHQgnRo2cS?=
 =?us-ascii?Q?VvgxfbdoIyTOrSIJhAypVn1s7Xhe/BUWtJoSfTVetsuHmEQDvy+57kvyG8qV?=
 =?us-ascii?Q?AXwUL4Baoll9VdZPNinUIV9s8fHwfTkqPoKkHTGUJghMg41X9p3xOEtXNcwT?=
 =?us-ascii?Q?jXm72hs0V646NqQ+Cm23KNwLa/b7ZnHldYAvLIaCpi41eEbcRDs/BS6yBPcB?=
 =?us-ascii?Q?f8VHwxqypujM34YG26ab9iyzzs7KpEQyDBL8qaLoyRakNcWmaxReZc0B1aCT?=
 =?us-ascii?Q?94ZLSiscrxE116EWzTWvCOc=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee55e675-851e-40ae-29f6-08dd5ac2620b
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 02:15:07.2451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S919K67HLE7EaecmrIqOgoLorvjXZVsJH+8HrsUre86ffqfsiGkxlZ9GmleDTKSE9m2Nt02OZLJn1ragAlIkcp9h5SbMPdPxJcBGsnD8lFGaEuyG37A8TU75lkWSIH/Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB11089

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/crypto/nx/nx-common-pseries.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/nx/nx-common-pseries.c b/drivers/crypto/nx/nx-common-pseries.c
index 1660c5cf3641..1f8a73fb6bdd 100644
--- a/drivers/crypto/nx/nx-common-pseries.c
+++ b/drivers/crypto/nx/nx-common-pseries.c
@@ -7,6 +7,7 @@
  * Authors: Robert Jennings <rcj@linux.vnet.ibm.com>
  *          Seth Jennings <sjenning@linux.vnet.ibm.com>
  */
+#include <linux/string_choices.h>
 
 #include <asm/vio.h>
 #include <asm/hvcall.h>
@@ -55,13 +56,13 @@ static int check_constraints(unsigned long buf, unsigned int *len, bool in)
 {
 	if (!IS_ALIGNED(buf, nx842_pseries_constraints.alignment)) {
 		pr_debug("%s buffer 0x%lx not aligned to 0x%x\n",
-			 in ? "input" : "output", buf,
+			 str_input_output(in), buf,
 			 nx842_pseries_constraints.alignment);
 		return -EINVAL;
 	}
 	if (*len % nx842_pseries_constraints.multiple) {
 		pr_debug("%s buffer len 0x%x not multiple of 0x%x\n",
-			 in ? "input" : "output", *len,
+			 str_input_output(in), *len,
 			 nx842_pseries_constraints.multiple);
 		if (in)
 			return -EINVAL;
@@ -69,13 +70,13 @@ static int check_constraints(unsigned long buf, unsigned int *len, bool in)
 	}
 	if (*len < nx842_pseries_constraints.minimum) {
 		pr_debug("%s buffer len 0x%x under minimum 0x%x\n",
-			 in ? "input" : "output", *len,
+			 str_input_output(in), *len,
 			 nx842_pseries_constraints.minimum);
 		return -EINVAL;
 	}
 	if (*len > nx842_pseries_constraints.maximum) {
 		pr_debug("%s buffer len 0x%x over maximum 0x%x\n",
-			 in ? "input" : "output", *len,
+			 str_input_output(in), *len,
 			 nx842_pseries_constraints.maximum);
 		if (in)
 			return -EINVAL;
-- 
2.43.0

