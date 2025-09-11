Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19747314A77
	for <linux-hardening@vger.kernel.org>; Thu, 11 Sep 2025 15:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757603097; cv=fail; b=diFshTtSVwRxV7qoVwrUi9gAe3yatYQ42SsTq9KGDMSMXh4b3VO5cO/Tdm7B50B4jjcuLmR6AvPboaoMcPi1CMRGdyHVrh4JkcUpGNiNBp1tMKrvrfexnM5FlIi4bGUFlK/ISSO51BQtvBxXbHzRBZ+ho08b8NsQTeLZauwQWJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757603097; c=relaxed/simple;
	bh=zKqgrVye5pIKiC4VSPcR/RfuPxeSIQNxAuKB8ravnbQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oyeThsqcsRc3pBzBR34dYPGQm2IfzLCP5jZWKsKg415rUvkhyhppFc1dRR8SZrqg8e1S6TPgJ2d/PXpE0grxjG1KOFfGHEuEWbOhthQlwcj+uQOFYDh4jCFDkgu2E3bdMtZB60lJJ5EytVRY2GH1lblt821PYGvFE83EGmhJ13E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kTIFaAnW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DOky3zge; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kTIFaAnW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DOky3zge"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BDtkHq005015;
	Thu, 11 Sep 2025 15:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zKqgrVye5pIKiC4VSPcR/RfuPxeSIQNxAuKB8ravnbQ=; b=
	kTIFaAnWOA4qQmYv0ywJHBeOZahKDhrDZx9BKkaq2lT9A1xmQEpCOb7gbj+PyBeY
	gKBaKczVWaaewI0ujxhzU/Ve453/OVnko76Uq3KHOCRSUXw4KdN8TdiO8XFsJ2x7
	pFmpInJO4IXYPEgCBTBCuV2XnKYbZRr8AbGkb2Ue/ZQ/m/40Sa6aBRWFOxJaZRL+
	53mloncmxsrKUZd1qMDHQAriRI73HpDOrl4uCSxFzhkw2HjFGFb84y6W1sA+NnOG
	IgOsBllShSYzzLFouXZvC7bjRcm465pYHFPt1NpzRIfx+GZXGsNQ+QmsgZ3vykR7
	majnnk01gL9wYHH6wSDGlA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921m2xfdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 15:04:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58BDK6TW013588;
	Thu, 11 Sep 2025 15:04:28 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdcrqby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 15:04:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iX4lLzGOzdHhhVKLTW2uB47O7R1/MMIWghjujR0EZBlyLvJ0Dkj/QToNdBMm3pbVXuOUxme29nYmjthTdkcM2BWGeCwuN2KNxC0DHtgc4Citsjr1akClg+C4hcoy1/HzNcw+1ioL7ET9gRlL8+16qQWXRcbNjiRdD2yM5cNuJ4A9OJ3xfU+RAp6tKC2HZleQVnCITr7lxjh6q9ksF9qwrINL7DqXSubi9XR1RJ4Y7g9seRnm5JQZdfJIlZDWj9ic1WoaQmxmxv3b8WyPhR27Ahu+8zXxXmeM6wSZhbGh8zStnIjx8c14heOfOLts1dg/CEqR6xaMbCOC02ojIW783g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKqgrVye5pIKiC4VSPcR/RfuPxeSIQNxAuKB8ravnbQ=;
 b=n1BKUlYUCn2RRn8ogTWwbI7+TtVT8hU7AVJx88gGoF4R4LwvriCNblfmzrSQWNHW5kE+DzT5KP60fRrY06Y+2Zjb813hwF/eCyAr7ImeAGRFf0NE6np+m0dIO2ftIyBAbGhM1e07x1d0+fKFaHXgPFJ+kZnikSkwTvOJG24NOgxGqUzcjcVocanf37xYHxbgEX9EaThwZCypzDt7R794gGuUqaXs0lvddcYiHk2blp0ULULdwwU1dmWDlL2HXbD5rccpIbIKE+9SNLbeQrTCrx0UPshn0f++PTiAR+5OUEKH+bhJ/7vavd+csgDZLMlTsSP1ymMHzVmpVSzv8FyLYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKqgrVye5pIKiC4VSPcR/RfuPxeSIQNxAuKB8ravnbQ=;
 b=DOky3zge0Vzs3S6gc0UCMXoZF6EgHYR8eUVvyP4BiHN3fxQXW0D9q5Z1qFI9nmiQNy+LgGykRJWosF+whodJqBNMgCtzkG4AqnL1uc7765Rf09Rrbfl8x1MZTuXJ1umJq4dpbc8OS452maztM5QxTkdFBYL23Ek+7F2z+/Btmwo=
Received: from CY8PR10MB6538.namprd10.prod.outlook.com (2603:10b6:930:5a::17)
 by IA4PR10MB8254.namprd10.prod.outlook.com (2603:10b6:208:568::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 15:04:02 +0000
Received: from CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::83c0:6ad9:b202:784e]) by CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::83c0:6ad9:b202:784e%3]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 15:04:01 +0000
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
Thread-Index: AQHcHftv8CjoT2T+d0ijWjIH+YDznLSLOOQAgAIc6oCAAMjJgA==
Date: Thu, 11 Sep 2025 15:04:01 +0000
Message-ID: <A356F147-5B23-46F6-B05E-3BDDC81A768B@oracle.com>
References: <20250905001157.it.269-kees@kernel.org>
 <20250905002418.464643-2-kees@kernel.org>
 <65CF25F7-E9F5-41C8-9316-F7A461FD35D0@oracle.com>
 <202509101705.92474D66@keescook>
