Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7931A206F09;
	Mon, 24 Feb 2025 20:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740428037; cv=fail; b=HwkTbg8YFqNBTyJ0s5ZvRiHHYWZyFmVZwg7uMoLLLgqg2Y4EdWChgcMeC2k2tTe37bNRYss4X3hYWqnC7dkZVOK9cwO+zDAF/AH6c0naJ2AYlA/B9Lj9JrdprWlbxU0GnhNYc2bfkeT/bUn3hKk4x+w8glHDZm0O6JCx2qzR6aQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740428037; c=relaxed/simple;
	bh=aVDC8oluxmsSndU2z1Klz6zr8kjW1nB7kADIRrvsSP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uvcr8GTzvyZOyLxQS3/aWWSw6N74vlF1HgqkSSqayl+YZsw2DGPlC3Z487fHeriEWF7FuYxZmStTKra/JvbdwxeyHTfvLDwR80xxXtSGglKZq4zn57fb5oz7UUilLYYnsXAsLGyMjtBcvC5/kBq4r11lpR3YF+cqfLj+jNiZwNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zjmwt6Tj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vRsBhN0U; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zjmwt6Tj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vRsBhN0U"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OJXgQX014005;
	Mon, 24 Feb 2025 20:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=js2YZi/Dg1pwo4wvaRb0OwLgBrZtBZ/gEr7msAN3NW4=; b=
	Zjmwt6TjSsCyNghnnRtJdOsEa0Q/P5VSV/rJwkyHwC0eHPOGuyiW4NeXeDuZ9XHd
	ct2sFgSTLVcep3/RNaFKoX9zbflcJ+A9QLsE8Jp80GhCSal7ybgvnMp61myNLdNy
	IcbVbtTbsk85/1uJBuYwUqzaW8+0+W1VzKCN0QgWaskkPZKTmymuSc+fimomGhUE
	PGXS0FGvMXM/Id6hEbas3hr66FvGZrfyy4X+PC3svuQA/Je6CxMfi08TqudvbJFu
	G1lRTEKhH5FGFpr4nGpfxU3pc+Rmv11eLZ2PtBcinDFFv4Df0J5iWxpsuYFwaAtt
	QWELXrydqQiV13CEuDXe6w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y50bkgnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 20:13:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OJcrnF007528;
	Mon, 24 Feb 2025 20:13:07 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51e72v2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 20:13:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slJpWHyCW3SO4FrIIrimkcivXkaBRSriY7Nk41bRjs7lozAVyzz22v1yLgAz3WUqrEfTdbNXCpBM6KdIdJMffwklbd9BDZIT69n+iEOx0GKXWlHBzQtsoWFwrpqDQsxuBPPzeo4uWx5vHLzvudozIIDcae4qIhMio0zDpbeDKOw8N/mmv+eecQodM4d//t0v8y+XKl8jSp6/HCDdy0Tsc8lj3dyEqd0Ql1suf1RnqqPILONhU1eH/iL5Tjm150NHx0N2cnJZzrpuJBdWURI7FuztBX1ojrCiIS07tAzEBa4gvYj4Bw1viLi4r4vgUybh6WosDE4XNB7tzNDPuJhrag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=js2YZi/Dg1pwo4wvaRb0OwLgBrZtBZ/gEr7msAN3NW4=;
 b=dP8vEIV/hFYfdeQ0rLqX68tgxlLKBcsgHBcjOIEmi/D0ZrZFiK/u00Qc29QKQItn66HZqnPiOsufmVLUVY7VvqB7Qj8digP/+pqQ0hk0RzI358cdu633jWFDRq12RmIhJTTwNZa5Xv6YJkSDE4gJU8PIKYUhMFBEIBVjO1lb9tZtpRpUDLA4FBWg8TPJzloPXFGGcK4yFMhrH41qqY1RSwjC9AV8j2zNeRVVtv+CXgugsvkAjlk24Ck+GN18B4L+C92MbiV8CLuvXfbmGjjUdvqyO3oVWSxLACpBN3GG2vJyNbxExglj0VgvKWAICnZxlOc/I9oaE/A9pKoxYYoIVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=js2YZi/Dg1pwo4wvaRb0OwLgBrZtBZ/gEr7msAN3NW4=;
 b=vRsBhN0UyMsJfzekyYsM02fQq9AZAt4sKF6YXuLerENOesAXNzlaSzaMEj58lI3L2v47Esc+s3LbRjjRNIsyNQ6Fbtva0uEDE7Cdgt+HQuoSiOG244dqTuRXJmKvfYqgGR7PkRLIXkujlYXdegEApIEWwJfhEg54ytyyb8+Rhqo=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH3PR10MB7504.namprd10.prod.outlook.com (2603:10b6:610:164::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 20:12:54 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 20:12:54 +0000
Date: Mon, 24 Feb 2025 15:12:47 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        akpm@linux-foundation.org, jannh@google.com,
        torvalds@linux-foundation.org, vbabka@suse.cz,
        lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org,
        oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
        hch@lst.de, ojeda@kernel.org, thomas.weissschuh@linutronix.de,
        adobriyan@gmail.com, johannes@sipsolutions.net,
        pedro.falcato@gmail.com, hca@linux.ibm.com, willy@infradead.org,
        anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
        rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
        f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org,
        mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
        mike.rapoport@gmail.com
Subject: Re: [PATCH v6 1/7] mseal, system mappings: kernel config and header
 change
Message-ID: <krwnfnuhjmes4al5pquxax2khy7laurjnvvzntsrk7xpenoc7m@k24fekzllylc>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jeff Xu <jeffxu@chromium.org>, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@intel.com>, 
	akpm@linux-foundation.org, jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, hch@lst.de, 
	ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, willy@infradead.org, 
	anna-maria@linutronix.de, mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, 
	ardb@google.com, enh@google.com, rientjes@google.com, groeck@chromium.org, 
	mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
References: <20250224174513.3600914-1-jeffxu@google.com>
 <20250224174513.3600914-2-jeffxu@google.com>
 <443992d7-f694-4e46-b120-545350a5d598@intel.com>
 <CABi2SkVKhjShryG0K-NSjjBvGs0UOVsY-6MQVOuQCkfuph5K8Q@mail.gmail.com>
 <3nxcy7zshqxmjia7y6cyajeoclcxizkrhhsitji5ujbafbvhlu@7hqs6uodor56>
 <CABi2SkV-RwWjfXZfK4tHzQWG=dCJU7CRGmthSA8vqhHcbeCiQw@mail.gmail.com>
 <202502241123.D398A24@keescook>
 <CABi2SkXLdL37LxLuo+W=rUOrBKfMbxgkkR+s3TqnnS-eAQbakg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABi2SkXLdL37LxLuo+W=rUOrBKfMbxgkkR+s3TqnnS-eAQbakg@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0401.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::25) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH3PR10MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d1a2d28-a143-4b94-072b-08dd550f9f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NG10bHp0RTlSUFQxdHh3Z2EyZkRxS3hONEFHanFMUVNIaWwvWFdCRjZzWUZ1?=
 =?utf-8?B?bTJ3MzFNbHVncTZpZThVQUxLREtEQmswTG1yT0VEa1RsRUVINVZRMllpWG5C?=
 =?utf-8?B?SUh2QU5nQ2FLVnlTbmtBYVVxVCtTYSsxWDRxclFUakhTSWpiWE5uZ1hrd2U1?=
 =?utf-8?B?WXZJODgrTGJhZWs2bFlUdUpoVStacS9PYWR1K1FiTXdRNFlHblFxUzBSM2ZZ?=
 =?utf-8?B?aXJlcWJJOXdUOVJmY3ZYRmlBcGk3ZVhHVEN4dnY1UHFoMGhoR25Oa3k4UE9a?=
 =?utf-8?B?Y3hzalpVZzU3cWxYQ1lXOVl2N1Y3NEtGSjRlWXNTV09SZ3I3Y0pSTzZRLzkz?=
 =?utf-8?B?OXNYaGkzK2U3QVFtTTJKU1ZQZ3krL0RESVloUm54SEFmT3M1SHVOU0ErSTRD?=
 =?utf-8?B?WHdzc09DVmhJWkcrUnhla3ZFaHFjQUJHa1J5RzFpOWhxQlUwS3NMUmwxWG53?=
 =?utf-8?B?S2hxQWNVbG00RU1ydHIrSW4xOWNqdlpvRVJScmdJUTA1b0hqRlFwc2Z5M3kw?=
 =?utf-8?B?Q0ZGcHBhVVhVeTFpVGdNRGYzdUFXS0xBRXorVFJwUFlIWFpYUUJVQnZFcjVF?=
 =?utf-8?B?aEVTNDhscm9TUE9Ocys0ZGdRekMwcjZ4clFjY1BxYkZTSUNvbFpIdzBSVkNo?=
 =?utf-8?B?T09zZXJWMFUyZThlSzg5aWxiOUkxbTJGVFZ4dDdZWUlaNkp2eStEbzdTeUZq?=
 =?utf-8?B?V3hKUnIzWFJ3RGZwWnZUcEtWOUJrWEY4bmFoSXZMcnc5aytTRzVGT0FLeTdx?=
 =?utf-8?B?M0R2U3NpUEovM053ODl3OEZIVk5tajJISVhuZ2sxdWpyQk90L0hMWmxWbTkx?=
 =?utf-8?B?MEdKSkJNL0U0ME1aK2ozRXZCMldLNzhhTXk2ZmZFRnFyNEs2Q1E5MWlRSG1X?=
 =?utf-8?B?REZvWnBZTmNFVEpmWWpzZ0U1RGU1NGxZUkl0RHRyOWdJOUdGazVnSUFKN2ov?=
 =?utf-8?B?TElTZ3pEcTExVTVMendmUWF3c3RFcXB3R1hHYnhEaWo1Y1RMSkNOU1Q0Vktz?=
 =?utf-8?B?Nkpvb0dUTUlVYkR0WWM4ajlhYjBIakZhWlkzYVFpL3RKL0lvUXorTGNwWWp4?=
 =?utf-8?B?VVVFb3cxWWxaejBTeDlLSGgzYWFiQkF1VitTcG55YXZjcEFtcXNuai8vK2FS?=
 =?utf-8?B?RFJYTEEzUlJ1RldOa291UUZFT0IrMVpodW92SC9XaG5Ya0VPeHczWU13UXlp?=
 =?utf-8?B?TUVoZ1libisxcmpUR2IvelpkejMwNDV4VkMzbHROTzB5UzFDZFh3dUpuekQ1?=
 =?utf-8?B?QlRMbGdTYTcweWdMcmU0SDJpbVFlNC9QNEVMaG1FTDRhOUJWUFhtMzRuMzJZ?=
 =?utf-8?B?R0xRUjZsK25aL1dEVnBDMy9yMUdCZG9uQ2o5QVZGSlYydTVqdnZ2TUl4Umlz?=
 =?utf-8?B?ZTBMdXNqQ056bW9RakMyV3N2Mm9TdkY3ZC8wNTYrbDJDNFpML2U4UW04RkVF?=
 =?utf-8?B?dzRBemJMU0N5MG1Ib1hvWEdRd1U1M1VNN1RLaG9OdjcySit3ZTZGNmNwVlU3?=
 =?utf-8?B?TW1kRFdJNlFhd3B5ZVdmdFhPeDVvUGV2TFFtaXB6dEZoWERCaGZVdk5KNDAw?=
 =?utf-8?B?N0I1Nm1Bd0pMUnlsOEFCYWpBaHNIRWhCNHAxOCtIV1JaVDhkcExzWmo0Y21m?=
 =?utf-8?B?ejVrU0I4VzlkWEowY0JUSkdrM2xLTkR3NHFZRXI5Y0F1MURvRkhkUWwwNmhp?=
 =?utf-8?B?V2xObTNNczdHT1J6UnhnZlc3SGFFMU5tWElHTmlWcHB4cUlGM0wvOXpiUEtD?=
 =?utf-8?B?K2ZtM3FrV1lIYVNjUVZUS1hldEg5aWNRRkdQMHBOek9PYlZOd2l1YnQ1bURL?=
 =?utf-8?B?NmN0SmxqbC9UeEpVaGVMSU1pWkJwdGNpZU5mdWptTlVZZ21rNjV0MzFXMjZJ?=
 =?utf-8?Q?rshgsRl6xyqTb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTEwWkhjM1VpQmtPOEE0cWVKclBCSHNPNWVBcmZlQzR1Y25LKy9pbGt4K0Mv?=
 =?utf-8?B?aVNSQTE3MlovcUZveDRhOTRzVVJGcklqRFgrR3g4eElCZXVXZDFRdENtM0l5?=
 =?utf-8?B?TEVITXNmZG9Ecmx0RG5IQWFxM0VFYlVtWUhuYitUeERvYnF4amc0NGJsc2tR?=
 =?utf-8?B?Ny80OHBEam9BZlpMdnEvcHpMYnF1MSt6TDc3TzdrMnZEcVRwbXc5enJiN3BY?=
 =?utf-8?B?TW5qUFByK3ZBYUVwWnBna1pIRXRkRzdITEFpT09WTEhuZU1ZNE9vaHM4UzZP?=
 =?utf-8?B?Ym9XdjF6TkJNRTNORlRsYWliWngyUnhlN3dsZGhzZkI5cjV5S0YwdThiYXo4?=
 =?utf-8?B?SDJXUERmdTZicG8zTm51b042T0RTWmNXN28wRy83dWpDNEkwMmlUOHNXNy83?=
 =?utf-8?B?SDB3NkJUU2hyWTBzVHRyQ2lTQWVwZjV3NEpycGZEb1F2c05FMmdTWnJrUmtS?=
 =?utf-8?B?Rk8vS3lQYmU0TG9YdTl1TGVJWlZoNVorejdtUTBmTkJDa1Y1R29MQ29UOXpy?=
 =?utf-8?B?K2RiRlR3ZytoSEVFOURtbzk5VmZoU29JQXVBNVRCaFVkZkQ4QVhic3dUVGE5?=
 =?utf-8?B?dERaUXU4Z095N0U4MjNnS2plR25CZVFvV1VuZVRFY3BhV2Z6bWZlUk9kUFJk?=
 =?utf-8?B?K21ZNXBUdUd4Tm9sNUV6dE56eE5ZYnVsd3VOVWJxZVgvOHpmTE9qVlZYWnBr?=
 =?utf-8?B?eXd1bnlzQk8rZDQ4Zm5XT0FsK0NTOTVhTmRBWDlOOGlISE54bCtvVnZmUG9F?=
 =?utf-8?B?N3p6aUphT1VhR0UyVUZtTXFLcXg5SFM1Y2ZzODlabDhITjEyK09OZnBNbFBN?=
 =?utf-8?B?K1JqTm1NMkhqVlNIVU1wMFUrM043MjFPd3h0c3l3aEFGRUlLSlUvTC9hbFlJ?=
 =?utf-8?B?bkRhVlpMS09QeDJrZTJTbnF4KzhyN1ZRTU1lOTBUVlZtZDg0b00yUFZlYyt6?=
 =?utf-8?B?NzJlZlcxVDUvVjg4OWpjRDN1SllRblltNjBpVlFVWHFGaW1RL3o0M3AvSG9M?=
 =?utf-8?B?bW45THVxbnluRzRmSXRDQ3dCc3hzb20rR3hxRHFRZkNrdkY3YnRYbEZNeU5u?=
 =?utf-8?B?WE8zOGd6elVMSEtNdmkrTk5hOXF2b05QeEJzMnU0azJJKzg4b3BxYWxKYk5T?=
 =?utf-8?B?N3g4Vy9BV0hIUVpsYlFKYVJsbUI5eWRWOURYRnJlZHpUY0N5Zm01SEM3cHpy?=
 =?utf-8?B?MmVrYlNtNnVVSUQ3VCtZblNMMXRhS2JBazA4dzUramRvN2lOWGRLZFo2ekVk?=
 =?utf-8?B?ZUVJRkFLeTlRdStsaGlzQ0FuK01oeFR1MWRYa3djVG1uRnlSUjI3VnVBamJW?=
 =?utf-8?B?a1dJbGo5bkF1aFVGQWtUdHc3Rkwrejg4RFIwcS9KNU9pL0VwKzRBWVF3SHZQ?=
 =?utf-8?B?ZUhadFp3bDhydU1OWElLYUNzL3kyNHptVzBRK0ZXSTV4dysweTM2dVY4akt6?=
 =?utf-8?B?WjhPKzlwM2lhV0ZmY2poeDVVQmxYWkVrY211R1VIajhqTnpQVHVyOW5oSU5O?=
 =?utf-8?B?S3hqT0ZaT05PWnk5TzJacitPeWwrTjBzcXprUWdqbGZMOTlRUGJTTjhSNEZQ?=
 =?utf-8?B?WlR1WEU4Z1NlUGwzcjRtcVZreG1Zb0FuRUNNcllPNVVQdW9yc2lUNFJCOU9Q?=
 =?utf-8?B?SVpKWG9qaFJRcXgyamsxaVhxcVFEb3BXdGlUWWJ0TGJNaC9WOTI3ZWlkYXhN?=
 =?utf-8?B?RUpJVEN3b3lvTnlWQVBaaFZES3NCR2RRc01OQksrcnpDTXQranpCWGV6KzFn?=
 =?utf-8?B?ejdCQW5XVXlzREVUZnJnQU9lL2lFbG1CZDRhRlN3MG9zUThGQ3A1Y1pXTGJQ?=
 =?utf-8?B?TU5sMUtxbTVqam8zR3pSdWhham5lSkdUUEJTSXBZVmkvM3RkN28vQUVBS3A0?=
 =?utf-8?B?Skl4ZTF1dklOZXgxODJ0ZHp6dGNkMmlEVzlSN1YzTGxiQ01Kdld1WFM3Q1FI?=
 =?utf-8?B?cmF1a2N1Q003K0tuQ3JGVzB4MUUycXg3ME1TdUd2ZTkxTlhHZTZLZUNlSTZF?=
 =?utf-8?B?eDhRWU4raHpHcjZKVE52VUJ1bnZ5Q2l6QVR0Qjlpc2ViZDAzbE1lZTNGZjNj?=
 =?utf-8?B?SERIaG1sSU14ZEg4TXJncWJrTTBXRG5ZemozcXdOejhpcnBZMGFYbEJBQ2gr?=
 =?utf-8?Q?zV77j9uFsl57I6E218/cnwKDM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C4jlXim5m/lSs0F7eDGA6eUA64F3ElHECeyNp5s+u9uAXX5khXvMDU7niq4CeT5YuKWFk2slbT8TbXypqwXQJpi9LCyUTLrESEzzxqhPFUat7B7UaswsGWc7LADU7LOOCyS0L0oTB7Y0b4XaXiieb5r9wTi0Wy1shUFAOJ+IAx+WdRB/VOb5lc7k2qdM8QXfcsFeyZ0yzaXAEo3MsS1xlzartUrLmzPb46KZB0VJlAKxkFE3RQIDsh5D4MENyadg+0d1e8VMRo999H7HvE82HdXpj4R+Wwbe5fsvEwsCTNGqZ/F3S8NXNr0h1Hzhk/q4mB7j4VjKcjRwHga+kCccheUxHMmjogVSp1FRiZsj6BkbO0cs++GBGFGe4ArBC9bEKfG7GaNBDcZBCEq7DFgLLW3sel1Uu52uMJi3YxB+M1GHN5OsMdy5o4dIooKQeoZK7uPMUQCatKteQwvwkLdc193R0aGAFmKiX9unnGUt5jhcqzZZfHI5IlwAmUL8L6kYQ/aXXxn7lxfQ9u4KT5ibBsYnm20OgCEBHaKdsHPHlGqHvRTj/+yCjhnDPUTWJlcgWFoUfL6mOY/Qm3RXWWtc4Y34UJV94AO4vYV7Yj4AXC0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1a2d28-a143-4b94-072b-08dd550f9f36
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 20:12:54.1912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1axUQf1TjhNwCN8VRlv9Uz3OIq+UGEFETCFd08l7il5m8uSRNMLuTYn5/dWCnmguweruPa5N/MKE/JMUNxF4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7504
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_09,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240129
X-Proofpoint-ORIG-GUID: YbQZEElTtmEFMOCNOFNgBDI_hPRUaK-S
X-Proofpoint-GUID: YbQZEElTtmEFMOCNOFNgBDI_hPRUaK-S

