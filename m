Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9545C277026
	for <linux-hardening@vger.kernel.org>; Tue, 28 Oct 2025 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666862; cv=fail; b=O5NYPDxJHZsmFdFDZCCbB7jC9GF85AJzSXkm7rI2vVmhA5szBAFIg5ghngjQY6v2TyZDBnzNr+X3etqGJ0pIaWX9YRugWz0LwlJufvBOfLceer3zz9mniciXg09Nb5Djno5DFDPOF8RZGlKyAxB/p52on3pOXOCu56c7ampwBWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666862; c=relaxed/simple;
	bh=snv+nUigeLnB9uyBZvTdn3g0LW4FV5NOpbNCFIQZKxs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Eufrva5YfNPyTPTu8Bgof4eliR9oAPRiMzvSdjXuQGB59oWRZcSjo8iISqcS42Wplujm09VY3eZ7UaIgbdIr0s9F8ez4+EbWgTGwEGflPNkdFhBnzvfv0W00nz1COjz4I/8KLJ19tBvP6CTHY6GwwrWdmNPXLxN9Cnq3ukTp2+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eEPx5mPS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iqSYB4Ne; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eEPx5mPS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iqSYB4Ne"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SBDZT8024399;
	Tue, 28 Oct 2025 15:51:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=iZDqFHhpUIij2SO9dR4F0TbI1ID3c0zayFwbzhKr0xw=; b=
	eEPx5mPSUWh1VoZs0jE2boN9Ocyk3IuN2spVXzJ9+oArbOSGA7x0gJa2U7Ulqnl9
	iOGcdeBE95Bh8YDh9tDjiNSV6MW7dvLI5WgV6Qns2hwW5it0ssHpL9S4TKngvxL/
	nOdCM9ISU8BfwD2vhtgLtfY5PwwGNLOnGSTEHDzUTHnRx1IBbtw2slOeoytk8MIg
	k/oVBAQ54DZWyiwIoPJhiuYuhT4r1fg8hbsvVzncHiR+H0MGc8ReTj1F/ujo0u1V
	JsUtdg8mVmpoJLb2qJ+O68RA+v3P6o7LOkFNB0XBnwf7wWjSYVcOFfm2wGajB/x+
	U0Nic7A2Ph+DvohYAnFg7g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a2357kyf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 15:51:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59SEPDXL037554;
	Tue, 28 Oct 2025 15:51:36 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010033.outbound.protection.outlook.com [52.101.61.33])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n08cy9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 15:51:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bR8/fbQIK88xcvnKrxGvNr5C+OZ8rcByXChfBPxdtWlxvoGkAgsqcCMLXj8eUHIFQX0I/RRZNX4AIIrm2ej0FSb9rbyvIOInspFSsYX1kwt1wGfDOdrrDQ6nzukqcoEkYe6OyWUtb1waFqc5eRPOph4CAhIOxtGnMxUjtyiPMxedaYH8vNuoASRKQGBaMCBToJSMzvuAL93J+Vhvzi8RZZsxi51yGOYmjYJIP5i84pxrt23sOaAqnShiA7KY7rcUzAm0eWiUbbjY6k8nyI2OzmQ7iZk/WvMPC2zeySeU8QHr4vNFoAlD/ExGkVZ8LZGcyLP79g380HxrY2VbMHVmgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZDqFHhpUIij2SO9dR4F0TbI1ID3c0zayFwbzhKr0xw=;
 b=b0cA43PEbjjAlzSQFQ1tQVoG5lEL1NVXoV2qyn7ZP6VB8tPLh7a7Wq/jiuZ83kaXW9Z+N7AWjUyLrghnpgcAcaAGdvbi5yAyUiC5uyNHjEcYe9eKx/LkrFQiNPzHPVgIpd/CgSYVX92JSuIi8Ijkp3ENNZ/uvKlmq5OOzc3CXy72InZs1svD+AwdjWziHUHhcUku/+8bO/V/AD3BgXD+FNlHhqNkN+eRy7ECeNUXudhCPmb24O3sHLQJzpuBYJKQ1ZvisPnxyr51n8XlHCnbk03fe/fCXEWPZMi12ARkKpJZpwIe3w3DPobRMrAmFh3mwU4RVhbPixi9XE/Kvp0DPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZDqFHhpUIij2SO9dR4F0TbI1ID3c0zayFwbzhKr0xw=;
 b=iqSYB4NeqvgfZ38QqRTT02tr0sFqio5adX6x5snrQc1Tfqy1LBo9By4mdAKY1x/4g7ZRU+n1gSNec4L2eyGHtABflnO0cdp51cUiuWqIUv51X5dbBh55NgKiRjx3gnA55+KazV68ao3YqbMtVwyqv5Npd/vFFxVq/VM5X7vOuQI=
Received: from CY8PR10MB6538.namprd10.prod.outlook.com (2603:10b6:930:5a::17)
 by MN2PR10MB4304.namprd10.prod.outlook.com (2603:10b6:208:1d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 15:51:31 +0000
Received: from CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::83c0:6ad9:b202:784e]) by CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::83c0:6ad9:b202:784e%3]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 15:51:31 +0000
From: Qing Zhao <qing.zhao@oracle.com>
To: Kees Cook <kees@kernel.org>
CC: Andrew Pinski <pinskia@gmail.com>, Jakub Jelinek <jakub@redhat.com>,
        Martin Uecker <uecker@tugraz.at>, Richard Biener <rguenther@suse.de>,
        Joseph
 Myers <josmyers@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard
 Biesheuvel <ardb@kernel.org>, Jeff Law <jeffreyalaw@gmail.com>,
        Jan Hubicka
	<hubicka@ucw.cz>,
        Richard Earnshaw <richard.earnshaw@arm.com>,
        Richard
 Sandiford <richard.sandiford@arm.com>,
        Marcus Shawcroft
	<marcus.shawcroft@arm.com>,
        Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
        Kito
 Cheng <kito.cheng@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew
 Waterman <andrew@sifive.com>,
        Jim Wilson <jim.wilson.gcc@gmail.com>,
        Dan Li
	<ashimida.1990@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ramon de
 C Valle <rcvalle@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Nathan
 Chancellor <nathan@kernel.org>,
        Bill Wendling <morbo@google.com>,
        "Osterlund,
 Sebastian" <sebastian.osterlund@intel.com>,
        "Constable, Scott D"
	<scott.d.constable@intel.com>,
        "gcc-patches@gcc.gnu.org"
	<gcc-patches@gcc.gnu.org>,
        "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v5 2/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Thread-Topic: [PATCH v5 2/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Thread-Index: AQHcQ4DhCtcCE7if3US6CgwWQVuf67TXvmYA
Date: Tue, 28 Oct 2025 15:51:31 +0000
Message-ID: <5086E7A1-DF51-47D9-A7D1-930F6342A909@oracle.com>
References: <20251022181345.do.256-kees@kernel.org>
 <20251022182243.72085-2-kees@kernel.org>
