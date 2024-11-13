Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C67189F45;
	Wed, 13 Nov 2024 20:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731530886; cv=fail; b=nWTM6lcTQtcJYMKAwO6muzPUtyYpfzpTt/+E0BRtdDgbSIUdpoFcmSghAING0nnbrGDsdnJR2VYCjyAr6wHUDaAV1RvIFZZlpQ20H2Q8yoPd8IXTs6YmycbisC3E9zg2UaFZHceVZn+fDmC7Nz2sS4+PTkWRHOmNjM2M0R0hmZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731530886; c=relaxed/simple;
	bh=mF3Tq9OUM7Eg71iF4g/M0HEt8Ln4MGQUShW/PCQvZq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tW8J07Rj/Ts3cOmb0p9jZbnpdmYjHH/n25ERNuikMxPGBOKPzXcrp+zOGQrPdBIYktPEoe0aGZcvBh2hWqBxpUdKfJUb/9Sg7ewJEznMDitlQsZuZFjnKVyaoQTjuEkrkn7Lj3c1AN+tE5EFrCbmuVd05N5u6CcvDNgolBBpMjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gFeC7zuB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ElTm/QRQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gFeC7zuB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ElTm/QRQ"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADIBVgJ006336;
	Wed, 13 Nov 2024 20:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=/VuWMvyDC5hrmi3iGo
	1QrXpe9V9awAPerfyuGU05OFI=; b=gFeC7zuBVFDbvwIYIlRD9ytg0d2wVhy1lp
	FY2mIOARDNJCygX1+FNH77UJ7w2o9dn/zTRpMHUm635UK6tX45QjQggyl3n8twBB
	cTaiPoO7MRGqX+QsHVOjKSjDtuzboz0qGiom7ZuGMnUxJlUmGW1K+rRN/K5FZLlk
	Hx30TKgW1dEEjJy75orLV2kUyKdtN+XENxgnGUAp+AXFuLe2vCZBHNF+JIT1oZ0j
	qbaGw25nRWejZXNS2DLAkT1dVMFd9GupNDLxsl6qrTPctcKsBjRbtNa2DgdBL/DO
	QG6RQr78TpFDkecAKdXoHcs7sJALhqL7xhTCYqPjXkAC4Ugl7CUw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0nwqttw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 20:47:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADJwfmZ001233;
	Wed, 13 Nov 2024 20:47:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6a6hc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 20:47:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzsx1Olss3+Qqp24wE+JcTktbFXi7tcX4/0ze0i4NLLI1DjW4e6WajOhPoyZ2A7KzvibP9QCFNOZ8hbIxVgyYbVAgtnopgGCoRLDxZjKiLvNLiOGd5VYgEYN8I8dYpRmdESJhPoRMz+91lpjE46tonQkURmBFNvks6GDHxUrB/WhkUnrE3VY8KS4/kH7j4PeadX8l+qBsQ20bjePjnXmX9M1OOFegSxdAWhzjGrV9PrqDDvuA1xVUbTB6/ANRWiFPg5cJi1ynUqwbLd+hffzivUXZAU5rvBAHMUCAU1MrRNk1UOkdQQ3s5NrxpC/oYD2nqipBFTgbML8CPWTtSSGPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VuWMvyDC5hrmi3iGo1QrXpe9V9awAPerfyuGU05OFI=;
 b=rgN4Wst1ldoA8kNBdI720iUG4poNFgAqYPvgK2SYsDZFHcJrsC6QqCFdkPOzqpvfsiU87qs9knNmz+Zm4LG+xs0a3XJebUVI98lirBdSxJUl4yKrmPuQWigYSEv3szYVHDnnmyj1ao7CPsSa3MuTcv3VFH8z7vZ1PN9jtL9TmcW257uWsZx4VsRLutBAiTUBwMK/5cqkctAjJCywBq/EuGuSKIFzUIxFtfM741tmEf0WoHEgNBZ7kpfDuGFzLtDj1MlTWmbsh9I3geWdRQq2ofs09NiWgeR3izmsYUp7t+JV4N+JBpB7GUnHNIeATkFf4PzxA/GWc363EghyQfozdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VuWMvyDC5hrmi3iGo1QrXpe9V9awAPerfyuGU05OFI=;
 b=ElTm/QRQHo7sOL9/Nj4kNm09zy69+5wUj+P75DxgDc1aftU7p5yMuzaEIVWo8XdlQDst9vN2qadlWnRlhppsfgNlRgeb5A7Tts1Ileuc5ygxPEy1q1OO6QwLZe5O09Dx/b1VpeOPbFDkAYJL/Er+OlGsHzA9Ijy4+Fr5J0ZUcLQ=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BLAPR10MB5185.namprd10.prod.outlook.com (2603:10b6:208:328::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 20:47:27 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 20:47:27 +0000
Date: Wed, 13 Nov 2024 20:47:23 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: jeffxu@chromium.org
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
        ardb@kernel.org, Liam.Howlett@oracle.com, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org
Subject: Re: [PATCH v3 1/1] exec: seal system mappings
Message-ID: <d3f61d89-77de-42e7-b16b-e5b1031ac8bc@lucifer.local>
References: <20241113191602.3541870-1-jeffxu@google.com>
 <20241113191602.3541870-2-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113191602.3541870-2-jeffxu@google.com>
X-ClientProxiedBy: LO4P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::10) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BLAPR10MB5185:EE_
X-MS-Office365-Filtering-Correlation-Id: ee382097-5631-4e77-9254-08dd04246235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FB2sW+C8ACZWI5ulKX/hfuPG2ZyRnn+FzleyewZiTrQNcyuDS5OhRX6FskKi?=
 =?us-ascii?Q?Z4OD1YFiv/W0k/UlcoJiyX6hs/3/SlWcg3ucdB4V7aYl8/VYit9XE5AiG2KZ?=
 =?us-ascii?Q?DybFS0+M5wpAKj+heFiGoLaJa8m6FVnfxerNkZHjSv4Fxg0YiQWJN8QJqjwe?=
 =?us-ascii?Q?YDWjPYNTI6XMWw2quSAuOGYwssNpARcoadyWiJOSR7clpOLT5RUI5yuKX05o?=
 =?us-ascii?Q?wiZunbM+Vi+6jLTQ6OmE8J6mGN0kth6fuGumASnkHEnOTM43NUG+CMC4+IK/?=
 =?us-ascii?Q?t7Jg7cZvUti5Br6Hjcs1QLfn2mn6iuMDYDPOl8CDk6/NWhinrDKA03YlJ1ai?=
 =?us-ascii?Q?Yl1+Dp04Td/yRalIjrfTfEXhAJRtEn0qHiFkbYFs+bPXV2xTxW8s3zTsi6XQ?=
 =?us-ascii?Q?q95VIKj3CJVQmFl57fAs9lVWJaENdWHQC0ZWzHtbf/qBbsFxJ3hZllUituHi?=
 =?us-ascii?Q?dq3u3TcTHTdUGGSj774BU2dvK2aforwdHzh/bTiHGbQp8oF9W5HO/SJgWRiH?=
 =?us-ascii?Q?HfrQxYPKJQOWhbwYWbqcdzv18xmZQDyVzbxnMj0pb6ymLqo4zkhWuP+Haopq?=
 =?us-ascii?Q?6CN0BJvUlBaFqQH4CLixhvww1U7IsjGtPOPwEKkBdbg/bFzfx3FnYF4tOmL7?=
 =?us-ascii?Q?xPz9lVOud2IKdYCcN/LkMZuax659rNRKEzQMcIrdGey72TMATDhW32rg9yB9?=
 =?us-ascii?Q?Ec2R813/ggSWbHiNF5dgSW/kPyK8+Mc/WZCgH7X3MYo119UsJJAQjwVMJti/?=
 =?us-ascii?Q?OyrbMoFbNWV+WP6pn/uSOQEDHSpT/bNKrSSOYNp/SVZ5Xl1/mZpNQVTWJ6HH?=
 =?us-ascii?Q?G9XnQjJ2kA/kdJyCUF4HAZkZfIq83dsSVefiT5WqgEFNWR7XRpFrH8BXfNT2?=
 =?us-ascii?Q?yuMueJRmuCSUlSizRymdM3N/aGDWYkw8O4SQuYmT+Yj+kFkaUeZAbttIYvjs?=
 =?us-ascii?Q?AAYOVN8++dxAREiUeOpscVo8ULcZHhz+LTjuTex+YV7xjS0hG7JKZtIpPE1T?=
 =?us-ascii?Q?ICAKhn9WEZUcpjCxxKyVCcIiI9SqJnD8mgP1lzodiHEiQ6Q223ywfDP+bbri?=
 =?us-ascii?Q?zgIF7RxI3auA+A+s6lpvD17sXGzR5qDv3+KQdyUiepudLXEDsE1uypbZgviK?=
 =?us-ascii?Q?0+XiFT5L880CitWtHleHlRpDBIt4/R0G6saUuB89GRWMHHa6M6rQmd3mTNFX?=
 =?us-ascii?Q?2pNrVvp0QhwEC+EiNOlDBq2eLB8yf/kKIgaQRaQSPtgSwRm7y+LRSxrAWdwY?=
 =?us-ascii?Q?qzTnbzj7hDZCvfjIWy8k5pDsiwH/NoigWLZW8EckHCOgT2Z48RD/B8waXy8M?=
 =?us-ascii?Q?6uPyaHj7miTMi6y7vorR7ODy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WslGFWiXcOIay9UnsMDmdFFcgdnxuV4fKBRn3ecLNj7k0dJYYsxMuq+uI9gQ?=
 =?us-ascii?Q?r5iX0Li+ujtqR1HLF6JL08G2HcbaQAbQyWBqsNdCmuHIWdM+sv5RX+r3MEtA?=
 =?us-ascii?Q?RDWuG27ymoapA7z2tDYUB6nXnw152GAujUrgBS2V8Mw/1KNyvBE4y8KUlJg3?=
 =?us-ascii?Q?4iJbvt+PtziRR6pFHHcdmpu9+AqYwjnZKI+voR4imtloNVCaB/y3ztZv+2ZB?=
 =?us-ascii?Q?06UBzPdF838GzYeuLDi/XXw4LtoieeKZ8OlbRkQryqLvxs5HhClcGnk6HQ0d?=
 =?us-ascii?Q?3QoAi/tOaRc1ijq/4qAU5cdYDQiox3tmujO33XspvZ291qf4mKu4rHowbor/?=
 =?us-ascii?Q?RnueXswluTB1W4MPI1ezYPpD4oaF5kgzUO1LcnitWiUWoo3dcsVd+DkuiEqf?=
 =?us-ascii?Q?PDTqewgUwTIVY1WFsoVCo7Tc19O5cJynPymFtImeSTYk4fqctYImWAbXYpM5?=
 =?us-ascii?Q?hznHW4+5Fh617j9pjQvUtohqmeb1YlMQaDnUAqq0BiTtGfkW7o/wE02yMmKO?=
 =?us-ascii?Q?OsrNPKQ9b5S6QozyVUqQEnuhxhX0aa/bOQCmDGDsSVcckkLfFjID8y/LJLgx?=
 =?us-ascii?Q?D+w/S/M2nlu7siRhpk9hSh7OI/m0hORjt8x01wlhaYdOhwNMs1OYCiI2iytl?=
 =?us-ascii?Q?numktVIgSbTau6Pi+OfMWTuGyF5OlbJPSmuMkxwhg01wsyp4uafjC1VWg58q?=
 =?us-ascii?Q?/O9Jo+CoCZPJPdn3WUIzAXxJPWZsUs7nGkB2ONfp2l0sUGiJeqC+hBASQSsX?=
 =?us-ascii?Q?FaWwEKazbPUzVN6oZH0RPjlqHlqVI1qHuiAtadtNWDkoleJPxGDz1oaal1zz?=
 =?us-ascii?Q?vHvVXhU3mTDU9l2kPUTGXpPi9AjUtm2cH2UUbWr1zrFkxy1KUcFy0XyZtjix?=
 =?us-ascii?Q?oNJBOCNAEbpDqp4qxkPn5RmyZpyYIbUajJk9z5tmBEtXMmEv16RSvNsaI0p9?=
 =?us-ascii?Q?trBf31Y8xj8iNtsL5e6/xFVtN+v6VLH8aF+8D8mdSGKR5cVHqMMfgScNqRXz?=
 =?us-ascii?Q?bQ/EoC7q3FLHxa0o0GRvu77slZWwqtcCXFHWhCt8iPIShlSF78lJ1cqKycpB?=
 =?us-ascii?Q?Vp4644YIcg/ilmLgIZPOVY9KGdoKoKQL8Ghy2to6MACZSHPxem07lkRUlGi/?=
 =?us-ascii?Q?bAF8ksfwL3HmZ102PKeQMx2eQg01dbsJyQB1JKAmcASGXXQ6tDHK3pGz8HUS?=
 =?us-ascii?Q?2NluMQrsvtmyvG9Rw4qEQa0M5WIOQp3NN9pRdGxV86+fID06QzK3PTqjy4QW?=
 =?us-ascii?Q?C7Ey0s9vUBJIEXEGe7bK+DqA2J4IfQRkCYzU7Kf0Ktmtjm0U9WfkcXgr5IfG?=
 =?us-ascii?Q?BeJbHppmLKK3Ll7zEWXC1stmsyjIoJUiKzKp19EpcP5U7S5Ct52kBG2Uz0iW?=
 =?us-ascii?Q?rHJk0tixfbcSa32ueR5ptV9AlSwBAyzzNv6nruSwwkcXIn8MQrC5M2AQqP6m?=
 =?us-ascii?Q?ijMqvXvTXtT/UziUvG/KF8fiHQ3VdvEZ82szB9LU/1KLFySkTXf0sD47iWA4?=
 =?us-ascii?Q?p5FECaOiX5PeXvEGT/cTLajBZnTPH48in4O/hKr9qtRNCcTxXdK16L5vSJ8X?=
 =?us-ascii?Q?/VjUaXtW6mli/4TeAvF2F5xQaQSKuUlHIARYt3fWNexl482uiB9hx6+0O7E9?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	huO06pzCA2Bzw9ITqfWqmNIyVlSf8TPDbcRTb+A9q7PPSMVnCQTnJc/EAVurmIRbSzwbiqIhmorK5t2fkFfHxCAJTIox9C2EnYzitQVDrBjZSMEQvZ/4uOCAChDZ1vov4Rwo1Zu5sM+MNI9E7CHBOVaZp7Rio9AVtiLC/uoR3sLZ4HetcYTRRpd8uIAX9yaQ0k5d8CnIwwz/kz3DV63pAXDqJmcebk4r3d3OeW4H9odrTwHO5rj7pA/vifUCGgBEid3LMfxXcOim9RqU6MHYn+QKbkp2sqCInDaJCEK4QPpCEV5ntl1hiBVrWsbqkBCiSDXhdjKFwKm9f8Mnan0nu7QjORHNA9p6xuFCIeD2xpoWlZGArl9djtdxu/NHJxSzU/1h6TOJFZwja73L4I7h79S94RDzcS5jKnmo3CWHwmfTEDqdEBB4W2d9i2Y2nqN5PPanL0uKaVzJtKROENVI9dgJQw5+Pdkgt0ZNj2ao6BJQ3ojArXPbT7emjODXr2jDZJlLguV4KLjNbMK6GPslW0EG5ONHsxy0yyvAof/DzGUoaH27+DC+3JPa6+GQtrdn45Ux+wviZSuoCxCz+5TKHfWAAfhlvKISFNDUG6kz3Tg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee382097-5631-4e77-9254-08dd04246235
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 20:47:27.0627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y1AWuzsMtt9IeNdurhivXvpa5kdvBFqHU4qVGrlOAdql2iBwOyw/NsJKUN9MlkN6qWeaeRddM2i5gC3NMOHvQQDpgCQCH+n0q/oKO24NUQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5185
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_13,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411130170
X-Proofpoint-GUID: SLFnEieK6vYp85BHXKvK271XUHoolysY
X-Proofpoint-ORIG-GUID: SLFnEieK6vYp85BHXKvK271XUHoolysY

