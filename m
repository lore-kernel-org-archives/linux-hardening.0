Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF1D3BB9FD;
	Fri, 18 Sep 2026 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742886; cv=fail; b=E96eGdtv6/pCtfxI8RU5+kVdUymWwvOqF6na/HKMRyeuPN5TMVumGratER8kGUXGwlGxYyBe7i28/JimTUaRjG4iks1AGteSHUTdihkw+ICDuu5PcwQVa4pmFtyTE7lmIvtMSy9Yi4uBcy7zUCNYm4gp96jgfi22laZdaUaznvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742886; c=relaxed/simple;
	bh=+KB0P6GMwMSfDS5+xByde/4pSqUTiJnj22ELvxAmDi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwUWjRrefxbs1bEnVmBPKIBcUMUcQImSzUsXrKwwWYmX2pozBSh+YkR3daCh506pO6TlQcYDRoKcrUJOz95WxlApZOF8sM1UX1gcbewWdCbjdMS161Ja4J3knx/8bqiwTHKrfKs2cLnkht3NEcVRJ+HurcI0NHkthjeicNdmPO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=RAimk24f; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=iAZiT4NU; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="RAimk24f";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="iAZiT4NU"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IEG0ie2847331;
	Fri, 18 Sep 2026 09:47:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=dSXqngqpC6FdhBBiCS
	F4KYBvrqb+DDrHvuS3pK1F90I=; b=RAimk24fkAIJGGOBMsVW5vTWl3mynA2J5X
	4XiOUuXhawQSOu/X2sWZvnZ5A+vkX4xIFdvqwY/LhKc0o3hsypSpi4nTc0QQUbMh
	kJ7IG48YEevOaLLorys+ERBE8lececwL2ay/Yb4BIGV04WsLlRW+SRgG5LpUOWRT
	erjlMMwREC4/LS2WdpratgiznA8Sf8NgF1i1TnN0BZGAmQ17GarzEXPSnLKm2i0A
	SqlHnk/C4eQCliUl8d1BnWAXy4V/St3BNkOODIl8zh9s2QYPzKtXYzj957y3jOWl
	ixJn0Ozb8BVlMwARMvg58FXPGC+21qFgtFZs7pbx8hRHuJ4n/lwQ==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11021074.outbound.protection.outlook.com [52.101.57.74])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4gregu2fmr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 09:47:52 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=plcomMIv5jdURoyisDlvkB8yGYqUPkyXsmyG7r2LY9SflKmkZRv/Sc871o4JeD6/Elsk3C/O06+TWv40zdpDUcj8w8VDMDHI0Q+NT6PDjUiJXiA8StE+M0+Zl8q8C3NFKyD1LWaxeF3KGcrjY7LlRFG2PfgEEp/3TLUornz9kwibkigr0sSXbq22dGHd+BFO9UkuvjJqPsq5oq8JwUAh0v8Zqv+KZ7sthnPzSjflo2kOS4qT0qYjrkNohXIaYPnAR1NerdY3cnasiV/JNhflGnIXGPTVGh+2foamn0+s1XS40WqMvYdnoKXh9+I8oGJFAQfHJLYNkgQD2uEm1yhS6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSXqngqpC6FdhBBiCSF4KYBvrqb+DDrHvuS3pK1F90I=;
 b=A/3vw/x/R3gHI3X0CwQOEvDBDDzouKbQD7FFdN/nnQDGR6Bk1QnaydNMg6MmkiuVMVOxnulqMawQytTeWuuqu+xBpFCV+SNqCOgbgEUH9zvKJOL9fYQGGoYg3fx2ok3xy+vxM4AzK9zRRBdpQLnOAvdiOPlCeiMgAw+qveY03PzG3fDk4E31sRJEKHBAgNV7YFS5jMH7CFplIMlIfx+11VW01pcVi3hxm1pudqPYB+TCOK7hDSZp0Vt/plxbmQozdbpN1p1UY8rfEVUMSQHdnMtg8QJemQoON93t1bs0Nv9nkI1JgcS9HcDv715fakKkCgC1ijT3eyBmlbj5HkDH/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSXqngqpC6FdhBBiCSF4KYBvrqb+DDrHvuS3pK1F90I=;
 b=iAZiT4NUWvvkruw5DxRUCEpf5XJK3tqrk5QV9nCNBLRrO2x6FHA+LzOU95qjeuOI3HX2ikOsbH8cig7yY8Xp63PxGRuOWGTxEVR8F/FuhP+qhFaS6bEw+j/Y8+ehXlXHXvuxywC2hAvBSd4MWi80mnHTaTzDWudqTP8WSghhVSM=