In-Reply-To: <20251022182243.72085-2-kees@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6538:EE_|MN2PR10MB4304:EE_
x-ms-office365-filtering-correlation-id: f84a2702-f710-4b86-9a2e-08de1639dd4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|13003099007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NIL+Qb5mRdAwY6fAwAZgc3EPEAmd2jnVMtxrgy4ZJopATO7JkmHyVJpfVQKF?=
 =?us-ascii?Q?XBFqlUe4poydjC81ou1KdgNeZ6mbOxtyF4T8sgTmXyO7Uu7elSjEyA/wsA+5?=
 =?us-ascii?Q?RAbtZla5SyFpVpPB7j+c87iFdImHpZ2iGaWwdRmpxz/q3Rmj8kN9c3gvgKeQ?=
 =?us-ascii?Q?dBgGVYn1vc0BxlHJVl22ABuZjfZSva5LTwYin/gIAcvsu6zssItHHcQG0//p?=
 =?us-ascii?Q?ngRCO3tusG5ZtW/yYFWkRDw3JwAWHXhPYc/EGQ772hk9bkCFziU4WJUOpMBd?=
 =?us-ascii?Q?rlFqJm7YLMPeTNBExNH3R2C93eHn9kXXxia0bOOaRXonzuaplhvrpmASm0Kc?=
 =?us-ascii?Q?Se/XbP2gSmDxCg/diDc2CKU1nKqGJQ4jZOwVQwujx3UcmLWKtHI9auvf4lew?=
 =?us-ascii?Q?mwm3uIPwvwcsFez83LYPBT7NLME0f0OKTRXkw4QR5gES7ti9/coB1Q3kCQad?=
 =?us-ascii?Q?8O5qQVSJhv+9V+uKrhpx9akUNEW2lpSrC6m1DJI1Wv4sioDPEt8G9b5hJbgw?=
 =?us-ascii?Q?+R1jtaPjYmaYH+jNCLPqxzq2bHVSMPL0FZChf10WxmZy0bP3kUGjC1SJEuKp?=
 =?us-ascii?Q?1kAHQjdnsqT31D13VeWQ0lgaVrsegvBCLwlLD1d5xkfsBnXO/nisKuumNxCT?=
 =?us-ascii?Q?1Xd8vy5D1+r34Rm5dGxgLrIYlkWzK+9CaHLnWfRHcQydi+t/00ax+BsUf0AP?=
 =?us-ascii?Q?aMv1Bi8KWXrTq8d1ZfNpGRLBLgAJ0OanI+zqLs9V1y5FMXbNPrVLmlDvoILo?=
 =?us-ascii?Q?0m5q6etUKqAUabF6RfQYsenc0TGskRcdVtSULvtc+1RSuBcj5MUT8SMP4y25?=
 =?us-ascii?Q?A+bfHuzbvKa9TKosrEWd2FuzHgk/EBKAC1XIgpQPFhnbKeauVu8LosopPb2q?=
 =?us-ascii?Q?g5tUmr3LUGTUZHoy5QsRD12SWs28qa+uLPW5ydbxxEagxMJ+TAb5DCEqcBm1?=
 =?us-ascii?Q?DrVjuEuguWTqaq8lAA7DEvca8993wLZmUc99x3sBZEc33zT19YesWGWzJLLU?=
 =?us-ascii?Q?kA+sNYMW3gcY45W9BgnbW631drKXEIa9Q7GO+6Uu5TuZzlgyrMNWFqQ0l87j?=
 =?us-ascii?Q?i1YOtpOk8WxQr8V58n/0GpYgLR7h6Qsyubdy/FPJaGULcqsBfLgoALZnaE9o?=
 =?us-ascii?Q?2DeY2fh1qTszBhmNXh4vMpALNUR5ijgved7L7reTl9DnT1XEApAxrJu8a+sE?=
 =?us-ascii?Q?7ZrkXvPDHnKr/IINKg5JrHro8K5Ke4KM9tGiYiNU4Fco4JpJYKleIWIyI1NZ?=
 =?us-ascii?Q?zGpLHB/5hB1yhfgkpy0U9DI3SwwEsWI4b7NwmkaFasUHLkfH7G3MYJKqHmku?=
 =?us-ascii?Q?TLOd8jMXiBVJBadQSngjY8NEyLvnXs0LmguHopLeuvpEtatGqE9uzMFxtIB3?=
 =?us-ascii?Q?/16gjtsAYn1F8rM9yyjtOArcEdvn54qocalBdUgzyLSRkJbUGv0Wb391H+kO?=
 =?us-ascii?Q?Np3idMaq4at321krrgR1y6vPNz/oFVB6Mwg4ZMtR9MUdISRv+S4lfg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6538.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NwA1PuwDGisTVyaDsJ4kBaaBIpfv7XR25A4H1/3umruVQnIdk9jdX7NH5xhk?=
 =?us-ascii?Q?jVsw0rA44vjDTiIUOsbzv3cu90inV1w8hem7gqKxMJHH8Ia+sM7COVTaiIR7?=
 =?us-ascii?Q?XNLtBl2LErXrRVFazEh241g+FJxkoQLxzWOb40njVJ6GWRrHCwKjqYlJlRnV?=
 =?us-ascii?Q?EKcdV8V++lR2z1XegfCIdiRlrZ1Z+g2zWj6zrIUrxTfPo2J735FvNx99+Lc+?=
 =?us-ascii?Q?TKQLrggB3uS9ARBGgbwpkUEXx0YYd03x6qgZwWQapTe2APmr9Lvf2R7ch0gP?=
 =?us-ascii?Q?b2asDZnhK3QAV8qzBkJmITYz1ApUcXVOCnRLjI3hovG0rsxKAp3BpHI+/vqv?=
 =?us-ascii?Q?YYbpuVfkmTP+6WDOKCs6HMyHaKGiDaC9rq+E7tXyI9sl1FWkp+RjZzyb9OWq?=
 =?us-ascii?Q?weM1gYQq14Y5UT5JB+OSKXDGPosgBNyRrYB5SeTWGuzUkKUx3m5XCEPRna0m?=
 =?us-ascii?Q?t1w5Y9G89dSjvaXB5GVqXQpPQKZeCAZmojxhoXfnZz16WTd1K4l5bnVTL3jc?=
 =?us-ascii?Q?f1oFFwjEmpLMKcrcko7LrxGkXxstbGD5oCJHnTarE2NJUtLENtacq9iLEJ5I?=
 =?us-ascii?Q?OBlh8uDkMTk0MZTTUgN3y+Ocptdjs+8Q/1Fgj5PrULul7F3IxdBFVN3UckVf?=
 =?us-ascii?Q?wk4AOPESdmU1N6183rm8eweTABWZ8LPF6ShCVPJhOkp/Yw7fhahYLA3Wh0Xg?=
 =?us-ascii?Q?5TTDgEfAm2My6qRsgoNew7BJ1CpzJ1B7HPBLWyK/y/h/tXPHL7VnyFGsobK+?=
 =?us-ascii?Q?CF6JujxwiocZMYBYGtN7LT+QCfnfn7T9V5Gqx6KkUtG35AIzaV0tTk6LVBiD?=
 =?us-ascii?Q?N+J3A9X1mvw7FJei4CD4NL+ziIWsSQPdLJ/m9PTVa9d2MWdaDiCinkijRXat?=
 =?us-ascii?Q?bY2IkouNHPoARo374UuHQNjvNVpGDyNYmiWGvQW28PAZY0GFnyjSkzWk4p73?=
 =?us-ascii?Q?qmYUtYk7oxnpi2Ugnva95j9L4AFLi2ZU11eHGjtFNqVQ47g6AQ2hg3kmWy73?=
 =?us-ascii?Q?fgEseKooSIXLTV8qKLq0VmH/Kp+xGaZkP+kiE6olvsZZ8eHOM4Xg+/9BN2vq?=
 =?us-ascii?Q?WR/WF40Ze0+YarLhOcrm68xAmTxCSox3Kr+DI2MiDiQzUxX/Fj1jYMqTtUbd?=
 =?us-ascii?Q?eeWwwBRg00TSwS+GyaN83ppBr9aUZ/6110taNrb1N7yDjPVUma3EVgk9S2F1?=
 =?us-ascii?Q?XPtfEFH4BuBQ1CQh13pgcUPGs2QlXY8jxGrZC3vPgzuxJ+RhJGGRiRztzxXU?=
 =?us-ascii?Q?9sYDmX9b5p1K3W6L4Ga0sM24YHjOV7Qo6U6iBOjSisVLm4YSSWISuIH9ReJD?=
 =?us-ascii?Q?/6auEUyBXSMe/pemCBiEuA3HDAcWIq1qCNikkXDIhDiKfIK725jbwaHoyFoC?=
 =?us-ascii?Q?y9DOgZfNFX8x+0CPOrTAmN7xYETSAL0WSibZ3LuqjspXSI5Xu6qLTk/7VM7W?=
 =?us-ascii?Q?YyqGxAstV3eAfeJqGPUofgnGZ7dr2YRim2Ci7eZRX1UH1ZEJJTAYHBXZtUcn?=
 =?us-ascii?Q?qROMfZPgT2xFkBGrWjYkvrsUWaluXb6DxfiT8rbB76a1mlkSsslZ3dmN0PvB?=
 =?us-ascii?Q?bi2PLTEGka/bH2ese+D3s6wOu4jQ7hPKjAT/70c3qLH+DdRO+9Ic/Uv/i0Xo?=
 =?us-ascii?Q?/g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E55BCE778D9BF0488EA117332864AF7A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ck20HKGqYW66mbIpP8PfaTSCMQNX/6AhJiyI/T4pCeLxJH58mH8gIRqVkOeG2FskhIkWqsmXubRtkw8LQt+fqNN8BEiATQ2dmf1PtpCHbSYOElqBc5QTaXVefGPCHvCi/CkXsgxdyljrspKi4fjLZUG5+n4xCLhQJUGajHtOMoYn8RC2tA9O3e2SlIFg3+ipXIko7rcqvrsF/mW0j4/Ib/64+O5sTOaaC1mHP+pHWF0XNKji153M30o9Qo9OyILGfJmAVFdwxCK5qoX23Vsg5s1C91UNNky56+5sEipzcQge4297y9xp6ENDcDy78czYZsG9t7Ef7RLoCPcaQo1103bA5j/2gYSSll0vXggH0mWYCLrKHNF2B1A8x67I5UOqAfZJF5b1scwZZIIg4lVwrhfAHX5NGg/pZN7Wx//0U36lSQAOI9wBmiMpaaTmt/xyiD+TxG6//asda7kij68wa5BKJePr2AdidbQS5TawgdxmBqNK1DOIo7sbYhQ4Jgo+tqhPrD1FslUCA91nmxGHQyMT0h80U6YFpbMGGfMGBy6P4iH5XHkvH50iYKF+18x5B+DZJJnjTmIQCSgv0vdjT7UcI8LUmZit78dCBO8icnA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6538.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84a2702-f710-4b86-9a2e-08de1639dd4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 15:51:31.4509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pRtvhS0W5Zg91bOwL8gvOd02klGoxyLLVZieqw5Q/IXPVwnFpQgYffEzsCWjOqyES/6HbXw+9ghtKc0+nXjW5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4304
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510280133
X-Authority-Analysis: v=2.4 cv=Bt2QAIX5 c=1 sm=1 tr=0 ts=6900e689 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=mDV3o1hIAAAA:8 a=Ue42Q34zAAAA:8 a=H0umD5oqAAAA:8
 a=We0TE4j0AAAA:8 a=o4cBDJ48AAAA:8 a=OGjWj8McAAAA:8 a=VwQbUJbxAAAA:8
 a=8wuyQv3UMnKfmK-RSGgA:9 a=Ls7hm5mh2MGOgLWU:21 a=CjuIK1q_8ugA:10
 a=s2Qs2jXM6lQA:10 a=du2hvLAJtKcNxoDMbUSS:22 a=OOX4_xUL_TWpQX1oCgna:22
 a=UYjydHh6ynBBc6_pBLvz:22 a=nl4s5V0KI7Kw-pW0DWrs:22 a=poXaRoVlC6wW9_mwW8W4:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=SsAZrZ5W_gNWK9tOzrEV:22
X-Proofpoint-GUID: GLWYE1Pau80mxPvWVES7wLxw1KUrTNM8
X-Proofpoint-ORIG-GUID: GLWYE1Pau80mxPvWVES7wLxw1KUrTNM8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1NCBTYWx0ZWRfX+pyuT1UJCkkx
 0J6ta2PKOX0xc1Olt9TkfK6NHbUg/4jnBXWbQZtBMJ+OqusFi86lr/uWBhtkdgxi2vDeYdumBB9
 0iQ5Iqi6i3l14lqXyIW7GMqXuSXAmqk3dI6QXufvvowg2qce5/4MimQROvsHcsiMl4FJ7+vTgXv
 2y9dk0jgtgMFJ9WPed+SjGfNghQqkh/MB/wxywCzEjywy4GfSZEwya/PGf1IXVpPfIV2DaX9Y8Q
 W1wg2ozByXgGVDndRkT53fbZTfFcI2ZsHH20Gcbm3GKfodcWtCpWHFZ8t2OYRMHmd/0F95ZUrXM
 2ZWtxtS+JXpTvWx+gWbwP2CYdagZ+ir/ekcgEaXmPEvOZk/F+anqZXPkRCIpb672UzpuV8TW4P8
 IrDkqm6ZVwH8MdEF67gguQLEn6vR/w==

Hi, Kees,

Thanks for the updated version.
I took a look at this latest version. To me, both the design and implementa=
tion
is clean and well understandable. I have no further comments on this patch.=
=20
Thank you for all the work.

Qing



