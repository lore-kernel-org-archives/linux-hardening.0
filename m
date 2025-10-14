Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CD02D7381
	for <linux-hardening@vger.kernel.org>; Tue, 14 Oct 2025 20:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760472945; cv=fail; b=V+xOMn/py4xA/FbEexqqEf3bU+o/l72lflw4O2z2oxEK4//PSzza0kLfi4hMMCKo97jaY5sMGSOYJgQ8cruhDSyeZHLwLUKhl58paABAhqvADJpC/EhpQ1oZFgsBO4q58iTXKJch72f+jDi9XJFKseJZ2N90p/hWs+4+GNXe+Ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760472945; c=relaxed/simple;
	bh=HLE7ZLBp8lDZRhIi13g3nRbD9PEw3DdSe46CoHi2SFg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YlrPVM0al8+6gNtm773742wTFJsxe92N8gIoQ32am/JMbyIZX3Dov97Ko+Uy9Wu66B6MB5xPZG3jHehYxaTNOPEOABloICuPpdgl3Ls7TAkLlVbgU9hYFmsHdTQ5P1r/qL4/aoI5pv44TbTB8jNoTh9G+jfE/WB8WFScdKK+YsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N69c9Zcx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KcVeyDmF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N69c9Zcx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KcVeyDmF"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EEf7g0003125;
	Tue, 14 Oct 2025 20:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HLE7ZLBp8lDZRhIi13g3nRbD9PEw3DdSe46CoHi2SFg=; b=
	N69c9Zcx1S1JOdXxfvOBP1s1rJZs4LP7rtvo7gKvczq3fAblpkKAK91MNx1C6SMV
	iST4W00IyIoY85XiJ/tXLOiGiOY5M9axuBiADAv4IjL9JI339lFGKXELqn3nimb3
	4KmzHBg1FDdx3UTNSX89Soi0L8XoqCWQHNEKykjKV2mxmF5Rtq+IHG2IIRDEdu48
	+aKyCebWkrVjpo0f4vrfoXf4QzSzpVjnGgKhkj1F3DEUO23kVs48xGHDGrpA0CqH
	ouP4xcr6K5jW8Gq+NjUp2sPmAIIjFP3YABRaoEIHpJw+wE/mq9SDr2cGnOZ4jMlZ
	dRx0HXj/fnn0kdMIgKbojg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qe59d7xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 20:15:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59EIVFOY037106;
	Tue, 14 Oct 2025 20:15:37 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010060.outbound.protection.outlook.com [52.101.85.60])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp9ekyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 20:15:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HHglo0o8Q4/j9oG/LwDlVk99cGNbmjKbixo8IRYmieAFRhPRV8bulAoV/vj43NBcKRDQczOVdkj3uP+EOb3mf9/C9VygmEV/QR2qWmWKjm+Vx9xg+0t9JsW7Ec+tCEFTSKxM44hk1XrNvt7wRwHWlpuAimhmcilHw41UgcAL6ogMkSX+TBXLZAi+hYeCcXQf1zkX7lXcK+NHmdfHjLSpRD/yJx6iPRZuwAE2WzJAAT4+SrmMucW7/F38X7Gb6+O9NA5DvUBTHf+AK7phZZWLBBrTQ2r44VSZv/MBF5TCVa3890ntuVFEPLEY9/26KPTzOyXE5ZHAtztoFr61R0cdxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLE7ZLBp8lDZRhIi13g3nRbD9PEw3DdSe46CoHi2SFg=;
 b=GuIEiYA7Au1Gf0pCqFxb1i5Qnp2TIR/IeWsevJU5x8y+CduQplDi50s3J0k+O9GO1MKIxCVPZtYSdGyA66WlQ4Th0ppt52rSv6Bx8aCqiSoKvca/P2B+PW5qlpW/g43wWBZB1Q9bYd9Rm+vsk6ll4IeWcNs/ABaX8loopJ8w5D/WXNI9vfxMu5C1BbRc+JdXnPG/43H2hi3zu1JM3ufmdOjnT/AD2CU2JFgInsD3vc3wJbZ7+VAWFqDrqq8hwRGPOmM4LVV1Q+mw8esySOk46byPcj9hJ5iyekP8KeA1qb9FARKrjENyk8JFAi4ONRMiePBtCtS9J7tWBdzdyoHpXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLE7ZLBp8lDZRhIi13g3nRbD9PEw3DdSe46CoHi2SFg=;
 b=KcVeyDmFwJ9VfFcMgTYy8HBhxxZsU3H0zuBhtOdsBguumwaodAvvUkVAZOylQsNeyvTSzwtzM51EkOpMCmcnvd4TO8tK40QIgj9aJlRE40cS+BmaW/mz8ryduPr9LKxh97jl/yrBvkV72GXGe6bd2ZSR6CRX5xHa0pSV82agj50=
