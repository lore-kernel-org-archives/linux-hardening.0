Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CBD275AE6
	for <linux-hardening@vger.kernel.org>; Mon, 25 Aug 2025 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130228; cv=fail; b=Aa8yTPCBcNCbyVRusY1uOWttIxOsB58kqrVf9KWIhirYHm1MlfDCAYW21jmXv2Yp+cO0G5KLUhupIuiGqrLFZgD1Cpq3YEPUYaAu54ZFl863pfNSU7aRiqJXS6kfdUHeB76tIrBYtqD5NUFDvqHoGrta0s8N5peRazvviUufFeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130228; c=relaxed/simple;
	bh=QAxsSxK49oC3zY00RVvwj7t1F06J/l6iqSj42bDsNBg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OJzrbxukjICOrlpTBlhYZugE2M0+0a+VlV4HNF0Dn4bGrlPRkstGiQTyFkkfq+7AzAlFGVZRC3+fFGp5imnRPCBhv9QqwIxr52Cuk4O5KDOSRzw0hNPNpA4DZb+p34A/pwr/Lbe/G0cMi0Q1lSEf3vw87wvJeMyq1ZLmyIGvF8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EFPeHYta; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=juBVVvDL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EFPeHYta";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="juBVVvDL"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P9JmQ6026934;
	Mon, 25 Aug 2025 13:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=X3kpJ48vr29D3szx80n5WA3zTO9gg3qtpcGTNxqhI+c=; b=
	EFPeHYtaxJu+vGeFBNKdEMsHeH1AMhND9zHZV1vRfRtxdo397LACB8E2sbs0NFZY
	3kTkkd8qFGrMyTBKBvRH1v5jAXIc7bKduvZoLOgK4sSkMch6PGCWo+kHJIFwcG7X
	rCCXbnOspurFRbzfxDcZ1k79KAwnnc0fFKf8ArxXaSacHy9lihh9GxAEZK2NZraJ
	h4zTAcicSV8eR+7/LRYmkDPONZB2jWS/Cj8F7nWn8OXObpmtxNJV4deCdvQZruih
	1xDo2SwnZdmyXpnZLt1gRehzGVkKcmR0HQcPTowoj7DriQ9ISPjK8Gyta1dKJAXa
	bPz+M+1duhWsXxaIo+UfIA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q42t288a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Aug 2025 13:56:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57PCBYed005112;
	Mon, 25 Aug 2025 13:56:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q438f2k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Aug 2025 13:56:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ue/fQKMVY6i2OFiO9+WYY4qWNvWan3Es0RmEcj/fmEWwSNE01xkIrLdAlrDF7NhzXBwF49apgYGYWFnXfxtPoEj8RKUIY6Izg3pn3taTVcsdSpRgLY9UuH3MrPscEqmocm24FcKr/4enmSV6VmrY+7i7WfmWMO9SLWQvwoD1m/aBhhqUWBfB2FrL/Wy7n5IPTHUWh5hgNH8fBiac5FPIHe86z9vD23ytg+W6Kzxku9fbCfqkls5Orewi6iehRl58TLpKqvMwzOm9VAI6BZnR/uVlYc8SSBfXJitI77JwX4DEg6nXyosa5Tg4j6vrfs10q1Zv0jnznBcFmBa2eXaz8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3kpJ48vr29D3szx80n5WA3zTO9gg3qtpcGTNxqhI+c=;
 b=EZiaQqSfR5oWBPe597+4GTEt0MemNSr7Ngi2p+K/YpWo15CCmohYqAQPLz5dG8Sp63MQG+JGhsYKoiORF7A38VP8t6yZJ2M16IzQKdlcWzT+bovHl/W/qDkUlnXf87S750j6r6qHpBbghm/8FimoIPxAcGdpKB0olJLfupOOcxL4EOD3qqoAoBD52RtuPj/dBAVpcawWDbY3ZOa8iVi+b5Mo1HAebwRv2dw9ne/bts7oAGeqhMShqkCIhUxlm8dwyvK+CRWPe8bMiAc83uwpoMBLaxss4hoOJ+GyCDDdsFr5UlPoJIej4Aubxaqt0TzPfQkHiRvtk2MlJaxVkq1giA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3kpJ48vr29D3szx80n5WA3zTO9gg3qtpcGTNxqhI+c=;
 b=juBVVvDL45gp3CvWtgFVHQeS99HN3BB2lhzikqfPQFhfbHvAtAE0wK6E9IZbWeQ/JRDL+fCc4kDrTT1dLQZYnKcAhwyiQIzKFvipVpZQzszQ1tNDaR3NNYfmo59XrQxFmnQPA7Hs0T7f7RFOQoQmslgVOKi7MxVDMXIJtZlq948=
