Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213CE382F01;
	Wed, 19 Aug 2026 05:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787115807; cv=fail; b=GDRD6xioCgciDBlIPexp2tFuFrUBDdDBUMRyeBw7c2/NfHIjvEHWhyMUussk2SdGwcQf2fw/WreAvO9hz15CCGDfURHgtwz8q5jtjFBo+nbUra3cdpwqGBaraB7ek/8a9qRF3m7QhzUT/duevGcf2A0FOuWToWkbxWYUEUrEDKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787115807; c=relaxed/simple;
	bh=b0+dBZEQ8nGYrEjpAdQqh+UuE3Dm/l+EW0eobWXUrWQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n/u1M86ce/ODF7Zxx3hoio+XBqkupZrwZaC9J7PDWT0u98hGWj22oX5gUcXeIlopGN1Jt0I0JkQ1ZBraIXqwGUWF3xMtn8SbZw+VjMmJ8U/mDKXJGfvk+4tTuwomKh+X2naRQLhNAJI33d4EXo8CGCX/awc/QJ3EaDSuaA/Fkpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qti.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mtVl4y3D; arc=fail smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mtVl4y3D"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J4vLho2508831;
	Wed, 19 Aug 2026 05:03:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DipWsS9WZazG4URJSigT0eOtNQlwOk06iKtLS1SA+5A=; b=mtVl4y3DpNO/cjGT
	wos12/ZF1aYy7AO/yobi6pFAWdEg+ukN+xImdBD4aEHskcL360q8YNUtIkLuGMmg
	RWltVnhtUjjgsQDPSj/zLITqluI6adYVelcWq7D1+wNNgFFFWsd/6dmlxu2eUOcV
	bSPNhrEQrbxJpDufbkb9db3GnSqWl7A5bR0ZmBZ1CK+RTc+42p8aLBpu4xU7d4mP
	LUssmcFQ6SkedJnAPKkDJAco8QDpRIi4DWVi4pPuY/aoh8yM5Nnk4wfRi/VX2n/G
	oahhiolMlLc/osW/jN38sj20Xj3ZtQyAVGIx1Qiz709zQl/qj2RRLfmeW9CSOwrP
	PnZYyQ==
Received: from byapr08cu003.outbound.protection.outlook.com (mail-byapr08cu00307.outbound.protection.outlook.com [40.93.1.111])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfm1d7p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 05:03:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYhKAsx8zbg9U1rF6uNwPkpJ85dVJzImVF3CwlygTK2gJj48TFjDFzHxxk3JboOwlBG5fxUldyVI/NIDpJa8US9WejHBmaWxGnQmKkM9MLORaFTbPYGo6MdwmWAmmD8UAbEkRtzhoAppXCj2FvxddaHaCBR/e/Shg9g5iaSwD/YZDP3ZYOS228SBVgWmUQvbTMo6wh/JSTqiIY0Sy8f/DbPxb32xhBJd3WioS+0LJ0vgwCf8oieffMionA+Tqkjxt5ll5ooIvTf0XQotXmgc3zt6byQDbFGZhz1rcS72S7g4eBIMwudcaECYHYRo9kIgz//khpTEhUOYf0ay16XxKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DipWsS9WZazG4URJSigT0eOtNQlwOk06iKtLS1SA+5A=;
 b=O+zIcds7QuUqOw9c8C/f3j763ed5q25eKFIixaOXAalrI7NPN7T7RSXNSDfYvybwjesy1lMAQiCcCQ3OQt+EKwkAwrOp9x9gHZpzsMkeCYaNgdvoOIcSNBdqWVyH7TM9lbsJgETl+ttLOKUUOdAk0QZHh5HjiZNXMuGhVp4o+gj3x/iIBbNR8vAza9gFIa+MWPtz/lO/IaOvp1jRJcl9mmCNe9L/McTrb0lqC14xMHfdiBi5ayvNIGZ0+41uuFBQact34w5xef4dZh5viaW92b+sHCeMuACe3gZ23K4PG6o3gah2RPb2piczL0lQQEj9yQNd+C7jSxxnGhEfMdVSnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from CY5PR02MB8991.namprd02.prod.outlook.com (2603:10b6:930:38::17)
 by SJ0PR02MB7790.namprd02.prod.outlook.com (2603:10b6:a03:32a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 05:03:21 +0000
Received: from CY5PR02MB8991.namprd02.prod.outlook.com
 ([fe80::6c24:88a6:606f:d52]) by CY5PR02MB8991.namprd02.prod.outlook.com
 ([fe80::6c24:88a6:606f:d52%4]) with mapi id 15.21.0315.016; Wed, 19 Aug 2026
 05:03:20 +0000
From: Jaihind Yadav <jaihindy@qti.qualcomm.com>
To: Nathan Chancellor <nathan@kernel.org>
CC: Nicolas Schier <nsc@kernel.org>, Kees Cook <kees@kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] kstack_erase: suppress -grecord-gcc-switches for
 external module builds
