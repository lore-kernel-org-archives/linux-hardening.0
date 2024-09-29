Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F266B33987;
	Sun, 29 Sep 2024 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727635377; cv=fail; b=mzmkgZmWuv/xxQCmxoldWcTGRlwy/0ctrdRjOrhCYd53GEybmVsUU6yU/GCxb+6O8dMBSQiNVp3RSqxwgy0JOAMv9TLvYh/UoqVziHvlCVON3FHNUgL7ge7BL5e9rlCT+2uS1Hk08kl4w9Ap8l7ap8GykP7iqj9v46isCLSVetQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727635377; c=relaxed/simple;
	bh=SP/frgGtXjSeAjl2VTO6FrorupTmmfvcnc0GPGNt2qc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C0mAVfj0iQNtzsj/wqyV376VxCGjaCPsAwFUm8f9d9VGADu+vsjPgw2K1uSZJEyKnefT7wwjiUN9JLUPcbgaSIWCV5PsySWJuRx/KLNtWk9FGK8y66h6Zx5H7g2bZa2F9l24HTxl+eDTpft75xtpVzfnEGBC7L6sjdrvcUeCSd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B5tN9Tyx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QcUF+GBk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B5tN9Tyx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QcUF+GBk"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48SNJerb028599;
	Sun, 29 Sep 2024 18:42:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=Hqifb0fb72Yp8b5ZmPQY/uc67yQ2SvWalamKxoFQfEs=; b=
	B5tN9TyxTCfRwasXc+qeeaCe68JxbmYRkdzhKN4Y6MEWEsSrmdhtXHd0B/t7OIzH
	G5KhTYeum2HIzmrJ9JMTdRHRBx928iVzx5B2SrP3X98yjL0kWCKjbu33ZLroWNwp
	zOdViUMuJi1SLhufFyKGxlk+JOwYF4nEPkDggBlMOjeEC5TERecgb9C2ibA3rAgq
	7bj0GedyeNNCF9s2nAxLM94ALXvkT/s1nzvS3B0jijdf4GYxB9X/6js0t9UQR1HS
	8zMmesfmSl3oizReNTxqFbk/8G+Ks3udHBwHCgLHB5eKzunODG3balpm445kOtss
	usj/KFXrpS9qie8bSOfRIQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9dssuq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 29 Sep 2024 18:42:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48TE0VIF038604;
	Sun, 29 Sep 2024 18:42:32 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x88591nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 29 Sep 2024 18:42:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kk/bse4jg3lbG2xMlUht1OeipemAHPbTJ9l+yb5mQhyLhkcDo+4wvrZiA7qQCpikQqz0hjcZ7yK5MIvcSSFE4ZTF5nVm4xXYzYE92lEDWG7HgNBO1+4V4bUJQTZBDZJTYc23qZJ4GLJFgj6FzKPhtdmTA6naTlNSSkUE4wqEAv8/Y2zFLU+9CyegT44sOhqdmTOhdmjVmTOnGzjUvGdhAcWj9y4OkuWSkvVPQq4CuGKjakWQQPu2SMXuyV+mIOPq57/6Auq/ZCj4SuroD7IMqTNdUTUF6AMYg4VYJ0MvcATycWKGzvQwoLCNqwkVQl+omTEZxF7rJk9xsaYRsIuOtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hqifb0fb72Yp8b5ZmPQY/uc67yQ2SvWalamKxoFQfEs=;
 b=GZRUaF1Aenemjl9YYyzz3j+vJD1dsL0FJaLLO0xD3TK8j7LrJSJpAfWfpYfXXNZBqjvQrnvCIx4sImZPFvvszdNawvedWsSQ4vQbK9+90ArmKwhGbYwbKt0eQsc1fSTMCHLezEbpZYRdJROEUxXvAV7+tkNoLMySes3Jc1bbTqTpib+dpCHKOEhhjYeGPPuvGhsQuL8EsUXsDMA3Fq84nxFd1+c4W5e9Zuubyb827ZbArvwABXHovx2HWLfAs73cdZ8xXYB/lmn50GjSb7Ohlr/7kEqVniCAyYPDte51WNsF019R1fccuzdZbnD5lxuo4d4VDNON8NYvaZFsFXFkVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hqifb0fb72Yp8b5ZmPQY/uc67yQ2SvWalamKxoFQfEs=;
 b=QcUF+GBkSQ97Heso4D2T7Xki6Ft1UGev4QyCYCPa4PUeWnOQG6eDPXqQLQqxn0MzB6gghUm/Np6cZjA4DkIf5rWJGAvfYvVzPBjHEuExwkPuKzPg4kayvLhbkgu6lLI1WENwcjNtD+gdXHhF79KEB/+NYEdSb4U26kk2Mz3QIQU=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by CO1PR10MB4692.namprd10.prod.outlook.com (2603:10b6:303:99::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.13; Sun, 29 Sep
 2024 18:42:29 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%6]) with mapi id 15.20.8026.009; Sun, 29 Sep 2024
 18:42:29 +0000