Received: from CH0PR03CA0386.namprd03.prod.outlook.com (2603:10b6:610:119::29)
 by DM6PR19MB4278.namprd19.prod.outlook.com (2603:10b6:5:2b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.16; Fri, 18 Sep
 2026 14:47:43 +0000
Received: from LV8PEPF0000005B.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::8) by CH0PR03CA0386.outlook.office365.com
 (2603:10b6:610:119::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 14:47:43 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 LV8PEPF0000005B.mail.protection.outlook.com (10.167.245.136) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 18 Sep 2026 14:47:42 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 8912F406542;
	Fri, 18 Sep 2026 14:47:41 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 6FD3582254B;
	Fri, 18 Sep 2026 14:47:41 +0000 (UTC)
Date: Fri, 18 Sep 2026 15:47:40 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Kees Cook <kees@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Kees Cook <kees+treewide@kernel.org>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        bui duc phuc <phucduc.bui@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, patches@opensource.cirrus.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ASoC: codecs: wm8958: Add const to enum texts allocation
 types
Message-ID: <aq1PDJZIGKiRBbc7@opensource.cirrus.com>
References: <20260917211102.i.029-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917211102.i.029-kees@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005B:EE_|DM6PR19MB4278:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d74d47b-62c4-4791-d771-08df1593cbb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|23010399003|7416014|376014|82310400026|36860700016|16102099003|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	SE5X2JR3xRjBqtu7N60boJRLTcpc1OkgSlsOudS9SHwL9jboFalLXgjHs2l19LRDRl12rXDWoOp+tTH2d7dH+0qD1zqyY8ONePk21PVUTwOzSWPA5EVF/Iw9OlmV1RLncasvzjsZVbe6fIM5VVDcjZb6v+F/0wgrosb19tTtn2L+CYqulVv5x3qz1CHgrhRbfAhgy5MtC0zn4BaiXyGSZgS4rp3FKMVfMea3J2jgQyQIBzE4wytMZ+pHaEQgI6cK5hQwxQkQujb2BFMBMsO90VXih41CnAYhmYqqm2L5WS9zWznpiOHZFNuET1medvC5jqbbY3hix5t+vCaDamPjhof1nRb72+Er12TScvkL8M/yTiYYylSaul21XweP96gR7O7nJ1IVPEP55SBt5unVHgfLWhDBNKEFWk6K9DuIvTKxG25nDBIoh7jljx4yLk/tPgVig1XixL3uEq8HQovBuQyhSxowKqMZZ12xHmQmpEyaNeapWrazCmmbe/8m8fLWgvi3F1iDZTS5RFCM0kBkJFIhkssYuhCqE7hxVl+H6dnP/4lNC8zav7OvBBNFG1AnsLhQJm10YY0OGxHki+JcRVJbvb5sR3wV0DQMj6CdJixLa3nu2K2AIk3B5xe3yEQZSYal+ghvXwlq80d8w8ZAHp9zFjzvJAKZ7yYA3qHYphonXKJ+Gz/pfX+I9GpjLLiCjLTRQttoHGQr+uXHNkfKuw==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(23010399003)(7416014)(376014)(82310400026)(36860700016)(16102099003)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JaT+VvYsNzHcUqyuCkB8Kot2ZO2WTry6JB3COW5uDbPgHbgKZiFFYhdrSiaWVjnROA8iLDS+YzLtkNUFteYOKBU7iLrL+YmIebUyoEV4BFJ49Hqo7IwIL8RlPcIc0hV/0HZ4DW0e/J48M3X8TmB2dTPLqnaUKf3ZzPVjLs0V+MbJl2L/pEPo+PxsP0W87lI6VMWNuO/YhpTrJnvEl8+LGmoOvm/K8K56ynVDIux5L7oLilAUd7Uz3CupOzFwTR3nLbjwnljNmXd15yvXLaXROD/TGEOG79cxExINc8eO/XKJlAhurPqnwY2doq14OBHnvWqDQAwMJDN0aIO/ResbO6tv6Z0j+eiYPEeJ4olJEPcmOPZdrHMo+NHLbMccV24sLvmp2jN/AJS1Kfr3XeLlIHjzM9KBfwpi949pN5gtx7jlPvPR9ELfqg8CQ0YG5GgK
X-Exchange-RoutingPolicyChecked:
	AyXj+xJnEORD3hjHrEMMtuCgnmn4Oc/xeIqPQw94/6m+3pOrNtran49y8TtuUUA+tXp9flqTtlSCz7UQPolHmT48QJ66wNbdIVGQUQ4/Yt56L/fNyk8BQrX5sVOTY+5dljnG1AtyFOtYW66ttNwGgaUisyOzdIjyAhlfmRk6QDNyC8iijnrpmC7cLyJ3eV/hzj/kuCkFihRyreNSfMp1fnfaYeEDMqUASOG0JqgWqXCU4O7iAW1YTDx2P3iV1SMYnS9C5X3T70zcqoqA6RCIEnYCPPI6++hYh9f38QELUbcAG4BlJCMX2mQMtkKsWctj+VTslcN+b18vhboDZxrHyw==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 14:47:42.9995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d74d47b-62c4-4791-d771-08df1593cbb8
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-LV8PEPF0000005B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4278
X-Authority-Analysis: v=2.4 cv=f8Ddl+yM c=1 sm=1 tr=0 ts=6aad4f18 cx=c_pps
 a=Tuw7gsdFDcWj5yiUab7xvg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=VwQbUJbxAAAA:8 a=w1d2syhTAAAA:8 a=Vo0kk2fU13m795__YKEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxMCBTYWx0ZWRfX/9irbNkGSOD8
 e/g2x+oeXEYkRqTO2dIuiNYobME4zKfrh6qwnYKl4I0hPMH1OckFPoiAFN0scdJQ6+vWlftWhmU
 Hiw7GrfJv7YFEvpySVJbfSLy2f3WBJY=
X-Proofpoint-GUID: 5-rUh72R0FeF-j7b7utDzEoPcgba9D4N
X-Proofpoint-ORIG-GUID: 5-rUh72R0FeF-j7b7utDzEoPcgba9D4N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxMCBTYWx0ZWRfX8fjNCjWpVEdX
 DFIbgXNl+xS6Evi4rOnP+GTwmVVWDZb22gKTLPeiB42r/VQS8lU26amxV5MmwfkR3Lp8/FNEWA1
 EwVJwSiQ5a0RzgBZmsfm0SgwV2hHQYD3MWY+TmOLMtnyFSMlvzUSjXluTQxDg2FetQHaj+I8jJx
 i0WrC6QxKVbX30z3J9tlra4T+BVRKbZoG+1EFWF5V1AqoqAXUU8TS7J7TMy8cRHxJvclgLdH3Ss
 aFM4Y2F/KK2ct4q7GXweprkFSx4H3F4U8nwIvfvLBjhxd2fc1APwb0+2urwA2ZtFun/CzMEjGSI
 +wupJ6qF1RoOpKhMYfJasURH7HxXudhpIv2aBh11hCX5vCJJcbi1fHV9m9BEB1ODHwWQMinsEJM
 mFSAldql2dFcbG4i5hSuaT1iEXJPsACJxWwuFsWVj1v3bO2fWEBK/rAaASlNUzCIWChhyztTslk
 ek7Om9CzUkg5FkXBfSw==
X-Proofpoint-Spam-Reason: safe

On Thu, Sep 17, 2026 at 02:11:03PM -0700, Kees Cook wrote:
> From: Kees Cook <kees+treewide@kernel.org>
> 
> In preparation for converting the kmalloc family of allocators to the
> type-aware kmalloc_obj family, we need to make sure that the returned
> type from the allocation matches the type of the variable being
> assigned. (The kmalloc family returns "void *", which can be implicitly
> cast to any pointer type.)
> 
> The assigned types of mbc_texts, vss_texts, vss_hpf_texts, and
> enh_eq_texts are "const char **", but the converted allocation types
> would be "char **", which is the same type without the const qualifier.
> As there is no general way to safely add const qualifiers, take the
> sizes from the assignment targets instead. No change in allocation size
> results.
> 
> Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
> sound/soc/codecs/wm8958-dsp2.o
> 
> Assisted-by: LLM coccinelle
> Signed-off-by: Kees Cook <kees+treewide@kernel.org>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
