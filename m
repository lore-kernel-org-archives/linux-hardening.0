Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E01301717;
	Wed, 18 Mar 2026 07:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773819936; cv=fail; b=ETehfNG8gvtbDHD7888QdhosoBwFe5C1I7awr3WcXpnGJ03qgdo9a3+072ZBgii+9FTIZH3d3hSaxdv8GvkGaik6mx5u4j6hZEtwmQ52XmRuhwshU90EvyDnFfFC2242zxh+d4L6w7GdnGT4573HQs/lfpWNexFHpH6Od2hT1qE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773819936; c=relaxed/simple;
	bh=OfSNNfGWwfVwg72gNtxu+a3rdlC0VB6ueMb8d6f/orQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pgbNDhlfd/vMtJJ5wzk5zkUCGeZWwf8oPn7O9bD5QC+jsURDbLjqtoikfl3nm0+b8C4iW3H9U/1zCQx9XnuZ/3J71gI+lvpl9WdpN7T0nuiVAz3Q2bgiFvml+yd+Xsok1gS9dpIKQ5+BNlYits08ftI766WLQaXH9hV6sbOFd/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dROWrqEd; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dROWrqEd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773819935; x=1805355935;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OfSNNfGWwfVwg72gNtxu+a3rdlC0VB6ueMb8d6f/orQ=;
  b=dROWrqEds4eR7v9GONI+YD01TRJR2AqcICzmfMzlpnd3snkLktOjm9bA
   QbpbyWu9XmrR9uzDviCZi4PCOFuHlVq4f982pG9SYAXiovZt1zZkp4kel
   Lhuy2e6JV80LromS39lBqsKVi3YlUcUTloJUl3AZCMoUx6+ZyCRb872Yi
   aNV8WRKIjGUqx2FL+VOC8usZMC5Mtahki8FEIpaqiblKsEtMoHLKdCk39
   etX/0q+ffXBMHddnMiH2uPb84stRPwgPdQMn39WOpoLZPKmNU21uRVSc5
   5OYo/OFF4QHYLKIwc7Q8FzWcGDvPsxnV0ZtcpHFKFdbVNvD649IeveHDE
   w==;