In-Reply-To: <202509101705.92474D66@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6538:EE_|IA4PR10MB8254:EE_
x-ms-office365-filtering-correlation-id: 0d1eb3e1-0749-40a7-f377-08ddf1447156
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z1hKTWhka0YzUHVMS1ErcWdnbGh2MTczYm13bXVEMEQvMkJSNC9SWEh2azBB?=
 =?utf-8?B?RjYvdDNiZWZLeUdpYXJoZDVlYlZxa1p4TFZuMmJOTzJOWmtmMlZQNGdqMm41?=
 =?utf-8?B?di91WjlZUGxzMWUybDZrMmVLcGpLVlN5ZHJSS0xOZmRhSDBDb1FtRmpSenF1?=
 =?utf-8?B?ZzNubk9rYUtVREdUK2I1TlVlcDZhV1hvMTQ5SXNXVWJvZE90MHErYzhSRTZN?=
 =?utf-8?B?cHVRUmsyNlZhdWVXVVRGOThYdHM3ODBjOTZySmcyZEtKdjlUc2NMZ1lLV3Nv?=
 =?utf-8?B?bGwwNWRJamxvaHlRaWdLbmhHaWt2ci9RamUyK0oxVVVqY25QdEFLU3NMbnFB?=
 =?utf-8?B?emcwV1ErZmFkd2VTSlhKUzdsTGVod254dm1pYjNLR0dUVENPc1NtYzc0QUh2?=
 =?utf-8?B?TmNJdlpvcm56WmNlRDVtNlBDTFpWT1ZVLytVKzhHN25hMHpFK1RxWDVNQUEr?=
 =?utf-8?B?NVNjOXBmOTgxT0RJWHpkbkozdHVac2puMzFJdStEbWFBQmJST05wQzBWUS82?=
 =?utf-8?B?UXBEcTgvd0xTZ2dQSEM2ZE1VWjJkTzR2dVYwUDQ3SFkrZEN0SWlOU3BSOWxV?=
 =?utf-8?B?ZDlrZTQ3WnlUNE5zK29UQVh5bEhrcmJ6MklJVlFLSWxydDBiMTlpY3lpZ1lN?=
 =?utf-8?B?bmhxc20rSVFHZldHSytpMlMyRmxvTThzSUhib0VRZHVQcVplWHR4UVc5UllL?=
 =?utf-8?B?UnRuRVF2OTB2QVdNTmNYempBR2J4dnQ5M1Y3dzg3Vm9URkg3UkZuWlNBejBn?=
 =?utf-8?B?WS94RzIyYzNNYzVvNndGYWgrSTdyWWNpVXc0UDFLbUo4amppRHYzMHpwb3E1?=
 =?utf-8?B?M2UrcTJTeU9zZFNzRXBNV0ZQRzhjMysrNktSUG9JU1ZrSmNySGNieFRqbGhW?=
 =?utf-8?B?ZE0zbWFQSDc2NHY2RDlQNzd2WDBNbjdhTUFOSHpKU04wZmJFcC8xelQvNVEv?=
 =?utf-8?B?WXIvVFpYc2ZMUlNDa3lPSVhSOGRzcS9yNGJTV05XQ2hWUHNLTGRIdTlTZXpv?=
 =?utf-8?B?QXVyVkN3aXBweUdFd29tcVhnZUdBTm54amdQNzE0cFRGOVB5NCtneGtWZVBE?=
 =?utf-8?B?Vmt2d2srV1Q5cHhkK2R5bHE3QVJvcXduTExaZnVJdHE2VEpCcmJUa3NvMkhl?=
 =?utf-8?B?SjBTclVlVTlJa1NhV0tqTXkyRWVEeWw1M2lTYTRCL29KUzJmaW1sZ0haV1NO?=
 =?utf-8?B?OUptUmp4bXBQTzRSYkFtdmJLcmFIeFoxZEt4VCtvNmZCT1VMbWN1Y2ZLa25q?=
 =?utf-8?B?YWs2RHQ3bmxPaWswNzkyODZkY0h3aTJHNjUwNklySmptMzArOXRkVUlVZ2dE?=
 =?utf-8?B?TENsS1hYUnlPZWRVOFA0NEsxQXlyaHlxWFFXTzJHeGExc2FvcS9XalcrTWt3?=
 =?utf-8?B?UGlYTVh5YU5qYVRhVTlRZnkrdThjRXVJeTNqL0xiZUpoRmlxRzVQNytUM2dV?=
 =?utf-8?B?TkVTMzg4Q0t2RFhXWHg3bldWY2U2RnJaR24wbVpJODlIRlB3YmJUdmczL0RB?=
 =?utf-8?B?aTZqQVFPMWx5MWNpdmNGdGVvSzl4eC9WdVdKdXZoQkVOZGcrSkNiVUxrRDhq?=
 =?utf-8?B?OGdnS25QRGtpYVVWcVk1Vk45U2dlejArb1NYcGJCTC9qdTNONWlEM3RQcHM4?=
 =?utf-8?B?M3EzRXdsai84Z1J0Nkh2NEtQeWZ4VkxQNXk0TXU5bHlBOWUxUE5WeXVrZDcw?=
 =?utf-8?B?bXVzZGx4SVJCOWJOK2FGdXJBSGFWWVB4Z1BuYkpBN1Ftdk02dWFiR0tSYVM4?=
 =?utf-8?B?TVo0SDVxMjdIRXpRZGlSaTU2MjhpdE4wNDlHM0c0MkV3ZmpYM2NUL2IxcEV4?=
 =?utf-8?B?d1F2RkZRazZOdS9BdjluclA2Zlc3T2E0SVY4aUJvV3F3UzNNY29FL1krbE1U?=
 =?utf-8?B?TVlNdmpmWnNBQmRHYUJNMVdZQU1TNkdpVU5aeFFQbkVCVlp1RG5mbWltN2F0?=
 =?utf-8?B?aXZXV1FQVzZVRkRTZ2pKMFdMMzRKTTZYS3A5d0NESGtoZmFHRXVZVW9JMzBC?=
 =?utf-8?Q?ajtT6PLMrgMB55XvmobfwDJroId+Ws=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6538.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZUlmdHZpbkNLU2hBTXk4VExoNHV3NWtyOFpPa1k4M1AyWEp3cWlZdmo0VGRn?=
 =?utf-8?B?MDlUM1VrZ0xpckxJZEdvK3RQM1dTaENHQzVueUUwa0VDd0Q3b3JneWJPMkJy?=
 =?utf-8?B?YjN6MW1EdWdySDZNTjNOWnRDUG80V3Vvd3lzUWpqazV0M1NHeHFJem9DUVpB?=
 =?utf-8?B?Q3NBK1NZSUszTURJQUUvUHNUU2pyTVFrTWpDZE1hT0Q0N3Zxa1RzY3Y4MVZC?=
 =?utf-8?B?d1VaNjRSbmh3QjhLRlZkdzFjaDMvZTB0SmVSUFhZQllJNTBGeDlVT2crTlNP?=
 =?utf-8?B?V0d6TjdWSTRTMzAraHZhUzBZWURkdVRWelBwYWg3ZVBTd3huWUdYZVVYazdq?=
 =?utf-8?B?U0dtdEtWU0R4VkJCNjF3UmJyWEpUSzBrU055OVllcDBjb0dSanVBL252OWtn?=
 =?utf-8?B?SWJoMWtSR3FLM3E4RVUyQ2JBM2ptUDEvL1NsZDB4R2RKWU9oYlNxTmlGLzJo?=
 =?utf-8?B?UzhWdVNhMTg2U2hwbXdKSzNaazVOVEJsbFUvTk5FbHJvaWNOWUxSTGN3dVZ6?=
 =?utf-8?B?cWQwazZPRStseDNxNnorZ0RSYWdqeWNTZTZRZVZObHowd3AxMUhtTzJ4M1V6?=
 =?utf-8?B?ZFNDUnAwUDVzbStBcjhiNkcxZWxHOEU4NHo5Ny9zN0kyUGIzNkFrM0hJVGpz?=
 =?utf-8?B?MXp5M0tISlp0WTEvdzZnRWYyVXgySWFkOVBOOWNHa3V6c2M3bUZjSHJ3T1g3?=
 =?utf-8?B?dmZMOVZOWkU0eXo1U3lNTW9rLzFhQ2Izd0hnNHpPRUV6bDN1T0Z6Y0JTS0FZ?=
 =?utf-8?B?ei9TY01hWVZPZm9IWmt5VmFHK2h5bmZMdUh2b09JTjd1eDhLbWJsRUJRSUcv?=
 =?utf-8?B?R29HblVxcnJXWFJlMDMwZUlJRmZLejd2cmo2VmxnK1VFSHJuNE9Rd1VKak05?=
 =?utf-8?B?ZHRuT3QrQnprU0tuYWk2STlaTWN0aCtzUUV6aWdYVW1paGh3WEpHME5ZRzNy?=
 =?utf-8?B?R3BhNW1BRFZna09oRzFWdzBkcFRLUURXN3p6amk1Q0F3MExDRjNrNEVqVXAy?=
 =?utf-8?B?QjhuajBIa3B5OVdacitqblFDaTVvblJ0VmxMZkEzY0xoOGxiZHpENEV0dFB1?=
 =?utf-8?B?TkVxZzFuZjVuS1hqdGlsQ1pNVmVEQmxHVXJFZHNlTjl3L0Y3Y2ZjcTRTUzdW?=
 =?utf-8?B?UHdCbm1Jellkc2ZZb1cveVU1dWhNQU4wd0JZY1F1Z3F2MmxQOWFzYWFheGZW?=
 =?utf-8?B?U1laNFhHZUlLb3JsbzhVN3B6bTJyWTM1WEN1bitNK1J2Mjk0OUZib0NZeVd1?=
 =?utf-8?B?MFRNN2U1bWU3V1Q4OUNZQWlwUENBWFpZdko5a3JzUW56Yzl0aHdkREFaTDRL?=
 =?utf-8?B?c2xwYkxVWXM1U2NyVjkwdUJ5SWVKQTFic24vc0pQNzl1aHI2TlV4SndZcTIz?=
 =?utf-8?B?eU5aa1YxMTc4VTI1Y3d6N0RhZ2NKejdCWmU4YlFUdkJpM0hsdlRUYTdMcW9h?=
 =?utf-8?B?aUlvVXpGVVpKdmRML1YxYXlRZllOZGIzd0RMU21JVUJOU0o0L0xTeGRrYnJI?=
 =?utf-8?B?U0VVOEVvRi9wazh0cGl6YVBmaUNteUdGdzhuWlJqSXJ0a2YvSjVWdm1wTDVu?=
 =?utf-8?B?UDlzQ01zcWNNME9jQldlMjA1QStmQlRKVEd3d0VmdU9KYlVIYldRdlFrb3Vx?=
 =?utf-8?B?Mzd3eWFRMDFaLzlIellWalRteXZwdm9RN2c0K0VwRFo5K2NzZEVrc04xL3Nh?=
 =?utf-8?B?VEprYzF1Rld2Qkp3SGYyY29EWnRaMmw2NVhVZEdmb0ZIMUhaMjVDcVdRUEpt?=
 =?utf-8?B?ZVpGcmtlT010aWVHWFdZZVVQSEo4L1dSNDFJNWdBekNNNGpsYU1rNXFMT2Rq?=
 =?utf-8?B?ck93c2FXTmtNK1Bjbkd1SWdQRWZWSnczK0pTTksxVFk1M0dlYnc3YU9rb2Mv?=
 =?utf-8?B?VGVscjd6alhHOWoyMGNoWkIwWkZmKzJpMTdnZHJQL0hQb2JVZU1WOCtFcWdP?=
 =?utf-8?B?VndUZEVJUExnZ1BkejhHNWl5SE4xb3pVTVhhS25ScWgyQ2dKRGxxcU41eUtO?=
 =?utf-8?B?OFhEcW1jN2V5SUdtNFJBRUhpSVRndjlDK1c4Z3dRSWNKbVVxaU51MXp1d1Bs?=
 =?utf-8?B?dFM4ZVZUbytsU2oxdXJiRDVoY0c1Y3U0WU1FZC9qc2xrTVRDajRPTmdnWkdM?=
 =?utf-8?Q?41RUmd+lMgc1Apij+jmfP6qEg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD0F2CB9B4B56C449E5F70106C80F824@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P/16Kstmvzz2x1Z3t76aFN7IK6EiMObE6VC6miD1VaomUadnxJbX9uuhiI7rIb/G2H9OvD3l5le9NQkATrzhAEr0qnET5QOtzBcSSUIOUIxweO1jmUVF5lnMkKUnrLrj9ZGGrV62qWmQh+SCDwbml/ooEo9dDCcZttpxSkZoU/Cszh0roxuHPUhce/2Fm1iC4OU1hUD2aV0i7iKIP0jGgOZA7zBxhEpndLJ5tKi6kauAq0rzyk5LGOcYbE3jqP2MI78/udkfrfZHI1d4/yRzv5aw3e5lfnMvKfVVhbI8V/4hLC8gW1/3Fp7sfMD96axkzBllRZBAEslNA5XLE8Ieer9m2XSPEodajeWtLNbUOqISeg2251jawVIxQw4CvscRHbz/rt89mrfJx2xAzIHKnd94NABfguHhCotmXG0xlxXhQ+xhD/PbVuGMzzXvwWr98I8F4zmO2knSifw/Vmw+6p16wLF0oHt1oFvckcSc+BMFMfjfzn0W9bjA5B5Uh7qwepwn4z9S3yKZgsvWFtxEBTaEv2DiMzaH/tbFX41HY8YfU6NboWvjbVcMu+azPdzRU1cl5L7GMhvn+uMAANKSFtwPPm+xKpWgqp4OV4j+rQI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6538.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1eb3e1-0749-40a7-f377-08ddf1447156
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 15:04:01.7600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q6R9szpVDhnJRMV5gh8UtRsJpRihjDbPLfzQDUJmAy5/iABT1QHFrUt/2AyRf3WLf3HE1R1Oz0Dm54IwolCcSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8254
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110133
X-Proofpoint-GUID: tUBg1CHIY50iOQTBreTl1AQ12LOX8Z1v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MSBTYWx0ZWRfX8XYkOmwVxkkb
 gAjlQjt3E8Zl8ObATmAZtCD3gTnvFSzHfRUqgy57pIc6jS0KPbY7ufnUAH3zlZjVdF4093EfQ9W
 li3+1HMLyS0sbqahrEnjjVxaeWJbh86rSTgQxYr7up1rScL+8lbPCs603l0U6EL7GnljGYtRIrf
 kufX4ACm6dcHe+DM/m2ZENXYF3CfGgT4enfLFeb8i9QUJwNzOIiLBG/U/VuLs4hTivfboml25TJ
 DtMwTIFLLkgiYBVr+ASOG+2U4a3dv8/DRbLH4lFKtUmt4zGMCqifBEdVP7X4pncsn8c7BNhuvzH
 u76Vt2mJQk0Jq4dcwzmLZIK9D0NcJQUdayOOQJpr1KM63SxkdAsdFdtbCN8KVHu2pkzQUhZG41R
 TenHj4ZT