Thread-Topic: [PATCH v2] kstack_erase: suppress -grecord-gcc-switches for
 external module builds
Thread-Index:
 AQHdKv35rL7DoRisNUSDvIbYNgWT5LacL4gAgAEHwHCAAKaeAIAASWwAgAIwE1CAAkWGAIACPSQQ
Date: Wed, 19 Aug 2026 05:03:20 +0000
Message-ID:
 <CY5PR02MB8991E2731EDB3A898775394CE2A52@CY5PR02MB8991.namprd02.prod.outlook.com>
References: <20260803181217.GB1067866@ax162>
 <20260813082949.1622045-1-jaihindy@qti.qualcomm.com>
 <202608130942.4FFA5AAB9D@keescook>
 <CY5PR02MB8991D4B48F9391D1849B2CFCE2DA2@CY5PR02MB8991.namprd02.prod.outlook.com>
 <an9dBpYEIb4GWhAC@levanger> <20260814224550.GA3553101@ax162>
 <CY5PR02MB8991C91E71C153EEF452972FE2D82@CY5PR02MB8991.namprd02.prod.outlook.com>
 <20260817185146.GC1249844@ax162>
In-Reply-To: <20260817185146.GC1249844@ax162>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR02MB8991:EE_|SJ0PR02MB7790:EE_
x-ms-office365-filtering-correlation-id: b1cb772a-536c-417b-36e9-08defdaf3094
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|6133799003|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 kVDce5geJvN5W7y8P++0rHGNPMsFNlisPoKHzwkkcVNjU8tLzRdw6eOpaEwJb99Cb1RVhbYc6wsdg5+oaa7IAIelF0giOdy4a/nVifTYsrte/lYbyXjhKH0xrTWF8W+P0CltV7DHLPclVT3BVHpeveUQswvqaiV9i3lLWBaMagY3tWJ7eouY1OFZwtmA386Rw50Y3H/hS+j9dshanwulyRDNiEXtxfJDtLY/6Bs1UHOszh8EkeU0GxAUrEtKEqovUBOE7PhrUJVfcqMM+OVBUwg+/EpKJ9NTdUZaJkldt3MJKl2H00p2HOZtZ4ZBVz+s6OjLNneTcSyaEQuDY2e7ZGTEc+0m0b16QK3LoyFQ3cREoaG5y3zHhcMx8vXJYw7O1sKQDFLDmjs6vO24qmbq8RAD8B4cILm4NbVKhdw2/OguTnZWwuQh+3fAHQiamMyP6um13m1R1Cban80YNDl504gzFPWFJrPndmVec8E0kIjz2v+krBzEOv/+nvDmBwJ3JZqusooD5Wy3hGAjJ3UV7FlJiZYxgmFwoPm+hR0sbY92hhREQnmb/PXu5nN77ojga/GjcTnoAuBxDZhmoIJcKnjqr0hiGcwNhUXq9fGpsrxBwkEdWyiBuFZdNk4uoJGT7CGBNKCMYxfV/2E0Zc7bQPEtGrMQfHbVdKjfsLQGxpExsGYEie34f/cckJ2e31ytR9SfEE/DSeU0pASMCHJlA05X7BKTei9eqKk1usSeIkQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR02MB8991.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3jSynvu74R6xJG4Ie1Qf4/GzB1m7c+839WxFLfS2xgWjAXfi1gelxwWl4pMv?=
 =?us-ascii?Q?Gw/zZjtcLdDaFF4EeZxW4cz7uUdshO/CTJLMgm4wf2fhBH4ytCdJptvqRRyw?=
 =?us-ascii?Q?0qUcwV1Um6rQj6fC3nUGXUnILwG13YF+psnFg0f/NaPaz31dNw9FALrSmN2H?=
 =?us-ascii?Q?wmyhFD+AbVdf83aiI1Q1MDBG5+boJpCsrPj1rc+XCCAOud2D54PgSJfKSlqn?=
 =?us-ascii?Q?GsAvWZXNbKOPn3w9cBOdH7Uc/+PwAA/dV0BE0GZX+3JDLGHOSZmu2WIMTYz1?=
 =?us-ascii?Q?vwxYw6nHB18KnjJksbHcocbN2adQIulhc1dRNCXD9iysWCr+kpluON2pB2u8?=
 =?us-ascii?Q?/fGTJL1tjpFHHHtN2xxZY0k8KHaxm+Q+Wt0SWx1sq9o7BQC5+Q7AVC5HoT9R?=
 =?us-ascii?Q?d0j5WumrBPy/HykuUH0Mq777gI58G2SayQ+NJcvUuFFZz+J7tuldzuVYrEig?=
 =?us-ascii?Q?Q+pvtGcHBGpUH6CVB3d1Oc1bC0HSg3J0nOWv2oyYcEGgfuMyKqviv6FHyYC3?=
 =?us-ascii?Q?FUDzv3TF8fwTV67zVpQD0xXoxJwgWkWMwMEFvZUk2756jXQyrH65Sx/oKLbH?=
 =?us-ascii?Q?SJyVW4u+q/CFhKI56gdwpr3W7SksFkdso2iJvqWl56KFHsnfUYf4duJ9zKf7?=
 =?us-ascii?Q?0Qzraef58UKO3JPf251BFgierCHWCsEJShRqw56SpGUyANhTapViDw85h/rT?=
 =?us-ascii?Q?98x5qWyCtLfWGNEsMMpCHDaimGWxSGVxbcqqSc+9m6rkYAHUvC4ram/6onPX?=
 =?us-ascii?Q?DduSfFpA+c5xvOrDjideBvUjTdhRFIlP332083FOUX4N6K0Hv5P+M01rl3Ab?=
 =?us-ascii?Q?9/rFvV0t6Ybgaq0sHo8xtHKZhtMqcVpYPHRikovC+w9t2XwRkC1Gg8kz1Hsi?=
 =?us-ascii?Q?pdd0FOSbLDqFNdIe39iH5ua0N7vFWLFI6a1t/Y/lgG1AzvslzRaiK3MQ9/XY?=
 =?us-ascii?Q?FbP3wosg3w2k71+MzpjkjFtY+cM7r0IlBPmidHFQoQH4H02w1t+87t8+x9J6?=
 =?us-ascii?Q?jZZjwfp5tlIkhnFwVxdx3/2vIRrF/6sK8SPfF/xeG9UrKRdaGO3DDpPq+5Qw?=
 =?us-ascii?Q?ktsz1reg0dsavQ0UbBm6SEo8o8ZRaUaPOJKNHeq3EqYoJaFxBqk5R+TENc6Z?=
 =?us-ascii?Q?LRBUzQBUPgZcUs8TkQB0/rlJALEjDQJw7Gm+zy39aZCgrAmT6zT59E7nJEpv?=
 =?us-ascii?Q?vOvye2sdmtazNdtlU5ykrfYHS2ImRorEY9IfHShwlD+sAvF9J9qEpgzhzACw?=
 =?us-ascii?Q?VHsWw7xXRA7ltn98aef43m9+KX0uROm3iLoVgSxTu+8zDHNVk8zl70xiZsUG?=
 =?us-ascii?Q?ZbFh+l4tkCdFRjxa/Nqq3nPLygfjR1zVn532S7lzzmUpgqNfMxoyO8TPOHAW?=
 =?us-ascii?Q?YuLLY3Xn907Hx4LIaSynf2gGUVcOf/LQ3FrQIqPbp0FeN5iOABQjcs/U3bAu?=
 =?us-ascii?Q?X44+21bTLIDhEMiTRCmMmWY1nwOMg0DBEa85RhUrI7dmC8wwmxtoIpwnpQ0B?=
 =?us-ascii?Q?/YCbPbmBhH6KpJtU9O8du3Po99yQDX6qYxJ/Me6koIkQQJdW147/qo1fkxW3?=
 =?us-ascii?Q?M9Tlesv7LcNi5vQvXlWCqb6O7KZ5DTaaQ0nX+wrZ0aE55RiRmz+DXaqjcKJd?=
 =?us-ascii?Q?LwDDOn7QHhmUWj6zE+JjGQ3G6RFMz1+5/cTC0NQGgAmPCTuMaAhjvdCJNsFY?=
 =?us-ascii?Q?0U1iLxsI4Xh/OHH5F2Hzqvze1XLkWBCGC2ARdfFLaE16NEKuhyXcyoSweK5e?=
 =?us-ascii?Q?o3FGlrEDuQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	GSkudm9IpL519egdZjCe16uCTKy7jb6AU7BjigRUH0k4y+kAwbRUZ4VnqoovCd6bnerSZOq7S6ea/ACHKML0n87eZ3FwTeNO4nU+ytdXGov3pFqQlnV907EtGUReB6O829EgM+q0o2EXf88/m2gkplp3xxQRfdQ5g8/2KUKVCcQNNH2aiJ6bqQUxTbT+AU52o/+5KAEzMDw3d8mBp9Xrq1Rg6iltVxGaUl1aNsOy7rz5r07cRPDenWGtTG4F++eNTj+iPaTp1kn1tITeKbfvvmHhyuw8x8/LvwQBtNedwmHFumfsfSlQqii+Tt5BaBlXrpSuJRKe9SSRp6lnOFGNTw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ulJkmbETaKTULAfsuE+qiwnXJafOCgh8NsKBK+ynbPfJT+npfZDzb/dKZcyTYXNQmXArAVY5zZn+3QG0sDumdlx6i5PWvfE0szipUEwtj/6maKvTSCfWbhu9F85sEqQnP9wiAEpYTPdSA0a7s60OxOHFac4F4+4WQ+tMEBneo6BbhafhqOrJSnUepchDeq+mZYLEv5e4gRvMB5pXX1cfOe4wEgN2kE9ic3i5NmJUxpVzUV/PCI/3YLAgrIj8TB4lLzFYdXf9pLJ5eTM020keTx0/77pouL65/hGquww5b4qXIOdgzpiCs+dFigrVXkYMXNNbkgHHOrq2VANLssPkfh6l4gRvRKtJqomv72xUETn2du+agsAhwSnMQj3sPsWwrnjF2aB4k1I/7IRIEYHOwkqjjHJnpPiwVys/10gOlMHopuh3uexfoyf92m6pZCVZWyg+BkSmuSyZX5kjajHkvfKwhxedzreRW+KdUogw5n0D4cAMwjlMOq3BIF6c49JTg1GOKwGwL49EU6FOZRlZZGwlQTeLd6nQ2S5DQzWH/tttjT2m+ceTHVFKhaLzrx1oOxmLLS20xMhZMLuV4jYmAvt3wpPLExTSxOfe8XJRnpokzGVj5MNqvjZ+ZVe9u1Oa
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR02MB8991.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1cb772a-536c-417b-36e9-08defdaf3094
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2026 05:03:20.8906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kYwNDRiPj2FLXY/ea3fpCj9n1Njxa5Ir8jegcLVt2kWrYw7xxKMILsaujmAQqpJsXDUggNbrzoRdPokINpIA6k4Lom5WhwlkO8fMAILU4vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7790
X-Proofpoint-GUID: meS8ZvA8V-LtCBAoyX6ph7rzRbht-Ao8
X-Authority-Analysis: v=2.4 cv=bth8wkai c=1 sm=1 tr=0 ts=6a85391b cx=c_pps
 a=FkaiYsdaSJ2J0TbLpd2qeg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=6D2HFp_SYjot_IQn2VQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: meS8ZvA8V-LtCBAoyX6ph7rzRbht-Ao8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAzNSBTYWx0ZWRfX5YLXoSVa8PF4
 jCnFxNiUB5Z540SUYa6xLdCqRS9LDJSrAfVA20IWSIPPP28+HrAVfg9dc02vgZqNSOIxVd3dhqy
 0KCXncoVAWgm6R7MXhV1KFGAq8VHo2JB8eGVWSaKm+A7lRiy+vgcubuN21Ub+eA+Z/1d01FraHH
 pXdPfrgWejXwi3aiBC5dmgD6t4LEre1d2AJyanGG1Xzeo/78ZKRzyv3QUbgmMQQ31ue6hOOQpOr
 2EOq+kD+/2z4dQivlyZTvpFw9uxJFBK+HgOIhyjSuL5X4xX+lMiOk5t1wAfXWG5gt653gn6Je/1
 Lyi2pQ5yV2JKwsnAItZo7L3/cXK3E3O+0cUUdxCXIJXG4Xo3HlDel0bC7fVoXRtSnCefFrd44MI
 y+3hfp2GZE1ExI3qJ3ioh4gr2XZaTGTa9/nWpo2n1sRUGothUi32eymmCL5XapFWMoED9cHHFzH
 Wa48+ao8btDJ5dLSSBw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAzNSBTYWx0ZWRfX0UF8daJNm2eK
 V7OV5sK2O/a46mvhG46Jdq1x0PvwxRm/E631H2J3FwJRUQ9S2ZzKiRA34xcir0Vnu8o7eFa4mgk
 7Q5UXbSI90TQvIu7oZ+yMoHftrTVofg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_01,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190035