> On Oct 22, 2025, at 14:22, Kees Cook <kees@kernel.org> wrote:
>=20
> Implements the Linux Kernel Control Flow Integrity ABI, which provides a
> function prototype based forward edge control flow integrity protection
> by instrumenting every indirect call to check for a hash value before
> the target function address. If the hash at the call site and the hash
> at the target do not match, execution will trap.
>=20
> See the start of kcfi.cc for design details.
>=20
> gcc/ChangeLog:
>=20
> * kcfi.h: New file with KCFI public interface declarations.
> * kcfi.cc: New file implementing Kernel Control Flow Integrity
> infrastructure.
> * Makefile.in (OBJS): Add kcfi.o.
> * flag-types.h (enum sanitize_code): Add SANITIZE_KCFI.
> * gimple.h (enum gf_mask): Add GF_CALL_INLINED_FROM_KCFI_NOSANTIZE.
> (gimple_call_set_inlined_from_kcfi_nosantize): New function.
> (gimple_call_inlined_from_kcfi_nosantize_p): New function.
> * tree-pass.h Add kcfi passes.
> * df-scan.cc (df_uses_record): Add KCFI case to handle KCFI RTL
> patterns and process wrapped RTL.
>        * doc/extend.texi: Update nocf_check for kcfi.
> * doc/invoke.texi (fsanitize=3Dkcfi): Add documentation for KCFI
> sanitizer option.
> * doc/tm.texi.in: Add Kernel Control Flow Integrity section with
> TARGET_KCFI_SUPPORTED, TARGET_KCFI_MASK_TYPE_ID,
> TARGET_KCFI_EMIT_TYPE_ID hooks.
> * doc/tm.texi: Regenerate.
> * final.cc (call_from_call_insn): Add KCFI case to handle
> KCFI-wrapped calls.
> * opts.cc (sanitizer_opts): Add kcfi entry.
> * passes.cc: Include kcfi.h.
> * passes.def: Add KCFI IPA pass.
> * rtl.def (KCFI): Add new RTL code for KCFI instrumentation.
>        * rtlanal.cc (reg_referenced_p): Add KCFI case.
> * target.def: Add KCFI target hooks.
> * toplev.cc (process_options): Add KCFI option processing.
> * tree-inline.cc: Include kcfi.h and asan.h.
> (copy_bb): Handle KCFI no_sanitize attribute propagation during
> inlining.
> * varasm.cc (assemble_start_function): Emit KCFI preambles.
> (assemble_external_real): Emit KCFI typeid symbols.
> (default_elf_asm_named_section): Handle .kcfi_traps using
> SECTION_LINK_ORDER flag.
>=20
> gcc/c-family/ChangeLog:
>=20
> * c-attribs.cc: Include asan.h.
>        (handle_nocf_check_attribute): Enable nocf_check under kcfi.
> (handle_patchable_function_entry_attribute): Add error for using
> patchable_function_entry attribute with -fsanitize=3Dkcfi.
>=20
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> gcc/kcfi.h                |  56 +++
> gcc/kcfi.cc               | 691 ++++++++++++++++++++++++++++++++++++++
> gcc/doc/extend.texi       |  42 +++
> gcc/doc/invoke.texi       |  33 ++
> gcc/doc/tm.texi           |  32 ++
> gcc/Makefile.in           |   1 +
> gcc/flag-types.h          |   2 +
> gcc/gimple.h              |  22 ++
> gcc/tree-pass.h           |   1 +
> gcc/c-family/c-attribs.cc |  17 +-
> gcc/df-scan.cc            |   7 +
> gcc/doc/tm.texi.in        |  12 +
> gcc/final.cc              |   3 +
> gcc/opts.cc               |   1 +
> gcc/passes.cc             |   1 +
> gcc/passes.def            |   1 +
> gcc/rtl.def               |   6 +
> gcc/rtlanal.cc            |   5 +
> gcc/target.def            |  39 +++
> gcc/toplev.cc             |  10 +
> gcc/tree-inline.cc        |  10 +
> gcc/varasm.cc             |  37 +-
> 22 files changed, 1018 insertions(+), 11 deletions(-)
> create mode 100644 gcc/kcfi.h
> create mode 100644 gcc/kcfi.cc
>=20
> diff --git a/gcc/kcfi.h b/gcc/kcfi.h
> new file mode 100644
> index 000000000000..f945e8678344
> --- /dev/null
> +++ b/gcc/kcfi.h
> @@ -0,0 +1,56 @@
> +/* Kernel Control Flow Integrity (KCFI) support for GCC.
> +   Copyright (C) 2025 Free Software Foundation, Inc.
> +
> +This file is part of GCC.
> +
> +GCC is free software; you can redistribute it and/or modify it under
> +the terms of the GNU General Public License as published by the Free
> +Software Foundation; either version 3, or (at your option) any later
> +version.
> +
> +GCC is distributed in the hope that it will be useful, but WITHOUT ANY
> +WARRANTY; without even the implied warranty of MERCHANTABILITY or
> +FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> +for more details.
> +
> +You should have received a copy of the GNU General Public License
> +along with GCC; see the file COPYING3.  If not see
> +<http://www.gnu.org/licenses/>.  */
> +
> +#ifndef GCC_KCFI_H
> +#define GCC_KCFI_H
> +
> +#include "config.h"
> +#include "system.h"
> +#include "coretypes.h"
> +#include "rtl.h"
> +
> +/* Common helper for RTL patterns to emit .kcfi_traps section entry.
> +   Call after emitting trap label and instruction with the trap symbol
> +   reference.  */
> +extern void kcfi_emit_traps_section (FILE *file, rtx trap_label_sym,
> +      int labelno);
> +
> +/* Extract KCFI type ID from current GIMPLE statement.  */
> +extern rtx __kcfi_get_type_id_for_expanding_gimple_call (void);
> +
> +/* Convenience wrapper to check for SANITIZE_KCFI.  */
> +#define kcfi_get_type_id_for_expanding_gimple_call() \
> +  ((flag_sanitize & SANITIZE_KCFI) \
> +     ? __kcfi_get_type_id_for_expanding_gimple_call () \
> +     : NULL_RTX)
> +
> +/* Emit KCFI type ID symbol for external address-taken functions.  */
> +extern void kcfi_emit_typeid_symbol (FILE *asm_file, tree fndecl);
> +
> +/* Emit KCFI preamble for potential indirect call targets.  */
> +extern void kcfi_emit_preamble (FILE *asm_file, tree fndecl,
> + const char *actual_fname);
> +
> +/* Get next KCFI label number for trap/call/entry label numbering.  */
> +extern int kcfi_next_labelno (void);
> +
> +/* Get the KCFI typeid offset for calculating callsite typeid offset.  *=
/
> +extern HOST_WIDE_INT kcfi_get_typeid_offset (void);
> +
> +#endif /* GCC_KCFI_H */
> diff --git a/gcc/kcfi.cc b/gcc/kcfi.cc
> new file mode 100644
> index 000000000000..91b60b06a243
> --- /dev/null
> +++ b/gcc/kcfi.cc
> @@ -0,0 +1,691 @@
> +/* Kernel Control Flow Integrity (KCFI) support for GCC.
> +   Copyright (C) 2025 Free Software Foundation, Inc.
> +
> +This file is part of GCC.
> +
> +GCC is free software; you can redistribute it and/or modify it under
> +the terms of the GNU General Public License as published by the Free
> +Software Foundation; either version 3, or (at your option) any later
> +version.
> +
> +GCC is distributed in the hope that it will be useful, but WITHOUT ANY
> +WARRANTY; without even the implied warranty of MERCHANTABILITY or
> +FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> +for more details.
> +
> +You should have received a copy of the GNU General Public License
> +along with GCC; see the file COPYING3.  If not see
> +<http://www.gnu.org/licenses/>.  */
> +
> +/* KCFI ABI Design:
> +
> +The Linux Kernel Control Flow Integrity ABI provides a function prototyp=
e
> +based forward edge control flow integrity protection by instrumenting
> +every indirect call to check for a hash value before the target function
> +address.  If the hash at the call site and the hash at the target do not
> +match, execution will trap.
> +
> +The general CFI ideas are discussed here, but focuses more on a CFG
> +analysis to construct valid call destinations, which tends to require LT=
O:
> +https://users.soe.ucsc.edu/~abadi/Papers/cfi-tissec-revised.pdf
> +
> +Later refinement for using jump tables (constructed via CFG analysis
> +during LTO) was proposed here:
> +https://www.usenix.org/system/files/conference/usenixsecurity14/sec14-pa=
per-tice.pdf
> +
> +Linux used the above implementation from 2018 to 2022:
> +https://android-developers.googleblog.com/2018/10/control-flow-integrity=
-in-android-kernel.html
> +but the corner cases for target addresses not being the actual functions
> +(i.e. pointing into the jump table) was a continual source of problems,
> +and generating the jump tables required full LTO, which had its own set
> +of problems.
> +
> +Looking at function prototypes as the source of call validity was
> +presented here, though still relied on LTO:
> +https://www.blackhat.com/docs/asia-17/materials/asia-17-Moreira-Drop-The=
-Rop-Fine-Grained-Control-Flow-Integrity-For-The-Linux-Kernel-wp.pdf
> +
> +The KCFI approach built on the function-prototype idea, but avoided
> +needing LTO, and could be further updated to deal with CPU errata
> +(retpolines, etc):
> +https://lpc.events/event/16/contributions/1315/
> +
> +KCFI has a number of specific constraints.  Some are tied to the
> +backend architecture, which are covered in arch-specific code.
> +The constraints are:
> +
> +- The KCFI scheme generates a unique 32-bit hash ("typeid") for each
> +  unique function prototype, allowing for indirect call sites to verify
> +  that they are calling into a matching _type_ of function pointer.
> +  This changes the semantics of some optimization logic because now
> +  indirect calls to different types cannot be merged.  For example:
> +
> +    if (p->func_type_1)
> + return p->func_type_1 ();
> +    if (p->func_type_2)
> + return p->func_type_2 ();
> +
> +  In final asm, the optimizer may collapse the second indirect call
> +  into a jump to the first indirect call once it has loaded the function
> +  pointer.  KCFI must block cross-type merging otherwise there will be a
> +  single KCFI check happening for only 1 type but being used by 2 target
> +  types.  The distinguishing characteristic for call merging becomes the
> +  type, not the address/register usage.
> +
> +- The check-call instruction sequence must be treated as a single unit: =
it
> +  cannot be rearranged or split or optimized.  The pattern is that
> +  indirect calls, "call *%target", get converted into:
> +
> +    mov $target_expression, %target ; only present if the expression was
> +    ; not already in %target register
> +    load -$offset(%target), %tmp    ; load typeid hash from target pream=
ble
> +    cmp $typeid, %tmp    ; compare expected typeid with loaded
> +    je .Lkcfi_call$N    ; success: jump to the indirect call
> +  .Lkcfi_trap$N:    ; label of trap insn
> +    trap    ; trap on failure, but arranged so
> +    ; "permissive mode" falls through
> +  .Lkcfi_call$N:    ; label of call insn
> +    call *%target    ; actual indirect call
> +
> +  This pattern of call immediately after trap provides for the
> +  "permissive" checking mode automatically: the trap gets handled,
> +  a warning emitted, and then execution continues after the trap to
> +  the call.
> +
> +- KCFI check-call instrumentation must survive tail call optimization.
> +  If an indirect call is turned into an indirect jump, KCFI checking
> +  must still happen (but it will use a jmp rather than a call).
> +
> +- Functions that may be called indirectly have a preamble added,
> +  __cfi_$original_func_name, which contains the $typeid value:
> +
> +    __cfi_target_func:
> +      .word $typeid
> +    target_func:
> +       [regular function entry...]
> +
> +- The preamble needs to interact with patchable function entry so that
> +  the typeid appears further away from the actual start of the function
> +  (leaving the prefix NOPs of the patchable function entry unchanged).
> +  This means only _globally defined_ patchable function entry is support=
ed
> +  with KCFI (indrect call sites must know in advance what the offset is,
> +  which may not be possible with extern functions that use a function
> +  attribute to change their patchable function entry characteristics).
> +  For example, a "4,4" patchable function entry would end up like:
> +
> +    __cfi_target_func:
> +      .data $typeid
> +      nop nop nop nop
> +    target_func:
> +       [regular function entry...]
> +
> +  Architectures may need to add alignment nops prior to the typeid to ke=
ep
> +  __cfi_target_func aligned for function call conventions.
> +
> +- An external function that is address-taken but does not have a definit=
ion has
> +  a weak __kcfi_typeid_$func symbol added at the declaration site. This =
weak
> +  symbol has the typeid value available so that the typeid can be refere=
nced
> +  from assembly linkages, etc, where the typeid values cannot be calcula=
ted
> +  (i.e where C type information is missing):
> +
> +    .weak   __kcfi_typeid_$func
> +    .set    __kcfi_typeid_$func, $typeid
> +
> +- On architectures that do not have a good way to encode additional
> +  details in their trap insn (e.g. x86_64 and riscv64), the trap locatio=
n
> +  is identified as a KCFI trap via a relative address offset entry
> +  emitted into the .kcfi_traps section for each indirect call site's
> +  trap instruction.  The previous check-call example's insn sequence wou=
ld
> +  then have section changes inserted between the trap and call:
> +
> +  ...
> +  .Lkcfi_trap$N:
> +    trap
> +  .section .kcfi_traps,"ao",@progbits,.text
> +  .Lkcfi_entry$N:
> +    .long .Lkcfi_trap$N - .Lkcfi_entry$N
> +  .text
> +  .Lkcfi_call$N:
> +    call *%target
> +
> +  It is up to such architectures to decode instructions prior to the
> +  trap to locate the typeid that the callsite was expecting.
> +
> +  For architectures that can encode immediates in their trap function
> +  (e.g. aarch64 and arm32), this isn't needed: they just use immediate
> +  codes that indicate a KCFI trap.
> +
> +- The no_sanitize("kcfi") function attribute means that the marked
> +  function must not produce KCFI checking for indirect calls, and this
> +  attribute must survive inlining.  This is used rarely by Linux, but
> +  is required to make BPF JIT trampolines work on older Linux kernel
> +  versions.
> +
> +- The "nocf_check" function attribute can be used to supress the
> +  KCFI preamble for a function, making that function unavailable
> +  for indirect calls.
> +
> +As a result of these constraints, there are some behavioral aspects
> +that need to be preserved across the middle-end and back-end.
> +
> +For indirect call sites:
> +
> +- Make sure KCFI expansion is skipped for inline functions that
> +  are marked with no_sanitize("kcfi") by marking these calls
> +  during GIMPLE inlining with a new flag which is checked during
> +  expansion.
> +
> +- All function types have their associated typeid attached as an
> +  attribute during an IPA pass.
> +
> +- Keep typeid information available through to the RTL expansion
> +  phase via a new KCFI insn RTL pattern that wraps the CALL
> +  and the typeid as expressions.
> +
> +- Keep indirect calls from being merged (see earlier example)
> +  naturally by having typeid be the second argument of the KCFI insn
> +  RTL pattern, so jump2 pass's use of rtx_equal_p() see differing
> +  typeids in the RTL.
> +
> +- Update register liveness analysis to look inside the new KCFI
> +  RTL to find the CALL RTL and examine the registers in use there
> +  so the allocator can track register usage correctly.
> +
> +- KCFI insn emission interacts with patchable function entry to
> +  load the typeid from the target preamble, offset by prefix NOPs.
> +
> +For indirect call targets:
> +
> +- kcfi_emit_preamble interacts with patchable function entry to add
> +  any needed alignment padding prior to emitting the typeid.
> +
> +- assemble_external_real calls kcfi_emit_typeid_symbol to add the
> +  __kcfi_typeid_$func symbols.
> +
> +*/
> +
> +#include "config.h"
> +#include "system.h"
> +#include "coretypes.h"
> +#include "target.h"
> +#include "function.h"
> +#include "tree.h"
> +#include "tree-pass.h"
> +#include "dumpfile.h"
> +#include "basic-block.h"
> +#include "gimple.h"
> +#include "gimple-iterator.h"
> +#include "cgraph.h"
> +#include "kcfi.h"
> +#include "stringpool.h"
> +#include "attribs.h"
> +#include "rtl.h"
> +#include "cfg.h"
> +#include "cfgrtl.h"
> +#include "asan.h"
> +#include "diagnostic-core.h"
> +#include "memmodel.h"
> +#include "print-tree.h"
> +#include "emit-rtl.h"
> +#include "output.h"
> +#include "builtins.h"
> +#include "varasm.h"
> +#include "opts.h"
> +#include "target.h"
> +#include "flags.h"
> +#include "kcfi-typeinfo.h"
> +#include "insn-config.h"
> +#include "recog.h"
> +
> +/* KCFI label counter, incremented by KCFI insn emission.  */
> +static int kcfi_labelno =3D 0;
> +
> +/* Get next KCFI label number.  Returns the current KCFI label number
> +   and increments the internal counter for the next call.  The label is
> +   used to provide a unique number for each indirect callsite of the
> +   current module of the compilation.  */
> +
> +int
> +kcfi_next_labelno (void)
> +{
> +  return kcfi_labelno++;
> +}
> +
> +/* Callsite typeid loading offset.  */
> +static HOST_WIDE_INT kcfi_typeid_offset =3D 0;
> +
> +/* Get the KCFI typeid offset.  Returns the offset in bytes from the
> +   function entry point where the KCFI type ID is stored.  */
> +
> +HOST_WIDE_INT
> +kcfi_get_typeid_offset (void)
> +{
> +  return kcfi_typeid_offset;
> +}
> +/* Count of needed __cfi_... preamble alignment padding NOPs.  */
> +static HOST_WIDE_INT kcfi_alignment_padding_nops =3D 0;
> +/* NOP insn template.  */
> +static const char *kcfi_nop =3D NULL;
> +
> +/* Common helper for RTL patterns to emit .kcfi_traps section entry.
> +   FILE is the output assembly file stream.  TRAP_LABEL_SYM is the RTX
> +   symbol reference for the trap instruction label.  LABELNO is the KCFI
> +   label number to use for the entry label.  */
> +
> +void
> +kcfi_emit_traps_section (FILE *file, rtx trap_label_sym, int labelno)
> +{
> +  /* Generate entry label name with custom prefix.  */
> +  char entry_name[32];
> +  ASM_GENERATE_INTERNAL_LABEL (entry_name, "Lkcfi_entry", labelno);
> +
> +  /* Save current section to restore later.  */
> +  section *saved_section =3D in_section;
> +
> +  /* Use varasm infrastructure for section handling:
> +     .section .kcfi_traps,"ao",@progbits,.text  */
> +  section *kcfi_traps_section =3D get_section (".kcfi_traps",
> +     SECTION_LINK_ORDER, NULL);
> +  switch_to_section (kcfi_traps_section);
> +
> +  /* Emit entry label for relative offset:
> +     .Lkcfi_entry$N:  */
> +  ASM_OUTPUT_LABEL (file, entry_name);
> +
> +  /* Generate address difference using RTL infrastructure.  */
> +  rtx entry_label_sym =3D gen_rtx_SYMBOL_REF (Pmode, entry_name);
> +  rtx addr_diff =3D gen_rtx_MINUS (Pmode, trap_label_sym, entry_label_sy=
m);
> +
> +  /* Emit the address difference as a 4-byte value:
> +    .long .Lkcfi_trap$N - .Lkcfi_entry$N  */
> +  assemble_integer (addr_diff, 4, BITS_PER_UNIT, 1);
> +
> +  /* Restore the previous section:
> +     .text  */
> +  switch_to_section (saved_section);
> +}
> +
> +/* Compute KCFI type ID for a function type.  FNTYPE is the function
> +   type tree node to compute the type ID for.  Returns the 32-bit KCFI
> +   type identifier hash.  */
> +
> +static uint32_t
> +compute_kcfi_type_id (tree fntype)
> +{
> +  gcc_assert (fntype);
> +  gcc_assert (TREE_CODE (fntype) =3D=3D FUNCTION_TYPE);
> +
> +  uint32_t type_id =3D typeinfo_get_hash (fntype);
> +
> +  /* Apply target-specific masking if supported.  */
> +  if (targetm.kcfi.mask_type_id)
> +    type_id =3D targetm.kcfi.mask_type_id (type_id);
> +
> +  /* Output to dump file if enabled.  */
> +  if (dump_file && (dump_flags & TDF_DETAILS))
> +    {
> +      std::string mangled_name =3D typeinfo_get_name (fntype);
> +      fprintf (dump_file, "KCFI type ID: mangled=3D'%s' typeid=3D0x%08x\=
n",
> +       mangled_name.c_str (), type_id);
> +    }
> +
> +  return type_id;
> +}
> +
> +/* Function attribute to store KCFI type ID.  */
> +static tree kcfi_type_id_attr =3D NULL_TREE;
> +
> +/* Get KCFI type ID for a function type.  Set it if missing.  FN_TYPE
> +   is the function type tree node.  Returns the cached or newly computed
> +   32-bit KCFI type identifier, storing it as a type attribute.  */
> +
> +static uint32_t
> +kcfi_get_type_id (tree fn_type)
> +{
> +  uint32_t type_id;
> +
> +  /* Cache the attribute identifier for build_tree_list usage.  */
> +  if (!kcfi_type_id_attr)
> +    kcfi_type_id_attr =3D get_identifier ("kcfi_type_id");
> +
> +  tree attr =3D lookup_attribute ("kcfi_type_id", TYPE_ATTRIBUTES (fn_ty=
pe));
> +  if (attr)
> +    {
> +      tree value =3D TREE_VALUE (attr);
> +      gcc_assert (value && TREE_CODE (value) =3D=3D INTEGER_CST);
> +      type_id =3D (uint32_t) TREE_INT_CST_LOW (value);
> +    }
> +  else
> +    {
> +      type_id =3D compute_kcfi_type_id (fn_type);
> +
> +      tree type_id_tree =3D build_int_cst (unsigned_type_node, type_id);
> +      tree attr =3D build_tree_list (kcfi_type_id_attr, type_id_tree);
> +
> +      TYPE_ATTRIBUTES (fn_type) =3D chainon (TYPE_ATTRIBUTES (fn_type), =
attr);
> +    }
> +
> +  return type_id;
> +}
> +
> +/* Prepare the global KCFI alignment NOPs calculation.  Called once
> +   during IPA pass to set global variables including kcfi_typeid_offset
> +   and kcfi_alignment_padding_nops based on patchable function entry
> +   settings and function alignment requirements.  */
> +
> +static void
> +kcfi_prepare_alignment_nops (void)
> +{
> +  /* Calculate where callsites load the 32-bit typeid from, based
> +     on the target function address.  Under default circumstances,
> +     the typeid is located 4 bytes before the function entry, in
> +     the __cfi_... preamble:
> +
> +     __cfi_func:
> +       [typeid] // -4 from func
> +     func:
> +       [function body]
> +
> +   */
> +  kcfi_typeid_offset =3D sizeof(uint32_t);
> +
> +  /* When Patchable Function Entry (PFE) is enabled, there may be NOP
> +     instructions between the typeid and the function entry point.
> +     Since KCFI callsites have no way to see PFE function attributes,
> +     it can only base the calculations on the global
> +     -fpatchable-function-entry=3DTOTAL[,PREFIX] flag.  */
> +  HOST_WIDE_INT prefix_nops =3D 0;
> +  if (flag_patchable_function_entry)
> +    {
> +      HOST_WIDE_INT total_nops;
> +      parse_and_check_patch_area (flag_patchable_function_entry, false,
> +  &total_nops, &prefix_nops);
> +    }
> +
> +  /* However, PFE is measured in NOP instruction counts, not bytes. So
> +     we need to find out how many bytes they are, and we may need to
> +     emit NOPs for alignment padding later. Prepare the NOP template.  *=
/
> +  rtx_insn *nop_insn =3D make_insn_raw (gen_nop ());
> +  int code_num =3D recog_memoized (nop_insn);
> +  kcfi_nop =3D get_insn_template (code_num, nop_insn);
> +  int nop_insn_bytes =3D get_attr_length (nop_insn);
> +
> +  /* Adjust the offset by how many NOP bytes may be between the typeid
> +     and the function entry point.
> +
> +     __cfi_func:
> +       [typeid] // -(4 + (prefix nop count * nop size)) from func
> +       [prefix nops] // added when -fpatchable-function-entry is set
> +     func:
> +       [entry nops] // added when -fpatchable-function-entry is set
> +       [function body]
> +
> +     At this point, kcfi_typeid_offset is ready and callsites can now
> +     correctly find the typeid.
> +
> +   */
> +  int prefix_nop_bytes =3D prefix_nops * nop_insn_bytes;
> +  kcfi_typeid_offset +=3D prefix_nop_bytes;
> +
> +  /* In the case where the KCFI preamble (and potentially the prefix NOP=
s)
> +     are being used for alternative CFI implementations via live-patchin=
g,
> +     the __cfi_... label itself needs to be usable as a callable functio=
n
> +     target, so alignment NOPs may need to be added between the preamble
> +     label and the typeid during KCFI preamble emission:
> +
> +     __cfi_func: // may need to be function entry aligned
> +       [alignment padding nops] // may be needed when -falign-functions =
set
> +       [typeid]
> +       [prefix nops]
> +     func:
> +       [entry nops]
> +       [function body]
> +
> +     But we only calculate alignment padding NOPs when -falign-functions
> +     has been explicitly set.
> +   */
> +  if (align_functions.levels[0].log <=3D 0)
> +    return;
> +  int function_entry_alignment =3D align_functions.levels[0].get_value (=
);
> +
> +  /* Some architectures may be using an instruction for the typeid (thou=
gh
> +     this requires that the typeid is a trailing immediate value), but t=
he
> +     instruction will have a size greater than 4, which must be part of =
the
> +     resulting alignment padding calculation.  */
> +  int typeid_insn_bytes =3D targetm.kcfi.emit_type_id
> +  ? targetm.kcfi.emit_type_id (NULL, 0, NULL)
> +  : sizeof(uint32_t);
> +
> +  /* Calculate needed architecture-specific alignment padding bytes.  */
> +  int needed_alignment_bytes =3D (function_entry_alignment
> + - ((prefix_nop_bytes + typeid_insn_bytes)
> +   % function_entry_alignment))
> +       % function_entry_alignment;
> +
> +  /* Calculate number of NOP instructions needed for alignment padding. =
 */
> +  if (needed_alignment_bytes % nop_insn_bytes !=3D 0)
> +    sorry ("KCFI function entry alignment padding bytes (%d) are not "
> +   "a multiple of architecture NOP instruction size (%d)",
> +   needed_alignment_bytes, nop_insn_bytes);
> +  kcfi_alignment_padding_nops =3D needed_alignment_bytes / nop_insn_byte=
s;
> +}
> +
> +/* Extract KCFI type ID from indirect call GIMPLE statement.  Uses the
> +   currently expanding GIMPLE statement to determine if KCFI instrumenta=
tion
> +   is needed.  Returns RTX constant with type ID, or NULL_RTX if no KCFI
> +   instrumentation is required.  */
> +
> +rtx
> +__kcfi_get_type_id_for_expanding_gimple_call (void)
> +{
> +  gcc_assert (currently_expanding_gimple_stmt);
> +  gcc_assert (is_gimple_call (currently_expanding_gimple_stmt));
> +
> +  /* Internally checks for no_sanitize("kcfi") with current_function_dec=
l.  */
> +  if (!sanitize_flags_p (SANITIZE_KCFI))
> +    return NULL_RTX;
> +
> +  gcall *call_stmt =3D as_a <gcall *> (currently_expanding_gimple_stmt);
> +
> +  /* Only indirect calls need KCFI instrumentation.  */
> +  if (gimple_call_fndecl (call_stmt))
> +    return NULL_RTX;
> +
> +  /* Skip calls originating from inlined no_sanitize("kcfi") functions. =
 */
> +  if (gimple_call_inlined_from_kcfi_nosantize_p (call_stmt))
> +    return NULL_RTX;
> +
> +  /* Get function type of call.  */
> +  tree fn_type =3D gimple_call_fntype (call_stmt);
> +  gcc_assert (fn_type);
> +
> +  /* Return the type_id.  */
> +  return GEN_INT (kcfi_get_type_id (fn_type));
> +}
> +
> +/* Emit KCFI type ID symbol for an address-taken external function.
> +   ASM_FILE is the output assembly file stream.  FNDECL is the external
> +   function declaration tree node.  Emits weak symbol definitions for
> +   external functions that are address-taken.  */
> +
> +void
> +kcfi_emit_typeid_symbol (FILE *asm_file, tree fndecl)
> +{
> +  /* Only emit for external function declarations.  */
> +  if (TREE_CODE (fndecl) !=3D FUNCTION_DECL || DECL_INITIAL (fndecl))
> +    return;
> +
> +  /* Only emit for functions that are address-taken.  */
> +  struct cgraph_node *node =3D cgraph_node::get (fndecl);
> +  if (!node || !node->address_taken)
> +    return;
> +
> +  /* Get symbol name from RTL and strip encoding prefixes.  */
> +  rtx rtl =3D DECL_RTL (fndecl);
> +  const char *name =3D XSTR (XEXP (rtl, 0), 0);
> +  name =3D targetm.strip_name_encoding (name);
> +
> +  /* .weak __kcfi_typeid_{name} */
> +  std::string symbol_name =3D std::string ("__kcfi_typeid_") + name;
> +  ASM_WEAKEN_LABEL (asm_file, symbol_name.c_str ());
> +
> +  /* .set __kcfi_typeid_{name}, 0x{type_id} */
> +  char val[16];
> +  snprintf (val, sizeof (val), "0x%08x",
> +    kcfi_get_type_id (TREE_TYPE (fndecl)));
> +  ASM_OUTPUT_DEF (asm_file, symbol_name.c_str (), val);
> +}
> +
> +/* Emit KCFI preamble before the function label.  ASM_FILE is the output
> +   assembly file stream.  FNDECL is the function declaration tree node.
> +   ACTUAL_FNAME is the actual function name to use, or NULL to use the
> +   function's assembler name.  Functions get preambles when -fsanitize=
=3Dkcfi
> +   is enabled, regardless of no_sanitize("kcfi") attribute.  */
> +
> +void
> +kcfi_emit_preamble (FILE *asm_file, tree fndecl, const char *actual_fnam=
e)
> +{
> +  /* Skip functions with nocf_check attribute.  */
> +  if (lookup_attribute ("nocf_check", TYPE_ATTRIBUTES (TREE_TYPE (fndecl=
))))
> +    return;
> +
> +  struct cgraph_node *node =3D cgraph_node::get (fndecl);
> +
> +  /* Ignore cold partition functions: not reached via indirect call.  */
> +  if (node && node->split_part)
> +    return;
> +
> +  /* Ignore cold partition sections: cold partitions are never indirect =
call
> +     targets.  Only skip preambles for cold partitions (has_bb_partition=
 =3D true)
> +     not for entire cold-attributed functions (has_bb_partition =3D fals=
e).  */
> +  if (in_cold_section_p && crtl && crtl->has_bb_partition)
> +    return;
> +
> +  /* Check if function is truly address-taken using cgraph node analysis=
.  */
> +  bool addr_taken =3D (node && node->address_taken);
> +
> +  /* Only instrument functions that can be targets of indirect calls:
> +     - Public functions (can be called externally)
> +     - External declarations (from other modules)
> +     - Functions with true address-taken status from cgraph analysis.  *=
/
> +  if (!(TREE_PUBLIC (fndecl) || DECL_EXTERNAL (fndecl) || addr_taken))
> +    return;
> +
> +  /* Use actual function name if provided, otherwise fall back to
> +     DECL_ASSEMBLER_NAME.  */
> +  const char *fname =3D actual_fname
> + ? actual_fname
> + : IDENTIFIER_POINTER (DECL_ASSEMBLER_NAME (fndecl));
> +
> +  /* Create symbol name for reuse.  */
> +  std::string cfi_symbol_name =3D std::string ("__cfi_") + fname;
> +
> +  /* Emit __cfi_ symbol with proper visibility.  */
> +  if (TREE_PUBLIC (fndecl))
> +    {
> +      if (DECL_WEAK (fndecl))
> + ASM_WEAKEN_LABEL (asm_file, cfi_symbol_name.c_str ());
> +      else
> + targetm.asm_out.globalize_label (asm_file, cfi_symbol_name.c_str ());
> +    }
> +
> +  /* Emit .type directive.  */
> +  ASM_OUTPUT_TYPE_DIRECTIVE (asm_file, cfi_symbol_name.c_str (), "functi=
on");
> +  ASM_OUTPUT_LABEL (asm_file, cfi_symbol_name.c_str ());
> +
> +  /* Emit any needed alignment padding NOPs using target's NOP template.=
  */
> +  for (int i =3D 0; i < kcfi_alignment_padding_nops; i++)
> +    output_asm_insn (kcfi_nop, NULL);
> +
> +  /* Emit type ID bytes.  */
> +  uint32_t type_id =3D kcfi_get_type_id (TREE_TYPE (fndecl));
> +  if (targetm.kcfi.emit_type_id)
> +    targetm.kcfi.emit_type_id (asm_file, type_id, fndecl);
> +  else
> +    fprintf (asm_file, "\t.word\t0x%08x\n", type_id);
> +
> +  /* Mark end of __cfi_ symbol and emit size directive.  */
> +  std::string cfi_end_label =3D std::string (".Lcfi_func_end_") + fname;
> +  ASM_OUTPUT_LABEL (asm_file, cfi_end_label.c_str ());
> +
> +  ASM_OUTPUT_MEASURED_SIZE (asm_file, cfi_symbol_name.c_str ());
> +}
> +
> +namespace {
> +
> +/* IPA pass for KCFI type ID setting - runs once per compilation unit.  =
*/
> +
> +const pass_data pass_data_ipa_kcfi =3D
> +{
> +  SIMPLE_IPA_PASS, /* type */
> +  "ipa_kcfi", /* name */
> +  OPTGROUP_NONE, /* optinfo_flags */
> +  TV_IPA_OPT, /* tv_id */
> +  0, /* properties_required */
> +  0, /* properties_provided */
> +  0, /* properties_destroyed */
> +  0, /* todo_flags_start */
> +  0, /* todo_flags_finish */
> +};
> +
> +/* Set KCFI type_ids for all usable function types in compilation unit.
> +   Processes all functions in the current compilation unit and caches th=
eir
> +   KCFI type identifiers.  Returns 0 on completion.  */
> +
> +static unsigned int
> +ipa_kcfi_execute (void)
> +{
> +  struct cgraph_node *node;
> +
> +  /* Prepare global KCFI alignment NOPs calculation once for all functio=
ns.  */
> +  kcfi_prepare_alignment_nops ();
> +
> +  /* Process all functions - both local and external.  */
> +  FOR_EACH_FUNCTION (node)
> +    {
> +      tree fndecl =3D node->decl;
> +
> +      /* Skip all non-NORMAL builtins (MD, FRONTEND) entirely.
> + For NORMAL builtins, skip those that lack an implicit
> + implementation (closest way to distinguishing DEF_LIB_BUILTIN
> + from others).  E.g. we need to have typeids for memset().  */
> +      if (fndecl_built_in_p (fndecl))
> + {
> +  if (DECL_BUILT_IN_CLASS (fndecl) !=3D BUILT_IN_NORMAL)
> +    continue;
> +  if (!builtin_decl_implicit_p (DECL_FUNCTION_CODE (fndecl)))
> +    continue;
> + }
> +
> +      /* Cache the type_id in the function type.  */
> +      kcfi_get_type_id (TREE_TYPE (fndecl));
> +    }
> +
> +  return 0;
> +}
> +
> +class pass_ipa_kcfi : public simple_ipa_opt_pass
> +{
> +public:
> +  pass_ipa_kcfi (gcc::context *ctxt)
> +    : simple_ipa_opt_pass (pass_data_ipa_kcfi, ctxt)
> +  {}
> +
> +  bool gate (function *) final override
> +  {
> +    return sanitize_flags_p (SANITIZE_KCFI);
> +  }
> +
> +  unsigned int execute (function *) final override
> +  {
> +    return ipa_kcfi_execute ();
> +  }
> +
> +}; /* class pass_ipa_kcfi */
> +
> +} /* anon namespace */
> +
> +simple_ipa_opt_pass *
> +make_pass_ipa_kcfi (gcc::context *ctxt)
> +{
> +  return new pass_ipa_kcfi (ctxt);
> +}
> diff --git a/gcc/doc/extend.texi b/gcc/doc/extend.texi
> index 465ca3b0acfc..b92eae159672 100644
> --- a/gcc/doc/extend.texi
> +++ b/gcc/doc/extend.texi
> @@ -2752,6 +2752,44 @@ void __attribute__ ((no_sanitize ("alignment,objec=
t-size")))
> g () @{ /* @r{Do something.} */; @}
> @end smallexample
>=20
> +When @code{no_sanitize("kcfi")} is applied to a function, it disables
> +the generation of Kernel Control Flow Integrity (KCFI) instrumentation
> +for indirect function calls within that function.  This means that
> +indirect calls in the marked function will not be checked against the
> +target function's type signature.
> +
> +However, the function itself will still receive a KCFI preamble (type
> +identifier) when compiled with @option{-fsanitize=3Dkcfi}, allowing it t=
o
> +be safely called indirectly from other functions that do perform KCFI
> +checks.  In other words, @code{no_sanitize("kcfi")} affects outgoing
> +calls from the function, not incoming calls to the function.
> +
> +@smallexample
> +void __attribute__ ((no_sanitize ("kcfi")))
> +trusted_function(void (*callback)(int))
> +@{
> +  /* This indirect call will NOT be instrumented with KCFI checks */
> +  callback(42);
> +@}
> +
> +void regular_function(void (*callback)(int))
> +@{
> +  /* This indirect call WILL be instrumented with KCFI checks */
> +  callback(42);
> +@}
> +@end smallexample
> +
> +This attribute is primarily used in kernel code for special contexts suc=
h
> +as BPF JIT trampolines or other low-level code where KCFI instrumentatio=
n
> +might interfere with the intended operation.  The attribute survives
> +inlining to ensure that @code{no_sanitize("kcfi")} functions do not gene=
rate
> +KCFI checks even when inlined into a function that otherwise performs KC=
FI
> +checks.
> +
> +Note: To disable KCFI preamble generation for functions so that they may
> +explicitly not be called indirectly, use the @code{nocf_check} function
> +attribute instead.
> +
> @cindex @code{no_sanitize_address} function attribute
> @item no_sanitize_address
> @itemx no_address_safety_analysis
> @@ -3124,6 +3162,10 @@ instrumentation on all functions that are part of =
the instrumentation
> framework with the attribute @code{patchable_function_entry (0)}
> to prevent recursion.
>=20
> +This attribute cannot be used with @option{-fsanitize=3Dkcfi} because KC=
FI
> +callsites cannot know about function-specific patchable entry settings o=
n
> +a preamble in a different translation unit.
> +
> @cindex @code{pure} function attribute
> @cindex functions that have no side effects
> @item pure
> diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
> index b40fc892fa0d..1497ceda482b 100644
> --- a/gcc/doc/invoke.texi
> +++ b/gcc/doc/invoke.texi
> @@ -18457,6 +18457,39 @@ possible by specifying the command-line options
> @option{--param hwasan-instrument-allocas=3D1} respectively. Using a rand=
om frame
> tag is not implemented for kernel instrumentation.
>=20
> +@opindex fsanitize=3Dkcfi
> +@item -fsanitize=3Dkcfi
> +Enable Kernel Control Flow Integrity (KCFI), a lightweight control
> +flow integrity mechanism designed for operating system kernels.
> +KCFI instruments indirect function calls to verify that the target
> +function has the expected type signature at runtime.  Each function
> +receives a unique type identifier computed from a hash of its function
> +prototype (including parameter types and return type).  Before each
> +indirect call, the implementation inserts a check to verify that the
> +target function's type identifier matches the expected identifier
> +for the call site, issuing a trap instruction if a mismatch is detected.
> +This provides forward-edge control flow protection against attacks that
> +attempt to redirect indirect calls to unintended targets.
> +
> +The implementation adds minimal runtime overhead and does not require
> +runtime library support, making it suitable for kernel environments.
> +The type identifier is placed before the function entry point,
> +allowing runtime verification without additional metadata structures,
> +and without changing the entry points of the target functions.
> +
> +KCFI is intended primarily for kernel code and may not be suitable
> +for user-space applications that rely on techniques incompatible
> +with strict type checking of indirect calls.
> +
> +Note that KCFI is incompatible with function-specific
> +@code{patchable_function_entry} attributes because KCFI call sites
> +cannot know about function-specific patchable entry settings in differen=
t
> +translation units.  Only the global @option{-fpatchable-function-entry}
> +command-line option is supported with KCFI.
> +
> +Use @option{-fdump-ipa-kcfi-details} to examine the computed type identi=
fier
> +hashes and their corresponding mangled type strings during compilation.
> +
> @opindex fsanitize=3Dpointer-compare
> @item -fsanitize=3Dpointer-compare
> Instrument comparison operation (<, <=3D, >, >=3D) with pointer operands.
> diff --git a/gcc/doc/tm.texi b/gcc/doc/tm.texi
> index fd208f53844a..d05bf0f208f9 100644
> --- a/gcc/doc/tm.texi
> +++ b/gcc/doc/tm.texi
> @@ -3175,6 +3175,7 @@ This describes the stack layout and calling convent=
ions.
> * Tail Calls::
> * Shrink-wrapping separate components::
> * Stack Smashing Protection::
> +* Kernel Control Flow Integrity::
> * Miscellaneous Register Hooks::
> @end menu
>=20
> @@ -5441,6 +5442,37 @@ should be allocated from heap memory and consumers=
 should release them.
> The result will be pruned to cases with PREFIX if not NULL.
> @end deftypefn
>=20
> +@node Kernel Control Flow Integrity
> +@subsection Kernel Control Flow Integrity
> +@cindex kernel control flow integrity
> +@cindex KCFI
> +
> +@deftypefn {Target Hook} bool TARGET_KCFI_SUPPORTED (void)
> +Return true if the target supports Kernel Control Flow Integrity (KCFI).
> +This hook indicates whether the target has implemented the necessary RTL
> +patterns and infrastructure to support KCFI instrumentation.  The defaul=
t
> +implementation returns false.
> +@end deftypefn
> +
> +@deftypefn {Target Hook} uint32_t TARGET_KCFI_MASK_TYPE_ID (uint32_t @va=
r{type_id})
> +Apply architecture-specific masking to KCFI type ID.  This hook allows
> +targets to apply bit masks or other transformations to the computed KCFI
> +type identifier to match the target's specific requirements.  The defaul=
t
> +implementation returns the type ID unchanged.
> +@end deftypefn
> +
> +@deftypefn {Target Hook} int TARGET_KCFI_EMIT_TYPE_ID (FILE *@var{file},=
 uint32_t @var{type_id}, tree @var{fndecl})
> +Emit architecture-specific type ID instruction for KCFI preambles
> +and return the size of the instruction in bytes.
> +@var{file} is the assembly output stream and @var{type_id} is the KCFI
> +type identifier to emit.  If @var{file} is NULL, skip emission and only
> +return the size.  If not overridden, the default fallback emits a
> +@code{.word} directive with the type ID and returns 4 bytes.  Targets ca=
n
> +override this to emit different instruction sequences and return their
> +corresponding sizes.  @var{fndecl} is the function declaration, which
> +targets can use to compute architecture-specific arity or other properti=
es.
> +@end deftypefn
> +
> @node Miscellaneous Register Hooks
> @subsection Miscellaneous register hooks
> @cindex miscellaneous register hooks
> diff --git a/gcc/Makefile.in b/gcc/Makefile.in
> index c0c7b2ebdacb..92ee0eb528b9 100644
> --- a/gcc/Makefile.in
> +++ b/gcc/Makefile.in
> @@ -1601,6 +1601,7 @@ OBJS =3D \
> ira-lives.o \
> jump.o \
> kcfi-typeinfo.o \
> + kcfi.o \
> langhooks.o \
> late-combine.o \
> lcm.o \
> diff --git a/gcc/flag-types.h b/gcc/flag-types.h
> index 44a90becb27a..5f9ea6a6d7b3 100644
> --- a/gcc/flag-types.h
> +++ b/gcc/flag-types.h
> @@ -338,6 +338,8 @@ enum sanitize_code {
>   SANITIZE_KERNEL_HWADDRESS =3D 1UL << 30,
>   /* Shadow Call Stack.  */
>   SANITIZE_SHADOW_CALL_STACK =3D 1UL << 31,
> +  /* KCFI (Kernel Control Flow Integrity) */
> +  SANITIZE_KCFI =3D 1ULL << 32,
>   SANITIZE_SHIFT =3D SANITIZE_SHIFT_BASE | SANITIZE_SHIFT_EXPONENT,
>   SANITIZE_UNDEFINED =3D SANITIZE_SHIFT | SANITIZE_DIVIDE | SANITIZE_UNRE=
ACHABLE
>       | SANITIZE_VLA | SANITIZE_NULL | SANITIZE_RETURN
> diff --git a/gcc/gimple.h b/gcc/gimple.h
> index 0356bc52a5ba..5931e5403ad8 100644
> --- a/gcc/gimple.h
> +++ b/gcc/gimple.h
> @@ -142,6 +142,7 @@ enum gf_mask {
>     GF_CALL_ALLOCA_FOR_VAR =3D 1 << 5,
>     GF_CALL_INTERNAL =3D 1 << 6,
>     GF_CALL_CTRL_ALTERING       =3D 1 << 7,
> +    GF_CALL_INLINED_FROM_KCFI_NOSANTIZE =3D 1 << 8,
>     GF_CALL_MUST_TAIL_CALL =3D 1 << 9,
>     GF_CALL_BY_DESCRIPTOR =3D 1 << 10,
>     GF_CALL_NOCF_CHECK =3D 1 << 11,
> @@ -3487,6 +3488,27 @@ gimple_call_from_thunk_p (gcall *s)
>   return (s->subcode & GF_CALL_FROM_THUNK) !=3D 0;
> }
>=20
> +/* If INLINED_FROM_KCFI_NOSANTIZE_P is true, mark GIMPLE_CALL S as being
> +   inlined from a function with no_sanitize("kcfi").  */
> +
> +inline void
> +gimple_call_set_inlined_from_kcfi_nosantize (gcall *s,
> +     bool inlined_from_kcfi_nosantize_p)
> +{
> +  if (inlined_from_kcfi_nosantize_p)
> +    s->subcode |=3D GF_CALL_INLINED_FROM_KCFI_NOSANTIZE;
> +  else
> +    s->subcode &=3D ~GF_CALL_INLINED_FROM_KCFI_NOSANTIZE;
> +}
> +
> +/* Return true if GIMPLE_CALL S was inlined from a function with
> +   no_sanitize("kcfi").  */
> +
> +inline bool
> +gimple_call_inlined_from_kcfi_nosantize_p (const gcall *s)
> +{
> +  return (s->subcode & GF_CALL_INLINED_FROM_KCFI_NOSANTIZE) !=3D 0;
> +}
>=20
> /* If FROM_NEW_OR_DELETE_P is true, mark GIMPLE_CALL S as being a call
>    to operator new or delete created from a new or delete expression.  */
> diff --git a/gcc/tree-pass.h b/gcc/tree-pass.h
> index 410341d47119..60d20176dc76 100644
> --- a/gcc/tree-pass.h
> +++ b/gcc/tree-pass.h
> @@ -543,6 +543,7 @@ extern ipa_opt_pass_d *make_pass_ipa_odr (gcc::contex=
t *ctxt);
> extern ipa_opt_pass_d *make_pass_ipa_reference (gcc::context *ctxt);
> extern ipa_opt_pass_d *make_pass_ipa_pure_const (gcc::context *ctxt);
> extern simple_ipa_opt_pass *make_pass_ipa_pta (gcc::context *ctxt);
> +extern simple_ipa_opt_pass *make_pass_ipa_kcfi (gcc::context *ctxt);
> extern simple_ipa_opt_pass *make_pass_ipa_tm (gcc::context *ctxt);
> extern simple_ipa_opt_pass *make_pass_target_clone (gcc::context *ctxt);
> extern simple_ipa_opt_pass *make_pass_dispatcher_calls (gcc::context *ctx=
t);
> diff --git a/gcc/c-family/c-attribs.cc b/gcc/c-family/c-attribs.cc
> index 8ca767abbeba..3711996983c7 100644
> --- a/gcc/c-family/c-attribs.cc
> +++ b/gcc/c-family/c-attribs.cc
> @@ -48,6 +48,7 @@ along with GCC; see the file COPYING3.  If not see
> #include "gimplify.h"
> #include "tree-pretty-print.h"
> #include "gcc-rich-location.h"
> +#include "asan.h"
> #include "gcc-urlifier.h"
> #include "attr-callback.h"
>=20
> @@ -1767,8 +1768,11 @@ handle_nocf_check_attribute (tree *node, tree name=
,
>       warning (OPT_Wattributes, "%qE attribute ignored", name);
>       *no_add_attrs =3D true;
>     }
> -  else if (!(flag_cf_protection & CF_BRANCH))
> +  else if (!(flag_cf_protection & CF_BRANCH)
> +   && !(flag_sanitize & SANITIZE_KCFI))
>     {
> +      /* Allow it with -fsanitize=3Dkcfi, but leave this warning alone
> + to avoid confusion over this weird corner case.  */
>       warning (OPT_Wattributes, "%qE attribute ignored. Use "
> "%<-fcf-protection%> option to enable it",
> name);
> @@ -6649,6 +6653,17 @@ static tree
> handle_patchable_function_entry_attribute (tree *, tree name, tree args,
>   int, bool *no_add_attrs)
> {
> +  /* Function-specific patchable_function_entry attribute is incompatibl=
e
> +     with KCFI because KCFI callsites cannot know about function-specifi=
c
> +     patchable entry settings on a preamble in a different translation
> +     unit.  */
> +  if (sanitize_flags_p (SANITIZE_KCFI))
> +    {
> +      error ("%qE attribute cannot be used with %<-fsanitize=3Dkcfi%>", =
name);
> +      *no_add_attrs =3D true;
> +      return NULL_TREE;
> +    }
> +
>   for (; args; args =3D TREE_CHAIN (args))
>     {
>       tree val =3D TREE_VALUE (args);
> diff --git a/gcc/df-scan.cc b/gcc/df-scan.cc
> index 1e4c6a2a4fb5..2be5e60786a3 100644
> --- a/gcc/df-scan.cc
> +++ b/gcc/df-scan.cc
> @@ -2851,6 +2851,13 @@ df_uses_record (class df_collection_rec *collectio=
n_rec,
>       /* If we're clobbering a REG then we have a def so ignore.  */
>       return;
>=20
> +    case KCFI:
> +      /* KCFI wraps other RTL - process the wrapped RTL.  */
> +      df_uses_record (collection_rec, &XEXP (x, 0), ref_type, bb, insn_i=
nfo,
> +      flags);
> +      /* The type ID operand (XEXP (x, 1)) doesn't contain register uses=
.  */
> +      return;
> +
>     case MEM:
>       df_uses_record (collection_rec,
>      &XEXP (x, 0), DF_REF_REG_MEM_LOAD,
> diff --git a/gcc/doc/tm.texi.in b/gcc/doc/tm.texi.in
> index 14315dd50805..a476f675cb79 100644
> --- a/gcc/doc/tm.texi.in
> +++ b/gcc/doc/tm.texi.in
> @@ -2442,6 +2442,7 @@ This describes the stack layout and calling convent=
ions.
> * Tail Calls::
> * Shrink-wrapping separate components::
> * Stack Smashing Protection::
> +* Kernel Control Flow Integrity::
> * Miscellaneous Register Hooks::
> @end menu
>=20
> @@ -3816,6 +3817,17 @@ generic code.
>=20
> @hook TARGET_GET_VALID_OPTION_VALUES
>=20
> +@node Kernel Control Flow Integrity
> +@subsection Kernel Control Flow Integrity
> +@cindex kernel control flow integrity
> +@cindex KCFI
> +
> +@hook TARGET_KCFI_SUPPORTED
> +
> +@hook TARGET_KCFI_MASK_TYPE_ID
> +
> +@hook TARGET_KCFI_EMIT_TYPE_ID
> +
> @node Miscellaneous Register Hooks
> @subsection Miscellaneous register hooks
> @cindex miscellaneous register hooks
> diff --git a/gcc/final.cc b/gcc/final.cc
> index afcb0bb9efbc..7f6aa9f9e480 100644
> --- a/gcc/final.cc
> +++ b/gcc/final.cc
> @@ -2094,6 +2094,9 @@ call_from_call_insn (const rtx_call_insn *insn)
> case SET:
>  x =3D XEXP (x, 1);
>  break;
> + case KCFI:
> +  x =3D XEXP (x, 0);
> +  break;
> }
>     }
>   return x;
> diff --git a/gcc/opts.cc b/gcc/opts.cc
> index 21ac6b566e0b..dddc77ce42e1 100644
> --- a/gcc/opts.cc
> +++ b/gcc/opts.cc
> @@ -2183,6 +2183,7 @@ const struct sanitizer_opts_s sanitizer_opts[] =3D
>   SANITIZER_OPT (pointer-overflow, SANITIZE_POINTER_OVERFLOW, true, true)=
,
>   SANITIZER_OPT (builtin, SANITIZE_BUILTIN, true, true),
>   SANITIZER_OPT (shadow-call-stack, SANITIZE_SHADOW_CALL_STACK, false, fa=
lse),
> +  SANITIZER_OPT (kcfi, SANITIZE_KCFI, false, true),
>   SANITIZER_OPT (all, ~sanitize_code_type (0), true, true),
> #undef SANITIZER_OPT
>   { NULL, sanitize_code_type (0), 0UL, false, false }
> diff --git a/gcc/passes.cc b/gcc/passes.cc
> index a33c8d924a52..4c6ceac740ff 100644
> --- a/gcc/passes.cc
> +++ b/gcc/passes.cc
> @@ -63,6 +63,7 @@ along with GCC; see the file COPYING3.  If not see
> #include "diagnostic-core.h" /* for fnotice */
> #include "stringpool.h"
> #include "attribs.h"
> +#include "kcfi.h"
>=20
> /* Reserved TODOs */
> #define TODO_verify_il (1u << 31)
> diff --git a/gcc/passes.def b/gcc/passes.def
> index fac04cd86c7d..3d17873d76da 100644
> --- a/gcc/passes.def
> +++ b/gcc/passes.def
> @@ -52,6 +52,7 @@ along with GCC; see the file COPYING3.  If not see
>   NEXT_PASS (pass_ipa_auto_profile_offline);
>   NEXT_PASS (pass_ipa_free_lang_data);
>   NEXT_PASS (pass_ipa_function_and_variable_visibility);
> +  NEXT_PASS (pass_ipa_kcfi);
>   NEXT_PASS (pass_ipa_strub_mode);
>   NEXT_PASS (pass_build_ssa_passes);
>   PUSH_INSERT_PASSES_WITHIN (pass_build_ssa_passes)
> diff --git a/gcc/rtl.def b/gcc/rtl.def
> index 15ae7d10fcc1..af643d187b95 100644
> --- a/gcc/rtl.def
> +++ b/gcc/rtl.def
> @@ -318,6 +318,12 @@ DEF_RTL_EXPR(CLOBBER, "clobber", "e", RTX_EXTRA)
>=20
> DEF_RTL_EXPR(CALL, "call", "ee", RTX_EXTRA)
>=20
> +/* KCFI wrapper for call expressions.
> +   Operand 0 is the call expression.
> +   Operand 1 is the KCFI type ID (const_int).  */
> +
> +DEF_RTL_EXPR(KCFI, "kcfi", "ee", RTX_EXTRA)
> +
> /* Return from a subroutine.  */
>=20
> DEF_RTL_EXPR(RETURN, "return", "", RTX_EXTRA)
> diff --git a/gcc/rtlanal.cc b/gcc/rtlanal.cc
> index 63a1d08c46cf..5016fe93ccac 100644
> --- a/gcc/rtlanal.cc
> +++ b/gcc/rtlanal.cc
> @@ -1177,6 +1177,11 @@ reg_referenced_p (const_rtx x, const_rtx body)
>     case IF_THEN_ELSE:
>       return reg_overlap_mentioned_p (x, body);
>=20
> +    case KCFI:
> +      /* For KCFI wrapper, check both the wrapped call and the type ID. =
 */
> +      return (reg_overlap_mentioned_p (x, XEXP (body, 0))
> +      || reg_overlap_mentioned_p (x, XEXP (body, 1)));
> +
>     case TRAP_IF:
>       return reg_overlap_mentioned_p (x, TRAP_CONDITION (body));
>=20
> diff --git a/gcc/target.def b/gcc/target.def
> index f288329ffcab..d7f2f08ff32b 100644
> --- a/gcc/target.def
> +++ b/gcc/target.def
> @@ -7649,6 +7649,45 @@ DEFHOOKPOD
> The default value is NULL.",
>  const char *, NULL)
>=20
> +/* Kernel Control Flow Integrity (KCFI) hooks.  */
> +#undef HOOK_PREFIX
> +#define HOOK_PREFIX "TARGET_KCFI_"
> +HOOK_VECTOR (TARGET_KCFI, kcfi)
> +
> +DEFHOOK
> +(supported,
> + "Return true if the target supports Kernel Control Flow Integrity (KCFI=
).\n\
> +This hook indicates whether the target has implemented the necessary RTL=
\n\
> +patterns and infrastructure to support KCFI instrumentation.  The defaul=
t\n\
> +implementation returns false.",
> + bool, (void),
> + hook_bool_void_false)
> +
> +DEFHOOK
> +(mask_type_id,
> + "Apply architecture-specific masking to KCFI type ID.  This hook allows=
\n\
> +targets to apply bit masks or other transformations to the computed KCFI=
\n\
> +type identifier to match the target's specific requirements.  The defaul=
t\n\
> +implementation returns the type ID unchanged.",
> + uint32_t, (uint32_t type_id),
> + NULL)
> +
> +DEFHOOK
> +(emit_type_id,
> + "Emit architecture-specific type ID instruction for KCFI preambles\n\
> +and return the size of the instruction in bytes.\n\
> +@var{file} is the assembly output stream and @var{type_id} is the KCFI\n=
\
> +type identifier to emit.  If @var{file} is NULL, skip emission and only\=
n\
> +return the size.  If not overridden, the default fallback emits a\n\
> +@code{.word} directive with the type ID and returns 4 bytes.  Targets ca=
n\n\
> +override this to emit different instruction sequences and return their\n=
\
> +corresponding sizes.  @var{fndecl} is the function declaration, which\n\
> +targets can use to compute architecture-specific arity or other properti=
es.",
> + int, (FILE *file, uint32_t type_id, tree fndecl),
> + NULL)
> +
> +HOOK_VECTOR_END (kcfi)
> +
> /* Close the 'struct gcc_target' definition.  */
> HOOK_VECTOR_END (C90_EMPTY_HACK)
>=20
> diff --git a/gcc/toplev.cc b/gcc/toplev.cc
> index d26467450e37..f48cfeb050aa 100644
> --- a/gcc/toplev.cc
> +++ b/gcc/toplev.cc
> @@ -67,6 +67,7 @@ along with GCC; see the file COPYING3.  If not see
> #include "attribs.h"
> #include "asan.h"
> #include "tsan.h"
> +#include "kcfi.h"
> #include "plugin.h"
> #include "context.h"
> #include "pass_manager.h"
> @@ -1739,6 +1740,15 @@ process_options ()
>  "requires %<-fno-exceptions%>");
>     }
>=20
> +  if (flag_sanitize & SANITIZE_KCFI)
> +    {
> +      if (!targetm.kcfi.supported ())
> + sorry ("%<-fsanitize=3Dkcfi%> not supported by this target");
> +
> +      if (!lang_GNU_C ())
> + sorry ("%<-fsanitize=3Dkcfi%> is only supported for C");
> +    }
> +
>   HOST_WIDE_INT patch_area_size, patch_area_start;
>   parse_and_check_patch_area (flag_patchable_function_entry, false,
>      &patch_area_size, &patch_area_start);
> diff --git a/gcc/tree-inline.cc b/gcc/tree-inline.cc
> index 7fecf487af73..37eca44a5008 100644
> --- a/gcc/tree-inline.cc
> +++ b/gcc/tree-inline.cc
> @@ -2110,6 +2110,16 @@ copy_bb (copy_body_data *id, basic_block bb,
>  /* Advance iterator now before stmt is moved to seq_gsi.  */
>  gsi_next (&stmts_gsi);
>=20
> +  /* If inlining from a function with no_sanitize("kcfi"), mark any
> +     call statements in the inlined body with the flag so they skip
> +     KCFI instrumentation.  */
> +  if (is_gimple_call (stmt)
> +      && !sanitize_flags_p (SANITIZE_KCFI, id->src_fn))
> +    {
> +      gcall *call =3D as_a <gcall *> (stmt);
> +      gimple_call_set_inlined_from_kcfi_nosantize (call, true);
> +    }
> +
>  if (gimple_nop_p (stmt))
>      continue;
>=20
> diff --git a/gcc/varasm.cc b/gcc/varasm.cc
> index 0d78f5b384fb..d4e9e2373c6c 100644
> --- a/gcc/varasm.cc
> +++ b/gcc/varasm.cc
> @@ -57,6 +57,7 @@ along with GCC; see the file COPYING3.  If not see
> #include "attribs.h"
> #include "asan.h"
> #include "rtl-iter.h"
> +#include "kcfi.h"
> #include "file-prefix-map.h" /* remap_debug_filename()  */
> #include "alloc-pool.h"
> #include "toplev.h"
> @@ -2199,6 +2200,10 @@ assemble_start_function (tree decl, const char *fn=
name)
>   unsigned short patch_area_size =3D crtl->patch_area_size;
>   unsigned short patch_area_entry =3D crtl->patch_area_entry;
>=20
> +  /* Emit KCFI preamble before any patchable areas.  */
> +  if (flag_sanitize & SANITIZE_KCFI)
> +    kcfi_emit_preamble (asm_out_file, decl, fnname);
> +
>   /* Emit the patching area before the entry label, if any.  */
>   if (patch_area_entry > 0)
>     targetm.asm_out.print_patchable_function_entry (asm_out_file,
> @@ -2767,6 +2772,9 @@ assemble_external_real (tree decl)
>       /* Some systems do require some output.  */
>       SYMBOL_REF_USED (XEXP (rtl, 0)) =3D 1;
>       ASM_OUTPUT_EXTERNAL (asm_out_file, decl, XSTR (XEXP (rtl, 0), 0));
> +
> +      if (flag_sanitize & SANITIZE_KCFI)
> + kcfi_emit_typeid_symbol (asm_out_file, decl);
>     }
> }
> #endif
> @@ -7283,16 +7291,25 @@ default_elf_asm_named_section (const char *name, =
unsigned int flags,
> fprintf (asm_out_file, ",%d", flags & SECTION_ENTSIZE);
>       if (flags & SECTION_LINK_ORDER)
> {
> -  /* For now, only section "__patchable_function_entries"
> -     adopts flag SECTION_LINK_ORDER, internal label LPFE*
> -     was emitted in default_print_patchable_function_entry,
> -     just place it here for linked_to section.  */
> -  gcc_assert (!strcmp (name, "__patchable_function_entries"));
> -  fprintf (asm_out_file, ",");
> -  char buf[256];
> -  ASM_GENERATE_INTERNAL_LABEL (buf, "LPFE",
> -       current_function_funcdef_no);
> -  assemble_name_raw (asm_out_file, buf);
> +  if (!strcmp (name, "__patchable_function_entries"))
> +    {
> +      /* For patchable function entries, internal label LPFE*
> + was emitted in default_print_patchable_function_entry,
> + just place it here for linked_to section.  */
> +      fprintf (asm_out_file, ",");
> +      char buf[256];
> +      ASM_GENERATE_INTERNAL_LABEL (buf, "LPFE",
> +   current_function_funcdef_no);
> +      assemble_name_raw (asm_out_file, buf);
> +    }
> +  else if (!strcmp (name, ".kcfi_traps"))
> +    {
> +      /* KCFI traps section links to .text section.  */
> +      fprintf (asm_out_file, ",.text");
> +    }
> +  else
> +    internal_error ("unexpected use of %<SECTION_LINK_ORDER%> by section=
 %qs",
> +    name);
> }
>       if (HAVE_COMDAT_GROUP && (flags & SECTION_LINKONCE))
> {
> --=20
> 2.34.1
>=20