Message-ID: <463aeea5-c24d-41bd-888b-6e0911081aae@oracle.com>
Date: Sun, 29 Sep 2024 20:42:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coredump: Do not lock during 'comm' reporting
To: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Roman Kisel <romank@linux.microsoft.com>,
        Xiaoming Ni
 <nixiaoming@huawei.com>,
        Vijay Nag <nagvijay@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20240928210830.work.307-kees@kernel.org>
 <20240928143532.39559729f9eceee468358abe@linux-foundation.org>
 <202409281438.EAC4B88C@keescook>
 <20240928144636.d1964e6c6bb77c3e9123fc64@linux-foundation.org>
 <202409281449.B228D0C1E7@keescook>
Content-Language: en-US
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <202409281449.B228D0C1E7@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0049.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::24) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|CO1PR10MB4692:EE_
X-MS-Office365-Filtering-Correlation-Id: f2c3dae7-956d-4e7a-0d30-08dce0b6786d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dm9pQkdtaWp3S0ZIdWVGVmIrTzZlSjBDSWhoM1pMcmZSZEtKYmM4bzRSWFI3?=
 =?utf-8?B?NWdIVkZXaE9RTnlROWYxTzRqTVhrZnR5MTFwaTZwdm1tS2NEZkNkVDBIZG9K?=
 =?utf-8?B?WFNnWFV2S2N0NHZKdmZPWXB3bE9IWmY5b3ZNcTJGdVJQblBHS2R4SlJ6R0FR?=
 =?utf-8?B?SUxqY2ZHVzUrTkVZaXZkTE1udjlmbnl5VjBZS1MwSVlBUThNSmtyV0V2ZEsy?=
 =?utf-8?B?NWlsT0ZKUjVrOS95WDlOYnM2ZXdLN1lld1FrMTB5eUQwbDRXN3liVitpajdU?=
 =?utf-8?B?Qmo1ZWJEYk02SHUydjJtNzRHdENNTDVvQlVENXdqRW8wSFJGN20zM1JDWTdH?=
 =?utf-8?B?TnFWYWoweVhBWXZINk5zZ2NzR1JqcGdZNXlXNWlETDgvbGF0ZUNWZ1BYM0FT?=
 =?utf-8?B?WXdLekFjaFpNZUVXWko1dzk3dEdHbThZem03eWg2eGVFU1ZSbWIreXRHd0tu?=
 =?utf-8?B?ZDlUUmdHcHpPR0lkUlRzWVlrZmJhY3pNT0tCMGNtUVp0TXM3a3owZTRNNFpr?=
 =?utf-8?B?U0RERXdVeU5MaTFjUnBlZ1RRM2FZVU43Y3l4L2xqWXR0M25uTm41VGlvb05E?=
 =?utf-8?B?TE5aZVg0bE5oSmtrQXNEdllNaHVTODZQT3BKYjNYYy9GdkVGUVdaOWJldFBM?=
 =?utf-8?B?cUE1L1N5TzBsNmNGVEZ6elQ1QkJuVGZWaDZ1ZitENEg1QkRrcDZFWTNRZGJ4?=
 =?utf-8?B?d1BoTFF6VG96YkVBcnFyMlVib3V0eFY4N2l1d0lkQTIyZXJpTmp5ZElYU1JE?=
 =?utf-8?B?bWxoVGlCQVlpcUlBVXlINmdkVDFPbXpoeXhWQXVuZlB2WEVKT1FBd0pVc1Yw?=
 =?utf-8?B?Q3U2eHdMenJhSG9JUk1SdGVJd1NlSnhYVk1nOEdUTzhOMkVzUlAxK0V5eERC?=
 =?utf-8?B?b05rak50cmd3ZWplRTRsajZMdmx0QjBBVXhIRDVuV0tZcm9xdzBGek5HWjlH?=
 =?utf-8?B?MzcwYzhnN0pvZWlWbytCWTMxV0QwVXJkTjRRRDE4QmtsQVB0cDBHVHpueTI2?=
 =?utf-8?B?WlFxSjhQV1hNRU5iSFQrdHZva2hDa0dGYzlEOUcyelEwLzF1b1lvNld6THFO?=
 =?utf-8?B?NXBpZXgzZXdVZUo3a002Vm9xbGNzb1RtMEREQ0FlME9TSVhrLyt1MmEzaVdM?=
 =?utf-8?B?UCtBNFUraDVCMUlxTjA2aHUrMGsyWHZXblJUZ29wTElyeXJiSER0b0IwS2g0?=
 =?utf-8?B?RzV4WnJGV01CV3Q0em5rTWswYkZPb1pkbnlmS0dCYWlZaDUxYzk1UGFpbkxy?=
 =?utf-8?B?OGRLbDA4WTRhODdDMVgrMmtMT3VXV25oUlJaV0xMaWxsS05aTmxUUDVrK281?=
 =?utf-8?B?MjJkRVVMM3gxeVdCN0xMOVJoMERKelBDRjVTajl4K2tia2QrZ3hvS3pQM1N0?=
 =?utf-8?B?SFQwRk5yRllQUmxsSVNwQXZocXc1Unpxdnk5amtoL2I4V2JBTmNsdW1ndlJi?=
 =?utf-8?B?T0VGaHZIck11VXZJY3lsT1gyUnNaNHNVZzJsQjJZd2NRODZaSGpiaDRSVklN?=
 =?utf-8?B?NElqM2xGbXlmN09BYjdyT1RvY3MrdHpSTjMvcVZaa0lKb0U4OFF4N0M2NWNI?=
 =?utf-8?B?MW1ONm0rS1IzeTUvaldvZHBwYlBma1I0Z3dLMm9KR0MyZURzZTJIL2hZSEtT?=
 =?utf-8?B?bnZPcDVWV2xQSW9Kb0kweUcxL1VZRkU5VWk4bldpMWZveEZnWGtJeHpHTnAr?=
 =?utf-8?B?UTNsdXBvc0FSbzVKUmFnQ2p0ckRSNFpYaFJ3bFdjM2kzekpGTEd0dXEyNFJB?=
 =?utf-8?B?ZVM4RURjREdKam9XK2Q1RHJlWkY5aWpLa0ZucUkrblhsYXRuNU02VHVEK2pn?=
 =?utf-8?Q?QI2Wks0X/MRYehIwcNiSkJSNjbd9dotdsnx6E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTc4NGJSaGhZWmg5ckUrUmxlblN4VTdXd1duUEdGcWs5RDBjNjRDM2tpMW1L?=
 =?utf-8?B?aHZjVm5NTEp5cytXNFJEcHlIem5za1lyVmhqa1lHM2g0UFVtZFI3NXJKdWlG?=
 =?utf-8?B?UER6M0RLY2MrU3h4eCtIdVJjMkUwRS9FMEdRajJPS1RXVXFVdVlEQU4wNHAx?=
 =?utf-8?B?bkRYbTMwVUJjVUZ5NTc4enlmUEp4L3Z1a1Y5NUtmZEt4MjJ0Q2pOZG0zNXFt?=
 =?utf-8?B?citMdnV6MUxZSGpxTWRBUFh0dTROZ2ZDd2hpUUhPVFllREc0bll3M1JvdUdx?=
 =?utf-8?B?YlVtUVdMTXgzTnJneHlJVHh3MUtnU1krRDhLejF1c3orbUozWHFpdWFTQ3Zv?=
 =?utf-8?B?WDkrSzhHbENFWFpTMEZGbHArelBIZlRHa3dYWUt3MDZQRmtPSmI2QXdTeC9U?=
 =?utf-8?B?V1VEZW9SVWpjUTRhcFVGNm16eENEYnFMQ2lrejZjYittZFF3RE5WaFREeThs?=
 =?utf-8?B?Nmx6dmZIUzNYd1Q1ZDFQbE1xd2F1Z0NoaWZDQUJKdWcxMzdGelhZYUtIdGFF?=
 =?utf-8?B?SlBvcVBZZkt2OUdSRVViZFBEcVQ0STVBTmVjWktNNWJTUis1Njh0bmJnLzNV?=
 =?utf-8?B?K1RNazZmYTQ0amcxWXBpT3hSa2swcFpzQ3IyUjlCWWZtZXZUQURQZEorMFl6?=
 =?utf-8?B?Qm9qY2RKODQzT0YvdG41T091QStvcEJQUVExQll2d1ptV2wvUHhNa1JUUEts?=
 =?utf-8?B?cHJMNWxmeFBQT1NkUEJHZDdVd2dHeWtiajJMVkE2NGswcVJ6VGxNVjJKNnlX?=
 =?utf-8?B?SjNjckxQbzBBbkI4aG9RdTRpdktoSGQwUWRoZ1d6YXl5UENMcXd4ZE50T2hz?=
 =?utf-8?B?cFNhOFVSa3NXclJLWW9aWUhqREd2Z01BSTZGNE5paG1ibkR0RlhiRm9Bczdj?=
 =?utf-8?B?VkorNUtFQlA5OWNERU9xNEpDZmJKQjdralpBN0JWRzlJVlZ0RElOa2E4M2lo?=
 =?utf-8?B?em44b1FsZlBMWkEzazYvTEQ1MEhmc05MM2ZPbEJZdGhmMkxHWlMzNFZDSkIx?=
 =?utf-8?B?cGp2SEJMZHlmV2RUUm9pZ2dkRGZJTnlvb1ExU0h4VVNhekNjR0VmWHVselg0?=
 =?utf-8?B?SlFJd3EyU0NIemtIcXJpRExsd3RlUWpHSWJOTEF2cjhJWFA3K2pqdzJ4MENq?=
 =?utf-8?B?RGJWZjN5NlBhLzlpd0NyWmUxNEExMHQyUWlhQ3pWWkkvbGtyWCs2cDkwNXRD?=
 =?utf-8?B?bVFwdTljVEpIcGhGUDhleWpqcVhkSTFSYm5PMDZmdlZTdC9PWmg0aGxEbHZS?=
 =?utf-8?B?SllYY0hhR3RSM2lTSSs4NXBSOWwwbi9LRTYvMVZMSE1wak1vaTlOM1pFSjZT?=
 =?utf-8?B?WUJLWU5aWFRZY1Z2N3cvcW5kK1A1TGVjekZvQVlZR0g3aE9BSkF0dlpZUlJF?=
 =?utf-8?B?Vk5MQjluaFhjMFhCVy9qYVBSejhTOStuL0lOemRmNDFLT1E3RjNzaVVmM2lx?=
 =?utf-8?B?amlCR0JqUlQrbTUrdEdJZVcwa2JadmtKRkkyWjF4cWhpTWlWaW5XbEVmQWlT?=
 =?utf-8?B?TUhzY1NvQVQweTBSaU96R2ZTdVdnOXRocnpiUHVKR05GSFNnVGppcDBXWmdG?=
 =?utf-8?B?YThNWC9GZmRUY21yNjNjNERsNTZlNWZpRlR6ZHNvUElXRnBsNTNUbXJ2T29H?=
 =?utf-8?B?WnFEUnVBKzRkZEpYc2pFRjl6OTdkUUgvU1ZqcEt0TUVaOWM3Tkx3enBWWGZv?=
 =?utf-8?B?WWl2YU40T2g2VTNLcHVDUTVTSVp0dnJYRW5JYmxnaHNnOTZCbkNRRWwrQlhx?=
 =?utf-8?B?dWN1WjAxNThKZFFzby9ib1c1VVhWYWswKzdzdVJDam1ZOEwvQThKNGJaellJ?=
 =?utf-8?B?WUVaSzNZN2JNMEMvYmZzZUQ1ampIc2F1Sk90Y05ad2xNV0JzSXFYOHM0MytT?=
 =?utf-8?B?OWQzMTZwSUFWZU9HcVg0NXhzM3dCSktFcFA1aWhhckVVaVgxeHpHQVFtTHdG?=
 =?utf-8?B?TXh2eXhjcmpSMmVPL0dRTmcvMlF5TFJVUm9tdU1qKzQyUVl0M3AxcE5Weklv?=
 =?utf-8?B?blJpUjVsYVJENGM0MXU2V3J1TnQwYm8xOE1VUk1ZVWdJcHRBUDIrZHkxRTRP?=
 =?utf-8?B?SDFTV2REZFFISERTejVHWG01VnRma2pRQVNiYUJBKy9PaTRFT0JsUHAwS0Zy?=
 =?utf-8?B?RURiTkNlRUNUeEtQaGs0RUlHZzNYRzBKeVl4MWVpOGw5RnhpcmZlRytxUno4?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dA0EUmiCHkiwfvBcxpSm4ItzJVVBmE7I70Hz+W7TeSpBKrkGl7X8MownDPauIrkbIIQ2jGPaSiMiPNeqe5GuvH56Yseq9jWhsvg34NZRnWQuC2dj9/lrXgpWOAG2NSMc2tuHwzh8NeRj5mSZA+NPORoBvVCQF5ngYMwRQVGs6sB9BVhWsQ2zJhUy32PbBN5GpGduv9jJgtDxYARQCdayeNnQRHMIUXeEDxPzM/y/KPtsEvcM1V158y3SMsZjdl3cgcur8jxHkEa9JTQVhHJmwFkA2qeeT5y4cX59FuX4hNKdxZdgSsHreiM6lYCPm0x/+3UEXToeM36kExuvoo9tQ2PYByqSZoT8PxV4W/8erBjOrII6rcUPpAmvhnSNcipTjzcP5PxDi3mlXZ+THFxygcYOVekf2oHQGbL/N2O6vrPQ+mpuBQLP4L+BiQcX+3/lrJKTcorVix3Hn1MH+bkaIw+qA++OpkgHPHwDMC6djApf+z2MYBkrFBzWbwwnLlsu/h4igFSUDkKRR8Kn3T7VmGGg+T7MEV5+fRYX0Z1SdQC05ibI1FLUhJphXVdaKLV1hQuT9Gm2Xozj2pxGwXR0jR8rrYQHL8hX4Vt4N0Joehk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c3dae7-956d-4e7a-0d30-08dce0b6786d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 18:42:29.1926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBpxLrYttUEvckt8MXQLUR7gZFdhgAtCuJ6eum/Zeib0UqL48VuD//JWa6vci6ap5Ds7F3g8jJgI6VoGmpYZ34nVtK3c0VB6SNYXijU0m7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4692
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-29_16,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409290146
X-Proofpoint-GUID: EjdzAxGZzQ9igKSbMB4PaaFBRJXEuC1k
X-Proofpoint-ORIG-GUID: EjdzAxGZzQ9igKSbMB4PaaFBRJXEuC1k