Received: from CY8PR10MB6538.namprd10.prod.outlook.com (2603:10b6:930:5a::17)
 by IA0PR10MB7370.namprd10.prod.outlook.com (2603:10b6:208:3dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Mon, 25 Aug
 2025 13:56:38 +0000
Received: from CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::8a:61cd:764a:e47]) by CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::8a:61cd:764a:e47%4]) with mapi id 15.20.8964.019; Mon, 25 Aug 2025
 13:56:38 +0000
From: Qing Zhao <qing.zhao@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>
CC: Andrew Pinski <andrew.pinski@oss.qualcomm.com>,
        "gcc-patches@gcc.gnu.org"
	<gcc-patches@gcc.gnu.org>,
        Joseph Myers <josmyers@redhat.com>,
        Richard Biener
	<rguenther@suse.de>, Jan Hubicka <hubicka@ucw.cz>,
        Richard Earnshaw
	<richard.earnshaw@arm.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Marcus Shawcroft <marcus.shawcroft@arm.com>,
        Kyrylo Tkachov
	<kyrylo.tkachov@arm.com>,
        Kito Cheng <kito.cheng@gmail.com>,
        Palmer Dabbelt
	<palmer@dabbelt.com>,
        Andrew Waterman <andrew@sifive.com>,
        Jim Wilson
	<jim.wilson.gcc@gmail.com>,
        Dan Li <ashimida.1990@gmail.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [RFC PATCH 2/7] mangle: Introduce C typeinfo mangling API
Thread-Topic: [RFC PATCH 2/7] mangle: Introduce C typeinfo mangling API
Thread-Index:
 AQHcEm0EGi+s8Q35f0a3asvZv7CnCLRsvhQAgACK1gCAADHTAIAAJaIAgAEovICAAECGgIAAGFOAgAAhj4CAA8gMAIAAX7CA
Date: Mon, 25 Aug 2025 13:56:37 +0000
Message-ID: <B838DBF8-DE0B-4CD5-A852-0CB9E188E1A6@oracle.com>
References: <20250821064202.work.893-kees@kernel.org>
 <20250821072708.3109244-2-kees@kernel.org>
 <CALvbMcAPV1eB6nocPAS=qR8SCiQyU43v911R8S7Ah_=G7yK-+g@mail.gmail.com>
 <202508210841.8BE6E3C117@keescook>
 <E69330D6-1302-4BA1-BADD-8C91A096A1FD@oracle.com>
 <202508211258.8DEE293@keescook>
 <22C19D00-58D7-4854-915E-C7B8CDB3317E@oracle.com>
 <202508221149.F19A56772@keescook>
 <0F3CAA68-8C9E-49AC-8B12-95BE8E92475C@oracle.com>
 <202508221519.02CEBB27@keescook>
 <20250825081358.GS3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20250825081358.GS3245006@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6538:EE_|IA0PR10MB7370:EE_
