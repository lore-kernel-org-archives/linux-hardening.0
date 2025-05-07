Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A5B19E96D;
	Wed,  7 May 2025 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746634960; cv=fail; b=OTuhapizS9vVia+oNdkPeZ5Gj1aWfZGECSkHiPlEHPd+Fes/Q0oQPScHssLBWDUlMmBzlSgPygcKzR71MMYdWxq0zH3nGuYM2lIUXuHoHsXuQuKmZpvcHOHb3idzBzd9FU7Iq4NWfNSs79CmWFDdpxqIJR87/Xw0LuUCkTKvdAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746634960; c=relaxed/simple;
	bh=qkLS5//ROVVhyeZA8QhGDyGFSaeXD8sPLrqWt0jJ2O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZQjtBGSjmeqwbhdW3CrCiwBOwzIPvjL0jXPB/W3Qvl2xZUDs4AzWXZmRbSUB5v8ZrZd8S4QlPML6TQhvnHHQ0/XRTtmXVMwjiYCjtbE/bnkuSaifhOeavAkRagD8BhPbhDK7YMtyyogvI9J1y1O7DmkJVbU29Q+0yQsLyhyXFVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BJ8h4sxy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y2T7gOCj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BJ8h4sxy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y2T7gOCj"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547GBuD2031947;
	Wed, 7 May 2025 16:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=iZ/Pfc8aQVOskF145wVEDHf6cBd8RKkaz16uNLm0PK0=; b=
	BJ8h4sxyjYJDgpiP1WJ+jofQ3s5j76w/yW5g/EGCPFM9YgskGDH6IxnmVjqMw8jo
	d6W4eLtL8AggFy8enFH7jdDVDZ8EO2EyRNN7rg+F6slvuBWx4XupW5PGvB0BKZul
	UljeEaSpSP+ZdVyiQWMNp5yKV5yz3LZ0hDJ5lWwEXhoSWi8ZIVW3Tj1qU14PlsD9
	RXL1Q+/7nDFGZRIcIxI9y0PhlGtuqPG7uaeHGPPxOXUAnxunEqjSqkE161FlD1h9
	lM0PsNjTfPWgpZpsbms29RhagcEdVV1XfR91SnXsrtgSMnDqs4Z0Z7pGEteTtI9G
	l2oxBkOXQdHyfXHT5Cmnow==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46gardg1gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 16:22:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 547F5G2S024474;
	Wed, 7 May 2025 16:22:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kgvfen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 16:22:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHf9xvyQrpaElOf2gaLyxmuGkELfEYVadkCPjWuK6xT8PxDnV0ZY7lckNfWbUkfxw141WEH9ncCRJwg+BHB4fD/AjH5IkxBWtygfcA6WPsb7MVn9HSK342eF7vjnYcBHBj/j9+pFLn/np0Z2a3bVlddKoJKyjUOPLQRy+sq2miPLbNYJf5OGAiMnycqozE6sL3iU4UeUap/AxIPVPt0xuVosaJVywu2F1+AhDaT7gJDlJBbwAGWvp5kKWVkTnGjEaIpKR1J+5jPkSUfqKOET9Mfeq+Xy0DSCXqhtlHkRGTusGf6u9rYVSIFhiXaGi/I+okxtDnMfAcxNqsB5rSehyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZ/Pfc8aQVOskF145wVEDHf6cBd8RKkaz16uNLm0PK0=;
 b=E/IPwTk8mLrFf5NuL52z8qatCfzvjDkgkL2EuL1kXq9J/aGr28cu6d8CTBqa+87gmUAvIwNq0/Jl+7LeqdbcnPP2O/J8Z8XH2GNUsCaYHJZTNLMbCCekEy5vPRimZuWYyQoWJRY84T8uTfi4NpC61XriLFJFmUB0fYLCM2xprgls3tNKXEYe+gQZCGOV9pRh5QyGctxt8AXYSvkWtD1UuIJASdyrsjXMIW0e/IJle/+D6ftZX5HodSqrg7mNXRrg/CnpHA/Mpdc0c5PzWrrN7LqawENg9DNiI5oGLHcFs9D2UYBWj4BMnM4ZndqfKUoKOxGPJX4jeDpTDabUCCVWGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZ/Pfc8aQVOskF145wVEDHf6cBd8RKkaz16uNLm0PK0=;
 b=y2T7gOCjcKQw2tIhvY6JlS0kwmbsrYPNipCQz8NvPnHzeMVNQps9iOiiTDShqc/CzzrkOPnw6Dop/5Z28ANCTn589niC7pIyArv5tT6rATJP6+Ray9wA1L8CS+XxwEMhI1LQM+gfdYrWsuU64ruV2AK2ivf7EQyJekDd3drdsa8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB6986.namprd10.prod.outlook.com (2603:10b6:510:27e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Wed, 7 May
 2025 16:22:12 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 16:22:12 +0000
Date: Wed, 7 May 2025 17:22:09 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Jisheng Zhang <jszhang@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Kees Cook <kees@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] riscv: enable mseal sysmap for RV64
Message-ID: <5e7f2acd-2eef-4e69-9c11-ba8d1ec0bbc5@lucifer.local>
References: <20250426135954.5614-1-jszhang@kernel.org>
 <CABi2SkXJgeLLYQEp1c7EepYzpGU+d0TsOZ5ix6PUUmJLuHyvwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkXJgeLLYQEp1c7EepYzpGU+d0TsOZ5ix6PUUmJLuHyvwQ@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0073.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 1400c34f-5aac-4b1e-ee99-08dd8d8352ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UC9DTGNvVkJtRFFPdVZ5ZVd2ejc3QkZSOVdSNDhFVXZOdS9lODN5bFpFTGZw?=
 =?utf-8?B?T3V5MXFCNmtFRGpDTTQ2SG5OeHhuOWRiN2RxaXZRcFZNQm51bTFFRjFTVzU5?=
 =?utf-8?B?Q3Irenk5OW9mS09sbTU5ODdCMEhmaFNLek9FR0t1dEk1R0ZuaXFiYkV5dEJJ?=
 =?utf-8?B?UHp5OUlrRVhZOFMvNkQ3WE45SVJhYWRFZCt6cFVKYytmcFU1dmp2dG94N1k5?=
 =?utf-8?B?eGZMK3JUem01WnNIRllCeGsrNmwxYkYrL0VZZVRkZzBvRDJjU0lETmJCenFw?=
 =?utf-8?B?UVZsZ1hSUXhtVnRQSVhNbGVPUWpEUFMrcm1EbGQvdjJ1aUR4UzJlRUU5Z3VF?=
 =?utf-8?B?VFc5Z2M1OTE2ZG92eW1GQnhxMjhCZnJqOFVSWTZMeTRBU0FHbFB1OTRSUHcv?=
 =?utf-8?B?TTZuQ21RMm5peEVCM0M5b2N2OVMwdE1XMm1VMHJ4LytVa3JVME5WSVdPdmVo?=
 =?utf-8?B?TnNKUjFhRHB0U2IvMGRsT0FWaE94dU1uRGkvL2NlVXYyN3VJa2pIS0JPOWNQ?=
 =?utf-8?B?Rkk5TUtWNkdOU1Q4WE9lcWJYOVVOWTFlb2MwSnI0WUhnRlMyaUQ1UjJ0Y2tN?=
 =?utf-8?B?aXdhM2pKemhtSG9lWVgwS3NYbVJhMXA1N2pEV3pWUUw3a0ZiV2luQVdTdUQ3?=
 =?utf-8?B?eDFxUldvdWIyMm9XQTlWT3NKWDVXbUVlSGdYZDZSRGE0RzBCakJpNlNYRERo?=
 =?utf-8?B?REQxOURuV29PM3VxTWlTS0luTmg2bTJjNXNrR2QwNk15MU5kNnQzNEtXSGFo?=
 =?utf-8?B?ODUvZy94STI2MzVLWFl4bUVRTlZKVEJUMXh0M2QxMnJqMW40Mk9MN1JVVVo1?=
 =?utf-8?B?VE45T2RTaWJjRWJPYUhySnBzRnZBM2N2S08ydGQ0MmNET3l5MFNyTktJNGV6?=
 =?utf-8?B?LzU0TU96VVdGSFA2YkxCS1RpdTFkdktEaDNkWWhMM0tEZ0pjMFJ5UGwwRkho?=
 =?utf-8?B?cFhYS0FNTjNkUTZ5bVpNSGRmS24zT0UzdTVHYmZZVmh3R05NU0R4WnFmSlVh?=
 =?utf-8?B?UHJWWjBzQVhjQVhvaUpaOGtLMDZITktWd2VGcFR3SGZkYkNLY3FvS2l5bGlj?=
 =?utf-8?B?aFk0YjBmSnhTcEp1a05SdTZKeCsvZUt3UmlUeEFmYnozWis4b1I5QmVsaHZK?=
 =?utf-8?B?c1pqWDV0MTF2TUJyb1AzVU5sb2FrUnVJdEk4enkyQURXOTdLSnJGTlV3c3hI?=
 =?utf-8?B?a1pkRC9yK3lLL3hWdEZKOVB5ZVZiblgydk9JQWpqMVhudG40L0JQTU1kbklP?=
 =?utf-8?B?OGdWRVg1WVQ5TDJqQXZnZUtnNWxTRHBNRFBPelF4OENjSUIweTAyV2F3ZGFt?=
 =?utf-8?B?VzNWYzVGRnNGMFNGTk41M1hRUGJBekNkeU4yODdkVlArRVRkekZTVkY1dTJp?=
 =?utf-8?B?ZmE5alh1ZzdtbkJKZmdJYTBDaTV1QzFlMEQra2Urb3lpZGRMT054c1RRNzgx?=
 =?utf-8?B?OEQyclJQWWJvekZMMjdJNzJ6R0QzWHpOYzRWOVZ6Y3QyWG95cDhyeDhjampE?=
 =?utf-8?B?M2lMaFpLMUsvZmlMR1BNc1VCRkVRSFFFby95a2RhWWcvcEhrWEJwTzg2S3h4?=
 =?utf-8?B?Skl0Q0FHRFBkd05CZkNYMXhRcGJmZlRoZ0RVNHNGTUh4blI0R2xCbTFKSmNS?=
 =?utf-8?B?L2xGK2xJU0p3NjNjZTdycGMrbnNlSmVXNWdGZ1d2L1FSczM3YlJXaE5MakFn?=
 =?utf-8?B?U01zQ1BCUDY2VkJDV3JRVlJ5UGRBdUNIZGRBdzFyT3ZNOTdNS3dscWtvV2Zz?=
 =?utf-8?B?S0VUVVVFbFdGaTNBVG1RSWhlcVFlSFpEMklHdmNFTnpocjA4TFJpV2hlci9v?=
 =?utf-8?B?UEN2dld1eHV2anZaWjJkV1NvYnpsaUJOd212WFAxTG03UG5lbUZVMDBMdzVR?=
 =?utf-8?B?Wm9nV3l6S3JhbnBKTFZXRUhNYkZUcTZNZm4zWVJLbndKSElVcVZVQ0ZxNHZ5?=
 =?utf-8?Q?n8WQvaP6rQo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dSs1WWxPQ1F6MjVCd0FzYUE3Yk8yMEI1YTBWeGhjNXZsT0RHN0tnN1ZkKzBu?=
 =?utf-8?B?Y0xGNFNHVXpTajVpblNEcXE0RVJKdHo0T3FDcUt2dEVjd1FUaDU0d3BvL21Y?=
 =?utf-8?B?STY1OEFWUmpYZ01qSTdBeTd1TlV6ME1Ia1YzU1Y1U2hNV1FwNkdWL1M5Rk1V?=
 =?utf-8?B?eXNhdTEzckVEN05aeHBlTjFCZG5YeTZCRDQ5RU5HUUtFS1QxK05zWlZLanFP?=
 =?utf-8?B?bXBmMXg5bnp2U3hiNnhzOFI5N1FwVHRiQ2htUS9GYkc0RjJqZXd2RitoVE9i?=
 =?utf-8?B?Z1NuUm1hdkZxYzhHSWlnS3lSUUZ2MXhTaDE2VzFxNk5oSS9kaUdjVWRPMElv?=
 =?utf-8?B?cEhlcHVFOTRBdjRibWhHVGFWYVZEaWk2bFZjbG5XQmd1Ly9nRnhWK2dWTjho?=
 =?utf-8?B?T29ZY0VmZUlGQ3BqVml6YkI4OG4yTE02SlVTS2toMUgwczMrUWd2c0RUWWg3?=
 =?utf-8?B?VnZXRExsQk05WDFNRGtBT2cxVFhHWSsxdzhpRFZtRkRmNjcrcWRQNGhrbEVx?=
 =?utf-8?B?RWpJT3BrSjdnNUNRL1o5VUZSYjhlS0tHMndPRXl4OWR4RVd2MG8vVU9CYXMv?=
 =?utf-8?B?OXQ3dkZnV0g3d2NBUHdMeGdYTnJsN1phK0pXYmVjOFF0NFoxcjF1aUw5cks0?=
 =?utf-8?B?THk3MXEyclhNKzF5MWQwQzhrcHV1eXZ5bndCL3NBVFVBQlljTWtVLzA4VXRI?=
 =?utf-8?B?b3hIQmM0dkNMdjlOSWY2QkUyU3RxRjBMNHV2cXIxVnNsY1ZlRzRLc2cyWmFv?=
 =?utf-8?B?MGRxemJ5U0FrbGtiOGZ2ZVZ5WjVPYmJ3aXU3VzU2dDFpbUJxaGNVZHRBbkdz?=
 =?utf-8?B?bkRsTWlBUHB3V0tkU0hvNnY0aS9JWDc1WGdIbk91VGtUQ3dRQ28zZFlZNDlF?=
 =?utf-8?B?enRRZExxVVFWOGRtdC8zTWtIeU1TSTgxbytlUVVnOGd0dXdocnU0S1FhSm9X?=
 =?utf-8?B?RkNWeGZFYU0yWlZIZ01DV3NuTXlrTTFHL3BMbjVpUmVSYnBYMW1CTzBDS3lY?=
 =?utf-8?B?cUJEajhxa0g1ZDVkZFBUcjV6ekdJVjRZTXdpajE0TEpBVmpCaEZKZzNzNGJJ?=
 =?utf-8?B?RTVUaUlQS1FySTRqQUdmMnJwTlFhQUo4aXRmbm1DR3kwdC9LaElka0VhQm1C?=
 =?utf-8?B?Sk1HcGQ5Mk4rb2NETU1mTDlBeENnRWFkUDhobUt0SndHQ3RSN2dTWHdHYnRy?=
 =?utf-8?B?eEg2aUNNdUpzQldzUWhpREVzcXdndVhPZDJPS0FkVGw3cFdyS1FnQlZzWFc2?=
 =?utf-8?B?Rk1EaHpwVmVTRVVTeHVLd0hhdDFGZG5CUVkzcWhBTjRxUzZVSGdPOXdWYWkx?=
 =?utf-8?B?ZGdHN1dJSjl0TDlnM0Rydm1yM2dneStZSUtoZ1k2RHpIL1k5Tk9BNkR3d3U4?=
 =?utf-8?B?SGl4dWdpc2E0NFNaTjByZ1MrNFdOR09kenJtV1Z1NUNtNzYveUhYN3pCdXVn?=
 =?utf-8?B?WUJkbE1aZDFYZDlZVHF6NE16aFpuaC9FSTRoMkFnT0dZQ3ZWbEtCbEVSaXI2?=
 =?utf-8?B?NE9HLy82ZWpVdDJtd1FIaFhOTXRWYkRGdFR3OTNNV2JHdThLNmRvZnhubUlD?=
 =?utf-8?B?WXFGV0dSRmxDNjdnSkZSMHNYY3o1dGR0L1Z5VkUvN2ZaRThWRlVpaWloMUpr?=
 =?utf-8?B?TFhIc2haZE03a05DeWgrQWRyZVRHZmxOSytUNGM1aTdXR3BCdFIxeS9DQnd5?=
 =?utf-8?B?eW12RVI4UlVHNklNZ2VUdlBrbW02U3lSMWNLd3JuSysrRTBKdG1KUmZjaGtR?=
 =?utf-8?B?S1l6UmI2dXJQMzcrSEp1TEdVU1F2SnlwNFRrdmRDa2RyWTNXV0FFeFRraTBR?=
 =?utf-8?B?b08zczBJUHd4cU40Y0xHWVNOd1cxUE5DcER5ZlA5RE4yaklteDUzb0pVZmsx?=
 =?utf-8?B?TlVFbUs1L2d1VFZ1ZTIyb2k4UUNZd01FQmhyQUxOQ09zTVhlRmpaTTZVU3Jv?=
 =?utf-8?B?Q2xRR05TSTVhdWtrMG55TC9xRVlIVUdwRlZBNE96aFRDUVpkWk4zZGlEV3M4?=
 =?utf-8?B?MlBzNE0vMkx2YzFxcU1mMUY0WEw3UGhOQlZVdFpDaTRHc0pQYUZjdis5MzNJ?=
 =?utf-8?B?RGJERjE1MEhEOU5Ca0dKUzhlaFkyUEp1cHdidWVQK0NWVnJWVWZHdnJZa24z?=
 =?utf-8?B?SVhWeXo2LzVlNTVSbzl3ODBQeDRhOUZLNTNWZ2J6R3g3eFgxUlN1MU04Qy9O?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HUBAYoZdqe0Qv3XiUWXDZo+PKnunD/w6Yvn3mRi8Qj1XxS/qWtbN3t+yS6wCqzfvXqbRSr65gi7vjHmRVsFeU2GCtZ8ETo7kaBxDB3PE8T4nvFrzOfNJZarQbvs7eDYIPMLe0P8CtuNx23Z7o8rYnwTKGr/TWCMqUKnUEUYnI+ZaUtxdQPfMygXPOVFOZhZsX0mEsWnvX7PEZuHEk0wC6Dtb5gNCw7nXyNiUbqRcXRKIHl5z7wfBVGqjNimFg6lTRcdWbNFsfTbNEQv5w1DuXwHdyTamBuOlv5t+mCdY7aK+FL9Dqkes92D7NQkdag3pMit+Cy3fgIBfc9rDq481gp+Z2WfG5S/NrY5d8aD4qEeYJ5W3p2MBMGXI9U46JDBpIuSolpiT083zAFb2vb59LuRNDs25GS1df/WaF1tNTuko1kmB+h+3DzpjYe3SE3Jv/ARY8Oo5YX0p1exIlZ8qg8D+RE+/8ghW/h6CJwwkpkoCWG5su9kfWtMrIKsPXU8qb5vbLHhh/E+bS7yWHB629MFNqjX8sbn7oxnkCEM3m/LYiJf/F/SnJhbRMFju+U88eMP7xBgj/cj47mL5BfZs+wBru6zB7cV/F2hsRzFP4UA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1400c34f-5aac-4b1e-ee99-08dd8d8352ea
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 16:22:12.8965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMbHad7l276Yy/GXISO1yT8v0gR1v2C6y4i51An7tzf2ulmJX4IxFksFqtd2SxR+6+4qnqb2bZJ1DnTxbsR5+6GzPXi2lNjP5WyOa/HvOQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6986
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_05,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505070153
X-Proofpoint-GUID: AGcIvVfEBPaRzN_Ulez-7h9z4RzFC2ws
X-Proofpoint-ORIG-GUID: AGcIvVfEBPaRzN_Ulez-7h9z4RzFC2ws
X-Authority-Analysis: v=2.4 cv=B8G50PtM c=1 sm=1 tr=0 ts=681b88bd b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=iHwBjlyiAAAA:8 a=cm27Pg_UAAAA:8 a=k64a2eEoAupXybcLCi0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uNSKXYNwxGiU6LD0JREI:22 cc=ntf awl=host:13185
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE1NCBTYWx0ZWRfXyNTc3G6973P3 1UbK6q1KymKV9qriwSsaYlQi/6c6Jx6rTsu1RXfoV79QGxPUe6fvCrgcWHONA2EA9eKuc1fACXA oRx7I9DF/Qr0agh26Rh+q+uRrASmLuO9FfIlR9nVOLb2S0UNUbQSlzbbOIvGTzIkr+tu2yOF8a3
 Bzl2yLMFVXYAlRFuhvAnoF5Czi7adWGgiLoYZEYKrF/tGey7/xz3uK9ttB3GFE5OrgyEhtTV6EA 57rNyDVBmT4A7+M2DYH7MUMn+riGxB8oEOiNVx/TInPUTEp5ADsIQmCrOsGPyHUBaJG+lHOrByw l87EgXAtUihugTLdTXVgIB0S7a0YYgV3KE4ZMV1Cyf7azZAgx3KInxw/fJ1nvQfzZFPvdj3lV05
 GvfnlTW7hmF7j8doxA2GFasAFiZwDMaqhAu6eGclgHhNPnoXF/ehDqAQIidaDwKwt4nI3p3h

