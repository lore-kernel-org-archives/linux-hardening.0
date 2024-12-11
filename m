Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360E31C4A1B;
	Wed, 11 Dec 2024 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733906147; cv=fail; b=cQ2tQ2Ni6/3fZqj5rHMwWe+JmZA/kehRzp5kBdlla/8NE500nIxbNfxTY/54XU8yAqm9QSwXxRfNjkVkIS+wReNDhcAzI7PZs3aLRPWRQZw2ZIzAApjgpGhtoPtNFOeXENNu4gvmevQGe9+YQeE27GNq+TCWXQfTQNmPcOyaHOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733906147; c=relaxed/simple;
	bh=AskMFozkmKRVoHajZ2Ubk3/o0rX2LW1Hu+YvwFxdliI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fcJXiK0aDPG2lIJBxG59ZpARFBW3ygoOakzVbxrIG8MD6UzhsdStOzsxBityaZZhRdi8DSdAiX02Cs6M87jysbXHz1xs0wclYLjQbx+FXMbvq07mf5g70q7ZpuriafkpLSQY/3FUQmfsyW8a3JOB7/xvqhpksErLGJGTsteHuWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S9byy/WA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D1VqOGcG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S9byy/WA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D1VqOGcG"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB8RMED004948;
	Wed, 11 Dec 2024 08:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=AskMFozkmKRVoHajZ2Ubk3/o0rX2LW1Hu+YvwFxdliI=; b=
	S9byy/WAzZ9AMNBb4iubU92RvejyfgzfVPRNsMMTz+Bnnf9qmKJrs0/PdmavDEMT
	BFso8vucB1xBd7/VpCKiVf02Wby19daGBDWerPAAnEmzKhnud/oXVJEOr6cKF4Om
	oONCAppOORa0Smf1ITujrKrGTVNU6aVyV40HpGpMXk8lOCK8oclUdW/fzj2NWWVT
	QKYbGUapGltCD5OAG7JN7Ek1xg4jS7BH7c+KCPUYab9pRFdE05pgoc384bbuti+D
	jkKVXoFqW7+jKMJHpmgEr9rauy8OOUsktwH0x8+7FOKpm3BzNhFrKKdxNF9MP8Rz
	4aQ33X5pmPZvJzJ4v55agQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43dx5s55cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 08:35:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB71URV020507;
	Wed, 11 Dec 2024 08:35:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cct9dxmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 08:35:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fpc54EXjj/SRLuJ1Bew7ahK3kH+yDiDbD01PIDR09chNAJlbtacNgWH6bvFI4o5IbGmbLcZOElL8PsoC9LzOAy0mL1OV2pr40DWPtGHC+boN8qg0+pu/+yloJgljc6lKGE4F6l/8Haa7qM6RwlteT1350MmrKKUZY/U1RZLhCLOcKmxOsRyAW8ir9QGfnC5+BwR6HFJDGOOsZxUj6PBkwiVN3OWSFnkaJuy4EGMn7uWpcXikxJCcOCQemzjzKnhabWw9z55E6dUioiIYyu3w6QZ5aJNrvO5fYcAAWWsD4S7mqgvEBj55cSn8JWMNbobL5i9UhI4dwgUCJfF3lhk3Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AskMFozkmKRVoHajZ2Ubk3/o0rX2LW1Hu+YvwFxdliI=;
 b=HmMvWpn754In7PTYlstWop+inywNtoTMumhLrShJTtj6EXFErVynUh2WbwWqPoy8YiMF10xjKf5NiJQXsRh4HQX25zjN15u7DzX/K72RQB4RNxVpG/+PVeMEG5wAdNwstg/KeYO3wWs+IFezncrcucOXGM7y2HDQ1xoAFO6sbiacQJb1haiyz6qMUwSpeFNKDXfmYWjS63zZ+65MBYxVwpkn6IC4DCip3puTpT0r+wYxFxe2/cNYZ8Rwg5IgNUC8u5MQRom3wfWGI1Gxb2ggyPTSvsvyxEsooUqmOWoWVe0c/hC4KYgwp0eJhblmy9QkErjXgd0zgQj/VnF4yd/cyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AskMFozkmKRVoHajZ2Ubk3/o0rX2LW1Hu+YvwFxdliI=;
 b=D1VqOGcG8fanlEWDZpiV1ctPCUFfVdwhXf0KcbTXanHSoNTr2XGDwzuE/H0kj9kpFhlTzK3JO/zFk1JUpTxwFqZJOt4lWUmkwvtCNWdaPjr9d4LF6zUtWqlFyj8bpJNl4MEDkZf3xx0AzhvkCOUFUpv62wRZE68QKUlEt+ZsZos=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by LV3PR10MB8058.namprd10.prod.outlook.com (2603:10b6:408:286::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 08:35:24 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 08:35:24 +0000
Date: Wed, 11 Dec 2024 08:35:16 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org,
        vbabka@suse.cz, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        jorgelo@chromium.org, keescook@chromium.org, pedro.falcato@gmail.com,
        rdunlap@infradead.org, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1] mseal: move can_do_mseal to mseal.c
