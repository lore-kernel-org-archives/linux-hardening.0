Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EC22750F2;
	Tue, 15 Apr 2025 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744718627; cv=fail; b=qFOiOnwzelc6JkEz/CcT0lKBg9sW6mMo3gaQGu6JqD/tA8uaUbn5+jev/logOnwwrWfZ7J3sDcHceGVnYhJG7k2am+j6zToG9eo8kOvPUEPZT2eByzFwNwUK05EoBMrbWKobdTEw7k7g9teZg5QeOPd9rPf/dSMutaTnmidA+aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744718627; c=relaxed/simple;
	bh=JysCC1r1soSB0vxbkObYGHNXosCO/3psQfn3j0PtjIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCg4+4idYU7IACX8PgQsqr304mMAR3W9zRkv6tRr23hD5pLd3gjDWJiQAUqVYD5Gpd/2o7B/nLs7rEN+DyTEj7z8hKzDogx26ETUcIGbKcuJhC/nn5wRlGEdSCflbMgwMaXcYStyGG13roIWHUTNU9WzfQzPQOLz0rfTtiLgXKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=SCO38vgM; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=vOJEBDJC; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="SCO38vgM";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="vOJEBDJC"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F6G2Pu030986;
	Tue, 15 Apr 2025 07:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=s8T1wNUdYF/8dTgq+8hPiMmt4eZSlKvB9Id76U46g48=; b=
	SCO38vgMhoRTDMQfLjENxz+34S75nQkWOPgZiMnwljvp7+lbArnowNYErSg10WRh
	xPq7F4biwNQJ86ekFj9r7v3dnko7c7BpihoF4Uqv1YWS9pNNboguMfo+f8giSoXz
	2r9cY1gGbZL9w9CCEuoeTHOuhXZd3Zpyv2316FTJjUhGM1XYKB1jTLZozgHHJcRl
	MtE1PTEPx2CLiD+MS0K16GVBQNMQJfjsCqJ1Uv+4CkqOane4qooyfCAmzF2D6QYy
	aaNdGGYThd0x13EU+ejr0hV9oki7GnFh4U8dGGYCAiJ0A7KplArRtYnOp9/oK7D0
	GfD0sWRcD3fFjOLKGbQegQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4615wt11a4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 07:03:26 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvwt/28vLRy8oR1uzJowmIMa+/waXujr0aUbVGFl21yyCrt3Wt/awD0lGKaBjDu8HJACN8KcC8CFKhubZqoSOz/LsCOg4a7ufWYBCO6u3vtbHDWGqNVqwkKeLaYS5Zwa+tn5fkA83BRtWBNpbzPexHyVajdDKjQtywQA6X1jB/TtS30rEYUeBxQvFeExSlwErriJ/MoB7oYGJRi30IhehwdF1NtZOBw2pGTksgtKrdBjQEtbpNI5bPmR6LVK4aD/2/9JFMGT37U36l1CglYCmNwUvUr98lj+PoPv1aEFeFEjPmIv8TTrAjF+x+3Z1IFP9CDaW2RrppcU0LYEvtfXrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8T1wNUdYF/8dTgq+8hPiMmt4eZSlKvB9Id76U46g48=;
 b=Dm5P2kmG34arDEA0NmvxaLZ65ceA57RPx2eHu9gW8342pmzySaPUCjEYnPPAK4LahqNXoXZgnYBRmk7BhOgNdsIOLQ1gB55mZpf5AVGkoVzjsQGcb9PAMLpf/Lb3v83mIyLnQRM4/2hTkZ1frT4bN69u13nipe1Q9h8LvaQ8i82kN7HmXpBklwM8rdQ5SU0QfOPMmteMLwaJvEUKnAdiIRR8s6APzsp5YOoqCUb4nmazUEAqzAfzd9/Xv/Iw4hOHUF9xq+prpYH6I6xl6gk2sBXpfL8hgkyeDQoA9Qo/AULbzze9WB86s67k7vE7Troz9ny/vDFBTHeVTd6iRStc5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=temperror action=none header.from=opensource.cirrus.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8T1wNUdYF/8dTgq+8hPiMmt4eZSlKvB9Id76U46g48=;
 b=vOJEBDJCoZrrBQQvw4eC14UMGGg+wNood6fzrqQ0UhK7vAJ+r1e6Sp/RTgZma39uDu25bCgTyAO00171lgGC6nhxP3jpv3UcfnYBAGAFbQ4Wf7bixClWBHWNFzNg78bXG80TnmcnspZLsjauzPzinEeiwAVwvjJvsOgv+6ruLEM=