Received: from CY8PR10MB6538.namprd10.prod.outlook.com (2603:10b6:930:5a::17)
 by DS0PR10MB8221.namprd10.prod.outlook.com (2603:10b6:8:1ce::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Tue, 14 Oct
 2025 20:15:35 +0000
Received: from CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::83c0:6ad9:b202:784e]) by CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::83c0:6ad9:b202:784e%3]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 20:15:35 +0000
From: Qing Zhao <qing.zhao@oracle.com>
To: Kees Cook <kees@kernel.org>,
        Claudiu Zissulescu-Ianculescu
	<claudiu.zissulescu-ianculescu@oracle.com>
CC: Claudiu Zissulescu <claziss@gmail.com>,
        "gcc-patches@gcc.gnu.org"
	<gcc-patches@gcc.gnu.org>,
        "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] arc: Add const attribute support for mathematical ARC
 builtins
Thread-Topic: [PATCH] arc: Add const attribute support for mathematical ARC
 builtins
Thread-Index: AQHcFkEKxM1jfW7R8kqet3uNWNqdeLS3bskAgABsFYCACoctgA==
Date: Tue, 14 Oct 2025 20:15:35 +0000
Message-ID: <75E83F4E-DC6E-431F-97FC-588E4F315DD0@oracle.com>
References: <20250826042212.work.202-kees@kernel.org>
 <1B081822-82F3-43A1-B3C3-B0B377F50CE6@oracle.com>
 <202510072026.568651EE@keescook>
