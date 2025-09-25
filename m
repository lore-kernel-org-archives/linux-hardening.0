Received: from mx0a-00105401.pphosted.com (mx0a-00105401.pphosted.com [67.231.144.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED84E78F43
	for <linux-hardening@vger.kernel.org>; Thu, 25 Sep 2025 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.144.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758822163; cv=fail; b=eRJW2uF6vs4unTtyMqnGqIRVCDGdty4DYaqEt+ZZeVf2IdrYNcsRxteZe9bykzMtr14PpyTdaVNO37Bo9toONkPjFhXn/sG/8V7gl1MBg6Hj0Ta++QaxPohSoNnWo1oOaYUq0QB3Qe7reh7Tj8Z5DiZCfdT8ZhlFsxNec7HLbeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758822163; c=relaxed/simple;
	bh=BNXeyVpw5tutTBxN77DMwpPBYJ/6ryhEWr0cxcHkbWc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Xt18qvG+Q+PQthZrztk056RhP1DzgcYNyGC97YkEK2FzGlo1VG/1OwWl/vvcnhqhWbOoBu9I9Lx3bmcOcZGYhxrxprgE4j/zTjYa0byL1YdaloaxqL7Kz13/r//aJPhUnZ6/beFqd73EmwWfadFJ/Sk43htG//yHOTJqHWRiZuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=collins.com; spf=pass smtp.mailfrom=collins.com; dkim=pass (2048-bit key) header.d=collins.com header.i=@collins.com header.b=ia3jcPia; dkim=fail (1024-bit key) header.d=rtxusers.onmicrosoft.us header.i=@rtxusers.onmicrosoft.us header.b=3v/EdrIl reason="signature verification failed"; arc=fail smtp.client-ip=67.231.144.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=collins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collins.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collins.com header.i=@collins.com header.b="ia3jcPia";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rtxusers.onmicrosoft.us header.i=@rtxusers.onmicrosoft.us header.b="3v/EdrIl"
Received: from pps.filterd (m0346906.ppops.net [127.0.0.1])
	by mx0a-00105401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P55HM0001724;
	Thu, 25 Sep 2025 17:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=collins.com; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=POD051818;
 bh=meC/6wDQdZIoLSeXTvXYqKymHnfE1ctx/T1WUNYT3gg=;
 b=ia3jcPia35aNllLP62tLkyi33/U+J11jDgFEo9gVAvBPR1ptnbe/xBHZy/H81Qxt6dz5
 mUGUedVlp9WR2aON0hBSj9yy3bLr8tPphQcw9nbLJzNZ13iyd2OV8cFXLHzc6loWH+J0
 939RlUTuiqMhc86bhBiv0p+Wk/TzIBAyLG5VHgOGk3L91dBba+tSy55iPItiwQg1cT3J
 eyfDFz6iu4sZxkq6FYSoaLdsLnjbkaQta+ec0Qc0W6KkklfQMhxkiL8REB3BXVEa6yDA
 4cffUBAAKRC719YcxOcoLcQe/U5dqsQjWzytb7Ep9MOZAoXJ8XZ8j/18hub45qupAYfu YA== 
Received: from xusxph008rp040.rtx.com (xusxph008rp040.rtx.com [128.13.124.146])
	by mx0a-00105401.pphosted.com (PPS) with ESMTPS id 499n12jm12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 17:00:41 +0000
Received: from xusxph004rp010.corp.ray.com ([128.13.120.135])
	by xusxph008rp040.rtx.com (8.18.1.2/8.18.1.2) with ESMTPS id 58PH0efj005014
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 17:00:41 GMT
Received: from UUSALE2G.utcmail.com (uusale2g.utcmail.com [10.220.63.42])
	by xusxph004rp010.corp.ray.com (8.18.1.2/8.18.1.2) with ESMTPS id 58PH0W5M025306
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 17:00:40 GMT
Received: from UUSALE2B.utcmail.com (10.220.63.21) by UUSALE2G.utcmail.com
 (10.220.63.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Sep
 2025 13:00:38 -0400
Received: from uusale2a.utcmail.com (10.220.63.20) by UUSALE2B.utcmail.com
 (10.220.63.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Sep
 2025 13:00:37 -0400
Received: from USG02-CY1-obe.outbound.protection.office365.us (23.103.209.59)
 by uusale2a.utcmail.com (10.220.63.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20 via Frontend Transport; Thu, 25 Sep 2025 13:00:37 -0400
Received: from BN0P110MB2020.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:19b::14)
 by SA1P110MB1277.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:192::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Thu, 25 Sep
 2025 17:00:35 +0000
Received: from BN0P110MB2020.NAMP110.PROD.OUTLOOK.COM
 ([fe80::f1a2:48e2:95db:aeec]) by BN0P110MB2020.NAMP110.PROD.OUTLOOK.COM
 ([fe80::f1a2:48e2:95db:aeec%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 17:00:35 +0000
From: "Hill, Steven " <steven.hill@collins.com>
To: "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
CC: Kees Cook <kees@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>
Subject: [RFC] gcc-plugins patch for compiler versioning.
Thread-Topic: [RFC] gcc-plugins patch for compiler versioning.
Thread-Index: AdwuPQXx2qJ9bckSSY61Y289wS7hvQ==
Date: Thu, 25 Sep 2025 17:00:35 +0000
Message-ID: <BN0P110MB2020D78705BB39062BF8D107FD1FA@BN0P110MB2020.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
compliance_labels/x-tech-data: No
compliance_labels/x-cert-selection: No
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0P110MB2020:EE_|SA1P110MB1277:EE_
x-ms-office365-filtering-correlation-id: 57b8dc9a-3a1d-4ab5-f343-08ddfc550bef
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?ycpjspl0GSHAMEML4QS/Lqd0QVxl87shXA2uzyszBYWhbT700n18nHJwe/EI?=
 =?us-ascii?Q?8eOxY1xidJWtRgDUaDagohn4tVgHgNpmlHGzj1n7WCp0TbPMYsiKdlKhNy11?=
 =?us-ascii?Q?D6dQSGP2KwXibOaD7YUn2zYaWStARmEqfCKPzgFbV+zBq5bw7vRkljf4W5KU?=
 =?us-ascii?Q?R/5xFGMV72WsF10pJYw/yscuFfO04rmHLEsdhrItegUr1IYSP/XSqG2uljKi?=
 =?us-ascii?Q?jrrV7locGZqCFvqc072rS6IyUmTmIQEUtOoP1fZVvxbcNtJoiyFqZnqMF7c4?=
 =?us-ascii?Q?O8uFzFHO/7FIIC555D0qPppyLoaZhEbWA2Co4iB52klwtOy/DxZ4cCglna4C?=
 =?us-ascii?Q?NjULCtrkunFCdfYwjFXpubSS0aIUGIkEeaHOprfXrEXYsYm0Ah5fxlhcKC72?=
 =?us-ascii?Q?ovWuqBsXPO9EMvdSOeaxIHQUNTOsDOZ9EDWay2cOVfEAT8yfSQGt5exiPg9m?=
 =?us-ascii?Q?mGsbrSSFlB4UTdj5O4IEOarbfIDe3lzYwj3i3AEBAgHhbjjQknRfEoE27mUV?=
 =?us-ascii?Q?KWu+o8Xh45QT2PJ9IqfxgFP22fLYRZJzDewF9tPICJEZDh1kwqfIesIjvr6O?=
 =?us-ascii?Q?zzRlz5/zUcIAomckBAeZYHALxVx49KyW9TG8TYToNqsBPKFIwVlbV5hjhFEi?=
 =?us-ascii?Q?LDJ9NOxKnW8NDSq3lfSKM51rctMDpTlej7oXIzCgFgI3vtiw6jTvgbo18n8x?=
 =?us-ascii?Q?l5u+4F4T47IvZ508HJp0ZlwFceywBHW0BpATEr4HabOF0ewl00aoMGr6pkKZ?=
 =?us-ascii?Q?OTqezAyxoCEtugvmgdkpQUNQrXEctlzY6TGO+/41qpk3Hot9vkV636am7oLg?=
 =?us-ascii?Q?mhtVmdeLBzuBt1eBmGYtLBHodkVTXUGQuKy5MF3V1TTJg8W5nJdAr8xYFwf9?=
 =?us-ascii?Q?jn0xJkh8iv8YnhhVvinpQJm8z0MEFGjSVE2OgCx3OjRvaifzy8pFpOD7gZ02?=
 =?us-ascii?Q?tjeZX7aP89LtKGq56dA3svFQCEM9bLU/cvJ0UkImea0tYDhTXyaAQdrfjlqF?=
 =?us-ascii?Q?RTmT51QHOaOcZkli1GZEXJOUjTQtSwy2Zu2wKb6UhZ+FHXQx1SLk/ZgEDfT3?=
 =?us-ascii?Q?plNQKZxuUj84Bb62RN13lQagOtShxrvBiBSy4y3e6Isklk8cgAomO+dG29Hl?=
 =?us-ascii?Q?VG6X5BBHpoIwA8FPFwGSKCnKpBjz5vHJf/6DyqEDKsIsYfOpy9yWbdgMY2qQ?=
 =?us-ascii?Q?Lg7oo2fYPDAqB3r4XnIla3MUiQMMPy0Uo77PyU9VX4RtGXdLZ9sXZiQMIlAR?=
 =?us-ascii?Q?hEYa/cE4IpiDXPrR7z3Un5gMVmTzf1DeROOB1nJ5kA8s8eKCNZGbixslxblc?=
 =?us-ascii?Q?lh8gnIbEMzlvKAEcVYynvhYl0bwmqsFBycz/oGHMDE/cIBmgy9M8fy3xgfgd?=
 =?us-ascii?Q?TlJXNJN7B16vTbuI1Ygum3D1PMs3BE5SL/jWHtWbIAkDdlBOUIbqQeiqKD/F?=
 =?us-ascii?Q?M8+GX5Q2InSjbQXiNDcSAdIfMtJp1jDE+R5X+SkYMs5YNJPOAch6zLAVGrxZ?=
 =?us-ascii?Q?Aas5TXmn5y3c+xhY8oZPuV3OseT38iJQaeoG?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0P110MB2020.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JNDRuwfb+SSj3DphOx6qqbqTgde6Bo8sefztnUhI1gm6yjysNV54Jwy4HsuJ?=
 =?us-ascii?Q?zs3raVa+eDQFskTiLHc4VWagczOFj1NKvEHKwsswkSOFOu6472pJqZatP+qx?=
 =?us-ascii?Q?4YIYZhnpwyHqk/tHHMudqxtZeIYKdEuyBfeF+6u3tmavoSBE49mBkKfAcYKI?=
 =?us-ascii?Q?unmIWCER0dk/YpeSVTbdde4/KdbZjP46dl7xYSbNjHGhX9j4uC0fS8LaiZ1A?=
 =?us-ascii?Q?cvWREdEcy1DDOjvyL9erPb2XItBwgFALGFS5XmQ/iw0mImO4vdXc3LLv9sY9?=
 =?us-ascii?Q?0PMI/bJt1+E0Z/t0bb1V8Un0WkId2b1lqZuxHgznblMiwt6QIabXqQiTIKsd?=
 =?us-ascii?Q?FfZiUF0Or+6uY97WLSN9pGn07jd5IW4/9u8nCFzzv2aKE6ibSrXOZZXKd7NA?=
 =?us-ascii?Q?bZwZGus+4PwYWHkJftZsttSo3t8ACnVaQoA9GFOF1X0rxYoQUoz1MKgrE/Sl?=
 =?us-ascii?Q?wq5yEEiVD+AizoO29Idl9yh5Am+zrm9Vn80mkZamvOUDyHX38N7Wyz62emEX?=
 =?us-ascii?Q?j5HSfPY5eFXbtXn9Ao5Voqrk8IOXxdguQcATor6U+/omu1Se3hlH6cpmoHvy?=
 =?us-ascii?Q?TDJkCTwaQwty8jlnntirpIYOy9a7h/RzSkD6W/yvMp0SXkUj8b/vEuZTfKpp?=
 =?us-ascii?Q?V5Kg0VvA2aF0M8rku9gJcVO3rHSi552XvuzO/5q2paRELozN4YExon4iLmam?=
 =?us-ascii?Q?zZ33n/pjqHcnmGaiARab58d779ID6NG3xbvfSn1M/ZKfxq33B6hwKLp99kJu?=
 =?us-ascii?Q?TuUAkBGK+rrTQbSRBLc+HUbbiDAL8zPF6D8VChfk8ws+vkgWzsVuRQLx61ED?=
 =?us-ascii?Q?NSrEvOkq8QHHsSSppppEdkCoZm3wq/YLEWaWDS9ftWPaaXmQ/q+Y3qTD5eD5?=
 =?us-ascii?Q?vVmkwXKkKuhbWzaSGkOC8lN4+7e1ZwWklfFKOXHwVV853t/AlA+Db0Ev94wb?=
 =?us-ascii?Q?tgUcsFP2ADAoScB9kObAykYFAlxjiKEsHQsDJOBns1Q4eSp0Xu9C279zxcsu?=
 =?us-ascii?Q?Lyc7s0o+IDzUw700YnpROQ5Ee6q+JFrmVmZ8xQcr4WH7MmZ00YByZrbAlvlo?=
 =?us-ascii?Q?9w6aRQrMtNq1cGqUcGyNlqwg9pPbNMRMeAIictNczuZlgtKCzRQfIcEe9JTl?=
 =?us-ascii?Q?akd+rUsLomqKR3Z1D1lEQ6kJH6kQAPPXFHLIm7WcHxlcwbkw63GEX+5jE7/e?=
 =?us-ascii?Q?DUmDtmSMMHYXwC7duwEhe436nFn9l+rymPF4E0zB/BCintgxuclgmVoOIEUA?=
 =?us-ascii?Q?q4ArAehj57XWZGZi9XveuEeuaCoE/NstgsDmuzdpNU/XG3yMKAH8r5Ug5qYd?=
 =?us-ascii?Q?mrNvXlXrLcwuFh2fXLXIt73HNQ8PU79mDtRb/SWkycSJPNpx6vKtWuQi/8N/?=
 =?us-ascii?Q?76M41fQTDJIgMhFGNbhob2LkuLrSSc6TUb35HfZHYdIe3XaozVFbc+400wYa?=
 =?us-ascii?Q?zJ/iay0gZ/CUgOwn2SnfH5PtjEYWbXLuFyLvfLYob/EcE8exRpSgticcnc3e?=
 =?us-ascii?Q?W6SuFRbto9F4Bzw=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=1QtAWpQyIA8CjWRQFuhmcQPXAv+9SgZFpGpRW2YKbxDkkv0G1lh1WdaS0PqcjO7CSLKYFJ7wHCNgNXZSTsksrha64q0BM+5POb7Pt/Zp9jNemFrTuN7a3PVdU2i80yg72SRd1zowyD3twGUabVZjwu/R+pdi7OIpTbNb5pGhllFw6RcpRgOIaBWFb8PltkRKK8+AN/deXKCfgYU5pWiJBT1WymYAZfBswDSRimyz8TRJcfBxH3+rzsgB+TxCpm0u7o9gNDKeJEL2MoWRxqXI6EdUCkggpmGAZiHjpAfEdeTobBDUlcdrhioA4uGSt8eUwahlibEVTycgChRT3vvV6Q==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFUpAqobtZRUniO2lE6aL4+BtQejJbtOH0Gw4gaHFeg=;
 b=tFS5NL3Mma9wKJL5k8P8waN/1PQOgHVMAPG+Yodhd7TkU+DFjMAj8qeJP1NMduF2S0LHQdOwBdLC5S35zPke/Ic+EVVPpXkqIc2u4VG2XqDIjtlpl1b7u4IWernR2gnfCWBGcWUXx+wWtzvX3aSdZ/mFNeDrsp8CKXjQ15Jy2pOjva99zMvUqbgsiPAIfh71EJ5SOrEqTaXceP8KPvlJDwbCUdxBGyRP0QVYZg/bafvsO/syhPlIdVsFNr61bjwJC3Nk2OmeDQsIZvCxBWneIAsiTtt2kFHpiqQyMwIIjUatAz8944BQxSTW1wTS1Zbr/1YbupnKj3IvGQ7ya9PJDA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=collins.com; dmarc=pass action=none header.from=collins.com;
 dkim=pass header.d=collins.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rtxusers.onmicrosoft.us; s=selector1-rtxusers-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFUpAqobtZRUniO2lE6aL4+BtQejJbtOH0Gw4gaHFeg=;
 b=3v/EdrIl7n+qB0TugT4yQA+remrj5tqoII4bMgQYlkzPGxW/cRfrqSf65aSgz7QjIeCUhznaiQ66UTv+Cwmb0jXHHnKXlp5MUVBdOFBOrVjNn5ZKXqK09GSwjkgMjgGFdUPYV2dU+NhVkGf9wh9i8fi/heBfuVvnGc3XE/CJyfQ=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BN0P110MB2020.NAMP110.PROD.OUTLOOK.COM
x-ms-exchange-crosstenant-network-message-id: 57b8dc9a-3a1d-4ab5-f343-08ddfc550bef
x-ms-exchange-crosstenant-originalarrivaltime: 25 Sep 2025 17:00:35.8966 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 7a18110d-ef9b-4274-acef-e62ab0fe28ed
x-ms-exchange-transport-crosstenantheadersstamped: SA1P110MB1277
x-passedthroughonpremises: Yes
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Collins.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-MHuser-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509250158
X-DMZout-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509250158
X-Proofpoint-GUID: zBy6lWd014UzhM9KhP2TVWXWW04Cbj3J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE1OCBTYWx0ZWRfX8DTa3qzynx6q VCsI9ThQWYO0jC+fEAHS05DCfKJl+ApVcUazkzNr6uHfKtXUq1Sj2d9avmIsYhEAPtAmsY2aeA9 81te5QJcig7727pYjVRznl1i9r0/i+Jrw2eIMz7ZKo3MM+Y+GTSNQqse0I7FD2aPwyTweseSwLV
 rw5HqhINTjpBKVBeBpdUXnvGbI1ZFGuBRBaQiTqCkDjjcKJZN7dDan8uQv17CfhWxDXPqpA0Onl UXIL8bNk087GLGHN/5r3YyZfanLJ2NBl4DfqNxHMnFKxaWvV2ob8S69ZktxU31sFLbiD8zw09zd C3KwL6j2r9xysZbJtVYhVY0osl9ir6qGZxe4jwGShIUC6oJNZoWTTdf1WC80iHjM3iRNuDlHxl5 PqfcCuid
X-Proofpoint-ORIG-GUID: zBy6lWd014UzhM9KhP2TVWXWW04Cbj3J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-CPOD-Spam-Details: rule=outbound_default_notspam policy=outbound_default score=0
 malwarescore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2508110000 definitions=main-2509250158

Hello.

Would like to have comments on the attached patch. There could be another
option for checking both gcc and glibc versions. Just wanted comments befor=
e
doing anything further. I am not on the mailing list, so please CC: on any
replies. Thank you.

-Steve


From b1ac0805d70aaa2e1500a071f63c88bcaa76754e Mon Sep 17 00:00:00 2001
From: "Steven J. Hill" <steven.hill@collins.com>
Date: Tue, 23 Sep 2025 18:21:09 -0500
Subject: [PATCH] gcc-plugins: Relax constraints on plugin compatibility.

The compatibility check for gcc plugins is too inflexible,
and a lot of times wrong. Add ability to let the user choose
how stringent compatibility is.

Signed-off-by: Steven J. Hill <steven.hill@collins.com>
---
 scripts/gcc-plugins/Kconfig                   | 36 +++++++++++++++++++
 scripts/gcc-plugins/Makefile                  | 15 +++++++-
 scripts/gcc-plugins/compare-libc-versions.sh  | 28 +++++++++++++++
 scripts/gcc-plugins/gcc-common.h              | 18 ++++++++++
 scripts/gcc-plugins/latent_entropy_plugin.c   |  2 +-
 scripts/gcc-plugins/randomize_layout_plugin.c |  2 +-
 scripts/gcc-plugins/sancov_plugin.c           |  2 +-
 scripts/gcc-plugins/stackleak_plugin.c        |  2 +-
 scripts/gcc-plugins/structleak_plugin.c       |  2 +-
 9 files changed, 101 insertions(+), 6 deletions(-)
 create mode 100755 scripts/gcc-plugins/compare-libc-versions.sh

diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
index 929997fb5e45..626a9200f2a1 100644
--- a/scripts/gcc-plugins/Kconfig
+++ b/scripts/gcc-plugins/Kconfig
@@ -19,6 +19,42 @@ menuconfig GCC_PLUGINS

 if GCC_PLUGINS

+choice
+       prompt "Version checking"
+       help
+         Each plugin is required to call plugin_default_version_check() in
+         its init function. This check can at times be too stringent or
+         just plain wrong, especially when cross-compiling. See source fil=
e
+         gcc/plugin.cc in the gcc repository for more details. This option
+         allows for the user to choose how stringent the check should be.
+
+       config GCC_PLUGIN_VERSION_CHECK_DEFAULT
+               bool "Default behavior"
+               help
+                 Just calls plugin_default_version_check() like before.
+
+       config GCC_PLUGIN_VERSION_CHECK_NONE
+               bool "Disable checking"
+               help
+                 Plugins will be built without any incompatibilities
+                 being reported to the user.
+
+       config GCC_PLUGIN_VERSION_CHECK_GCC
+               bool "Check only GCC versions"
+               help
+                 Compare only the GCC version strings of the host and
+                 target compilers.
+
+       config GCC_PLUGIN_VERSION_CHECK_LIBC
+               bool "Check C library versions"
+               help
+                 Compares only C library versions. Checks the
+                 version strings and the highest library API versions
+                 supported in each toolchain. Only glibc-based tools
+                 are currently supported.
+
+endchoice
+
 config GCC_PLUGIN_SANCOV
        bool
        # Plugin can be removed once the kernel only supports GCC 6+
diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
index 320afd3cf8e8..48d50a3fe362 100644
--- a/scripts/gcc-plugins/Makefile
+++ b/scripts/gcc-plugins/Makefile
@@ -24,6 +24,19 @@ targets +=3D randomize_layout_seed.h

 always-y +=3D $(GCC_PLUGIN)

+ifdef CONFIG_GCC_PLUGIN_VERSION_CHECK_DEFAULT
+GCC_PLUGINS_CHECK_VERSION =3D -DGCC_PLUGIN_VERSION_DEFAULT
+endif
+ifdef CONFIG_GCC_PLUGIN_VERSION_CHECK_NONE
+GCC_PLUGINS_CHECK_VERSION =3D -DGCC_PLUGIN_VERSION_NONE
+endif
+ifdef CONFIG_GCC_PLUGIN_VERSION_CHECK_GCC
+GCC_PLUGINS_CHECK_VERSION =3D -DGCC_PLUGIN_VERSION_GCC
+endif
+ifdef CONFIG_GCC_PLUGIN_VERSION_CHECK_LIBC
+GCC_PLUGINS_CHECK_VERSION =3D $(shell $(srctree)/scripts/gcc-plugins/compa=
re-libc-versions.sh "$(HOSTCXX)" "$(CC)")
+endif
+
 GCC_PLUGINS_DIR =3D $(shell $(CC) -print-file-name=3Dplugin)

 plugin_cxxflags        =3D -Wp,-MMD,$(depfile) $(KBUILD_HOSTCXXFLAGS) -fPI=
C \
@@ -32,7 +45,7 @@ plugin_cxxflags       =3D -Wp,-MMD,$(depfile) $(KBUILD_HO=
STCXXFLAGS) -fPIC \
                  -I $(GCC_PLUGINS_DIR)/include -I $(obj) \
                  -fno-rtti -fno-exceptions -fasynchronous-unwind-tables \
                  -ggdb -Wno-narrowing -Wno-unused-variable \
-                 -Wno-format-diag
+                 $(GCC_PLUGINS_CHECK_VERSION) -Wno-format-diag

 plugin_ldflags =3D -shared

diff --git a/scripts/gcc-plugins/compare-libc-versions.sh b/scripts/gcc-plu=
gins/compare-libc-versions.sh
new file mode 100755
index 000000000000..592e501575f2
--- /dev/null
+++ b/scripts/gcc-plugins/compare-libc-versions.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# glibc version comparison script
+
+if test $# -ne 2; then
+       echo "Usage: $0 <hostcxx> <targetcxx>"
+       exit 1
+fi
+
+#
+# Get paths of base C libraries.
+#
+HOSTLIBPATH=3D$("$1" -print-file-name=3Dlibc.so.6)
+TARGLIBPATH=3D$("$2" -print-file-name=3Dlibc.so.6)
+
+#
+# Find the highest library version supported in each.
+#
+HOSTVER=3D$(readelf -V "$HOSTLIBPATH" | grep "Parent 1: GLIBC_2" | \
+         sed -e's/.*Parent 1: GLIBC_2\.//g' | sort -rn | head -1)
+TARGVER=3D$(readelf -V "$TARGLIBPATH" | grep "Parent 1: GLIBC_2" | \
+         sed -e's/.*Parent 1: GLIBC_2\.//g' | sort -rn | head -1)
+
+#
+# If we get a match, emit the pre-processor flag.
+#
+[ "${HOSTVER}" =3D "${TARGVER}" ] && echo "-DGCC_PLUGIN_VERSION_LIBC"
diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-com=
mon.h
index 3222c1070444..5a747895d8e6 100644
--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -439,4 +439,22 @@ static inline void debug_gimple_stmt(const_gimple s)
 #define last_stmt(x)                   last_nondebug_stmt(x)
 #endif

+static inline int plugin_version_check(struct plugin_gcc_version *plugin_v=
er,
+                                      struct plugin_gcc_version *gcc_ver)
+{
+#ifdef GCC_PLUGIN_VERSION_DEFAULT
+       return plugin_default_version_check(plugin_ver, gcc_ver);
+#endif
+#ifdef GCC_PLUGIN_VERSION_NONE
+       return 1;
+#endif
+#ifdef GCC_PLUGIN_VERSION_GCC
+       return (strcmp(plugin_ver->basever, gcc_ver->basever) =3D=3D 0);
+#endif
+#ifdef GCC_PLUGIN_VERSION_LIBC
+       return 1;
+#endif
+       return 0;
+}
+
 #endif
diff --git a/scripts/gcc-plugins/latent_entropy_plugin.c b/scripts/gcc-plug=
ins/latent_entropy_plugin.c
index ff0b192be91f..e1899f16bf22 100644
--- a/scripts/gcc-plugins/latent_entropy_plugin.c
+++ b/scripts/gcc-plugins/latent_entropy_plugin.c
@@ -596,7 +596,7 @@ __visible int plugin_init(struct plugin_name_args *plug=
in_info,

        PASS_INFO(latent_entropy, "optimized", 1, PASS_POS_INSERT_BEFORE);

-       if (!plugin_default_version_check(version, &gcc_version)) {
+       if (!plugin_version_check(version, &gcc_version)) {
                error(G_("incompatible gcc/plugin versions"));
                return 1;
        }
diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-pl=
ugins/randomize_layout_plugin.c
index 5694df3da2e9..fd8220c6daeb 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -851,7 +851,7 @@ __visible int plugin_init(struct plugin_name_args *plug=
in_info, struct plugin_gc
        find_bad_casts_pass_info.ref_pass_instance_number       =3D 1;
        find_bad_casts_pass_info.pos_op                 =3D PASS_POS_INSERT=
_AFTER;

-       if (!plugin_default_version_check(version, &gcc_version)) {
+       if (!plugin_version_check(version, &gcc_version)) {
                error(G_("incompatible gcc/plugin versions"));
                return 1;
        }
diff --git a/scripts/gcc-plugins/sancov_plugin.c b/scripts/gcc-plugins/sanc=
ov_plugin.c
index b76cb9c42cec..78e1e38d3922 100644
--- a/scripts/gcc-plugins/sancov_plugin.c
+++ b/scripts/gcc-plugins/sancov_plugin.c
@@ -106,7 +106,7 @@ __visible int plugin_init(struct plugin_name_args *plug=
in_info, struct plugin_gc
        /* BBs can be split afterwards?? */
        PASS_INFO(sancov, "asan", 0, PASS_POS_INSERT_BEFORE);

-       if (!plugin_default_version_check(version, &gcc_version)) {
+       if (!plugin_version_check(version, &gcc_version)) {
                error(G_("incompatible gcc/plugin versions"));
                return 1;
        }
diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/s=
tackleak_plugin.c
index d20c47d21ad8..2d3129ad2507 100644
--- a/scripts/gcc-plugins/stackleak_plugin.c
+++ b/scripts/gcc-plugins/stackleak_plugin.c
@@ -560,7 +560,7 @@ __visible int plugin_init(struct plugin_name_args *plug=
in_info,
         */
        PASS_INFO(stackleak_cleanup, "*free_cfg", 1, PASS_POS_INSERT_BEFORE=
);

-       if (!plugin_default_version_check(version, &gcc_version)) {
+       if (!plugin_version_check(version, &gcc_version)) {
                error(G_("incompatible gcc/plugin versions"));
                return 1;
        }
diff --git a/scripts/gcc-plugins/structleak_plugin.c b/scripts/gcc-plugins/=
structleak_plugin.c
index d8c744233832..7128889979f5 100644
--- a/scripts/gcc-plugins/structleak_plugin.c
+++ b/scripts/gcc-plugins/structleak_plugin.c
@@ -216,7 +216,7 @@ __visible int plugin_init(struct plugin_name_args *plug=
in_info, struct plugin_gc

        PASS_INFO(structleak, "early_optimizations", 1, PASS_POS_INSERT_BEF=
ORE);

-       if (!plugin_default_version_check(version, &gcc_version)) {
+       if (!plugin_version_check(version, &gcc_version)) {
                error(G_("incompatible gcc/plugin versions"));
                return 1;
        }
--
2.29.0

