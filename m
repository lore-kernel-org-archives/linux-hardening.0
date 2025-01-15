Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E29624A7C1;
	Wed, 15 Jan 2025 19:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736970415; cv=fail; b=IlsWVWcKhGGk9hyuEVX/s2Hj8bOC+r90Xwffx1hN7A8m7e7Vr/Z+nV1dmkn1YdXyKosnQAiWYQh2zEmla6K9ztdr/dn5B+HVTf4pIupJV7XOh3hVZMkgZCLYL7ktMxya26b9sxMXiFN4gUwEA6oDsa6sjfNqexWF40sD56/B6JI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736970415; c=relaxed/simple;
	bh=XRuypOJfaj3Z5dtRJx/fbEc4a7Xtl75exrrAExEKlA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dZd7t60Hm/U8Mf+rlEFHFeOGO4X4WVBs1RFI8nUwxx4fhvLpthwajvym8XrnGubkaGdrxGOQc19UnI1UEjm5RDowF7lWeJB0sxxiJ2m+CZZIOQ4ArJcNJ2QqIivgNjs6jdUmYJwiaRjIsyh26jd+c0fb2+Y7EDGkF+07PqjQeng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ESa41X2q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SyR9hdL6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ESa41X2q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SyR9hdL6"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHti3q025332;
	Wed, 15 Jan 2025 19:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=glQPACV7md5Z8u0PhH
	j5dzTs6fKSAQuq9J+b/UeIJvs=; b=ESa41X2qfI5Ff7PjmZEMRJaEgi3MVlyCsX
	Gn3/3rUbTENA1URknBt/GCaKjLIUNLAreMDksIL9NcTIu1MEaRPtGGxs28yII1CE
	BeotEdEixb3LThyWUvo3EI5UVS6WsX7nArUht0tvQp16ZBc4kEjXF9jtIqXPrlWW
	JV//9W949paT1Ca5wczIc8fUcckGB3q9t/biAtRPYD/v0xQ9/TojcQWeSlrrbs7h
	uf1r5ZPtPvR4Xf0nCwLa0sB1pHD86G0JCW1iSkbe3Rmf0QlgAac/WKVqAHs3HcUO
	YpOkWgkFsBDGbqvew2bLNepj9MuzOTHK56tBf0RPdAKMBZOVyY7g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443gpcs149-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 19:46:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50FI0a7d020356;
	Wed, 15 Jan 2025 19:46:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 443f3g7nd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 19:46:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIGlYQ/QZgglekEtpF3Ej/C5wfbXPdL33wQdL4OAWVEYW/9E9vSCVibBPYy8fGnpPmCOXX/prLxY0qznnfrzvYdYZl4Houf6wA+JsSYREb0DJ6FYBmsRRet+sBOYhrcg7JXpo1kNAb6L8YiUnGLfmMMXLuKjALYTAq7wqXxwobCntF4xIEIXEYiaPEKsnuje8VDjspI8wKo6bL1oEqzm8Mh7PFXyXdcz3Dg7jHFaCSvA5ozH/AB1bAr/ucntDj8MfTpCKZ+X5jOsRUNRR3My/MD0aUZyIXyASUEjaPDgZegZfDeRgWog23JPuwN1oNdyU/Jt4yt1layUH0hxW+rwiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glQPACV7md5Z8u0PhHj5dzTs6fKSAQuq9J+b/UeIJvs=;
 b=NdBxKzrNovzmtbyvX0DRpV+L07qc7n7m5UKRfno5coVlBmmvJp2nwY3H7UBe0Nsncjgqz0PK3109DtY6Af/ari8uShAdHEtudm5FcdKXiTKTJYJA+pJJRexW2gkc59SwfCopTszGOpzLii8EuqgJVpax7HskwNNQc3/O6t7HhJ0tdqyuKuOX7BLv39zGt9a+3QKodGI5IgzYmOEzWZpHljIhI8kixz60EXcfssXFMFhHhRF2f2SQnd2JC9HTlAWTYdshjrsDDc/r+2XodnQM+fD/bKSDH95cVs0dMO+cXPV3jDyjSwfujMGMYj73bqZ3gcLEK9qENO4d6EMU1HsNbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glQPACV7md5Z8u0PhHj5dzTs6fKSAQuq9J+b/UeIJvs=;
 b=SyR9hdL680IIuKf4Z0ddHYdXhLzUCCPpr9HHDdMYfUwGE82YsDJQfbzQuG4V2Z4TOV22cqxzBikIv9/sgnJUdGRcflYVkqGZH3QJSc2apcPadypUpYQPqVvTBbOwciwHeQu+pSCivSVKhxDSqD+SCCkETXJRrNCrzHljR70xGWs=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA2PR10MB4794.namprd10.prod.outlook.com (2603:10b6:806:113::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.19; Wed, 15 Jan
 2025 19:46:05 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 19:46:05 +0000
Date: Wed, 15 Jan 2025 19:46:00 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Kees Cook <kees@kernel.org>, akpm@linux-foundation.org, jannh@google.com,
        torvalds@linux-foundation.org, adhemerval.zanella@linaro.org,
        oleg@redhat.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        jorgelo@chromium.org, sroettger@google.com, ojeda@kernel.org,
        adobriyan@gmail.com, anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
        rdunlap@infradead.org, davem@davemloft.net, hch@lst.de,
        peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com,
        gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
        ardb@kernel.org, Liam.Howlett@oracle.com, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org,
        mpe@ellerman.id.au, Vlastimil Babka <vbabka@suse.cz>,
        Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <0x7f454c46@gmail.com>,
        Mike Rapoport <mike.rapoport@gmail.com>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Benjamin Berg <benjamin@sipsolutions.net>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
Message-ID: <5cf1601b-70c3-45bb-81ef-416d89c415c2@lucifer.local>
References: <20241125202021.3684919-1-jeffxu@google.com>
 <20241125202021.3684919-2-jeffxu@google.com>
 <202412171248.409B10D@keescook>
 <a0a3b26b-2222-478c-a1cb-56514ec8d6ff@lucifer.local>
 <202501061647.6C8F34CB1A@keescook>
 <CABi2SkUfAoCbsknnXnyoFbCPOFRahDx+Vqz3ohnyf_G1p4eszA@mail.gmail.com>
 <CABi2SkXS9OOwP2BZGQOa=Pn+NoL1VmOJBJEn-6tWBBQwLtpYiw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABi2SkXS9OOwP2BZGQOa=Pn+NoL1VmOJBJEn-6tWBBQwLtpYiw@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0567.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::20) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA2PR10MB4794:EE_