x-ms-office365-filtering-correlation-id: b8fca713-19e7-4bbb-0695-08dde3df3601
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?rxQH9rPT7y31tiZWmbAP2NBpqQKdEH1R/3AE+hD+WYiNZwYR/PBxW8GLIrJ9?=
 =?us-ascii?Q?zIYckdtAfbIPFTUy242PX8ng2+bdUugehtYyS3UUbb2EI/Z2A/2hSUbQxcLc?=
 =?us-ascii?Q?XBeCbkUR826hYtR7m0ji/RUJ+ofJbD7aRF8Od3kEb/hulFBJ9KSkLXWn8uzn?=
 =?us-ascii?Q?f8nSwbJvJy82NCIHHEOEd4ol/WgLkZ0PpK3AKHiYzYsY2Np9QHEb13hpBHYu?=
 =?us-ascii?Q?C0pY9v0eflE9dppm8SC+RkpruVguQipLONrTMZvgB4BUsQfQ9THjp178G3Jo?=
 =?us-ascii?Q?Anx0vhKnl2rpmHUrSn+wN+++/862UaGnz1/6DAjMswzMtl902mEk/HED2hxX?=
 =?us-ascii?Q?tpS00yx+8ihtUVL8ux3DBDbM0EEdY8uvxAF6oOKXVpdVgRIyr3BDL2fF5zZZ?=
 =?us-ascii?Q?ficMx8Jst9twsLF2Kh1XlAi8+u8CTKcHJULFZHr0EF554UArNR4CMHMtMh5Z?=
 =?us-ascii?Q?4/O0/qwCbKRD97tFOj92BP+Joz10RxnMdqPWvIRW6hHQMBxjSDxgCW1UqGoR?=
 =?us-ascii?Q?6ZUbihwK4IjtQ9c6F70FkPquxNTq49cYfLro1vPlfLXOD20E3kvX0K2MSOzu?=
 =?us-ascii?Q?CR4pjogj/9P9GPcwWwp1fSRpcd/lTTHnAYZeM9RpO7v6WDRkTor9Z5WOIxtN?=
 =?us-ascii?Q?N9ju1H9zAB1s7tTjmBQX0dA+XXK4n7GbtWj0QcKQfrqqeQO5cbCb91auwAmE?=
 =?us-ascii?Q?iXLdH6TCS5XVxBuYhmz5D21PAqItVcgCTzA2IgTcXevJAy6PAfhQOVbv1y+C?=
 =?us-ascii?Q?w8xvQ/wsEC0VkirNAK1RM+jB+DkWMW5oqs/ARZESY8x+AF6zNFpPIbEx6eVC?=
 =?us-ascii?Q?+Ds4xg4+nza/n/5uRfrqglpvWzCKfcDLGn6Br7lhSDVqwpOBiCeazMjKV3Id?=
 =?us-ascii?Q?rPWTPuWdS88dLh4BWgkRhm4LLDD7PpTPCaXUGkx2WxqmBupIhMj2JjcxpOIO?=
 =?us-ascii?Q?j9F4G8ljCdoE+42F9H7EgQ/UulOB3tFOfiJUhWhL6hpo1CMMWXb/Pdk8tzio?=
 =?us-ascii?Q?dxvcHssUWUrHmZQVlRKPSpXejFSwSHTBboNo+4CKKmvobOo65qsnYaqpjnev?=
 =?us-ascii?Q?T3k+iP7QlTXDRjjiVy/YNxu1cUXFN6+WU2nXS2Hs3l3JSyu/Okl5UfI8Txu1?=
 =?us-ascii?Q?EI/2JhsAXMBWLjGIW0UnN9VN1g+kAO9DYI5nn0fO9z9WaHKHpBo3N4pd9KNE?=
 =?us-ascii?Q?qhfS9IXRLfwM02H7Q/WGfEoeI4fLoXjL8pE2H21zLNyiWh7upHq+HnCUAxIi?=
 =?us-ascii?Q?fV7lY4MH8oRXg2o6nGAipZMfUfe1eC4aqaRgc5VA85RsFDljcP+HHaTi1iEX?=
 =?us-ascii?Q?a4/L5aODXVS5GQL09hfSJ1iAymMm7T9thZbRo6Sil3It/x9lJiCuR5HxMmEZ?=
 =?us-ascii?Q?eCEbi7DI1bnhzkN+rNBzVNcIiWHBEjJc5cxN0ZJgZ/um8AjgJ16YOd/VGXAt?=
 =?us-ascii?Q?y8069Ymz8noXLqQBfhYtvSuvAbU0ublImzjFUtX9pauWLJvA2lBReQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6538.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5b7xU5ajafHVg+NGPa35mXGzyk9L0wD6J4f4907t9rEZyuQd2ZK2zFd6dPRb?=
 =?us-ascii?Q?TcxN9UqPeLWuoD7kNWZLveVLwNiHof6YyY3stYcYbpa2B8DO2jZ2br6Qb/ZD?=
 =?us-ascii?Q?lsgyQRHMAN5t5Satcw/8ftq9DYqmRRRgFyhAhZCIiZmDBo52Z3DEvPTwayoh?=
 =?us-ascii?Q?rLUVcfY2L5qNk0SV0RVwjChCjAcuxhmuFNYlNCs8AGEb6VXGSAA34ISGcb8i?=
 =?us-ascii?Q?D4dg8hc104q0V2EbCZv4OOThvYAkP8sV6vlXNMgvflZOCDndevIPUGlcIQ90?=
 =?us-ascii?Q?5XT31XFm5v8OXUX5hrBlJ/p4LA2ZHAIzUlvrYjQatxr1dCm11xetDHk5Temu?=
 =?us-ascii?Q?CYWPdE8IfeyFaBjizteNdahBQTO0mppxmvH6QQ65RP/rKIVdEno7qH80hb7C?=
 =?us-ascii?Q?sszKrYaDLGyHjQUAgGa/P/HFeDJqcQeoUPrT0e5ZO+kCjs4vbLTJcmlbpViy?=
 =?us-ascii?Q?KqDP8oQ5da23Y51foUvJTfXQd0Tb1xqmYxHSgG0BCI+CoEKZrB0fjXm+H0Md?=
 =?us-ascii?Q?J2kMap+p2HN/jMhtN4O9ZUq0Af4Keudrlx7AZGYFuc7T4Dl4K6LlCCRz1AU2?=
 =?us-ascii?Q?GEdErXCw0KBKlskG4VJIWFcIx5BV8Gmuu5kWPfsfHAn96A+Be0epz3d4D+bN?=
 =?us-ascii?Q?LzCBEDAHXD9Q3evN7iqZVHDcseKnc/liPMqRTTgKJNSj/Sau8RptrOEqUDFA?=
 =?us-ascii?Q?rcGw1ACu9o4WB87crYpPAY4ciBwbbHLN98affagaAgRGioN1hRE5bzE+VXfW?=
 =?us-ascii?Q?iFWOLidfrB7Iujr+QUHTF7lYryE0Z1mCM8f9nI5q1/xvZvACmDJJA7PxXBUu?=
 =?us-ascii?Q?7NZykA/kDtcp53VsjUi9/fsFAwIrZ6BOrS7Pbdi2zOsy2vYbuH6fsmGbIN/D?=
 =?us-ascii?Q?YzrzE/N2RGpfkqA/FR2BAYy60jHMmcA+5i/ewpcOiO6Ag3lYidU6SaBBHMw/?=
 =?us-ascii?Q?R30NZoH7g2B0Lj3Yb48Urpzo6P88P0n0+3CeX6Shez8Gpkmbi3oFMvDm6vkH?=
 =?us-ascii?Q?l/zDyhOOglliXmmiWYoKJBuny9K2/lsQpml4cTmLYZeoSbtQP2ftOrANSzhX?=
 =?us-ascii?Q?CPVq4c3BLZDiwYSnY7dBxAjUI/5v6Z/V64job6S3x/pbIVlDNcO2RRIKUxb/?=
 =?us-ascii?Q?K4b5q+ccyFnbPPMrssO0R5hq7tHe2wh0T0WBxcNmitQlBzYB34ocZMD1lqPs?=
 =?us-ascii?Q?sVROvg2wIyTTG0ztbmdnH9lYYBRbpKVF2q+Ndi1suuKh8c3gx7rbOf6APS/b?=
 =?us-ascii?Q?Fc/IwYE3PQknTa5rfDh9CSaX/GRuGpO0FlvJxV9g3Vi2BUwA4+WwJ0QHTVzQ?=
 =?us-ascii?Q?xTRcRPonA0bHVGMcUB6q1Fakvv7tZPi44nNwakkHrG4aLLqQHey/dj4bNORj?=
 =?us-ascii?Q?97wrMQrRSfHhiTEFGYZW/ftws2GvvIuF/DTNAQI1yMInkkyVrfgIWLNg8c59?=
 =?us-ascii?Q?W88tsHw5G8YQzFVMcGag8AnL/zIfgUt+TIDyPX08ktLjohvIX2bEIbMDiKIM?=
 =?us-ascii?Q?YrcdjpjLIjFYyNrt3raP2AQ0HS+2ETsd/mY5nUi58rcZfl/+/9XavJdO6CSp?=
 =?us-ascii?Q?wgMtXsI9ARaZXywV6f4GOALhGvnRurir/6YXLd34?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <40206EC3D9F7B247B47A672E6542715B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DVhdDgc4JHLZz5zFk4St4EQZvIOM/KbRqeDVGTmN7D/0YTg3gs7I+4x0mD5N6btOCJ3ypHTJYLxEPTdrBnZLWlSvWB3BGtAD8eW7i+giwic963Q6OPJDMI2ET72to5iWWYSASi3/NJusfYiT99xFg8M5F7i2LSkVvKG16Lrm3ObgEg2o+pbI2qPMCbCy+JiIXE6zZEQcWVCGxM25O74dGkjXL8hrIk3ZCi8qDATRhT0orX4Z5nVW90+ZSnh+udu7Nd+pU1Wuzupni7RWlc5Wn71ERJj1/69J7TvlY74BL80ZG0i4WKmCxyF9vXOQ0CXe2IP5eJP4Xw9Uk0qK0zslInQk9lwm9U+KpDnnc50vJfCQ3WSPX9YgljdfV0qWUGeNNp9l4NwMUleAnGVwdEaGLg+7Rbiu+2WsIfUMjf8YhrWex8IuLWELw+AKr18dDQT0Am3OB6szsueJ3oIedZUgHk1jrLbaC1h1+oW7GsrfZ0z08xBVHskNcIPw6uNfQl/mh6pjB/FPYMCSIPuBo0Ztx176mw1YxdjZMO4brd6ejASrUO4ilsbJatcFFUyyUDzNSrUKLdKWYrOn7BsnCVqr/B+t+MDBwYWxX23ABx4kqTI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6538.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8fca713-19e7-4bbb-0695-08dde3df3601
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 13:56:37.9338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3pOzOPtiRecVxqc/EXCQyqGkIJZYyFQgAdalq6BTGW5OCxUTOw5wQJAZuc3tWCKVDWsMXCDr5hhOmLZTZ02zeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7370
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508250125
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxMyBTYWx0ZWRfX80owl/uF4SNu
 OJozAw4GeImy9F/HVM44y1salF6ZMlpUqCJF1nY55MZpHP0a6YtDkKPv9SNKHD39nugIS3ibaqO
 0w5DAJx7bgBCzvo+VKIk+6YftslinzT5g6Z9BnfNKVedTPQmRlhsdkzKM0f1t8vg2fSoBHCPfpf
 Ni/xBvolcOBpP7hfz9nOTk9S3yewZvOsadeEh99WmtvwdZmw0EHtmQhU32gyvWrnhMJTWkCmoMw
 kGkiI0UBT1WmoF4rtZdfdbiyenchi4NamqZ7AxayyVwLjTZmK2yM6BX3b16R1II7x6Yb7TRs9tO
 u4pVs+Swt1FLESUk6RWT22Zv5dENn345UZ7ktX4kfXMqkdgGPXf4kLPak5G55QlKYnTlrrkj3bQ
 hNxuQ4eM