I'd prefer not to move forward with this until we have confirmation that
adequate testing has been performed, given how invasive this change is,
even if behind a flag (unless we explicitly mention it is untested in the
Kconfig).

We are touching arch-specific stuff with VDSO, VVAR, etc. so we need to be
cautious when we're in effect hooking an arch-specific function in mm.

Other than that, the actual patch isn't too crazy overall.

I think a sensible approach might be to only enable on known-good arches.

On Wed, Nov 13, 2024 at 07:16:02PM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> Seal vdso, vvar, sigpage, uprobes and vsyscall.
>
> Those mappings are readonly or executable only, sealing can protect
> them from ever changing or unmapped during the life time of the process.
> For complete descriptions of memory sealing, please see mseal.rst [1].
>
> System mappings such as vdso, vvar, and sigpage (for arm) are
> generated by the kernel during program initialization, and are
> sealed after creation.
>
> Unlike the aforementioned mappings, the uprobe mapping is not
> established during program startup. However, its lifetime is the same
> as the process's lifetime [1]. It is sealed from creation.
>
> The vdso, vvar, sigpage, and uprobe mappings all invoke the
> _install_special_mapping() function. As no other mappings utilize this
> function, it is logical to incorporate sealing logic within
> _install_special_mapping(). This approach avoids the necessity of
> modifying code across various architecture-specific implementations.
>
> The vsyscall mapping, which has its own initialization function, is
> sealed in the XONLY case, it seems to be the most common and secure
> case of using vsyscall.
>
> It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
> alter the mapping of vdso, vvar, and sigpage during restore
> operations. Consequently, this feature cannot be universally enabled
> across all systems. To address this, a kernel configuration option has
> been introduced to enable or disable this functionality.
>
> [1] Documentation/userspace-api/mseal.rst

