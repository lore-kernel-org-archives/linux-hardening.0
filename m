Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8591C84AF;
	Mon, 24 Feb 2025 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423872; cv=fail; b=HiiOlGQmcKaxjhCo3gzkLyNmhxOPY4pn5NYxNNIN4/4cjYcrKwL4577i3aG5lpRtUL8lp+IkO9sAzfvQBhZ5r03f5k6PQ02z9NEyWdmGHDb7HFuuYaGo096gE5U3gaR5lIQaf+VCG4/iL1RjXI0tqZ/1M2WLlD3hNYFo6EV+1PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423872; c=relaxed/simple;
	bh=OB49mYXlkXgGH82rdPZt52ViyJ3SeSFM4Vxt0n168cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U1NBsDR20o3BtzLM1dXr8YTlZq/K9yydSjYE8xxlGXkgIjrusZK0W3jJFNc8IHsIT8LB14TeDMXF2zaW+YFdAQ4LKwpxSOvDVSCIirlOIIkZQefG4ZBXIgICGdr7+lHm/umMh+6HoQdH2eXPGtaXrj20XETpQTBx4cbyX5CQaqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RYCGBPbt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JLnpE7wo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RYCGBPbt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JLnpE7wo"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OIfea5015875;
	Mon, 24 Feb 2025 19:03:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HV94VZ93AqUpI1V2Jo1Ky40gYOLmfZwKRrWPpnCKNZE=; b=
	RYCGBPbtrzM/mDh6u2QP4exTs0a/Dnv4r1SotBveMJGdT1w5KXY5j0iEI7r3NeU4
	4lkxZliKeVqhD+mrMNKwmb7wpR+Epy6W1eGyYmiPm6Zu746FjR2TYJQfqLhk3Ebs
	/b/8g2vhIHLV7cY+b5h1wgg2tQ7tI/v0u02xdMATJ/tf7tPc9I2T/F8IoyK2Saed
	M2qZNsh1AUnIgr+LqNn3ZFtC9hj/dNPteKyoNoRTIYkBJysBiiw/TRfeJ2IVxN9m
	3QTIBtGgwGDMA7nULEKRlkhMuuALjGOPhxu4WzQGmar2Jzq3w9LVjbAJPekr6FRK
	FG6PMxrFZaSQZZ2e20CnKA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y6f9bah2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 19:03:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OHOu5t025295;
	Mon, 24 Feb 2025 19:03:37 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51emjd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 19:03:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7oTZxh7RolTURLVULKiDJbfzlVwvkJbFhU6Fyphc474/A+Q9/d9Qd4H9j8tHmNO2Ew0fWo3auSG6ChJ4pV18Qfs/1/5HNBqgvN9K/z6QrUnpy9D7Pbt4HbhOmofmlpo7uGOy0IUwa9cM1Kjxaetjz8wiGRStZVpsjkEzyt0EhW1vj9f4p168C+g1Itd51K1K4e6TsStXMnI1YM+hKrztBkDe8qSBXD/I2jPY/fTTwej1a+g5dlVvLn30ij3GTPEG8HfGCVCAiEqnxYVdlvUJh4QHzYi8wWgNLeV+DCRIdvl1fCudJsbiCEImSfzFzhOUzaTxCFAP4CLyy4slZ4EUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HV94VZ93AqUpI1V2Jo1Ky40gYOLmfZwKRrWPpnCKNZE=;
 b=B/M2W6AQsaej9fubCl6xw+rq515vh+hyqcoufKADvt4VGabrgvBO2yMY0P4mbhX/dKB5mWuL2aDWpPUuUTDkTTtH9lPjqkvDzdKQZNUzDKGf2JIXJtveTtjdOqjB7Huu2+gBdhudWHf6XKeoatyexoCRfYtg43k9pY35r4qjHpGOmiEPySHxEp0Pol97A+CSVPD1sEqSTJNuQcsuweA8Fwcj7tWJZ3hMVGv2pNjCY1TxhVvcI5K4ww1roJSj9OrJVqbiNrHEjTA8LJPAlmwfmPS8Qffgha8rbSseGpdQQr7nVkcZTX/W3Vhn0GPgugSm/NBva6yu2Sm3SiTfnfOOXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HV94VZ93AqUpI1V2Jo1Ky40gYOLmfZwKRrWPpnCKNZE=;
 b=JLnpE7wovaa2q2PzfdAl9W2YfxCjYI5pSiP1AsmtBc8Xvs0du1x9znZY3aEFJzeIt6DcDHoIiqzgahaf6PsL6Q9c3jOk62Dmy7yMH/qPO+mHiC4ZjsFFAfcar8EEKbc7ymrzfIEXkBEraI0etRebqADQCio8StU7a2YWYqd1mnU=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH0PR10MB4988.namprd10.prod.outlook.com (2603:10b6:610:c8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 24 Feb
 2025 19:03:28 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 19:03:28 +0000
Date: Mon, 24 Feb 2025 14:03:22 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Dave Hansen <dave.hansen@intel.com>, akpm@linux-foundation.org,
        keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org,
        vbabka@suse.cz, lorenzo.stoakes@oracle.com,
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
Subject: Re: [PATCH v6 1/7] mseal, system mappings: kernel config and header
 change
Message-ID: <3nxcy7zshqxmjia7y6cyajeoclcxizkrhhsitji5ujbafbvhlu@7hqs6uodor56>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jeff Xu <jeffxu@chromium.org>, Dave Hansen <dave.hansen@intel.com>, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, hch@lst.de, 
	ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, willy@infradead.org, 
	anna-maria@linutronix.de, mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, 
	ardb@google.com, enh@google.com, rientjes@google.com, groeck@chromium.org, 
	mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
References: <20250224174513.3600914-1-jeffxu@google.com>
 <20250224174513.3600914-2-jeffxu@google.com>
 <443992d7-f694-4e46-b120-545350a5d598@intel.com>
 <CABi2SkVKhjShryG0K-NSjjBvGs0UOVsY-6MQVOuQCkfuph5K8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABi2SkVKhjShryG0K-NSjjBvGs0UOVsY-6MQVOuQCkfuph5K8Q@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0315.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::28) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH0PR10MB4988:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e8f6bef-e84a-4d2a-247c-08dd5505ec54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wm9na2JpZDBlU0JBQno2UDFPRlMwb0xDakwzV0tpUDFZaXZNVmpZd0dzc0Fj?=
 =?utf-8?B?bk5DY3FnUFp4S0haOGpIcWhyRUxDVUZzQnJGd2Y4MlpZam90dGoxcGVrUnFE?=
 =?utf-8?B?OGc3Q1plZUJqNVFIL3R5cFhTM01qQnBCVHFUdnJ0L09yRHFYUG5wdDlra1ZW?=
 =?utf-8?B?WmQ0VGMwVDZ6YVQ4ZG9ZbUVlT29FUGQrMHRWQ3BMRFB4dVloSXA4TU8wYmJP?=
 =?utf-8?B?eU1WS2tMNlFOQ0E0MkNXRnRDMytFSWpabjhkTlJ4RVhqVG1tQmlVcDBYL3Z3?=
 =?utf-8?B?YjlsWmM0amdjUWlMckRGMUVadG5TbTJ6OFg4NFFxeWtyS1psczgwVVkxZDRh?=
 =?utf-8?B?RWw4Z1J5QmVWUzlMNnFWQWk4SWl2L0JsMjRqUGlFL2FmQ0RuVFI5RVM5SFE1?=
 =?utf-8?B?TFdtVDNrVVJ5eS80ZTh4Z3ZFRWdrcm42MzFab3BtdGlqVlFGUjNhN2tnV3Jy?=
 =?utf-8?B?VUNadzkzdDR4N2doZmpIVVBPT3EycGJMWnVGYXJKWmplU3VrNmVpUGFTYlkr?=
 =?utf-8?B?SU9SMi9TS09mcFZweDRLa2U0Z21MUWF0SllUVmRqeWtvTnRyRFh4TVlHWW1m?=
 =?utf-8?B?UVpRUDlDMVczWXBjVVUrNkhGV1MvTFVHZVFOOXhhSU0rbkgrZUlFMkRBZW11?=
 =?utf-8?B?aEpaTDlTM0pySlNiTEp5VVJsVDlTejFjUXFFdkJ1K3o5TEk5TzVKWVFPcW1R?=
 =?utf-8?B?anUzM0xTN1dXVDJ1RXlzTVVJRkMvdzRUMUpZK2hEc09TMlNNVWxUYlVFVjVF?=
 =?utf-8?B?d1ZPNXpzRTlEdHVtZnhkN3BvYmNTZUR0UDd4T2tMaDhrSFhiQlJhRDBja3ZS?=
 =?utf-8?B?U3RLS0pFcEhlT2hYdm11c0xGTW9pWXpPdkV0RFVlT1BNSWhpQ1N5Y0E3MlBV?=
 =?utf-8?B?aDBCQzU5cDd3YTRYeE4rK2xVZXNRNXFtZHRqS0FrQlcwVVZZMms5OXNKZGMr?=
 =?utf-8?B?bjNHWjlQOFFObUVMTzh2c0g5M1ZyRC94WklsTTF2UlhWZlhPdGVNUEhSZSsr?=
 =?utf-8?B?STVpOS9RMWFLVWdEWGEyOGMrdTVXQktjOE5xdmhlSVI1R2w4c1VsTFhkZXQ5?=
 =?utf-8?B?YTdVT1IxajlCVWtUN2JGOXY5SEE1UW10VllhQ2pLcXdRYTBPVjd4M04rT0Vx?=
 =?utf-8?B?VS9zSVRhY1hOS2NxVnRvem80S1NBbGhKQWgzN2Y4ZTBWcm5IQ09xRE5vUVds?=
 =?utf-8?B?VDJOZ1RaamdibmJDaTZmekhING52VEhtdjMwZTEzMmU3S1ZycWF6S0RnemNa?=
 =?utf-8?B?cmIrenNWSzFQcE5zWGNQV0JCTmtoc0JWN2VIalN3L3BRTTBwMy9hN1VaTkgy?=
 =?utf-8?B?Y1NPZmNqTityZmRuWUs5cHhLOTBNZFdOUFpDdTV0eFVyM2ZNOUVUMW9qekUr?=
 =?utf-8?B?SDlwSGFXTmM4NUhNNHpMLzFzRXIxWTMrYnBPN0ovYytyVHhWSWZiMXAybXhk?=
 =?utf-8?B?S0doM1JrR2VObjdmcmZ0WCtnaERqdjRTS1E0MzhlY0EzbDl3MmovTWlNKzkv?=
 =?utf-8?B?aEx5K2R3dlJxME5sRmh6UWZWV0l2TUNhcWwrcGlJb2tHK2Zub3Q2dFVCeExG?=
 =?utf-8?B?YWhzbDZOZTZrRUEwTi82bEdZR0VyZ2ZwR25zOCtZMEVtcEY2eTlnUFYvbEw0?=
 =?utf-8?B?ejZmM2p1SkVqd0haeG84UUlsYk55a2Z5Z2V0cWdqbWZVMnFOUWk4NmRuWUx2?=
 =?utf-8?B?U3lPQUhrM0JVdXFhYnNiVUtVUDFFaERESXZRR01FVWxDZ3VkTVdaT0ZrZXlq?=
 =?utf-8?B?dTJXRUtJZkNhdzJQWHN6dTdXYXZxeE1ybTZVUWVIQnBqYzRKMTdyMStsc1k3?=
 =?utf-8?B?RHZ1MEc4TVpwMmhDRW9KaVhiSGhKRG9GaWovS3I5MW5GalRYcTlMUVFZU0Vs?=
 =?utf-8?Q?/ggh+/Aiwgu/O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ty90Vmo4ekhVTlhKcEU2NVVRWkJvVEUzSU9hblBvdXBPTm16VWwwY2NDWHI2?=
 =?utf-8?B?cjhrU01rUXd6Q0k4d1JsRTJPaTRzRUZsL3pEZHRncExPcmNJckNIVG44Y2Vj?=
 =?utf-8?B?bk9HbkpvTkRZZ1ZxUjgwVk8wNllVQXM5M1lQL2dtOFNrU3o2WHJxdzlSbkR5?=
 =?utf-8?B?dVpnWnkwWjFXWEFPWXlWQUpRUlRZOERzTUttSFV6aW9lTG45UnFScEFpa3Jy?=
 =?utf-8?B?Q3BtcEhoNXltZkoyV3Z2czlDRWpLU0VLTnZpWmxrY2gvZWxWUWVIWWV0dUdD?=
 =?utf-8?B?K2lpOWhPcXU5VFlQakJYUHQ2TWJoRzNsTmRDSEJsTFRuOHgwc2RDLzJEMkdu?=
 =?utf-8?B?SUNNVVhuSXkyRng1MDBsM1pOTVhNMnlSVGZsSGVjSlRRekF2NzQxS2c3VjBM?=
 =?utf-8?B?a0VCYkdQVm5tYVc3QTlFR0ZKcTBGUEQ2M0V2andrSWpnTTlyYVZSbzQ3L29v?=
 =?utf-8?B?bzlqdUovYmtCZmQyQk9RMW5ZbmxhUVIxYlNBM094bWNxZ1V0VFRBTTZKTE1F?=
 =?utf-8?B?YjBKNlRpcXNWYjdaQ2VseU9kMzRlUGlOb2xpc1FKMXVnbURwTmU2OHdUREJh?=
 =?utf-8?B?eTJVYUdtajhhQ1VwZ2NkSHlCTWgzYkZtbVcyTE9HSnVHREgwQ3BjcXZaM2p4?=
 =?utf-8?B?Sk04aWZXU3pvK3dvOG0vMnVmNGk2WnkrSGcvem44NmJ5aHNCeTN4Yi84cnB1?=
 =?utf-8?B?NUtBTVRaUVVjVC9qZjVXNFBZb2R6elh0elZ6dy84Y2xlSXA1WC9RNXZZMHo1?=
 =?utf-8?B?WXozeGpCZndZY1VnY0FvZkJ0VWpudDM1R3Y4ZlFQK1BZYzJWRmsvUGlSNmhi?=
 =?utf-8?B?TlBEM3RyVEk2WTFwQ1ZraDF6ZFdINThnZSt3Q1hBVmlCbjFFaVQ4WWVmeUZi?=
 =?utf-8?B?amw4VFJXYzNkcEVVaFBCTG1GRklKZGNMTGhrYnJFYzQ0NFRCcG9nLzI5VHRn?=
 =?utf-8?B?NUZJNExxMEp3TjNrcTc0dWw5K0drZUFMRzFrWTRGMitBRVpZTGc4dzQvWUZo?=
 =?utf-8?B?SjVwZnUvaDRuSGpvTkdzRUR0R3Zhdy8xbmRKT0dJOEVuTjhiUWpQUUhXWFV1?=
 =?utf-8?B?SHBsYkt4SGt4KzdJWGRBa1ZZUlVnc3BKcXFrR2hRUzRmcTdCbHdDUHZEZk1s?=
 =?utf-8?B?RGVnRXdKcWNiTVlkQ0ZubUZMU0FQRS9PeEVHMy9UeWE5bUtLVnBqRmViNEdD?=
 =?utf-8?B?MnZuZE8xYjFoNlJDTk1rVVc2aFpoaTFYWHQwTzlZOWhTRVU3R2FWTWpIajdE?=
 =?utf-8?B?UC9TN1o0UVBtVXl4TjFqL3JQZFYrcHlYNFhTeXlOSkJuWWhvak9wM2VkTXRY?=
 =?utf-8?B?UmFTVkdHZ1JsMWpZcWxQbjdSUUpyNlVyV1B6VGJxeHpubTE0TjNncGs3QWI1?=
 =?utf-8?B?bEpkZjJkVHh6bkxjZTFOamQ4UHRwQmp4dkRKVlR5VWZ2NlF5ajRvWEh3eWNo?=
 =?utf-8?B?RGwzRXladXRmaFBHR2dZakVqTW9LcUpBVUE2VWFUaUFsY05UMklXSjNNSjN3?=
 =?utf-8?B?YXB0eTdGSU9nUWtCNDh3SjZ1QmwybDlPRFlCUnl3NVp1K3VFa3E1MGdmbVBQ?=
 =?utf-8?B?N0xJOXMyYk41TUhUQlI2SW8weFVZMTVxU1VrZU9kZEE1djdJck1qTFRkaERE?=
 =?utf-8?B?OGx4Vk52NnB2RmdUWE9EdHZvQlFRSm9XUmJPZm93d09lVTRGSmR5SlMxL1NK?=
 =?utf-8?B?N3hjd3hBWUgrNGZjYXhUa1h2Z3lEMU1oN2RPd2hjMnl2UEtvU1dDenNxdmwx?=
 =?utf-8?B?d1NuRGpiQkRMazYxS1FaZ05uMUhmNlRGMmhKeTlkeE90dmZOUmZDRHZlTDhK?=
 =?utf-8?B?QVUxRlkxbTIzWmRWMitFZEdRUGYrWXo3K05oZFNUY3ZyeFNPUkJLMUR4MWph?=
 =?utf-8?B?RnBUR01PTWJ6L1gxY0dqUFVDSkkrTWQwSzBWRFJpN0szcmJqRkhGdWJuM3lM?=
 =?utf-8?B?RjdCRERsT0VIZnZnc0duVi9aYy9uV3p4QlRyYW9uWmNsVnR5bkxrdDcwRWha?=
 =?utf-8?B?d2FoRjZTV1RTQy83RDhXSFFtbW1pcnRMR0tOQllTcVg5dEpjR3lNZnE5VjVj?=
 =?utf-8?B?ZllSNEhEaXBjMGh2cWM4SmhlTmkzNGdrU1NlS0VaVE56SFB4ZTgzQ2VUZDc1?=
 =?utf-8?Q?OAwa0iNr50SE7mqW7w5OVDUaw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	39xupqdX5VT8TyjmIvHEBkriOmBGIPFAO9MmGKsIpRy2aV5vF7CU+zFjbWJ1EXG3ittLeyqXsxIpwUjKh2pYhdEA2Hon0yl2ERFyOdOVdhp3op0scoHvESdamV76rzQFYaB3wvSV9EDUTTu6mzSPOtgyd17rJmwt4gaAg2G78RmaOoksV4A3/ZUY04cuWhlRHpe72XJRhiGoC1GHYKh3433SJv5C45eCFbdIsoBGhy7sf/Bs9ed9FPcCV91DhBox8GUdfgaEtkx3EWFvdiImKvyA+KT2qzzhiXaPJZfzZrW8O7Jll4e6LWICj1If2+oHB2ne1IYDDNdRN/OOyPpiANLVfYpwjbMQ0QQ3Z32L9oQ8coxL/Zgpte/YnXmf8sIz+knFopl2Kwq26coouybD7XrnDCUYYlFygMlVhU/Q5XdMdHLhY4qcfpqbKF+ct3cgRS93jhTyjLpmY9qDNX6FlNIFH5AaU83Yvad7YDeaMTbzafSJN6RrXI5yVwgOeBqq5rjQEfcMbBGla7nL/s1alNKYImuOE9MS4Ph3Thvc5WHFQC4oWzMY3ltbozTBnVf197BILs9wMOJaUZcLFONApHfZL13yurx00L1X5IPt5/I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8f6bef-e84a-4d2a-247c-08dd5505ec54
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 19:03:28.6008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +OwQZVI0bXcnZ+qu9AjwSt4YKtuCS9FoRUDqj3qG02jave3guyju2YSVroDvcHaMLNh9tdPJBUkf2B9R6go/4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4988
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_09,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502240124
X-Proofpoint-GUID: -nc6svq1flvMf69fGp7XvcJoAb8Ufol9
X-Proofpoint-ORIG-GUID: -nc6svq1flvMf69fGp7XvcJoAb8Ufol9