X-Proofpoint-ORIG-GUID: IcF8ir_fVjWh-LIeb9MfjV9m84XOxpic
X-Authority-Analysis: v=2.4 cv=RqfFLDmK c=1 sm=1 tr=0 ts=68ac6b9a b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10
 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=qU78OsMCR701EZofIfEA:9 a=CjuIK1q_8ugA:10
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: IcF8ir_fVjWh-LIeb9MfjV9m84XOxpic



> On Aug 25, 2025, at 04:13, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Fri, Aug 22, 2025 at 03:29:11PM -0700, Kees Cook wrote:
>> On Fri, Aug 22, 2025 at 08:29:16PM +0000, Qing Zhao wrote:
>>>> On Aug 22, 2025, at 15:02, Kees Cook <kees@kernel.org> wrote:
>>>> Right, and sometimes we have to explicitly perform a no-op
>>>> address-taking to make sure a symbol gets generated:
>>>>=20
>>>> /*
>>>> * Force the compiler to emit 'sym' as a symbol, so that we can referen=
ce
>>>> * it from inline assembler. Necessary in case 'sym' could be inlined
>>>> * otherwise, or eliminated entirely due to lack of references that are
>>>> * visible to the compiler.
>>>> */
>>>> #define ___ADDRESSABLE(sym, __attrs)                                  =
          \
