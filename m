Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC671C3C11;
	Fri,  3 Jan 2025 20:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735937394; cv=fail; b=HAd/udPAGn3qnXfccUVkhSSuAEIK2uwtyx0xAj9e3Y3ymLxUPHVRsLbwauT6xIxic8c7nk/dN9o7bAsuTBFiOSbuiN4+TZt/ila+K0B7JOC7V2jL8+yT455/LHUtuTM+0AUXmMtKOrBxRn8/KRzX/pB/Y1hj+MpedOjOVmy9kbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735937394; c=relaxed/simple;
	bh=nlfgmOEzxuIxJ+NzM50pHSxxrqi6UHb13SP0LeyU8qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dtz2PdsD9q9weO2V+7Oxkj4vXvY+gYbbuCQvAaBJqjioRYEpWMtwI3BDAUQF6rY61So7E+9L16hZbkrl+MFZHnFsWVOwDqSlu4AdTzJVUP8ehU9l04sk3Rwx6wkIL9oxzOA4MyuKziANyNgUj1vOPGVafdY8A6QXTRz0nS9EyDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oK+v/mOS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kCwxQF/x; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oK+v/mOS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kCwxQF/x"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 503Id4Kv025249;
	Fri, 3 Jan 2025 20:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=qKTgg798HzRFOIvgZS
	+qPpBUXieZ/jjNvpvGejtvbS8=; b=oK+v/mOSAzgYywuLAB8dvUnAE12Ql7Wkxs
	3N9knv6BofZ04RyB1YeXBq/apMmsXXuHYd8glKpvblixt9f5USk6SOWzgsPk7pJJ
	MQWwtCL2Us5pVBiNLi3BN6Xm9QGfhuocVccDXtIutwF407Q4gceOJfKFH39YasVT
	21YL0gxMrs/ebTwO6BYqqVaFsMSkNJUG/5nCfAo9GBd29v2y7xZqRKCNi21VsQX8
	e+pf43S7WaQ2aL1dTaZyvK4iuUBwwN20Auz2M37xKMk9BMnps2cfQt5e873piwiZ
	fdQ0yRnDi/rKQkUi55bjLwbKsvGpiRwBNW5UWGpOgP74cth+XEpw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43wrb8bnqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 20:48:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 503KOdp0012901;
	Fri, 3 Jan 2025 20:48:37 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7sa2314-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 20:48:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DY/OBzHp4FfZaVQVu5LrwrceU1Ezmrvoa3K2KcOVA969nP2xO6sG48jRnbFZSGNX8IJ5PEroufsDw/1AOznVYAodj0hXdLR+XduU1Zn2Yf6hLq2omwh3a3t/gaGq5na3/yIUXlUDRZI/8SXVRI7VZnd/oiAHVJOLzyrLr9n5d5nTm5vj8V/cpxwot7TxcMP1DkQAD8FCSZPDx65Fjp+sVW1opgVjC90jfQI757ju5QnDZ1g2Kotp2SF+UG4ZHAE88sxRb2QI3VzYZ74Yih2Dprvz6LjXzY4wPaYLG/k7JhgsaHaOUmCrlnI35wO7R3SwW4CLBbiNXMUtFuG8AtFvFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKTgg798HzRFOIvgZS+qPpBUXieZ/jjNvpvGejtvbS8=;
 b=TO8ju46I7R17qoYLcnIm1An9bxwYjOpZuqAhqWTS1n8wySTlMCSLgnWkoin1wm3hRFxU/3J2ZYvkx6zQfUabdRp+dA7NLn7cgpHxDphZ2MCmjK0B9bITef9lMbRc/wu0DDUoK3+CutTbcWYfx1BIuWqcb1lMY9A8mh6C7/yoB4aepKNx10L4WG1ufLG+GiOrO66mT0UTiTBPQGdZbeiDpMgENnNvzVkS7PXYxUJQZReULeya31wss2SllX8AQ3QhJR1gRcmwJO9l8/TBd2HyXf4RTwIN3WIonr/MPs0tv13axbJPUkumtNiAGtXvIxJ2uZtstF3Xn6unNbNxuBiIfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKTgg798HzRFOIvgZS+qPpBUXieZ/jjNvpvGejtvbS8=;
 b=kCwxQF/xs5qUdDXkkUjtbRF3q7GMETQuOZ/j2kaA9tLszd1NyuK7uNyjBoSPiN2oDcL5vlDSdMIWwH3OlLX9+1Bzrx5yfpFR87hXUg+F3AGBd3k3fna86ofv6xT2fcreeqXMClvuGiFLG+A46eRecy/U7bKdssBj+uZGM9n2vK8=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by MN2PR10MB4255.namprd10.prod.outlook.com (2603:10b6:208:1d2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 20:48:29 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 20:48:29 +0000
Date: Fri, 3 Jan 2025 15:48:23 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Kees Cook <kees@kernel.org>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org,
        jannh@google.com, torvalds@linux-foundation.org,
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
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <0x7f454c46@gmail.com>,
        Mike Rapoport <mike.rapoport@gmail.com>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
Message-ID: <htdv44tqzi4jl2b7dwutsdwnh4tgrxq6xdvumi5wwu3hnh7sgw@tfwlal74ukx6>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Kees Cook <kees@kernel.org>, jeffxu@chromium.org, akpm@linux-foundation.org, 
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
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <0x7f454c46@gmail.com>, 
	Mike Rapoport <mike.rapoport@gmail.com>, Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
References: <20241125202021.3684919-1-jeffxu@google.com>
 <20241125202021.3684919-2-jeffxu@google.com>
 <202412171248.409B10D@keescook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202412171248.409B10D@keescook>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0471.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::22) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|MN2PR10MB4255:EE_
