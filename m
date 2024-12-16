Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D971E87B;
	Mon, 16 Dec 2024 18:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734375466; cv=fail; b=gMmab+6kz/PR57Bf7/cSedqFDj50fj8ISZjGpJGpuC69iBq61/QpLkOsPiXWTKw4oJpV59TtTw3wyr2mDT6Y+ux5dRXrmu0/eUT8kySht8gVLqVmC7MFZuAVUdHVTJ/tQJkLh5LQPWz0PVo+l4d11g60lK8wubudvt1PMiqtUFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734375466; c=relaxed/simple;
	bh=jKCvz/AvOPeIArWCj2xD+oOPj/Dec+jcDkPK2gh/MIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dLYVN18Ivi15DDjr1wuK+T1+U+s296IJU9X7/MudIq33Y/kAZtyqmCKAd1gL8YaXlAqus5nRiBVBK1JN235/gEeKBFriUA+UBlJlL8FouyYcQxNZg02g+CaCoBL8y1nuwTPVhBJF0HudilMNQrh9njAVnVYHrkUChPp0lGONRmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KeWe1BF2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BDPXkvwq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KeWe1BF2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BDPXkvwq"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGIttlW010894;
	Mon, 16 Dec 2024 18:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=p9aQ3JYFDToT1tBMEv
	ZcuaDMy5yZZemBTCSQGkMu0zg=; b=KeWe1BF2y/tBnpaa23Jx3G7dN/BIcAV9iO
	jJw/vuqjrE4haiRJ0jreY82kOmOT3ib4Llkb3emcyYDUVL+2lMEFNwgyGt7jzbtT
	pN2HruKrRilz2DjsHM7UL2PtJ0sMwiH9HokRaYA+Zh6ykQHN9j3IbFojOeeM3pjh
	vHs5iOiYtF5it5njEz8ufVzRcC6L7jxlBgPAyvbkCnazcDMYRvc1TaaQ7gLsO77j
	5Ooxu0vH8NeJ1VjZ51MQ4DdstzRf9HSGwX0q3xC6tv7ZJAUiKnmyC7CTkEGRt9fl
	bzFDzSn8Ny79cIrbj/4M84VmtwE0nKoE0k4MFhPMeRge3FiFw7yQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0t2c3e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 18:56:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGIXBbV018355;
	Mon, 16 Dec 2024 18:56:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f7pe50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 18:56:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARIBpJFXo25P8WvEtg3T5A6+/yBhkPqRHacml+6miZuqSDGKj9eMM8kZl5i/mzmPJdWl+9L9Tn+JEaxBmz4SB817XMzofj+EtFdJU5dY4RYY4AE30A5hlB5aISTG5sAXZYSJVL/c951xppefdQD6raOSscGBcsLCD3rHaexaWvp8vxDcVXUEdX/FcDuPSe7wXgv9ju2MZi5bRcslmhG4OzSGISDkcNSGDvhF4aZrHK5fhb5dJVH14gNCTzfn0GOJI8pMasosWLeZb88ABPojFPBCCJyMF6WEdXl697fS+sqMA4tygenJYuMVt5fcvGRMYh9mZmG9kkcCMd5yDzRzuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9aQ3JYFDToT1tBMEvZcuaDMy5yZZemBTCSQGkMu0zg=;
 b=nGVeFaxyjleRp5MNYrLMO6+0/bziDFes2vBrLIEqpchx8PwtIy+RzoC61Lyz7mWbXRKnygL+jYA4RGFLNVT0hQ6x9ncRG/cZ7kterJGRz1mycc6D9s5jmV8/5Z9Jvjq+wbshNB4IF5nkQZ7yb8qW5smT/5PXYblUVk6OPic2AQOrBdPDBKSx3Gqu14C3/2ptcJwxeFxkBbVYjTKaqrnYwDvYabwuz6hX+HcQYc9X5nyVotWJP9H4Kv3QFxPUzXnQ7Jgq1jr7F3Im/Aj9035hH7IEMYKmIt6Dg6s2PjAegF5k1h6XamGzOv30BSU7iR7gtW/44oh6tFyzwZedVtjMIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9aQ3JYFDToT1tBMEvZcuaDMy5yZZemBTCSQGkMu0zg=;
 b=BDPXkvwqh2NKlsH/BA3KBpMUMKvxuZJrse9GIIiGMjRjW7FBxbXZGERI828HDDMV3b9C0KoJr1aEKP3xXPcUubueM+3iiKJEpM1XGM/7lVPNw1dHTukIHSgYHlB2QHQlq5qfS+P7OAv+Eq2CM+Z9PWLUgLWJnElkrIFlsuRT9s4=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SA2PR10MB4523.namprd10.prod.outlook.com (2603:10b6:806:113::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 18:56:48 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 18:56:48 +0000
Date: Mon, 16 Dec 2024 13:56:42 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Andrei Vagin <avagin@gmail.com>, akpm@linux-foundation.org,
        keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org,
        adhemerval.zanella@linaro.org, oleg@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
        ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de,
        mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com,
        deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, hch@lst.de,
        peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com,
        gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
        ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com,
        peterz@infradead.org, ardb@google.com, enh@google.com,
        rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Mike Rapoport <mike.rapoport@gmail.com>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Andrei Vagin <avagin@google.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
Message-ID: <qsjxqi64jolf3ywbz2sdtsrjehvvthxjvrsjvonvjmc7vrvlvp@nbn2ehiedagu>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jeff Xu <jeffxu@chromium.org>, Andrei Vagin <avagin@gmail.com>, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, 
	ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, hch@lst.de, peterx@redhat.com, 
	hca@linux.ibm.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 
	42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, enh@google.com, 
	rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	Dmitry Safonov <0x7f454c46@gmail.com>, Mike Rapoport <mike.rapoport@gmail.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, Andrei Vagin <avagin@google.com>
References: <20241125202021.3684919-1-jeffxu@google.com>
 <20241125202021.3684919-2-jeffxu@google.com>
 <CANaxB-wvHERPBu+17b5GP3pVv7pC8J0dkK9MUG1tSir4PQx=ZQ@mail.gmail.com>
 <CABi2SkXgZfTvyPX_rcb8KTKyeHxpZrL9_2Wr+vJ1q3K3_1rwoQ@mail.gmail.com>
 <CANaxB-z57KoCNawGEkmpoiHV_iCaYr8YiOc2zQiTHM4fso0ABQ@mail.gmail.com>
 <CABi2SkXYjq0ACYkFf3e35DoOJP6d3TEpLEU_RCTmNLHQ_YJq6g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABi2SkXYjq0ACYkFf3e35DoOJP6d3TEpLEU_RCTmNLHQ_YJq6g@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0403.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::17) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SA2PR10MB4523:EE_
