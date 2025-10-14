Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E178A2DA755
	for <linux-hardening@vger.kernel.org>; Tue, 14 Oct 2025 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760472993; cv=fail; b=olHVXMh4YqMEMyYh/CCqSgteCAlvOEfyPoipt+g2deliRFvPhYny3fPKb8GvCkBBxP9lQikXoEufe8L+LDbQzEKg1WWiBJyQEPMB25DNmJ73AacU1xQ0YKaDtcL61A+uJ1VfNaKxLKLMo1B925MIxZArWq6GxiD/8fFx8skFLZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760472993; c=relaxed/simple;
	bh=eRuDWQRFo2VTwNwoJfFrci/UjTmbQKLia7o/RzQdoTk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IrI8dFV/n1JBYEjAWMssetPpmwncvwiks0KrNKkFxAa6Ry0Hzm9razV7NKFZ/a2+ogf0JaLPYeb4l4Qz2Yx6OP26o+EDWAo1bMQoSiX43ZBzAyJm78Kt1RmBdLMofIkYQz/PJYTJ7/NdyKkCdPKz+kO8DoQ4lJcefDHOduoCsfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bYeZw06T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NUNV4/oP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bYeZw06T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NUNV4/oP"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EEfLYi026445;
	Tue, 14 Oct 2025 20:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=eRuDWQRFo2VTwNwoJfFrci/UjTmbQKLia7o/RzQdoTk=; b=
	bYeZw06T5mc0Eimr91ERA8SM1xUV+kCVgMi12iW0aPJizA3dG4JtYXEJRs+HY44s
	fI0XpfQcko2cIN+QKJy11HBpHWBAtlN90Qju/2YTHAyNXg5j7bz72FBmIr50VEjy
	6Y0lrlaBiYgfepO/oaDDdsn1pyQqpZ8L1bOJtYBEuLBQ7P7oseSB3iLEbWmd2tV1
	wP7Izkke15sp8smTznWHgd0dYwnSZHkh53Hd8++/wDFpYt3tzq1YJKtnr9Xo4AEX
	31o0/xlvP8Hc5iRwGM1QOavi8ecUjZeoTq0xgPDvi3jNVIOCC2FJ2hxmF1d6nPoe
	dNA0FO36p9jZhtOslslc7Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qdnc58ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 20:16:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59EIU1MV025628;
	Tue, 14 Oct 2025 20:16:19 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011022.outbound.protection.outlook.com [52.101.62.22])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp968rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 20:16:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCoS2lwvGeqcYwO+VsSkbiwKGPFutp/gmUNswJVmPKWlX9FNREVpK5cMPK9HErLWiYFBdGjk5rpB11nOzvTwj9eG1/AtnZAQNu7CRuV0yGP3EoRhXwzwSbMUosokcB8R3Dbfce3y91rC7UxCFYzN+LBraGEYORSyS9y+Zjfxi8lN4170YatyY2J98n9rBM02bo1wtP+ktFs6VuA3Dlb6OqDnjuyR5mX1QWQw00R6kShuJ0u3yCrreuJjnsMewEr7y7mOlBkFg1CzFJLYM8qCjrYqqeaeSsRwFcmj8R00EyeLTOMRyGk6dObj6YsKBZWS5xW26rVqyWLGl2yOB+bkLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRuDWQRFo2VTwNwoJfFrci/UjTmbQKLia7o/RzQdoTk=;
 b=Qet22o5V+qxLTD4YCHdmkIOXmaJ5XJoPQBb9fAZ0HlWJntP9dtu4HKVg8HiU3qe235woEou+szzHfn5idvKYuDFphFWm+5GdrPaiYqmDZnVo8qERLElqBZOX/w7PQCVCVG+00K08fnBg/fPgBLufpLYaTA2C/Qzf0LL4o+rd0tjuSy5yQlKCrbB21SHvt/exncVhy6bIdIguWW8P2zN2BNFRTOKL5/l9phcFNqpbiS5ln7BOwqMb7h1KATJcEqXiEGAfOVp4rDMyT9RX2dx2HxeSf8nK90wqh/+0UFaqwEQ0HLJ+/QQ7xWBHUSRANSy6F9zMBvPpn8PEeybqbXNp2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRuDWQRFo2VTwNwoJfFrci/UjTmbQKLia7o/RzQdoTk=;
 b=NUNV4/oPx65zON6aGtlOSlF/Fzf0ux8GUGqPyUihoY4k3T1GQCFOESnueZMwGQgYHhfDRktzenuOcv0EqwjEEERVdl0Te4htozl1NXlua1/0Vts2D8RA3kUU6rUZLrEL+x2WBA+CP1YmCE2Jxx+B0mhA4z6jzWIWE0r+1DQlXWA=