X-MS-Office365-Filtering-Correlation-Id: b3fe8888-9da2-4e66-d34d-08dd2c37fa83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?efsNNNMQadLJE79yTGjAnTiOUcxReL3iaT/VnJqep160bHdho7Fy9w91MW4B?=
 =?us-ascii?Q?I5PV23G3MWBWPJgdTYs8qiq8YDq66mYB78uBOfBL2KnKkr/IqrXN1Ggm2BKB?=
 =?us-ascii?Q?2X0kweSZI0//jlt8FDokjmK3F8D0+fg3KXIKHT+rsBnZhbj7kpDGZvhnS9oo?=
 =?us-ascii?Q?cE+m2Z98tklfdXwpCzoObQwc6/Q4lTAUhME0rlos29H/x0aP84dH4Ic+4FAB?=
 =?us-ascii?Q?9y4M8qv4KKuISHvEhcej11ipuYw8bZOur8Bsko6BxLg6HY9Cf3BzZ2TSlG2F?=
 =?us-ascii?Q?gp9AFG+zit0b739eni8bjQCHdKrmOveU1kiaIEB+cLYFhMGwsOb69zUyqaRQ?=
 =?us-ascii?Q?kFaTNZ/7Lxr8UzbWBorojxK0kycQneEj10A4dAHOmIc/LJZ1IQRFZZerM0QF?=
 =?us-ascii?Q?npu78CMY70Cz5q2qz2KwbZiQEUP6C3/FGhGGbmdqrqT8V0oag2Tec+/9YFfe?=
 =?us-ascii?Q?4K7zEXSHFbdDKOxvt3sh2XooytlJPQfXYtZHByLQ+SFuy7wpucBj81xogFtU?=
 =?us-ascii?Q?FgvNE+hktgqBKzvWBsSPCboL5ANCawTzxx+Pto8l9wNBeZuhZwLck32KhG66?=
 =?us-ascii?Q?cgL6mEUE0lOL/EE977NJEQ93ydPUGuXkM0mphy2/MaheDO9NhTrSDNkAGNvu?=
 =?us-ascii?Q?ZEOmpqj5tjcu3nAdSg2O6vZ4MSx17kEt7yyW/HbDAXLQtSmzNd+koZ9GqmE0?=
 =?us-ascii?Q?dAKRmQebm7M2aWTSMUzvStwyYDAyzdHPSzXBvwEN2znqHHY5oVSM6bizx6JU?=
 =?us-ascii?Q?iQWuYAMKzxEQuwHqSV/VwbaXL1ky1NJXy8Bn1zoMiCA9PSPy4V1WYvMkiOmG?=
 =?us-ascii?Q?L1Lki7o79Y1WNszuMVjYSN3JNw2NFVbwRqtrR6BKJnSULSyh3on1seS7FVJ9?=
 =?us-ascii?Q?4vLilQ+Dr3C2S5V6RJejfSO55tdGZbKnoNZRbJ3qBaW/OX+FQ3Kd7oy0HRzZ?=
 =?us-ascii?Q?mcmUYoonR3YEArCXNTuqb4EoQcBU684Ysh+1L5ub3zCnyWE9NYGDK2YiT70e?=
 =?us-ascii?Q?EHPFDH5wbqE0Kq6N++pHqE/1cG9XRe+I9ZituBMnAz4nicKEfRRMAIKex1qI?=
 =?us-ascii?Q?rfM8FvusJY2WhDooY8em8FtolLMiIodAmYYs04YWm8iRnFbfTcyvmsTwekIP?=
 =?us-ascii?Q?aZs+gSVPUyb8xtb4fdJCT3hWbGczarvZY8EcEMQfMX8d5WyprrCBEiii82yj?=
 =?us-ascii?Q?ciUEvUgZg6/7jmTgXMAeWtW5oYYcC6gJ5/mHkx7YbD4N2YrGyj0iV8vAZHZe?=
 =?us-ascii?Q?qVFL5TryeyGtwaovk782sQrbgs3bVOvWgifPVPpbzS7e9h2lfmokoSrdKMoz?=
 =?us-ascii?Q?lLkXA2EaIM7W5sHIDHyhVRjNzMfIuM68bCuP039DehPik479busavNvw0BGw?=
 =?us-ascii?Q?XnH7+fowwQ14bZUKZ81khoQPgItj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7xFIGLTQEQt9zRe8VyH9t8X1jKOvb6MKDaKwmN0CrJXljiwGroCRwLStm6v0?=
 =?us-ascii?Q?Zw3dDB0+q3zU1q4sUfGv4agQQVYa0BXU5y28x2RXVncySWeKWpHxdPfQihwn?=
 =?us-ascii?Q?J/c15F1unZqqoBY8yrTEkXPt9JrVkEpIQN48laiukWAK2YhkEmY+9pYnI8cZ?=
 =?us-ascii?Q?WPxLR3TpUzOuvsp+hwsdAMLYF5E5CvNxyFRjxBwldHneU9kTg1Q46nq11/DL?=
 =?us-ascii?Q?bi1mC3WJUhUkXS3yAiw3D91AqjK5W799cqYZtrfWbgschsxg53XCwdYCD8nE?=
 =?us-ascii?Q?Ly2AdJRpV+v5i186dg50wIZZRGmhRv6yK746Lr0lg8A9Ouv6jJ9Hqu6RZcdI?=
 =?us-ascii?Q?uJnvjcvcs8xdR0BsVjmaah80kkuar2n0yiyvgkJHsgYH/kDQC4VD2h8pqPPu?=
 =?us-ascii?Q?sV4kjcHukE/mZ3LMCwP+HbDbpV2t6XUhJZ56u7oYng1/2q9Zpa5etVqJfuiC?=
 =?us-ascii?Q?1p7eouLewE7sDHNrZKfFCMUZCGmDqWk/RmJ7zflxx8O7I0VNnlcuNCSn8GGu?=
 =?us-ascii?Q?RxwcCgUbCyjWWINaBtLmFl8UuhZ0q21Ve1U2u+Ti8USS+z3F2fhQQpcTuQeJ?=
 =?us-ascii?Q?hHWknJZZ9RQFLkQZ1sYTsTHDh/yNfc+TntnTKgdli+X/NHSr6Tfux9+xIMWM?=
 =?us-ascii?Q?rYtuQVpjoXYibFpBKrDsHf3NDCPEeN+bddWfHbC71CcxeikaZzGdy8Cdfiee?=
 =?us-ascii?Q?F6+9mqfvQUNFCVxD7DQJCkLmpIi/mf/+MOe6cPwpahYSmFvwCDHM1Ldr1rQf?=
 =?us-ascii?Q?EmwNiD0QeZDO64OWSZBao0nxdCvi4lClDp6bXF3HsgXuPOB9ksNw5ljCQly6?=
 =?us-ascii?Q?oFLLfIspOJJ1325oCtGA849X8jmYa2GVEyybi+TjRR8bwvDdBGtAnfr18sn+?=
 =?us-ascii?Q?4bgqMjCL3/1uGLMAyjzeUqt3LlTciaYQTO04ex6dXBHeEQZbKxFiTNTAuOgc?=
 =?us-ascii?Q?gB9afbD+w3g1Wqavebkq2kQ/MgFANp0USatJG+5H2J96ANYFoLgqYHtELLnA?=
 =?us-ascii?Q?8pVTfZk9ur4bGqARKC1qWEBV1FJ5UHIKDlnDDiB7Lzr8Zl3c1qasdi74y2hm?=
 =?us-ascii?Q?yK39Bv3cXU40sowq9OmwbPANgrnw6+VagNfj1gAFx6wcg1KP/7VU5ua4q133?=
 =?us-ascii?Q?qpociKvfph4Lq/j1eH/55eaAXhyyMzA9pGHQT9nYkui2G816O1zzOmckD4qq?=
 =?us-ascii?Q?Ih9Cy0D5EAoKpyTyG1cAlhBqwYMAzwsGra9cq+4a98pSdvhup4aVhaM+N6sO?=
 =?us-ascii?Q?mHIwXJKhAwNS0JBS4kWJyjYglgqsRqH4MSkMFdJWY2FQUuRFHDfBYykArlFp?=
 =?us-ascii?Q?ia4GwjS5SWjzNSMSRuUB807VASJCm659VMzV/Gu1zjJ38KWFXo9ojYJT4oCK?=
 =?us-ascii?Q?dCKamftDAo+C3YFk37HVk1gxrDoU2zx7KDGQl+h/T+5FdBHmuiDNdGkjE6I6?=
 =?us-ascii?Q?lBQZup6QBHIAvZTfJ1X0r7MAWsCjeszicBpmtDHIYyFDg4UpcqfdegyDUyeZ?=
 =?us-ascii?Q?zrHRdqQjLSXefDJVrwITsx77RAp2kQ0/FgelG8mpE7iadyVReLCMPk8X/aaA?=
 =?us-ascii?Q?T2dBufZ2pIY+yDZfpg8ZdEfHs/9B+W8juzD1wGy2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wBZ8Yp9B9/bFnSMLZ5V1dU5V9vUCfXLg2ym+4UFeqrA3WBdym9ZSws2tjNSu4KgRYrY1ZLGVCs9wGLXFSlMsVK8Km3bwvpYw8SgcR2DtsVqax5kHahLvcnhzcinPEtQkMlX2JoVw+2jGQ0AkRUc9pDRtboFqM2iHqh25f2q+KLgn9OBQIfB6pUWGBAXtEDUkHYXMVMR1zhs92GVknfjkVqcxzt8odKv5M4p89X/jas5/yz+vjWlvyGEChBUdLapz1cuOQBj3C0UmF1CNkUCG4t4P/yZDcrWkAYssDbI4QVauj+kULMiqIPBeaXj114M4KcMC1chKk086br+eEuCStpNzilhR4vhhZI7G5ut+QRfsdqrtJQEG2M9gtRGOi2I6u7LSBqVg78Gcp2hu4NwokEhvdsayytpwHFFNLWnfrS4Jzbx4QDeYoiJRFYOszSVu2EVqT7FQ+Krb4Sxeholq1rSW4nO7jp9S8NAdCy/tX20ycfOpcqwIFsr5CyGeH2vTB+ePKWk1OThn9opUcmHYho5uYc8EI7P9mDB0SgMLp9B8Km/OPYaz+9D5puxSBSxZdnC9ccxc9OtRKynImdBLhsXaOfmQ+rTRlUcD/bM70LY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3fe8888-9da2-4e66-d34d-08dd2c37fa83
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 20:48:29.6762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5iSGb6VUHj1RhiQQWXvgzZiE2lY+Eaocj7zeX/lwNh2uMSgmhhONHgRNLpnhXYRK6s1fEmunUEHHfLlNdUz16w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4255
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501030184
X-Proofpoint-GUID: Fc9B4rpa7O8FTgLFdKjiGiftocxkLy5Z
X-Proofpoint-ORIG-GUID: Fc9B4rpa7O8FTgLFdKjiGiftocxkLy5Z

