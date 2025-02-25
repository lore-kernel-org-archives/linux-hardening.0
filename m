Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A291C266B62;
	Tue, 25 Feb 2025 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479881; cv=fail; b=AQl9R7rO10R7GYxys1g96Q4sVj5U+WB8d+HuhMOZCmOovy1QWUkrC0/ypjpBHmJR9+4R4Sdvvf31o7VhbujN9+h2hpSTo+EMgLzEmOaEh/4lvxUVtp+WQjuKu19dA1szSUPHRLELmZul7R1i4AjaWw4fMqTU3GCR3yo2HUgFu5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479881; c=relaxed/simple;
	bh=BR9r4925UGrAWRgCj2EI5wKK5IIPeVZ1xdf/oOTHufY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p3ZKz04jRe6pIKYF1ouApsMXA9Ha9E4/U003ewnpi18S1wXzFr0Jyr2oCrDrx0XJWWuX8S5QTthg8EZxHp4lNh/uRWunD88ftN9Tori+/OX+ZUjAOWEdXjkSWdtEPLzHdOxlkkyP8PTTlfF9QFSVJXXTl3k7QgxLKfAoD/fi+hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oF4WsZp1; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EOGxUd7k reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oF4WsZp1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EOGxUd7k"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PABjRV012897;
	Tue, 25 Feb 2025 10:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=kD2xyxI99q1gcNSWahpyn/f4964xOd4HOHsKVVQHEW8=; b=
	oF4WsZp14sT5GEoCs++Ywy+F5FdYLW0pWEPDoHKDhyaEcKEpY9+lwSNKAXE4o02b
	GOjgauXcI7hswoXU+pkeQsA50AiT2TB8iPGF9lUT8AFd/9sMT8UFv8BIUmwisjlV
	qTM4CrXiepC29tEI2apkKTlZN7Ra8BBIZMzk40ZCuYqrCyOZNBCK2ELzdysJNfB/
	BBpo7j6gZTDQXWd0eTOK1LjrCma1gVbNMrR4Ai2CaG59JyuHKJ/L8DR+dy89Cxgr
	yBk/j9W3ul27oYJTBKCU9XSWtxq88bovpROX0g4gPt2hOqVV063PNtIex/Onjqfx
	ajO60xM0SsiL9Kt/E7qPqQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y50bms2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 10:37:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PAWVZl002704;
	Tue, 25 Feb 2025 10:37:16 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y5196y4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 10:37:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrU/VWiN/0zYIEVnEq8Cc5UkWiUcR6ozB88ZrVl9y4V10WnBnLd/gz2iAIXtaA7YDCGF4aKdqmGEzPzsUnkP3NPmA1xBdZZYiz9tcWoWU6S/q3bkkN5oZzF72IQZf6CStR5B9kvZ6OJw365MrhXgeaCuTD3XGDhuQtnQ/vYv1mXj7yFDuySaWhX+gN2QTd+v16cGvzpG3mzoTU24aQe/dHma6Fvr1/khJ6PxSuVX2lHzGJ1++aMIpTT8Ye305t/JjJBPsqi+ro6AufSiC+4v+zz704O1tS5XSB5RSlYPhCKlKsi6sFxXKlnOwdjchl4CYb8560G0pZvjZvr23KY5Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zH75svYeG7NiUyArs4JXKynAFkwjDLWg3mUzNoTTxY=;
 b=v0MClVnQ+8fdVqBD09M2hK/t0JpnL63rChw7OPCLlYQEh+nh+cWEVpLksaQzGKjvMybtPs2kutLtHNtxbdN3TtWRIkMygjfCgvDVdE92woF/nyX9Asj+0a40TcMhji0F9xNroyUa5YwGc2hAjIxyOdpyoqu+AQ+nAHZcsYJokW2Uj3fFzOdPTHN1rgSEpqCmAcWxRA3MSckRmHDsnWl2KJ+eqVoKowSILtwK2DiIz1Q3SLzXLt0/diai0XQgGvSlK0pXgpMj33ln1nwzibxHG1OpE26sCbMfXxsEcxJpjVomLj77cbeQcq22sHv+q6PkFUmj2H4EbxFoPuWTezVuEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zH75svYeG7NiUyArs4JXKynAFkwjDLWg3mUzNoTTxY=;
 b=EOGxUd7kFSgJzPiJTLmSpAtKzPd+CjhGBUMGkH9xkO3hURzq+o9SK3lzsNHWhXUOxKxwoRmN2DUfcALORFP5mMAr8PXyIqdz9dh/ufHDEXlFHxIzmBVunmLxAeNvY68slnS/8TZhmJZZxfLK4lr8nPLH5RbOkBGEyFv5jzxRVys=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by SJ1PR10MB5907.namprd10.prod.outlook.com (2603:10b6:a03:48a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 10:37:13 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 10:37:13 +0000
Date: Tue, 25 Feb 2025 10:37:11 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Berg, Benjamin" <benjamin.berg@intel.com>
Cc: "jeffxu@chromium.org" <jeffxu@chromium.org>,
        "Jason@zx2c4.com" <Jason@zx2c4.com>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "deller@gmx.de" <deller@gmx.de>, "gerg@kernel.org" <gerg@kernel.org>,
        "anna-maria@linutronix.de" <anna-maria@linutronix.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "avagin@gmail.com" <avagin@gmail.com>,
        "mhocko@suse.com" <mhocko@suse.com>, "enh@google.com" <enh@google.com>,
        "thomas.weissschuh@linutronix.de" <thomas.weissschuh@linutronix.de>,
        "hch@lst.de" <hch@lst.de>, "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "adhemerval.zanella@linaro.org" <adhemerval.zanella@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sroettger@google.com" <sroettger@google.com>,
        "ardb@google.com" <ardb@google.com>,
        "jorgelo@chromium.org" <jorgelo@chromium.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "mike.rapoport@gmail.com" <mike.rapoport@gmail.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "groeck@chromium.org" <groeck@chromium.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "aleksandr.mikhalitsyn@canonical.com" <aleksandr.mikhalitsyn@canonical.com>
Subject: Re: [PATCH v7 5/7] mseal, system mappings: enable uml architecture
Message-ID: <d2aeeb56-ba8c-49f3-957d-1ac790522233@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-6-jeffxu@google.com>
 <c5d3927e-06e3-49e7-a1d6-f4c9e817def4@lucifer.local>
 <96ebddf3fe31353c89f6a4680eaeb2793c25cd09.camel@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96ebddf3fe31353c89f6a4680eaeb2793c25cd09.camel@intel.com>
X-ClientProxiedBy: LO4P265CA0280.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::17) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|SJ1PR10MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: 949f504d-ae57-4d25-8887-08dd55885d84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?i362+fKwXu36s0wR9qzt1lhqQS5fkvJBjPr/ys1ywYLMykC/OlJc0JnQkG?=
 =?iso-8859-1?Q?nerivIAs5iE1l5hOZIygbQKsBO/ZiQp8EX/TevF/Q2hWkblT154eqYA9Le?=
 =?iso-8859-1?Q?7k5yQFOXxrcYEgRUB0aqkMpM0nopVhopG8hp9RkcmHMXKOG2U6ZRuR7qal?=
 =?iso-8859-1?Q?GvlSp4lpGeCYl8akL0EM9qL/oi9gs8Rum2Pbs3MqibdUUlgjUsXTIh/0Z+?=
 =?iso-8859-1?Q?sktX3+aZYQS5DJ4pMw+w3CW6qHG4vEy/10Yp2tzeXk2s7slN2df0Mxwg/d?=
 =?iso-8859-1?Q?Rqz4YEGCBy3Jl3zws4f+LZe155gXh2nJZNhKSfRo8dDC9F0TCKfUzbyRKb?=
 =?iso-8859-1?Q?rDeC/d9uVeED1y2ZmY4r65iLlN4Xus5naVU4y0lVn/gI1JT/WiDIBg1bdI?=
 =?iso-8859-1?Q?A0G1y92r/xlDwo5q28T4WkcesiZZx9eOoqLlxDrlpU0MOjChNFum0SULhR?=
 =?iso-8859-1?Q?IJokxRT6KA7rncE1l1RhYObq/kZqS9K2J5tmqRtfFtEGk6AtUBYFXoFtPp?=
 =?iso-8859-1?Q?edBjyA+DtB4oh33Hqp/dOS/YE+nDLwtiIV56YeE4w6PBMyHXH3W1tcckjA?=
 =?iso-8859-1?Q?AJ6u8PJWSsM84hQ6cByYNc2vx4pcEpRXaSoZ2GSnTvR1oG7tjY9o+9pAWN?=
 =?iso-8859-1?Q?De/AbpbtBAf0mLGF/tLSPaXLtFJpKen3bBlR7Zn7drDAioyvMQNNhHcJmF?=
 =?iso-8859-1?Q?aI4RTEk9W/S/gNagWC+irUWsLipZYUm3CtKy6R/C5fJVygdIaTHytYfjZ/?=
 =?iso-8859-1?Q?RCPxYDLZwv6LzfRP1+zH/NZOgr+Nf5Nza0HDix7lr7qikgwDAdiK421Q/H?=
 =?iso-8859-1?Q?Ib8TKGiWoq6hkF+Sd8yecblB/D2miDwdnwVAhcqtyAD04C1AHlYWY1wP97?=
 =?iso-8859-1?Q?/fIzE49I6e0AtW6OHMagCnY0J217drmk8y1NbU1detYk7rEWT82nL9IA4H?=
 =?iso-8859-1?Q?w/rQ9edtxErpczs8bh28ej1MLITp+xMJ/habCPXd63YnY48CogsRlMml4P?=
 =?iso-8859-1?Q?Obn3sLCFIucWh+jXwXHiEdIWWiku/iw5H1lmsgP4AHBE8HoJHSTcWMUctQ?=
 =?iso-8859-1?Q?esccCcfJ2iYKe9MyfbWUkR589xnYdrWAPUAdGVbEsfV+7C1wTsfwubSsu/?=
 =?iso-8859-1?Q?fIk8HTlDNEwqBO2s8Qdxgi2hQmm4Ronj71LuuQzw9fCXPA9QrtxmsLJ70/?=
 =?iso-8859-1?Q?qClIb9Luhi0t+v06CHXt8IEuPuw0dhuRYdU0wzr9G+yoElLd1dI2oQluif?=
 =?iso-8859-1?Q?ja1HOfM9w6eXn6282vsfcHfJcwXbP/H/+FMrQaudDxOFEsuZrWAtQfMFpR?=
 =?iso-8859-1?Q?bKQrOvCcnTJxQtE/baegkfmRGiFS5b0vX0LjrN2NXxl8tEDq7NQks3rxro?=
 =?iso-8859-1?Q?zwsgo040KjerGu5ZoS9wmWcI6xZvMcWQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?XMoApxcarW8o1keHPSqkiQ3TJIuiqZytFZJHiYmGpT82rFFu8362bO2sOr?=
 =?iso-8859-1?Q?X0GdpWwXMlG4ymDm4z8UKK7tlOvLMIhL6fYtC0q9KiiOOzISNVCkqDTWT4?=
 =?iso-8859-1?Q?WMvs8f4X6XJc1xllWWvcgD311/WnwRoGbNNNZRqj9U3K89yBDWpZOmK2Ir?=
 =?iso-8859-1?Q?riJrSrOtdWB83/mY/cTDJ4yQu4niPfh1cMyZQ77mxLbwreqnAT0ao2xQHM?=
 =?iso-8859-1?Q?sRg91SDE6sSsncHm9JtkffihwKKl9nfRgyjL2HkaJgNtTUiqQqHrOCOI3e?=
 =?iso-8859-1?Q?U7F+0bdkqCTN/2uaojZACoA/5NWQvIp2on8ryiyy9hXYjjSDeU77D/BDoH?=
 =?iso-8859-1?Q?gQegkB50R/9LbJey6KEQ4/iIFqHqXG4SGoVnyYAlWge/CyCAIxrTj15T9k?=
 =?iso-8859-1?Q?wG5RaDtstRaUPAR59JQot7TJXCaA3kZDYiRZHS/u2AJdIDSgP8hJKzbyUb?=
 =?iso-8859-1?Q?KeZwmGonAIUpH6qvUb+HlP1+tS2H8gS6FFADwmkLxe9IUAe66zQmpTNr1h?=
 =?iso-8859-1?Q?QjPOJEL3ladzbaQcSNE/fjK2KHK6G3xGnRRB5QpFuz86sRKiuAIrhdqa0e?=
 =?iso-8859-1?Q?a1kcBtkmG7ougTIFbaHHzLmIWz/VqE3/U0j8aUobL20Vg5GzO+q94du7Oy?=
 =?iso-8859-1?Q?XSm9FIHa0Qh8WpL25u90e5OtvgSqsB5zP5A77OxXv03TqQJTEP6XCXXdbj?=
 =?iso-8859-1?Q?uhbVRhE42PcpqSxWGZXiAIDFgWO9TmUZslSFOcOKqquy3TXbxPF/LxUods?=
 =?iso-8859-1?Q?J0hC8IYXBTJg+h2lQLgUD2ZzZ8IVYMWsK94P6cMoYT31cFw93bbXpcVgVA?=
 =?iso-8859-1?Q?RHpit4PZIA/w4axJI0+YYY2bd4ytMzyXZCACOGLt/krKxQS7BMBgENGYvL?=
 =?iso-8859-1?Q?Tts5TtbjPyES4ntGapKymr5iu0Dfj9C9XwdgLaiY6drgqUUZ7F2vmUTaqH?=
 =?iso-8859-1?Q?3pBQhKO9YUBOUT9Kl8U+iX4kAomRpGfg40YPzkdYqqdvBb3VJnqS1Fm2zK?=
 =?iso-8859-1?Q?vOdla3/3y4Szegvz9+q+AyfhEqp80k7813et+NWC4wFjs2zBf5enPEB28F?=
 =?iso-8859-1?Q?YGw/y20Y2LoL488WmPDEeSKee6ZdBTjwu9IAATMf/AZXvEfA7+I35OUJ0I?=
 =?iso-8859-1?Q?mWecG8AxQrlQXhNCnr/dj2DU5OANWf14naK8yvhg+WZpIpqhEjavEkIdt7?=
 =?iso-8859-1?Q?IQikeRYpNLknNjxCsBD6Mz0LMJh/RSboHkC31oyQXPjfl5NDhGF3cp0bDf?=
 =?iso-8859-1?Q?P06r0mHFyZYdNSu4tM8NJat1MqrO0I4AirKkbB8ofTjFpKo8BOKNRYtMXA?=
 =?iso-8859-1?Q?FfmmE4l5azF3gH6WN2a8oIKiTfELDLk0FItNCwNhAqZu1KEaJixmgDyoV2?=
 =?iso-8859-1?Q?bIhpMsA2hCi60BbnRrWZmY7eRKa+J6qslQwaI59bHFuzyO+gMNhIGrceTh?=
 =?iso-8859-1?Q?Fo1lyuE7khGBb3NVbR2wS+HqBcHjKijDS/y3M/PeZVIldIkRcKEtHcBU8e?=
 =?iso-8859-1?Q?3tWQyYaswXdjcjrG1ty/gFDq1DdqGjm6r45P8GNYbNeIwl3ari6eIshujm?=
 =?iso-8859-1?Q?vFUIfK0aEdmkm77W9lDoll6Z6ww20t1Tc2UXd1D0pPZqumd/r2IQ8TNU6W?=
 =?iso-8859-1?Q?vFaQGoxWwHdQpLvJH/bi2p4C1H7LmKwpeD20qEO5wgcuw16tlwNeeh/g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VOSCOMpb2yGegFsOLxngFF9XolDEF+zTmos8J1F03BbrqCOZ92izysgTS4grc8nkwg7Esj5ZgvSBpks4pL/mr8slQsb0eMt3UCsHEozR/kqkoqCjrfZmqQdxyXR1J+KmMqA7kR5CaURv0LA38zGlW7TByYadEzUOWwRtpmn0YdIbzvQO4UPX4XEtoLgoq4452OeI20HwJvakTZ97HdmOtKl0a8ifCuJE9QMIEc00HZ9k31h7d/qOKbU+UA8xRwNhGjE8KuCGBUdj0EfnNORu46Q9egALKIxT6RAokZ4Fgyvv7mceVM3ld2PD6BDlAcNrjzLjhlZMJlYMxAkvWGQ6w463r7hy71p/Pgu++sXyDtPOpO76o3PhfwmsHplHMFfpVWR5oCrloIoB0Tnpc7u1AmnCOl1LB8OjCjAvrfi8H4ved1yIic1VrzwJkifTDdK3Gbs/mr85iG7WgpLMtj/n05cH3BjLeWQGj3Tl2SpbJ77QfhBOXzmcbllHY4qKyC+Ag1fF/oLbKqAPO/G8gAeARAFIt6YmU2ogvY7Z2Ru9JCM4FW08UEZDa3yT6uUIrYFG/SQHnbSSOacsoIOJXajUAAfwi+oJ5EKf7EboACdmMcY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 949f504d-ae57-4d25-8887-08dd55885d84
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 10:37:13.0712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 16unkOlCvy1xcG+RJb3K238n9iBcGhjrPH2TS2ZP7PBip9k2EUo7AWzQYrEj7mWcC81ip1LXyVnEOIc7rnihs9eDSjCoVE1obpVz413wejw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5907
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250074
X-Proofpoint-ORIG-GUID: UGUeeqWHaFl-vSXG6XrBu-42wOGHOX0V
X-Proofpoint-GUID: UGUeeqWHaFl-vSXG6XrBu-42wOGHOX0V

