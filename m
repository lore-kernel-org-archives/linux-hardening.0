Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA9621ABBB;
	Tue, 25 Feb 2025 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497873; cv=fail; b=fYnItpkyYzRJ0R5KVuJrJSbLJnFIc9Ms7LiyoIE5gX/OaeWwBGcZ6w2JhGXP7Ek7SvyNRmg3XJVbSZ+I3UCG4Uc49SV7NE25EAKfHl1vqG7FBP2wWHL7iLdxS+OAVf8uJA7knuaqbsO6gWo1kxusDFLnjGA8ZqFpKJJfV9nmXDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497873; c=relaxed/simple;
	bh=gjFqlF0c9S1BHCZhGn5LFySZwKBlzr/awbtiEVsnrGQ=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jwUSof03plBlf7VDqR8zOiLhsMf7PAC36cKC5U5Np1wnbKdWkt7Eej1m2/rFWcWEUnGKrg8CVYvpmq1Z9f59y9I2rkBNlmdLt2ILpGogrpIrBxJe8+wmo67252+se9SRJrOsE5ERRTLAh/qlx8vFZS4RbqCQRl1Uul8/WRd8Kn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ODB9Rba9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ygRIa98o; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ODB9Rba9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ygRIa98o"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PFMbAM006516;
	Tue, 25 Feb 2025 15:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=6Q+HJUmv2D5xEtxtTA
	wo/2VYjIE3O/0t7C4QYUGACX0=; b=ODB9Rba95jxxDcKj1TqV7doW95gJcd4tSd
	ItMqPOfl7GzDTWiC08R12AyCTxJFpds7uk+ci2/h+GymCveOWPtCaocX1a7uTTF3
	vMrqSIADeic73/9/cloJhNAxsNP04S4TUreW/9+62n5zXnSHpvVu25jte7gS4JMl
	1vUPY3DkJSn9JxjI+7S95NHBcsR69w3pvBXy+VX/K82ws/0cJcR3iOfXpg8b2EAP
	QISAqoLJPmICRdg1V7inHU+EuUmWSuEeJE8EB7DkMFhJ9NEZJneszZuBgbq2RtVq
	eB7dmapD3M5q6Y/7UIdiNJXpfnavyqdDwwiYONSW7we1SSZfNTuA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y50bnh29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 15:37:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PEj7fx010085;
	Tue, 25 Feb 2025 15:37:11 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51944jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 15:37:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZx/peRSs1Su539qD0d0sEyG7DSziRGr5gbtGF1fnpbvMp6t6T6NaHzs0qVh9geGroE3VA5zHAfBFiU18nSjr2ydDSyBd28gq3lsHToRXSuvxg4w5nafXROdpeBzXrF+IuweaQ/LTUC1N1DuLONhh1r24HT5BMDyf/8KUaYUX2GZWxHPNBU7+pU7Kr63pU7FEpfoVIZKIMJN68unn/8Wu58Otp0VXyK2JBfQ6GYOVWM+CCPwTqRJC6Gb+FHh/YKC999mFmSMZkWywTlmxf+Ck6Yw9uHtsZydUdBpK7tQq+iRktOGFcWX/vS+krOlFyvLr6WElxBzwYlVdTDaAfXNRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Q+HJUmv2D5xEtxtTAwo/2VYjIE3O/0t7C4QYUGACX0=;
 b=V9+ELxuoF3IRUoPaf9vgD2NTYyWnB/lYFXxBBYPLppXAPlfPe30xXjH6Ux68GIJJ9ApuePkGdLvdj9b46FindpIdylcOPOSR0qfxLjA42uqM0l48a1WUQgcVnAyh4jiaKdyn6XpnzmD0XiPSuCF1+636d+0wCyv5XczKm89hz8Hj3mVdL9Xicf68kLrRXIWj08WssoCX32uYXCOoMdNk9Byw6PW7kwTAHw4n1NBKDDDAjJ2B+FLW+hxLEPc5h+L8e57DktZOxP10eK229cuareViRqrEtTAgWyZLbnbbfsDSUEA+FcS5Vm9udICGkGh0iRTROUZblcJU5EY0dxH1Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Q+HJUmv2D5xEtxtTAwo/2VYjIE3O/0t7C4QYUGACX0=;
 b=ygRIa98okLaalLjVApah6FBgp6bXKSV0dbjCyy69Wrq/n13CzVPvN1883Ms5RZaFVMsOCPwjJY5JLyIINXjnFh3rjhOq3+5gO99JR+lBm1a2idT+46ykQSJpcQrIP5SBuKMxZ2LP0YNzewG9OCAMhiEzL5peJGJLN/yHbq0zuDI=