Hi Nathan,

Thanks for the suggestion. That makes sense, and I agree that keeping the c=
hange scoped to GCC plugin builds is the better approach.

I'll amend the patch accordingly and move it to scripts/Makefile.gcc-plugin=
s as you suggested. Thanks again for the review and guidance.

Regards,
Jaihind

-----Original Message-----
From: Nathan Chancellor <nathan@kernel.org>=20
Sent: Tuesday, August 18, 2026 12:22 AM
To: Jaihind Yadav <jaihindy@qti.qualcomm.com>
Cc: Nicolas Schier <nsc@kernel.org>; Kees Cook <kees@kernel.org>; linux-kbu=
ild@vger.kernel.org; linux-modules@vger.kernel.org; linux-hardening@vger.ke=
rnel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kstack_erase: suppress -grecord-gcc-switches for ex=
ternal module builds

WARNING: This email originated from outside of Qualcomm. Please be wary of =
any links or attachments, and do not enable macros.

Hi Jaihind,

On Sun, Aug 16, 2026 at 08:11:01AM +0000, Jaihind Yadav wrote:
>   Would it be acceptable to handle this generically for external modules =
in
>   top-level kbuild (`Makefile`) instead of tying it to kstack_erase? I wa=
s
>   thinking about adding:
>
>     diff --git a/Makefile b/Makefile
>     @@ -1057,6 +1057,10 @@ include $(addprefix $(srctree)/, $(include-y))
>      # Do not add $(call cc-option,...) below this line. When you build t=
he kernel
>      # from the clean source tree, the GCC plugins do not exist at this p=
oint.
>
>     +ifneq ($(KBUILD_EXTMOD),)
>     +KBUILD_CFLAGS +=3D -gno-record-gcc-switches
>     +endif
>     +
>      # Add user supplied CPPFLAGS, AFLAGS, CFLAGS and RUSTFLAGS as the=20
> last assignments
>
>   This would avoid per-module changes and also avoid coupling a generic
>   compiler switch-recording behavior to `CONFIG_GCC_PLUGIN_STACKLEAK`.
>
>   If this direction looks reasonable, I can send it as an RFC patch for r=
eview.

I do find this direction to get more at the heart of the problem but should=
n't this live in scripts/Makefile.gcc-plugins?

diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins in=
dex b0e1423b09c2..9b9899580571 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -8,6 +8,10 @@ ifdef CONFIG_GCC_PLUGIN_LATENT_ENTROPY  endif  export DISA=
BLE_LATENT_ENTROPY_PLUGIN

+# Disable recording GCC options in debug info when building external=20
+modules to # avoid leaking absolute host build paths=20
+gcc-plugin-cflags-$(if $(KBUILD_EXTMOD),y) +=3D -gno-record-gcc-switches
+
 # All the plugin CFLAGS are collected here in case a build target needs to=
  # filter them out of the KBUILD_CFLAGS.
 GCC_PLUGINS_CFLAGS :=3D $(strip $(addprefix -fplugin=3D$(objtree)/scripts/=
gcc-plugins/, $(gcc-plugin-y)) $(gcc-plugin-cflags-y)) -DGCC_PLUGINS
--

Otherwise, this would apply to every external module build, not just ones t=
hat enable GCC plugins.

I defer to Kees on whether this is actually acceptable though.

--
Cheers,
Nathan
