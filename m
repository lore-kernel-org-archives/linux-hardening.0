Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3291A1DE3C8;
	Mon,  2 Dec 2024 17:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733162312; cv=fail; b=VZFsEfiORZoHCseAdQWcUf8a+82i6+sa8DIZmptxjmV4GvYKRTLnDZ0Qemwnb4dagj83kyPeZlacvHNQxpTDcnR+wjTxJgdNB0haV5ftZGzbQm1SZmfGBjucd5e5vP5m/TJimTpl7MFoo4zNnjAz0KX+CSSh2gM0+aPpUj7UYkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733162312; c=relaxed/simple;
	bh=0LV93pr2UGyYF8+ZaCAQgH6KjNaeMuxdevZ8Z4XoRcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IYrT6pgxzGppbxotUSUCDrOuPsviBoo1vBIAfpmBwcuzA2evwyyqNef6ENF9uJq+/5VxsJgN4TU4YPyXRkVIj5kUMMvem+Boy85aUkyyD8V97QJpPh2P3VGeZngY6AHNaGbRWdbSdYzYtVlLFqNkN9RoJre90KoztSYQD9GN3Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gnvf2ETX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YO8H9Ub6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gnvf2ETX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YO8H9Ub6"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2Hfgpi016857;
	Mon, 2 Dec 2024 17:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2getf1ns5Z+SAGFMKgrh7mcXoHTAVEtKXKBqlQPDvOw=; b=
	Gnvf2ETXzAEXUxDjhVXVuP8Imo/WY47oTtozSE6WYsphTohBM37a8AdOIzukJSwP
	4OZ011sQrq3sPHUveKc7htvJVsZONhUitnsguBsPm7udzLB4ICvyxIL1c6WPJZbO
	zjiDI+P1B2/edYyNiSyPhyRKx5NaOwGZ2kEdCxGrH0ZR8mJlVuM86NkahP2SgC2B
	b1HbDugcq2VknqbIq3PUDgjNspYfg8YcUUkRXI/ipONPRbH+45QQh+nNkMSSKKLt
	YKABaiRwwbVESY9sC8BA0s2xYu7GbDBdLSCOlh2tWCVwDMR8b7JOjn9p35fLl3U5
	RObjZtuN0MpbLa3jcDBbLQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s9yv6k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 17:57:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2Gi3hb037166;
	Mon, 2 Dec 2024 17:57:40 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s578s1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 17:57:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxMMP6sCoE+Y96YAxo2iOYRegHUr+kGMn2uv8426MLj4mJqGmK9ZlpulQOIhxubb9MYM6g4SO8VR2gRNX6+NQiNy3VgmDDq14bQBr3CQW69ab9g0xuxjOSYHx+k5clR1bnf7boC/+op+LeUF4C01mR3J07zdaZfxE+z6FXjtZdXTFkZsYGrSeGr+ybEWnDbnN3t8pcySfXHgr0H4Pf+GQCZWfBY3u3/6hWeIeiKEbnI2eHTO5tHX28XflFA3gCSzVdB4V6O8nvxy+ThS5Noz1x2M2Ys/EG60hWeb2AKgiw/3nGGeabP7Nu6IK4cMfktwWzc2AUn2HY8tG3ZxTiPkAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2getf1ns5Z+SAGFMKgrh7mcXoHTAVEtKXKBqlQPDvOw=;
 b=x1YNfn1E4vJoLfrC33YcnpxEs6v3uEQYxYYYyAih0h9LGvNWWV+5FqYr1QfDyjWb68S9drg/5m0EGypWV7Hnhr3FDNzsTSiaO2TzCWlDXhZcMvAL3vJSDdxaPlWKMB+t7N7Pe/vBoaC4j4fd1Z4pyJBVXeGdfe9HG7Oc1L2fhHPAbOP/vYjI0Su0iHY3QY4zd141xdsBzQz8Ut4n11I64YkOoIWeAOA6OhtbvR3iZjnSYKLolYIqHYL36AOb+MDMQ/U3b1lGD8jNsmJ5POxvjhjo8iFLuLll66Fu3dUMU+fLWIz1w2jSrLPLkfTQ0hQDtQUL11pRHgAioQqcWz/TUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2getf1ns5Z+SAGFMKgrh7mcXoHTAVEtKXKBqlQPDvOw=;
 b=YO8H9Ub6R1lJn1kCmtgS7WcIu5xeucFm8ns7Il+d2FGbZALa+bZPA1t44m5U5NxQKzvMDKpbEjtR9NpGBW5edwPnRqBNlu/iy40hN8nx+4vXya6UY4xC9mG11DArohotGoLZSz1IGmQ5LotUrl+Cg6c0a9btxhokoKI4cU62gSA=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH0PR10MB7027.namprd10.prod.outlook.com (2603:10b6:510:280::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 17:57:35 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 17:57:35 +0000
Date: Mon, 2 Dec 2024 17:57:32 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org,
        adhemerval.zanella@linaro.org, oleg@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
        ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de,
        mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com,
        deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, hch@lst.de,
        peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com,
        gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
        ardb@kernel.org, Liam.Howlett@oracle.com, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org,
        mpe@ellerman.id.au
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
Message-ID: <37817840-66d5-4208-b5d4-5f941ea6b95f@lucifer.local>
References: <20241125202021.3684919-1-jeffxu@google.com>
 <20241125202021.3684919-2-jeffxu@google.com>
 <Z0Tgp4WBPvJiojqG@casper.infradead.org>
 <CABi2SkWkD90ghRHO-1eV9oA9C2sy6Sdzj+3Z-jLzrm6dVGDXvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkWkD90ghRHO-1eV9oA9C2sy6Sdzj+3Z-jLzrm6dVGDXvQ@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0038.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::7) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH0PR10MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: 828c5749-e229-4a33-da94-08dd12facd2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y284NFF5TFVuOXZkaWJ2bVBrNWtTZkpEdlJIaGgyMDRJN2lkeFpZdzlEUm9r?=
 =?utf-8?B?emdkT3NnS0JJRFBzYU5mVFJpS3JmYmk0WFZwdFZGRUFlMDVrQ2VwVFE2TmFt?=
 =?utf-8?B?ZHU4SHdUTG1iWThSVmtGcWpnd05xNi94dWtUV0pydEM5bUtSQlEwQVNsVS9m?=
 =?utf-8?B?NlNlcC9DSnhhSUxxSURZaFB6QjViMUFiVnd0a09Da3ZJT2QzdTdYZ3RSKzJz?=
 =?utf-8?B?bjFZV09YOGMvWkt2aUxKZ3ZORzQzaUJsTEJ0dDg2NUxDQ1plcndwR1hucG1q?=
 =?utf-8?B?WHozVVZZWm9MVWJFTE1PQ2F5RUFKU1UwOGowNExOYzYwdW1rUHJpd1Y1Y0dG?=
 =?utf-8?B?VEFPVHk2YnlaSC90Z3Vrd1JCWEtFbktLdHE5MEVaSjJvY2VQMWJpRmttZW9I?=
 =?utf-8?B?WVI3RjVRSW5MQlltcHpLZ1hIWTdqakRrWTZnaWVFNkY4aWdaU2RFY0FVTHVk?=
 =?utf-8?B?NHRTRGM1L29vdDZhQUF4NWNYeTRtTXJQeFloWnFRSDA3OFBxbE05T0FGd3Z0?=
 =?utf-8?B?OVhYbU1hU09pQkVaREdmR1FTN3FNZGFrL2hBUG9tRHk0cjJkeVQ5czRkNHdQ?=
 =?utf-8?B?WkRydHJnYjg1MDg5b2FxY2I1V1RJOTZscXhGeDMwKy9ybzJZWHd4dGIvTURD?=
 =?utf-8?B?L0paNDdjblFack1POE5jbU9sYWIzdFBGT3dIemlIa05UcjNoL2lSY2J3aUNI?=
 =?utf-8?B?bk5GdTR6cTh1dWZ2ZHFzUURLd2hQUXF1YTRydlZCZUROb2tsWGJvQlY5YW1S?=
 =?utf-8?B?ZWRMczZlZFFFUHZjVy9LUzN3R01GMzVWcjVCamgrWEUvbDJISi9za01EZ3FD?=
 =?utf-8?B?QWkxVU1GYStZRzd2Q2JFVkp1NTJZNDJ3Q0NpeGZzaWQ5N29zbHY3bi9FQVBo?=
 =?utf-8?B?ZHhXRUY4dGZ1cnU3Qk5ObnlVMzhrTEtiaGRyeERTY0xJU3lTdVJMNSswdmhR?=
 =?utf-8?B?TFNMRWF6VjBCZ2RVMUozbFFWL2NFVUlGZVk4Z0Y5anhrNWJxd3Nta2R2ck9w?=
 =?utf-8?B?UGlmZzB5VExsc2xBeXcwM0RDaGN1Q3o3eEhmNUNZNXZud0U2NlNVVmdKTUh4?=
 =?utf-8?B?MmhBK2dONFl1WXpKVktnNHNrbFZWL3BrWERwcElXTXBYZnBKRm01WmhhQmV1?=
 =?utf-8?B?MHB5cU4yd3RYUWZuNi81MjJ4MGVrMkRRakl4ZU8zbGkwR2dTeU9GaGVMcXRE?=
 =?utf-8?B?aVNJajZ4U1hRRWpLM2tMNG9PdkZRYmZ5M3FvekN6YVFBSlJMbnoxQ1pSWmxE?=
 =?utf-8?B?MEtuUGlxQTU1VENwT1pOTWp0akxpaGd4MlRmZWhlcHA5OUN3NUZYY2NNL1Rq?=
 =?utf-8?B?Y2gyenpsZEZvbjNTcCtuYVhXRmdQSlFBS1R6ckgvTmdobVp0R214K0FxL2hs?=
 =?utf-8?B?eFlpS3F4WVVtb1JOQVJKMFNMbGVPUUlaUVZCaFcvaGUzS2Rab0JrZEsvaVQx?=
 =?utf-8?B?eWlTNTlWTERZQlR4SDRYaC9nOFI5ZVJmbmRIaEdIWjc0MEFDU3pwdU5GOXhE?=
 =?utf-8?B?SVA2b2tBV1FqaW5sS0FMeXYyQWZ1d0tZWStWamJNMEpyQmtqQVFmMG5sUDVv?=
 =?utf-8?B?d0pTKzBmUXorQ1R5aXMvQnBlNzY3RWtQKzhCbVhYR2NJUy8wczlLQU1tTVBT?=
 =?utf-8?B?MDRORlJxbUJldnpvcUNSSWF1YjcwS3ROeG96b2ZTQTczaE45LzJVN2t6QlJX?=
 =?utf-8?B?MFhsOHhmdmNiaFBmOUhFcVpKczlaK0NwTzNzL2ZVMDM5cWJMeG04OUthdnhE?=
 =?utf-8?B?OGI3ZU1ncjVrc1R6WTYzcWxYL3NpWUxyYnhZbkhEaEpxL2gvZnRzWS9lWDgx?=
 =?utf-8?Q?aunxXuSN9206R9fTQ4RIMvpnxvYFsfSLhYDC8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUVHTk1ZZ04xTUxWVmh6TVVEUkhIbXlNSGJNT2d0Z3NyZ0V3UU8rZ094eFdD?=
 =?utf-8?B?RHJHWmRvV09ZeEc4dEF3VDA5RUFOajhKMGoxcGkrVCsvdW8yVUJuaTNVY01h?=
 =?utf-8?B?TS9TU1NJZ3I4V2p2YkFyWm1DUHlzQVF4L0tJcTdPaHI4YzdsclFIcGhNNDFx?=
 =?utf-8?B?eWJSbS9ZTDFEVXpIUkxsNVJGUG9JM0V6aGg3SmZNWGhDbW9iNk9KYkNmWXpo?=
 =?utf-8?B?SjdmL2pJcVllUkYyeE45UmJIMFo5VmNCaFRjZllWL0pwcmU1MUZtOXoxdno1?=
 =?utf-8?B?Zzc1QkJjdTJXTUlYZ25pVngwSnpEczNoRCtjOTVDYlpPdDRZNjdYNW9HOHhJ?=
 =?utf-8?B?NjlxNXYzNmNyQ2kxTWlSZ2tEMUhoVHpXMThEeVJPd1Y3by9mVmtyNnM3elh2?=
 =?utf-8?B?R09vVldTbW1XejZwKzU1UGsxaGs2bHJvN2lZSlJ4b3pNNTBnZk9oRjQwTzhX?=
 =?utf-8?B?REo0K0oybHFzZ1F2cklnRHVnVDBaZkN4RXhoREdMbkpjaEdQU2pJZWVmMnhx?=
 =?utf-8?B?b01DV3hPV0oyVm90M3lSbUgzcnFUSXErbDVrd1U4T0lkUlU4TVQxT2FtNnNq?=
 =?utf-8?B?dEdFUzcyWm1mdEpZcThyT3ZGRSswTGprMlpKQnN0enA2cHV3YTVrR0VrLy9J?=
 =?utf-8?B?d0NIc05QMkdEbXFrem8vYmhjbW1WYmNVZXdXYjlVU2FsMy9MamNFU2tzR0hw?=
 =?utf-8?B?WlFNSFZ4dW40Umk4cUpxancyalZ1Vm4vbEJQTnJlaCt2RlV2K3MyL2xnblF4?=
 =?utf-8?B?MGVvOTEwMCtwaW1ocEk0TC9TZzViSGdqMUdyM1dmQmFYci9zUlBqUW9peEQx?=
 =?utf-8?B?bFRjby9lMUlRWm9YQ1lvUGpsaG9KOFpOVTVPY21EVDJrL0grNksyNFJVUlJa?=
 =?utf-8?B?SEluV1ovdUtTa0J5MEFUcERJaGErNkYrZk0zTnRuY2R4UjdlcVhoVzZWc2d2?=
 =?utf-8?B?T1E5V3RrK1BFc3c5V0xFa3hQY2gvSVA3bEwyZFdOS0g5RkZFaEhDZUU0Tyta?=
 =?utf-8?B?ZklPQWIrNng2S0xsS2l5T2tkTHNHQnpXUG1hMHhjZmNFRjRJUjFiNlVzNWV3?=
 =?utf-8?B?cG1iRElOd2NuMnZvQUVQVFhXZFVPdVJwTTlpVWFFMFJSL3YyWUJPM1JQd1Rm?=
 =?utf-8?B?UXNLRGk1dzRhYWo5TXdqcU9hUFVwMFZFaEtYQUkxcG1BZXFQcEt5SVE2NENI?=
 =?utf-8?B?RTYrcldGY29yS1hlUXhuVm1oNmJraXFFUVFJcFg4VDFVRURMZkkwdWErRnZO?=
 =?utf-8?B?cG03MFQwL25Gc2s1WTNUM2k4YTRCNXY1UjNLS3krblJ2ODAvTEhudDNWK25s?=
 =?utf-8?B?M0FxKzBuenY1TlVvL1Vab1AyMjE2enVkNWpBUVdFaXhXWFpSSjRtS3dzMFhB?=
 =?utf-8?B?YVFDNkVVby9sODhmNVIxU0ZSQ21qWFR4TVZaOElLTXhNUS9DdHM4V0pldEpW?=
 =?utf-8?B?bXZoMEJrUU5TQUwvWnVHQUhucktRRUxDY3hEQUpiOEVvTHJIYWYzcEtPcC9y?=
 =?utf-8?B?dWdyVGZ2c1FGWVRJQ2x1R05xeFpqVWVxQ0E5WGZmaDJaRE8zYnlWYW1XR2lx?=
 =?utf-8?B?OGNORHZXL1kwRWlMQ25jaTJLTjB2YlBiajU0TFhoNGo2Y2hCVytoZko2S2hF?=
 =?utf-8?B?aGxyeU9zdE9YS1BMbGZCYXFlWE5YTG9sZFdCTmxvNDY1akhNc2xpY2JDbkN6?=
 =?utf-8?B?Z24rWCtVaWZETTJNT1ZsWThNVldTVjNscjZEdDR6M3lTczMyNzJKNnRob0Na?=
 =?utf-8?B?WVl3VGZZRGNzQWJiZ2tHNWJaRUF5a2dFWkY2ZHJHVmdueDEwa2htajRHazg4?=
 =?utf-8?B?WnZnVG1rL2tnODFHMnBMVjY0eEoxZ3VDcXROYWdRSGJ2a1NlSDVjVjlyM1ln?=
 =?utf-8?B?aElqYVRyOVk1SjBIV3RwTUU5ZEdURzlLRmtOc3M1cGkxalJqeWVrMWF1SVdy?=
 =?utf-8?B?eGpKN0tpTHBiaksvZGlyakZja3FRZkUyTGJ6N0JPamVWdWNTeTR6eWNMckpn?=
 =?utf-8?B?bXFqWm93YTJkbUZBeWFIR0pIWDk2MHBWZjVTYU54M29sam5aY0F6ejFHZWE0?=
 =?utf-8?B?d2JMekpRSDJYMHlFSFdIMURMNXlhUnZINXgyakZVbVA1K3dUZy92aUwwang1?=
 =?utf-8?B?MVpWQWZFYTJPUjRIOTdnQ2hQb0ZpWVZxUXNVTU9PRE1Qb0IydWkxTkZjV1p2?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tTTFsTS7NGp1pcp4H0Mj+Q6oMk/dN8WjfANaX/Q0QEmHUkR3fJsPxXDcUC7OFSTF1SLbr2MMCYTb4jEWcI8F6GVbp2zSBGlmuxa/sh9zPAMNOfz6kiveI1jsPi4FhhIYoGE/5+yZlBCl3m+BLrA5Nfh5zcXcL2o3DRqxZ+bLwwS1/n3uvPjhNrDTjUHJanOrMTG2Hizbhi9LyfyAbmM9SRVrMK1fOyYX35SjuUVznwqJ9EMWYqIi6blKZaJ6WaXPSyxlyk4W4kxKUgl/C2ozg5bCLr2GpwEG+yjqnxs8oYAwyqSGDbDQu/xFmSPWlZmP9phjSoUtw2ac6Y7aGgRI9ILq2BUjozf300FpfH2QRPa2jm5WIE4ET69GrrFXFbPHbhHsKr1lWKdIjvxy1m4KnnLkituurRDnIhLZNNOXY3GJpW2iKHNpTj3SANrc4nzKvFDgfxWVnGASVFGH55QnQgFadGxYfVIYns+WDIBR9j3grcci/FkqnbgouKdKxFT/jH088wCzrCH1NF1XdnG3K0pHHjNn4/uqsFc1rTiCNS9ojiFokBDb9l6VLqU22E+1UCHQHp5REemJASTqUT47OdmzXr+IKcrmU/YggZK5L4g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 828c5749-e229-4a33-da94-08dd12facd2b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 17:57:35.6978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jpHWJ39wAlIdWEfadlW1lrsuTHG26gX8xgmh+05pUgQ/vdfmdmjcoB0uOtCCbhTqBvATl4BcG1HENv+u+AhEL5mTOI+/KC+X4KG+1cFl3PY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7027
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_13,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412020152
X-Proofpoint-GUID: ezw7bsEoUDkBbExTn7iyfGqflweHkBfn
X-Proofpoint-ORIG-GUID: ezw7bsEoUDkBbExTn7iyfGqflweHkBfn