Received: from BN8PR10MB4099.namprd10.prod.outlook.com (2603:10b6:408:b7::32)
 by DS7PR10MB4861.namprd10.prod.outlook.com (2603:10b6:5:3a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 15:37:06 +0000
Received: from BN8PR10MB4099.namprd10.prod.outlook.com
 ([fe80::5db:fa9a:dfe:2a2d]) by BN8PR10MB4099.namprd10.prod.outlook.com
 ([fe80::5db:fa9a:dfe:2a2d%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 15:37:06 +0000
Date: Tue, 25 Feb 2025 15:37:04 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, jeffxu@chromium.org,
        akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        torvalds@linux-foundation.org, vbabka@suse.cz,
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
Subject: Re: [PATCH v7 1/7] mseal, system mappings: kernel config and header
 change
Message-ID: <fedeca63-5c6a-489c-a5dd-12ec9b601ce8@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-2-jeffxu@google.com>
 <bekot7b4mhgdsp636e4zltao4bnqoeiu46yehrwpuzydfgt3ya@t5njn75sbvym>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bekot7b4mhgdsp636e4zltao4bnqoeiu46yehrwpuzydfgt3ya@t5njn75sbvym>
X-ClientProxiedBy: LO4P123CA0339.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::20) To BN8PR10MB4099.namprd10.prod.outlook.com
 (2603:10b6:408:b7::32)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR10MB4099:EE_|DS7PR10MB4861:EE_
X-MS-Office365-Filtering-Correlation-Id: 65dee43f-5a59-4acf-2256-08dd55b24260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UtA6I/wnvJfNjZIZfbk2d03aMbivb9v6sXTFnow28XNLZ0Ni7LYA2TXflXIs?=
 =?us-ascii?Q?o1Oh09VUs4fdgbpm1nQFNkb5vKw5Mc9Jg5cyz8BENEufFZgFaI01i3qggCv+?=
 =?us-ascii?Q?evqwn91I5MCdZvwrDu0BytX4BKQKF/sOrXf00zUgcF1P4/DU6EQIAA0hf88j?=
 =?us-ascii?Q?v6jzelVK8Qn6wUmuXfso1wNrWpoKzFE+sAEbWb4pMw4US8MhlUa1ICUXkRCv?=
 =?us-ascii?Q?oLEN3wbrSIY9UCbq40NqeQppSXRPby5plDg6WMV5Jt8fALnmgfALQw5H27PF?=
 =?us-ascii?Q?uf/rnDyXNAQXgNAPXuRt0LiOTGz2jTiC1thOq8GpQuASlI9MOU1xfgsW2VJA?=
 =?us-ascii?Q?mNXGlaqT5Qt/CS7iQfLiCRksF5fPKBrf3NGBwvD5C61iYGNOmLmLYJZO3S2m?=
 =?us-ascii?Q?Hw/sQjDRG33KRkE++/q1VJlIGyRgwpUTNCA8zGN1cTj2MJrlaT74NhUFnmlZ?=
 =?us-ascii?Q?83Bi7K8fLtg4Os/HkjN99RSqRg3Bh11Fxa2fzOWC2IBIpqpNrOx1rHRH9qV5?=
 =?us-ascii?Q?+QiujT4PlZI54zhCRxMFBVbcP8/IHcO9rzSvU2jg3/bupBjWS/nZPd1XAKyi?=
 =?us-ascii?Q?e5VZsLrSCtaqxX0MS18fFCXgXlojmnvQxypkvs/Gxr5Vd7+zPWtAtbKEZXhi?=
 =?us-ascii?Q?sNSf+9d2TYw3ittwmQ/OY5lOk+YstQ4kIHnOxbKcB72O2RRJbjEXyZZRFNUF?=
 =?us-ascii?Q?+nb0i6Uh1yvNAq3Go28d24RInKNxYs6Bo24+tbxD15Qvwie1uKfWfE8aWO3j?=
 =?us-ascii?Q?s/9OY/+1BG602iLNJhT/Y/GL66vbZRsrmjGjZmjivS9eLjvAlOMoxxVHP7jV?=
 =?us-ascii?Q?dQkxVZEUldGE0xEQLnz81tHkk3A2zFvT0o4tMlPdSb6qtoGxymTt2eRa1t0c?=
 =?us-ascii?Q?geQnpbv9bXvJEkSUsWTsT9gjZEkDOfMP1R02N7alKort4n5wW9Fv93PbPPGW?=
 =?us-ascii?Q?4xhAKw+H7vAGAFNRZ+cCVNBwbdr0ZHQz0kvU1j1x7XPOrl8rXC6RZfzbZv53?=
 =?us-ascii?Q?SW0LbiLWq/hDq+NcBg6EXaqS/HIaXw42wYL4CU3atnwcHQS5sCW2pJ5ZCKQ7?=
 =?us-ascii?Q?VZW0SwA5pgKBgtjkTlA6LaD626TX6qhrZk8Kbq5tRDSKDfAF+5/as8In6NDm?=
 =?us-ascii?Q?xMibEXIAywmHRDE6P+JrbG+i4EdMfgFmyUFM9hvWIxrgCBJ+YB8cEjhjAPQd?=
 =?us-ascii?Q?uFwZGSat0GRHtPkDECNB1GvPVkD+379QNx7AKJnXNInNrvQnLbIcOcZNouuc?=
 =?us-ascii?Q?ZR2lvBwVIXzfFQQUlujeIMCMuRT543R93KxGQFukTnb1GSYbQFc0hwu+XjTE?=
 =?us-ascii?Q?+SwXvFZvB6dsnbvvb6NIPdO2P7/qbxDDLELMvep0MSsumu2kqpYHSJV4b+IN?=
 =?us-ascii?Q?AI3qE1agGItoQ7IxrApSrAdpbW4cYDMeXtZlW5xsxZq2d6vvATq0ZD9TreKF?=
 =?us-ascii?Q?UyEZovyR2aM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB4099.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jpdWZdwPXsuNm4zx15JV2Pa49n522jXtC9xbhihFpMmaPg4vRZ7TS9+KlnD0?=
 =?us-ascii?Q?EfcRpLuawZY0paL3jjhqPJ8Uyw0EaC72Sc6Iwuq/sAJSbsR0U01he1fTfDVS?=
 =?us-ascii?Q?GKL1aU++snQj7Fp8k0wvlCxPX/Av0xEk0yewafDZmm6oj/7nXCHPdmpwikB6?=
 =?us-ascii?Q?VWOZXgppUF4CJC+WgkRFCUUumLrNVtr0IV9ofRh718KxLKTq5qF0nvJ7xBBo?=
 =?us-ascii?Q?909pFVL9dwZjd6t5owE1nkjwqFSC0HZBS3WumJ5NswLiZgBPQ/zr9VQKdUbg?=
 =?us-ascii?Q?jN/cTPTqzja3jQjZR+T2oxPFufRTMBnWlfJQhOKAYEtqrtozWy4gXZWPjvKX?=
 =?us-ascii?Q?AdYyJKaDoaDCxms646GU4y+vgz/olD6yzz0k3fPmR90MtLG5n2xoVjSPrseH?=
 =?us-ascii?Q?kX/KIS8n/6AsdRrM0fvbHXUX8K/uNvSw9LoOxz3sDkCx2RmIcmvVKLQERPar?=
 =?us-ascii?Q?/lP/d7n2FfkO7WtRlY63uduLJcyVxyY4NV78SPgxnTx5fiz5vksd15zY29rl?=
 =?us-ascii?Q?Edcx36YhR9vqr8pOmlXHdOj4A+QhoG01qRDefry8s1ujupV+Iznw7ro4P1Hp?=
 =?us-ascii?Q?npTnuzLW1fvoDbifl4LrXmdimo4xdXWpAoq2exS5v6tnQmsKHIaCJpZu5/QH?=
 =?us-ascii?Q?3w84gF5hZ8tWWAZeOGMN0yHtY+mVYbzytwrR+vWY08+h4OvcYd3KWSj0Yxnf?=
 =?us-ascii?Q?Uu04Ir7ij5WaNc3sswUzJAmBBL7ny4ZoM5jXsoMgoHlIzmpoYCejcSru4//s?=
 =?us-ascii?Q?1N4XL+Prp8JHTRxp/U5CbrAReJozutAs6Eh++vt0DU953x0q43K/Mk+Wh7Gy?=
 =?us-ascii?Q?NFF9RQ4czMC9cJ1qdYufjC7WagjcC5Lby779Dg/dcsFfb5Jry9OlHlIBCLeM?=
 =?us-ascii?Q?byjlgDDARTsI69CfLdr4o5abbgnDN4zllY5qwshxYEZYnun4xdkH7QouzTTd?=
 =?us-ascii?Q?0Rpc6D4iH9UkfkcuxzJXKngGjvdMXqDZCFlWCn312l0qPFQCixc9pVRvcH/B?=
 =?us-ascii?Q?7FWOjWrn9pv+JpWCAtv5bJCIMhHsPpgNMwcOa3JOkOc2A3q8G+kcKxs/vxOj?=
 =?us-ascii?Q?KyI41uNPVi4w/byhIsuvYn28zIRD3/fZt2VJufZ+0ccKw3Okpscy7Cwxfs7w?=
 =?us-ascii?Q?aLWy6/6PUsv06U47tFYEgzfKzbxY8Qnr8bp9+SRA4xxtkJDcpHba7u9hZKMz?=
 =?us-ascii?Q?FoJyYkFpIQQy1c152DdMuYDgSGH+3TMGH7qqyeub6pw1kb2W2zvU5qCQ4KoG?=
 =?us-ascii?Q?6QLMnYIt0HsP9kFYtu7zDXD0tTdc6Q2KYKEH/94a06/ZzGYyKHKglhYeOrUv?=
 =?us-ascii?Q?MGeKEXohhGQtBmRFpQYEoYxbzEjcDzETRGliqfylzu5QTj8f+LMRdAosdMz6?=
 =?us-ascii?Q?lszAu8JelAx/3cPxwaXAE/T6Abm+WZbzaBJzHMUGuIwqJmw0q+cqAwoRb28s?=
 =?us-ascii?Q?ik/yRKz0+W2xJqDt+CKMwAEdXTneSPPVYJjk09OX3onbD5f+fdn7lN26/jtP?=
 =?us-ascii?Q?N1A4qZTzEUlXU9wE+Po4LVRplw1++Kgfh4uvLOqke7zbxfyee1dStZMeL13c?=
 =?us-ascii?Q?rrnHcQwZBJ9NY+GwmGEHMgqQ5rxOwX+N1IOlbLtJTdbB2ZwcReZ8FXaCWTfx?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GyzaAjymz17NyHHSyfYXlgDQdzPoQCupzN785U5dkxDspEjOJvuic56N92aeHv5UvQjpvPNtNOf/b1sSpsQKue4ai4lajgFPm1tgbxBU6+22oxso+9NjEXi4fuM8QxZzj5iIgtShDe14U2OjkeVIlLt51d1NwMJK2MMKqdZ2a0YTrEOwTXdY4pRrVWjj2DWQjzaTobiy2C/mZrquFj9jEW8rZkI95pMRbmV+7zIhB/yOEvid7G6trVZSQR2NjusVaDyfFHVZ7M8S4tvYdXvdP659+aUdW0y4mI8Xv1zX9ibKsTC53447JMkmPEfPu0DpWjnC0eT6F7tqghwwSYpbXYGbiTX6yJTJ2FMf7MaIQ/Vwjb1z/vfI59yUWbU7a7WTI0KVsV2N9KPmFHC0hNMRnTlCPTJo6to9otQXmhgPcUc67hr/pJHfDNdQHCwbzIAdELwy9OWHNV396K30MaftsyUDezMrW/geGfLHkGSQr41SU+MaRc9CF3T9rDJaZcSCXeUUzAlF1NBUujVeZCSzRdyxP+sdSvyX6ikSD2+fbDZnm1DSPaNjX6vSH6VZU7Jj1DazHgmfXs3HXUC9AVFZxJQgTJ5AVPuVRoaOzG2D4Kc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65dee43f-5a59-4acf-2256-08dd55b24260
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB4099.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 15:37:06.3715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JYcjV+53yDB0KXWnZuPtn/d2WJcQIT/X1JW04OVe8p6MYxJskPhI/ymcttlAhIkO3VUweTVtZUdk0pXawRseFmzvEkdWEq+SMl7y9AYchAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4861
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250102
X-Proofpoint-ORIG-GUID: oEpLraxgLgrBvYZbrAit9YfRr1BapbFa
X-Proofpoint-GUID: oEpLraxgLgrBvYZbrAit9YfRr1BapbFa

On Tue, Feb 25, 2025 at 10:22:56AM -0500, Liam R. Howlett wrote:
> * jeffxu@chromium.org <jeffxu@chromium.org> [250224 17:52]:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Provide infrastructure to mseal system mappings. Establish
> > two kernel configs (CONFIG_MSEAL_SYSTEM_MAPPINGS,
> > ARCH_HAS_MSEAL_SYSTEM_MAPPINGS) and VM_SEALED_SYSMAP
> > macro for future patches.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  include/linux/mm.h | 10 ++++++++++
> >  init/Kconfig       | 18 ++++++++++++++++++
> >  security/Kconfig   | 18 ++++++++++++++++++
> >  3 files changed, 46 insertions(+)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 7b1068ddcbb7..8b800941678d 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4155,4 +4155,14 @@ int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *st
> >  int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
> >  int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
> >
> > +
> > +/*
> > + * mseal of userspace process's system mappings.
> > + */
> > +#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> > +#define VM_SEALED_SYSMAP	VM_SEALED
> > +#else
> > +#define VM_SEALED_SYSMAP	VM_NONE
> > +#endif
> > +
> >  #endif /* _LINUX_MM_H */
> > diff --git a/init/Kconfig b/init/Kconfig
> > index d0d021b3fa3b..07435e33f965 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1882,6 +1882,24 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
> >  config ARCH_HAS_MEMBARRIER_SYNC_CORE
> >  	bool
> >
> > +config ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
>
> I think we said ARCH_SUPPORTS_ for software features in v5 of the series
> [1].  Can we also make this change please?

Jeff - I'm going to risk sounding like a typical, grumpy, kernel maintainer
here (sorry! :P) but please, please do ensure that you address all prior
feedback.

It may be worth even, when things settle down here, putting together a list
of things you intend to address in the next round and double-check you've
covered everything off.

Because obviously when this happens once it's probably an oversight, but it
seems you've failed to address at least 4 separate things requested of you
here. It's obivously s going to make this a faaar more drawn out process
for al linvolved.

Again, to be clear, as to allay LWN articles about 'Stoakes urging caution'
or what not and related drama - my intent in saying this is purely that _I
want this series to land_. So I say it merely to help expedite this! :)

Cheers, Lorenzo

>
> ...
>
> Thanks,
> Liam
>
> [1]. https://lore.kernel.org/all/202502131142.F5EE115C3A@keescook/