Received: from CY8PR10MB6538.namprd10.prod.outlook.com (2603:10b6:930:5a::17)
 by DS0PR10MB8221.namprd10.prod.outlook.com (2603:10b6:8:1ce::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Tue, 14 Oct
 2025 20:16:17 +0000
Received: from CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::83c0:6ad9:b202:784e]) by CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::83c0:6ad9:b202:784e%3]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 20:16:17 +0000
From: Qing Zhao <qing.zhao@oracle.com>
To: Kees Cook <kees@kernel.org>, "claziss@gmail.com" <claziss@gmail.com>,
        Claudiu Zissulescu-Ianculescu <claudiu.zissulescu-ianculescu@oracle.com>
CC: "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] arc: Add const attribute support for mathematical ARC
 builtins
Thread-Topic: [PATCH] arc: Add const attribute support for mathematical ARC
 builtins
Thread-Index: AQHcFkEKxM1jfW7R8kqet3uNWNqdeLS3bskAgABsFYCAALMAgIAJ1F+A
Date: Tue, 14 Oct 2025 20:16:17 +0000
Message-ID: <7CB4C8EF-3D28-4BFB-B37B-40128285EAA1@oracle.com>
References: <20250826042212.work.202-kees@kernel.org>
 <1B081822-82F3-43A1-B3C3-B0B377F50CE6@oracle.com>
 <202510072026.568651EE@keescook>
 <E828A2FA-A5DA-472E-9C22-C04AF91D13A0@oracle.com>
