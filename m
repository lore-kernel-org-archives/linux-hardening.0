Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8838630E0F0
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757685751; cv=fail; b=X7zivFYnIxOSiME/3UNSe5sDiMfK4tD0oNXVqWjfPVxjiPfiw5ve9ODTtVju76cXjFc3qIVyDWJOAORJeOh1GmjsNlWC2OpXhSXJ/Vs3sy4eo2DQb/lPpseIXgEmYmhAdd6rtDFlfQ2L/5zaQAvowsADbIPih9XttZYZ5Sg5U9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757685751; c=relaxed/simple;
	bh=qdMZhwixtG1QigOLi4wYfaYNaFuQR7xTxPKpMuxcW5c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i7VaUnjEmWugOBhDe4LgvP67lE35UVr4VdcMHfUJjeuCUbUt+DXD/Syofa4xsBeVmQcVo/YPCe/k34RyaVcEjftzlspZagFwU5b3veMq6/2N1cihEA8HNjL5bJkLZ16gjlY5KwowqyyMBCVCXYobmZYnGKYMORGv20uN5gaJHy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ICpcvcCZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KWXWiJ9L; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ICpcvcCZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KWXWiJ9L"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1vvXX019342;
	Fri, 12 Sep 2025 14:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qdMZhwixtG1QigOLi4wYfaYNaFuQR7xTxPKpMuxcW5c=; b=
	ICpcvcCZPBtemjU5krF13P4Ll1072vrLojVg5aetSl673kkrLTwycMXpoSzfD7yT
	Q6gb+O/30aPS7a8EmL/KwbtxEGXBaNQfjbasfxVl9Wp9LnIQsvSxmXqkzoIEdBQJ
	Z7oFKa3D087jMQlQU9PgciQHP2eEBZTH8IGoSOmvMirxR5T2OTCs8e6QpO3Dr1fb
	gDDSnuzlEDKiAJ7UE4+yCHk6pyhPdB8LaS6+0pkGgBTOhlFash19ABz4z6aMc8Lm
	uNbVxI91U0DCqwzeg5nOK3pxVMwojtdJvonfyIpaFnT5mpa4tyVUYPrULPftNQFG
	TjiIGLAcUWDLeequNrLDTg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49226t0a2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 14:02:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58CCcUwQ002850;
	Fri, 12 Sep 2025 14:02:01 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013071.outbound.protection.outlook.com [40.107.201.71])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdmes78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 14:02:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUc19lKppqF32NSOyFMatJaIuxib3NymtJpYEgymoQjYuHxSFNXUG66vvat1SiO9Ynj4qUtBiJuhCb4UaQFX1ulACwpNo/XPxeFrGF9ecHNCYGnoR01tbOXM5wHTNn1XdTVMDEZ+13GwVkJj3TuQQODLfLWeVXtnmi3sfWdFe+C1YdW2Lh5xmGbGiA2+vOpTO6bqwXG3Cu2r9wXtnp4YriioL32g6u/22gztS7aWI+szzbtnJ5i3bH1wLO0wL9iP8QSma+h8oKMBTTpT8DuW8/Wtsc0rSHb/8vhu/d/IreVsC9MTVZnn3tO4UIcDt3VtevOfUoV6z3NRFk9F9OBwiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdMZhwixtG1QigOLi4wYfaYNaFuQR7xTxPKpMuxcW5c=;
 b=QJQc45DNJH09at7GgmbxZQpmZF4o1en5rbpyWzjrV2HLPbPBBHDQXz53i1ZaVwoQ6LHLqaaR5t7d3KvPdrybEYHkNMu//2f17QXOiJQqOczodSGZ0mQq1gTt8npTreXKVMq2DwWLwibFjtyx3CDLevkR3uaMZ7LNa7vtkEszdcf4Yx3iGAv+gEv/En/IudttVstkA0cEoVCBURq9gmLRJAqJG0i6RlqcLCw/aWzUzp5ojxJIDE+YfXleLAZOBalGTA5s9F4Xm7yddoEK/hfvkEEHYVq2NBC5nBi0BaF1gVODg0vbl6kKenivxA7C9Jr9qfCauvuwBZm37TAKwGrFAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdMZhwixtG1QigOLi4wYfaYNaFuQR7xTxPKpMuxcW5c=;
 b=KWXWiJ9LpuiJpkNkyPiN6TtNEfbAk69E560ncl07wgLGUqkRVo+ge3jbsLtKeQa/qicmtFqC8vMeyCa4KIW6wfLY9Y7kshv99pcB14J9FFnTDFCxzTgC/1j7ax7ajs4D1eTp/ZHzsPo3MbxzPhI+rcL0MqFIVgkXMV0n9dD8OPU=