In-Reply-To: <202510072026.568651EE@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6538:EE_|DS0PR10MB8221:EE_
x-ms-office365-filtering-correlation-id: c23e6687-c52d-46b1-31b2-08de0b5e6f5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZVJYdmc5UnVEbmF6R2pKZEVYZEF3dDZwTlBxN1JkeTZjYnZwdGtETUxXSEZO?=
 =?utf-8?B?VllWZXFnTDRjcFlsWExackNOQXl3U3dLRVdyRXhHYjRnaFlKTExWTkVrYzFE?=
 =?utf-8?B?a2FCTy9uSG9oUFJ2UU9lbUNZK0pzWmpvTjE1UjV0OUdUdWpJemtPMUFlSGgz?=
 =?utf-8?B?dkc5RWN1dGFOYUdNaitHOVQ1NjA3aUQ0M3dlR3R3Qmw0amlxOUZ2a0c3dGJN?=
 =?utf-8?B?Nng0aSs4VHUwY2dRYnl6UXBLK09Ed1REQ2ZVNFhkbzRrMm0yZjJTbUpsajVy?=
 =?utf-8?B?MWV5RHNLWTlmTkI2aXBSNTFGd0ZQZC8veUdyNWtOcEpIeWJhV2p4ZTlJWkpY?=
 =?utf-8?B?RUNTNzJQNzJHeTBBeThndHZyR29sbU5wNytJckZoNk54OFN4YjBQZmVobGN6?=
 =?utf-8?B?WnJjbFlWZGEzd1dYVUl2bmNrMzk4UVEzYXlhTGZYUXB0Q3FXV29xbUhiK2sr?=
 =?utf-8?B?V2hIbFkzWWxTd253d21EcGtDZDhMMEUrRlZNc0QxTXZCN2xXQUlSY0huaG1C?=
 =?utf-8?B?VG5LSHVoSjN1TkVFVWtBK3hzbWdEVmhBalJ2aHVXbmo5QmYwRmtZcG1YNm9n?=
 =?utf-8?B?Qzg5STQwZVIrdFNPdlVSdnZrWkNNS1BFTHIxNy9WdStOSEl6Wjk0UThWQUNB?=
 =?utf-8?B?MmwydGpRckJWYldQejlVTTdjbTduOStXcTJSK2lqdERXSjBZanB6aWQvMjU4?=
 =?utf-8?B?ZTRlNWltcFJFcmZ1cmFFUUNhbk16ajlrQk5iWUNhd0xjQ1FpWitBQ0xteU8y?=
 =?utf-8?B?endNODA2VHo4RFVtZ0VOUlVLOGNCVFZCZVgxUjFMMElUUmlGNDlvdXhlV2pu?=
 =?utf-8?B?MW56VWR3SitoL1BueE41RVNKbWx1WkJxSkh0clBaVlkrcnVZU3E0dWtYZ0xq?=
 =?utf-8?B?SENoMlpQU1JjZm9TVDRReW1XTnV1d0NkbGNuOGE3dHBtM2JKdW4rTU1Xd1Vw?=
 =?utf-8?B?bHBBWDRnTWFvQUduNXBwRGxlN1BvWHdyc2pvMUpXb2xDZEJXQXpibXVzOGM2?=
 =?utf-8?B?Sm5IQWhCNHZXaG02MU1ZZy96TC9veExMR1pyaHNEZHcvVlBsQmZYUGxCZHFO?=
 =?utf-8?B?R25wQlEzQ0lBd0xpTVBYdFp6bW1lR1FvTlVRRkJ2V01GWnN1THR5S0hNZ1h1?=
 =?utf-8?B?bmFXcHA5RThuZ0dvZHFucHQ5WE04bXhzeE9ZNU02SHFTaEFSd1JvK2E3ejJn?=
 =?utf-8?B?RUVmeU5OaFp2S1ZYNXFhQW9YZjVoQzRKTjYzenMweDZEMGJlbTZoY01iZjd3?=
 =?utf-8?B?ak1MM3JycjlBaHpQVEowMWs1SThhOXI0RXlWN1FSMkdqRkZjR291Qit3czBQ?=
 =?utf-8?B?ZGVYU3FWamVBbktXUjNKNVJPSXJCc04xTXNycDh4ZGtYeTh4WTAzRUNOWVBV?=
 =?utf-8?B?WldvQTZMWHVJQnJITU5jbXVBRTdTS2FjcmRZVTdTSFFsblpSZ1JDUFFwQWFM?=
 =?utf-8?B?YXY5R2FBQnpUaHFSM2tmWTljUmcrNkV3Uy9OTnBXcEFTcHQvblo3M0YwSjIw?=
 =?utf-8?B?cjBaNHFGaVNCUWIyYzJ6S3ZsdkR0VnpsZ2hRWDBSV3d2ZXdoMnRmQ082MHk2?=
 =?utf-8?B?MVNYTDVPNFBUYUcrMGhvOFY1RmJsUExRUHV2NysyamdNeWNxK0VoQkw0SC9x?=
 =?utf-8?B?SVNTMHhXMmZhS1ljU3pKR0JNOGNjT0sySGo3ZjhKTk9Nbmo4N3pEUXlTWDFJ?=
 =?utf-8?B?bDZmR29lL0YyMWw5TnpYYlZpTGtUcFF5L3RpbWtRbUdadjdIV2lqa0RHRERi?=
 =?utf-8?B?V2VuNCtvS3JTTXRIMWFDRk96ODROM2d5UlgrOWl0Z2VKc3lobXYzNlAvT1I0?=
 =?utf-8?B?YUgzc3FqdnBMUVhoRG16Qzk3eDhlaWtDSmxydVdadERCRHI3bzA1Mkt1K0sv?=
 =?utf-8?B?aVlVZlUyd3BMS05jVzlwTnR5bmY2ZXlJMThHZ0lDemRzZko0aVF2SUdpK014?=
 =?utf-8?B?L0FFN1dwM3RqSTFUU0Q1NzR6RG0rNlZLNDRWZTJqNjlkZ3ZLU3VSVTVTSlVp?=
 =?utf-8?B?RGtMZVMvcUovb3RtWlcxU0thMmZYSlBkTFE4NWN3MnZQMXlVY1dPRjB5dUVC?=
 =?utf-8?Q?0KJfaT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6538.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VzdUbVRjbkx3SzhRcmxtUXc5bnV3QjRUS1lOWllaUUVKWW8zaERzVTBiTVNq?=
 =?utf-8?B?K0lOS09VeTZvYWRxaytFMG1LME5kWWpRK2JwQ0hvS2gwb2x5VG92dmRwNkxV?=
 =?utf-8?B?MisyKzZ3c1RUT3hnWVNMbWlyaUE1NVlTUTg5akRvZFlrQzVRV0FoMEdCdmFu?=
 =?utf-8?B?OC90a0Y2Zk8wVHIzUWdhZno1WnYvNm10TzIrQjZRLzJOUkpNZVdLaVpUMkRC?=
 =?utf-8?B?UTE5cmpyUHNucHE3S3FLd2lZQ29wOU0wd2NLcWdLK2NOMEhOanZiME1QeVkv?=
 =?utf-8?B?Rkt0b2RiZzhkcjQ4K1VZem9aL3B5bzc2aTB5VXZQb1NlUVJOZjZ4UEtRbEND?=
 =?utf-8?B?NDJFYkRYMTNzTHRmN01SVkM5Ui9FTGF2N3pJRStYaDBhN25YVHZwVDdzN201?=
 =?utf-8?B?clpRUUhiV1Y0aUdvc0s0OG1naWlYcURHWGdtTEVIMnk2Y01vMURKaXFpZytv?=
 =?utf-8?B?S1o3WjVsZGhSUnY5cDAwK3dMellLTXl1WlZNUmRVOUJnWVZBS0RHWEo2S3dl?=
 =?utf-8?B?ZE5lMy9HQUc4b1kwb2xoMXorS0JHdFdVM29yQVBlRmJTMmpwdGtOdDlVMXV0?=
 =?utf-8?B?bUtDaGw0TkVhei8vbHA5YUpYVnc3L0RBNnYxVXI0emxWdTFKVkRjKzFsdXo5?=
 =?utf-8?B?R1NaWkVCdGJ0eE9Uay9KUzY1WVZaSjM4Z1RBYVVvKzA0WndpZXB5c3BOb1Mv?=
 =?utf-8?B?eGdVOUtSbTNnNHppWEg2YVB0ZjdlanRwM3N2TmtMc2hpcWlhZjZ5VTU0RHhi?=
 =?utf-8?B?RHNtK2hJK1dpUllseGZXSnp2MmZPSWJPdUR5MTB2VHd6dmpJUmVPT1JaOHdR?=
 =?utf-8?B?Rklza1ptUU5EMWJiMGhEeGZ3aXRtTDF2M1RrblIrdEwxd253N2J3b1NyR1Fi?=
 =?utf-8?B?cENGaWYrSzk1NEhJT2pIVUgxVHgrL0FKQ0V5ekZabGRGUTV6cTRjeXI2YXpD?=
 =?utf-8?B?SlRSTy9mdXhSS3VNanREbU94VDJnaHRETFJYN0pudU9xUWVMK3Y2cDRFMER5?=
 =?utf-8?B?clJaUUo3TXl3UklMZFJ0d1pZelJaci9lWWsydkdhVmtTK0dZN1FINWE0L0Ux?=
 =?utf-8?B?cmQzUVdHVkRJM1dqQnFpRnJIdVNILzd2OEtYZ0VpL0Ztam9ieDgzK2daeHUr?=
 =?utf-8?B?K0JTandiclo4a1Y4MXJLUE9mdjByT2hZVzJDcGtGd3BQYVYwQjBjTzE3SjBN?=
 =?utf-8?B?aHBIdnc1YjI1bTJPajdkOURiQklwR05BdWFwczQrbXlINXZaNlJ0Z1hRaEdy?=
 =?utf-8?B?N0NJUHdXMkhmRUNDMXdaTkNHdk90WmtveUpYUlRYeVBIdHQzeUZXb0FjRnZz?=
 =?utf-8?B?QStnNkRicVRUL21kMHBib216SnhZZVVId0ppd0tGRzdUeTdWVHBBYTQyL1hT?=
 =?utf-8?B?WGpUZjhGenYxajd1QVhCY3BrYTRYMXRSYUFXQVZqaWk4NFNUaUkxekRtTzY5?=
 =?utf-8?B?d29WaUZVY0czSG5WTzVta1plWGVwaHUwRzV5WFZaOGpNYVVXZnI4REtNRzJB?=
 =?utf-8?B?Z3RVVUNLYmEwenhjMWQ1Zm1ZNFYwd3dORGZsZHFFMWhFZ2IxVmRKdHU0c1Jq?=
 =?utf-8?B?NXNpeU5UOGVZZGNTc1BUSEZwc0tNbENMbDVSdS9aVHVQUXBvdmNjRktSSXhM?=
 =?utf-8?B?RUQ0S09wTHZpMDZqcnR4TWpUUGEzWUtualJIUGp1RzdWYVNsTEhXRXVWZTlu?=
 =?utf-8?B?NzhmUllVK2M0TEV3b05zVmRaUk5JbHl3RmpGTHhSQis5OUgyeXR1YlB4bVBQ?=
 =?utf-8?B?c1haRU1jUEhXTEh6Y0VlZm9pSG45Q1JaTDhvQ2JzSjVVbFBBTGVrblJadzYz?=
 =?utf-8?B?OEJxcHFQWlRCb3RFVUNhaHZGWXVRUzZ4aWNVOFF4eE5lQytUWWNqazJhWVhG?=
 =?utf-8?B?NmlRdkNENDJZdUJyc21oQXA5eXRrRlpkaGxxZm82eFphMGVtN3l1V2NreGhJ?=
 =?utf-8?B?dk45STMzajN2UEExUXNiZWtPMndDNjJOMEU4MjE1RHhQa1ZaNllpemkvUDEy?=
 =?utf-8?B?SHAzU1A2SkJyUnVaczZROGFQSEQyY3NiS0FvRkpKbnArRjVhdlA5NEhOTks1?=
 =?utf-8?B?Mk13OGxpN0htK25QUmc1dGNXeExBZkhLTHNDci8xRHZMaXBFUWNLVHdmenJV?=
 =?utf-8?B?RkFJdlM1N3Z6VG41SzlpODB3T3BnNmM4TDgrLzNHYzZ4QjZaUHNJcVNKMmU1?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <464330FE4D3BAA458BFD006EE2CB4A6D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BPDnXR86hGmA0ppHAiIp4Do9ruzJanORNz14y77F8jLVTcyVBse++FXqFOWDSZHRKw9Dd8rsOHCh2imNi/wVdyUDmTWPknBs2B0wsNnR3MHos268njY9+38nQ6fGacQ6J90j1GjLlvfq/lm/zfosSxhMlwW7i0qpGe/LJ387slXkQfgH2KknmCefN9C3ijKfgIXtWSu5k1bcaDofI+L62kMHZGWemyOZttGek8bTiqASE69D5ocxNE4LCqsGI4ASX4whHO2x/YBgRkP6/Cwkf80j7S+gaV/qx7G6C7d9eZeLkBvzn5yfX2kii2qo7+ZjBw6RGqA2Y9hPS7+74chxiPi4eqE32goalpfj77sB/JopEFpDiY93JYu25zprcx4ll3zaWn0lX2b7wiC63Bu1mZdIgfS0RtuvRVjidnALSk+YL0OFFD1VHPkrAeyCQXYQ0RqtL1p1wzk72A2SOSW9kVkVG8dPkclaArD5fsvPAu5Y1dMgpda2qhbn57Dpe07nMcjeT1oDgoj5CSMlB02uwD9n1h7WHtAB8TBMvzhTpDOZzEb5zJKlu4HbMm81uOqxNshG9pBIjjaAPdKzjNTJtydOMp34/sMgBD3rNUcUWwo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6538.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c23e6687-c52d-46b1-31b2-08de0b5e6f5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 20:15:35.6272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T05Y8UiZOLV69e8Yr2t6OzNxs6NNhfwHN8DTyJqYFCKt64QzNlv1WrTgp2fdTeutzEPRvijCO3Hi8PYVLoWfVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8221
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510140142
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMCBTYWx0ZWRfXxETYp5W693jQ
 RWNNFUg1yR1D9f0cFSNBc8zAuw2Jy6vyfOfrwqw6h232nZxOkXgfNhan92duJQSD8TjAkSEoTTp
 TJ1ja+u9h6y7t0p+0EApVhMq/faEPZBWiQS6TC6VOZ7xNRn9vYkuU37K79Gn3J48oTQQvewVs9u
 2Oli2VgYWhnKB8BS2qSgBSSY19TKkC8A9Cy8E2rn5Lj0w1U//JQfcAwgpCe0eakKzDC4Nqpe6dY
 kxLKv6q7Dv3xrZet7hJTGeq5Tm85txErYnlkX8pRhg1YYs5t9ylC0xue9HAa5s2HSBVEY0F5dUJ
 zy8n2fAQolhtzZUDsTMURH8Kup3AjAIIW4x6r4NGRCgbfNy33ngtNOrwYdg6gWXCe/u8zGHFNJE
 ZHrto8ObFRha9BuxZWqqhQiOpxzcJw==