X-Authority-Analysis: v=2.4 cv=Dp5W+H/+ c=1 sm=1 tr=0 ts=68c2e4fd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=XAHKWE2ByNQLr-Hp-OoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: tUBg1CHIY50iOQTBreTl1AQ12LOX8Z1v

DQoNCj4gT24gU2VwIDEwLCAyMDI1LCBhdCAyMzowNSwgS2VlcyBDb29rIDxrZWVzQGtlcm5lbC5v
cmc+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBTZXAgMDksIDIwMjUgYXQgMDY6NDk6MjJQTSArMDAw
MCwgUWluZyBaaGFvIHdyb3RlOg0KPj4gDQo+Pj4gT24gU2VwIDQsIDIwMjUsIGF0IDIwOjI0LCBL
ZWVzIENvb2sgPGtlZXNAa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4gK0ZvciBpbmRpcmVjdCBjYWxs
IHNpdGVzOg0KPj4+ICsNCj4+PiArLSBLZWVwaW5nIGluZGlyZWN0IGNhbGxzIGZyb20gYmVpbmcg
bWVyZ2VkIChzZWUgYWJvdmUpIGJ5IGFkZGluZyBhDQo+Pj4gKyAgd3JhcHBpbmcgdHlwZSBzbyB0
aGF0IGVxdWFsaXR5IHdhcyB0ZXN0ZWQgYmFzZWQgb24gdHlwZS1pZC4NCj4+IA0KPj4gSSBzdGls
bCB0aGluayB0aGF0IHRoZSBhZGRpdGlvbmFsIG5ldyBjcmVhdGVkIHdyYXBwaW5nIHR5cGUgYW5k
IHRoZSBuZXcgYXNzaWdubWVudCBzdG10DQo+PiANCj4+IHdyYXBwZXJfdG1wID0gKHdyYXBwZXJf
cHRyX3R5cGUpIGZuDQo+PiBpcyBub3QgbmVjZXNzYXJ5Lg0KPj4gDQo+PiBBbGwgdGhlIGluZm9y
bWF0aW9uIGNhbiBiZSBnZXQgZnJvbSBmdW5jdGlvbiB0eXBlICsgdHlwZS1pZCB3aGljaCBpcyBh
dHRhY2hlZCBhcyBhbiBhdHRyaWJ1dGUNCj4+IHRvIHRoZSBvcmlnaW5hbF9mdW5jdGlvbl90eXBl
IG9mIOKAnGZu4oCdLiANCj4+IENvdWxkIHlvdSBleHBsYWluIHdoeSB0aGUgd3JhcHBlciB0eXBl
IGFuZCB0aGUgbmV3IHRlbXBvcmFyeSwgbmV3IGFzc2lnbm1lbnQgaXMgDQo+PiBuZWNlc3Nhcnk/
DQo+IA0KPiBJIGNvdWxkbid0IGZpbmQgYSB3YXkgdG8gc3RvcCBtZXJnaW5nIGp1c3QgdXNpbmcg
dGhlIGF0dHJpYnV0ZXMuIEkgbmVlZA0KPiBhIHdheSB0byBkaXJlY3RseSBhc3NvY2lhdGVkIGlu
ZGlyZWN0IGNhbGwgc2l0ZXMgd2l0aCB0aGUgdHlwZWlkLg0KPiANCldoZW4gZGV0ZXJtaW5pbmcg
d2hldGhlciB0d28gY2FsbHNpdGVzIHNob3VsZCBiZSBtZXJnZWQsIGlzIGl0IGZlYXNpYmxlIHRv
IGFkZGluZyB0aGUgZGlmZmVyZW50IHR5cGVfaWQgZnJvbSB0aGUNCmF0dHJpYnV0ZXMgaW50byBj
b25zaWRlcmF0aW9uPyANCj4+PiArDQo+Pj4gKy0gS2VlcGluZyB0eXBlaWQgaW5mb3JtYXRpb24g
YXZhaWxhYmxlIHRocm91Z2ggdG8gdGhlIFJUTCBleHBhbnNpb24NCj4+PiArICBwaGFzZSB3YXMg
ZG9uZSB2aWEgYSBuZXcgS0NGSSBpbnNuIHRoYXQgd3JhcHMgQ0FMTCBhbmQgdGhlIHR5cGVpZC4N
Cj4+IA0KPj4gSXMgdGhlIG5ldyBLQ0ZJIGluc24gdGhlIGZvbGxvd2luZzoNCj4+IHdyYXBwZXJf
dG1wID0gKHdyYXBwZXJfcHRyX3R5cGUpIGZuPw0KPiANCj4gVGhpcyBidWxsZXQgaXMgc3BlYWtp
bmcgYWJvdXQgdGhlIGJhY2tlbmQgY2hhbmdlIHRvIHN1cHBvcnQgdGhlIEtDRkkNCj4gY2hlY2st
Y2FsbCBpbnNuIHNlcXVlbmNlczoNCj4gDQo+ICsvKiBLQ0ZJIHdyYXBwZXIgZm9yIGNhbGwgZXhw
cmVzc2lvbnMuDQo+ICsgICBPcGVyYW5kIDAgaXMgdGhlIGNhbGwgZXhwcmVzc2lvbi4NCj4gKyAg
IE9wZXJhbmQgMSBpcyB0aGUgS0NGSSB0eXBlIElEIChjb25zdF9pbnQpLiAgKi8NCj4gKw0KPiAr
REVGX1JUTF9FWFBSKEtDRkksICJrY2ZpIiwgImVlIiwgUlRYX0VYVFJBKQ0KDQpPa2F5LCBJIHNl
ZS4NCg0KPiANCj4+IFdoeSB0aGUgdHlwZS1pZCBhdHRhY2hlZCBhcyB0aGUgYXR0cmlidXRlIGlz
IG5vdCBlbm91Z2g/DQo+IA0KPiBEb2luZyB0aGUgd3JhcHBpbmcgYXZvaWRlZCBuZWVkaW5nIHRv
IHVwZGF0ZSBtdWx0aXBsZSBvcHRpbWl6YXRpb24gcGFzc2VzDQo+IHRvIGNoZWNrIGZvciB0aGUg
YXR0cmlidXRlLiBBbmQgaXQgc3RpbGwgbmVlZGVkIGEgd2F5IHRvIGRpc3Rpbmd1aXNoDQo+IGJl
dHdlZW4gZGlyZWN0IGFuZCBpbmRpcmVjdCBjYWxscywgc28gSSBuZWVkIHRvIHdyYXAgb25seSB0
aGUgaW5kaXJlY3QNCj4gY2FsbHMsIHdoZXJlIGFzIHRoZSB0eXBlaWQgYXR0cmlidXRlIGlzIGZv
ciBhbGwgZnVuY3Rpb25zIGZvciBhbGwgdHlwZWlkDQo+IG5lZWRzLCBsaWtlIHByZWFtYmxlIGdl
bmVyYXRpb24sIGV0Yy4NCg0KT2theSwgdGhpcyBzb3VuZHMgbGlrZSBhIHJlYXNvbmFibGUganVz
dGlmaWNhdGlvbiBmb3IgdGhlc2UgYWRkaXRpb25hbCB0ZW1wb3JhcmllcyANCmFuZCBhc3NpZ25t
ZW50IHN0bXRzLiANCk9uZSBtb3JlIHF1ZXN0aW9uLCBhcmUgdGhlc2UgYWRkaXRpb25hbCB0ZW1w
b3JhcmllcyBhbmQgYXNzaWdubWVudCBzdG10cyBhcmUNCmZpbmFsbHkgZWxpbWluYXRlZCBieSBs
YXRlciBvcHRpbWl6YXRpb25zPyBBbnkgcnVudGltZSBvdmVyaGVhZCBkdWUgdG8gdGhlbT8NCg0K
DQo+IA0KPj4+ICsNCj4+PiArLSBUbyBtYWtlIHN1cmUgS0NGSSBleHBhbnNpb24gaXMgc2tpcHBl
ZCBmb3IgaW5saW5lIGZ1bmN0aW9ucywgdGhlDQo+Pj4gKyAgaW5saW5pbmcgaXMgbWFya2VkIGR1
cmluZyBHSU1QTEUgd2l0aCBhIG5ldyBmbGFnIHdoaWNoIGlzIGNoZWNrZWQNCj4+PiArICBkdXJp
bmcgZXhwYW5zaW9uLg0KPj4+ICsNCj4+PiArRm9yIGluZGlyZWN0IGNhbGwgdGFyZ2V0czoNCj4+
PiArDQo+Pj4gKy0ga2NmaV9lbWl0X3ByZWFtYmxlKCkgdXNlcyBmdW5jdGlvbl9uZWVkc19rY2Zp
X3ByZWFtYmxlKCksDQo+Pj4gKyAgdG8gZW1pdCB0aGUgcHJlYWJsZW0sDQo+PiBUeXBvOiBwcmVh
bWJsZS4NCj4gDQo+IEZpeGVkLg0KPiANCj4+PiArSE9TVF9XSURFX0lOVCBrY2ZpX3BhdGNoYWJs
ZV9lbnRyeV9wcmVmaXhfbm9wcyA9IDA7ICAvKiBGb3IgY2FsbHNpdGUgb2Zmc2V0ICovDQo+Pj4g
K3N0YXRpYyBIT1NUX1dJREVfSU5UIGtjZmlfcGF0Y2hhYmxlX2VudHJ5X2FyY2hfYWxpZ25tZW50
X25vcHMgPSAwOyAgLyogRm9yIHByZWFtYmxlIGFsaWdubWVudCAqLw0KPj4+ICsNCj4+PiArLyog
Q29tbW9uIGhlbHBlciBmb3IgUlRMIHBhdHRlcm5zIHRvIGVtaXQgLmtjZmlfdHJhcHMgc2VjdGlv
biBlbnRyeS4gICovDQo+PiANCj4+IHRoZXJlIHNob3VsZCBiZSBvbmUgZW1wdHkgbGluZSBiZXR3
ZWVuIHRoZSBjb21tZW50cyBvZiB0aGUgZnVuY3Rpb24gYW5kIHRoZSBzdGFydCBvZiB0aGUgZnVu
Y3Rpb24uIA0KPj4gSSBub3RpY2VkIHRoYXQgeW91IG5lZWQgc3VjaCBlbXB0eSBsaW5lIGZvciBh
bGwgdGhlIG5ldyBmdW5jdGlvbnMgeW91IGFkZGVkLiAgLTopDQo+IA0KPiBPaCEgV293LCB5ZWFo
LCBJIHRvdGFsbHkgbWlzc2VkIHRoaXMgY29kaW5nIHN0eWxlIHJlcXVpcmVtZW50LiBGaXhlZC4N
Cj4gDQo+Pj4gKy8qIENoZWNrIGlmIGEgZnVuY3Rpb24gbmVlZHMgS0NGSSBwcmVhbWJsZSBnZW5l
cmF0aW9uLg0KPj4+ICsgICBBTEwgZnVuY3Rpb25zIGdldCBwcmVhbWJsZXMgd2hlbiAtZnNhbml0
aXplPWtjZmkgaXMgZW5hYmxlZCwgcmVnYXJkbGVzcw0KPj4+ICsgICBvZiBub19zYW5pdGl6ZSgi
a2NmaSIpIGF0dHJpYnV0ZS4gICovDQo+PiANCj4+IFdoeSBub19zYW5pdGl6ZSjigJxrY2Zp4oCd
KSBpcyBub3QgY29uc2lkZXJlZCBoZXJlPw0KPiANCj4gbm9fc2FuaXRpemUo4oCca2NmaeKAnSkg
aXMgc3RyaWN0bHkgYWJvdXQgd2hldGhlciBjYWxsLXNpdGUgY2hlY2tpbmcNCj4gaXMgcGVyZm9y
bWVkIHdpdGhpbiB0aGUgZnVuY3Rpb24uIEl0IGlzIG5vdCB1c2VkIHRvIG1hcmsgYSBmdW5jdGlv
biBhcw0KPiBub3QgYmVpbmcgdGhlIHRhcmdldCBvZiBhIEtDRkkgY2FsbC4NCg0KT2theSwgaXMg
dGhpcyBkb2N1bWVudGVkIHNvbWV3aGVyZT8gDQo+IA0KPj4+ICsvKiBHZXQgS0NGSSB0eXBlIElE
IGZvciBhIGZ1bmN0aW9uIGRlY2xhcmF0aW9uIGR1cmluZyBhc3NlbWJseSBvdXRwdXQgcGhhc2Uu
DQo+Pj4gKyAgIEZhdGFsIGVycm9yIGlmIHR5cGUgSUQgd2FzIG5vdCBwcmV2aW91c2x5IHNldCBk
dXJpbmcgSVBBIHBoYXNlLiAgKi8NCj4+PiArc3RhdGljIHVpbnQzMl90DQo+Pj4gK2dldF9mdW5j
dGlvbl9rY2ZpX3R5cGVfaWQgKHRyZWUgZm5kZWNsKQ0KPj4+ICt7DQo+Pj4gKyAgaWYgKCFrY2Zp
X3R5cGVfaWRfYXR0cikNCj4+PiArICAgIGtjZmlfdHlwZV9pZF9hdHRyID0gZ2V0X2lkZW50aWZp
ZXIgKCJrY2ZpX3R5cGVfaWQiKTsNCj4+PiArDQo+Pj4gKyAgdHJlZSBhdHRyID0gbG9va3VwX2F0
dHJpYnV0ZV9ieV9wcmVmaXggKCJrY2ZpX3R5cGVfaWQiLA0KPj4+ICsgICBERUNMX0FUVFJJQlVU
RVMgKGZuZGVjbCkpOw0KPj4+ICsgIGlmIChhdHRyICYmIFRSRUVfVkFMVUUgKGF0dHIpICYmIFRS
RUVfVkFMVUUgKFRSRUVfVkFMVUUgKGF0dHIpKSkNCj4+PiArICAgIHsNCj4+PiArICAgICAgdHJl
ZSB2YWx1ZSA9IFRSRUVfVkFMVUUgKFRSRUVfVkFMVUUgKGF0dHIpKTsNCj4+PiArICAgICAgaWYg
KFRSRUVfQ09ERSAodmFsdWUpID09IElOVEVHRVJfQ1NUKQ0KPj4+ICsgcmV0dXJuICh1aW50MzJf
dCkgVFJFRV9JTlRfQ1NUX0xPVyAodmFsdWUpOw0KPj4gVGhlIGluZGVudGF0aW9uIG9mIGFib3Zl
IGlzIG9mZi4NCj4gDQo+IEkgdW5kZXJzdGFuZCBHQ0MgY29kZSBzdHlsZSBpbmRlbnRhdGlvbiB0
byBiZSAibGVhZGluZyBzcGFucyBvZiA4IHNwYWNlcw0KPiBzaG91bGQgYmUgcmVwbGFjZWQgd2l0
aCBhIHRhYiBjaGFyYWN0ZXIiLiBUaGlzIGlzIHdoYXQgSSBmb2xsb3dlZDoNCj4gDQo+IGZpcnN0
IGxpbmUgaW5kZW50cyB0byBjb2x1bW4gNiwgc28gNiBzcGFjZXMuIFNlY29uZCBsaW5lIGluZGVu
dHMgdG8NCj4gY29sdW1uIDgsIHNvIDEgdGFiOg0KDQpZZXMsIHRoYXTigJlzIHJpZ2h0LiAtOikN
Cj4gDQo+IFNTU1NTU2lmIChUUkVFX0NPREUgKHZhbHVlKSA9PSBJTlRFR0VSX0NTVCkNCj4gVHJl
dHVybiAodWludDMyX3QpIFRSRUVfSU5UX0NTVF9MT1cgKHZhbHVlKTsNCj4gDQo+IFRoaXMgc2Vl
bXMgdG8gbWF0Y2ggZXZlcnl3aGVyZSBlbHNlPyBSYW5kb21seSBwaWNraW5nIGxpbmUgZ2V0X3Nl
Y3Rpb24oKQ0KPiBmcm9tIHZhcmFzbS5jYywgSSBzZWUgdGhlIHNhbWU6DQo+IA0KPiAgICAgIGlm
IChub3RfZXhpc3RpbmcpDQo+IGludGVybmFsX2Vycm9yICgic2VjdGlvbiBhbHJlYWR5IGV4aXN0
czogJXFzIiwgbmFtZSk7DQpPa2F5LiAgKEkgZ3Vlc3MgdGhhdCB0aGUgbWFpbCBjbGllbnQgaGFz
IHNvbWUgaXNzdWVz4oCmLikNCj4gDQo+Pj4gKyAgLyogQ2FsY3VsYXRlIGFsaWdubWVudCBOT1Bz
IG5lZWRlZCAqLw0KPj4+ICsgIGFyY2hfYWxpZ25tZW50ID0gKGFsaWdubWVudF9ieXRlcyAtICgo
a2NmaV9wYXRjaGFibGVfZW50cnlfcHJlZml4X25vcHMgKyB0eXBlaWRfc2l6ZSkgJSBhbGlnbm1l
bnRfYnl0ZXMpKSAlIGFsaWdubWVudF9ieXRlczsNCj4+IFRoZSBhYm92ZSBsaW5lIGlzIHRvbyBs
b25nLg0KPiANCj4gT29wcywgeWVzLCB0aGFuayB5b3UuIEZpeGVkLg0KPiANCj4gV2hhdCBpcyB0
aGUgcmlnaHQgdG9vbCBmb3IgbWUgdG8gcnVuIHRvIGNoZWNrIGZvciB0aGVzZSBraW5kcyBvZiBj
b2RlDQo+IHN0eWxlIGdsaXRjaGVzPyBjb250cmliL2NoZWNrX0dOVV9zdHlsZS5weSBkb2Vzbid0
IHJlcG9ydCBhbnl0aGluZy4gT2ghDQo+IEl0IHRha2VzIF9wYXRjaGVzXyBub3QgX2ZpbGVzXy4g
VGhlIC5zaCB2ZXJzaW9uIHNwZWNpZmllcyAicGF0Y2giIGluIHRoZQ0KPiBoZWxwIHVzYWdlLiBP
a2F5LCBJIHdpbGwgZ2V0IHRoaXMgYWxsIHBhc3NpbmcgY2xlYW5seS4NCg0KWWVhaCwgSSB1c3Vh
bGx5IHVzZSBjb250cmliL2NoZWNrX0dOVV9zdHlsZS5weSB0byBjbGVhbnVwIHRoZSBjb2RlIGJl
Zm9yZQ0Kc3VibWl0dGluZyB0aGUgcGF0Y2guDQo+IA0KPj4+ICsvKiBXcmFwIGluZGlyZWN0IGNh
bGxzIHdpdGggS0NGSSB0eXBlIGZvciBhbnRpLW1lcmdpbmcuICAqLw0KPj4+ICtzdGF0aWMgdW5z
aWduZWQgaW50DQo+Pj4gK2tjZmlfaW5zdHJ1bWVudCAodm9pZCkNCj4+PiArew0KPj4+ICsgIC8q
IFByb2Nlc3MgY3VycmVudCBmdW5jdGlvbiBmb3IgY2FsbCBpbnN0cnVtZW50YXRpb24gb25seS4N
Cj4+PiArICAgICBUeXBlIElEIHNldHRpbmcgaXMgaGFuZGxlZCBieSB0aGUgc2VwYXJhdGUgSVBB
IHBhc3MuICAqLw0KPj4+ICsNCj4+PiArICBiYXNpY19ibG9jayBiYjsNCj4+PiArDQo+Pj4gKyAg
Rk9SX0VBQ0hfQkJfRk4gKGJiLCBjZnVuKQ0KPj4+ICsgICAgew0KPj4+ICsgICAgICBnaW1wbGVf
c3RtdF9pdGVyYXRvciBnc2k7DQo+Pj4gKyAgICAgIGZvciAoZ3NpID0gZ3NpX3N0YXJ0X2JiIChi
Yik7ICFnc2lfZW5kX3AgKGdzaSk7IGdzaV9uZXh0ICgmZ3NpKSkNCj4+PiArIHsNCj4+PiArICBn
aW1wbGUgKnN0bXQgPSBnc2lfc3RtdCAoZ3NpKTsNCj4+PiArDQo+Pj4gKyAgaWYgKCFpc19naW1w
bGVfY2FsbCAoc3RtdCkpDQo+Pj4gKyAgICBjb250aW51ZTsNCj4+PiArDQo+Pj4gKyAgZ2NhbGwg
KmNhbGxfc3RtdCA9IGFzX2EgPGdjYWxsICo+IChzdG10KTsNCj4+PiArDQo+Pj4gKyAgLy8gU2tp
cCBpbnRlcm5hbCBjYWxscyAtIHdlIG9ubHkgaW5zdHJ1bWVudCBpbmRpcmVjdCBjYWxscw0KPj4+
ICsgIGlmIChnaW1wbGVfY2FsbF9pbnRlcm5hbF9wIChjYWxsX3N0bXQpKQ0KPj4+ICsgICAgY29u
dGludWU7DQo+Pj4gKw0KPj4+ICsgIHRyZWUgZm5kZWNsID0gZ2ltcGxlX2NhbGxfZm5kZWNsIChj
YWxsX3N0bXQpOw0KPj4+ICsNCj4+PiArICAvLyBPbmx5IHByb2Nlc3MgaW5kaXJlY3QgY2FsbHMg
KG5vIGZuZGVjbCkNCj4+PiArICBpZiAoZm5kZWNsKQ0KPj4+ICsgICAgY29udGludWU7DQo+Pj4g
Kw0KPj4+ICsgIHRyZWUgZm4gPSBnaW1wbGVfY2FsbF9mbiAoY2FsbF9zdG10KTsNCj4+PiArICBp
ZiAoIWlzX2tjZmlfaW5kaXJlY3RfY2FsbCAoZm4pKQ0KPj4+ICsgICAgY29udGludWU7DQo+Pj4g
Kw0KPj4+ICsgIC8vIEdldCB0aGUgZnVuY3Rpb24gdHlwZSB0byBjb21wdXRlIEtDRkkgdHlwZSBJ
RA0KPj4+ICsgIHRyZWUgZm5fdHlwZSA9IGdpbXBsZV9jYWxsX2ZudHlwZSAoY2FsbF9zdG10KTsN
Cj4+PiArICBnY2NfYXNzZXJ0IChmbl90eXBlKTsNCj4+PiArICBpZiAoVFJFRV9DT0RFIChmbl90
eXBlKSAhPSBGVU5DVElPTl9UWVBFKQ0KPj4+ICsgICAgY29udGludWU7DQo+Pj4gKw0KPj4+ICsg
IHVpbnQzMl90IHR5cGVfaWQgPSBjb21wdXRlX2tjZmlfdHlwZV9pZCAoZm5fdHlwZSk7DQo+Pj4g
Kw0KPj4+ICsgIC8vIENyZWF0ZSBLQ0ZJIHdyYXBwZXIgdHlwZSBmb3IgdGhpcyBjYWxsDQo+Pj4g
KyAgdHJlZSB3cmFwcGVyX3R5cGUgPSBjcmVhdGVfa2NmaV93cmFwcGVyX3R5cGUgKGZuX3R5cGUs
IHR5cGVfaWQpOw0KPj4gQWdhaW4sIHRoZSBuZXcg4oCcdHlwZV9pZOKAnSBoYXMgYmVlbiBhdHRh
Y2hlZCBhcyBhbiBhdHRyaWJ1dGUgb2Yg4oCcZm5fdHlwZeKAnSBoZXJlLA0KPiANCj4gVGhlIGF0
dHJpYnV0ZSBpcyBhdHRhY2hlZCBkdXJpbmcgSVBBLiBUaGlzIGlzIHJ1biBiZWZvcmUgdGhhdCwg
YnV0IGFzIEkNCj4gbWVudGlvbmVkLCB0aGlzIGlzIHRoZSBjYWxsLXNpdGUgaGFuZGxpbmcsIGFu
ZCB0aGUgSVBBIHBhc3MgaXMgZm9yDQo+IGdsb2JhbGx5IGFzc29jaWF0aW5nIGEgdHlwZS1pZCB0
byB0aGUgZnVuY3Rpb24gZm9yIGFsbCBvdGhlciB1c2VzDQo+IChwcmVhbWJsZXMsIHdlYWsgc3lt
Ym9scywgZXRjKS4NCkR1cmluZyBJUEEsIHRoZSB0eXBlaWQgaXMgYXR0YWNoZWQgdG8gdGhlIGZ1
bmN0aW9uIHR5cGUgdGhyb3VnaCDigJxzZXRfZnVuY3Rpb25fa2NmaV90eXBlX2lk4oCdIGZvcg0K
ZWFjaCBmdW5jdGlvbiBpbiB0aGUgY2FsbGdyYXBoLiANCg0KRm9yIGVhY2ggaW5kaXJlY3QgY2Fs
bHNpdGUgaW4gdGhlIGFib3ZlLCB0aGUgcm91dGluZSDigJxjcmVhdGVfa2NmaV93cmFwcGVyX3R5
cGXigJ0gYWxzbyBhdHRhY2hlcw0KdGhlIHR5cGVpZCB0byB0aGUgb3JpZ2luYWxfZm5fdHlwZSwg
YW5kIGF0IHRoZSBzYW1lIHRpbWUsIGNyZWF0ZSBhIG5ldyB3cmFwcGVyX3R5cGUgd2l0aCBhIHR5
cGVfbmFtZQ0KZW1iZWRkaW5nIHRoZSB0eXBlaWQuIA0KDQpTbywgSSBmZWVsIHRoZSB0eXBlX2lk
IGluZm9ybWF0aW9uIGlzIGNhcnJpZWQgcmVkdW5kYW50bHkgaGVyZS4gDQoNCg0KPj4+ICsgIC8v
IENyZWF0ZSBhIHRlbXBvcmFyeSB2YXJpYWJsZSBmb3IgdGhlIHdyYXBwZWQgZnVuY3Rpb24gcG9p
bnRlcg0KPj4+ICsgIHRyZWUgd3JhcHBlcl9wdHJfdHlwZSA9IGJ1aWxkX3BvaW50ZXJfdHlwZSAo
d3JhcHBlcl90eXBlKTsNCj4+PiArICB0cmVlIHdyYXBwZXJfdG1wID0gY3JlYXRlX3RtcF92YXIg
KHdyYXBwZXJfcHRyX3R5cGUsICJrY2ZpX3dyYXBwZXIiKTsNCj4+PiArDQo+Pj4gKyAgLy8gQ3Jl
YXRlIGFzc2lnbm1lbnQ6IHdyYXBwZXJfdG1wID0gKHdyYXBwZXJfcHRyX3R5cGUpIGZuDQo+Pj4g
KyAgdHJlZSBjYXN0X2V4cHIgPSBidWlsZDEgKE5PUF9FWFBSLCB3cmFwcGVyX3B0cl90eXBlLCBm
bik7DQo+Pj4gKyAgZ2ltcGxlICpjYXN0X3N0bXQgPSBnaW1wbGVfYnVpbGRfYXNzaWduICh3cmFw
cGVyX3RtcCwgY2FzdF9leHByKTsNCj4+PiArICBnc2lfaW5zZXJ0X2JlZm9yZSAoJmdzaSwgY2Fz
dF9zdG10LCBHU0lfU0FNRV9TVE1UKTsNCj4+PiArDQo+PiANCj4+IFdoeSB0aGUgYWRkaXRpb25h
bCB3cmFwcGVyX3B0cl90eXBlLCB3cmFwcGVyX3RtcCBhbmQgbmV3IGFzc2lnbm1lbnQgc3RtdA0K
Pj4gQXJlIG5lZWRlZCBoZXJlPw0KPiANCj4gQmFzZWQgb24gbXkgdW5kZXJzdGFuZGluZyBvZiB0
aGUgcmVxdWlyZW1lbnRzIGZvciBHSU1QTEUgaGVyZSBpcyB0aGF0IEkNCj4gbmVlZGVkIGEgY2Fz
dCBiZXR3ZWVuIHRoZSBvcmlnaW5hbCBhbmQgdGhlIHdyYXBwZXIsIGFuZCBhbiBhc3NpZ25tZW50
DQo+IGZvciBTU0EuIEl0J3MgY29udmVydGluZyB0aGUgY2FsbCBsaWtlOg0KPiANCj4gIE9yaWdp
bmFsOiByZXN1bHQgPSBmbihhcmcxLCBhcmcyKQ0KPiAgQmVjb21lczogIHJlc3VsdCA9IHdyYXBw
ZXIoYXJnMSwgYXJnMiwgdHlwZV9pZCkNClllYWgsIHRoZSBnaW1wbGVzIGFyZSBjb3JyZWN0LiAN
ClRoZSBjb25jZXJucyBJIGhhdmUgaXMsIHdoZXRoZXIgdGhlc2UgYWRkaXRpb25hbCB0ZW1wb3Jp
emVzIGFuZCBzdG10cyBpbXBhY3QNCk9wdGltaXphdGlvbiBhbmQgYWxzbyBpbmN1ciBhbnkgcnVu
dGltZSBvdmVyaGVhZC4gDQoNCj4gDQo+IEknbSBvcGVuIHRvIHdoYXRldmVyIGFsdGVybmF0aXZl
IGlzIG5lZWRlZCBoZXJlLiBJIHRyaWVkIHRvIGNhcHR1cmUgdGhlDQo+IG1lcmdpbmcgaXNzdWUg
d2l0aCBnY2MvdGVzdHN1aXRlL2djYy5kZy9rY2ZpL2tjZmktY2FsbC1zaGFyaW5nLmMNCg0KTWln
aHQgbmVlZCB0byBzdHVkeSBhIGxpdHRsZSBiaXQgaGVyZSB0byBzZWUgd2hldGhlciBiZXR0ZXIg
c29sdXRpb24gaXMgcG9zc2libGUgd2l0aG91dA0KVGhlc2UgYWRkaXRpb25hbCB0ZW1wb3JpemVz
IGFuZCBzdG10cy4NCg0KUWluZw0KPiANCj4gTXkgb3RoZXIgdGVzdCBtZXRob2RvbG9neSBpcyAi
ZG9lcyBMaW51eCBib290PyIgOykNCj4gDQo+IC0tIA0KPiBLZWVzIENvb2sNCg0K