* Jeff Xu <jeffxu@chromium.org> [250224 13:44]:
> On Mon, Feb 24, 2025 at 10:21=E2=80=AFAM Dave Hansen <dave.hansen@intel.c=
om> wrote:
> >
> > On 2/24/25 09:45, jeffxu@chromium.org wrote:
> > > +/*
> > > + * mseal of userspace process's system mappings.
> > > + */
> > > +#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> > > +#define MSEAL_SYSTEM_MAPPINGS_VM_FLAG        VM_SEALED
> > > +#else
> > > +#define MSEAL_SYSTEM_MAPPINGS_VM_FLAG        VM_NONE
> > > +#endif
> >
> > This ends up looking pretty wonky in practice:
> >
> > > +     vm_flags =3D VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|VM_PFNMAP;
> > > +     vm_flags |=3D MSEAL_SYSTEM_MAPPINGS_VM_FLAG;
> >
> > because MSEAL_SYSTEM_MAPPINGS_VM_FLAG is so much different from the
> > other ones.
> >
> > Would it really hurt to have
> >
> >  #ifdef CONFIG_64BIT
> >  /* VM is sealed, in vm_flags */
> >  #define VM_SEALED       _BITUL(63)
> > +#else
> > +#define VM_SEALED       VM_NONE
> >  #endif
> >
> > ?
> >
> VM_SEALED isn't defined in 32-bit systems, and mseal.c isn't part of
> the build. This is intentional. Any 32-bit code trying to use the
> sealing function or the VM_SEALED flag will immediately fail
> compilation. This makes it easier to identify incorrect usage.
>=20

The reason that two #defines are needed is because you can have mseal
enabled while not sealing system mappings, so for this to be clean we
need two defines.

However MSEAL_SYSTEM_MAPPINGS_VM_FLAG, is _way_ too long, in my opinion.
Keeping with "VM_SEALED" I'd suggest "VM_SYSTEM_SEALED".

> For example:
> Consider the case below in src/third_party/kernel/v6.6/fs/proc/task_mmu.c=
,

third_party?

>=20
> #ifdef CONFIG_64BIT
> [ilog2(VM_SEALED)] =3D "sl",
> #endif
>=20
> Redefining VM_SEALED  to VM_NONE for 32 bit won't detect the problem
> in case that  "#ifdef CONFIG_64BIT" line is missing.

I don't think it is reasonable to insist on doing things differently in
the kernel because you have external tests that would need updating.
These things can change independently, so I don't think this is a valid
argument.

If these are upstream tests, and we need these tests to work then they
can be fixed.

>=20
> Please note, this has been like this since the first version of
> mseal() RFC patch, and I prefer to keep it this way.

Thanks,
Liam