* Jeff Xu <jeffxu@chromium.org> [250224 14:42]:
> On Mon, Feb 24, 2025 at 11:25=E2=80=AFAM Kees Cook <kees@kernel.org> wrot=
e:
> >
> > On Mon, Feb 24, 2025 at 11:10:22AM -0800, Jeff Xu wrote:
> > > On Mon, Feb 24, 2025 at 11:03=E2=80=AFAM Liam R. Howlett
> > > <Liam.Howlett@oracle.com> wrote:
> > > >
> > > > * Jeff Xu <jeffxu@chromium.org> [250224 13:44]:
> > > > > On Mon, Feb 24, 2025 at 10:21=E2=80=AFAM Dave Hansen <dave.hansen=
@intel.com> wrote:
> > > > > >
> > > > > > On 2/24/25 09:45, jeffxu@chromium.org wrote:
> > > > > > > +/*
> > > > > > > + * mseal of userspace process's system mappings.
> > > > > > > + */
> > > > > > > +#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> > > > > > > +#define MSEAL_SYSTEM_MAPPINGS_VM_FLAG        VM_SEALED
> > > > > > > +#else
> > > > > > > +#define MSEAL_SYSTEM_MAPPINGS_VM_FLAG        VM_NONE
> > > > > > > +#endif
> > > > > >
> > > > > > This ends up looking pretty wonky in practice:
> > > > > >
> > > > > > > +     vm_flags =3D VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|VM_PF=
NMAP;
> > > > > > > +     vm_flags |=3D MSEAL_SYSTEM_MAPPINGS_VM_FLAG;
> > > > > >
> > > > > > because MSEAL_SYSTEM_MAPPINGS_VM_FLAG is so much different from=
 the