Message-ID: <acbc0663-57a5-4643-88e0-33c7beeadc22@lucifer.local>
References: <20241206013934.2782793-1-jeffxu@google.com>
 <2m3zmlehfigs5r7rptwcoft3j4fipfkgfxmdrdttpf76hwhwae@vclfa5ulcmv2>
 <d710d812-3dc0-406f-ac47-a782673d3d07@lucifer.local>
 <CABi2SkWkUmBdsUYhr-cE181oh=medLG0iXgHk6TYEuPgztxqOw@mail.gmail.com>
 <f4c704bc-3b9a-48bb-b1dc-8a73d181223c@lucifer.local>
 <CABi2SkV+jVgg5Q=XCTC3+J7WtyvgFbHfP-sGTrzfJA0oteRPLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkV+jVgg5Q=XCTC3+J7WtyvgFbHfP-sGTrzfJA0oteRPLQ@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0119.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::16) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|LV3PR10MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: e79f03f9-a775-4842-94a3-08dd19bec1de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWg2UGpXeVpMSzZFOVRpbzNEaGZrK2IvMzFuQmlUTUNUYnRZa3FLL3Jzc1Zw?=
 =?utf-8?B?S2lockNuZVZpZkNxM244U05HYjFMOVJnUVRPMmU0RW80M21UNEpkUm1kZG0y?=
 =?utf-8?B?RitMaFhzTEZHQWFIWHpNUDNCZzM0SlJMSmtSN0dBMXZGQ29IeEhrdUlxNFN2?=
 =?utf-8?B?Ti9oT3BMMEhMTjVJckJpSXg4cW9mQUZZUG1vZks1Mi96QnJZOTVmT0hNUGlU?=
 =?utf-8?B?RUlINDA2YTgzSkg1TFExM0hwa09uSlBjeWxBRWpRdjRCSnVxNkNsK0VtWUxr?=
 =?utf-8?B?TmlxMTlGWCtkMzNFWDFDaTlSK0N3aDNCeDlFaEk0Tmkzb3BFSTc0d0d6YnpO?=
 =?utf-8?B?dWl4ekVVWUZRM3ZTMWI0U2VMOFo4ZU0wZDBLUG5FdVFQYVRFN3l1eVpqZGdq?=
 =?utf-8?B?SGc1WlBEeGVqRVhFcktuS3ltUmN0NHZMS25TZFZkcWt5Z3FIcGtJakNzb0Q2?=
 =?utf-8?B?NmtPdW5vRkh6YUltdXA4WnkxQ1dZYjRSTWVuck11OHA5UlphSTZJVUdzRjNN?=
 =?utf-8?B?TzR2ek5GMTlGeWQxZXJrcGZacTZnUDNyM0RiSjBQZklxRFArVzBQMUkvcXNh?=
 =?utf-8?B?UStOcmFuUEdqMGpSSmQyeG11M1ZwSTZOa2xzK2RZSXVkR0kraG14Q3ZGb1RX?=
 =?utf-8?B?bGx2N05INXRuU0g5ZHNHTzgva3cxNnNYWEY1TlB0OGpJR2cxeVhMcmVuUlJV?=
 =?utf-8?B?cER5Qmg0UWJ2YXkwd3ZBejJBWVVDLzVHRWJvV2xQSU50N0hSSUdINFUrVldk?=
 =?utf-8?B?OGQxS0tYTXZ4WWhpLzJ3V21UUWdwUnhjeStxTDYwRzZNdXlsQlZ2ZHBsSE52?=
 =?utf-8?B?WGZXbU01Q1lwWWJIL2U5dlZsL1dkZnc4RXMwNThkMVl1SlpyV1BpNlM1aURw?=
 =?utf-8?B?Nmc5bWpOVkJtK3ZtdDZaQWJPR3NhY1NUa1VwR01KZkF0WTRJM1F2M1NIYmVN?=
 =?utf-8?B?WlNDeGtSK2ovaldrbVlWV2JBWmpCcyt2WmtyR0NlcWQ1QmRnYzBYbFFYWWNN?=
 =?utf-8?B?aldqYVMyWGNoUTNEQkUrdlBCTUI1Y0RQWURVdHFoTFBjMHNrT1pCSmhyQTJ0?=
 =?utf-8?B?anhBR1dKaXVVVk5OSkQyNEFNNitwc09qOUFxUk9KakEwcmdVbWN3Mnd0NVpW?=
 =?utf-8?B?MWx6emIralJOTHVpTUNtVmZaUTNIcW1WbStTUyszUldlYk5XcTF2S2duQkRy?=
 =?utf-8?B?SVJvR1RST3Z2WTZYOFVBNTQrN1VFb0txNHRKSlY1Q1p1TjluQzJLYkR3dDEw?=
 =?utf-8?B?blY3cXgzdktIdElQQ1d6K1FJOGo2RFFtLzE3MWJwZEIveSthQ1hBVjVDSmt5?=
 =?utf-8?B?bjY0NnNjV1ROZld4bEw5RlNwQ0xzSThXMHpRakJzbzE0NzhkN0VzWHkwRFFC?=
 =?utf-8?B?UVNMdE95MmkzYjYrT0NjSnd0S3B6ekptN3JOZ21XQjNibmhTay9HQlJuWXpY?=
 =?utf-8?B?WG9YanpuOWVBeEd5ZzRlTUsxRXVvcUdTb2lrNGtpRFFPUHF0eHlEMnN5WFVn?=
 =?utf-8?B?RnlWZ1h1NnFLVXJocENtNUEwNUlRcUMySE94bTlaL1RYZTlWbFRJS0M0alps?=
 =?utf-8?B?STFaaHlJVExpRzBZbE5QNHRkSUdLV3JiY00velRFYkFLcHJva2VhR28wb1g1?=
 =?utf-8?B?TTE2M01WeUNISFNQYXg0ODB5WXBNSGZRRVFXWmtJdzdvdUVyelNMRHlWQW1h?=
 =?utf-8?B?QzlHWnZHeHZNU3NmeUtRQ1FNTFZNMWVFY1ZBZGxWMm9ZK2U5Yy9OVDhQa3hs?=
 =?utf-8?B?QjdkYmFYMkRVVHZYSFhwKzJZUjBCY3ZWdnFpNkw2aURLMVpMKzBtaVM3MzlX?=
 =?utf-8?Q?aEU6lFmGYcHCNCVKL4ODGiJUPNUCGRB1jzmnI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEtSVW03MXlXS3V6LzJFbVdlSE1jRjl0NDN2ZFJZdW1kWURsbzBnMEgrdFps?=
 =?utf-8?B?R21MR0VkVnFRTWNDbDN2aHFZN0JlZndEeCtJRTMrQzFPRU1IUkRvbFVSK3lF?=
 =?utf-8?B?WUF0QkdyOUs5TnZpZGhVWjJGUE5TZDJtQlBzVG9uUHM4a1h1QnVmQVUzVFdT?=
 =?utf-8?B?cEtXUnM2UzdzWDl3dzZTTTAwRTE5ejBSdmlBQTBCMUdnN1BoOTJvZmhINjUv?=
 =?utf-8?B?YWswU1IxZVVlNkpYZS9KOVpuRDYxSVhrVHpZa2liWWk2eThpNERzQThhZGRT?=
 =?utf-8?B?cWxEWTFLZFMyZ2RsamJGdDExVXRCZ1BraFpRVmtrK1pua3lzSGVlNzV2RHZR?=
 =?utf-8?B?cktLRzFoMXp3eDhJY0JGZS9VeWRQQWw2dnJnVS9kdDd5YVROVWFudVFqdGYv?=
 =?utf-8?B?UFRyR05OS293dmE0RlJSdmY1RXcvTzJrcVhBTExqRFVRbEw5TEtxNVpoL0JZ?=
 =?utf-8?B?N1dBVVpCMTZjTDZUbCtLWWt6a0Fad2JjTzNsNmtCQ3hqY2crZ3Bjb1hJQ0c3?=
 =?utf-8?B?U29jVHpmOG1nK3Joa1F0WXc0d0w2SzhncGVGOFB3MklZTWMwSE5xVUM4TmQv?=
 =?utf-8?B?NzA5ZXpTVWRraklHWnpZWnluZG83WEZKSnJ3dGcrYjFDRmF1ZUhiSzJlOHVy?=
 =?utf-8?B?WlhJSW9adlRCMEJ4Tm5haE5QblNPWDhjQWlRcXdVWXBIWU8rWnhjbGpIZjZQ?=
 =?utf-8?B?UFY1OTBKNExhN0wwME1pSDlIRk1WTTkwL0NWcmZuL0ttbUtCNm95SmFFSTBq?=
 =?utf-8?B?SE0yVmRzbkQyV2dFeUxRWXlsK0kwMmpFNFQzSi8wVzlwNGRpNlVaT1FxVnB2?=
 =?utf-8?B?eDZtRFhTNzlIMWhvTzIrRU04bTkrcVg1aEdxUTRmby9lbzFEUklKQU9jVm1v?=
 =?utf-8?B?WWUyeC9pTm1iZGpTNjMxbjIxaVgxeFBkNU9Vci9XRkYrRWNPZlJkQ1QyQkcw?=
 =?utf-8?B?M3hTSUxHQ1RlNjhZUVYzanFyeGUvVGsxcE1Tem92S2lGSGk0YVVzMTY3aFNF?=
 =?utf-8?B?em9hMlM4TW84dWdEbytLRnRVYkxtS2dLTFloTnJpRTUya2JaTittYVQvZEg4?=
 =?utf-8?B?eDVVbGdjWXV6Y3J6Uk00VTdYT2M5RlVJRVB6d21RUVdNMWtMYlhTL2I3VHpC?=
 =?utf-8?B?d1ZZMkRlTFBadW5HMlVYQ1ZPYXozTXJwOEFudDNHTFVReXR6T0o4Nm9qTGlR?=
 =?utf-8?B?RXBpVGVaRC9JVEdwU1ZoMU0wanJVM29Ha1dhQUZ3QVh1N3BnbWVUb1JlYTVU?=
 =?utf-8?B?ekl3ZE5QVjg3UFlyU2VldkNNclhBczlKc2s1U0RZd1dBQUdzVmtrU2Z6Y3Rw?=
 =?utf-8?B?enVHaENkb0QzeTZxeHF1RFA5bUVLOG92UWpMWldxN1g3THByMlBQM2VuQ20y?=
 =?utf-8?B?aU1KTGU4a0NDTGdBRzQ1OEhNSTVjNzFoNTk0Skx4dlgrWjZFNitxV1lBN0Fk?=
 =?utf-8?B?Ym5GQUFQTkRDL24yV2Z1VWE4QmRwR3ovWTdMN2NFZFZjanFSbkl5LzVJbTc5?=
 =?utf-8?B?R3ZNekMxVlRLUEVMTEQ3YzQ4Z3JmV2kzRDdPSmVBVDZ0cU1Ib3NEbUJiUDhm?=
 =?utf-8?B?alhGM3FhamVhZTdzUHAreSsrZlJabnlCZWVuVDJURTVIQ2IwUFlvMlBTZGNC?=
 =?utf-8?B?ZHNNdS9PSFpNYUtyVW9BaTF1azlrcXlRaEdRTWE4VTI2ZWpKSTJwejUyTlhS?=
 =?utf-8?B?ZHQ5ZVJLNzdqMGFZd2N5Mno1SkNPNWkvSytad09iY0Q0d2g4eG5QcExObFgv?=
 =?utf-8?B?M1RXenp6aGt2UXBUODNITUFCVXJGR0ZURGFGaDM3TUdwdXFoTUN5L3ZHaW1v?=
 =?utf-8?B?SzV5ak5pZzA4a056UU5kMEhMakJRK1RyMWFsaDBoWEZCTWdhZVdLNlVnZG92?=
 =?utf-8?B?eHljZzl4d1RhU2pnM1Y3cGpSUjhmemFLOXhFUlV2bXlOVXZ6OHpaWUFsSXZM?=
 =?utf-8?B?c3lEaEU2THFSc0krTGdGOXduYnlCWEprc3ZkMUhtanZkb01nME4wK0tQSzU5?=
 =?utf-8?B?Z09NeWV5b1ptajFqRHNVYmNrMG9jV3dIR1BZblJESk1acmpqZEswbTN4Q3l2?=
 =?utf-8?B?dFlLakpBOEJUUitPZFlLS0haeXI5dkRyWEtDdGtCVzVtTHVNU2tvOGFVNjlz?=
 =?utf-8?B?RDNlYmdwT1FuM0srN2VCbitpdGNyWVJNRVJ1VmdRTGludG50K2hiUVh4S2g5?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EmcmFVW30LUBXWsiV1nFxhYkAnFL7woVlC4op2LGemqzmqTYVIaNhwO0s+WVPQ5brL+J3esWu2X/IZdlfcTYb2jd2IUXtbYbKHe9Xn1afZMw+N75+jIRPsGsktRNMWiG+/0Lh+SxNGXmszSnsfyZ5Eqs/6J7QzwYhzB8pbS7ZubGIuOsT1BOB0HyXWo3aRfxk6Atpd5MdeAr32i2ZXAkdgP1+altHyGKKHwKGgRIRpGQnLnvN+0Ws+vXb1hID0dZTIwjolyPWdNoYrjAG8pTk/yRvdhKYay6Q99ngov5Qqc3JG2QOIs2R2LdNUU8VKUIUN1pXpJamjY9UV40rxJlJlZ8sl0pomqEFe2Z/CnRY+VfINHeg2fiHw7ajpu40YUeWNHFAvaDMvOvevOIR2lc5bjB35gEnOkyL+h3DHjtoxSn/TuuCPq5HMjZQu2i50qNhrpa2+93ueP8+EsTLbhyMcwgrUG7hQJTEAIc+adF294eYs0IGEud2BNlXbKVbdi+Ej58pn/y44Uiweq1PcWH7PcWs1kCL4FQTA2R++4fPaSFGoCeB2qzZWKrsQcaBHwXAoKT0JCqUTV7+JVyJggmDjHqYeSPf3B0aOGQg5mEwGY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79f03f9-a775-4842-94a3-08dd19bec1de
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 08:35:24.6684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syb1dUEn4zyrTgizqSDxsBOxDZeYrWVdc3fqO5fsxcxD+LcgpN+RDOAfAx/jgsg5Q668kPBub5RTTUusKCTIcJJLyrOsPJjnS/HspAhF9lg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8058
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_08,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412110064
X-Proofpoint-ORIG-GUID: 9Gf9j2aMMAVQcR7K__MacHqhDHufzVUY
X-Proofpoint-GUID: 9Gf9j2aMMAVQcR7K__MacHqhDHufzVUY

