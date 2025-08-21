Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681CF342CA9
	for <linux-hardening@vger.kernel.org>; Thu, 21 Aug 2025 18:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755799786; cv=fail; b=a5n4R136S5hn9ZdVZRgXBPbFbVjTqboIo68eTnsS2r15SICiOwZI94FdBlXLG08daIfpAhhQ8SWJz1v62HmJjkOkq+nY1lZ5MFj1eGntwu4Shb8pkHIbqC44LUZ7vNQvwlwtTJ4yYokZK1LhKiK+pfQhZMiFRMn0qwNIYBPEV90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755799786; c=relaxed/simple;
	bh=wgicYOyQ3IyuUs/NU/MJtSYBKGCgMfhUA6yMc1M5GMA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MTDPxzEmrof25QUBHsfDnEM0cwd26y9f3tOOU7XykKuaIAi5/wLcbzA//z9BhrPdSQpsg58Uf3J3KNjx8c/cct3ZEte+qo+3VGq/q8kPvTMEyWYPUx+9jQhiR3t2SpSI5KcD+4G1kbez7fzX9gG7lqrEdOmueCD0ox4CYIJOYv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jK+UzPk6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dY0xLp46; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jK+UzPk6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dY0xLp46"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LHDsCs013444;
	Thu, 21 Aug 2025 18:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wgicYOyQ3IyuUs/NU/MJtSYBKGCgMfhUA6yMc1M5GMA=; b=
	jK+UzPk6iaCUyhVL6c66wrSL0W6nmurCt7fR4+12dneEMYP48TdroSIYTUEIVIRR
	HpEeIDIdtYoOXVGYTcElfYy8Cbq39veHWisqJ8ss5q7ic0ryGeCSlMYVf5Ewjrz8
	lEpI3UYWT8jTO7XavhLpykDkVTULfldX5goPgWMuCvtO+SQkcKk/xOUbax22rdLT
	/vOrVl3bMizC3Zxq8P5Zc5vbvqH70DoTrO77SZkrfLZ8REE4IC5qS/Dmc7bkLdXg
	1XojM8DONvK79wMcP6i3bU6m0zcVmeOtTi/U9hkMEKWQe5BQVuMZoXoAbArJAzUP
	Z/DN3SqvS3ebVr7xVBcFBQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tsc5dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 18:09:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57LI56qx020675;
	Thu, 21 Aug 2025 18:09:16 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48nj6gcx2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 18:09:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGYqKi+11/oCp9QOvvG7w4bqTUuO99OHPCDu0z5DLKeEA6zVcXfJ7YROLb8o5VScH0LszHgAY+Le8ugFl+yItK6AZCvuAEJBmjAeu5cM0SXF4xRifm11IukP6u+rAZQO64qeaG5N3YBKCWHONMWMYYSyQ7m1S1q513CcA42vpJbmdxDiMiKT6NQMS4vFEbRfVRK3WQ6MwiTrtG4R1DTnSHTslhOEPL2ccEPOga0oPe8f22qeOmMX+5Tm3Mzw25lmtJsW3xy8v8NDNvta2Mx+yE/Q447plSCL93SvsrpaR964bEAlLbaV8R9krTKA95uvsJm8eqU0XCTmpcXG8GyslQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgicYOyQ3IyuUs/NU/MJtSYBKGCgMfhUA6yMc1M5GMA=;
 b=a9YMDVgQc2KvD6cqLzRPNO4PL0J/3RqQGS0m49lAC0G0J7bDa4wjIuqDaaIJ8qTi5+1/AxpvLvWX+DBSFwvbWfPRfcBkN77uPwzCAFoKjtI46qJ5m36vRCMTIDpRk1t4KYlxsYxYTic7fXtGY59kGBdkPWX709k1xiXo1qNfLwrvDuJr58ieXpWgmZ2kMu1gbW9Ohd6YyuDYirRzRiiLMkuPEu/NeTgQPqGysoDjysN2/cxp6JUw+4vD7v2TvHuMs4YDFNpziR/l8S9RDdQeBQR2aKgmJZbSmTGq6XJLMyf173vQv0oHVDhrNBpgs/QXjRlcPK53NL6Lnch6IAR11A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgicYOyQ3IyuUs/NU/MJtSYBKGCgMfhUA6yMc1M5GMA=;
 b=dY0xLp4636ndGVaANZG8cGVVa2AHC9kYCLWmuo25f+xiFodt7knotfn3k7ovLJtlbZ2keli4Z04LPALtnBgRPLqrEQrn0dmXVga8gBEPtRDocc+EJky2w0oexUy/IMK9mSdCYdhncqqTselq0ltvNJCSD9ejwvKuTR44Dm/c5BM=