It'd be nice to explicitly refer to this in the docs, it's not quite urgent
though would be nice to be part of this series.

> [2] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com/
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  .../admin-guide/kernel-parameters.txt         | 10 +++++
>  arch/x86/entry/vsyscall/vsyscall_64.c         |  9 ++++-
>  include/linux/mm.h                            | 12 ++++++
>  mm/mmap.c                                     | 10 +++++
>  mm/mseal.c                                    | 39 +++++++++++++++++++
>  security/Kconfig                              | 11 ++++++
>  6 files changed, 89 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index e7bfe1bde49e..469a65b3cf50 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1538,6 +1538,16 @@
>  			Permit 'security.evm' to be updated regardless of
>  			current integrity status.
>
> +	exec.seal_system_mappings = [KNL]
> +			Format: { no | yes }
> +			Seal system mappings: vdso, vvar, sigpage, vsyscall,
> +			uprobe.
> +			This overwrites KCONFIG CONFIG_SEAL_SYSTEM_MAPPINGS
> +			- 'no':  do not seal system mappings.
> +			- 'yes': seal system mappings.
> +			If not specified or invalid, default is the KCONFIG value.
> +			This option has no effect if CONFIG_64BIT=n

Or if CONFIG_CHECKPOINT_RESTORE is not set. Please update to reference this
also.