X-MS-Office365-Filtering-Correlation-Id: 188f5bd7-e9f5-4772-513d-08dd359d3fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DZ5ZZVSJS1B3UKcFTKpCh41Jnd+CtuTSQNbRW0ESBW2ASmr7DwM5MKnaLkA4?=
 =?us-ascii?Q?yxgThc8XF+c28pm0c2EmZIeJi/RGDgHbOyFjnYMiyKyzcw+k4Ig6jCnxPVAN?=
 =?us-ascii?Q?Li7xXH5KZACVQTyTMP92Sgzj8IUZLDyt14ImFO2rEAKj5y1xsWrWm1A0lFy1?=
 =?us-ascii?Q?QTHUI1vHknszJ+Lcp5AIKu7SFtv5SkdjX11F00Etuy6RtB5I0YeT3gTdBzeq?=
 =?us-ascii?Q?EXlxZb+QjOU/Gdc41ykZNpdSRj1L2SoSk+gbT5rgR8RVwFKyZGNwyKMR1vm7?=
 =?us-ascii?Q?qhxKoViiYAqDYZs48jdVPO8Z1+miEMYUJuIRs1BHNSugSaX4Hn9v072HnYEA?=
 =?us-ascii?Q?KfjS3S+6ByJwizZ8UZIGzWOIHfTCwKluTJeOXx+0Bx4soHGOt2HUqnTfNo6I?=
 =?us-ascii?Q?E7OcpmV+Ey5vebMiZocwvYkXc1G9pj169+vEAUppkA6reY0bgioSMe1Xx2Sc?=
 =?us-ascii?Q?WjIe1wTYEjKKR7+1QhDLEWQ5DkZidg5HBW3LhfntBkEGA+tjtTsHhu8NSIlV?=
 =?us-ascii?Q?Gn1T9QNzoWCHzU3TxpfcFy3Y/3AJ0SDCzCm8fVznzo+HWwhxZn3CMVfakUwb?=
 =?us-ascii?Q?bFE8h7Pd78tkRLOoGCX9YkmSMnjKvxp1IV8P3Pc2Bq0K9r7O3XxDe3VzbQfn?=
 =?us-ascii?Q?fWkj2B6jKiuBLg7eCx4kSPsZivQzGy579efPYDQ/MDpuMGLpy49By5MByRMe?=
 =?us-ascii?Q?fWciWSZfGQj3M9soLJOIj8gn/K8WzYucGBbdedz+OC9rEzvm09gX329KTBm5?=
 =?us-ascii?Q?IaP9TlmhCBtP3Biw6He+rwl9hGGejbjty5DM90rg9plb9cvf+19TAoExE5m/?=
 =?us-ascii?Q?jV3Haj5J1xPuQHIl93o30ZYfW+wIy+YTifG+SOkuvkq1xbjGeNosllIQARY4?=
 =?us-ascii?Q?Bt488HCOebn3eWnCPoPuoUPsYi/E/PmOt1eZ3srJAQFQ87qpQsylFpu9b8x7?=
 =?us-ascii?Q?nGF4/e/MBmEtkYBM8jn0P+CpGSjFZ1pAv5nA4j70ps8Ky1VH59Oc2GTfv0vk?=
 =?us-ascii?Q?HPCo4efQyLVUAp3c45iuPxAlMYlaO092pRxh2rulQnKao3H5M+EaFfEvnMU6?=
 =?us-ascii?Q?3nYjNT5V8L0akAn8AbADle097luDkbF/eT9Qhg9dWxT6MvMeDsbY4IOkSldy?=
 =?us-ascii?Q?oWKrpxX7vOnHLFOZfafw4ANW8TkChjkz5JtReK0K+8yWJBxRcuJ6ouYvaNQF?=
 =?us-ascii?Q?j/EvyWdLdpUQwspu5Sq0SBuCcthSS1m50jdrsbiN9s6Kf15towkAMAxnnVGc?=
 =?us-ascii?Q?aJhLbnJ2HDsoT7ox3+NpIIUclUWJXInX+/HqmkGM5Hg2X0vY2Av7ARLoQfQE?=
 =?us-ascii?Q?Ry0b2SiAcgF3MjUIjYSRIdKYeSXuoaoGQn1CLEiWnEsYIOxx8z6VljDGo1/G?=
 =?us-ascii?Q?mXybn5xFxGiszYqz5uFnT6NHUptg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dc2k6h6qTJlMHh1ojcIRzqlQWgtxvRX6d1uImLoO2jXquwJdvXrw/Zr8kwQr?=
 =?us-ascii?Q?Tle+xOzZ/m8cHPfWJSMwQMSUhS9W6bhFILN4GElBv/MdTDIl6g6tHFoTJKQS?=
 =?us-ascii?Q?rpU+uHdqkoq3s+MUiBF7yuz7rBvsLVD/pCW/hyLRb/QLWYm0uCcQHQ/veAB4?=
 =?us-ascii?Q?juaUX9lqD68Ya8g4XpvTtKr/BDpyFzwakRLcx7rHtmvK0AQ36ijtKfUfQU6A?=
 =?us-ascii?Q?8lRXQl/IXmqXRyf2pUeJRP01bIstjLLvD/4/awqF0Z5nzqQREHSrvCY4CCR9?=
 =?us-ascii?Q?XR13oLHfG7dOiqpvNbaltQ/JgbYBa5IAgXdzgaUtt+mpz3b3r7kd8tDctAjZ?=
 =?us-ascii?Q?qux2aah8hNzGaZSTZLDAFySSwTwNcBJ6PcUpmDeng2/eyGleOM+IcUdAwlW4?=
 =?us-ascii?Q?iDWcpt7h731GnqyvfYgY9isoBVff7Rr8cWH0XjnRZwEdt5it3Hg78KWFUxvR?=
 =?us-ascii?Q?JwsnR/sjoG9z4V8Q2Iwzhj+0REXj0rvBt4eKMQDZ7BLz15CbH6dIBHYJiu5n?=
 =?us-ascii?Q?wVYiLb1mYa2Cs5MH1jzG8LkIv0YMrKsKkhrb37IOGh+w3mnjhvymwDh2yJHF?=
 =?us-ascii?Q?uEdLn+Hy03IajUl2G7VxoWdH+UEC79pdRHv/W7Wr7n6604Q6IOyBSjjRd4H4?=
 =?us-ascii?Q?RsrNnkgwcbLKgVFAM3FpCO5MV8wBsvmmNpQypC33FcxKLS3MAmUkpe78D6Ex?=
 =?us-ascii?Q?xOHOIw52KsFefRLhFlQkGMfz+4uAOjp+QHoqBjhOAquCZXb0aIny9zUxF974?=
 =?us-ascii?Q?EkrSrp9gqLLbq6gwjWzIG7i0F3i/KJfvNaLJz7b7vMbuhRyEMaDIGbYMqziI?=
 =?us-ascii?Q?mxEu/PeNsyE9wduQPfFBdAuvIiROcyTdLOqajTf430HTpDOvt7ZXCpcp09q+?=
 =?us-ascii?Q?Ky0QgRXQt3EIDRAhyTbcT3GqmkMF2e65mfjr8RLRVazqedmEhHlO6IGotUld?=
 =?us-ascii?Q?nRmuSWzjxxDcLrcIiOmqv/gMj6B+yo2ecP8I76dd27VGYm5GDUt9h63cT5+W?=
 =?us-ascii?Q?e3IicAKmWLBq1GkpVo/IyO6CmhSryjE6xc0Xq9r6rTcwV5wx7oLs5POmU9v7?=
 =?us-ascii?Q?lpB+UaaJ8sHyw/A8h0frQk4ZKHX0prtxhiCpNWQ4tTnd6UCj9r4RY8+6tB6L?=
 =?us-ascii?Q?mK21S/3egN4DiIJgyUKVEVhGoqJgcawCc2Fk5cH1cKOrLPjXhf4tKflQFY9Q?=
 =?us-ascii?Q?ibjvzMHWe9IZ5U7GmP7JKgh4Wo2Vs2oJRBDuzQE7QJLPu8CvsLZwJdPgGqUK?=
 =?us-ascii?Q?cwVJauSuv1xMG5rpsh9zIGWGAs3SR0JFygG42YBqWFpkVGHuwgaMeIfHQNRn?=
 =?us-ascii?Q?VgITyFTuBy1FG2swClC79aorEd8cS8TUYAhIWYsUW7CB7dQMmsHI/5Ppp4gB?=
 =?us-ascii?Q?aBeRdviQd8m9d8ocE7jPgWVuRIPu66mwseaxgPuINsox8sP712u7E/untk0H?=
 =?us-ascii?Q?loTgQ8HSp7LpAUHf6j7nX0pVhCUQ//Vt2qWIm8GGaV/14Nb0mUtq9hh8pgLl?=
 =?us-ascii?Q?B809b8uBbEsuct+VLQHlnHbX+xGKqiDLJkiPWH55N0XZB+dTjKKnLagr1N41?=
 =?us-ascii?Q?nXovpqk/epNDxR2Qs75QJR0Rsm0//2/TrcI60GYhZIFE7tfcTwYM4aFLXLEQ?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vtTSXs5V4nB+5wo+5we+/58kz6uc1diVjihnUgB3FUUzrTGi4MkMZJetvQtIAIuKNEjk65aJPk2OU87iCo9smQL+omXuDbDSYjnH6C37I9KDl+DniKVthlRDBOFzVstFLjJAR46akkeU4Rt/kTqjXYcHZDXSWXo/e7nSm0ZsjPm7Jqn/CK226FLJMVU3cNRWcsP8VspCqv04/WPLmnkgC8BiyUAQUAescB94DbcyvZZo1X+Vj7CjzttLekZITj7OLdQc9cE4e/Ni48fPhBZGtWGQpLrIOiS53AcKcJEOgpmcXIbdr1GcqPawncnjL+kmJyeKDUq025GMphMCWg0v7IvunyfEuZA4NAyBppe/8S6oYbiJQ8hJQTkgG53kAd/9jytwhm5bHoxCJkR6NeG2QlthYRS9G0xel7MLFAVfa4QWZlF16sjVdAhy3SiE/kWDVEewEfcvZPHwamU6kmP7Hv8IVpB5RAMZlCBp+s25/09OtozVxfkEWrBX81FdPTSRMd0cKe8bUcHHWtLPPY+ia1uC+IMZAsff+NyWQ3tMi5Hf4ZQbj86bmMAof8l4UDtVa/ZHTGtyRB1WnMuOrPpBGSa6sS0CV8JsKpLndF/4+qU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 188f5bd7-e9f5-4772-513d-08dd359d3fc4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 19:46:05.3888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UaZ/vhBApw8hsP8T478mWfQqYLsn6PfG9K6RTmnsqw9cHGiIOUY4LtL7Lle/mVt4asFxc/vrzLUvH8gy1LH/re6JWbLC2IzdfLntN5EO54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4794
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_09,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501150143
X-Proofpoint-GUID: wOTqDEeGtEwCqRKKExDfENUqdf4Hmzfx
X-Proofpoint-ORIG-GUID: wOTqDEeGtEwCqRKKExDfENUqdf4Hmzfx