Received: from BN9PR03CA0781.namprd03.prod.outlook.com (2603:10b6:408:13f::6)
 by PH0PR19MB5443.namprd19.prod.outlook.com (2603:10b6:510:fd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 15 Apr
 2025 12:03:21 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:13f:cafe::3c) by BN9PR03CA0781.outlook.office365.com
 (2603:10b6:408:13f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Tue,
 15 Apr 2025 12:03:20 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 84.19.233.75) smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=opensource.cirrus.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of cirrus.com: DNS Timeout)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8678.4
 via Frontend Transport; Tue, 15 Apr 2025 12:03:19 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 3C831406541;
	Tue, 15 Apr 2025 12:03:18 +0000 (UTC)
Received: from [198.90.208.23] (ediswws06.ad.cirrus.com [198.90.208.23])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 1D849820259;
	Tue, 15 Apr 2025 12:03:18 +0000 (UTC)
Message-ID: <c344e6bd-1a95-4982-927d-f679410c444b@opensource.cirrus.com>
Date: Tue, 15 Apr 2025 13:03:18 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: cs-amp-lib: Annotate struct cirrus_amp_efi_data
 with __counted_by()
To: Thorsten Blum <thorsten.blum@linux.dev>, Mark Brown <broonie@kernel.org>
Cc: David Rhodes <david.rhodes@cirrus.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250415090354.92211-2-thorsten.blum@linux.dev>
 <9a0595a3-00c0-4006-bd54-99b938ee95bd@sirena.org.uk>
 <C0A89B4A-14BC-48F3-9D0F-31C8C0AF7ECE@linux.dev>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <C0A89B4A-14BC-48F3-9D0F-31C8C0AF7ECE@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|PH0PR19MB5443:EE_