On Tue, Dec 10, 2024 at 06:38:49PM -0800, Jeff Xu wrote:
> Hi Lorenzo,
>
> Regarding your proposal of moving mseal.c to vma.c for unit testing.
>
> On Fri, Dec 6, 2024 at 9:04 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > > >
> > > > An aside - I actually think we need to move the bulk of this code to
> > > > mm/vma.c - it makes absolutely no sense to keep the internals in this file,
> > > > and that way we can userland test mseal functionality.
> > > >
> > > Is there a past discussion to read ? That will help me understand your
> > > strategy of unit testing mm code.
> > > Moving everything to vma.c, will lose log history, e.g. blame no
> > > longer helps, did we consider alternatives ?
> >
> > Re; git blame - I'm not sure what alternative you think exists, and I've
> > moved brk(), mmap(), etc. with a history spanning >30 years, so I'm not
> > sure what blame history you're concerned about given how recent mseal is :)
> >
> > There is always code that gets moved or changed. You can't stay attached to
> > your name appearing on a git blame line.
> >
> > Re: discussion, there's dozens of discussions and patch sets totalling ~3k
> > lines of code... just search lore for vma testing, or search through my
> > commits in mm/vma.c and you can see.
> >
> > I can put together links if you really need, but I think say [0] is a good
> > motivating example of how I was able to actually write unit tests for VMA
> > merge functionality which previously could not exist.
> >
> > In any case you can use the git blame -C option to 'see through' things like
> > code moves.
> >
> > The whole point of this is to be able to _unit_ test functionality under
> > circumstances that might be otherwise improbable/incredibly difficult to
> > obtain if run as part of a kernel and self testing.
> >
> > Importantly it allows us to conduct fuzzing testing in future, something
> > key and fundamental to security testing.
> >
> > I would say for somebody who has clearly stated his huge commitment to
> > testing and how critically vital it is especially in the security realm,
> > this is entirely something that is beneficial to the kernel and to mseal
> > stability and security.
> >
> > If you want to see it 'in action', you can run the tests in
> > tools/testing/vma via:
> >
> > $ make && ./vma
> >
> I want to express my support for unit testing and agree that more
> testing would benefit mm. However, I'm unsure about the reasoning
> behind moving code to vma.c in bulk. Could you please clarify this for
> me?
>
> In my understanding, unit tests can be conducted regardless of the
> code's location once dependencies are addressed with stubs. Have you
> considered adding mseal.c to the unittest makefile at the same level
> as vma.c? Since mseal.c doesn't introduce new dependencies, i.e. it
> operates directly on the vm_area_struct, so I would start with that.