Jeff,

My name is Lorenzo, not Lorenze.

I've made it abundantly clear that this (NACKed) series cannot allow the
kernel to be in a broken state even if a user sets flags to do so.

This is because users might lack context to make this decision and
incorrectly do so, and now we ship a known-broken kernel.

You are now suggesting disabling the !CRIU requirement. Which violates my
_requirements_ (not optional features).

You seem to be saying you're pushing an internal feature on upstream and
only care about internal use cases, this is not how upstream works, as
Matthew alludes to.

I have told you that my requirements are:

1. You cannot allow a user to set config or boot options to have a
   broken kernel configuration.

2. You must provide evidence that the arches you claim work with this,
   actually do.

You seem to have eliminated that from your summary as if the very thing
that makes this series NACKed were not pertinent.

if you do not address these correctly, I will simply have to reject your v5
too and it'll waste everybody's time. I _genuinely_ don't want to have to
do this.

Any solution MUST fulfil these requirements. I also want to see v5 as an
RFC honestly at this stage, since it seems we are VERY MUCH in a discussion
phase rather than a patch phase at this time.

I really want to help you improve mseal and get things upstream, but I
can't ignore my duty to ensure that the kernel remains stable and we don't
hand kernel users (overly huge) footguns. I hate to be negative, but this
is why I am pushing back so much here.

Thanks!
