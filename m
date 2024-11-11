Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196DE1B86EF;
	Mon, 11 Nov 2024 22:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731364568; cv=fail; b=YWNILRuWOAbH7LrQsERXakH0vs5qNT8bip/vCp0KHwZ7QU4kKm7cSkWhPLZQCUfI6fFflvn2cRuAOQYs2jdZs6JYwCmOGnxqCCBFdA7gXUp561l6khgc52Ju8u7Sol6VuiAIWX3hWBP3GtKmvFtUYzPnxdyxuHZyFZ/6nTVwypM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731364568; c=relaxed/simple;
	bh=5/f3xwLV0RNMQHN0jV38FS3a3hqKIOggGwUGLPMirzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kCBc9oytjuiYXTreLS92QvUoYqtgutaxkHpCjjNou1LmIekQDgEHNmxMNGdcViPq72YT6tgOy0fZDtxh8r01wE1qWSmFzWt3gszTqGq5mqZrdsiEoppo2U1jeGs2UZ9VjbvriUuNh7P3xx6KW2XdvpfyujOT23dL/ShWgyRTEVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OyALtg/Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x6EOq5r0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OyALtg/Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x6EOq5r0"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABHneHQ028858;
	Mon, 11 Nov 2024 22:35:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=MSQ7+pqHy5vAYdlCrPn8lblxbEyNR5PVlMT4IgAHkz8=; b=
	OyALtg/YGzSFAE1GYkqElvECkd2CFA+HH6iKjkZMJ27Sq5wz+RvabtaUjDYdLOIN
	UgAxQyheHslVA2EnFN5bvUKUHr992EuNS1toXoRZFyCzU9dW789pCYblCtrjwuOK
	j6SWHtxwATOyb5aiJDZVvynEzCM4k78TNDA9b7dJE2eE66OpuFo/oEEPlihKv9Ji
	eV2/rFlf8uSoacbvBuEiz8SuvmXxIIVzVql2uY7IlEeG1MNXeftXZU52JFFYZAEv
	H2u6YzaQdZB4FQTuSsL67tOO/My0wEPNx3qF4yjFBb4rlV++53YZIMAXwZK7FClG
	qp+QQteY/7kcPrG0AElP8w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbba51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 22:35:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABLZELB034430;
	Mon, 11 Nov 2024 22:35:18 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx67g9kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 22:35:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uB0ORUAEmxZoKlqVouFX3F7j0ETj6ZuivL+GqQR+JCUCJc6LKJ6QbwA1OYezwBhDyEVeNEu4wgRHVJSbgPjfaIM9YeWa0tUP2aBhWy/+tLY/N4Yc+sIoiiCv+GI2+SdxCLpxxVCnvEn0xsF24rDpW8RxRcqO6q0hEw95bTisSOCAfDxc1wJZD30asX4zqvTUjVbqKPQYkm+kNVyClBr+bsUF9Mzc7DIfnaIIez7HsOhe3q6M4uCQY7s/zJ4kpxpOLjlfkrjoQww63UyPbYo8i0yK/tIzcl+S1ynd1KmFRww5rErK73keEzvYLDqPpvPaq6gt5HjdJzG+HI4sLnjwLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSQ7+pqHy5vAYdlCrPn8lblxbEyNR5PVlMT4IgAHkz8=;
 b=PkpCROlEgfp23sxIsqDxOynvy1vdaSuTaI8FWlKRAh23JxtNNYPwgxiYziyyHs0C2iO5qgOvLEvSmW7JLEMtwyaUjyJHdQ68YTVCVLvfHDZmbRjCgxDwmP/zLEDQ+I/neFbm79IcKm2lJ/1X9MVBvenCZKFnbr+5kEgVJzySytstK5Et9UiNhLhcpfPxz67aue+2npDW8bn0W4GRoW5ZFKrjY44QgGBtw6MaNILKTqrUNuDJe6+FgdzALVDo63xFBlOzhCjMBrI72LgcGmOc2iLJISyRYhx6lBYp4fR4I42f2mbN7m6DyxGLIzyb9BmLFJFZ5ZmMX6TyGOfzi0hmxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSQ7+pqHy5vAYdlCrPn8lblxbEyNR5PVlMT4IgAHkz8=;
 b=x6EOq5r0rP/AoqLdKlTr/eo3Zl1q7E/DIdnhH3ANl2qZpmwCntbv7gHzUGgaQqMsG9338z083C45iocP9B2MmkY3OtyKG5QJMUFPa6SnF39g6YUhtbnokw0f5R+1xloxGAUyoPtPX8RclB4t1BqgJMNKq9vDT/Q21viJzatWfhE=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by IA0PR10MB7381.namprd10.prod.outlook.com (2603:10b6:208:442::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Mon, 11 Nov
 2024 22:35:15 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 22:35:15 +0000
Date: Mon, 11 Nov 2024 17:35:09 -0500
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
Subject: Re: [RFC PATCH v2 1/1] exec: seal system mappings
Message-ID: <5wpwj5uokivgcwfcpjh7lbi4g64gecsajfn6glghfmc2lvzrgd@2fz7zhgmsduo>
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
 <20241014215022.68530-2-jeffxu@google.com>
 <6r5sxlhfujr2expiscsfpdjtraqlvy6k3cznmv25lo6usmyw7x@igmuywngc5xi>
 <CABi2SkUfXrRLg7+ZrLjMEQzh4FtU0EAfckdiDuza1mFKzi0SAg@mail.gmail.com>
 <agkliam473nmhxirk76psryxh5qkrncdhwzyoyf4w4efkxnubw@vkeini5qa6xw>
 <CABi2SkW-cWJQtT2E_vO40bFi7Qrr+At3Q0jFVVQt+WZP=jaHHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABi2SkW-cWJQtT2E_vO40bFi7Qrr+At3Q0jFVVQt+WZP=jaHHg@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1P288CA0007.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|IA0PR10MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: c68c6021-654a-4076-5c3a-08dd02a11c77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDJlT3hCZ1lZWjh2WVU1R2krc2dDTTJUSnhuKzFLSTZzdkEvOHdIUmI3dVVG?=
 =?utf-8?B?SlphRExwWEdodWpzRkNHZkQyZWlTU3BIRTlQUVE4NVJhLzkwdVFoWm5tdSt2?=
 =?utf-8?B?Ulc5cmZ3UkZ1dWhIN2dzQnpuazFyMzF3SnBTWUVaVVROZGlvTkozQVRrUitU?=
 =?utf-8?B?MTF0eTNnZWhQZllIbysveEpZclptZ0ViMlhWdnM2UFdNVEg2My92YlFJQk9l?=
 =?utf-8?B?TnBmYk1BSFhvdVpXTC9iWjgyWWZ1MFd2Mm93WFNsVGhqZFF6eVBpaGkyWis0?=
 =?utf-8?B?cE9UY3NhRXNteXl6SzJFVzBWMThMVGdqeE55dnBoL2VqVnkyZGNUWThNN0Zt?=
 =?utf-8?B?Q1ZXVDAzNzlKSHF4M1VTUldTTVRVQXYrcDlnZkM4UjBsOHdEVkJqZXRKenpG?=
 =?utf-8?B?WHYvTGRPVXFWUEhqNENHTnVqejlsTnJ3T09rcUE0M0JWMklEekl4SXJUbHRY?=
 =?utf-8?B?WmdrMHBEbm13ZzUza0tDZXBteFp3RGFqSDBLOUpOYi9nS0hkSHRyOHdMTEpR?=
 =?utf-8?B?dlVwQzJ5dXQyYnNmRUZ3QVZkOXhUY0hlK2RQdVczYjUyV1VLREhTTzFKVkYx?=
 =?utf-8?B?dDc2b21RdkRWcmFZYVhyd1FwZXpSY1pPRGpBUUd1d2YyR2NvTW4rMFI1Vy8w?=
 =?utf-8?B?ZDVQVUdUMkV0MmsxcTNlWFdJS1ZUakRPbVZHZEl4N2xLSFFxWWp4b1piNTlV?=
 =?utf-8?B?OHBnSWp4bkMvUXR2eVEvVDVnWWdSZ1lrNGV1T3ZmcW5QTGNZTEFPSkJ5QnNX?=
 =?utf-8?B?T0FqQVcvQXFCQ0pUNXBVRElwcTdXTk1kb09ON29FU0ZkZzQ4T2FsVFM0OVho?=
 =?utf-8?B?WDQ1alVRbW9kRjcvbFpZMlpheU9RTmx3a2R6S2ZiYmpPN1VyYzdETm01cHho?=
 =?utf-8?B?WEd4WkhyWTZtS3NaZDJ2VEJZOXYvTWRSV3R0TUcxZXRYZllHblJrekRBdlE1?=
 =?utf-8?B?ZjR4aUxOcS82MDBkNzdUdnYvczB1Qnd6TjZ0aWp6MEl5a0hhN212QUFHRVpo?=
 =?utf-8?B?NVA4NHNPVW1oLzRpVmVnaldKRmVuU3Vmb05tQW1aUWp3NXRtZTQzcHhyaW15?=
 =?utf-8?B?aENLK2JVdURXK0VoOC9lUjVzRDJmaTZZZmVtT3UxN1UxcUNHckdiMWtFWEZN?=
 =?utf-8?B?b20vM0t0NnBZaUd0S1FBc3ZBSSt2dzVNdGpieU1OS091ZWJNY1JiMys1MHhl?=
 =?utf-8?B?QjlWWTNEV3o1TCtUMVFLbG8zeEk2SlZ4UHRuSDRXdlpjREc2M04xazRDOHBD?=
 =?utf-8?B?RnVVZ2NBWDZBLy9jMTNUNERlMWpxQW41RmQyVnhGWldmcThEeVRCQlh6S1Y4?=
 =?utf-8?B?MzFjQVBITmkyWTRod3d6NHBTUk5FTkdSbjkzai9ibFBUMXJpZ3VZOGdrMDNv?=
 =?utf-8?B?U29iUEx1OCsxTEJKWlNGeTJaNXdoMWlkQm5tbUx0bDJ5VFFpNmVQcG9iQXdt?=
 =?utf-8?B?bVpCaGdDRFNibGQvM1dNbzh0MnFzekRsRUY1WjlQZGhGa0p1WHFVN09mcGJ0?=
 =?utf-8?B?OUF5TjUrRlNlQWI1V3ZmZkFGKzV1ZlFTb2lwaXN5WWJaakN5d3NGVWpXK3hI?=
 =?utf-8?B?ZE44R1dpTGVsRU1VRmJIaHNSOUFmclNyNVhyR3VSSlpHOURrUENXNUVwZ2VW?=
 =?utf-8?B?V0pxN0tIYUl4VWJQUE5nM000ejBaaTRnSEwrcDVpc090UEtsSUZtU2d1WnNJ?=
 =?utf-8?B?V3ZFdGROVVV5UklIM1B4V2tJeEF6OTIzWEg5Slc0Vm5xS0Q2VVBvaGRCR2k2?=
 =?utf-8?Q?IGDkwOJBYHaeQEuiY0xhTsg36Hs/wfOT1wEm9N5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFdXdmhacFhoeTgwc241aUwrTGw2aFg4eStRSlFER1J0QStLWGRxdEhuV1RM?=
 =?utf-8?B?eVk1Wno3K3Z0cndybEhJSVhFZ2o0ZStvcSswTUtYR05pTDlpQ09PbEt4dVli?=
 =?utf-8?B?Q2ZyTnlIL1JQdFF3UWUyRFFzcXA3VGwwR012UFJBUTRKVjlPQUEydERHN1VC?=
 =?utf-8?B?WmwwclE2VVFuQ3E0QlFZOFN6c2ZUSEJtQkZxam5uL0tDQnZCTnJIYnpWeDY2?=
 =?utf-8?B?b1Z1TlN6ZHZCL0NmWFJkZHZlRG9EWHkrMTB6RHFXOUVEOXVNZjlVbmhJWnhC?=
 =?utf-8?B?ZnFkVGNLUXpvYjIycGNOeUh2djdKblZJYXJQaUp5alpCV1pLY1M2YUJOdDNr?=
 =?utf-8?B?dmNBZFR4dWtaemJ2UnJqL2FuM2pjNmJycXE1TFBPQVRYRVFlc3FiQXg5NjNB?=
 =?utf-8?B?Q1RuSnFLbWlGZXB0VEt6RUpRZCtPN0liQngzT00wNzB3TFNHWW1WajB2Q3NX?=
 =?utf-8?B?YmhRQk1Fc0VXbXFkYnAzUFNxZXQzWE85TFhZY0JxdUF3bUN3c1FvZ2pPV0Vo?=
 =?utf-8?B?VVVQdTFhMXM2QXR0S3Z0TEtMVTAwL3I5eG5lQnVKaGhpY0d3d0daanFHd3dY?=
 =?utf-8?B?Z3JDV0pTeVkzTjJXNXlvTzNlcHM4bGY4VEFPK1hpR2hjMjlHL01VZlNiQ2tx?=
 =?utf-8?B?UFdQRmdCT09SbEZPR1IrTkNsMTUram9pSnIvZkJZZUlkK3Y2QWJvYUVDaEFK?=
 =?utf-8?B?UFBUYlNaQk9tY1B4cGV3UG4zcEcvbUJwY1V1WUh0TDdUQTkyTmEzYWtwKzlB?=
 =?utf-8?B?NmlkMzlpSkZCV3hBSmNkdU5oUWdrYlE5T1pJZkRJbGZYVEFlN25vTzIreW5j?=
 =?utf-8?B?QWdyZ0t1WndiZFVmdGV2ak9IN3d5dkxUM1NHRUcxWkh5VmY2eFFWeFdSeDdE?=
 =?utf-8?B?aGs0cWpKR2s0RktmQW5PeFN1WEMrUlpaY3pXK0NqdVNCTzJsSmxRejVscHp1?=
 =?utf-8?B?RFgwY3J1QXRKQW1PWGlxZzRCYzFYNGlYamFVclFSS2lVTXRRblZCdklNNHBs?=
 =?utf-8?B?RE1GOGhaZnlVcUdUWDFPQUhBbkhmMU1JWW5YYkNEMzJ3TkxqOEhIeG9pQ0Yv?=
 =?utf-8?B?eXgrTHV0OHVwK01ER3pJS0kvd0FtQUQxUHgvYm8xQkFFa0EydmFPYzdrakhZ?=
 =?utf-8?B?ZnB0THZWVXVDVm1MbjJPZFlnRkpGYjgwUkMyVnQvalJSTjRFZENmZzNIUkZF?=
 =?utf-8?B?YTNCVlhrcFJOQ3o0eDFhTDZhWHhwdHVqK2NmY3RSOSsxYUdDMW1FdTcvQjJF?=
 =?utf-8?B?ZGhHcGp4WHFZRFRkSDdlRlp4ZHNEcDFTWUtEVml3RDNkellSNHhYZGVvR3Fy?=
 =?utf-8?B?T2JjNHB0LzJVQ244alc1cVNUQjhsQ2lwV21qNVJpZVVrSXNwNytEM2dFOCs5?=
 =?utf-8?B?SUNhSXZTdC8vRnJhNm44WURXN0pTQXM0MU5TUWRpS053ODNTSkVqdlR2dXEz?=
 =?utf-8?B?akZFUjh0RU4wRm03dUxzU3plYXNXcXgrQ0RCMUkrQTFRUW5WNXlZc2h6bElt?=
 =?utf-8?B?MUF0enZSRytYbVhoZWdPQlFTTDZHbnAwS0ExaG91Mzd3QldXMjQxN2c0QXN4?=
 =?utf-8?B?bTlXSjdtY1pWRit5aXkrOWdMY2xXczlXbTkrRVc1RTgzWmdiS2pCdFN4TnZn?=
 =?utf-8?B?MDk5QjZjMS9YYThWYXEzeGRaUmZoMXdmV3ptaGRSenhaekxLNFRqY3BZSyto?=
 =?utf-8?B?NUtneTNMRlhDaHFtR2loLzNSR01rV1RBNzVhckJFdmp6S3pzNStrc0VLbFpx?=
 =?utf-8?B?SUFoeGxBdTd5ZGM1RUszWEQyalRLTjA3T0FyQWVmdUZ5dnBMdHZzK3hrdHUy?=
 =?utf-8?B?aUxNakZXNlhmU0JRT2NnVE5hN3d4WEhLVjh5bHVITEFoaTVkUUJRRFdLZlJ4?=
 =?utf-8?B?YThVenh1aEFPd0pmR21URlR2eWtYeW9LSzA4cm9MY3RTaS9LVTRuYWVUZ0hl?=
 =?utf-8?B?MFYvVTFOdU5hVWpTWHhHUzhweU53d1d6UWZUck5lU3I1M0hFNEZKTGdvbjdD?=
 =?utf-8?B?SHRsRzFQV0FoZHNXU1BJU1JPY2xRbUJ0WG5oOEpFUFRTdjErNmJVM1dld1Zx?=
 =?utf-8?B?djIxcnV2R3lWbW9WeC9jY3Q3YnUvRGM3VHVJREd2eHpyc05Xek5EbjV2TTVo?=
 =?utf-8?Q?woTHqLiEpGiN4OsMC131kkIMu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hQ8f1/l36HpX07jsR9keIepmYSxZR78kF/p1dWGpFQ7cG2bJcLZ1sX14ChJFyXrKaUpHWCWKHwzzLzrPjD9+fh8Jz7reVcoyq/Xvmj1BtQFzI/SdxTDuSlf/+euugtGwzGpP2bIGjs34GKJ0iRQ4mrNNvbec3mX3FFEPTtTxL3r1QQMkfLmvuAvKsLT6ESgw/bXl4l3q2q82vSn0YJJqpYSCB9vzXMeHRHzgWznt/w3YZqxt1yP0ChLCMsPjXs9lCTjhun5CocGXaKTTwjHNazvxanVZBU9GUeoAtTb+vdtGhdF3776pc/d8ULZ44TYyTXAglybobeam7B+YfIRTCLEjOa2GUYM99OXWen+qTHRpG1EtMoJGSQsESAq/OEwgGX3POvHZSKvGZvUH2Yo7ZuMleuDpDR4RlOBByWTmW2dUdJT05VzAX1JCrGu0UpeEetUXKCBuIOBuw1GbTZY4++F5pH+H0Tyk0Q1OdyMoGetZEJqlz9lQIpOV/RDhPo72wDYbtFEdDnYs0i+TCNBdzLnS/EMFhebsCIYgv2Ee9dLKXXF8/Byv7SzqJH/1zXDwpCePzRF4PHnu8v9GmAmbJRUm38XDAylHNBSXWVL+iqA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c68c6021-654a-4076-5c3a-08dd02a11c77
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 22:35:14.9862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NOYS2nKPkggCapxtB9pWJQkK5QYxpnTlZx3EI9WojUA/ugkwUekS42StUxVRQzd2MaB5/1jjWx/CTNg6GodzRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-11_08,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411110181
X-Proofpoint-GUID: gq7GwCb7SfXW-XceE4FzRKT88JcYT6Sw
X-Proofpoint-ORIG-GUID: gq7GwCb7SfXW-XceE4FzRKT88JcYT6Sw

* Jeff Xu <jeffxu@chromium.org> [241111 14:10]:
> Hi Liam
>=20
> On Thu, Oct 17, 2024 at 9:01=E2=80=AFAM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
>=20
> > > > Does it make sense for this to live in exec?  Couldn't you put it i=
n the
> > > > mm/mseal.c file?  It's vma flags for mappings and you've put it in
> > > > fs/exec?
> > > >
> > > If you are referring to utilities related to kernel cmdline, they
> > > should be in this file.
> >
> > You created a wrapper for the command line, but then included the user
> > in this file as well.
> >
> > hugetlbfs reads the command line as well, in cmdline_parse_hugetlb_cma.
> > That parser lives with the rest of the hugetlb code in hugetlb.c
> >
> > I think this has to do with your view as this is an exec thing, where I
> > think it's an mm thing.  My arguments are that you are directly adding
> > flags to vmas and it's dealing with mseal which has memory in the name
> > with the file living in the mm/ directory.  If I wanted to know what's
> > using mseal, I'd start there and totally miss what you are adding here.
> >
> > Besides applying a vma flag to exec mappings, why do you feel like it
> > belongs in fs/ ?
> >
> The vdso/vvar/stack/heap alike are type of mappings belonging to
> processes, and are created during execve() syscall which is in
> fs/exec.c.
>=20
> mm/mseal.c provides core memory sealing functionality and exec.c uses
> it. IMO, it is better to keep the provider (mm/mseal.c) and consumer
> (executable) separate.

IMO, mseal should not be sitting in its own file since it's just a vma
flag.  The entire feature is to do with vma and vma flag checking.  It
should at least be globbed together in one file, as much as possible.

The way this and the help text is written means there is only the
VM_SEALED flag that links this to the actual feature name.  And with all
the abstractions, that flag is 2-3 functions deep across 2-3 files.

In fact, there isn't a dependency for enabling mseal in the kconfig?
Isn't that needed?

Please fix this.

>=20
> To make modulization better, I can do below adjustment:
> if (seal_system_mapping_enabled()) <-- implemented by fs/exec.c
>    add_vm_sealed() <- keep in include/linux/mm.h
>=20
> However, if you have a strong opinion on this, I could move the
> parsing logic to mm/mseal.

Yes, please move the parsing logic together with the other mseal code.

>=20
> > > > > +void update_seal_exec_system_mappings(unsigned long *
> > > > The name is also very long and a bit odd, it could be used for othe=
r
> > > > reasons, but you have _system_mappings on the end, and you use seal=
 but
> > > > it's mseal (or vm_seal)?  Would mseal_flag() work?
> > > >
> > > It could be longer :-)
> > >  it means update_sealing_flag_for_executable_system_mappings.
> > > mseal_flag is too short and not descriptive.
> >
> > mseal_exec_flags() ?
> >
> It needs to be more descriptive because there are also stacks and
> heaps to be sealed.

Stopping vma modifications to vmas that exist specifically to be dynamic
does not sound wise.

> I suggest to use below name to make it shorter:
>=20
> if (seal_system_mapping_enabled())
>    add_vm_sealed()

I am not sure what one you are renaming or what these functions would
do.  I think you need to look at your overall design and try to fit it
into what exists instead of putting a call in a wrapper function
(_install_special_mapping) to alter an argument.

>=20
> > > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > > index 57fd5ab2abe7..d4717e34a60d 100644
> > > > > --- a/mm/mmap.c
> > > > > +++ b/mm/mmap.c
> > > > > @@ -2133,6 +2133,7 @@ struct vm_area_struct *_install_special_map=
ping(
> > > > >       unsigned long addr, unsigned long len,
> > > > >       unsigned long vm_flags, const struct vm_special_mapping *sp=
ec)
> > > > >  {
> > > > > +     update_seal_exec_system_mappings(&vm_flags);
> > > > >       return __install_special_mapping(mm, addr, len, vm_flags, (=
void *)spec,
> > > > >                                       &special_mapping_vmops);
> > > >
> > > > If you were to return a flag, you could change the vm_flags argumen=
t to
> > > > vm_flags | mseal_flag()
> > > >
> > > passing pointer seems to be the most efficient way.
> >
> > I disagree.  Here is the godbolt.org output for gcc x86-64 14.2 of your
> > code (with some added #defines to make it compile)
> >
> > seal_system_mappings:
> >         .long   1
> > seal_system_mappings_enabled:
> >         push    rbp
> >         mov     rbp, rsp
> >         mov     eax, DWORD PTR seal_system_mappings[rip]
> >         cmp     eax, 1
> >         jne     .L2
> >         mov     eax, 1
> >         jmp     .L3
> > .L2:
> >         mov     eax, 0
> > .L3:
> >         pop     rbp
> >         ret
> > update_seal_exec_system_mappings:
> >         push    rbp
> >         mov     rbp, rsp
> >         sub     rsp, 8
> >         mov     QWORD PTR [rbp-8], rdi
> >         mov     rax, QWORD PTR [rbp-8]
> >         mov     rax, QWORD PTR [rax]
> >         and     eax, 2
> >         test    rax, rax
> >         jne     .L6
> >         call    seal_system_mappings_enabled
> >         test    al, al
> >         je      .L6
> >         mov     rax, QWORD PTR [rbp-8]
> >         mov     rax, QWORD PTR [rax]
> >         or      rax, 2
> >         mov     rdx, rax
> >         mov     rax, QWORD PTR [rbp-8]
> >         mov     QWORD PTR [rax], rdx
> > .L6:
> >         nop
> >         leave
> >         ret
> > main:
> >         push    rbp
> >         mov     rbp, rsp
> >         sub     rsp, 16
> >         mov     QWORD PTR [rbp-8], 0
> >         lea     rax, [rbp-8]
> >         mov     rdi, rax
> >         call    update_seal_exec_system_mappings
> >         mov     rax, QWORD PTR [rbp-8]
> >         leave
> >         ret
> >
> > ----- 48 lines -----
> > Here is what I am suggesting to do with replacing the passing of a
> > pointer with a concise "vm_flags | mseal_exec_flags()" (with the same
> > added #defines to make it compile)
> >
> > seal_system_mappings:
> >         .long   1
> > mseal_exec_flags:
> >         push    rbp
> >         mov     rbp, rsp
> >         mov     eax, DWORD PTR seal_system_mappings[rip]
> >         cmp     eax, 1
> >         jne     .L2
> >         mov     eax, 2
> >         jmp     .L3
> > .L2:
> >         mov     eax, 0
> > .L3:
> >         pop     rbp
> >         ret
> > main:
> >         push    rbp
> >         mov     rbp, rsp
> >         sub     rsp, 16
> >         mov     QWORD PTR [rbp-8], 0
> >         call    mseal_exec_flags
> >         mov     edx, eax
> >         mov     rax, QWORD PTR [rbp-8]
> >         or      eax, edx
> >         leave
> >         ret
> >
> > ----- 26 lines -----
> >
> > So as you can see, there are less instructions in my version; there are
> > 47.92% less lines of assembly.
> >
> vm_flags already  run out of space in 32 bit, sooner or later we will
> need to change that to *** a struct ***,  passing address will be
> becoming necessary with struct.  Since this is not a performance
> sensitive code path, 3 or 4 times during execve(), I think it would be
> good to start  here.

No.

I have pointed out why this is not 'the most efficient way' and you are
now switching your argument to 'this will be needed in the future'.

Please fix this.

Liam
