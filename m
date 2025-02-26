Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903741624F3;
	Wed, 26 Feb 2025 05:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740547705; cv=fail; b=NA+ZBE3IIBLGDLgXCrCkVKCqAmDNTtuI4yUvk+coJU2jpoVImC+OOz21bP/EWwGy6Q3P3cv2Pi/pJdtwyXqEevQYE39saLkSVStfjYpxwFRk8X1+qcd4Avb+nZyEsFuRsX86Ep7UQHeB+AnaUfMEQODJ3nz4/bc/bV6kL7lVQ8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740547705; c=relaxed/simple;
	bh=TlODiWgYbIipBqye29bQFJ/JDjg6bvw5aqbcpK3NhwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qqih2pLqqSU/5cle6h2P2HNT7xp+6bbSKGISccXFiSQGCuNjhBH2tT3adkxczYL9yw1u8513SGOQAf/xW/1pBO9AXZ2wEsO8B8Ohs96mgnezpnjj1ayKe/OVzOzUHWFbw53vMBC05IdSqCSHJzLrcW+mB0eHqJ0wZB0aV+V8mqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bLUA16bE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uzhTfe4W; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bLUA16bE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uzhTfe4W"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q5QZGC017064;
	Wed, 26 Feb 2025 05:27:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=We2A90aosxcqwuc+8BkDl0jS2RKDQg4wIzyMr+P2ohI=; b=
	bLUA16bEUaLAZc1nHh5OYzIbsifPpiMgXm5fzy5PDjNYUWuh+CgBj9/hoTVCeJUg
	qeAkxTMnWX2U16biCERHm9G1M0uf9qnmwm9aX90DEHdlI9l1+4yzn9xC26AbdOS/
	5Ya2dbNETvsS1yBQJ5KXHqVl+yoUvT5kqfIIldYyCTspJtJItJ+N8pjYGNoYNjGM
	NOu3N/w4mqq1I1AYW4fWMHj3bpsna2E5a6XDcNhHj0Nec2bU4xbuMyVNHujFGIhn
	2k1ka3FuIecg3KCZsgs9h+o3IYyu50aSbuzYuaLgWac/v8akGZJvOjPMhfmv10jb
	vPGZj56V7hRFJjYl5u+kag==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psfrcku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 05:27:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q4j7Rq024391;
	Wed, 26 Feb 2025 05:27:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51a7b2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 05:27:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KX4ddDmKhi9BsbARttjBsyBGC21pj67yuQBh85AbIE/OwwxrIB4PE2MqKpPn9DBkCaObdUyjsW4q4gt3C1/E1fld+sBjI0OQ13JdMui1AonlmR71nATNDAnyFKFJKvdecae/WFUpj+5OeMZ+ZBPvYIczm1jfJoU05iDpCJ4WgR1lO2BNpesPIC3l3vzOPlL2l5bgHrilTYcBdo1m4j1c3cNVFDkxpmMaf8OU9skQDhqlfIzPBgVieHdq3JgGeTsV7Y48Q/NVmV+WW/dsTWq9Bv2l1TUmRUuT6uIy/lTfKvm/eTe/bsvES3btWwQYJxBAug1YJbEYLWVIXU5ZDNybTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=We2A90aosxcqwuc+8BkDl0jS2RKDQg4wIzyMr+P2ohI=;
 b=AoDaZXaQObtC4OM8nW+mvBL4OV2Ne5RYdIrf+SOvbfie+MQIsVe1J9VawbxEzvbmpTBoPGm0e+4re8vvfgH6hb/82pN5++CZbxzJR193PlJsB1eXXzzugAWzY7rgbQh/DnZxdSfoPo8a1egIXOej5Wx2kqG9ZyL0jnBsmVKm4DAWdmms78ryDkVNhchOFgYBVtE5GcouMOxkh17ikymOOoQgq4OsWwvfllssI4K6xUAw6OE+7IrXbuU9KyDVM5ew4gJht58s4TsLPm0SZzfNshz6x6kuBI2kfwm1Il7rkA6FeDe64FXbnk/P0SShiWFEmYLa4M0ACNgvEwx9zdXdrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=We2A90aosxcqwuc+8BkDl0jS2RKDQg4wIzyMr+P2ohI=;
 b=uzhTfe4Wlm/QjHyKW6LJyTSvkpPMhSomvzsqkrJWZYF3hdwhluTj9S6wytZm5Woqc6HdB32p5bQvQeq+JGup+co72zCdJIp5Te0MG7tXlAHEckPfMmOSR5bFprymDAgZQv0GqqPwD2wL9nSSckA2An7OaJ8Pw6wJWLt4NeQzqME=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DS0PR10MB7269.namprd10.prod.outlook.com (2603:10b6:8:f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 05:27:24 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 05:27:24 +0000
Date: Wed, 26 Feb 2025 05:27:21 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com,
        adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com,
        benjamin@sipsolutions.net, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        jorgelo@chromium.org, sroettger@google.com, hch@lst.de,
        ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com,
        johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com,
        willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
        rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
        f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org,
        mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
        mike.rapoport@gmail.com
Subject: Re: [PATCH v6 7/7] mseal, system mappings: update mseal.rst
Message-ID: <c1134051-4ba2-44d0-955e-7213cac38b90@lucifer.local>
References: <20250224174513.3600914-1-jeffxu@google.com>
 <20250224174513.3600914-8-jeffxu@google.com>
 <7e1bfbf2-3115-408d-a40c-ae51a7ffffe4@lucifer.local>
 <CABi2SkXcYnSOTPHy=VYCUGA9UpXSt_2fCqF8sWS8nxrah5ziPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkXcYnSOTPHy=VYCUGA9UpXSt_2fCqF8sWS8nxrah5ziPw@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0618.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::20) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DS0PR10MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: 04083f23-a100-49fd-7e0e-08dd56263fb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anhVa3ZpTjVWc2lLNkV4TEY0d1R2aGZvOVFkbzNzR0FEcGplenRhdzVaLzd1?=
 =?utf-8?B?Mm9lNWMrU2ZHaENYdDRpUlJtTm5oSUVnVk9IRUVEZE1lT2hCeGF1K0lsTGh6?=
 =?utf-8?B?bDNnQnAxb1gxTnFHVmlMSnl0MjFkNEkxQ0xQLzJxbkpSM0V4TUpVaUdYVFZq?=
 =?utf-8?B?Tkw3Ykx0S1lYczFIbkEwdjM0WVJjVVN3SW5wQjlETWlCTyt2SnBzKzlFVHZE?=
 =?utf-8?B?SGJCSTl1ZjNnTm1ZR08rSXBQS0VtK1hETExhaTlQMnhuQWF4dHlvTjNIdjh3?=
 =?utf-8?B?T0htV3p6dnJBNHFZNFNFMWRFMDhpeEhKMGl5NU1BZk02bWRXNTM5Slp5WnFk?=
 =?utf-8?B?ckNWWE1rZTVIL1R4T09Yd2ttSHRKQ0RQZW9kbmJiWUtxMkdwUSt3UUxSVlE4?=
 =?utf-8?B?WmY2RG5KS1g1OWNLdkUweTVCVWtSTGM3dlI4dVRSem5ZNlRDeFNvL1cvVEhx?=
 =?utf-8?B?VHpsV3lsc2RhbWV4REFvVExlVEs1dHhtS1Urb0xvVG13eDU1WmY2UndGTEZh?=
 =?utf-8?B?dWNPaEsreDdrZXdQUkw2cUNCMTIvdGZ3RlhjWWo0bVBhK0tLT1ZpRWlDSHR1?=
 =?utf-8?B?R1hicmhLUExsaG41WnRNaStJK0FWNi9GRSs5K1lTSWNuUCt4aWhWS0VQRnRJ?=
 =?utf-8?B?bG5ldDdsTCtwTXdTdkhDaU1vSFJuTGhFb1c5MlpuYldaTFdaNHBMcTlldXVS?=
 =?utf-8?B?b3B1aW9kWlZlZ25JL283TGxneUw3aGlRQ1pESFFuN01OeHNKZ0M0L2l6V2dV?=
 =?utf-8?B?OW9VOFd1cFJUTkRSUTNPUEVuU01YdzhkUWhVSE9WazI3dkRtajZLUDBybEV0?=
 =?utf-8?B?ajNEbHZ2S2VzNGNOZ0FxSlNHaWdwK3U2RmlubGUwS0ozNStzUW1wZmZ5anli?=
 =?utf-8?B?T0hRS3RyczMwOVhORFEreDdxbkx4Z1h5cFlJZnU0RXZ3ZGlFSUlZeU5PTU1k?=
 =?utf-8?B?VFBEckhIa0hMZ3FWTGVMWk9rYWtOalBhYUpyT1NWVVMxdXA0WjdQMzkvckFl?=
 =?utf-8?B?WFZTb0NmSFcvNDBFUzhsSUFiVStEWG5rcWlGaWIvOHBMczYyRkJqUHlHdm5n?=
 =?utf-8?B?TzdJdWh4c1U5VmdOam1xK2ZUZFpBL0N5c0ZUdWxtcDZEZ0pjNEtGSzB1aUJ4?=
 =?utf-8?B?OU03NXM1QVUzZUhSZTYrTWorUnNwVHlQUFNveitTOGs3L040THlWaVRsNW0y?=
 =?utf-8?B?U2xYaVU3ZlEwZ1Z6R0NZMjdIV0VKMk9lMzNCL1ZiYlNNNUNJbGpjU3dtaU5j?=
 =?utf-8?B?WkJFdkRqKzQvd1BMNzFaMndIc252TVNBWnk0TEhkN1dwR2RxUEZoUWRjMGxJ?=
 =?utf-8?B?NnVFVzhUTUhTZk1wVEFwMHM4WnhHRHV1WWJSNXhDRlpYTHNZMnZQNUFlU2sx?=
 =?utf-8?B?cnRaTzBPR1AzbXE0aEJMN0VhWjdLVkZsV2UraEJLVVRveVVWYVhEdHNwWWhu?=
 =?utf-8?B?QXRjL3YyVmFEQlBzUVZGZGRkbEwrSVF3SDZtdkhzUkkvaWV3b01xQ082Tksz?=
 =?utf-8?B?SkJUUFF5NHBkbFNIM0J6U3NnNzlFaG5YMDZlUHdsLzhVZFdvSWhnc2tXV05l?=
 =?utf-8?B?ME4yaTFKMURsRFhGQWk2ejVjK3NRcjdKNWNUaG11ZnBRKys3SzV0V0Z1TGFm?=
 =?utf-8?B?VUdvczUwTG43dFZKbVNZek84cW8yUkJlWWRwSGVXZjBVRksvbDUxNXh2emFR?=
 =?utf-8?B?WHgvaHhtbzR4b05CWWdMczJQbVdJelh5Q01VdXViZzkyblowRGwrVk1QRENq?=
 =?utf-8?B?RndYNFMycEpETW9NQ3VSdkpUV3VvQWxlY1NtWUltMXphTXI0V3R0c3gzTXZK?=
 =?utf-8?B?dkUrT3VoMGtma2JMZ3hzQnEvQ0hDVUhBbXAvVzZDS25mLzRudUlWOFREblly?=
 =?utf-8?Q?DTJ/yXgBNuoc/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWllWENvKzg3dCtrUzZFWEQzbVRGQnN0L1NFVjh1V1lJNFVmbGVBYjBuemIz?=
 =?utf-8?B?aS9jZFZPaENLbVVVTnBqTjZFaEdIQ3hNMDlDcTBrS0FKRjdsODFKVXlUZTAr?=
 =?utf-8?B?VmY0WjNjUkI2QlZBSXpDdDEyOGtKd2VJdXYwcVVENDE0ZTAvUXFlbk5GT3hI?=
 =?utf-8?B?WnBnYzFaeXFYbGdLbkc2TGExbzNGTHZ5azVhOUJ3M2d5L3RUMnE5N2xRVVRo?=
 =?utf-8?B?dUo3U290R2N6KzdLQnhpRk9BQnZiYVNINDR5dFEwYjRUbkplR0xGK0RrckUz?=
 =?utf-8?B?bTlrUnAwSHlwaEg4dDdmbGxyTFduQzVCdVZVKytvMTVzUGF2VmNMREtVVUlz?=
 =?utf-8?B?QWQ0cVFSUlhNaFJyK1FhUUlOMHlYVzNBZDEyNkVzQTNIOHdSYVdPa1pnSGZz?=
 =?utf-8?B?T2hmM1l3bElFK2tXeEhwZlRKUlAyZlpqNk94WnZ1SjVZcGlMYUlpdEFidHhu?=
 =?utf-8?B?MUZMcVowaDJ1VG5Sb1VLS0lEUnRxWTZHS2hSeCtQMURGeStmSnFzeGhsMEhG?=
 =?utf-8?B?WXVqbllXSnloS0JOQ21Pazl5YzJTSzd5d1E1UklTRTYzQXhEMW4vMjFtSk5O?=
 =?utf-8?B?ayt1U2gzUFBPWVhlM3hHb3BZbVJ4UXd3RUcwTk5xRzlBTEpDMnN3NTRqRFNL?=
 =?utf-8?B?cE5vQ25oY0dwRVFiWEQwWEVxWFQyQXR1ckNkNWpiZUs5a0RZNThISFFzRTNt?=
 =?utf-8?B?YW5iejJZOFRtTnFyeUJGYzFGb1VLVHltRGJkMnZXSHkveHAxRHJ0STU0a2Fy?=
 =?utf-8?B?R3AvVnBONnQrR3d3d0hpMTA1Q0lzUmZ2Mm9TUHR6eXh0aURCRzZuZXY5R1BO?=
 =?utf-8?B?VzJXSWpWT2p6SjZ3MnhBcllvUjk3YkdDSmEwQjBjZnZhbkg1RHg1M0ZXUUJr?=
 =?utf-8?B?WVlEMEJVOFovZXdGTDhnUEFWMXZHQ3NzNFlWL3UraWViMXhFV1AvMjFaaEJY?=
 =?utf-8?B?R1djbkdrUDBRS3ZRcG9jZVNmQTFNREZlVzJGUENDRVZjZ1lKVHlwMTloUjhs?=
 =?utf-8?B?OEhKV1F3MzBWUmlHZTNjOGFFZWZjaVF0QkJrVi9CZnd4Z2paT0hCNXEwNmxH?=
 =?utf-8?B?YmdWQjZweG5xSnpPUUt0eUE1dHpkQUlvSVdEbk94QlVrWEtUT08vajY3bWth?=
 =?utf-8?B?OVBZMTVGaWdJeGxuMm9aaGViUDd4ZWVUc0lBQnB2OXJ6a3p5cDNTdTBXVlNl?=
 =?utf-8?B?K1lzdnFEWitDT1lHaGJvbUFMdk9SQWVSdXRSSnFrNFRIakZpNHZxY0dTQTVD?=
 =?utf-8?B?cEdZc00ySVg4d21nL3h2dUwrRm51ZHFnVndjYi9vUzJDMGFEeHhJL2huc1Z5?=
 =?utf-8?B?NitybXBvdmdNaHV5NTRpZmlyYkxGOFdIQkpOUUFScDNZTXRTMVRFTG92QmJP?=
 =?utf-8?B?MUNyck5NVFVpeHlkWUJndjJJTlB6ZFFONTN1dVRLQWxNMVNzVUhUelNianVy?=
 =?utf-8?B?MkI0NVhVZzFRL2lBcGE1Y1kxZTF5ZXBoazVIT0Z2SGZBVnlPOXlZRm96WW10?=
 =?utf-8?B?TDhrTEF5YlpkemQvVGFRekY2My94cnRITUM4cmNtUnU3RkUwWWlPTnBLdmVS?=
 =?utf-8?B?K1NxeDJheVBwemZCbmFTMTlVb1YzTlF0ZGRTV2xiWlg4R1dvOVFzTUY1NnVl?=
 =?utf-8?B?alN3a0V0clhlenpWUXVDWnlQY1k2UEhvSHZrMkRXd0tvMS93ZUdQTjFsaTNS?=
 =?utf-8?B?cUl6aEhFR211REtSQzBlUkRMRnN5dEllMXIwUW9yVEtxUHQ3VWNkM1NxRDZM?=
 =?utf-8?B?TEZpemozay9uNmg5bldrWi9HMlJlRUliU1Q3ZFBzQTNBeXVWckFEbzg5bk52?=
 =?utf-8?B?ZWw2WG5NNTJsNVFLQ3VKY2NNU2VQZE15eEp1Z0ZvSzVuUjhtSWtiRU5SRGI5?=
 =?utf-8?B?eG1LeVBYWUhuQjNwbDdSd1daVEx0SDEyUVRtNUQrTDMvS2J2ZjRFTm85M0hL?=
 =?utf-8?B?UUNWc1l1WUZBekxRSG5qdHZPT2x0Y1J0WTZUdHF5YUlaZ0c0L29EZ0JJQkJx?=
 =?utf-8?B?Z0FNSUVnV1dHWVdyemRpMjFuVXRxMTlNaTlIR2pQREt4KzVwOW5NT2JFV0pQ?=
 =?utf-8?B?Rlc2T3U1TjI1ZGphQWgrK1JwMlNGSFZWZlR6SUJOV0oxZStrY2p3VU5BY1ZI?=
 =?utf-8?B?cjRMNXVGaVhIdDNDMm9MTVFPVXhkZDFSZkxobGhFbTJiakNhWFA3WmxOYVlY?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UuywVLE1Yf3c/lfeABOLGB54AJmzSz+cZQeUeuUuG0KgRmKvRG8HoN3faYoNovlFABST1CqET3W0MdeQGXfeShn644K/8IOcYyKtv++3XnFkGuVBLdxCJTRTQdSUW6+mNOUmiebUKMWMc65V16TROci6UCbqm+bBHNUHZWAUNHIXn5pUJ3KDyZYrnBalQPnwMLCYDgj9dI4mw55/mErKWmhqUrrHwDOqY++nBsERWJ85WAO96YeOSqnoJ5Own8/17Lhyzrfut1qXlqTum9umNTeGqnM3z1ZLIP5uO5EjFz1Rg45fQhtlUg991THDE3bCfbF7KFGF3Lgjuij1I2aYKEaS8gIxDfSLQ7eRhWOD2GbNtd5YP6HbLfo1bT3WKm4MsNz7ATUlKv8323JrgWnVji7bYAVzbVlT81OZYdEgXFTCADyUFo+gkf/CJGqOHmrfg+wXtMoJHxWFduXaV2O+SfJvEJXgZFxYYfNGp6XaXiUdDCk1F1KWIvRSz7vHZc9cBaZjgePiB4E4ukfNdPKz35Ed6TXE7XxwtLLfkKD7q3cu7Lpi/aDhNbf6qLxVKsRfMXROD4QPpdAJMo5vDLsE0Hvc1feEFEemmdJap6DreVE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04083f23-a100-49fd-7e0e-08dd56263fb4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 05:27:24.2326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0rGM4GT5B3An07STrD3plttNheHpsndEG2i9pelN8IXBxtt0ICJ5pdLRN4/HcDE54ZHzegHw3qu5sH7QHf2J6IarLKq6JvrecO1/yAxP4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7269
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502260041
X-Proofpoint-ORIG-GUID: 5r9NzvYAjJMVJoC1iIdzyU2248ak77Pe
X-Proofpoint-GUID: 5r9NzvYAjJMVJoC1iIdzyU2248ak77Pe