On Tue, Feb 25, 2025 at 08:45:21AM +0000, Berg, Benjamin wrote:
> Hi,
>
> On Tue, 2025-02-25 at 06:22 +0000, Lorenzo Stoakes wrote:
> > On Mon, Feb 24, 2025 at 10:52:44PM +0000, jeffxu@chromium.org wrote:
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on UML, covering
> > > the vdso.
> > >
> > > Testing passes on UML.
> >
> > Maybe expand on this by stating that it has been confirmed by Benjamin (I
> > _believe_) that UML has no need for problematic relocation so this is known to
> > be good.
>
> I may well be misreading this message, but this sounds to me that this
> is a misinterpretation. So, just to clarify in case that is needed.
>
> CONFIG_MSEAL_SYSTEM_MAPPINGS does work fine for the UML kernel.
> However, the UML kernel is a normal userspace application itself and
> for this application to run, the host kernel must have the feature
> disabled.
>
> So, UML supports the feature. But it still *cannot* run on a host
> machine that has the feature enabled.

Sigh ok. Apologies if I misunderstood.

Is there any point having this for the 'guest' system? I mean security wise are
we concerned about sealing of system mappings?

I feel like having this here might just add confusion and churn if it's not
useful.

If this is useless for UML guest, let's just drop this patch.

