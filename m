Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51204A2D;
	Thu, 17 Oct 2024 02:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130662; cv=fail; b=aFf1RC0+RhX07Wu7FkFOxCDp0M/ijckndkNjY0JSGXXtB7KxSW7MINPK4MvbDjYRq1x4s73zKRvcRep3my/9nf9VsHLNGExqKdI8BdUcLIzeZLTKo7q4UWvajOwR4pey9VgqlWMND3Pm/0VSDYK94umZfSAcsCNnnHEuc5n1W2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130662; c=relaxed/simple;
	bh=RW58UNQPiUUt5Ar9nSnXJM4FFe3KRSu1q9lHwlHBSKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jR1MiS9KVQNfd9bgRu7UShElx3zQxmgxR1BOfM/MNLKTUbmRYUYEZNyA3q6Uj9KniW22x0/wpfquCGO1SGux20AJaCDxAGDpdH/O0EjWQlylqF/aOD90vexz2IbRa6xZOfe5vSwiU1d5sGokrWV875Of1Pw9XQVIDPiQANfQP7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LM/FGHF4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=khoIX/Br; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LM/FGHF4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="khoIX/Br"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GKtgZ4004462;
	Thu, 17 Oct 2024 02:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1QOR3UGnnbDu349/hFZDSYRR6O9MQg1LghBQmqUk8YM=; b=
	LM/FGHF40WKikIlijRcGtwtzIcZcZv5ZDcEmxKL1ZviH0EY078nWEnaM1Y3r9ifp
	4Ea1Mug0eIiWTbVgrT1dJ9LVDP7jokyH0+ZVPzZRb8gbDL3FIQiIYV4KX2tUybGK
	fJQ4XMm6yTad5gATYaH8BOCZli3MJ6Lfo8teJ0s6Gddijeri99voKjWsMR2/YfcU
	hAiTcum2tGmCTUQNwqBQ0axBEM/GdtxDp1SnkT6QNeTLv25fq3iQHVahOeay8K6g
	NsFXWnruS/p98vm0M8hDawzRdUNwlSJSq4YAKLBrvrNrOo0ybebmG8S8CywMKYW8
	CrPaLSrAPjZC0Bf7vcoTOQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1an10v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 02:03:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49GNOQGS019899;
	Thu, 17 Oct 2024 02:03:44 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj9kjrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 02:03:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sW1/9RC/c7UQ0A/evVMe7QvQhGJV+bx7ytqJfgvImFlLMQhtx0yQsW1AgcW5J9hj7l+/D9WNuhtmgY/HPaPpdlzd1CaLIT3/pvExKJZGVP6FogI+B+wCCiS2w5UIqRx0H4kuQXlO2GEtGfKFBN8ESqZ6Oer776TadRDApXzIhHCwvbWdj9ymBdQ4y+j16Xu4iqdeeChpcvW1D+9hWw/vaUCA3ygazQdi/ybKuGpc7GLJ6FK+qRoDQfdiaMzJ8+r8VpK+O+BjIQlk4wnwgiz0rRbe2qZbbCrrWnoLh9DUcbcuwXcuKWMNxr3xhmtgfIb8AGcCDeE7zJBAykLlXNqhsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QOR3UGnnbDu349/hFZDSYRR6O9MQg1LghBQmqUk8YM=;
 b=S/zNNd4krWXZ8nciTLz3awMeYwU125qwePm1wFV/NxQTyecjbPQcQw9Rb2VlMVk6rNxQxoLnPM2fyyjaq9IsvXcjyX/9T1q1szp3QbqnKYDl85FDyhsfX+pd5hsSCMx32IO9N4ERJqkmOvKtAP37fydFxogBqNJF6QdFAjrSMmTqJ4WNNFWHcngEDJIWqMt4xXHS3U1NZWSG0gxP0qsTZJ6qeRw6yaWouGDbmWflkpVkzT9T2F/4f6ZnoOXw7WIFPKrS8G3NhG/2ywEO3rbcFpJ0T8GnwN9weM144IUYXCcsHGaRp4gbBFUyuYLxZPzDrpADcJ0yisjMaTLDXwYaww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QOR3UGnnbDu349/hFZDSYRR6O9MQg1LghBQmqUk8YM=;
 b=khoIX/BrtxrdUai3rHlDz4dZRqBQuZ6w7/j/OuuQENp7WwGith8DrsCfJ12/GXNDGt6tkKM6yne3rl8rJox103hPVMiC2J/RShEfIiyJSKibqUdB9eUz54Ce/aSdoLned5vsmRoqZSkXFd7m2dW265m7gV8UvpBl9q+Vy+nKgWY=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DM4PR10MB5917.namprd10.prod.outlook.com (2603:10b6:8:b1::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.26; Thu, 17 Oct 2024 02:03:31 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 02:03:31 +0000
Date: Wed, 16 Oct 2024 22:03:28 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        torvalds@linux-foundation.org, adhemerval.zanella@linaro.org,
        oleg@redhat.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        jorgelo@chromium.org, sroettger@google.com, ojeda@kernel.org,
        adobriyan@gmail.com, anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
        rdunlap@infradead.org, davem@davemloft.net, hch@lst.de,
        peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com,
        gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
        ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com,
        peterz@infradead.org, ardb@google.com, enh@google.com,
        rientjes@google.com, groeck@chromium.org, lorenzo.stoakes@oracle.com
Subject: Re: [RFC PATCH v2 0/1] seal system mappings
Message-ID: <whsms76xkf5yzec5mlt4gq2jq6mkb2vj2uunl4k4ka6i3r6s2a@piv6weghxco2>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, 
	oleg@redhat.com, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, ojeda@kernel.org, 
	adobriyan@gmail.com, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, 
	davem@davemloft.net, hch@lst.de, peterx@redhat.com, hca@linux.ibm.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, 
	ardb@google.com, enh@google.com, rientjes@google.com, groeck@chromium.org, 
	lorenzo.stoakes@oracle.com
References: <20241014215022.68530-1-jeffxu@google.com>
 <2durheir3u7uv7y5d3zsuxgkxbfhyj6gbef6xiktp2nybf7os2@zppt55ut7f57>
 <CABi2SkX3YjU-soYqRahjV07cAw1bB0ukUNiUFkc-APNN3DvJ6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABi2SkX3YjU-soYqRahjV07cAw1bB0ukUNiUFkc-APNN3DvJ6A@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0021.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::23) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DM4PR10MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b188f02-c829-4152-e69a-08dcee4fe664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkR2RkIrZEFab1ZtWElyVitkT2xXb016VXpldDhqSWV3Umk3MW5TSkoxNjB4?=
 =?utf-8?B?OTEybWwxZjVUSjkwd0tpRVBXOE5jOEZhUmlxZXBpUDdBaFpEN2xJQjA3Uy9R?=
 =?utf-8?B?ZnZQUHc2V3RjTmp2bGhxdk1wYnZhT2UyQXhTT3RnTmtQOVdnVnlaa0VFeWZv?=
 =?utf-8?B?MHRvZWdiMzZTS3VDMjRZdksrSGROakJkbWZtcGFzQ1R4SHdNcFlPVUYvdWlM?=
 =?utf-8?B?WU83SkpQRFNucEpacWl2UjFjalJxL0VCOGhGTEZjL2ZnOXByVXV3Skdzb01V?=
 =?utf-8?B?RFY5eE5ZdzJ6dTZud0ZjRzFIU2N3bldBZ1BLcm1YWXBOd08rZEZuS1FzOUhq?=
 =?utf-8?B?cjNRakptV3FUaEt2VFR2YXNUKzZ4b21FRnRCb0dqZXJOQ01RTnplRlNhYzd4?=
 =?utf-8?B?akRFZ3Bpd3JVTHByU3NUTVlBMU9obXlGN0Zkek1Sem1DWWFVRHZFZ0tYRnZx?=
 =?utf-8?B?QktFYTBzSjV3YzBQNkNNVWFrSUMvNFIrQ3pEODcwVW5iT014K2ptRktXalNI?=
 =?utf-8?B?cENCejVwYm5xSGJ6dHo2RE1OSmorUmFielhzN1VLcGFxbW5jTUdiVkNiWWVK?=
 =?utf-8?B?Sk5mMFY1bE53TEZQMlBSOFFJS0Q3WmgvWDZlQ2JBL0Z0OWt2ckR1c3FScXFN?=
 =?utf-8?B?RDNJOGpDMlJFOTh1dTZGMmlMbEQxeVBWSUQrZ0cxUHJVeWxPbHQySXhwTzNi?=
 =?utf-8?B?UCtibXlzd2pGN29QMnZCMUlzeUg0MU83VXdGWk5pNDBQNFdHYzBFYks3UWRX?=
 =?utf-8?B?UDBJQlVSZEdYc1B1YWQvRnEydzdXMU1yQyt6Z0x4YlNNT1F4dU5IWDlXRHpX?=
 =?utf-8?B?dUQ4aVhOd2tOVHFzNW5pai9oLzNoN2xVUlhiMndBSkZ4RGNqS0xoZnNINDho?=
 =?utf-8?B?ZzhCSXJyNVN6UGdSbElNYWVjWCtCREluNWt3U3FaR2RBZ1RXRHpETUFxT3Nx?=
 =?utf-8?B?Z0hKTkc2cGtMY0ZsaldrR1ZMSjMzajd0RCtibHRNcjNCWjNrVGl4Umc5a3Rj?=
 =?utf-8?B?SjVmLzcvSmxrREpKS2pYbzc4bUQzMzE5QUxVYS9qK2JYUVhlUlNubVg2SG15?=
 =?utf-8?B?Sk5ZbytOa200TFhRVW5RL1hldFlJUXdhR01rZGVkWnhMbmtIMVRjdVVDQ09R?=
 =?utf-8?B?a2pWZVJhMjltZUtFUDE3aHIxQmRueThZQjhveW05RjhKblNxSEFwenk1cEk2?=
 =?utf-8?B?VFN0MTBMeTFWWnpiMTJlQUVYcWtPSkJFU2RrbU1yY2JGekFUMGxpV2FqaWxI?=
 =?utf-8?B?cjNxeWhKdVd6RThXakpPeVRoZFhveEIvNHZzc1owZDNJUlYrRm9FZlp5MXpm?=
 =?utf-8?B?T0tkQ0JKSVR0SzU5QlpwdDlKK084aFhiZy92aUZ1djBhWHQ4akJ6Y3IzU3Rt?=
 =?utf-8?B?ZTBIclNSYjYxWXVTN0pSakFsaUlLS0NCWXZOMnhRbVJHUE4wODdocnM2ZExT?=
 =?utf-8?B?bnh6Y0pSYmdsN1BjeHRJVVA5MlBwMDVpajhjR3E4QkpDYjRGUDFXVlRhR1FQ?=
 =?utf-8?B?d1d2MUIyVVR5bXhhcS8zNE9QOUdUcTJTRVlyQ3NUMlFoMUNDdmdEbVdFTzdP?=
 =?utf-8?B?Yy9BYU5HdGI4OGlIMmpPVjRlRDBTMXhaODA0YllnN1ZtUFlkQmtNQjQrQWFL?=
 =?utf-8?B?d25HNGRRNVJuVEtDVStsRlR5MEZHbk12WElsNmNvYVg3RFNMRXdIZ3dQMEQx?=
 =?utf-8?B?NkpncXk5eGxtMDB4QkhGNERFaWxwUXBIK0JtMnNSTW81V01pMFA4RkRkbFAx?=
 =?utf-8?Q?gPSrLXp79K1Y+a81DeDn8HkqFCgxZFiAkRW7xzL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nk96bXV0bk1XekpyVElNSzhCb1NjMkZGRTE3Sll3TWgzdU93K2djUVJ1WnBV?=
 =?utf-8?B?ZnFaemhEM016b1hMSHR3YlFNSUMyaVB0eG5YTkxENzZpNkZVeXM0NWk1VFBw?=
 =?utf-8?B?L2x4dVZZcUZ3WDBTaGV4TVNXeWQ2djVxQzVMWFpJdzd1MXB6cGtBUGJNek43?=
 =?utf-8?B?OWNqdDlPemxQaHNzNWhjQXV2bzE1UFpwaVUvbEEvNk04N0N0Q3hycXNRM2d1?=
 =?utf-8?B?Y1pLVjM4YkpzZGZFVHUyRDU0YkdCMmE0ZVJMN3pSbnZlWWpFa2pBQnJZWkhh?=
 =?utf-8?B?V1M3WElIZkljbFFOQ1gzRFhNa2E4bERxdjFqN3FpLzUyN1ZlZlBQTnF1VVJj?=
 =?utf-8?B?QWRDMExuR01LaFRMeUVyS1NlR3cwblRCU3RrSEtNOHVsbUptTGVFSFBueGJ5?=
 =?utf-8?B?RDUvWGd6ZzUrVzIzY3RHWHN5dGhFQ0U2MDNpWFltSHp5dHd1UHJyc3ZpZFNq?=
 =?utf-8?B?UG11UTdpZVFoWDhRclk4bEc1Sm9lUWRra096ZGJEbzdQbnhQeUlnNjVPblpx?=
 =?utf-8?B?cEVTN2lGazdJbk0wak4wYmpWN1NJd205dlFraGxzd1JYU0VUdVZNbUw2YjQ4?=
 =?utf-8?B?V0NWWHZwVEM2R2xFQU1MaFhYVjFWQkVHbXZDeHlwNXYxVFliMVdwTVFySURw?=
 =?utf-8?B?Ymp0Y0I4ZlRoTVZTbFR1VUZGY2Z3VTdIS1JFS1JENkNHNElBYWJCY21LaWpw?=
 =?utf-8?B?ZWlpNHpGL2xJYjNGenZnZ0dXTlZkS250aGN2Nk1rejNwWkZrbmkvQjllQjFL?=
 =?utf-8?B?d1o4ODErZGFsR0I4bE82dy9Wa1o0dGJuaE5KVSsvMXdHSUd6azFBNzhTWFIx?=
 =?utf-8?B?WGZlM3B0aGY0R3pIdWxnRTFTK0JpSWQ4N3BYUU4zZ2JPRlNhNTlmYTUzSVAx?=
 =?utf-8?B?SXdSZHJ1dFZza2ZXN3ZsejRxS0w4ZkpCNjc0aERmZHF3Z3NWNUs0bmV6c0pM?=
 =?utf-8?B?ZTJTSnpDaVArMEVFcnZiWGRLaDlpSnpxczc3YWtwMEdTUmxoVHk5aU5XTUhj?=
 =?utf-8?B?UTlKakgwbFk2TDlFV0ttdnlROWhhcERldGZ1NTg1eGlQSjhBVGZRazFkSHo3?=
 =?utf-8?B?cWlNa1VQTFVRWjljQmZuaEFKd01KOVN6N1I0eU9XRU0zeVVOUkswNXVjNVcy?=
 =?utf-8?B?WE5iUUx4aG5mN2FQRE5sc0RJV1hBUXFaYzZLUGlLK0gxOXVjOXRWMVY0MmM4?=
 =?utf-8?B?aXVzZG90elQ0NnExMWJGZlFqQUhORzFwdUJWeU1xVjYzWklpM05wN2ZmZG15?=
 =?utf-8?B?d2Fjanh6SFVrRkI4ZmVmVmlHM2t6WHZCY1ZYd1A4Z0ZGVTc0TmhkUVZIRVZL?=
 =?utf-8?B?dTJ3V2dkRlU2US9OVGRQUDFQK0NCaW1LamtYMGxMSGRFRE45RllqaFJhbjd0?=
 =?utf-8?B?QjFXblNaWjJpcTR5azZYRW05VmJCK1hmbGFwNjRwU2R2QWtIVUJheGMyVjk5?=
 =?utf-8?B?ZFJwOEJteEFPWEJQa243d1JMNGxrQllBbjd2ZUJoYTRSUEpnWS9xV0hmVWlI?=
 =?utf-8?B?SmJUZnBjUGVvbWxSVDJLeTlUNjArRXFOMGhNemp5cDgzTHBsdHBVNkRkQ0tK?=
 =?utf-8?B?NjkzRW83UlJGcW1kYmdRY0p6K1M0emp2RUlablFxQmowanZRUXhKNzR5QitD?=
 =?utf-8?B?Sy9aczhBRFBUVnZBNWdYSXVoOHdQZjlmNzVNUDNBQVJEV3pBRkFkYnp3M1JT?=
 =?utf-8?B?WFZtSWx0VDdkbkN3eENQakNCc1Zmdk8yZXVpZ3E1WkNBMmpHbmYyWkxXS2dv?=
 =?utf-8?B?dFNSbzRuM1lUY1YydXBVNFM2eDErdW9IdjhNN01FK3JzbHNzcHpvbGpFTUpZ?=
 =?utf-8?B?SS8yWG94ZE9OZ2RsWVBkSVZSckZxNHJ2TzU1bGM0RlJjVnE3WXBMSjc2RjZO?=
 =?utf-8?B?SUlBMEN0b290ajFPVWFjZXVCZDFLWVdZalJ4K2RXR2N0OTJBYmM4L3YyVE5T?=
 =?utf-8?B?U1pLWk1qOXVrS0ZGTWR4YVhZeGlhUVJUNnNFTWs1R2JJTUREaElKNHVuMTNz?=
 =?utf-8?B?WGczdUV0cDJTdUxqVm1LOTVzR2QwYnM0QzNnVXlvWkU5bklmZ2VSS3hNOFZa?=
 =?utf-8?B?bklnV0dFU3k2Sk1kNGthcVQvQmFLOGVRZXQzZkpsU2QxUWF1cjI5V2VsS2E4?=
 =?utf-8?B?Q0E3UjhvTVdaZXE2WDVHNWY4bElSMHNuZUdLS2JrdmpGZ0ZtenNDVHdtTDZx?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AkPu/hbUGbRLMqTCNHEkSdh6utO5nqfUEAsr4IGW3T5Otr98KVG9Ku+pGlrxEerNJuIN2EhL4kVxMwdEIeDlbSPLNwmfB2bNAKvKQsT3hqjcQ1QIs7HrH44E7e6sVxYM6sj5ceKUB8FH4qAE4paDUj+CU/6HhGkjWhBGui02ftWKoeIFz9M4Ey6IrWC6UytGlQuJ1VD2Rmr576pQPssKbDkYUfsX8cZR8Pt09Im4LNnzWWfH+lD2IBujJB5ptTvxYmjmarBbEiSkuao6c9bI7470O7AsQTrk9PYY/Im29w1Fvfhrm3wqaj54FStLDUNgjR+Tno13VkL/MZ5UulHcAbDDWlwafEqRts8jjePSHimBHieni2b21lBx8jWs9vu1ViLQtp5VvG2qgoP8Q/CUWpehBLbi4vaSzBqajFjXjdQ0S3QuKWlPe1hz4xACEcuI3mAfCFLro3fcNHtbbiD/X1gvwL3NUgYO9AoKn1IzbMxv45dIby8JLo2XCktDW90uMtuS2dwoCcjOvTtcK9fhCUiktw5qwfNLBrPjPSa1EDIWh+lh3fNuRA4gPFfUA7+7+3SmMqWABFiJXdHyE4IbBgnx75cNRnYjk3ALsmTnFL4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b188f02-c829-4152-e69a-08dcee4fe664
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 02:03:31.6230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRnTZ4y6oKWUUXlLDvOo7qhdZhVq+oR0ivtBfDEpnukiCTILNEYUX5GDVD6eS3qwJnMOkGzw0posf7re2F38pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5917
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_19,2024-10-16_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170014
X-Proofpoint-GUID: XN4IWhu01ZT07PT1F58iL0cK8YOtq2j1
X-Proofpoint-ORIG-GUID: XN4IWhu01ZT07PT1F58iL0cK8YOtq2j1