X-MS-Office365-Filtering-Correlation-Id: ea6c7bc4-fb9d-432a-24b8-08dd1e0364e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ouD8Db6GJg5eCFghGWJi0HrVUdRdIvk2XLnJD/fDCiC3SqZ2jGi9pJj4DzmM?=
 =?us-ascii?Q?YcQgEprYOLS4MqRGzcWaiDqvHA4hjEcuylltWtopupgh5HTOnVxhgPhsmlOe?=
 =?us-ascii?Q?OJdaqFR25v3ZtvThsUeMpYwfS9JsG4OXd5jK9/kD16b4VWQHgc11oQkSm89c?=
 =?us-ascii?Q?OHeVSDYoJOgYdspdSy2PvAE0sSolys/yyHKNhCygRYuEt5YlRS4+90wH3PLY?=
 =?us-ascii?Q?8NvfbJCCVY3LlgeL5dKcbGRd8068pnwhz6hzbZtRyvg44f+2NPrXhHnchhJR?=
 =?us-ascii?Q?FwvTWUkLnXNu57qEPU16kIQIvhj4fi2CK47+5o6+wuUMvXCGEfzJaOZMGSl8?=
 =?us-ascii?Q?YI0R3LMepC2dV3RIUwiUEfdV7GI+na/6xaMFqJtsvKs6xzfiZ/5oyMlBxp0Y?=
 =?us-ascii?Q?TB1vx9uUVibxWuVEILn/U4SF5Izue4I46ii9mKCc/+Fzpfq24vahxYkXcVyx?=
 =?us-ascii?Q?G8AycbSluixhrzH+pAeGKkQ+N144LNG/JbD+s6zyoSiqgZZdmSeniLzndi3J?=
 =?us-ascii?Q?LKVdH2kD5hTVtF82wWCKGaOYUCciZ3o/6OaddkdCUhrEW18MHkxHmFX4Pp3C?=
 =?us-ascii?Q?H/i6oNkO4pD7LCsai0czolBOptEg8arhbvs8qUktOVkeAvyMrTlHDsbFIlHi?=
 =?us-ascii?Q?4a7TCcGiNSuG9QKHpzzSfvmv820E8O9qoWmhZ0xbJGiU3MslkjBF4KFhvCAp?=
 =?us-ascii?Q?aLYWp2La/o6LaudE9TGGZUTXFESbwywtoQEcS0NWMt/rOKsI/4Jdw8JhabE/?=
 =?us-ascii?Q?PtKapVp6APBMUxZBbJHJPmY/0RHJxHoJWz0ON28oA8as9WOwwdNGXjG+faYk?=
 =?us-ascii?Q?7iYUlpNVD2adNGVJr82FpdEiHm/cblWXwOELGwBfMGMa1XOC6IrZblojq5tR?=
 =?us-ascii?Q?HfbMIN1TEoGQlWZXMI/Dtu7NqBxu5MovvIIt4gLAXCgcZl0iWYfA7CkvSvBw?=
 =?us-ascii?Q?8rbSgW+OOT483tpIhzXHuoIlNsqmhdvMfxCRn4qjkYhkDXMh9eMFwITxotyr?=
 =?us-ascii?Q?6ShOWJr5zXiZO7DOZBAsLFAaETQrHuvGxtgxhqaJt9o74CcofrHk9NtrtUye?=
 =?us-ascii?Q?gWh7WJLdakYdEb5ZyBXiFm5BV3hcSUpzgiFxYl3GCHASo+X8LvPot8QbBoeA?=
 =?us-ascii?Q?J7WObOivq72+A93k3EZcNBsvjrnQhrR2at0OyDszl4ukqIkgoCRO1aO7OqDl?=
 =?us-ascii?Q?6J+ZRUh2U0t9EzjIEafPLbCHweuI1p7zz0gkVn4nSlj6Wl3sxUPuw1hZT/nO?=
 =?us-ascii?Q?eOJpjCngXYQGfiJHuTZWiM0Q98044Ocd41sogmtMGWQnVP4RkTY3qb0rBfiK?=
 =?us-ascii?Q?ZvpuKUUXMCLrfGeKClYpnFjVMaFWA7B87HtR4PS+aMWHqOt3jiX7iozC8OZI?=
 =?us-ascii?Q?qZqDswrYaVdqAXWg/YwUF7eAC912?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qxsEzzYC6kP1hFPqu6APw5OlRWmpgto0pPoh/JHjCFijNNpzt+V66CxNHF9Q?=
 =?us-ascii?Q?TI1dXtapG4o4Q5fHygSU1aF37909hGvULb3mGz/jtq6/sjq+ziuKRV8g8GQc?=
 =?us-ascii?Q?nDa/1Umcejbik+at7roO12kVYMG2gRI6FEuLSKu6YJ+CZj7V+vZXVhmoRU1P?=
 =?us-ascii?Q?H+9JoXm8h4qAjh65D77k9iLRH9oega32SZXNUxm22esyazHkb5gWiok6v/ms?=
 =?us-ascii?Q?qLf2tZRDpKuiR4v5QbeELFyalSq8irr/W+TPvATUFAKpXwo66RsiOI1lUhJx?=
 =?us-ascii?Q?Q4aItoZ+UeuEZwBqqdTJXtRoBMpCCPOSPDr04xwCBLAfvprwEIMlFvE2ERTj?=
 =?us-ascii?Q?XzZ2ue+OvsQoElgE208arb/2c+Uj4geWbGqA4Y97G9GU5lXGsnrmC7u3W5gR?=
 =?us-ascii?Q?y6+lK/dGRK7Z9+rArEdtZn3xOD3bfFJ1+ydPzZsTo+mtJjJaSugP4OKAoFVH?=
 =?us-ascii?Q?H9ISnyqUFe281rUaHRy+5Cxqim/HUEvaZ68srFFzZomPYFTTRviIxgl32Lo2?=
 =?us-ascii?Q?xDHFOGytp+WZMrzyDQ4sLSLzIgBFu7EqNhLm/t3Ss3pjx8CZx2mokQ0aoV9w?=
 =?us-ascii?Q?+LODd3jvnR5dgbPfH6t5fG5dzZaNv6rh90treQao7+aTtr9UynrlE7oLqv3c?=
 =?us-ascii?Q?VZshjruDhXBm4WgoZlAlzT30kBLRQ8RyoWNPz1lzEn5VBnRqqZVkPSp+gazK?=
 =?us-ascii?Q?gHOrA++QZpZlKZ2Km48nXEhPsXRsKRLd01hydY9FBpD9Md5GZXCqTFEiCc7n?=
 =?us-ascii?Q?x9kYaghfhUNejEdloQyIyhQUhpO+7tq9LzIWVvdzw00D59s6HI2xU8cHZ7ez?=
 =?us-ascii?Q?Gia+hlwJyjQUCvBlkirUhdzPwHDpRtyvr+0Zl9q66blPJdnaAergLvyUs5W5?=
 =?us-ascii?Q?9Ru8O+IZJfCJqHMBHYp3sUNH7DcHMSVkmF5SE3J1KjrvbJFMjEtjeVW6YSFC?=
 =?us-ascii?Q?C+1CXX6wSTcNLityaRofrZFT+2S718aL02Dzw1Az6lIOjjROZhJj4ZfB1cDH?=
 =?us-ascii?Q?mx9y8HqF+i5/tyuE7qaGIVOGe4ZwB+vgdOi3xA3Nj+fdRAadg88/iidrhLnb?=
 =?us-ascii?Q?mo4futDIPMLUMLN0GuSo2R5ZTCmalJNLSgFXPidDfXzecwQZKw4ajA5TVj+A?=
 =?us-ascii?Q?WK+vqSDpLr1J/gHoigiTkqIzp6ChkBou56BB+ZjeK/DfUwBNHGFeN7WgDxUK?=
 =?us-ascii?Q?3uupDHJYoJxl4QRvjwenueo444+jAInx0DA1JutLETR3CVPl0EvwULcu17/S?=
 =?us-ascii?Q?zq/UnaYo6zoTIvPWQtSjp1eCbPc0MSoxJv5I5eS5lQMVO8iLnyKgVJzj5XYy?=
 =?us-ascii?Q?ZALZtXF5NHRJsaOLxZxVktDIRa2T0202Dhx+zInxUqWy3ZPy6E/SdrOzgJbn?=
 =?us-ascii?Q?c0mAD/VGFth88qhl0UhXg3zyjzaAQKkXCSq2XKBjmlgzmXpqTr28QBX5JcHX?=
 =?us-ascii?Q?UzqXjFvmH9OR9fQ1hevwDk+Fk4sDLgpl86DWBGiPfcIsLDnqHzxcqCU4+DVw?=
 =?us-ascii?Q?bSyzSld+JYKuzn0loR6sbaZ3nE4O5+OtzRHNABuS+lahibSWnjxG60OoxlT2?=
 =?us-ascii?Q?HUOVawcFDTxDs/YNui8Ge8+mJp43tARX0BcMyfAn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wAZoweb6k3qQBXoEcNdgn2syF9vcvDUu1EK2EsYRfL2ZW5hcWKsBBhMId8qKJQvUCnmjGDL1cSUX+vPyqDLxdLnQM7/7ltwapBH4wOd+WILYML7gJjF/ur461KGNMFJjU8qWZWnVKbinOgzk0M4bpDMaezXXk4NAoxOsOFvid6kLwt/f5m9VxDVo6PZNu/c8Po7e4+th7OWDOP/suVdMDeEQeNK3hAkrgHmCP+InlHVIKlaU+ybi0+8erS579TmmDsh/XUz3hJrJhpXAgUm5KiSoorbGcvgFjjBv1f1taxoP1WaPBXrzp3yd2WNLgpfqe3LfjP01qORE++ts7oNukwK3tJeAwNaHTgvxcRiIBna3Wq2odphpk4GD7Ae/L51gR/A4RAL46sre3vtXDSHJnu151dpZs0rsC6nsoomIlrjPF/c8N9dhFu6d+YUHXKlpWXFnzbS1QIzy7hyBLD4PTLBwZN720os01e0wQCc6N4LH+dClDKe4ezaj6Ux0MPXD+VCsB3En8X2nnL+u7WpWgbKXWVJ/BUPf7GIt+AE4VJGVlSJ/5s0ycQqCVVK5HMSypiOZnsScu/3pvjYUlZ+6CYpcIPlloOYi+LI2vUaDo2E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6c7bc4-fb9d-432a-24b8-08dd1e0364e0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 18:56:48.4248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZyAkxwOszKwo3rA52CoEPld7VISd7LxbFK3APAB+YcdlBRtG7YcbvqabOtjQFT8MnkdAw77+QAfU4gFMF45Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4523
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_08,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=731
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412160157
X-Proofpoint-ORIG-GUID: U1jYkoNgPvfFymlFx1gPJHdBUBP8xO_d
X-Proofpoint-GUID: U1jYkoNgPvfFymlFx1gPJHdBUBP8xO_d

* Jeff Xu <jeffxu@chromium.org> [241216 13:35]:

...

> >
> > I like the idea and I think the opt-out solution should work for CRIU.
> > CRIU will be able to call this prctl and re-execute itself.
> >
> Great! Let's iterate on the opt-out solution then.
> 

This patch set has been NACK'ed.

Please rework your solution and address all the concerns raised.  It
will not be accepted in the current form.

...

Thanks,
Liam