>
> Benjamin
>
> >
> > >
> > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > Tested-by: Benjamin Berg <benjamin.berg@intel.com>
> >
> > Anyway I know UML has at any rate been confirmed to be good to go +
> > patch looks
> > fine, so:
> >
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

OK guess drop this tag please until we can figure this out, sorry Jeff.

> >
> > > ---
> > >  arch/um/Kconfig        | 1 +
> > >  arch/x86/um/vdso/vma.c | 6 ++++--
> > >  2 files changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> > > index 18051b1cfce0..eb2d439a5334 100644
> > > --- a/arch/um/Kconfig
> > > +++ b/arch/um/Kconfig
> > > @@ -10,6 +10,7 @@ config UML
> > >  	select ARCH_HAS_FORTIFY_SOURCE
> > >  	select ARCH_HAS_GCOV_PROFILE_ALL
> > >  	select ARCH_HAS_KCOV
> > > +	select ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
> > >  	select ARCH_HAS_STRNCPY_FROM_USER
> > >  	select ARCH_HAS_STRNLEN_USER
> > >  	select HAVE_ARCH_AUDITSYSCALL
> > > diff --git a/arch/x86/um/vdso/vma.c b/arch/x86/um/vdso/vma.c
> > > index f238f7b33cdd..fdfba858ffc9 100644
> > > --- a/arch/x86/um/vdso/vma.c
> > > +++ b/arch/x86/um/vdso/vma.c
> > > @@ -54,6 +54,7 @@ int arch_setup_additional_pages(struct
> > > linux_binprm *bprm, int uses_interp)
> > >  {
> > >  	struct vm_area_struct *vma;
> > >  	struct mm_struct *mm = current->mm;
> > > +	unsigned long vm_flags;
> > >  	static struct vm_special_mapping vdso_mapping = {
> > >  		.name = "[vdso]",
> > >  	};
> > > @@ -65,9 +66,10 @@ int arch_setup_additional_pages(struct
> > > linux_binprm *bprm, int uses_interp)
> > >  		return -EINTR;
> > >
> > >  	vdso_mapping.pages = vdsop;
> > > +	vm_flags =
> > > VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC;
> > > +	vm_flags |= VM_SEALED_SYSMAP;
> > >  	vma = _install_special_mapping(mm, um_vdso_addr,
> > > PAGE_SIZE,
> > > -		VM_READ|VM_EXEC|
> > > -		VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
> > > +		vm_flags,
> > >  		&vdso_mapping);
> > >
> > >  	mmap_write_unlock(mm);
> > > --
> > > 2.48.1.658.g4767266eb4-goog
> > >
>
> Intel Deutschland GmbH
> Registered Address: Am Campeon 10, 85579 Neubiberg, Germany
> Tel: +49 89 99 8853-0, www.intel.de
> Managing Directors: Sean Fennelly, Jeffrey Schneiderman, Tiffany Doon Silva
> Chairperson of the Supervisory Board: Nicole Lau
> Registered Office: Munich
> Commercial Register: Amtsgericht Muenchen HRB 186928