On Wed, May 07, 2025 at 09:18:31AM -0700, Jeff Xu wrote:
> Hi Jisheng
>
> It seems mm maintainers might prefer arch change reviewed by arch
> maintainer and goes to arch tree, according to discussion in [1], I
> don't have an opinion on this,  adding mm maintainers as FYI.

Thanks Jeff, appreciate the ping!

Jisheng - the main point here is to ensure that the arch doesn't rely in any way
on, within the arch code itself, relocating any of these mappings. It's pretty
easy to eyeball it and get a sense.

Because if this is the case, the arch will be broken by this change should a
user enable it, and obviously we'd rather avoid that! :)

It's really likely that you're fine, as it'd be unusual for an arch to do this,
but I strongly suggest you do so.

And yes, I think these should really go through arch trees as explicitly arch
code.

Thanks, Lorenzo

>
> On Sat, Apr 26, 2025 at 7:16 AM Jisheng Zhang <jszhang@kernel.org> wrote:
> >
> > Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS for RV64, covering the
> > vdso, vvar.
> >
> > Passed sysmap_is_sealed and mseal_test self tests.
> > Passed booting a buildroot rootfs image and a cli debian rootfs image.
> >
> mm maintainers like to get confirmation that the arch doesn't rely on
> remapping the VDSO, VVAR, or any other special mappings, see
> discussion in [2]
>
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > Cc: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  arch/riscv/Kconfig       | 1 +
> >  arch/riscv/kernel/vdso.c | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
>
> Please consider updating document as part of your patch:
> features/core/mseal_sys_mappings/arch-support.txt
> Documentation/userspace-api/mseal.rst
>
> Sample change in [3]
>
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index bbec87b79309..3cb0b05eef62 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -70,6 +70,7 @@ config RISCV
> >         # LLD >= 14: https://github.com/llvm/llvm-project/issues/50505
> >         select ARCH_SUPPORTS_LTO_CLANG if LLD_VERSION >= 140000
> >         select ARCH_SUPPORTS_LTO_CLANG_THIN if LLD_VERSION >= 140000
> > +       select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS if 64BIT && MMU
> The "if 64BIT && MMU" are not needed here.
>
> MMU is not checked by MSEAL_SYSTEM_MAPPINGS, which we should,  this
> can go to security/Kconfig separately. If you'd like, please submit a
> fix to mm tree directly.
>
> [1] https://lore.kernel.org/all/7EB087B72C4FBDD3+20250417132410.404043-1-wangyuli@uniontech.com/,
> [2] https://lore.kernel.org/all/3de559d6-be19-44bc-ba8f-4c52d4bca684@lucifer.local/
> [3] https://lore.kernel.org/all/648AB3031B5618C0+20250415153903.570662-1-wangyuli@uniontech.com/
>
> Thanks
> -Jeff
>
> >         select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
> >         select ARCH_SUPPORTS_PER_VMA_LOCK if MMU
> >         select ARCH_SUPPORTS_RT
> > diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
> > index cc2895d1fbc2..3a8e038b10a2 100644
> > --- a/arch/riscv/kernel/vdso.c
> > +++ b/arch/riscv/kernel/vdso.c
> > @@ -136,7 +136,7 @@ static int __setup_additional_pages(struct mm_struct *mm,
> >
> >         ret =
> >            _install_special_mapping(mm, vdso_base, vdso_text_len,
> > -               (VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC),
> > +               (VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC | VM_SEALED_SYSMAP),
> >                 vdso_info->cm);
> >
> >         if (IS_ERR(ret))
> > --
> > 2.47.2
> >