Received: from CY8PR10MB6538.namprd10.prod.outlook.com (2603:10b6:930:5a::17)
 by IA1PR10MB5993.namprd10.prod.outlook.com (2603:10b6:208:3ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Thu, 21 Aug
 2025 18:09:09 +0000
Received: from CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::8a:61cd:764a:e47]) by CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::8a:61cd:764a:e47%4]) with mapi id 15.20.8964.019; Thu, 21 Aug 2025
 18:09:08 +0000
From: Qing Zhao <qing.zhao@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Richard Biener <rguenther@suse.de>,
        Andrew Pinski
	<andrew.pinski@oss.qualcomm.com>,
        Kees Cook <kees@kernel.org>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
        Joseph Myers
	<josmyers@redhat.com>, Jan Hubicka <hubicka@ucw.cz>,
        Richard Earnshaw
	<richard.earnshaw@arm.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Marcus Shawcroft <marcus.shawcroft@arm.com>,
        Kyrylo Tkachov
	<kyrylo.tkachov@arm.com>,
        Kito Cheng <kito.cheng@gmail.com>,
        Palmer Dabbelt
	<palmer@dabbelt.com>,
        Andrew Waterman <andrew@sifive.com>,
        Jim Wilson
	<jim.wilson.gcc@gmail.com>,
        Dan Li <ashimida.1990@gmail.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [RFC PATCH 3/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Thread-Topic: [RFC PATCH 3/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Thread-Index: AQHcEm0Edhok5jEwKk+4kHDo0FX/JbRswxAAgAAPewCAAB6IgIAAONMAgAA+lAA=
Date: Thu, 21 Aug 2025 18:09:08 +0000
Message-ID: <15D39DFE-C110-442E-BF34-A850680767BE@oracle.com>
References: <20250821064202.work.893-kees@kernel.org>
 <20250821072708.3109244-3-kees@kernel.org>
 <CALvbMcA+8iHo+zCCvs4UdAg9PVQVtgOno-rtMS4i5YajrjkyGw@mail.gmail.com>
 <20250821091220.GM4067720@noisy.programming.kicks-ass.net>
 <q93o5262-po30-8n51-o17s-qrn0q96o51qp@fhfr.qr>
 <20250821142500.GS4067720@noisy.programming.kicks-ass.net>
In-Reply-To: <20250821142500.GS4067720@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6538:EE_|IA1PR10MB5993:EE_
x-ms-office365-filtering-correlation-id: bccb88f7-4753-488d-f9d5-08dde0ddd2f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NkZ5aDVERThsVU8zM1ppUE00aTg2MTZpQ0JmbkFoWThtMDhpZ0JQbjl1YlVQ?=
 =?utf-8?B?Uys4VU5zLzhJRXBtbUE0bzhwUXpyTlJ6aDhSenlObnZtTHF3dGZyMmNsTjda?=
 =?utf-8?B?L1d4Z0lxeC9XR3NSR1l4YkNaY3dyVUxjL2NyYWNKTm1SMlg0ZHhFUjVNRlFo?=
 =?utf-8?B?VjJUKzBiNGRKRHRFTC9mNTJRVGpoTHN4OWZBK1Y0NFNzQ1NPRkcwWkZyd1o4?=
 =?utf-8?B?SjJpeFhiczV4QWlMVStUR3FDNmRqd0NqbUM2RXBjNlNLM2t0RnRZYmFuQWNH?=
 =?utf-8?B?eTVhdjdWbkdGWHVNYjZhb3FGbm5VaGU5dEZyMVBiM0ZCdWVzV05HQVRIeUo0?=
 =?utf-8?B?cFJhMkMyQy9BVVlaQVhkQ3FCZXkrV1dyaDNSeVp1REtIRHUxZ3ZqRHBvZzhM?=
 =?utf-8?B?d0hZOGoxdlZ0eUxWcC92ZGl3aC9IdVQxK0QzU0trYTJhV3picVdGSUxwNnNa?=
 =?utf-8?B?Zkg1Y3lUVTRSSE1lM1d2cXVuQlpPWU9lUkU2OVJMSTRtV0FqZDdabzliM0Zj?=
 =?utf-8?B?akZMMERDS3VFNjZXdjNFUnpISmZGbkhJL1J3UmllYS9WakIwMmlaZC9idk03?=
 =?utf-8?B?RDNGalhtU2J0ckNrbjdZVVlNZDRZa3htOVNQa3JFVThhcTRtbjI2NVlTaDJ2?=
 =?utf-8?B?dlZxQ0cyMGpKeVVlcEdiZkQwZUlTdG03UUpzVkc1NjhVMlZiU0RhbmN5dVFI?=
 =?utf-8?B?d1FLVzdRMXcyY3k1M3hIZmpUMXBpZjllSUtFZDRSUTdkci9yZzJPOHA4QW9G?=
 =?utf-8?B?Um1keFBnWnlabDhITS83a0Ura2VWNVpaUElPN3B2SVN1TWZPcWU2NndldmI4?=
 =?utf-8?B?UDJUNVl1Y2xDTWt1WmFFOTNkOTZHNWhJdFlNM0RpM3dJak92RW5wOVJsUWtN?=
 =?utf-8?B?WHNRL0NwRjNzZG5URG9Iekp2dWNMbDVleVl2U1RGckVweEJPdkFBdnZxcWxy?=
 =?utf-8?B?V0tEWGtDaGJjOEphd0NLVWY4ODBkQUhRM1ltRFE5WlRGTkFzeDBaMmkwV3Rt?=
 =?utf-8?B?aVNDb3Fud1VDK1c1MGRGZzRORGxZdms0Nllqa1RmS0h2VUszTDhITk1STmU1?=
 =?utf-8?B?Tm1sQlhrWUJoazNlTVBDVW4wVkFsZGZpUkpVbHlVMkg1aUN4M1hTdWs5Znlq?=
 =?utf-8?B?azVPRDBsUER5N2lHK2pPaHRDSE93bHRjMVpscEVIaHBHT1JWK05pR1h4WWM1?=
 =?utf-8?B?TFJ6VFlxRGo1cGV3RmpxK29aZERHQzFqZmJ0L25hclFIcWRwQzVodDZNNVVx?=
 =?utf-8?B?L1pUN2Nvc1QxMG9FODIwQWVFdlE0bXZGcjdCWXNRbFoveVVhM2hKMEFxNTdL?=
 =?utf-8?B?OFNnRWxjTUduS09hb3M5SVVKdXhwOCtVWXFvMFdjT0U2Q3JTSTI1Mnp6UVdZ?=
 =?utf-8?B?bGg3T0pZL0hpWFBBSGxkMVluN2dMWFRQSmJnbDhNRVl5SE05VWxuTTVjWGhv?=
 =?utf-8?B?K3Y5Y29NQmRWZVdxZFJzWThMUm5tUHdMeUtSVVp2T25KUWpMc0Z1YXo4Y0xx?=
 =?utf-8?B?WWZuTnVkZnNMUWJnalJrclg3Y0JtMjlwQUFaWWZTdmljTVh6cmlZK0JKd2Mw?=
 =?utf-8?B?ZnMvY2ZMN1VpbG4wUTQrZkUvcHZsOFR3YmxSSFNEY1J1Z2ZOaFRqQzY0NFFU?=
 =?utf-8?B?TmppeFJhT3FLN0hJaDd4RXdIendMd1J2YXE2dGFBWndpY243bWJ6bjFvSmFh?=
 =?utf-8?B?UXdWK3dsVTdnWE5VWE13SEVRWkpRcWwvcU5QYzVydW5lUFNtamh2NklWOE16?=
 =?utf-8?B?dmhMaGhrSUNneVhxMEJCTWdhUEtlLzVkUmN4TG5NSDFHbENodVBqb3JLMjFN?=
 =?utf-8?B?MDhxb0x3SE5BSlN0RHNpcm5CclpMZWVIaThsTDFzeDdDaGxUMWM1ejFWdi96?=
 =?utf-8?B?YUpYNXFyTmpQK0RZd2RVRDZSRDJoaHAwcjkvWmU4WE9NY1crQmpHODFxNTFt?=
 =?utf-8?B?ckVsOHNwUGl4RUoweXRlellmL1BKMm1CNUVwdG1UcDNQcEx3NFh0WVE4UEQz?=
 =?utf-8?Q?bGVd9+ZEae1egtQ6C3y/UZrl0lOLbw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6538.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MlFpeTRtN21ubDJkeXJpTGlKZStGbWk1Vkg4YURpa0dzcm1vQ3Y2QnhUTU1r?=
 =?utf-8?B?UFpKc0QxUjArZTdCV3FIRHdOUG9Icm0rYWtNMk5LOElOUjFYWUsyNEhHTjZG?=
 =?utf-8?B?RGFNNDBzNlVRV29kMkFSWlBWeGtOUHRkRmN5eFVJTmM2OGU3eW1MUWJ3NjdF?=
 =?utf-8?B?bmJWL0JYMVBtVWEvVEJ5WTc5ek4zdTJpZWZEUnpKWDJrOGJTYVpJSm1OVGlt?=
 =?utf-8?B?YnRvb2xmVHlLVUswYUMyQ0xWNUV3QUp1cEFVWFRPRkZ3bURlUTVyTFNtMnBU?=
 =?utf-8?B?Ty9acmJKU0lDSmZBTTFVbUhsZ3I3aUVFYzdENkNzZktCM2t2TFBCYmJVMkRC?=
 =?utf-8?B?RW43eVprSDJlOVJ4Z204dWN1MDJWbzh6TzFYTzlVYjE2K1hZTFJoelRLMW9q?=
 =?utf-8?B?MC9hbTNkQ0d1UG1lMGg2V3VCT1gzdEhFOWoyNVdKZnBxL1Uybnc5QmhDNWdv?=
 =?utf-8?B?amg2aTNxUVFWWVFRbjlYdktXdzlhRWpYcnh2S2dUWTU2K0ZTYktXUXEyMmlw?=
 =?utf-8?B?ZzVNWFVMMDlNWXo0TFRmNUZQNVdqREJRbWxwcXhRWFNDVXVNeVJLeTY2ZElk?=
 =?utf-8?B?cDFmQjh0RUVyRzViQWUzR0N5azRVSTgyZEl6cUxSQVRkVkd5NlkrdlNuSWZD?=
 =?utf-8?B?MWh1bzRZTlQ3WE1vZmRyOEgrMlFQZm9Sd1J0SG92bkF4NWFJZWtLckdpRHRv?=
 =?utf-8?B?eG5OaVk2RnJVUzhYSG9qcjBzU0hFQlBoRXR1QnBoNFlMVWJUWGpHZ0o2cGVz?=
 =?utf-8?B?NlI4bnVwRlFuMk1SVUh3b0tVMFhIaWp2cTEzWUg1aldoMW45bzJSaG55SGNM?=
 =?utf-8?B?TDhyQkhWb2pWZzJPSVlmZElzaXBJMVQ4aUpOSElaSHIzMFJvQWttVXg3M2FD?=
 =?utf-8?B?OXY1N3ZGVmlYUDBWeWdKd1JyS0NLNDh1b1pLeElOWStJOEdIMjAxcGhpb0wv?=
 =?utf-8?B?VVBvUzZhNmJON2N1QUVYeXVoZ3lJT0xPVXo3WXFvWjF0NGp4T2wyRG5YUXhZ?=
 =?utf-8?B?MitkQlMvMFhLeDVlekRQVTh1Ly90YzhrdzNHZWdDZGFKWHIvV3FTSkZURllQ?=
 =?utf-8?B?Yi8waXZwN1Q4OUNJL1FoOFVwSitDQ1g0ZTZlc2Q1RUlhTnJSYndpWFR0N3Ra?=
 =?utf-8?B?OE5pRlVNT3R0ZzY0THBTNlpUTWs3cWt6MkdTTE1SeGxMSmVVMC9EQVMwSWZr?=
 =?utf-8?B?dnhRZndyS1hrQjJGa1NYWkp4WXhLWnZWZ1BMU0UwTmxUOXhjMVRiNGJCbXBK?=
 =?utf-8?B?dUhOdytDM3lXM0lzN25HaGxlTi9icU04M3FIdXNqUDdaZkNxYnVvelhKVXJp?=
 =?utf-8?B?N1NpSTFpb2RvVk1lcXpUbmIxOFZrUmJxK1JPL3pDd1JOWDlHeldaY1VTcGlM?=
 =?utf-8?B?eW5URURzTHdqYWZSM2dzK09ubzZ1M3JwbTFGcGszSnQ3aWF4aTJYc1M3alhS?=
 =?utf-8?B?YzVUUE1yenNvQzFyZ1RqRGxFUE5Fa1BwVDltdUlwWVQrK3Y4Yi9TTG16QUdT?=
 =?utf-8?B?ODRLNThvNnFBdHRBSVgrVU5SdFV6QzVLNnpHdG5vVkhVdE5uZWJHdjdXdnFs?=
 =?utf-8?B?MnZBQk9uQWdDTmdRbEVUMGpuZUlMa2N5eW9pSCtqWnRmWkhjeHVKR2doakhT?=
 =?utf-8?B?NzJwNmVVV0V5OVBYbmxWeWxjcWJja21XZjlOTDZSYVlzSkFLYzhsaGdUTjVD?=
 =?utf-8?B?ZXZEYWhiUVh5ekZlRE5PVVZicWhsd0pKRnpKS2lMb1QzdDErZmpVRDNycmkz?=
 =?utf-8?B?MXlxdHVxKzB4dzZXN3AzR2ZCYmJWRWZRZ1drNlIydGt2QTExU1BMa29sQjd6?=
 =?utf-8?B?V29JejVEU0FBTFVzZFNqWWRzbndvaE1CN1pFWkxXSGVBMnFyZlp0OUdLaTlh?=
 =?utf-8?B?VzlSdnJONjhoSGdhclZqd2kzOW5sMDhEZGlteFcvWlh0c1pVN0xYTmQ2QnBw?=
 =?utf-8?B?dTRXeWhEYzg2cE5sbk5ISWRqQzNOV2JUQk9MbHltOENiemwzVGJ1Y0F3U25i?=
 =?utf-8?B?WXlOWnlpb3BKUGJjNmEwazIvcUxjMU5IZzkwSkgyYlVRNHh1eG5zelhLU3Ni?=
 =?utf-8?B?TmJRaHhsaDdlTFozZk1reG1oOWcreE14dkpBZ1hGWTBWcGg2ZFRXcU5HSlND?=
 =?utf-8?Q?y4Y46WBFhoDL9K9SCZURd0j0+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D8A2960309C9741B033E8C2650EFB5B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sXNqcTSwXXYkp0vFJoedRdUrR4b10lUbjhW0sCPupRKP97D5+QlKWMijzBtGppBXQDAyWM6sLK6aXU+OzhpG5qLx8CNKIxcwP6vwYZkHg5tR6w0q2TyM0ghtbORBrCepqD4YIDlo7oqkow7SokG/nGa+st81aqzTmvaWqsH6DcK7aKHzWnMPDkR45e/JfAmZCnSeNLb841QxnhcVIeM5e6hE4J2zxQzEc1g1iaNka+1rpIXhqMIMf9r/l/q05JFgxYwApBHZ4nqukPPlKCryLO1Zp4obnLQTKfqdiNK6CxkJMmqSfEuSPtWavAbByJLEDyQAxuA9x9V0j0CpFtJKQu8yLdUbu9n7+ujTE2Kdr7hL8Jtshq7vA/3dsmwrnA1dkGwOBgRvi5ejBjAlvB1IgLXvxH+/F3A7jd+DZ3qN59TFAM+ygDWobPjFrm5KZj+1om+uvY8tNAO629UZuzwrYljCWfXR37tic427He1/GvNc5W2uyafjgIVsoDZoObRO1tonFTq/ZjNRzEM03LUyS6yNkfTl3MTC9VqT39KYRJv1Oi+WhHvtgEtIC007ZIGuI8I9pN9P2qeQiTwb35Gk1YEwEkX2ZYCNmPigdzO/2sQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6538.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bccb88f7-4753-488d-f9d5-08dde0ddd2f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 18:09:08.8059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N8983a9Csga7f/WAoy13aexUTd7+GyT+JXp8zrI3zO46HMMwUsh/TF+xX1y7l9/Xm4yOGeAAlAHg8dBiKoVbVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5993
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508210150
X-Proofpoint-GUID: JeH-hTv9ryOz1pFoa7ZfCQJZs5eqbvuf
X-Proofpoint-ORIG-GUID: JeH-hTv9ryOz1pFoa7ZfCQJZs5eqbvuf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX5wwLnD5hjlHt
 PH0OcPPI+z8E4LP2mkk4odD3ym6rTJMhnUT4VpWlO6pSB1DpFAeJdPvKdl7R7ae0gIReL4RvroQ
 iJ7+yzkX852k+afiiJc+Hi3Jh6vVF9KQE4c8tXbtVTmQgbLdy708HjLifNgxqguECXW4TfvlIhx
 7HwOa/C0sMBLNWIs+Li0pJ4/XCKcuRYXR0eu8ec3LkALZD94C0fYD94NKk+TPsQo+brHVbBKBIU
 zSwA+nBdcPwHxMKvoBO0ubCB7Zg0lIZs+I04GXnnGaxm2sD/1aOsq8yCa+3fJaRFR1TB64if0zw
 L5HyYUP+ydKGSREt+ln0coNep62HN5C3e0s6ghwGICOJyg5uZUq7Or7QwJ3aoHQwylotBB1cX31
 q2PDp4uiu2HinEP00bmS5l13BjWDbMMQcacDgvugQeXKeOgHR3A=
X-Authority-Analysis: v=2.4 cv=HKOa1otv c=1 sm=1 tr=0 ts=68a760ce b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=-uJhMygFscdG52ZMn5sA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12069

DQoNCj4gT24gQXVnIDIxLCAyMDI1LCBhdCAxMDoyNSwgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBp
bmZyYWRlYWQub3JnPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgQXVnIDIxLCAyMDI1IGF0IDAxOjAx
OjM3UE0gKzAyMDAsIFJpY2hhcmQgQmllbmVyIHdyb3RlOg0KPj4gT24gVGh1LCAyMSBBdWcgMjAy
NSwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+PiANCj4+PiBPbiBUaHUsIEF1ZyAyMSwgMjAyNSBh
dCAwMToxNjo1NkFNIC0wNzAwLCBBbmRyZXcgUGluc2tpIHdyb3RlOg0KPj4+IA0KPj4+Pj4gKy8q
IENvbXB1dGUgS0NGSSB0eXBlIElEIGZvciBhIGZ1bmN0aW9uIGRlY2xhcmF0aW9uIG9yIGZ1bmN0
aW9uIHR5cGUNCj4+Pj4+IChpbnRlcm5hbCkgKi8NCj4+Pj4+ICtzdGF0aWMgdWludDMyX3QNCj4+
Pj4+ICtjb21wdXRlX2tjZmlfdHlwZV9pZCAodHJlZSBmbnR5cGVfb3JfZm5kZWNsKQ0KPj4+Pj4g
K3sNCj4+Pj4+ICsgIGlmICghZm50eXBlX29yX2ZuZGVjbCkNCj4+Pj4+ICsgICAgcmV0dXJuIDA7
DQo+Pj4+PiArDQo+Pj4+PiArICBjb25zdCBjaGFyICpjYW5vbmljYWxfbmFtZSA9IG1hbmdsZV9m
dW5jdGlvbl90eXBlIChmbnR5cGVfb3JfZm5kZWNsKTsNCj4+Pj4+ICsgIHVpbnQzMl90IGJhc2Vf
dHlwZV9pZCA9IGtjZmlfaGFzaF9zdHJpbmcgKGNhbm9uaWNhbF9uYW1lKTsNCj4+Pj4+IA0KPj4+
PiANCj4+Pj4gTm93IEkgYW0gY3VyaW91cyB3aHkgdGhpcyBuZWVkcyB0byBiZSBhIG1hbmdsZWQg
ZnVuY3Rpb24gbmFtZT8gU2luY2UgdGhlDQo+Pj4+IGZ1bmN0aW9uIGluIEMgdGhlIHN5bWJvbCBp
cyBqdXN0IGl0cyBuYW1lLg0KPj4+PiBJcyB0aGVyZSBkb2N1bWVudGF0aW9uIHRoYXQgc2F5cyB0
aGUgaGFzaCBuZWVkcyB0byBiZSBiYXNlZCBvbiBhbGwgb2YgdGhlDQo+Pj4+IGZ1bmN0aW9uIGFy
Z3VtZW50cyB0eXBlcz8NCj4+PiANCj4+PiBUaGUgd2hvbGUgcG9pbnQgb2Yga0NGSSBpcyB0byBs
aW1pdCB0aGUgdGFyZ2V0cyBvZiBpbmRpcmVjdCBjYWxscyB0bw0KPj4+IGZ1bmN0aW9ucyBvZiB0
aGUgc2FtZSBzaWduYXR1cmUuIFRoZSBhY3R1YWwgZnVuY3Rpb24gbmFtZSBpcyBpbW1hdGVyaWFs
Lg0KPj4gDQo+PiBXaGF0J3MgdGhlIGF0dGFjayB2ZWN0b3IgYW5kIGhvdyBkb2VzIGtDRkkgYWNo
aWV2ZSBtaXRpZ2F0aW5nIGl0Pw0KPiANCj4gQW55IG9mIHRoZSBhdHRhY2tzIHRoYXQgY2FuIHJl
c3VsdCBpbiBzY3JpYmJsaW5nIGEgZnVuY3Rpb24gcG9pbnRlci4NCj4gVHlwaWNhbGx5IGEgYnVm
ZmVyIG92ZXJmbG93IEkgc3VwcG9zZS4NCj4gDQo+IA0KPiBUaGUgd2F5IGtDRkkgd29ya3MgaXMg
YnkgY2hhbmdpbmcgdGhlIGluZGlyZWN0IGNhbGwgQUJJLiBUcmFkaXRpb25hbGx5DQo+IHRoZSBp
bmRpcmVjdCBjYWxsIGlzIHNpbXBseToNCj4gDQo+ICBsb2FkLXBvaW50ZXItaW50by1yZWcNCj4g
IGNhbGwgKiVyZWcNCj4gDQo+IGtDRkkgY2hhbmdlcyBldmVyeSBmdW5jdGlvbiB0byBoYXZlIGEg
cHJlYW1ibGUgbGlrZSAod2l0aCBJQlQgYW5kDQo+IHJldHBvbGluZXMgYW5kIGFsbCB0aGUgbW9k
ZXJuIGNyYXAgb24pOg0KDQpEb2VzIOKAnGV2ZXJ5IGZ1bmN0aW9u4oCdIG1lYW4gYWxsIHRoZSBm
dW5jdGlvbiBpbiB0aGUgY29tcGlsYXRpb24/IE5vdCBvbmx5IHRoZSBmdW5jdGlvbiB3aG9zZSBh
ZGRyZXNzIGlzIHRha2VuPyANCg0KUWluZw0KPiANCj4gX19jZmlfXGZ1bmM6DQo+ICBtb3ZsICQw
eDEyMzQ1Njc4LCAlZWF4DQo+ICBub3ANCj4gIG5vcA0KPiAgbm9wDQo+ICBub3ANCj4gIG5vcA0K
PiAgbm9wDQo+ICBub3ANCj4gIG5vcA0KPiAgbm9wDQo+ICBub3ANCj4gIG5vcA0KPiBcZnVuYzoN
Cj4gIGVuZGJyNjQNCj4gIC4uLg0KPiANCj4gQW5kIGV2ZXJ5IGluZGlyZWN0IGNhbGwgc2l0ZSB0
bzoNCj4gDQo+ICBsb2FkLXBvaW50ZXItaW50by1yMTENCj4gIG1vdmwgJCgtMHgxMjM0NTY3OCks
ICVyMTBkDQo+ICBhZGRsICQtMTUoJXIxMSksICVyMTBkDQo+ICBqZSAgIDJmDQo+IDE6dWQyDQo+
ICAucHVzaHNlY3Rpb24gLmtjZmlfdHJhcHMNCj4gIC5sb25nIDFiIC0gLg0KPiAgLnBvcHNlY3Rp
b24NCj4gMjpjcyBjYWxsIF9feDg2X2luZGlyZWN0X3RodW5rX3IxMSANCj4gDQo+IFdoZXJlIDB4
MTIzNDU2NzggaXMgdGhlIGFwcHJvcHJpYXRlIHNpZ25hdHVyZSBoYXNoLg0KPiANCj4gDQo+IFNv
IGlmIHRoZSBsb2FkZWQgcG9pbnRlciBpcyBzY3JpYmJsZWQgc29tZWhvdywgdGhlIGhhc2ggZW1i
ZWRkZWQgYXQgdGhlDQo+IGNhbGxzaXRlIG5vIGxvbmdlciBtYXRjaGVzIHRoZSBoYXNoIGluIHRo
ZSBmdW5jdGlvbiBwcmVhbWJsZSBhbmQgI1VELg0KPiANCj4gVGhlIGtlcm5lbCBpcyBhbHNvIGdv
aW5nIHRvIHJld3JpdGUgdGhpcyBpZiB0aGUgaGFyZHdhcmUgc3VwcG9ydHMgSUJULA0KPiBpbnRv
IGEgRmluZUlCVCBzZXF1ZW5jZSAod2l0aCB0b28gbWFueSB2YXJpYW50cyA6LS8pLCBidXQgSSds
bCBzcGFyZSB5b3UNCj4gdGhvc2UgZGV0YWlscy4NCj4gDQo+IFRob3NlIHBlb3BsZSBpbnRlcmVz
dGVkIGNhbiBmaW5kIGl0IGhlcmU6DQo+IA0KPiAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvYXJjaC94ODYva2Vy
bmVsL2FsdGVybmF0aXZlLmMjbjEyOTgNCj4gDQo+IA0KPiANCg0K