X-MS-Office365-Filtering-Correlation-Id: d316ada9-15a3-42fb-8036-08dd7c15839f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHN1ZmplUHVaS2Y5a09QbjNrWUxKS1VlbzNLVmNqTTJlTDk3UXpsd3h5ZGR0?=
 =?utf-8?B?Y290b09FTXpJeitHZXJHL0E2QnFHaTRMV1BUdVVHWXNNcVJBMHRySm4rSUFE?=
 =?utf-8?B?WXhNbDN6dk1XTTRqM0RBNi9QRkF2Nm1RNHhPOGl0RmpFTzdHV1N1bXFJbEVa?=
 =?utf-8?B?Y29OWTVjV0pxaXhybjh4aVBiTXFZVFdEREZYdEM5MHQyK3UyTUQwcmYxY1V5?=
 =?utf-8?B?VVBBZFpiaUFFTnZLazZCbGFPRUVKOEFjMmp1QnhzOWpUTXlnQnZmZVVFckVW?=
 =?utf-8?B?QzJyWS9hZmcwaXNqb3QyZm1lRFBiRWM0UER4d05tOGZCQW5YUjI1OGZDakds?=
 =?utf-8?B?aUFuV09xWjhDREpxdzVxUSs3QzBwS1JCRUdqNDhpV1gydm9RRi9mRUVDL2hs?=
 =?utf-8?B?R0ZtUjZnQzFlakNsL0hsRG9wSlFtZlpmczZkOThTWTFaSjRUTU5aeE53Mmdm?=
 =?utf-8?B?N2JKM3VEZUkyM1Q2Ukd1MXlIMTJhL0d0aTdQdTZvYmJwNG9ramxyZi9SMlRv?=
 =?utf-8?B?bU81Z21tMEM3RnVYaGJNUS9YZjFIM2NIcWxoR1g0Q3liTm0rRzJSd2lWMzlY?=
 =?utf-8?B?Z2pHeXR3ejFyc1N2Ylk1OEdtU1RjLzJKVVI2S3RJOURybUh1UDBKTDRuTy9L?=
 =?utf-8?B?bUFaSm85SEpCNy82aVlqZXNLUkZ1WlI1amsxdG1XRW1CT2ZmZHNXcUFvdGRL?=
 =?utf-8?B?ck1BT2EyYmFsdnFnd1lDU25GQSs5WVd3STZYUWxPTDlLRzBoa3RNUXRKVzN0?=
 =?utf-8?B?eWwydmhOZzNwYmJtQ1MxbE1pVWdzc1lkQk9OMXl1K2FrYWhLbHBvbi8yc0Ur?=
 =?utf-8?B?ZFgxQ0FGMkJlVHR0UDlLRkl2VFY0QWdabkZmTUdQSWZZQTFOOUtLNzlqQTh0?=
 =?utf-8?B?eFJZMXgrQnN2aExMVVpVQzdaTW9IMVhjMGIyVjE2Ui9JblVDMlNxWU9GSUdt?=
 =?utf-8?B?ZGxhZFFlcCt5YVdza3QrZ0tiTHNlbjRpWGNqZG5DbTBUOGlhdjRrd0JCcHhY?=
 =?utf-8?B?bXBNeWFpaXdZN0NEbmRlNlFnUjBaNko5RVI4UVhFc3o1cFpLS0JwWCtpQjYy?=
 =?utf-8?B?ZHI0U0VZd3UxaDdERkNUeVkrbHNZd0k5OTFQQitueHdrZnVCMmdWRGJuRWRX?=
 =?utf-8?B?SmlsQXhQY2lkOVhPeUxIK0xNS2N5YU9mVGZPWWtYZ1JCWEhRWWVkUHZSeGxj?=
 =?utf-8?B?bXV5Ymowc3hTd3NOT2xsNnRLVVU3SThmRnRnZGdvQUVJOUtidFQ4OG5UYSt4?=
 =?utf-8?B?eW9NTnhlWWZCSW82VzhCL1RkaCt2VlVwNGNwaU5maHZWWitTVkx4MDdCcUJq?=
 =?utf-8?B?Z0lCMWswc3ZoRGg0bUxVa3c1K0xyakFEQThBQWlVTncxNUpYVG9xUmhjOXd0?=
 =?utf-8?B?WG1XLzhWYXFldDg1eFo1SlZva0NYUXFKbmFQTDJQVGI0Mlp1blFZekx0L1lC?=
 =?utf-8?B?RkhHYUZoTVcrSERIUC9LYXE0QjU0Q2k4b2NOWS9aMzltTDQvWEhBbUFSREJF?=
 =?utf-8?B?OHcxSmk1aVBEaTVIQi9rZmpRODN0QUlmWWYyOVprZktuaGUvTkpyVm5oWTZM?=
 =?utf-8?B?VTI1TDRsbXJJZExnWVFXczJPUTRkbFloL1ZxT01KeTBtSGo1QkU3R00zbmpM?=
 =?utf-8?B?U1BtS21rNGplWTZ6U3M0Yk9FT05xa3BWSXhxcjV3NU5RdnBSc2VIeEtSelVq?=
 =?utf-8?B?bDdDWlZYMndpbFJzRVgvaDBVcGRqZDdxbHlpWnFuNFRqdXR5cXVycEN6ZkVv?=
 =?utf-8?B?cDQ0K3lUd3RRWWY0bFdvTVMwL1k2NXVSQit0Y3puM0VNTGZUbXNXM1pIdFVL?=
 =?utf-8?B?ZllMb2IwT3lOcGI3dEM4RHI1TitzRFdrMjlPWEFJVnRuSW1jTFMxb3duNUpH?=
 =?utf-8?B?aE5TL2dSc2tIVlVGcVJRbVdXY2VIelNlM2dsdys5a25jT0xaTlgwY2ZYQmMx?=
 =?utf-8?B?MGZTUmhId01GUllsa212THYzd2dRTGNOeFhJRXVndlJNRHBzV2JVNmo0Vkhk?=
 =?utf-8?B?THN3d01pT3V3PT0=?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:03:19.8759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d316ada9-15a3-42fb-8036-08dd7c15839f
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB5443
X-Proofpoint-GUID: eRkUwvRZTdMt1IeDfrrfteIcyw0M7gya
X-Proofpoint-ORIG-GUID: eRkUwvRZTdMt1IeDfrrfteIcyw0M7gya
X-Authority-Analysis: v=2.4 cv=OeuYDgTY c=1 sm=1 tr=0 ts=67fe4b0e cx=c_pps a=vIBLTX18KUGM0ea88UIWow==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10
 a=RWc_ulEos4gA:10 a=jE4wCpEYmYNN9sJuJygA:9 a=QEXdDO2ut3YA:10 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-Spam-Reason: safe

On 15/04/2025 12:51 pm, Thorsten Blum wrote:
> On 15. Apr 2025, at 12:56, Mark Brown wrote:
>> On Tue, Apr 15, 2025 at 11:03:55AM +0200, Thorsten Blum wrote:
>>> Add the __counted_by() compiler attribute to the flexible array member
>>> 'data' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
>>> CONFIG_FORTIFY_SOURCE.
>>
>> As documented in submitting-patches.rst please send patches to the
>> maintainers for the code you would like to change.  The normal kernel
>> workflow is that people apply patches from their inboxes, if they aren't
>> copied they are likely to not see the patch at all and it is much more
>> difficult to apply patches.
> 
> I just use whatever scripts/get_maintainer.pl outputs. Maybe the
> MAINTAINERS file should be updated?
> 
> Best,
> Thorsten
> 

MAINTAINERS only lists Takashi and Jaroslav as maintainers of
include/sound/*.

A separate section lists Mark as maintainer of a specific set of files
within include/sound/

I guess any files we put in include/sound that are for an ASoC driver
have to also be added to Mark's ASoC section of MAINTAINERS?