* Jeff Xu <jeffxu@chromium.org> [241016 20:59]:
> On Wed, Oct 16, 2024 at 4:18=E2=80=AFPM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > * jeffxu@chromium.org <jeffxu@chromium.org> [241014 17:50]:
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > Seal vdso, vvar, sigpage, uprobes and vsyscall.
> > >
> > > Those mappings are readonly or executable only, sealing can protect
> > > them from ever changing during the life time of the process. For
> > > complete descriptions of memory sealing, please see mseal.rst [1].
> > >
> > > System mappings such as vdso, vvar, and sigpage (for arm) are
> > > generated by the kernel during program initialization. These mappings
> > > are designated as non-writable, and sealing them will prevent them
> > > from ever becoming writeable.
> >                               ^ or ever removed.
> >
> > This is a pretty big deal.  Platforms are trying to make it so that vds=
o
> > is the fast path, but if they are removed then things stop using them
> > and it's not a problem.  This description is robbing them of the
> > information they need to know that, and it's not in your change log
> > either.
> >
> > I had said before that you need to be clear about the inability to
> > remove the mappings that are sealed, as the description above heavily
> > implies that it is only stopping them from becoming writeable.
> >
> The mseal.rst has the full description about memory sealing, I don't
> see the point to repeat all the blocked operations in the commit
> message here.

That's not what I said or asked for.

It's three words to add.

>=20
> I don't know why you would think this heavily implies that only
> stopping them from becoming writable,=20

Because you left it out of the description that states what this does,
and it's three words that adds a whole lot of context.

I told you to add that detail because it is _way_ more important to
almost everyone that you are making mappings exist for the lifetime of
the process than the fact that not writeable mappings will still be not
writeable.

One points out the fundamental change to the mappings you list while the
other tells people how things won't change.  I get that not changing is
the point of the patch, but it's not the only thing it does.

> There is already reminder: **
> For complete descriptions ** of memory sealing, please see mseal.rst

Getting good code reviews is difficult.  There are very few people who
do a good job of the very few people who do it at all.  If you want
people to read your code, then you need to spoon feed it to them.

You have just put up a huge barrier to someone doing a code review at
all, let alone a good code review.  So if you want good code, you need
to provide good information with a low bar of entrance.  We can all
agree that good review creates good code (well, better code, at least).

What you have done here is limited the number of people who are willing
to even entertain the idea of looking at the following patch.  And of
the people who do read the patch, probably close to zero will read that
document.

It's (usually) nothing personal, it's just human nature and a function
of time.

Thanks,
Liam