> > > > > > other ones.
> > > > > >
> > > > > > Would it really hurt to have
> > > > > >
> > > > > >  #ifdef CONFIG_64BIT
> > > > > >  /* VM is sealed, in vm_flags */
> > > > > >  #define VM_SEALED       _BITUL(63)
> > > > > > +#else
> > > > > > +#define VM_SEALED       VM_NONE
> > > > > >  #endif
> > > > > >
> > > > > > ?
> > > > > >
> > > > > VM_SEALED isn't defined in 32-bit systems, and mseal.c isn't part=
 of
> > > > > the build. This is intentional. Any 32-bit code trying to use the
> > > > > sealing function or the VM_SEALED flag will immediately fail
> > > > > compilation. This makes it easier to identify incorrect usage.
> > > > >
> > > >
> > > > The reason that two #defines are needed is because you can have mse=
al
> > > > enabled while not sealing system mappings, so for this to be clean =
we
> > > > need two defines.
> > > >
> > > > However MSEAL_SYSTEM_MAPPINGS_VM_FLAG, is _way_ too long, in my opi=
nion.
> > > > Keeping with "VM_SEALED" I'd suggest "VM_SYSTEM_SEALED".
> > > >
> > > How about MSEAL_SYSTME_MAPPINGS as Kees suggested ?
> > >
> > > The VM_SYSTEM_SEALED doesn't have the MSEAL key or the MAPPING, so it
> > > might take longer for the new reader to understand what it is.
> >
> > I think to address Dave's concern, it should start with "VM_". We use
> > "SEAL" already with VM_SEALED, so the "M" in "MSEAL" may be redundant,
> > and to clarify the system mapping, how avout VM_SEAL_SYSMAP  ? That
> > capture's, hopefully, Dave, Liam, and your thoughts about the naming?
> >
> Liam had a comment in the previous version, asking everything related
> with mseal() to have the MSEAL keyword, that is why KCONFIG change has
> MSEAL.
>=20
> How about VM_MSEAL_SYSMAP ?

I don't recall if it was this set or previous ones, but seal is becoming
overloaded and having mseal would have been good for this one.

VM_MSEAL does gain more greping, but since we have VM_SEALED,
VM_SEAL_SYSMAP is going to show up on VM_SEAL grep, but not VM_SEALED
greps.  Maybe VM_SEALED_SYSMAP would be better for searching.

Thanks,
Liam