On 28/09/2024 23:51, Kees Cook wrote:
> On Sat, Sep 28, 2024 at 02:46:36PM -0700, Andrew Morton wrote:
>> On Sat, 28 Sep 2024 14:39:45 -0700 Kees Cook <kees@kernel.org> wrote:
>>> On Sat, Sep 28, 2024 at 02:35:32PM -0700, Andrew Morton wrote:
>> So why does __get_task_comm() need to take task_lock()?
> 
> That was to make sure we didn't end up with garbled results, but
> discussions have determined that we don't care:
> https://lore.kernel.org/all/20240828030321.20688-1-laoar.shao@gmail.com/
> 
> But just for safety's sake, I'll change this memcpy to:
> 
>      memcpy_and_pad(comm, sizeof(comm), current->comm, sizeof(comm) - 1, 0);
> 

Reverting Linus's revert, applying the patch in this thread, and then
changing it to that memcpy_and_pad above, everything seems to work well.

Tested-by: Vegard Nossum <vegard.nossum@oracle.com>

(However, I have not looked at the _safety_ of omitting task_lock()...)

I'm also wondering how I could successfully cat /proc/$pid/status before
on one of these hung processes given that it does __get_task_comm(),
which does task_lock(), which should have presumably hung as well?

Finally, I'll add that the comm/pid format is different from some other
messages:

kernel: coredump: 31447(entry-fuzz.1): coredump has not been created,
error -13
kernel: entry-fuzz.1[43396] bad frame in rt_sigreturn
frame:00000000e4ec200e ip:40a6712e sp:40c25f20 orax:f


Vegard
