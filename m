Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011048.outbound.protection.outlook.com [40.107.74.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603E957C9F;
	Tue, 25 Feb 2025 01:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740447841; cv=fail; b=qxe5OsbBoNOWuGr8qqD6DQtHqVH7LVw8+2jisH16FQV+3D0tLYJVQR2MWQafdqxhQsRnAeJiDKdz9hKNECDsxZ9Mj5KqoRLl/Xf0UCOrD6CHV4lg6QRvYgW268zNAQLk+9I5BiVtIdfgHew8Nomn/UDJc4cPfK8wS70AfGG/YNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740447841; c=relaxed/simple;
	bh=0EEOlAObVEeWtyVgassAGhEGkairgZqmSq8RBRtmBOQ=;
	h=Message-ID:From:To:Cc:Subject:Content-Type:Date:MIME-Version; b=UpoGlEH7FGtr59PwITvTDO5pK2x0r7K1IGVCsqUP6qRl0YfhXyyMlx0y1j8kVyjFma1JYKKr3/TKimFpsJ0uOjmUrOtBcxZDJWDsJd/aMAlOaLNWys6zpHTHhIjW3pU4K9K0Jkwed8VWvdXRRQ9r7ld2kFkClCxRnyUDAOJUZaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=j/zOTxxo; arc=fail smtp.client-ip=40.107.74.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="j/zOTxxo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kh95QFC4ejklxBQMiHtPg1YCCveTMLg0H6BIM2kLYEvLs3vntTrMjHZYlkQAJtV8w1GRfaOvdKH6SddxOUC6uA1mbHt9Cg/pUpEwqUVhHCikePX4eFvIYsw6TuexvEtg0OqIe5hPGr3G5JVAsqU5HaiKfZ8gmwyIvsJ5nZZ2xBRmKllm2u4QDDkmnibRGvWv8EcHHRWj4ZH9dxp2biaEa9mNK7EFmRng4AbsPJKyoNBBXy0te6uAhfGcziUTGsmRdE3aB8057AuZVPxGP+1REpaVDhWLGe58KMmpgXK/eKuTNVY/W6f7GRvZIytHf8iMoTOx05OR9J/Jwg4g88u3hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EEOlAObVEeWtyVgassAGhEGkairgZqmSq8RBRtmBOQ=;
 b=R274w+DimrbEDJPo8zlm/pylmUEMDUUEdNuABSiB2ej++fBRRSu2PELGZdqQsgBZHDOOLNrwQQ+O6AYdZKEKB9IiO3PUzUfRyLrI6jwAncE0eymPiKIxLsaCdvCEP4rZKZ56i3hwQekXdkn6V0M/r0tNF1AmQ08Ex3mj4CNcN8PggNY5bDUTNWG/E5AzmKOovJldYlh4pYBf/koFn1sOZy1uYSNJLu/7U8iTuswNF99iuhCinH544c7g8Lg5gBOfUQd0Wy+oSEqQ2z3IEy3W9P4v0rjjy0lw0CZWJgDYmlhjA7r1gWb+pTT2S9g03RKbt0CrgUbfFummxI1Z0DNeLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EEOlAObVEeWtyVgassAGhEGkairgZqmSq8RBRtmBOQ=;
 b=j/zOTxxoR4di2aRw1ilKmRJjMW6c0HvXiB8Yssymi5To2skHQ9Czxcs1yojvcP0SGRFQ7awNK0WHAZOEBokIcgFSlN3VIfzqX6blqZ+RAp88WRaf5jlLGBwDcVT6oVEXH13W04hukZQFGej3V0Ljkz+s9JPzE05teiL+jV3r+BI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY4PR01MB15472.jpnprd01.prod.outlook.com
 (2603:1096:405:270::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Tue, 25 Feb
 2025 01:43:55 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 01:43:55 +0000
Message-ID: <87eczmssrp.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Question about strings of string_choices.h
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 25 Feb 2025 01:43:55 +0000
X-ClientProxiedBy: TYCP286CA0359.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::13) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY4PR01MB15472:EE_
X-MS-Office365-Filtering-Correlation-Id: cfa85784-1d7f-40a8-57c2-08dd553ddd81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zhWAc4CdN4LbEi+7l6W0Eyi3QevPNNa9cfgsE/KKYa+ir4pk+VwYdDC3CNr1?=
 =?us-ascii?Q?PyBZckbFfEK25/h3UDLdY/1uswnyONSE8lKc0A4KJw7G6KImvLDaOYu03ZqZ?=
 =?us-ascii?Q?iYa+59ByEqPfsyMGC6lBVv1NU6Vk27+ENI2VbDi9Oinqi62nbEqkhUgE/lYD?=
 =?us-ascii?Q?NRQN4bkHvx13mKXsbRRjHJATXeFtvhKZ9h68Yw1ciId5VqDcV6rekqQlW68q?=
 =?us-ascii?Q?B0UlRZ+5rdPgI7q3ZPlAV/SeJhcIxub44bZULOrvA6EmW/SdWslfwvZlJfRj?=
 =?us-ascii?Q?5CgK03HXCE3sZflRUs+v+Rw1QyU9+OdJPOi9W0+pzdMudUKN/GRJqR09Mj4t?=
 =?us-ascii?Q?4jtQihmtQNKHTkF4zCtLuHTYRrl1NC521EUMBY7FR5z1F9O0+kqR6dXuW13b?=
 =?us-ascii?Q?0loSn0fOUB8QxcOuBfKgN1nbK/J7A3nrleP5vzMdokBBiw67vltxvyj+89wS?=
 =?us-ascii?Q?wULSgXTcIskaAmEq6UFY26zoIS1gSeM61S/F7jgZhFTqontXaZ4tU5K5X6RQ?=
 =?us-ascii?Q?pppfk1PwJUGvECBexBTTZN29ccluBn4TotslOtFjbZUzvFjI8VX+hvJZ9Bi7?=
 =?us-ascii?Q?CBLmCJsFPqKev/9ISzxngcA/L8Gf0vd03Ox5u7PTn13NFCcx/RV45jO49Vsr?=
 =?us-ascii?Q?cIZMSPrOQOiIloSxI8NskbdZ6fpSw+7diprPnlOljUCFQMTT263Fl0wo/Wze?=
 =?us-ascii?Q?kHBC1EURLtvrHAkzQSx0pGLGK8X9Ihnqkav0ghFMle7MePkDPLBKuvWUZIs0?=
 =?us-ascii?Q?RNbaZG2rfL/aJk3ege7hASGeylASIydEQxlHPdgWidTVRyWfEHLrF3XLC5rx?=
 =?us-ascii?Q?4VV8v1xGxiBby40IMaGxrpX3kTXMZlkLZuJEdm2G+H8M5XLpgmC4gMqE9yil?=
 =?us-ascii?Q?grP7DRTTpvZjnYNHNUhPMnInszY9lfQCGVeUCtZMftcQDXRklNPIVZV1nD/t?=
 =?us-ascii?Q?hCUCVgcASOUkLjY3uqE/C2n1iA0d+a+cqK2TOSgS0KvJrCMSjYTwC0/f4MNn?=
 =?us-ascii?Q?++c9qTvp+Anx1VnG8Wa9RffvJAIH6g5a4IxpbQusVaoFUjb8FcR81udsX4TZ?=
 =?us-ascii?Q?/0g3yurTJrdDSbzcz9a+jMhGz5DimWgkZ12lRk1Qaj186PpbiJId6C2PT+9q?=
 =?us-ascii?Q?9pkda0BNLUlLZM56ZLcFyW4jRmnB2QeOoOCglbZfcidsLA1UZPhxMhIlpY4/?=
 =?us-ascii?Q?9/yFfo3jUOwFaeo2YBnEQZHgnRu1XIe3Q2+TRUiNh497sLpOTc8fXV+Z3mwj?=
 =?us-ascii?Q?kGFNUx/2+qG2/sqBh87hdZ2oQYwf6ghFJAEXMoY9syIgaHntVW/2lk9AyF3g?=
 =?us-ascii?Q?NslFpuyytUiFuW5zvUeV4A6l+QM3aZSiqhZYmqTupHf0lvw3Ac1US1fW+Ha2?=
 =?us-ascii?Q?c1NG52RZm/eidcLKpuX07dKVvVSb7u9vZkQg81X2uBH0zOWAGxvvZVuGr0R6?=
 =?us-ascii?Q?Em+ClErTfgIaN2qwxnhg3o6bMkK/soVY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dx8Rrp3JOnlssCjobIXHnRCoqsT+4OuYg+wxT4MGuNu0q1nc9R9qy3h7Njwh?=
 =?us-ascii?Q?v8JgVTEmdQdLQ1/uzHHOWMdzvNuUCncH2UZMYycp4MOKuqvO+QVPAC1iYgAe?=
 =?us-ascii?Q?LVbz9l7XhfZEGnRp2mV2fP+0seCg8Vf4w9koFsckFMuROeodLyZRkvh3VpeX?=
 =?us-ascii?Q?qvLKkmJNg3twE2RNqE7/0Kc7q8L/mWg3l/3+VdAL1pyzelDOUTpiOkqmtqbX?=
 =?us-ascii?Q?SHnmyymhQyX7sOajh0vZtQ8CkI7r7mJp1O+VTMyrUci4uXQe6+2BVZHSPRtH?=
 =?us-ascii?Q?TyBepx/znf7p6U16S/YwnDqcIlmxDNj2U+fJUOROs4xgp/C+INMiQYY2Tlg7?=
 =?us-ascii?Q?k2YF4x8tOc9HRccQGlkvYD5jGYsvuyy8GJcVkO4olNmgcK78leticJ2ddd66?=
 =?us-ascii?Q?5egzGWnK+NABiZzSzrfT/eRB58agSnkqvWi/PqMkYxu/wkeh/mBqXO+U23w9?=
 =?us-ascii?Q?94wBd4btU+clbj3lC3W73+RYkhLYZC0NSYNo5CRIpUY+JpCUe2lVN3ry0K8A?=
 =?us-ascii?Q?5+hF/I8GAKA2ZE7HkZDjOjcCCjgIzZVkM+iupyvudwReTc0u631XBIATHviE?=
 =?us-ascii?Q?BUDyMJHjllNl7YMzsWm6yHEY0PX0eEdXB6bYAhsqu7pMQWTPrrUAvKEnlK6a?=
 =?us-ascii?Q?nsR7zPH7/ZmdE+ZYXsRvMeNf09sfh4118NB2z0C+rU1kgxj8OMaUZIwpowcI?=
 =?us-ascii?Q?hzmPIggt7GN7ijj+i+LKVogsdQgjguhpfU4LqPSs1MQPUawCNJMRmtiobH9E?=
 =?us-ascii?Q?tq9krdhOH98YQgphkMKAx5o8pBke35rcFmxeZL9OGgFuXyebm6KeztsWldPu?=
 =?us-ascii?Q?KEVuzca8pF4J7cbQEGVkicFyb0ysmD3gmbjycmcRumBZNFB8JCHHfFA+ORuI?=
 =?us-ascii?Q?QWMv1iudyd/ga/dHlQVitOi2ggn2mcZeRC7qUzAnzZ9tngs8o5sR93lRI1iA?=
 =?us-ascii?Q?V1btv9+t8o7rC5JdU7hGOFH90mv3T/ppNxRHzVv1Cm9NXnXtgjzjqyaP8ZqU?=
 =?us-ascii?Q?y8cGcYAUAG4SjUIp1srY6ggPr7dB3E9o6MqFLlsruMQp8ubnDfyoGWA3Tdz/?=
 =?us-ascii?Q?UVmb/E1WFS/rL8XjRBtHnk+BEzmEDlUSlKQ/D9he0Zr3nHm3b6F+TJpHF2pt?=
 =?us-ascii?Q?Lku1/GnnE9sA1QRGGOSXlPimus/kLh4WuZAwOH0qImAELB5iudoJ08BVBMgS?=
 =?us-ascii?Q?qlNhXsM9rXDlQB2HEaVUyFPp3jhMZJuhuvsW9xJFxuEADyRSzX1tmUDrW16c?=
 =?us-ascii?Q?rvP8EHhgFvPesLwJ9xh8w4j6nDMKNx6hsYAZxaN3udAUJj1THBYpZQk7fOO5?=
 =?us-ascii?Q?UtieicNr+NtR9PkPNFwStdo345LQMPEuMi/dGXOpyV8r9DqOsl2w4hcs79Ya?=
 =?us-ascii?Q?zpi8p1Qj7sJTMkrvyXuHG2AK2e5SEbw5U/uy+WWdpyDMnk4zO4BWKRp22sC4?=
 =?us-ascii?Q?c/Tvb0DHiT7DluSCpHpZhEAWlKIsZXCapqNPu7zN8rJZBeWlxqdAwVWLPYYQ?=
 =?us-ascii?Q?c4tmw7rHbD73uNOpcGQ/+wsPgJmsoj9x3ADBHUNEae8b5GYa5EiqT7kpVln6?=
 =?us-ascii?Q?BfwCnZyI7Ln+lvAFAMIwN9cITEZE8PYSyEG/SecJ1z951inUi/RKNQg1LK/U?=
 =?us-ascii?Q?GWVLlpyPp9ro+0xwY52dbTo=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa85784-1d7f-40a8-57c2-08dd553ddd81
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 01:43:55.5727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3dqYo5PNctneqJOMH0e3pgwOOpz/i4saKzEGUYe8kU7HT8hW9ekWUqrhQHUcbFZQ5RAjg7xvG/uwgISqKyPW8FVXYJGKaNebyVK2nmb5QchNmkWCKl+KoivHb8Cgr/w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15472


Hi Kees, Andy

I would like to use string_choices helper, and want to add well used
but not yet supported strings. But before that I would like to ask one
thing about it.

I wonder is it guaranteed that the strings were persist after the
function returned ? In normally, function local variable will disappear
when it returns from the function. But I'm not sure in case of
static inline const, etc.

If it is guaranteed, I'm very happy.

Thank you for your help !!

Best regards
---
Kuninori Morimoto