On Tue, Feb 25, 2025 at 02:31:15PM -0800, Jeff Xu wrote:
> On Mon, Feb 24, 2025 at 10:07 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Mon, Feb 24, 2025 at 05:45:13PM +0000, jeffxu@chromium.org wrote:
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > Update memory sealing documentation to include details about system
> > > mappings.
> > >
> > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > ---
> > >  Documentation/userspace-api/mseal.rst | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
> > > index 41102f74c5e2..10147281bf2d 100644
> > > --- a/Documentation/userspace-api/mseal.rst
> > > +++ b/Documentation/userspace-api/mseal.rst
> > > @@ -130,6 +130,13 @@ Use cases
> > >
> > >  - Chrome browser: protect some security sensitive data structures.
> > >
> > > +- System mappings:
> > > +  If supported by an architecture (via CONFIG_ARCH_HAS_MSEAL_SYSTEM_MAPPINGS),
> > > +  the CONFIG_MSEAL_SYSTEM_MAPPINGS seals system mappings, e.g. vdso, vvar,
> > > +  uprobes, sigpage, vectors, etc. CHECKPOINT_RESTORE, UML, gVisor, rr are
> > > +  known to relocate or unmap system mapping, therefore this config can't be
> > > +  enabled universally.
> >
> > Thanks for adding this.
> >
> > Similar comments to the Kconfig update - you are listing features that do not
> > exist yet, please just list what you're doing, specifically, and avoid the vague
> > 'etc.', we don't need to be vague.
> >
> OK, I will remove etc and list the known mappings here.
>
> > As per the Kconfig comment - you need to be a lot more clear, I think you're
> > duplicating the text from there to here, so again I suggest something like:
> >
> > WARNING: This feature breaks programs which rely on relocating or
> >          unmapping system mappings.
> >
> >          Known broken software at the time of writing includes
> >          CHECKPOINT_RESTORE, UML, gVisor and rr.
> >
> Sure.
>
> > You also seem to be writing very little here, it's a documentation page, you can
> > be as verbose as you like :)
> >
> > You really need to add some more detail here in general - you aren't explaining
> > why people would want to enable this, what you're mitigating, etc. from that you
> > explain _why_ it doesn't work for some things.
> >
> The mseal.rst already includes below regarding the protection/mitigation.

Not for system sealing. Please add it even if you think it'd be
duplicative. Thanks.

>
>
>
>
>
> > You're also not mentioning architectural limitations here, for instance that you
> > can only do this on arches that don't require VDSO relocation and listing
> > known-good arches.
> >
> > This is a documentation file, you can go wild :) the more information here the
> > better.
> >
> > WARNING
> > =======
> >
> > > +
> > >  When not to use mseal
> > >  =====================
> > >  Applications can apply sealing to any virtual memory region from userspace,
> > > --
> > > 2.48.1.601.g30ceb7b040-goog
> > >