Received: from CY8PR10MB6538.namprd10.prod.outlook.com (2603:10b6:930:5a::17)
 by PH7PR10MB6580.namprd10.prod.outlook.com (2603:10b6:510:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 14:01:57 +0000
Received: from CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::83c0:6ad9:b202:784e]) by CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::83c0:6ad9:b202:784e%3]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 14:01:57 +0000
From: Qing Zhao <qing.zhao@oracle.com>
To: Kees Cook <kees@kernel.org>
CC: Andrew Pinski <pinskia@gmail.com>, Richard Biener <rguenther@suse.de>,
        Joseph Myers <josmyers@redhat.com>, Jan Hubicka <hubicka@ucw.cz>,
        Richard
 Earnshaw <richard.earnshaw@arm.com>,
        Richard Sandiford
	<richard.sandiford@arm.com>,
        Marcus Shawcroft <marcus.shawcroft@arm.com>,
        Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
        Kito Cheng <kito.cheng@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Waterman <andrew@sifive.com>,
        Jim
 Wilson <jim.wilson.gcc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dan
 Li <ashimida.1990@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ramon
 de C Valle <rcvalle@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Bill Wendling <morbo@google.com>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Thread-Topic: [PATCH v2 2/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Thread-Index: AQHcHftv8CjoT2T+d0ijWjIH+YDznLSLOOQAgAIc6oCAAMjJgIABFD8AgABswAA=
Date: Fri, 12 Sep 2025 14:01:57 +0000
Message-ID: <40B4B0A9-FC8B-4681-850F-88D8CE525210@oracle.com>
References: <20250905001157.it.269-kees@kernel.org>
 <20250905002418.464643-2-kees@kernel.org>
 <65CF25F7-E9F5-41C8-9316-F7A461FD35D0@oracle.com>
 <202509101705.92474D66@keescook>
 <A356F147-5B23-46F6-B05E-3BDDC81A768B@oracle.com>
 <202509112321.BFBE82ABBA@keescook>
In-Reply-To: <202509112321.BFBE82ABBA@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6538:EE_|PH7PR10MB6580:EE_
x-ms-office365-filtering-correlation-id: 58b7723e-e548-443d-263b-08ddf204efbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aEd6bTJlNmhQT1ZWQjY4YkVvcVNBQ3NQWlBUNDVkc3NFMUREV00yTmtOTGlR?=
 =?utf-8?B?SThLUkdERGh3WENidWdMRjN3MTA2SEIza1pCejRMajZLVTQ1UDA3RTV4enQ2?=
 =?utf-8?B?S1VrMDY0ZWV4SmRJRHFHN3BpVHhtQU1VY1NUb05Gd3Fuc1JTVi9yUk00YW83?=
 =?utf-8?B?S0VRSmNpS0hiWUZ5R0g2Ylk3U2JCSzVXczJWMGVQb3RuV1VGSnQvaDQySm0w?=
 =?utf-8?B?UU0vdTVmOUU1ZG9YOWRldG9GQnRKZXNpSWdJYjNjcmMyWC9rOVV5VFREUEUy?=
 =?utf-8?B?dVBWRFo1TlovYXBUNTcvOFg5VjNjWDFPY3N3UmxtVm5ZY2dBRnBuOTlMZTVM?=
 =?utf-8?B?MTJuT1BIdFNRT1dJRkZZMmtjWEZES2xTeXF3MkpxV1BhQXNNQ0k4MW11VTda?=
 =?utf-8?B?NUF3eVFRUVlqTm16QURMRE9zM2Y2UUxKMnA4dFI2RVZ6aFdCODFPZzdqdFpp?=
 =?utf-8?B?QllFS0pDOWU4QXo5VEN5cXoyTjU2RjhkNHRGdzBWbDhsQlRWd0NWR2pJcUEy?=
 =?utf-8?B?ODNoTzlIVkpqQlhLSE45cTBBT2ZYRUROaUkrUWcyOFdwdGxLUVpIQWlPbUlB?=
 =?utf-8?B?RmRpWkVoSDhGM1RtelJWRjdpeW0xa2grampjaGlqQWpTY09laFdRZ1BkNktQ?=
 =?utf-8?B?S3NZN2NzN082aC9EaDg4WXBmZ21pMW9CcmoxamhJVDYzM0NrY3NwZ2ZmNkZ0?=
 =?utf-8?B?T2lwZTN4YVp4N2xzZExGOVptcmdSTEJiVDBhRnRPR2dDYmROWUltOWNGS1hw?=
 =?utf-8?B?eTZ0cW9EYVhzRUE0d3ExbmdjaEJCRmhSMjBCY1d2RVVtTm9BSEhick4zVURx?=
 =?utf-8?B?ZVpXZHBwVW9KaFNaOU5oOU9qaWJkSHAzMHlQRU1xTS9YOG9tTGcxL0lMOGJa?=
 =?utf-8?B?a281Ujh4Y1ZSWUI2aHAzQWl1eTY3Tnk1bXNmVDJ3SE4zRzl0NEhmZmUyN1RB?=
 =?utf-8?B?K0d3UVZiME1LRFcyRWNxTVFKOG81ZGhpM05lc2Q4YXZwcHZpS0s5YnhOb21y?=
 =?utf-8?B?V0hweUsydzdGc2tSUEtwUVF1dGRaQzRTVnc2dnl5K2hhZk5mbTFMUkhhUi9u?=
 =?utf-8?B?WTJkZnBiNlVOQm1zWGVYdEwzUVdWK3VSc3N4WUhUUWpXMHJubVhPNjVjS05p?=
 =?utf-8?B?ZUFYWElKc1FZTDduUUppR09HL0VYV0dzSk1uYXFyL2J5cnRlN2R6RDVIUFFj?=
 =?utf-8?B?SW9XeXJaRkxySEY2cWRoREVJdVZqSjltRnlJampxRUgzUzZoSy9jRDhSNW5z?=
 =?utf-8?B?QUlhQWt4Z1Q0djFnSGZVL2NjcEJUVUwrWUNNR0pSS3FidklHUVpSWU9BbEw2?=
 =?utf-8?B?QTY3NXRGSkMzT1NXT1dzajh2NTZFS29Idk5keWRUWUw1RGhDU3JncWNtZXg2?=
 =?utf-8?B?NmZjMklteEpzWjdTMzJDdlBUYTlKcnhoMDlQWjVlazFld3pZRzlpQytST2Rh?=
 =?utf-8?B?a1g5WGsrMGxZOE9ud3piWGphd0dJK2tONVJpUzBzQUVETmFrcU9zUmFzaUti?=
 =?utf-8?B?cGl4OWhaWUhLN2dvUUh5UGp2anJLS3dJb1E3TmJFcFVlTDRlTmNQdVJhVFlC?=
 =?utf-8?B?ZnloRXRNUEs1Y2VURWJ2MDd2bm1UTnhEbnJOR1ZabTNUdStZTThiUFkwTkM0?=
 =?utf-8?B?STUrdE5UeHJBMUtSN1dTQW1hQmtlSG1xeER6NnpLRmQyZzZZVk94dzM4eWVw?=
 =?utf-8?B?QWdXL2pGZER2Q3p6alVuZFl0RG9ORGI5bnljdkx0b3dUS2xMbEg4N0E3Wm0x?=
 =?utf-8?B?VmFpUWdaUjBoQnFMdzUzbGlUaXJFdUZLT2M1UFFuaTlCTUcrUVhERk1NbEN2?=
 =?utf-8?B?Q2ZLNGlVbFNUZXlRSXBIVG5Zb3FkUjhXcTRSUmN5MTdFYUpPQUtGVEJuSGhI?=
 =?utf-8?B?OGtOWmQvdXhVUkNNTnFWeDhLL0l2Qm1CVHRrSnoxTTlhVEI0YjRyY1RzZW5N?=
 =?utf-8?B?ZnFqVTFIWDM1NnRCYU80ZnFRS1EwSmxxRi9wQkhheXFtNGVmNnJNUGpRVWV0?=
 =?utf-8?B?ejhZWkhGcGVBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6538.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UThEQ01vQXAxTTZBN2dqdzQ5RVMzVUNFL1FmOXRlYzhKMnE0aldGc21ickNm?=
 =?utf-8?B?YTVhTTRabk81eFJPSDZBUU1hYnpPbCtXTEVib0tNWkhhSGY2aC83alAvdkky?=
 =?utf-8?B?a0gyZWJJWS9GNUdhcCtCS3hrSXNEN3JtNUdWMFVXN2pJMkhtbkZvWE9XZ2Za?=
 =?utf-8?B?ajZSYW56ZUVhT2xGN0d2ZWpLcCttcmN2dEtiU1BibmhGeGlFQy8zNW85MlNB?=
 =?utf-8?B?SWp0aHlzNUR0ajE4ZitnVThUUGdBUzhsOUtNdm9abXVBMklPV1hxUk5jQmZm?=
 =?utf-8?B?NnNUZ2VvaHh3K1hTeUhscGh1bUxlT0R1aDlpU1YvWlVCMkNCN21mNmR3Sm1a?=
 =?utf-8?B?dHhLL1pWWTZMNVM1M1JXZllhZ2F4MmpVNjg3NHUyZnEyeG1OM0MrVkNyVjF2?=
 =?utf-8?B?NGJ0RC9ud1FyTEJJYmxpcElFRkhDUG5DRFRVWUVXQTNNS3d2eGwrTlJiMUl3?=
 =?utf-8?B?cE1mTW9TRWtUc2VjcjQ4eFoydUVjM2lqK3lnUGhYWWdtdmRaMXI3S1lEWGRS?=
 =?utf-8?B?eHFUSTVieWExd3BnaS9LOVpuZm5jMEd3d3ZPMjUrVFdmWXE1ck9zRmxKYjBV?=
 =?utf-8?B?UTZiTGVGL1ZpSlBZV0p2VzFWNEhkZHdCL004T2NwTS9rbzBMVGF0VHh2MkpJ?=
 =?utf-8?B?VGtjaEh0a3pCTU1GQm5qRlhJQndTanRHTS9URnJwSXVRa2RZell1bC9TQXZ6?=
 =?utf-8?B?aWVnQkVtcG13M1JLOFlIZWN6Y2lkdnpvVVZ3SnR1cnd0NVp4RDFySEtFUWc4?=
 =?utf-8?B?YVdQaGJFQjB6ZW9aV05ESDJoeGNUN0o5bmVlLzFjVlptN2g2emd3c2lQUmoz?=
 =?utf-8?B?dllrZDFLU0ZseFI0NmhySzdvM2tKUWJMMlhuOVZDcm5iaE1sOEJxanZxejJL?=
 =?utf-8?B?SkdReDVCS3VBbERtemtYY0I2MWpDUDJDQ3RVUnVYaVQ2YzdpR1VsN0NIOUJ4?=
 =?utf-8?B?NjB2YVc0UDNVR3kwMVZCazlvR3JaWTRzN01sL0NrUjdiUG90Tmd4cll6dkVU?=
 =?utf-8?B?N2J6Z3RkNXdDTUMrZVJ3a1dnT2s3Z3crMEpOSE9mcjlidmNvT1pGN055T1VE?=
 =?utf-8?B?S0xSWDNjcThBQUZ6bW93SWNiWTFKREQweEtjWms3b1F6U3pKN3lKTnJEOUFM?=
 =?utf-8?B?NWIvRFA2TnFwdUFXNG5ybnJmVGtNd1g5TUJDZDk1MlZzZUg2Z0x3dTdOL3JR?=
 =?utf-8?B?NHlwK25rYTFmbmZkWWhrYU9oVmxwR2Z0WjdDd0hQNVpjN0VXelFFeTRiOElC?=
 =?utf-8?B?TU9YOFBoTEJibForVUtsb0RaN3huNTdpdkRBWFBIOW5meWRDWndXRGp0QWRu?=
 =?utf-8?B?MnFaNVhWTitVTFhWRVNlYUdmUEV6MGk5OTcwV1BEZ1h2L05OMVZ2Z2pLSEtx?=
 =?utf-8?B?ckRKN0xoUmU5UTdvWkJLQ0hQU0ZoRHliUFl5ODkxcFlpbDkrRFFCUlpiYmhZ?=
 =?utf-8?B?RU9zT091cVFRR1FMS1J1Mmo4Vk1tdEVuakl2MStTalM4dWJ4WG1NbUVaaFd1?=
 =?utf-8?B?YnFuVXlralVMckY4RCtkN1JYa3ZGSjlpSFRXWTNqb1JmMzQyQm02aXVmR0s3?=
 =?utf-8?B?bTk5UFowc2JNYjdxbms5cUxLNW80TkVPejV5MHlyalJiMzZOUVZON0ViNHNh?=
 =?utf-8?B?L1hmb2pMYW9pSnMrTERCZlFBUiswOFgrMmtoVjk2clI1VllXNURJa3pmckVN?=
 =?utf-8?B?MUd1eWh2bElnc3ZxNXpTRzJMeDEwWkRaek9CMVRsSEFTeDF1bDlVWSt6NWJY?=
 =?utf-8?B?cktwWDZqU1E2NXVIbHFVb2tyd2svRUxNNHhndXRLZEw0a2ZOb240RUxtUUlY?=
 =?utf-8?B?dWJyc1o0a0N3ZXg5SU1VSlJqV2RsQ0dsZnRjWkdKa0twNk5OZDhPUFRGZmZM?=
 =?utf-8?B?UHdmOGd0WkNQcGxxSHppS04vQis4YTB6UkxsMldteHV1U0cxZjZ6UkNqZ3gz?=
 =?utf-8?B?L092NXlsU3RpY2k3bGozdlBudmZOK0ZxNE82c2tOT2xJeWpXUmZaczJodVVx?=
 =?utf-8?B?SnlJbDlQcXA1OWljRlZXSkJGSFg3Vk5LRGxGUXlONWZqclRZZ25pMVNzelBh?=
 =?utf-8?B?YUxxcURwNVBTdVlKMVBoRU9DMFlOc3hvN0pXRFgvaytWeGJlWDFhS3FtSER1?=
 =?utf-8?B?aFc0c2VMNloxM0t1b3BKazI1a1JBOXFhMGp6WFYxeHJyMmJ3ZUFqdnFnOG9Y?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA655E77CF03CD49BF1B959B26EDB3FD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tO0qU9nDuX5m8PfO/8oxAOTZavWbF7qzIjczAFs4OpePIMeMKotF0+dy/tVQf6XLxlCZ+N8IJtRr7wBq6mVsMtuLyrTUfIhVnklY9+yxCuOe6g8w5PCDK7ToWoeoYJps5IFOS/BCj9QCqFt3MxmTa7hfxcCnlppcA9m7x2hq5Jj7lxky4MQ/ln/3PTU8qGETryd0yipIXMjT2+gaMZMp0/qlFBN3GKm87CGIw1QF2LhSEogUfUT3yvcC4dUsJ+GjIjpnYPV6LcbpvX1q2ukEEpwMKxKW5j8IKRJn0cMFBDGVTVb4sEc+oaituF2pUD84TnA0mEFfDL6LviCwc3K80i5fRKrqAhhlXvfvTU19o4cs9euA3hQXKRLjUCobCBoiCAnJy2hP5o+DQ7SRGYV5Njbud4RmAliNU2IVobWcGJ4xkAw2nksQBr21pfER3zGuMM2IhcTZrAGmLkEDwR88g+mb6/UMoEzjpRRpo7IAKWj20RsKbag3XxY0ra9POIaEiTgRqAH9dhUi6/LLQk95nCJ/0JeFBRGwuQN2SW5IaghmYAi47v9yKbTWfRv3s0Wab2X3+4ijC3YCp1IWYO1htZKjBEnybooyfw3lSH8TIcM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6538.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b7723e-e548-443d-263b-08ddf204efbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 14:01:57.1966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qK3K/76TJ55JVJ/gXtP3OlbVSi/Kld1NNqEBgvpJcbMzpK3BiAqwDLPlCWfLJrDV7wnLNV0GbikfzWjmVlfiaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6580
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120131
X-Authority-Analysis: v=2.4 cv=QeRmvtbv c=1 sm=1 tr=0 ts=68c427da b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=SwhCuYFGft85SuKpTrMA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12084
X-Proofpoint-ORIG-GUID: 4htyWwWQQ1F_5DqQwAZ3qYgZP1NCeyfi
X-Proofpoint-GUID: 4htyWwWQQ1F_5DqQwAZ3qYgZP1NCeyfi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OCBTYWx0ZWRfX12qfZqMt0vg7
 qQmKk1VXUTPchPEkvMxu/i5zGxiWyQ//gaejv0jh87ett9pHRGZpWn6MeiGQoPSSTdr7yb+Uftj
 9e6A60sArqhmrGjQuwdQ2DOUUFNF4/DyRBVQmNJSnLi1MO7KMde42qhFTSR0QuO7JdehhdyEuwe
 KP40N+nLIcFNYsKkRRgcpFuVmbqFTI3SLTVU/DllQAvNPL9hWp+vOCKodqZ9h2PWOjXDpvX0J4+
 0++9QfpDKu96WKgAh0uvNFUqTAySsK9Ppbf90rtzRGYEQAsw3gSCpV8Kybrsosc8oL9z/dTnVw4
 xTygjeLudnEH25xffLtujxACRZxnVBhVwhv7WocyB+g7NPD/3P7oy41KIQ8DTBI5kj3O1isyjJC
 69oohvZwdTVutDNp8BQgyG/TLBI7HA==

DQoNCj4gT24gU2VwIDEyLCAyMDI1LCBhdCAwMzozMiwgS2VlcyBDb29rIDxrZWVzQGtlcm5lbC5v
cmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBTZXAgMTEsIDIwMjUgYXQgMDM6MDQ6MDFQTSArMDAw
MCwgUWluZyBaaGFvIHdyb3RlOg0KPj4gDQo+PiANCj4+PiBPbiBTZXAgMTAsIDIwMjUsIGF0IDIz
OjA1LCBLZWVzIENvb2sgPGtlZXNAa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4gDQo+Pj4gT24gVHVl
LCBTZXAgMDksIDIwMjUgYXQgMDY6NDk6MjJQTSArMDAwMCwgUWluZyBaaGFvIHdyb3RlOg0KPj4+
PiANCj4+Pj4+IE9uIFNlcCA0LCAyMDI1LCBhdCAyMDoyNCwgS2VlcyBDb29rIDxrZWVzQGtlcm5l
bC5vcmc+IHdyb3RlOg0KPj4+Pj4gK0ZvciBpbmRpcmVjdCBjYWxsIHNpdGVzOg0KPj4+Pj4gKw0K
Pj4+Pj4gKy0gS2VlcGluZyBpbmRpcmVjdCBjYWxscyBmcm9tIGJlaW5nIG1lcmdlZCAoc2VlIGFi
b3ZlKSBieSBhZGRpbmcgYQ0KPj4+Pj4gKyAgd3JhcHBpbmcgdHlwZSBzbyB0aGF0IGVxdWFsaXR5
IHdhcyB0ZXN0ZWQgYmFzZWQgb24gdHlwZS1pZC4NCj4+Pj4gDQo+Pj4+IEkgc3RpbGwgdGhpbmsg
dGhhdCB0aGUgYWRkaXRpb25hbCBuZXcgY3JlYXRlZCB3cmFwcGluZyB0eXBlIGFuZCB0aGUgbmV3
IGFzc2lnbm1lbnQgc3RtdA0KPj4+PiANCj4+Pj4gd3JhcHBlcl90bXAgPSAod3JhcHBlcl9wdHJf
dHlwZSkgZm4NCj4+Pj4gaXMgbm90IG5lY2Vzc2FyeS4NCj4+Pj4gDQo+Pj4+IEFsbCB0aGUgaW5m
b3JtYXRpb24gY2FuIGJlIGdldCBmcm9tIGZ1bmN0aW9uIHR5cGUgKyB0eXBlLWlkIHdoaWNoIGlz
IGF0dGFjaGVkIGFzIGFuIGF0dHJpYnV0ZQ0KPj4+PiB0byB0aGUgb3JpZ2luYWxfZnVuY3Rpb25f
dHlwZSBvZiDigJxmbuKAnS4gDQo+Pj4+IENvdWxkIHlvdSBleHBsYWluIHdoeSB0aGUgd3JhcHBl
ciB0eXBlIGFuZCB0aGUgbmV3IHRlbXBvcmFyeSwgbmV3IGFzc2lnbm1lbnQgaXMgDQo+Pj4+IG5l
Y2Vzc2FyeT8NCj4+PiANCj4+PiBJIGNvdWxkbid0IGZpbmQgYSB3YXkgdG8gc3RvcCBtZXJnaW5n
IGp1c3QgdXNpbmcgdGhlIGF0dHJpYnV0ZXMuIEkgbmVlZA0KPj4+IGEgd2F5IHRvIGRpcmVjdGx5
IGFzc29jaWF0ZWQgaW5kaXJlY3QgY2FsbCBzaXRlcyB3aXRoIHRoZSB0eXBlaWQuDQo+Pj4gDQo+
PiBXaGVuIGRldGVybWluaW5nIHdoZXRoZXIgdHdvIGNhbGxzaXRlcyBzaG91bGQgYmUgbWVyZ2Vk
LCBpcyBpdCBmZWFzaWJsZSB0byBhZGRpbmcgdGhlIGRpZmZlcmVudCB0eXBlX2lkIGZyb20gdGhl
DQo+PiBhdHRyaWJ1dGVzIGludG8gY29uc2lkZXJhdGlvbj8gDQo+IA0KPiBUaGlzIGlzIGJhc2lj
YWxseSB3aGF0IHdhcyBoYXBwZW5pbmcgaW4gdGhlIFJGQywgYnV0IEkga2VwdCBmaW5kaW5nIG5l
dw0KPiBjb3JuZXIgY2FzZXMgaW4gdmFyaW91cyBwYXNzZXMsIHNvIGl0IGZlbHQgbGlrZSB3aGFj
ay1hLW1vbGUuIFVzaW5nIHRoZQ0KPiB3cmFwcGVyIGFwcGVhcmVkIHRvIHNvbHZlIGl0IGFjcm9z
cyB0aGUgYm9hcmQgd2l0aCBubyBzcGVjaWFsIGNhc2luZy4NCg0KT2theSwgaWYgdGhpcyBpcyB0
aGUgY2FzZSwgSSB0aGluayB0aGF0IGl04oCZcyBiZXR0ZXIgdG8gZXhwbGFpbiB0aGUgcmVhc29u
IGluIHRoZSBkZXNpZ24gZG9jIG9uIHdoeSB5b3UgZmluYWxseSANCmRlY2lkZSB0byBhZGQgdGhl
IHdyYXBwZXIgZnVuY3Rpb24gaW5zdGVhZCBvZiBkaXJlY3RseSB1c2luZyB0aGUgdHlwZV9pZCBm
cm9tIHRoZSBhdHRyaWJ1dGUgZm9yIGNvbXBhcmlzb24uIA0KV2hhdOKAmXMgdGhlIGlzc3VlcyB3
aGVuIGRpcmVjdGx5IHVzaW5nIHRoZSB0eXBlX2lkIGZyb20gdGhlIGF0dHJpYnV0ZSwgd2h5IG9u
bHkgdGhlIG5ldyB3cmFwcGVyIHR5cGUgYW5kDQpmdW5jdGlvbiB3b3Jrcz8NCg0KPiANCj4+Pj4g
V2h5IHRoZSB0eXBlLWlkIGF0dGFjaGVkIGFzIHRoZSBhdHRyaWJ1dGUgaXMgbm90IGVub3VnaD8N
Cj4+PiANCj4+PiBEb2luZyB0aGUgd3JhcHBpbmcgYXZvaWRlZCBuZWVkaW5nIHRvIHVwZGF0ZSBt
dWx0aXBsZSBvcHRpbWl6YXRpb24gcGFzc2VzDQo+Pj4gdG8gY2hlY2sgZm9yIHRoZSBhdHRyaWJ1
dGUuDQoNCkRvIHlvdSByZW1lbWJlciB3aGljaCBvcHRpbWl6YXRpb24gcGFzc2VzIG5lZWQgdG8g
YmUgdXBkYXRlZCBmb3IgdGhlc2UgcHVycG9zZT8NCg0KPj4+IEFuZCBpdCBzdGlsbCBuZWVkZWQg
YSB3YXkgdG8gZGlzdGluZ3Vpc2gNCj4+PiBiZXR3ZWVuIGRpcmVjdCBhbmQgaW5kaXJlY3QgY2Fs
bHMsIHNvIEkgbmVlZCB0byB3cmFwIG9ubHkgdGhlIGluZGlyZWN0DQo+Pj4gY2FsbHMsIHdoZXJl
IGFzIHRoZSB0eXBlaWQgYXR0cmlidXRlIGlzIGZvciBhbGwgZnVuY3Rpb25zIGZvciBhbGwgdHlw
ZWlkDQo+Pj4gbmVlZHMsIGxpa2UgcHJlYW1ibGUgZ2VuZXJhdGlvbiwgZXRjLg0KPj4gDQo+PiBP
a2F5LCB0aGlzIHNvdW5kcyBsaWtlIGEgcmVhc29uYWJsZSBqdXN0aWZpY2F0aW9uIGZvciB0aGVz
ZSBhZGRpdGlvbmFsIHRlbXBvcmFyaWVzIA0KPj4gYW5kIGFzc2lnbm1lbnQgc3RtdHMuIA0KPj4g
T25lIG1vcmUgcXVlc3Rpb24sIGFyZSB0aGVzZSBhZGRpdGlvbmFsIHRlbXBvcmFyaWVzIGFuZCBh
c3NpZ25tZW50IHN0bXRzIGFyZQ0KPj4gZmluYWxseSBlbGltaW5hdGVkIGJ5IGxhdGVyIG9wdGlt
aXphdGlvbnM/IEFueSBydW50aW1lIG92ZXJoZWFkIGR1ZSB0byB0aGVtPw0KPiANCj4gWWVhaCwg
dGhleSB0b3RhbGx5IHZhbmlzaCBhcyBmYXIgYXMgSSd2ZSBiZWVuIGFibGUgdG8gZGV0ZXJtaW5l
Lg0KDQpUaGF04oCZcyBnb29kLiAgVGhlbiB5b3UgbWlnaHQgYWRkIHRoaXMgdG9vIGluIHRoZSBk
ZXNpZ24gZG9jIGFzIGEganVzdGlmaWNhdGlvbiBvZiB0aGUNCk5ldyB3cmFwcGVyIHR5cGUsIHRl
bXBvcmFyaWVzIGFuZCBuZXcgYXNzaWdubWVudCBzdG10Lg0KDQp0aGFua3MuDQoNClFpbmcNCj4g
DQo+Pj4+PiArLyogQ2hlY2sgaWYgYSBmdW5jdGlvbiBuZWVkcyBLQ0ZJIHByZWFtYmxlIGdlbmVy
YXRpb24uDQo+Pj4+PiArICAgQUxMIGZ1bmN0aW9ucyBnZXQgcHJlYW1ibGVzIHdoZW4gLWZzYW5p
dGl6ZT1rY2ZpIGlzIGVuYWJsZWQsIHJlZ2FyZGxlc3MNCj4+Pj4+ICsgICBvZiBub19zYW5pdGl6
ZSgia2NmaSIpIGF0dHJpYnV0ZS4gICovDQo+Pj4+IA0KPj4+PiBXaHkgbm9fc2FuaXRpemUo4oCc
a2NmaeKAnSkgaXMgbm90IGNvbnNpZGVyZWQgaGVyZT8NCj4+PiANCj4+PiBub19zYW5pdGl6ZSji
gJxrY2Zp4oCdKSBpcyBzdHJpY3RseSBhYm91dCB3aGV0aGVyIGNhbGwtc2l0ZSBjaGVja2luZw0K
Pj4+IGlzIHBlcmZvcm1lZCB3aXRoaW4gdGhlIGZ1bmN0aW9uLiBJdCBpcyBub3QgdXNlZCB0byBt
YXJrIGEgZnVuY3Rpb24gYXMNCj4+PiBub3QgYmVpbmcgdGhlIHRhcmdldCBvZiBhIEtDRkkgY2Fs
bC4NCj4+IA0KPj4gT2theSwgaXMgdGhpcyBkb2N1bWVudGVkIHNvbWV3aGVyZT8gDQo+IA0KPiBB
aCwgd2hvb3BzLCBuby4gSSBoYXZlIGFkZGVkIGEgbm90ZSB0byB0aGUgIm5vX3Nhbml0aXplIiBm
dW5jdGlvbiBhdHRyaWJ1dGUNCj4gZG9jcyBmb3IgdjMuDQo+IA0KPj4+IFdoYXQgaXMgdGhlIHJp
Z2h0IHRvb2wgZm9yIG1lIHRvIHJ1biB0byBjaGVjayBmb3IgdGhlc2Uga2luZHMgb2YgY29kZQ0K
Pj4+IHN0eWxlIGdsaXRjaGVzPyBjb250cmliL2NoZWNrX0dOVV9zdHlsZS5weSBkb2Vzbid0IHJl
cG9ydCBhbnl0aGluZy4gT2ghDQo+Pj4gSXQgdGFrZXMgX3BhdGNoZXNfIG5vdCBfZmlsZXNfLiBU
aGUgLnNoIHZlcnNpb24gc3BlY2lmaWVzICJwYXRjaCIgaW4gdGhlDQo+Pj4gaGVscCB1c2FnZS4g
T2theSwgSSB3aWxsIGdldCB0aGlzIGFsbCBwYXNzaW5nIGNsZWFubHkuDQo+PiANCj4+IFllYWgs
IEkgdXN1YWxseSB1c2UgY29udHJpYi9jaGVja19HTlVfc3R5bGUucHkgdG8gY2xlYW51cCB0aGUg
Y29kZSBiZWZvcmUNCj4+IHN1Ym1pdHRpbmcgdGhlIHBhdGNoLg0KPiANCj4gVGhhbmtzIQ0KPiAN
Cj4+Pj4+ICsvKiBXcmFwIGluZGlyZWN0IGNhbGxzIHdpdGggS0NGSSB0eXBlIGZvciBhbnRpLW1l
cmdpbmcuICAqLw0KPj4+Pj4gK3N0YXRpYyB1bnNpZ25lZCBpbnQNCj4+Pj4+ICtrY2ZpX2luc3Ry
dW1lbnQgKHZvaWQpDQo+Pj4+PiArew0KPj4+Pj4gKyAgLyogUHJvY2VzcyBjdXJyZW50IGZ1bmN0
aW9uIGZvciBjYWxsIGluc3RydW1lbnRhdGlvbiBvbmx5Lg0KPj4+Pj4gKyAgICAgVHlwZSBJRCBz
ZXR0aW5nIGlzIGhhbmRsZWQgYnkgdGhlIHNlcGFyYXRlIElQQSBwYXNzLiAgKi8NCj4+Pj4+ICsN
Cj4+Pj4+ICsgIGJhc2ljX2Jsb2NrIGJiOw0KPj4+Pj4gKw0KPj4+Pj4gKyAgRk9SX0VBQ0hfQkJf
Rk4gKGJiLCBjZnVuKQ0KPj4+Pj4gKyAgICB7DQo+Pj4+PiArICAgICAgZ2ltcGxlX3N0bXRfaXRl
cmF0b3IgZ3NpOw0KPj4+Pj4gKyAgICAgIGZvciAoZ3NpID0gZ3NpX3N0YXJ0X2JiIChiYik7ICFn
c2lfZW5kX3AgKGdzaSk7IGdzaV9uZXh0ICgmZ3NpKSkNCj4+Pj4+ICsgew0KPj4+Pj4gKyAgZ2lt
cGxlICpzdG10ID0gZ3NpX3N0bXQgKGdzaSk7DQo+Pj4+PiArDQo+Pj4+PiArICBpZiAoIWlzX2dp
bXBsZV9jYWxsIChzdG10KSkNCj4+Pj4+ICsgICAgY29udGludWU7DQo+Pj4+PiArDQo+Pj4+PiAr
ICBnY2FsbCAqY2FsbF9zdG10ID0gYXNfYSA8Z2NhbGwgKj4gKHN0bXQpOw0KPj4+Pj4gKw0KPj4+
Pj4gKyAgLy8gU2tpcCBpbnRlcm5hbCBjYWxscyAtIHdlIG9ubHkgaW5zdHJ1bWVudCBpbmRpcmVj
dCBjYWxscw0KPj4+Pj4gKyAgaWYgKGdpbXBsZV9jYWxsX2ludGVybmFsX3AgKGNhbGxfc3RtdCkp
DQo+Pj4+PiArICAgIGNvbnRpbnVlOw0KPj4+Pj4gKw0KPj4+Pj4gKyAgdHJlZSBmbmRlY2wgPSBn
aW1wbGVfY2FsbF9mbmRlY2wgKGNhbGxfc3RtdCk7DQo+Pj4+PiArDQo+Pj4+PiArICAvLyBPbmx5
IHByb2Nlc3MgaW5kaXJlY3QgY2FsbHMgKG5vIGZuZGVjbCkNCj4+Pj4+ICsgIGlmIChmbmRlY2wp
DQo+Pj4+PiArICAgIGNvbnRpbnVlOw0KPj4+Pj4gKw0KPj4+Pj4gKyAgdHJlZSBmbiA9IGdpbXBs
ZV9jYWxsX2ZuIChjYWxsX3N0bXQpOw0KPj4+Pj4gKyAgaWYgKCFpc19rY2ZpX2luZGlyZWN0X2Nh
bGwgKGZuKSkNCj4+Pj4+ICsgICAgY29udGludWU7DQo+Pj4+PiArDQo+Pj4+PiArICAvLyBHZXQg
dGhlIGZ1bmN0aW9uIHR5cGUgdG8gY29tcHV0ZSBLQ0ZJIHR5cGUgSUQNCj4+Pj4+ICsgIHRyZWUg
Zm5fdHlwZSA9IGdpbXBsZV9jYWxsX2ZudHlwZSAoY2FsbF9zdG10KTsNCj4+Pj4+ICsgIGdjY19h
c3NlcnQgKGZuX3R5cGUpOw0KPj4+Pj4gKyAgaWYgKFRSRUVfQ09ERSAoZm5fdHlwZSkgIT0gRlVO
Q1RJT05fVFlQRSkNCj4+Pj4+ICsgICAgY29udGludWU7DQo+Pj4+PiArDQo+Pj4+PiArICB1aW50
MzJfdCB0eXBlX2lkID0gY29tcHV0ZV9rY2ZpX3R5cGVfaWQgKGZuX3R5cGUpOw0KPj4+Pj4gKw0K
Pj4+Pj4gKyAgLy8gQ3JlYXRlIEtDRkkgd3JhcHBlciB0eXBlIGZvciB0aGlzIGNhbGwNCj4+Pj4+
ICsgIHRyZWUgd3JhcHBlcl90eXBlID0gY3JlYXRlX2tjZmlfd3JhcHBlcl90eXBlIChmbl90eXBl
LCB0eXBlX2lkKTsNCj4+Pj4gQWdhaW4sIHRoZSBuZXcg4oCcdHlwZV9pZOKAnSBoYXMgYmVlbiBh
dHRhY2hlZCBhcyBhbiBhdHRyaWJ1dGUgb2Yg4oCcZm5fdHlwZeKAnSBoZXJlLA0KPj4+IA0KPj4+
IFRoZSBhdHRyaWJ1dGUgaXMgYXR0YWNoZWQgZHVyaW5nIElQQS4gVGhpcyBpcyBydW4gYmVmb3Jl
IHRoYXQsIGJ1dCBhcyBJDQo+Pj4gbWVudGlvbmVkLCB0aGlzIGlzIHRoZSBjYWxsLXNpdGUgaGFu
ZGxpbmcsIGFuZCB0aGUgSVBBIHBhc3MgaXMgZm9yDQo+Pj4gZ2xvYmFsbHkgYXNzb2NpYXRpbmcg
YSB0eXBlLWlkIHRvIHRoZSBmdW5jdGlvbiBmb3IgYWxsIG90aGVyIHVzZXMNCj4+PiAocHJlYW1i
bGVzLCB3ZWFrIHN5bWJvbHMsIGV0YykuDQo+PiBEdXJpbmcgSVBBLCB0aGUgdHlwZWlkIGlzIGF0
dGFjaGVkIHRvIHRoZSBmdW5jdGlvbiB0eXBlIHRocm91Z2gg4oCcc2V0X2Z1bmN0aW9uX2tjZmlf
dHlwZV9pZOKAnSBmb3INCj4+IGVhY2ggZnVuY3Rpb24gaW4gdGhlIGNhbGxncmFwaC4gDQo+PiAN
Cj4+IEZvciBlYWNoIGluZGlyZWN0IGNhbGxzaXRlIGluIHRoZSBhYm92ZSwgdGhlIHJvdXRpbmUg
4oCcY3JlYXRlX2tjZmlfd3JhcHBlcl90eXBl4oCdIGFsc28gYXR0YWNoZXMNCj4+IHRoZSB0eXBl
aWQgdG8gdGhlIG9yaWdpbmFsX2ZuX3R5cGUsIGFuZCBhdCB0aGUgc2FtZSB0aW1lLCBjcmVhdGUg
YSBuZXcgd3JhcHBlcl90eXBlIHdpdGggYSB0eXBlX25hbWUNCj4+IGVtYmVkZGluZyB0aGUgdHlw
ZWlkLiANCj4+IA0KPj4gU28sIEkgZmVlbCB0aGUgdHlwZV9pZCBpbmZvcm1hdGlvbiBpcyBjYXJy
aWVkIHJlZHVuZGFudGx5IGhlcmUuIA0KPiANCj4gQWghIFllcywgc29ycnksIEkgc2VlIHdoYXQg
eW91IG1lYW46IHRoZSB0YWlsIHBvcnRpb24gb2YNCj4gY3JlYXRlX2tjZmlfd3JhcHBlcl90eXBl
ISBZZWFoLCB0aGlzIGlzIGtpbmQgb2YgYSBvdmVyc2lnaHQgZnJvbQ0KPiBzd2l0Y2hpbmcgdG8g
dGhlIElQQSBwYXNzLiBJIHdhcyBhdHRhY2hpbmcgdGhlIHR5cGVpZCB0byBERUNMcyBpbiBJUEEN
Cj4gYW5kIFRZUEVzIGluIEdJTVBMRSAoY3JlYXRlX2tjZmlfd3JhcHBlcl90eXBlKS4gVGhlIERF
Q0xzIHdlcmUgdXNlZCBmb3INCj4gcHJlYW1ibGVzLCBhbmQgdGhlIFRZUEVzIHdlcmUgdXNlZCBm
b3IgUlRMIGV4cGFuc2lvbi4gSSB3aWxsIGF0dGVtcHQgdG8NCj4gbWVyZ2UgdGhlc2U7IHRoZXkg
c2hvdWxkIGFsbCBiZSBvbiB0aGUgVFlQRS4NCj4gDQo+Pj4gSSdtIG9wZW4gdG8gd2hhdGV2ZXIg
YWx0ZXJuYXRpdmUgaXMgbmVlZGVkIGhlcmUuIEkgdHJpZWQgdG8gY2FwdHVyZSB0aGUNCj4+PiBt
ZXJnaW5nIGlzc3VlIHdpdGggZ2NjL3Rlc3RzdWl0ZS9nY2MuZGcva2NmaS9rY2ZpLWNhbGwtc2hh
cmluZy5jDQo+PiANCj4+IE1pZ2h0IG5lZWQgdG8gc3R1ZHkgYSBsaXR0bGUgYml0IGhlcmUgdG8g
c2VlIHdoZXRoZXIgYmV0dGVyIHNvbHV0aW9uIGlzIHBvc3NpYmxlIHdpdGhvdXQNCj4+IFRoZXNl
IGFkZGl0aW9uYWwgdGVtcG9yaXplcyBhbmQgc3RtdHMuDQo+IA0KPiBUaGFua3MhDQo+IA0KPiAt
LSANCj4gS2VlcyBDb29rDQoNCg0K