In-Reply-To: <E828A2FA-A5DA-472E-9C22-C04AF91D13A0@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6538:EE_|DS0PR10MB8221:EE_
x-ms-office365-filtering-correlation-id: 42eb442a-4d47-4612-db60-08de0b5e883e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SllEb3ZkeFdmdDJXVGtGV3lVVFVkQ3IvWjBUWXMxYUU3WUNiWUFxK01haVJD?=
 =?utf-8?B?YndoQ004eEowNkN3N1l4VGtZQkxQcDdkM2dLbktXMHd1WmNyTzU0RnRjMXVW?=
 =?utf-8?B?eUFNMHBxNFJJYTFLaW5na3ZkUnozc2VHanRCS2xyT1Fhb1RYdWlRdDF4RGQy?=
 =?utf-8?B?Rng1OFArQjc5VWZVRFlrZ1kwQVdyZXhOdFRNNk4yZUlnbG9qSnFSQm51S2ND?=
 =?utf-8?B?NVZocUxCTUsyWkRyczc0SUlCUTZVNVpPN2VUd2NTZy9HdkRVZEVvTkhaZUFP?=
 =?utf-8?B?aStBQk9DcklvaUJ5MVVYZDlmQ3dVZEQyZCs5MWlmU1l2MHF0bHlFQlFMZ1BO?=
 =?utf-8?B?WS9BU0tyTTJBU1JPZ1JKOHdJSzhwOFZuL2ZVdWtHRUs1OWtKM0NLbWhqK1Zo?=
 =?utf-8?B?aTJndzRKcEtNL2ZPZVFrVUtla3I5VFRhYndveEJpNDZ1Y201bFhxdnUwZkww?=
 =?utf-8?B?VFRpanZ1bjhIRTFyVEc4dm5VWkR4SVAzQUpsWjR3WnVZOE5OeWMwQ3Rwb0Fx?=
 =?utf-8?B?QkZRZUgrOU0vY0wvd1FzQ2xlRm9wbllGcjh3Qmx2UzFNL3JaRk1OdzQycTNL?=
 =?utf-8?B?M21TbWE1WDZ6WUhkOEhJdlhlUmRmRzk0VklqVkk5RFQ3SlAyd1N2R0ZveTk2?=
 =?utf-8?B?MzRSR0JmbG56TWlIem5VaWxZd3BkUXN2U1Y1cVlPbUZ1a2s5S1FzZ1VKSHdT?=
 =?utf-8?B?WUQzUk41M3E3UEJCTzd5d3lBdzRrcWpueWUzYUpCZndkWGJFbGVicmVxdXIr?=
 =?utf-8?B?NHZBVjRqUTZjQmJYZ1FiMzlLNkpxdlBGNGFndEJLUUY1SGZsYlNBMU9Bd2JF?=
 =?utf-8?B?Smh5bGtYRGpMNnJPK3NaK3Nab1dsN0xzMXV2TnRkQ0J6YUdBNUJLcVk1SXN2?=
 =?utf-8?B?R0xJdGhiOElkYm1vVVVaSWpYOGtIbmNhcTZXVlNFNDJWQVNyTnBUU0wyRW92?=
 =?utf-8?B?d2w5eFFhV3VaMXFMVkVtVkFCWVdQNjEwWkMrRUxPRGZiOW9kdmFUM1A4Tkx3?=
 =?utf-8?B?aDdoK05CVDVoc3kvTU9aRU4wQ05TeHBiaVpiZzVoSUFOeUhlbTN3MFRCdW5r?=
 =?utf-8?B?U21kZnYveC9MVkNpM0RkK1hSNFc1ZkJWVVB4MWcreXYxSUQ1Z3dRY1NvaGti?=
 =?utf-8?B?NjRoZDRXTjlnRmlaekhGekZHcnNwYVJDdkNQczN4MG5JMXpnK1VnVlA1VHR5?=
 =?utf-8?B?dVNGdjZmb0RCN2N2V1hPRnQ0RUk4VUVoYVlnR01ZUGpFenl1M3pvOU5FWHRO?=
 =?utf-8?B?Z3A1NHhMUGZlWXVtV3F6YU9pM3oyZWYrZ1JGcmtBMVNFNFMySUlIOVpEVnQ5?=
 =?utf-8?B?MEcyT2tBZVRwaDk3alJnUnNMK2NBVGc3SEcvdVVxQ2NtVVZpNmVNU0xUelk1?=
 =?utf-8?B?WDR6T1NnYkVKQmhHcTF4WllDd0FjWjJkRjBobEJFL1JHaUxtdWI1QVBiSTc4?=
 =?utf-8?B?Z1hET1pHNkpYSTU2QThPTVJNUHRGUUhEVnVWQmRFdFAwRnB6L2Y3WDduSEpa?=
 =?utf-8?B?TGFSR0VCeTkzYTZkaUVBK0x6bmlKblRBNmRFNzBvV1VUNjl1UE1oZHVyUlJ3?=
 =?utf-8?B?OElPaEdYUHpSUFp3aGsvcXljdHNwelBhRktDY1ExWkU4TnFoeHgxOHp6cTBH?=
 =?utf-8?B?bXdiN0wxN1R5dHh3WXpZQnh1VytCVnJWOXVuK2VMbE0zYVo3YWhNKzRoMDds?=
 =?utf-8?B?RElVRGl1T1NKK3A5b2FxekdQZ0UwWm96em9YVGMrSDVBZElYYVFnTko3Wmt6?=
 =?utf-8?B?OW5qaHlydzR5dVBkem1LK3R5M1JKMEJxRGk2MlRyVTAxM2JkQjNINWZTREhx?=
 =?utf-8?B?aHpuWXF6a1hJOUdsaVhHMm5iQlhRTjdMa1JNRXBQZFFJMWdPaThZaHZMOXJy?=
 =?utf-8?B?ZkhZaFg2OU92azRXVUNXSnpWeXVyMDFzR1NueFBCTnpRbkdiLzhYWExIZUlN?=
 =?utf-8?B?enMzUkcwckhRbnJjcWQ4QkVwYmllUG44L213K0V4MWRSZ2ZhdVNjQUxYb1NB?=
 =?utf-8?B?UFVEOU9MMGlEc1o5Sy9MUjNXQUxKZktNUHR4YnRXUlowUDA5MTFkQ2s2WGN0?=
 =?utf-8?Q?ljvFiN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6538.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QW9la3RCY3JOd3BVemJ1YVpFL0hTZmNKM2s2Q2Foa0hRUlpPYzB6ZVc2N25o?=
 =?utf-8?B?aU9KdGs5WU9YcnozL2xUL0RaeEpWOGpQbTMzaXRjZytTOU1CTnltNEJnV0l5?=
 =?utf-8?B?cTYyNnM2WldDMlZRQkx6NDFnK0ZqQ1hEK1NSZTU4bW9LVlZYcUhyUkhHOHV1?=
 =?utf-8?B?ZFBVTzF1UklpMkVvZFFvOTJMaG5za1hjOGdPQVZ4TE1oU1pVMHJZMTV6Nk5v?=
 =?utf-8?B?Mmo3QzVNVFAxdTEwcWhTMFU2cHZzTDRDV0xrbitCSnJRY0g3cXdoSG1DT2lo?=
 =?utf-8?B?UmZNV2R5SWdRQXNxcVFZRkNiRExUdCt2MVZiSDRSUlRzTG5MYlJtRjNSd1B2?=
 =?utf-8?B?MndSN282QzBvNzZpbVlINFpObGFEQ0FCb0RtOGQyakZaaE5oZjVmMEdwUCtC?=
 =?utf-8?B?U2gvd0RyMXIvQ2FhcXRpSEovMkpqUkVqUE81WEs4S08vRSs1ZXB5SFF4S2ti?=
 =?utf-8?B?WEdtbndHY25XQk5UQjIzTVhGcFIyVkxkaVNLWlFiLzFSWksrc0d3S3NoeWR2?=
 =?utf-8?B?MXlmS1MvT1pKNGpRcXo0YWtFZWd2SkNNTGZaTUhUYWdONG5LN2VTU1hZbHZi?=
 =?utf-8?B?QWhYL3hvem9tNEp1SzBHaHplNFMrd2QyRlBPc0g2c0FTRkdzRjlLckhvMjIz?=
 =?utf-8?B?eGxIUnNvQ3JLRDdUdEVrdG9PallaV1oydmtLbkRPL2lIamVaYWo5cjhwZ0N4?=
 =?utf-8?B?M05IU3lYbDV2YXdmdDZMR3NOQ2ZBelg0dy91cHYwL01taFJ3cmpILzlXY2c0?=
 =?utf-8?B?VXFLSlZRUmdGUnVpb1B6YXVsdjBSYlpUbXE1MHc0NHVjNVFHeFdlYkJFVzAw?=
 =?utf-8?B?OVNmd0F1ZU1UOGRFMW50bnNMZDZhaVQrSGErRmxOelFrbUFjaDBoL1dsNVMy?=
 =?utf-8?B?U1JzemY4Sm11cmJOQVBycmdNaUZCNGZJNnBNQUllbzJseTJpM3hSKzc4S3hR?=
 =?utf-8?B?VzBVZWVuYTUwRGsvb0VSMmQrTktqQVpjUmtNai9PRmlLVzlzSlVlWTBQWUR6?=
 =?utf-8?B?emh6aDgzRldaWjRYZGdXR3k3TDBBNWFoMHRzTUZJOUxOdXcwK2pzc1lhaUxr?=
 =?utf-8?B?a2FLVXY5YzVNdXlJZzVqR0V3NHdQMDBXY09ZLzdlUEVmd3BoTVN5RzBPSG1p?=
 =?utf-8?B?QmR0UW9sbDFnVlNxTVdJRlROekt0czF1R1lnYXNnM1N6Q3FKbnFFeE9yOWtw?=
 =?utf-8?B?cEFNMGE5TTZLOGE0UVlEVE9KWmhPQmR4R3l6TVphazhGd2owQzhZNEUxMjll?=
 =?utf-8?B?QUhYVmFzbVFKZUxFRHhzWFU1eUcwa3h6U0UwaHdxZEtTTUkzbzgzY2V1cVM3?=
 =?utf-8?B?SCtjOS8xY1g2d01sNzZYYW0wWm1lNUdpMVhtWThGRzR4Q3RJTjdKeTlqM3V4?=
 =?utf-8?B?ZlVRUGs3QWw0M3YrQ1ZpY09sUitQaWxZLzJ3Q0k5K2FNQWZGN2pMWU9wb1Z2?=
 =?utf-8?B?Z1ZDKzNmb1MvNTFYRjBEQk4xcVhwL0FhS2h5emxrdU1nZzNuRVAvTU5Wa2dm?=
 =?utf-8?B?bndhSDZ0UUV4TGJheEw0MjcyVktKbkV3MWpLTWVLWVAwdlhlMEZDT2Zxc1ZC?=
 =?utf-8?B?NGdwK0doOE1rb1I0QW9VR1dEdFpzZFFLYm5MQ3lZMVVVZVJFczB0b1pRR1BN?=
 =?utf-8?B?TzlRN1RabjhxWU9mUkt4UlZOY2RCYWxyTnkyTXl6T2N5VlRocVVCMUVrdGtG?=
 =?utf-8?B?cmFlS21mUXRaZTRtSEN5azZRM25paC9WK21LNnFvMzlnOWtSbDdvQjgwTkxz?=
 =?utf-8?B?ektGVkkwMVN4Tkp1VkdlV0ZJRStlTGZ1V1kwZFg4dUk5RWpvdktUa2Z4bThh?=
 =?utf-8?B?MUpkTnoxOEhkZzRUdU5rbG9tNnk5ZzNnOGdvZGtmMkRLV1V5ZCtZcWhSOURC?=
 =?utf-8?B?aVFIUTJOSG9JVndVREM3ei9hZHJiUnNFUEk5aFlaeHN2QzJSOVV3SzFMa2hX?=
 =?utf-8?B?cTRVa3FhRUMvZGsrVitoRjFGbXNic0h1TjFkVS83Mm9hVHRzbjVhSzRUOXE5?=
 =?utf-8?B?WnVmUWdId0VXc1RyamYwN1B1WFJIeXRNbUIxVnZ2dy9Kd0xPMzRVcE1raWFO?=
 =?utf-8?B?ZTRNZkpWNThHaW1GVzFZSlVzc0ZmSEdXSHgvTnRWa2MxQ05kOGo4bVl6OE1i?=
 =?utf-8?B?VURTczM5ZXZwWitCN1piNXIzRnlob3lCOXJaeUFmU08wVkV0bkx0ZDNpNUVW?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F6135388E339E49A5F62A0DF592DC9B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HMda7cJ7p5PGmDrUajvmWIsFhEtKG430oH5VjuSM0XyUzhej4qFIIjPGxnJl8VhKNqwAka4ASzMOq1a1H19caBRbv6Ppns8BsQiAFQXtKyTK8TNr3hEABUWn5VcxqKsuUE0In7TVJbXN5a3mJCk0OzXcbXvoaMW/pg6a5HAK5FneMckhdBnlrRK8J5Q7Up/O3bRfSiIBguzK3SsLIDEAO2Vg6gFvf+F6QeHuogOhcekMPfD2+bEDmCNnWwNflzEWXXAQ3vlqo0WbF95lFIJ9SMSiAWUuCVKDnO1R3LUVLreuJxgPmdL1IBAt5Mf+V22tt5JoO34Xnw4s3lfVjAIYifbg4ZEU4Ae3ND2LIDPKKx8fo2Hv57LVbWbWPygeKsZKBTDAM+fxNz8ixR/vLcCHhhty3nRFpKMWLkESooDriJZvnCN/cFFdchbpxT/8ZkZPmjqEsxvOZFfVR6qkEi5nfHWYoYbmMkokjMzE034SxBFQoz5huz8P01d2S9vmDv2nlNTR/0FchxsFGz0RSWOug2HqUzrZ7rXedTTKYMH2SCNH4scZfN10WX4e9HwBIHlEZA+Dcq8eHosxIut73h2MJ42IcIed0lZOk6bmedHSP3g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6538.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42eb442a-4d47-4612-db60-08de0b5e883e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 20:16:17.3668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4+QhYN+XeSt1KB9ifE1EYr+WzC9C4sAFOZG1+VdrmZLOMiSkRcWMB72jT7GygJtjTyojmPK/e95+HkPT1WmHxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8221
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510140142
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNiBTYWx0ZWRfX+95vgxj77d/z
 0Nq52NukZmU/3V7hUkoPf23NdqpfDeSfY2upgBXvtbfYfjpa/IecjTGVJTqxaqkElKxVMqN6cOt
 E6KCstOvWOzYoTr1Ox76N98mcA/qQtNsvZPL3Q4NBgkTqYIyhM+kCt0tY3zyJt+bPqJKmLCb2kA
 Sa1XKMPbOLiXzFTcZhpOyP2Pg6U9XB92TJSrRKQ+7oHbPEYxMeNtr4dmQgZxlZyqSTqF+dvByDL
 DrB/3KmzudjI0Z+6JdVYalTcVYlqcIEk9p5Uk0CPwcVvv9KhvxwVHliyzhLzY9IQmEudC9S0oN4
 ZazV3l5zPkRlhQt3UmS9TcCey0iuH2U2iCyaqV0YKcIBuFo2dB+P7HuKbB0D6iJ/O3QSp7bYK+F
 wrjOS91izsbGNg7XtpciuLbLl6vUpACLbsh6oO07e5fkMMIA9ZA=