X-Authority-Analysis: v=2.4 cv=V7JwEOni c=1 sm=1 tr=0 ts=68eeaf6a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=UHVlB3au9_2PJK93KAsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: bqz4OMNxt7H2XuV0XDX57nscnSrFGNiv
X-Proofpoint-GUID: bqz4OMNxt7H2XuV0XDX57nscnSrFGNiv

Q0PigJlpbmcgQ2xhdWRpdeKAmXMgb3JhY2xlIGVtYWlsLiANCg0KPiBPbiBPY3QgNywgMjAyNSwg
YXQgMjM6MjksIEtlZXMgQ29vayA8a2Vlc0BrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFR1
ZSwgT2N0IDA3LCAyMDI1IGF0IDA5OjAyOjIxUE0gKzAwMDAsIFFpbmcgWmhhbyB3cm90ZToNCj4+
IEhpLCBLZWVzLA0KPj4gDQo+PiBJIHRvb2sgYSBsb29rIGF0IHRoZSBwYXRjaCB0b2RheS4gDQo+
PiBPdmVyYWxsLCBJIHRoaW5rIHRoZSBwYXRjaCBpcyBnb29kIGFuZCBzaG91bGQgd29yayB3ZWxs
Lg0KPiANCj4gVGhhbmtzIQ0KPiANCj4+IE15IG1ham9yIHF1ZXN0aW9ucyBhcmU6DQo+PiANCj4+
IDEuIEFyZSB0aGUgZml2ZSBmdW5jdGlvbnMgaW4gdGhlIGN1cnJlbnQgbGlzdCB0aGUgb25seSBm
dW5jdGlvbnMgaW4gX19idWlsdGluX2FyY18qKiogdGhhdCANCj4+IGhhdmUgY29uc3QgYXR0cmli
dXRlPyAgDQo+IA0KPiBUaGV5IGFyZSB0aGUgb25seSBvbmVzIEkgY2FuIHNhZmVseSBhc3NlcnQg
YXJlIGNvbnN0IGF0dHJpYnV0ZSB3aXRob3V0DQo+IGRvaW5nIGFkZGl0aW9uYWwgd29yay4gSSdt
IHN1cmUgdGhlcmUgYXJlIG1vcmUsIGJ1dCBJIGRpZG4ndCBmZWVsDQo+IGNvbWZvcnRhYmxlIG1h
cmtpbmcgb3RoZXJzLg0KPiANCj4+IDIuIEluIGFkZGl0aW9uIHRvIOKAnGNvbnN04oCdIGF0dHJp
YnV0ZSwgYXJlIHRoZXJlIGFueSBvdGhlciBpbXBvcnRhbnQgYXR0cmlidXRlcyBzaG91bGQgYmUg
YWRkZWQgZm9yDQo+PiB0aGUgYXJjIGJ1aWx0aW5zIHRvIGVuYWJsZSBtb3JlIG9wdGltaXphdGlv
bnM/DQo+IA0KPiBBZ2FpbiwgSSdtIG5vdCBzdXJlLiBCdXQgbXkgZ29hbCBoZXJlIGlzIHRvIG1h
a2UgaXQgcG9zc2libGUgdG8gYWRkDQo+IHRoZXNlIGdvaW5nIGZvcndhcmQgaWYgcGVvcGxlIGZp
bmQgc3R1ZmYgdG8gYWRkLiBCZWZvcmUgdGhpcyBwYXRjaCBpdA0KPiB3YXNuJ3QgcG9zc2libGUg
YXQgYWxsIC0tIHRoZSBpbmZyYXN0cnVjdHVyZSB0byBkbyBzbyB3YXMgbWlzc2luZywgc28NCj4g
dGhhdCdzIHdoYXQgSSB3YW50ZWQgdG8gYWRkOiB0aGUgaW5mcmFzdHJ1Y3R1cmUgYW5kIHRoZSBm
aXJzdCB1c2VyLiA6KQ0KPiANCj4gLS0gDQo+IEtlZXMgQ29vaw0KDQo=