>>>>       static void * __used __attrs                                    =
        \
>>>>       __UNIQUE_ID(__PASTE(__addressable_,sym)) =3D (void *)(uintptr_t)=
&sym;
>>>>=20
>>>> #define __ADDRESSABLE(sym) \
>>>>       ___ADDRESSABLE(sym, __section(".discard.addressable"))
>>>>=20
>>>> $ git grep KCFI_REFERENCE
>>>> include/linux/compiler.h:#define KCFI_REFERENCE(sym) __ADDRESSABLE(sym=
)
>>>> arch/x86/include/asm/page_64.h:KCFI_REFERENCE(copy_page);
>>>> arch/x86/include/asm/string_64.h:KCFI_REFERENCE(__memset);
>>>> arch/x86/include/asm/string_64.h:KCFI_REFERENCE(__memmove);
>>>> arch/x86/kernel/alternative.c:KCFI_REFERENCE(__bpf_prog_runX);
>>>> arch/x86/kernel/alternative.c:KCFI_REFERENCE(__bpf_callback_fn);
>>>=20
>>> I am curious on why the compiler eliminates an external routine complet=
ely in the file if it's address-taken in that file.=20
>>> Why an additional no-op address-taken is needed here.=20
>>=20
>> If I am remembering correctly this is needed for rare cases where
>> a function built without a C definition is being used in Linux's
>> self-patching "alternatives" code swaps in one function for another,
>> and is being used indirectly. These cases end up not being visible to
>> compiler (so no address-taken), but the indirect call site is still
>> being instrumented. And the above list is the _entire_ list of such
>> corner cases: all really low-level things.
>>=20
>> Peter may remember this better than me...
>=20
> The above are all functions from assembly and JITs, the C compiler
> simply never sees the function definition, only the declaration. The
> above is used to force emit the __typeid symbol, such that assembly can
> reference it and it all links correctly.

Okay, I see. Thanks for the information.

Qing