X-Proofpoint-GUID: a7IY7yH77XJtB6UEucFP-PHfrYCGsskC
X-Authority-Analysis: v=2.4 cv=ReCdyltv c=1 sm=1 tr=0 ts=68eeaf94 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=AE_H9iSivJjvm2MY9GgA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13624
X-Proofpoint-ORIG-GUID: a7IY7yH77XJtB6UEucFP-PHfrYCGsskC

Q0PigJlpbmcgQ2xhdWRpdeKAmXMgb3JhY2xlIGVtYWlsIGFjY291bnQuDQoNCg0KPiBPbiBPY3Qg
OCwgMjAyNSwgYXQgMTA6MDksIFFpbmcgWmhhbyA8cWluZy56aGFvQG9yYWNsZS5jb20+IHdyb3Rl
Og0KPiANCj4gDQo+IA0KPj4gT24gT2N0IDcsIDIwMjUsIGF0IDIzOjI5LCBLZWVzIENvb2sgPGtl
ZXNAa2VybmVsLm9yZz4gd3JvdGU6DQo+PiANCj4+IE9uIFR1ZSwgT2N0IDA3LCAyMDI1IGF0IDA5
OjAyOjIxUE0gKzAwMDAsIFFpbmcgWmhhbyB3cm90ZToNCj4+PiBIaSwgS2VlcywNCj4+PiANCj4+
PiBJIHRvb2sgYSBsb29rIGF0IHRoZSBwYXRjaCB0b2RheS4gDQo+Pj4gT3ZlcmFsbCwgSSB0aGlu
ayB0aGUgcGF0Y2ggaXMgZ29vZCBhbmQgc2hvdWxkIHdvcmsgd2VsbC4NCj4+IA0KPj4gVGhhbmtz
IQ0KPj4gDQo+Pj4gTXkgbWFqb3IgcXVlc3Rpb25zIGFyZToNCj4+PiANCj4+PiAxLiBBcmUgdGhl
IGZpdmUgZnVuY3Rpb25zIGluIHRoZSBjdXJyZW50IGxpc3QgdGhlIG9ubHkgZnVuY3Rpb25zIGlu
IF9fYnVpbHRpbl9hcmNfKioqIHRoYXQgDQo+Pj4gaGF2ZSBjb25zdCBhdHRyaWJ1dGU/ICANCj4+
IA0KPj4gVGhleSBhcmUgdGhlIG9ubHkgb25lcyBJIGNhbiBzYWZlbHkgYXNzZXJ0IGFyZSBjb25z
dCBhdHRyaWJ1dGUgd2l0aG91dA0KPj4gZG9pbmcgYWRkaXRpb25hbCB3b3JrLiBJJ20gc3VyZSB0
aGVyZSBhcmUgbW9yZSwgYnV0IEkgZGlkbid0IGZlZWwNCj4+IGNvbWZvcnRhYmxlIG1hcmtpbmcg
b3RoZXJzLg0KPj4gDQo+Pj4gMi4gSW4gYWRkaXRpb24gdG8g4oCcY29uc3TigJ0gYXR0cmlidXRl
LCBhcmUgdGhlcmUgYW55IG90aGVyIGltcG9ydGFudCBhdHRyaWJ1dGVzIHNob3VsZCBiZSBhZGRl
ZCBmb3INCj4+PiB0aGUgYXJjIGJ1aWx0aW5zIHRvIGVuYWJsZSBtb3JlIG9wdGltaXphdGlvbnM/
DQo+PiANCj4+IEFnYWluLCBJJ20gbm90IHN1cmUuIEJ1dCBteSBnb2FsIGhlcmUgaXMgdG8gbWFr
ZSBpdCBwb3NzaWJsZSB0byBhZGQNCj4+IHRoZXNlIGdvaW5nIGZvcndhcmQgaWYgcGVvcGxlIGZp
bmQgc3R1ZmYgdG8gYWRkLiBCZWZvcmUgdGhpcyBwYXRjaCBpdA0KPj4gd2Fzbid0IHBvc3NpYmxl
IGF0IGFsbCAtLSB0aGUgaW5mcmFzdHJ1Y3R1cmUgdG8gZG8gc28gd2FzIG1pc3NpbmcsIHNvDQo+
PiB0aGF0J3Mgd2hhdCBJIHdhbnRlZCB0byBhZGQ6IHRoZSBpbmZyYXN0cnVjdHVyZSBhbmQgdGhl
IGZpcnN0IHVzZXIuIDopDQo+IA0KPiBZZWFoLCB1bmRlcnN0b29kLiBBbmQgc291bmRzIHJlYXNv
bmFibGUgdG8gbWUuDQo+IA0KPiBEb2VzIENsYXVkaXUgaGF2ZSBtb3JlIGNvbmNlcm4gYW5kIGNv
bW1lbnRzIG9uIHRoaXMgcGF0Y2g/DQo+IA0KPiB0aGFua3MuDQo+IA0KPiBRaW5nDQo+IA0KPiAN
Cj4+IA0KPj4gLS0gDQo+PiBLZWVzIENvb2sNCj4gDQoNCg==