> +
>  	early_page_ext [KNL,EARLY] Enforces page_ext initialization to earlier
>  			stages so cover more early boot allocations.
>  			Please note that as side effect some optimizations
> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
> index 2fb7d53cf333..185553376f39 100644
> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> @@ -366,8 +366,13 @@ void __init map_vsyscall(void)
>  		set_vsyscall_pgtable_user_bits(swapper_pg_dir);
>  	}
>
> -	if (vsyscall_mode == XONLY)
> -		vm_flags_init(&gate_vma, VM_EXEC);
> +	if (vsyscall_mode == XONLY) {
> +		unsigned long vm_flags = VM_EXEC;
> +
> +		vm_flags |= seal_system_mappings();
> +
> +		vm_flags_init(&gate_vma, vm_flags);

Nit: remove weird whitespace above. Also might be worth adding a comment as
to what we're doing here similar to the one in _install_special_mapping().

> +	}
>
>  	BUILD_BUG_ON((unsigned long)__fix_to_virt(VSYSCALL_PAGE) !=
>  		     (unsigned long)VSYSCALL_ADDR);
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index df0a5eac66b7..f787d6c85cbb 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4238,4 +4238,16 @@ int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *st
>  int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
>  int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>
> +#ifdef CONFIG_64BIT
> +/*
> + * return VM_SEALED if seal system mapping is enabled.
> + */
> +unsigned long seal_system_mappings(void);
> +#else
> +static inline unsigned long seal_system_mappings(void)
> +{
> +	return 0;
> +}
> +#endif
> +
>  #endif /* _LINUX_MM_H */
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 57fd5ab2abe7..bc694c555805 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2133,6 +2133,16 @@ struct vm_area_struct *_install_special_mapping(
>  	unsigned long addr, unsigned long len,
>  	unsigned long vm_flags, const struct vm_special_mapping *spec)
>  {
> +	/*
> +	 * At present, all mappings (vdso, vvar, sigpage, and uprobe) that
> +	 * invoke the _install_special_mapping function can be sealed.
> +	 * Therefore, it is logical to call the seal_system_mappings_enabled()
> +	 * function here. In the future, if this is not the case, i.e. if certain
> +	 * mappings cannot be sealed, then it would be necessary to move this
> +	 * check to the calling function.
> +	 */

Nice comment!

> +	vm_flags |= seal_system_mappings();
> +
>  	return __install_special_mapping(mm, addr, len, vm_flags, (void *)spec,
>  					&special_mapping_vmops);
>  }
> diff --git a/mm/mseal.c b/mm/mseal.c
> index ece977bd21e1..0a9d1e9faa28 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -7,6 +7,7 @@
>   *  Author: Jeff Xu <jeffxu@chromium.org>
>   */
>
> +#include <linux/fs_parser.h>
>  #include <linux/mempolicy.h>
>  #include <linux/mman.h>
>  #include <linux/mm.h>
> @@ -266,3 +267,41 @@ SYSCALL_DEFINE3(mseal, unsigned long, start, size_t, len, unsigned long,
>  {
>  	return do_mseal(start, len, flags);
>  }
> +
> +/*
> + * Kernel cmdline overwrite for CONFIG_SEAL_SYSTEM_MAPPINGS
> + */
> +enum seal_system_mappings_type {
> +	SEAL_SYSTEM_MAPPINGS_DISABLED,
> +	SEAL_SYSTEM_MAPPINGS_ENABLED
> +};
> +
> +static enum seal_system_mappings_type seal_system_mappings_v __ro_after_init =
> +	IS_ENABLED(CONFIG_SEAL_SYSTEM_MAPPINGS) ? SEAL_SYSTEM_MAPPINGS_ENABLED :
> +	SEAL_SYSTEM_MAPPINGS_DISABLED;
> +
> +static const struct constant_table value_table_sys_mapping[] __initconst = {
> +	{ "no", SEAL_SYSTEM_MAPPINGS_DISABLED},
> +	{ "yes", SEAL_SYSTEM_MAPPINGS_ENABLED},
> +	{ }
> +};
> +
> +static int __init early_seal_system_mappings_override(char *buf)
> +{
> +	if (!buf)
> +		return -EINVAL;
> +
> +	seal_system_mappings_v = lookup_constant(value_table_sys_mapping,
> +			buf, seal_system_mappings_v);
> +	return 0;
> +}
> +
> +early_param("exec.seal_system_mappings", early_seal_system_mappings_override);
> +
> +unsigned long seal_system_mappings(void)
> +{
> +	if (seal_system_mappings_v == SEAL_SYSTEM_MAPPINGS_ENABLED)
> +		return VM_SEALED;
> +
> +	return 0;
> +}
> diff --git a/security/Kconfig b/security/Kconfig
> index 28e685f53bd1..63b87a218943 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -51,6 +51,17 @@ config PROC_MEM_NO_FORCE
>
>  endchoice
>
> +config SEAL_SYSTEM_MAPPINGS
> +	bool "seal system mappings"
> +	default n
> +	depends on 64BIT
> +	depends on !CHECKPOINT_RESTORE

Would prefer to depend on actually tested architectures only.

> +	help
> +	  Seal system mappings such as vdso, vvar, sigpage, vsyscall, uprobes.
> +	  Note: CHECKPOINT_RESTORE might relocate vdso mapping during restore,
> +	  and remap will fail if the mapping is sealed, therefore
> +	  !CHECKPOINT_RESTORE is added as dependency.
> +
>  config SECURITY
>  	bool "Enable different security models"
>  	depends on SYSFS
> --
> 2.47.0.277.g8800431eea-goog
>
