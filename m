Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DC128A2D5;
	Thu, 13 Feb 2025 18:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739471778; cv=fail; b=NvuLWJ3gLpFYFsfGOU3PP6dy8ZSlPG57RoJnQaBIo+3FOHGzJgVP3cN0XeWj8vXqWRG5/4m0oc0qzvBvUdvy2DMJ4bUcHuL6jgZpP/v8PrTJbr+M6x4hZhF9Zyk5ytCH2rSzA/lMsMpXG7gspplXzbds+s/4cHuuPsLPIamt9pU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739471778; c=relaxed/simple;
	bh=76xPj4QQnseY/PuCQo5dSbxo2hUs8dt9gOa7a27F8k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=em5+yEtK+vQzxzWmOQrDaEvDoVDbbOtSDnx8YvO0atygm/ORrHZ+hI/IdFoaKtJoQl//qjgz8zEHzu+iNuQPaVtYb1XPBJqu9N6eHUW8Hrmh6d5mgp0/gtMTu+ln34GubplJ3iRVdZdPxTU03DXCyBxne++e62AdwkpdfkprWJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GuVsCVXb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CstIh+wT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GuVsCVXb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CstIh+wT"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DGfgXf015284;
	Thu, 13 Feb 2025 18:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=GDZnqX6yyLm7r5BrwV
	D6QPzJbLOmyv+CyRifmPUpY+c=; b=GuVsCVXbDF3Ny/DKD2Yy8dYf/XOYR19+Lh
	M5hc5RL/nYemuWWsaM0BLTF3DFwmGpytmczuH8i20B9OKCHEDiIQEUmQmp436e74
	TA1g610OL0A1llEnAFAJakPJsY3yi3MMLwAIzxNB1vnD3mT+EN17oQzFAJAF/N++
	CkpTpvkk1B9pHh0JJyRcMZlIZixwuRdXIp0p6k+u8RYkZcKQfPpJwPFjncE1pwbF
	FV+RZfkiWxn1AC5ooWhfi56S3AmEd9AzF4xWWpCpXHWTXVy5fZRFKTo3k3N/sCBb
	5CkVEzbFKUT0FXmwZ5omexk9UOsgwZoD2DAtrWlKXXU3kXwRCzzQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0t4a5rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 18:35:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DHHV0M012376;
	Thu, 13 Feb 2025 18:35:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqc3ua4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 18:35:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUvdxyoQYGxZn6PZqZ+b0qrILFTwTyGSkvmZsacBG2xWXZ6g9JnSKZvxGl1gDgjdQ0KGZUhYDcle412ut6F4XwKbhWDQ6bXX8emf8gopa6B20eseU3t/nsfwvKtWAVY50txl+/yReSk4mzg7MkXCx/mn8LBGptCp8oNXWpxgv1QpRuB6SFehKvh5ryCLtf+SRycnRvE2keplJ+aYEcP/4FpfJ88usuLAvnbtYnr5mVvLq9s6WWmKK+kMbmroxuLFKZhBcGGG0rtTnQjNS/36z0y/Vr48m6YPO3TJNIBojQdW+w7r+EshaN+lkeJUn8up7LC0zbpw5YKEf4rXieY4xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDZnqX6yyLm7r5BrwVD6QPzJbLOmyv+CyRifmPUpY+c=;
 b=ATq4g4RWSWMYBqRntqbF0mxtWryH/yoVIgNqapTtVWVkPA+S6pZU6gfPl/+mQFHCDDVYTmxI7WTkAbbe5j1QyCPz+h9B2vp+7uk4mV3Smhp2RoCuuJSceiq+CorVTE3DpUJjn7LxsuTi3pcFz+jM99jTWU+Cc1WrcQV126qpMUsHvnVguZ7KXBCT0ahykp9cWuVBWANagD3UF0HbDzBO4bopCZ9KBuJMnLoRuBwyBNXyVpQ0bhSsBCMkZR1fk3SEj9LRefV2boJq3NWq8i7MBaCSHAWB5hWKG2v730f9p7Ldnd5qayZcGtBEbp1GIqZ4FanM20RC1kfu/PCF8MM4eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDZnqX6yyLm7r5BrwVD6QPzJbLOmyv+CyRifmPUpY+c=;
 b=CstIh+wTqiVSiE9NPSiciY3GKTbAYQj5CCntVbEGoe/Vdzyau1OQqYYfRWtYLY4pdNHt3wxX1ZhKKuWjipWjbgPPu8Vw98Dkno9ZTP6w0p4AIZQGlmqiFw1XaiP0VemFeS9acHEimQtn+NmJtYCVZ8y4tWEv7/OIAeUgJORv0y4=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH3PR10MB6740.namprd10.prod.outlook.com (2603:10b6:610:144::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 18:35:28 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 18:35:28 +0000
Date: Thu, 13 Feb 2025 13:35:21 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Kees Cook <kees@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, jeffxu@chromium.org,
        akpm@linux-foundation.org, jannh@google.com,
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
Subject: Re: [RFC PATCH v5 0/7] mseal system mappings
Message-ID: <fyqlqgtbscwh4fiwmjtkb74k4ratlelwh2vzfyaeatbc3tcicb@5uvfy4hq5xde>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Kees Cook <kees@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	jeffxu@chromium.org, akpm@linux-foundation.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	avagin@gmail.com, benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, 
	hch@lst.de, ojeda@kernel.org, thomas.weissschuh@linutronix.de, 
	adobriyan@gmail.com, johannes@sipsolutions.net, pedro.falcato@gmail.com, 
	hca@linux.ibm.com, willy@infradead.org, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, 
	enh@google.com, rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
References: <20250212032155.1276806-1-jeffxu@google.com>
 <b114f48a-a485-4ebd-9278-6c62a1f33d9c@lucifer.local>
 <202502121401.B6EF2D4517@keescook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202502121401.B6EF2D4517@keescook>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::11) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH3PR10MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d02313-ecda-418b-bf05-08dd4c5d2ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RMb1hRJO6OGStLIH5/3yL+8fDAez2xtw8BN3+T+N8GB9NYTAtIC2WHCm6ohS?=
 =?us-ascii?Q?N+cGa4zNmbAH+YlAU1uU3zuIVO3kHOEXittaW6UEnsZJ0TJzJykLqsIPy0yO?=
 =?us-ascii?Q?7ojZSAY/hPj7iVN6q096490m5YLxfQAB9LI8jAALbq4de1J1RIGS6UE9pAm/?=
 =?us-ascii?Q?WPd9IfbiX5wef2K4kKXvob2Jz9NcyY8aTc3hF0H+Ktva8I+QVKNZ0ew9EL8h?=
 =?us-ascii?Q?qS0E6PGPE+4oqnITUU+Yps4ZmvzgPNFVXUXQ1v1STtvVVcKekMHM+GQ58Mg2?=
 =?us-ascii?Q?brC+mrl9MRKL3UPuBC77tSzEVyegyRxDRshKlMdLiZGt2zX/k3MX/sbihfy9?=
 =?us-ascii?Q?UGL1lNJefQnT1f6RZejm+lX7seHce4Patdb6T2WlDRG2N1JVDhlo0XnRCggW?=
 =?us-ascii?Q?G6d5pkkV3q6p+bsOKCCRFNXYYW0ngJm7nGyNuvOS9ejoKnQVjKT/Y8sktLoh?=
 =?us-ascii?Q?vq99jmW+R/LS22lePuesgDFht/LnX3vINZm0duH8KGG+KYZg1xWRYnLv8wrI?=
 =?us-ascii?Q?mAVujNoGfH0iYretKtI57/GtBo8yl/8ODwjf09epJLqp8vnbDwg2ZQAaX0Yy?=
 =?us-ascii?Q?wRTVRmJC8v3w960fVjMeIxZK43z6R+zg/TB6fnEDecxMRZq35OwrM8lSP9wL?=
 =?us-ascii?Q?atXCfWT8cVIhtU83cgnyX6t5ig5w7EthiQCuE6OvBSkd2yl3jtbiSXY/F7YM?=
 =?us-ascii?Q?Q7E1O70LeEz1Pc/92YOCbhJEoo0FUVtwS7Y3oZv9uNqUl8ltbUhxu/ni4Z1h?=
 =?us-ascii?Q?5XOPT1vAkzEfB0ZtUXblnyYsfyuwkiQc2Gza3/9RScV1VO+MXGaiwzNn7Teb?=
 =?us-ascii?Q?bSS8Dku15MAALzo0u5fyCccTYW8Zs+MAOI/7QkvrH0kCBiPkJcAxM9z8zhOR?=
 =?us-ascii?Q?YTMn++TTzMQb1Oh5Up7LfhX3ugXDgEpiXV+k24UGPb96Gm9CC4DDnBVAG5mL?=
 =?us-ascii?Q?txtGxzFCjU+qbCC3tRDW8bC78W/lsWVHphW54zZSlaK5yKTC1wWTfFr8MO9Y?=
 =?us-ascii?Q?AXPf0h91Mnu1VImGkVobgilVzRqEWsz37lCzTjwVGO5N33G9CYYt+Q6xFs8U?=
 =?us-ascii?Q?9eoiJU4oFWrqCG12u0cDU2ARRiZvA3h+0W+onhNGSOTvWTXwyEf+5hRVVYZM?=
 =?us-ascii?Q?M4eoxC2zFRKO4T6M3XvDmtdUPEx+oQC13NSgsv8G8qDtKKxMCUhmhMJT8NMI?=
 =?us-ascii?Q?3dyshphdDvXjIm1HwrRDJiFEKWCBf+C+Mo1yV5esvgh6lWuR73qne/ECsHVI?=
 =?us-ascii?Q?vpK6aQCvTwBc/vzzBJoAG2nIKpKUOq9DzmJJthUROIjNzRX7F9Vk4jvhfhUX?=
 =?us-ascii?Q?bH3wFwMv2u+vRjEKFupQPF20HhMLZ4uUv552UaVmzaJyaYF3cGU2N/MyhEmj?=
 =?us-ascii?Q?aY+DbrG7V3IpIee6MKUTBJf9Ye1B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R2h4HmbMVXNCQu82M3hCN3ScNyhyIgTLEZzTax5k989j/I4WtWuOdp+CF0No?=
 =?us-ascii?Q?3l03MxLgYLgLW2N9xx/hgERffO3Ge9tjC3w9tnAwBD4DQdew0Ngf8eKO2pTx?=
 =?us-ascii?Q?MXzjkBHXZLue0dMa1PcHE39qh4aJYSUBb+R7pw1SwFYbZ8RvyMkHAAuUJ+Y/?=
 =?us-ascii?Q?lqwEhNsW8X1CsFIMB8DPmVTkzVAD6wEx3b1NJZM2NeDSOq9J+YDQT9zPvbq5?=
 =?us-ascii?Q?HOim8WTKIKg1rawnL1/FqpnJjOJjWcfxvLtd/O0DSJJLAmSQ5LU5wjMu0CfO?=
 =?us-ascii?Q?7llYwNu8tdLtana9nzXrjMLne1Ea10tQoJ7odTO4tT1eiQVtxX9KguyhzXL2?=
 =?us-ascii?Q?nflQnMgW2oeL/5La+kD5fgmi8tSRSm/0I1R2DleUg5fwKNYeA/4YJxAjenXj?=
 =?us-ascii?Q?z4CLSanGFWmKlelG9C2FLfux+HkbpQa+hrWLG4QDrjZVU8+iU1wq00YWPmGw?=
 =?us-ascii?Q?GIWZcUn7suTviMAuNIge222RFIWtPLqVSfatBrhTFNeSGsh57AYVop8wV8a8?=
 =?us-ascii?Q?e51/8+97Xz5/rVi1I9kP0gOb6vVFYFEhLsL5PWjlbkLjxBpTZvagLWbxht4O?=
 =?us-ascii?Q?AgUU33z1NJeGYl0J/ir08JPAoYRzs6uWFpWMFFDOhFC8cGTxESLLiSJ1AGix?=
 =?us-ascii?Q?WX6bslQX2RAgY9H2Vm3RhVYHhGwUEzPxWyI701KSogSgG60TuIgOLkHl2LpN?=
 =?us-ascii?Q?8uOC/kgEAx/AalWDl8tFVSVYMecYVk4vk0F8PSy3Eqx2FlSutzUxGSQhCxfP?=
 =?us-ascii?Q?D1rOCZbEmrpcAhZxdAY+QToNFEA8HbpPXkwgzoLh5QE4AA4/gR46ZdeGWczh?=
 =?us-ascii?Q?a3d26qQgzGFR/RmLhjvLg9igixdPcDFohcsrM4zmH+Ofia7VU7oF2E83yeVv?=
 =?us-ascii?Q?chu4xfUkVSk8VLXVlZ38io0/EwU9K3Rv6m48GkUB1MemHABJCaRY8lmOSR42?=
 =?us-ascii?Q?ePo7Ye6HeyzikDYh9MiB0ETYFe9WPO4VHqtVC8VYCPuCZ+KvZi7dkLOTNBHq?=
 =?us-ascii?Q?X9HtPGnUXoQamNs0xheI9JHPbvj0VXx+wZiRi6UsqNRNpdxLnO0rKMYXXLH5?=
 =?us-ascii?Q?9v+qKllDG+UPQ14Z/HCorNyxoHTh/1kXMGYgx/x/wawOe4i2or23tBi7uY+n?=
 =?us-ascii?Q?3FlMjirNm9qWPfWn4WHkCg0/U7QC43Tx0umNZVzVdh4Ir3ZX2MvYTvjpwh/v?=
 =?us-ascii?Q?KsodgWrcDueMW2WdxsJ3NaJQMOaRiFzKHqq35VRSVUotYtyggDsHftVApt4x?=
 =?us-ascii?Q?nLfKvcJQW+KZ95PMH27OMtMBv67uO78mQtVjcVY82stwjgrgrMf9TzAeIYV+?=
 =?us-ascii?Q?o6rno6fkThmmqHVSTETrd2KotKhyJrDfs5R2gUOJPg+V0QwVxh4j3nUj2KXr?=
 =?us-ascii?Q?KPQrK9/YeZot+YPOIuEx1dqGYd6zrUerBTet2jnkvrmvWIeGO0M2/scWTklp?=
 =?us-ascii?Q?Wkb0PafTLMv0pp2fLwZE2/KTzrs2dy0SqrScoaIDEQeG411X2gzhNoz0gxqe?=
 =?us-ascii?Q?fJE2s53ilum/VxmcWMfmJ6jB+Adh8b7V8f5JEz3apXCWv9qg/mt5YDlWFa3Q?=
 =?us-ascii?Q?ZuZaFfSOtKtLmWfJJna7R4YIriF9yRsdmosi8eJ6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XZ4kROhZP36UfvNuYhu4lp36X3Jkp0VUh9MwRL3u76/yHBw/eV4KIjsXs7eRZs/OtNb4Zazv0SBY3vSzqwZttzdfVYqkcsNdtSNPb9gOkbjlemLXq4uCjh04hUUDPALrnEgp9JsuBt9V9iaXzhmvlIW0KQgD5yLECIsGdk7Z/ye/jTp/BMDthragDaFYPa3PPqq5Vqlzo9jzYKqRLovXYtjnCKMjQTDPZ63wl/eu7ucLr6RZXPbPrG7K8vshB3M39+ym3LgwVH6x6kxWXov+xP+mWj/vBdI7+0/yg2y7XjZj3KsgV70DXa5CIu/JMhxAsghBH7PtyYsE3qSHO+VIudGNwXJuN7Rd/z5cNfJ4a6zeeYF/n3wPgf6uJ5yJPG63vYhkOEb7INKEBJJR5AEe799p516U+9pazv2yje0sRp3oivtwKzKNboA1uhQ8Q/MkczP8AzCjG4Wkp5/VETbPC0yLSD9Ft5UIHyJWEoYPidpIWUEPPdrpOirjzMpjqXaHtoHYzSplxW1G0MAwkD64eSGL/5vJzlz/lwfkVpBtq6/Ia4d390wl0DxzS6mY21LscHsY7EZhI1QEUV9gPYVhklpxVjyiI1CbscqUGtduKHI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d02313-ecda-418b-bf05-08dd4c5d2ff0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:35:27.9147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBi13ucRR5Z0hPtzBQDATL0NvCpk0CZsfzVC3imUKEKzPOvTQzDP828cHP2uOvoHNH5s1LPZpjq+96+OWc2m5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6740
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=893 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130131
X-Proofpoint-ORIG-GUID: iS0-tHp-PNXdtefXCQUvBY_-bdAjsTte
X-Proofpoint-GUID: iS0-tHp-PNXdtefXCQUvBY_-bdAjsTte

* Kees Cook <kees@kernel.org> [250212 17:05]:
> On Wed, Feb 12, 2025 at 11:24:35AM +0000, Lorenzo Stoakes wrote:
> > On Wed, Feb 12, 2025 at 03:21:48AM +0000, jeffxu@chromium.org wrote:
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > The commit message in the first patch contains the full description of
> > > this series.
> > 
> > Sorry to nit, but it'd be useful to reproduce in the cover letter too! But
> > this obviously isn't urgent, just be nice when we un-RFC.
> 
> I advised Jeff against this because I've found it can sometimes cause
> "thread splitting" in that some people reply to the cover letter, and
> some people reply to the first patch, etc. I've tended to try to keep
> cover letters very general, with the bulk of the prose in the first
> patch.

Interesting idea, but I think thread splitting is less of a concern than
diluting the meaning of a patch by including a lengthy change log with a
fraction of the text being about the code that follows.

I think this is the reason for a cover letter in the first place; not
just version control.  After all, we could tack the version information
into the first patch too and avoid it being in the final commit message.

Thanks,
Liam