On Mon, Dec 02, 2024 at 09:22:33AM -0800, Jeff Xu wrote:
> On Mon, Nov 25, 2024 at 12:40 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Nov 25, 2024 at 08:20:21PM +0000, jeffxu@chromium.org wrote:
> > > +/*
> > > + * Kernel cmdline override for CONFIG_SEAL_SYSTEM_MAPPINGS
> > > + */
> > > +enum seal_system_mappings_type {
> > > +     SEAL_SYSTEM_MAPPINGS_DISABLED,
> > > +     SEAL_SYSTEM_MAPPINGS_ENABLED
> > > +};
> > > +
> > > +static enum seal_system_mappings_type seal_system_mappings_v __ro_after_init =
> > > +     IS_ENABLED(CONFIG_SEAL_SYSTEM_MAPPINGS) ? SEAL_SYSTEM_MAPPINGS_ENABLED :
> > > +     SEAL_SYSTEM_MAPPINGS_DISABLED;
> > > +
> > > +static const struct constant_table value_table_sys_mapping[] __initconst = {
> > > +     { "no", SEAL_SYSTEM_MAPPINGS_DISABLED},
> > > +     { "yes", SEAL_SYSTEM_MAPPINGS_ENABLED},
> > > +     { }
> > > +};
> > > +
> > > +static int __init early_seal_system_mappings_override(char *buf)
> > > +{
> > > +     if (!buf)
> > > +             return -EINVAL;
> > > +
> > > +     seal_system_mappings_v = lookup_constant(value_table_sys_mapping,
> > > +                     buf, seal_system_mappings_v);
> > > +     return 0;
> > > +}
> > > +
> > > +early_param("exec.seal_system_mappings", early_seal_system_mappings_override);
> >
> > Are you paid by the line?
> > This all seems ridiculously overcomplicated.
> > Look at (first example I found) kgdbwait:
> >
> The example you provided doesn't seem to support the kernel cmd-line ?
>
> > static int __init opt_kgdb_wait(char *str)
> > {
> >         kgdb_break_asap = 1;
> >
> >         kdb_init(KDB_INIT_EARLY);
> >         if (kgdb_io_module_registered &&
> >             IS_ENABLED(CONFIG_ARCH_HAS_EARLY_DEBUG))
> >                 kgdb_initial_breakpoint();
> >
> >         return 0;
> > }
> > early_param("kgdbwait", opt_kgdb_wait);
> >
> There is an existing pattern of supporting kernel cmd line + KCONFIG
> which I followed [1],
> IMO, this fits this user-case really well, if you have a better
> example, I'm happy to look.
>
> [1] https://lore.kernel.org/lkml/20240802080225.89408-1-adrian.ratiu@collabora.com/
>
> > I don't understand why you've created a new 'exec' namespace, and why
> > this feature fits in 'exec'.  That seems like an implementation detail.
> > I'd lose the "exec." prefix.
>
> I would prefer some prefix to group these types of features.
> vdso/vvar are sealed during the execve() call, so I choose "exec".
> The next work I'm planning is sealing the NX stack, it would start
> with the same prefix.
>
>  If exec is not an intuitive prefix, I'm also happy with "process." prefix.

If we HAVE to have a prefix, I'd prefer "mseal.". 'Seal' is horribly
overloaded and I'd prefer to group these operations together.

>
> Thanks for reviewing
>
> -Jeff