These aren't ordinary unit tests, this is a whole new structure to allow
for _userland_ unit tests, that is the ability to compile kernel code in
userland.

The mm/vma.c file has been specially set up to allow for this, it
outsources its imports to vma_internal.h, one which exists in mm/ for the
kernel and one which exists in tools/testing/vma for the userland unit
tests.

It also strictly means that vma.c is _internal_ only and _cannot_ be used
from any other part of the kernel except mm - it's a sealed environment
unto itself.

None of these things are true of mseal.c.

In any case it was something I was considering, if it makes sense to. You
can see VMA manipulation code in mprotect.c, etc. which may not actually
make a huge amount of sense to move over.

So this isn't for certain, and you'll be involved in any discussion if this
were to be done... :)

>
> I guess, for UT, you might need to change some functions' signatures,
> e.g. remove static, if you want to test an internal function (e.g
> mseal_fixup) , from your unit-test, but this is the same even after
> moving them to vma.c.
>
> There will be additional work of clean up including header (".h"),
> still I believe this is the same work even after moving the code into
> vma.c. You might still need to move the prototype of some functions
> into vma.h or vma_internal.h (e.g. definition of MADV_FREE). But I
> think this work is also orthogonal to where the mseal business logic
> is located.
>
> I understand the logic behind the current vma.c (on the linux_main
> branch) and the unit test for the VMA merge functionality. However, if
> your plan is to move all VMA-related code into vma.c, that means more
> stubs are needed (depending on the boundary of the proposed unit
> testing), and I don't understand how moving the code can help reduce
> the amount of work or stubs (if that is the motivation).

Yeah it isn't to move _all_ VMA-related code, because some don't make sense
there, but rather core VMA operations which make sense to be there and also
tested.

The possibilities are pretty exciting as to what we can do with this (ok
maybe only to me but still :P).

So again, it's far from certain I'll try to do this with mseal, it was just
a heads up ahead of time just in case I do.

I mean speciflcally speaking it'd be the very straightforward stuff about
applying mseal flags, checking compatibility etc.

>
> To avoid spending too much of your time, if there are previous
> discussions on this topic, please share links or a brief summary, so I
> can study them first.

Sure, I mean again the best thing is the original series [1]

[1]:https://lore.kernel.org/all/cover.1722251717.git.lorenzo.stoakes@oracle.com/

>
> Thanks!
> Best Regards,
> -Jeff
>
>
> > [0]https://lore.kernel.org/linux-mm/1c7a0b43cfad2c511a6b1b52f3507696478ff51a.1725040657.git.lorenzo.stoakes@oracle.com/
> >
> > Thanks, Lorenzo

This won't happen until next year at the earliest anyway, as I'm off for
Christmas/NY at the end of this week and this is nowhere near my TODO list
even at the moment :)