* Kees Cook <kees@kernel.org> [241217 17:19]:
> On Mon, Nov 25, 2024 at 08:20:21PM +0000, jeffxu@chromium.org wrote:
> > Seal vdso, vvar, sigpage, uprobes and vsyscall.
> > 
> > Those mappings are readonly or executable only, sealing can protect
> > them from ever changing or unmapped during the life time of the process.
> > For complete descriptions of memory sealing, please see mseal.rst [1].
> > 
> > System mappings such as vdso, vvar, and sigpage (for arm) are
> > generated by the kernel during program initialization, and are
> > sealed after creation.
> > [...]
> >  
> > +	exec.seal_system_mappings = [KNL]
> > +			Format: { no | yes }
> > +			Seal system mappings: vdso, vvar, sigpage, vsyscall,
> > +			uprobe.
> > +			- 'no':  do not seal system mappings.
> > +			- 'yes': seal system mappings.
> > +			This overrides CONFIG_SEAL_SYSTEM_MAPPINGS=(y/n)
> > +			If not specified or invalid, default is the value set by
> > +			CONFIG_SEAL_SYSTEM_MAPPINGS.
> > +			This option has no effect if CONFIG_64BIT=n
> 
> I know there is a v5 coming, but I wanted to give my thoughts to help
> shape it based on the current discussion threads.
> 
> The callers of _install_special_mapping() cover what is mentioned here.
> The vdso is very common (arm, arm64, csky, hexagon, loongarch, mips,
> parisc, powerpc, riscv, s390, sh, sparc, x86, um). For those with vdso,
> some also have vvar (arm, arm64, loongarch, mips, powerpc, riscv, s390,
> sparc, x86). After that, I see a few extra things, in addition to
> sigpage and uprobes as mentioned already in the patch:
> 
> arm sigpage
> arm64 compat vectors (what is this for arm?)
> arm64 compat sigreturn (what is this for arm?)
> nios2 kuser helpers
> uprobes
> 
> As mentioned in the patch, there is also the x86_64 vsyscall mapping which
> eludes a regular grep since it's not using _install_special_mapping() :)
> 
> So I guess the question is: can we mseal all of these universally under
> a common knob? Do the different uses mean we need finer granularity of
> knob, and do different architectures need flexibility here too? The
> patch handles the arch question with CONFIG_ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> (which I think will be renamed with s/SEAL/MSEAL/ if I am following the
> threads). This seems a good solution to me. My question is
> about if sigpage, vectors, and sigreturn can also be included? (It seems
> like the answer is "yes", but I didn't see mention of the arm64 compat
> mappings.)
> 
> Linus has expressed the desire that security features be available by
> default if they don't break existing userspace and that they be compiled
> in if possible (rather than be behind a CONFIG) so that code paths are
> being exercised to gain the most exposure to finding bugs. To that end,
> it's best to have a kernel command line to control it if it isn't safe
> to have always enabled. This is how we've handled _many_ features so that
> the code is built into the kernel, but that end users (e.g. distro users)
> can enable/disable a feature without rebuilding the entire kernel.
> 
> For a "built into the kernel but default disabled unless enabled at boot
> time" example see:
> 
> config RANDOMIZE_KSTACK_OFFSET
>         bool "Support for randomizing kernel stack offset on syscall entry" if EXPERT
>         default y
>         depends on HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
> ...
> config RANDOMIZE_KSTACK_OFFSET_DEFAULT
>         bool "Default state of kernel stack offset randomization"
>         depends on RANDOMIZE_KSTACK_OFFSET
> ...
> #ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
> DEFINE_STATIC_KEY_MAYBE_RO(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
>                            randomize_kstack_offset);
> ...
> early_param("randomize_kstack_offset", early_randomize_kstack_offset);
> 
> 
> For an example of the older "not built into the kernel but when built in
> can be turned off at boot time" that predated Linus's recommendation see:
> 
> config HARDENED_USERCOPY
>         bool "Harden memory copies between kernel and userspace"
> ...
> static DEFINE_STATIC_KEY_FALSE_RO(bypass_usercopy_checks);
> ...
> __setup("hardened_usercopy=", parse_hardened_usercopy);
> 
> (This should arguably be "default y" in the kernel these days, but
> whatever.)
> 
> So, if we want to have a CONFIG_MSEAL_SYSTEM_MAPPINGS at all, it should
> be "default y" since we have the ...ARCH_HAS... config already, and then
> add a CONFIG_MSEAL_SYSTEM_MAPPINGS_DEFAULT that is off by default (since
> we expect there may be userspace impact) and tie _that_ to the kernel
> command-line so that end users can use it, or system builders can enable
> CONFIG_MSEAL_SYSTEM_MAPPINGS_DEFAULT.

So we have at least two userspace uses that this will breaks: checkpoint
restore and now gVisor, but who knows what else?  How many config
options before we decide this can't be just on by default?

We're also veering off what mimmutable does in bsd, for no good reason.
At what point do we decide that it's not worth pushing this?

I agree that security (and everything else) should be turned on (or
default to on) for everyone, when it doesn't break things for users.  I
think this isn't one of those at this point - it's breaking things by
changing the behaviour.

And we really don't understand what it will impact fully - considering
v4 is still resulting in new things that will be broken.

Thanks,
Liam