X-CSE-ConnectionGUID: JkJLHNc/RiChSD2cAcRqmA==
X-CSE-MsgGUID: 0yUCHS2wRwuppqRM0PKSGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85945223"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85945223"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 00:45:35 -0700
X-CSE-ConnectionGUID: 5yvb9OaxSFei5g6JMpHyjg==
X-CSE-MsgGUID: u00+ZrzyRo29sr3ehTUcgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="222749891"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 00:45:33 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 00:45:33 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 00:45:33 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.39) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 00:45:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTpFXO2VNued2D4tEOINt2G3DRKz+02a7vV89dohJd8Lf0EwvCNam9GQWyFTngv2iH6sfevf+ty+Sm8oSNOPDF2pLdb2b4rup0WVFpu0y5rAlVbfEQjxnOkoThqZrxpOw85gmUyraPSvrYppGNeP/iMXpuCooCNF78mt45vvRUro77FBqRw36kwcLx1tTSwnEQDQaQ/t8ndXnVLSXC7BIAt8kQDqe7sxYICSaKiJK7mk+/AXN5p/T3/oyHTlWcWtibAOxOFgjFZY01UO+GC6Sjqu92a1mUtUvcv7UUYXjs4tN88OPhLb9+8nnuyzRkkg2Q4pNFeifu3z518/jCd/IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfSNNfGWwfVwg72gNtxu+a3rdlC0VB6ueMb8d6f/orQ=;
 b=WOy206KAYYVrCv7IUc8i8Il08tpz+qB09tqzqoHbryKPNXCey69T7cpfhyQOg624/QuNwCvtRpm40g/ihw+QB0SH4mxE+zIWizGT13k+KeN5r208uZQU+neSbFPOKOqPooHlZ2MFLJB+ir/dMGjg1CXrUNhv50W8NYa0U7EWz8G0HhPlvLu0cJdJeVep5xL50ht+uyVn278Y7WEa81iEcSCUD9TJeArOv6uqO1jUzagcplynvTgrdNm/R5Cr6yvUEhM5SP+SZnGAuy4Dckh/MbKQz9RLMib70NCOcyk2htltgG7duc1DzDXitI9JrJRdWC5wzVDRNlfi3j90jFhInA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DM4PR11MB6191.namprd11.prod.outlook.com (2603:10b6:8:ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 07:45:30 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Wed, 18 Mar 2026
 07:45:30 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
CC: "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Randy Dunlap
	<rdunlap@infradead.org>
Subject: RE: [PATCH v3 18/22] docs: c_lex: setup a logger to report tokenizer
 issues
Thread-Topic: [PATCH v3 18/22] docs: c_lex: setup a logger to report tokenizer
 issues
Thread-Index: AQHctjlFMU9+1Xuhnka7k7aSVSE0vbWz6cCw
Date: Wed, 18 Mar 2026 07:45:30 +0000
Message-ID: <IA3PR11MB8986A8AEE4B63E00E59CF13EE54EA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <cover.1773770483.git.mchehab+huawei@kernel.org>
 <903ad83ae176196a50444e66177a4f5bcdef5199.1773770483.git.mchehab+huawei@kernel.org>
In-Reply-To: <903ad83ae176196a50444e66177a4f5bcdef5199.1773770483.git.mchehab+huawei@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DM4PR11MB6191:EE_
x-ms-office365-filtering-correlation-id: b27e7563-b134-4493-a954-08de84c2541d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: jUllUmhKXZ8ZsE0nzjcxQ9sPoYOW6iPVu2ukr3BHCE8IRZXNMz6zVCwAGHfEnnbcAY4Yx35DKrIO7DNExEBt3mDIJtPPfd7uG1zHVTOH2gBuHRimxWh16L3BvH14yMWG6kTAYJjLLYOKcYoEU1cjAtUrTQM5mZKLJuH1qsTMlAASRS9tIaMFReluC1Xxy8bBSRB3XNXSkIcgl/HBKk+/Ca74+bQuX1lqWHOtkKEf14eSNe27DfInK6BB1ab3eEqK92aR6GFgFIabb1TCBmemxs4CDR9yu7ise6fEHY/C0VumS/64ABpGUVqtp77z8Y8VwkkSP3JTygugIZpwHTzS/n736949Qogo6QLVWPc3cGtL2CwMG2/Xo2TJfvGCJIIh8nXvdqdpC9iBy8IBI6GDd2dk7qZkIJxhaI3M/H1C+QPZ9X0r5+/ddT3mhHZeEvRTsNGNyshBx/bBTwmV2hS6sJ/XDssPIcec0lRD+0TVkpk+XvjOsLzYgUKr8W8/2E+D+3DmpZFY8LHonMNwhS3VKNKLJ4oqRqAWwCNjrwguoo1IMZWe71n+Cc8IEQIZJJNykVRltFHnb3m60luyHoG6pPK8AQdMG3AMDX1YLJspKqdSprZdjqCjhfRoMNMtC+GwrTebepOrq1UC1nrkB/8TuT1skeg9F3BCm+eo7nEtyEZPCghNAP/PaufygvrCA14NcqeEqgeMLXN2U77h3d5tNMnwcZyuQ57OJ6SFSQM0VkPkVloA8PqLpwCAOjS3q6LlyzZRdb/vwcTe3TKA7I7op62K3/cdtxBxTJtD8rTseWU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0RQZTY5QmRFVEc5L2x1bkV2SmxveGQvSGxjU0pTeTZZb2xvZGE0R0VYMnlG?=
 =?utf-8?B?SUZvNm5iNlcvem8xbXB3NGVDSkJhK040b0FQTXFpSlJQamZqU3c3VXN6SXNq?=
 =?utf-8?B?bmdLT1pHZGw4aUhpWDN5Nm9ocUxVK1dua1hRNUpUS0EzRzNNYmZiTm82WWh6?=
 =?utf-8?B?UElJNHFKZDM3N2ljTExjQk5RUTd5d0xnNlVseE5KaVJTYTZQK1VEbzFSL3BM?=
 =?utf-8?B?YnB6YmdqSWk4WWxPNllldW5GOStiRDVxaytzM2dNTFU0OXNrTnMycHkxemhp?=
 =?utf-8?B?UWQ1VHR3QVRMTmRYSUpWZHNQeHFwYTdsNE1FZksxUjNqRFRVUWZPSHJaUzBM?=
 =?utf-8?B?d0VXVU1WOUFGZ21wSSsxSFJBNTUySlJjVDRZa3h5Q1p4Q2tkc25JTWZ2eGlW?=
 =?utf-8?B?bEU5UzJ0NHN0N015SlV0OTNPRlg4M3I4OHRWYkdyMnRsMkNsTlh6clFTdFlT?=
 =?utf-8?B?MTVRU09sbjZnb1AweDdxejFqa0IwTmk3eXY4MmROSVB5RmJ0OFk4dHNYV3Mr?=
 =?utf-8?B?MkFsMFhoNUNEcHpxOGdEQ2FEbndad3VITEhsMnhVV3JaYlZhZE50K0JEWXdM?=
 =?utf-8?B?aG9vN3hyQWtLbmVjaEJLQWlHdGNFVmQwVkNmRjk5d211NnhIeEtpMlpqSUI2?=
 =?utf-8?B?VGtNQ2s4QmllRUFLQ1crMzdxS3U4V0kvc1BkcnZZdG8vMmRaNVVDUEpmODJo?=
 =?utf-8?B?VlNEY0tpL3hxMm9SY0lSWVJHSmpCRW9JZ2taSXIrTUxMOXdxdXpLQU1Eb1k2?=
 =?utf-8?B?Mi9PUTF2ZU9kMmZTbGZ5SGlnZTBDZUUzWmhCVFdGYUd4Qm5XdlkyTXFwT2dR?=
 =?utf-8?B?NWRDUjQ2aXJtamVIZ2ZSSWJXZStqYTJ1c0lNM01vOEZuSStHcWhWWHZxTzRZ?=
 =?utf-8?B?N3oxMnNCYVZiSVM4TFk2ZzRZWnRzcnVsMEw5NXF3Y0pyUjJHVEtYMkdEZVBT?=
 =?utf-8?B?RzBrWVBYSldPakczcnlMU0ZyNW1wcVgvYTRNaW9JOGZxTnM1R04ydXNldThD?=
 =?utf-8?B?V0I2dGtTeEpxdW8zZEVyYXdxRFVMUEdaMGZMd0ZZVUpoMG1sYkFVcnluOTRz?=
 =?utf-8?B?MkVxZkI5c0h4VkJCOWJLbUJPTC9HQzZUODl6enFSZXMvRG0xQS9sYUFpaUc5?=
 =?utf-8?B?UUwyaVoyd1pBNkg4aGM5bnYwK3NtR21SQmRtYklyRjZKRkFMRFh1M21kRVVm?=
 =?utf-8?B?TmxyVTFyWlN2UTJ2U0wxcEZCNFBNdDUxMnhET1hFU1oxZFVHWnU3UFJSMkJU?=
 =?utf-8?B?d2R5emdOOHA1TFB5c0V3K2J1Y0czdkNUekpNd2xuclJrb09PV1I3Ty9wOFd0?=
 =?utf-8?B?ZWkwTEY0MjdGT2J0Ni9pVEVsYUsrZENONEhOVjlqUU1UZXE3ZUVyMEtjN1hH?=
 =?utf-8?B?Tjg1dytXODZYbE9rdjVGaVgzRm9UMlRLNS9LdnQwQWZ4VmJhdjNLODZXUTcz?=
 =?utf-8?B?ZzgrL2wrbWpldDh1THA2WW9EYkZMMlVLZ3NFVmtWcGpyZFFFbkVpcGx0b3Ri?=
 =?utf-8?B?R1ZFTEZlSGZ4VEJVcU0xUnhIV3I0SElxbk1YUXJZVmZiTUpPZGNrbEg1SzNX?=
 =?utf-8?B?MDNtRXErZlRyekF6U05hR3VHYjdRdTFPc0twNC9nSjhxRHV6MEpIZlRmTXhT?=
 =?utf-8?B?VVorVG5XWTBHc0grclNEakRNUXVrWmlyQ0pGUm1XUENlVlJ2R2xDaGo0NTAr?=
 =?utf-8?B?SEJWem85dXRNU1puUHhLcmpzdmtmS0tDT2FqRlJtaUVHTmlMQnFNNUc2Ym9B?=
 =?utf-8?B?SlFEZStROTh6STFjMVFxUmE4aFNzVTF3RHNMSjYrMGFvMGpabzdkampGK0Vy?=
 =?utf-8?B?WDdsam9Yd2Q2d1A2WC9HWU9pSXFuZDUzVk9EMmxGUW14VEYxV2Q2cEhra0FF?=
 =?utf-8?B?QXBqOExWWHdHZGxmVzRVVFgzaG9yZDdDL2hiS2t5RnBqV1lYcjNWa3pBamd2?=
 =?utf-8?B?ZWtqT1VtcDRxR0hCS3ppTUVybE5JQnBQR1hCRjl2TjUyclNnZ0NITGlmczdv?=
 =?utf-8?B?SW50SkM0N04xcWduKzFCQ3FnWU4zNXVWcFJ5TXN6WHc5dUZFK1Zmc2g3QlN5?=
 =?utf-8?B?dDlYWDZuUEh2NWFFaUE3UlppUys4UGJveXcvd3lSb0NpU0xuWFNQMkJHMW1l?=
 =?utf-8?B?ZmREMkhJZkt4Y3VrRzdEYWFBOWdyaTVTd1g0OXZTd3ZYcytkbkRyRjdKQnRu?=
 =?utf-8?B?Nit4NFNYejR0R3BOV3dna1FwcXFYcnpscmJFYjlvVVYwWmR6OUdISk0vVHZ6?=
 =?utf-8?B?bXBVaFRDZS95UjhtRFBrWXJ4MXdhYlNJQS8wNjUrTVhrOVFKLzFsbzF3bzNh?=
 =?utf-8?B?S2MvTERXeFlsVVJOMk9lS09yaFpmOVVTSllvcHdZbVNjeXBhQlFvNmkyeHdD?=
 =?utf-8?Q?yPzSm/MhQFexVHZM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pInS5OywG8woLMu/OZ6xrB7HuKULxWJb5Kqm+i35isvVrC7Srdw15cr2zad7GW2OqSRdOFohj/2gYelJ1Vr6d9NQfCG+aOGqn4DvR5eNfnWI1afRkVDCAKJoi2js0NgcVF1LJym3tz5Ym6ZOCxTRalpUbuMqfS2KJnHvPrJPTo/cy9/Xt/LGT314Oy7uypfi1EdlDHPUbAnv5uf0pQPCgbM2T+L0TZo+uoWgJa8iLRYDD9FxZBxAp5o10aMCt56BFZycDc3+7NG0NAgzeDFfbhRgyk6e4GK/YtaIeVq7/DITt6feZhE6ByhDIVw+nF5S9wou0ysWy+115Zc1Ws6Kyw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b27e7563-b134-4493-a954-08de84c2541d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 07:45:30.2743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ujDqnEJWheupq8vjfwNbpLTe204/WePssKemqxnBOsNDchCpwiJcFx+H5v+k/88NeUnjvKEQj1pjE890smfiO04OdNupx+Ohr0ihXVbRCvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6191
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWF1cm8gQ2FydmFsaG8g
Q2hlaGFiIDxtY2hlaGFiK2h1YXdlaUBrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBNYXJj
aCAxNywgMjAyNiA3OjEwIFBNDQo+IFRvOiBKb25hdGhhbiBDb3JiZXQgPGNvcmJldEBsd24ubmV0
PjsgTGludXggRG9jIE1haWxpbmcgTGlzdCA8bGludXgtDQo+IGRvY0B2Z2VyLmtlcm5lbC5vcmc+
DQo+IENjOiBNYXVybyBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWIraHVhd2VpQGtlcm5lbC5vcmc+
OyBsaW51eC0NCj4gaGFyZGVuaW5nQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgTG9rdGlvbm92LA0KPiBBbGVrc2FuZHIgPGFsZWtzYW5kci5sb2t0aW9ub3ZA
aW50ZWwuY29tPjsgUmFuZHkgRHVubGFwDQo+IDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+IFN1
YmplY3Q6IFtQQVRDSCB2MyAxOC8yMl0gZG9jczogY19sZXg6IHNldHVwIGEgbG9nZ2VyIHRvIHJl
cG9ydA0KPiB0b2tlbml6ZXIgaXNzdWVzDQo+IA0KPiBSZXBvcnQgZmlsZSB0aGF0IGhhcyBpc3N1
ZXMgZGV0ZWN0ZWQgdmlhIENNYXRjaCBhbmQgQ1Rva2VuaXplci4NCj4gDQo+IFRoaXMgaXMgZG9u
ZSBieSBzZXR0aW5nIHVwIGEgbG9nZ2VyIHRoYXQgd2lsbCBiZSBvdmVycmlkZW4gYnkNCm92ZXJy
aWRkZW4gLT4gb3ZlcnJpZGRlbg0KDQpPdGhlcndpc2UsIGZpbmUNClJldmlld2VkLWJ5OiBBbGVr
c2FuZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCg0KPiBrZG9j
X3BhcnNlciwgd2hlbiB1c2VkIG9uIGl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF1cm8gQ2Fy
dmFsaG8gQ2hlaGFiIDxtY2hlaGFiK2h1YXdlaUBrZXJuZWwub3JnPg0KPiAtLS0NCj4gIHRvb2xz
L2xpYi9weXRob24va2RvYy9jX2xleC5weSAgICAgICB8IDE2ICsrKysrKysrKysrKysrKysNCj4g
IHRvb2xzL2xpYi9weXRob24va2RvYy9rZG9jX3BhcnNlci5weSB8ICA0ICsrKy0NCj4gIDIgZmls
ZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL3Rvb2xzL2xpYi9weXRob24va2RvYy9jX2xleC5weQ0KPiBiL3Rvb2xzL2xpYi9weXRo
b24va2RvYy9jX2xleC5weSBpbmRleCAyMGU1MGZmMGVjZDUuLmI2ZDU4YmQ0NzBhOQ0KPiAxMDA2
NDQNCj4gLS0tIGEvdG9vbHMvbGliL3B5dGhvbi9rZG9jL2NfbGV4LnB5DQo+ICsrKyBiL3Rvb2xz
L2xpYi9weXRob24va2RvYy9jX2xleC5weQ0KPiBAQCAtMjIsNiArMjIsMjIgQEAgZnJvbSAua2Rv
Y19yZSBpbXBvcnQgS2VyblJlDQo+IA0KPiAgbG9nID0gbG9nZ2luZy5nZXRMb2dnZXIoX19uYW1l
X18pDQo+IA0KPiArZGVmIHRva2VuaXplcl9zZXRfbG9nKGxvZ2dlciwgcHJlZml4ID0gIiIpOg0K
PiArICAgICIiIg0KPiArICAgIFJlcGxhY2UgdGhlIG1vZHVsZeKAkWxldmVsIGxvZ2dlciB3aXRo
IGEgTG9nZ2VyQWRhcHRlciB0aGF0DQo+ICsgICAgcHJlcGVuZHMgKnByZWZpeCogdG8gZXZlcnkg
bWVzc2FnZS4NCj4gKyAgICAiIiINCj4gKyAgICBnbG9iYWwgbG9nDQo+ICsNCj4gKyAgICBjbGFz
cyBQcmVmaXhBZGFwdGVyKGxvZ2dpbmcuTG9nZ2VyQWRhcHRlcik6DQo+ICsgICAgICAgICIiIg0K
PiArICAgICAgICBBbmNpbGxhcnkgY2xhc3MgdG8gc2V0IHByZWZpeCBvbiBhbGwgbWVzc2FnZSBs
b2dzLg0KPiArICAgICAgICAiIiINCj4gKyAgICAgICAgZGVmIHByb2Nlc3Moc2VsZiwgbXNnLCBr
d2FyZ3MpOg0KPiArICAgICAgICAgICAgcmV0dXJuIGYie3ByZWZpeH17bXNnfSIsIGt3YXJncw0K
PiArDQo+ICsgICAgIyBXcmFwIHRoZSBwcm92aWRlZCBsb2dnZXIgaW4gb3VyIGFkYXB0ZXINCj4g
KyAgICBsb2cgPSBQcmVmaXhBZGFwdGVyKGxvZ2dlciwgeyJwcmVmaXgiOiBwcmVmaXh9KQ0KPiAN
Cj4gIGNsYXNzIENUb2tlbigpOg0KPiAgICAgICIiIg0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvbGli
L3B5dGhvbi9rZG9jL2tkb2NfcGFyc2VyLnB5DQo+IGIvdG9vbHMvbGliL3B5dGhvbi9rZG9jL2tk
b2NfcGFyc2VyLnB5DQo+IGluZGV4IGVmZDU4Yzg4ZmYzMS4uZjkwYzZkZDAzNDNkIDEwMDY0NA0K
PiAtLS0gYS90b29scy9saWIvcHl0aG9uL2tkb2Mva2RvY19wYXJzZXIucHkNCj4gKysrIGIvdG9v
bHMvbGliL3B5dGhvbi9rZG9jL2tkb2NfcGFyc2VyLnB5DQo+IEBAIC0xMyw3ICsxMyw3IEBAIGlt
cG9ydCBzeXMNCj4gIGltcG9ydCByZQ0KPiAgZnJvbSBwcHJpbnQgaW1wb3J0IHBmb3JtYXQNCj4g
DQo+IC1mcm9tIGtkb2MuY19sZXggaW1wb3J0IENUb2tlbml6ZXINCj4gK2Zyb20ga2RvYy5jX2xl
eCBpbXBvcnQgQ1Rva2VuaXplciwgdG9rZW5pemVyX3NldF9sb2cNCj4gIGZyb20ga2RvYy5rZG9j
X3JlIGltcG9ydCBLZXJuUmUNCj4gIGZyb20ga2RvYy5rZG9jX2l0ZW0gaW1wb3J0IEtkb2NJdGVt
DQo+IA0KPiBAQCAtMjUzLDYgKzI1Myw4IEBAIGNsYXNzIEtlcm5lbERvYzoNCj4gICAgICAgICAg
c2VsZi5jb25maWcgPSBjb25maWcNCj4gICAgICAgICAgc2VsZi54Zm9ybXMgPSB4Zm9ybXMNCj4g
DQo+ICsgICAgICAgIHRva2VuaXplcl9zZXRfbG9nKHNlbGYuY29uZmlnLmxvZywgZiJ7c2VsZi5m
bmFtZX06IENNYXRjaDogIikNCj4gKw0KPiAgICAgICAgICAjIEluaXRpYWwgc3RhdGUgZm9yIHRo
ZSBzdGF0ZSBtYWNoaW5lcw0KPiAgICAgICAgICBzZWxmLnN0YXRlID0gc3RhdGUuTk9STUFMDQo+
IA0KPiAtLQ0KPiAyLjUyLjANCg0K
