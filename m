Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBA72033A;
	Mon, 31 Mar 2025 03:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743391696; cv=fail; b=CbJIwqF1u2fJX7crJtM2KMizQg4sfeVnayFJFlEwPaIFMDN4N6rWmmLdBGWC3lrvlttWXjtS8W2YFrmo7OwDs7Jn/OAJD7lixxWFj67cC93INDBc/SrwJoa7Idvg5JA80gMLkWSTIPTx49nDHGFVMABsMdqZ7YsGEoePyDvDwwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743391696; c=relaxed/simple;
	bh=e8lMaqWoPS1etCDp+XIZuS+3hG+T9ivTZXR28UxdzPM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rs8xc6TZEmNpReWiIJ1h3Y8SCls7fw1q5JfG62yRxLOBNgmT95yJzJhSS2gngFRF3czsCjtr0icwLXDeze0XdnFVx6aFbuKbC8NCyFRor2SKHZ8UGWSBMcCm5MRjT4UhF6VXtPQLJTg2lmyOTi5qPG34W8SX2B0Uro4pcVZ+GkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qmI1vDv1; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qmI1vDv1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqzdYS7G9Mx0H4kteo8i+rYA6adFOG2DjNyVcTrf7ZWLvHeq1F3xiUHf8dyw2a7uJgD5gyqSL/av+qjgOL4ugPwK16aBTt2Yx8sI1pKt0zPBou/IFZ0Kzstr43r+cYYrH59Z5heyr5Y5XVmc0JwjkvkKnJ9XoSyCbaWp5vsgSoiUarRkGYHMQn72BxJRvKhXYjsyYMjRuHnCdy5g8ZvwhSACDpphcMk3RaOoLV3OSV4vtoD5bQWCZz0vGd6MLG+S0nZVmyZOvnq58VD1puH+hX5IAOmEpaDP/zl/dcJ64ls93C/PDvJhR9YgDcnFCb1khHtneFfnH/mf9ZBYCuAuPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8lMaqWoPS1etCDp+XIZuS+3hG+T9ivTZXR28UxdzPM=;
 b=supGuljXjrZSQbEqLRACUGpoCZhgfc+xiXVrMUF1SZeukJrVf1BqAGt9PD5NcAGeTIgMaP7MgXL+dsNiktILLBKAOX79daeNsM1Xb8lMFxTMCifxgkU+O3/Isirlun4jSpaWTZzHpG4lvN11aw9NVB5uaE14z5TF6jUs/vQJrcr9SX/qIiVx8OUKyYFsDXq6WKr12w3zzL2etxRIF4xChyI55cEFoVoOTIxOR137EwXw+QKhW4kzTSJGXO3cuEUtT7BT4K+qpZWmg3hYROVDYtniAhRy9xMXCd0Kz4vhLD8ipE6jku7GHmMq6ZfQ66UKkIhuRTUgL3/w9DEfvT5b7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8lMaqWoPS1etCDp+XIZuS+3hG+T9ivTZXR28UxdzPM=;
 b=qmI1vDv1WoYF3BdAX7nTb2r8XCU0modJCVNAjqJu4rLRlWIR3r6BjtZFvNyCkw3iOh/ltqlhsE0hBUujKJdL8guROPEKz52gizEf8bJj0mJCw6JbT2iC25sGdFvTLTqM8uPvVa93sDYZyN2hvPbKymfaaLjZNi3vyUtvuoP8FKtLsS6vIptlcTf68wRcGeHWYNnf+sbIJGWP8W5PsfNhQ0GFuVYwSE5L700lTBcs5lTcSpzdUJ9UQF9g2vhdgMHkAHhnQK0W8enX00NFt++Zih7HMeCs3N6C95WQYPz9hbXAceR2Xx6EOPIyZzeyVLQ3httgNBORbkX6EHCxYhJEjQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB7543.namprd12.prod.outlook.com (2603:10b6:208:42d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 03:28:10 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8534.048; Mon, 31 Mar 2025
 03:28:10 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH][next] nvme-loop: Avoid -Wflex-array-member-not-at-end
 warning
Thread-Topic: [PATCH][next] nvme-loop: Avoid -Wflex-array-member-not-at-end
 warning
Thread-Index: AQHbn+04EjeWqTTc6EaXtKliwIRMjrOMmf6A
Date: Mon, 31 Mar 2025 03:28:10 +0000
Message-ID: <cefca512-2368-46ea-84f7-1e59fd1436d7@nvidia.com>
References: <Z-axRObjXYjIHGQC@kspp>
In-Reply-To: <Z-axRObjXYjIHGQC@kspp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB7543:EE_
x-ms-office365-filtering-correlation-id: d5ef168f-4d08-4268-96d9-08dd70040fb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?REdSbVZsME15UGRTRXZTbW9BbTc0ZEVoODVvSWE1UXlSRTBXOERsaXo4LzBW?=
 =?utf-8?B?ZzR4RGFZUlh3N0dRK0w5NDVSd2tZUnpVelJOakZqR0lVeFZoU0l4b0dtYVNY?=
 =?utf-8?B?TjFqTy91V3k3Z0g4ZTdkY0R1QzVUZm05azJTS3dXRHBvc3FtMmY1N0JLcnNo?=
 =?utf-8?B?RXNqLzNlTUZlSERtRE1KQnY3ODZYWmNScEdYeU1sRzVTc05OM1FiUWIrb0Iz?=
 =?utf-8?B?M1ZmVVFJMDVRY2dOVFV6UzJXNGhiYkxEcVFWQmtzcmNCQU1zYWF5MmxiZEpZ?=
 =?utf-8?B?aDduQW9zcUxMNjhHUktjRE80dm1DSTlhT29DM0gyTjREbzFZSW9Rak8yMU1U?=
 =?utf-8?B?YWswa1ZhVEhLdWtKSHlONWtSYVlyTHZabm5kT0NoTkNaM1VmeEhnMnIwY2Rz?=
 =?utf-8?B?UlNOWmF5RkV3MHIybGFMS2hCdiszN0tBb2pIY1RhMEtXbnRuZ2p4b2NWRE9N?=
 =?utf-8?B?MVBwY3JrTThiTHY0cE03ZGtoYTR6aDRoOGV3SUdkZUV5dm5xL1phdnU5TFBJ?=
 =?utf-8?B?ZFl3b3BCb01uR0FYTWJyT0xjTWw4RU9YVUd4ejFUUlhnVzRHVVpzbytBYSs0?=
 =?utf-8?B?SjZYcUFYM3JrV0U3eW5LaXJEZmhGUi9acFRmbWk2UXBXclo0dmtkVm5WN0Yz?=
 =?utf-8?B?bUZBdEQ3dW5tZVNYQU53RTVIRzFyVE1INFFrdk1qNnNnbis3V0NValNSUGJP?=
 =?utf-8?B?aUZGZHdVSWV0bElTU25NU2lUYjRwKzhZZDZIdWdJamszejhpMm9kRkJ5TGhR?=
 =?utf-8?B?OHdJTWdUWmo2clQ2M0I5YzlQY013dWZIblA3ZkdiYzZPU3F0VWtZTEVXcklz?=
 =?utf-8?B?SzV4cG1ORWEyb21GUjZMek5oNWdRY05aZGppSG0vY21SNGQ3UHRaU3VVSm1C?=
 =?utf-8?B?ZWtHSjQ2Qm9paElmdjRtU2NRQ29scGM2NURNVFBXZTgvUWMxbCtCS1h3bXZO?=
 =?utf-8?B?dlVFUUZhVVRVNkJXbG0wd1g5MzJkYUN0UG4yNzlubXBUQXluYnYzQmR3MnFM?=
 =?utf-8?B?cjFwV3FnZTl2U2pTZDFmOFJJZXNvVERuLy95L2dIUW53b2o5VmZsY0NZNTFt?=
 =?utf-8?B?YzV1Uzd2Q1BwSllwcEEvd3NFWlVNYUM5czlHQkRLcVJrOEp3d1MzTjkrY1FH?=
 =?utf-8?B?UFVVZ0hoZTRab2tZcDBOb2pFV2xqUDdoK0xQcTB1cTk5a2JvazJrNFhaS2RG?=
 =?utf-8?B?MUQ5dldnVUpabm5hdzBVVzB4WU9oMzBoZVRibzIyRmF3aE9yZGpTMG5nM3lX?=
 =?utf-8?B?aG9UTTdhZERPQXVaNXZ1OW15RnBhTFZmLzBnMVIycEFBV2gzQ2kyNGhMaWE4?=
 =?utf-8?B?c3RBUDBjSzVRUGdYaDhvclF4M3pDWlI1TFk5c3JEb0tYWTRVdlE5ZGJVTWQ2?=
 =?utf-8?B?VForY1lFeFhpOGF0UUhhSDZndWhmYTVRNmVnTUFzQmd6VnJFQTNieVl1a2JE?=
 =?utf-8?B?czM3Njl6dno1dDAwUW8vamJjbUl2M2ZiUnRmZHIrM0I5eVROa0tSWVlHOHc5?=
 =?utf-8?B?UmJoc2szdVdYK0F1R2s5ejBqWUhjYXBLNkVkcS92eTRLYVlCL0h3djJiT2Jm?=
 =?utf-8?B?TW0wcHNrTWJ5K1l6YUR5SFdGRkN6N2RuMHVNRmNuak5QbUFzV1JNTU4wR2x6?=
 =?utf-8?B?TVBCNVpQVmllWVpTVTh2V0F5bklLTjdFMDhIZGxEYjlZOC9ZMUdGeFR3OWZR?=
 =?utf-8?B?VkUzdit0MFNYUVhFRkkzWHdvaWo5QW5WOFB4dm9UYkYrUXhVeHhweStYNmlS?=
 =?utf-8?B?dU5xbnRITUdqL2p5N2FjR2FUTTQySUlCRlprd1pneEQ4NHhHOTZ0b3Y1SnBa?=
 =?utf-8?B?QXozZGV3RFlxNlVIRVhlYTl3RkFma05IeU9yVkRXbHZDYU5sYzlTOHk1aHNR?=
 =?utf-8?B?UGwyR3VZTkgvdDN3R0F6ZXI0c2ZzMm5ZVEJCSEFIWTM0Y1dOMk82OWluditU?=
 =?utf-8?Q?tvGwkCE1QXT3i4fKC/hf5Qz5X5qsXHD7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eGo0KzBtOFRyRmlGazZPeWxFMHJCd0dFWTV0eVp3VnFnOE1TMDBJa1RXM2pk?=
 =?utf-8?B?VmVEQTNoaGovOG1qZTk0YnhsQjFYQnQwa1ErNFdnUktDNHE0alZKS1dzRlVp?=
 =?utf-8?B?aW1yQy9DNDJXbEt3aVNHQTFla0JMU3VUZ2JMdk4yemFrQUtpdjBqMzFtWTdO?=
 =?utf-8?B?NHFxcnV3TkRONTBXYmU5YXNMcnJHMzJZQ21tODhnR0JlNExGTGYrTGdzaGM3?=
 =?utf-8?B?UGZyVmtjWXdXRTJDcUJWKzcwanJEZWVaNFJoNDU2S3JIZTQ0VW5lSlJVSndw?=
 =?utf-8?B?Z1FMYVp3bE5zek9KdlpadDczbjcyOCtkY3N6ZStDSitsMkdJZ1dCRmxZMDJx?=
 =?utf-8?B?SHpMMEt5OTZ1clgwL215dlV1OEZXMXVHckVwYWM3eE51UXBOV1RXeU92N3Bo?=
 =?utf-8?B?eTh6b05hajZYUStmekhDWTlndmVISDNOeENlLzJJYWJOL0tFK3JpRStPUVha?=
 =?utf-8?B?NlBZVjlNVDhDZGNXZk9HcSsra1FERDQ1dm1VbGZ2aHdaM0VwYXY4aGRiL3dy?=
 =?utf-8?B?Wk91NWs0RXVUWmtyYUtlc0tRcENKQ3J5SnlTUmtkdGRmRmNwS2RnVzhnVE1Z?=
 =?utf-8?B?VjJiamdNc0V2VHlBclFVNWxoVThQWC9MZjFucnZBcENVZ3QvaVoxTmE4R0dQ?=
 =?utf-8?B?eDNuTG1DWnlJRmRuaDExaHN4cUpHWEs0SXhMWjZQcUMvbHhSelptbG5EbkJY?=
 =?utf-8?B?OHdhMjFORVErYzBtLzhmZVVJQXRjRlpKd1J0V0lyU3JSTURpVkQwTis4RDd2?=
 =?utf-8?B?a3NraWhNVCtkWi9sRGNSTk5pWCsyQTVNa1lEN0dDeVk1S0JVQm5QR29SVnl3?=
 =?utf-8?B?SCthbXVkdVpZS0pPVCtHTXF0Tk1aWWF1VXozSnFPS3AzMk5WbzIxdVBCbXM2?=
 =?utf-8?B?MkNJUlBiaC8rMkV5cUVjYmFIdFJUaUJZU3lGUGJEQWpWbWxrTkFUS2xOd1p1?=
 =?utf-8?B?T2x0MVY5R3EreGI5ZzJYbEpKMElrL3phZE1BL2Q3YWE2ZnNPNWlKYi84YWR4?=
 =?utf-8?B?YXJJS2dyenZDZ1lzaWpObXhTNDZaYy9CL0ZsTHpRNm40VzY0SHJkbXlLMFdV?=
 =?utf-8?B?L1RRbGNXMW1BdGVybHZlMk9LbjN1UGdWTDNoeHhWL25vS1MzU0FoZUlNM1NV?=
 =?utf-8?B?OEg1U1loREZLVVhETU1wTDZKZ1hmYzFFdy95WGgvT1gzU1dQNlh1a0dVU1Fa?=
 =?utf-8?B?OU5VdmYvY3FSZlBXSGpDeU5CZ3d3UjYrbWluQXVGcytCdDNwVGN0Z2kwYnhs?=
 =?utf-8?B?Y3RkRCsxY21sM3FpMXpDOFVqTk1MWVBxWGw5WmV5ODM4eXkzRFpSSUJkazVO?=
 =?utf-8?B?Z0JnRHFldEVOYmsrYSswY1dWR3BTZzgwR3c1ZkpQUUN0eEFEWDI0d1dDTkVB?=
 =?utf-8?B?UitXWVpqN08xQmZ3NnZlc2lObVBHWWxsR21IbnFnUGh1ZW5waWFEamN2THd3?=
 =?utf-8?B?bUdjc25xLzNMaWFZdEJ1eXk3dTd1NnBYZUpYYVVpUHl2S0svRWhEektreGda?=
 =?utf-8?B?UjM0MEZYaTY3aHpVT0VTbGt6bCtmY01Gb2RNeW9wdWpWVmg1Um1XZm5VTXY4?=
 =?utf-8?B?amJ3dGFvNndHcllCK1BZVnBEVjIwMnVEd2MrRjdnN2hKak91UzdkNUNBZnlW?=
 =?utf-8?B?NkVxWVhhUDczYTJXeU9zdXllS2h5bnpOOXNDajlVcVJUSTZQTU4rOFgxQk9H?=
 =?utf-8?B?MXYwRk9sNStpZnhpNTg0cTRzN2I1cXNsS3FKZ3RwNUJFMlNPeXMyZlZxU3Zl?=
 =?utf-8?B?akU4NEdzMU52TTQvWXY5UmIrMmpKSHMwYWZmUjVoREx0N3NhRUpOV0N0SWVY?=
 =?utf-8?B?WTB2N0VvMjZwcnF4Y3Y1dUFtMmN2KytqR3FGMlgxTUV3L25IeVdRTjNIM3Zo?=
 =?utf-8?B?ZElwQWMvdVREelErZHR3ZFF3aEVtK2xKeG1ScVl6Y2EzcDBLcVlZM09jQzBN?=
 =?utf-8?B?bUR2dy8vZUx6aVBkWGcyUWZOT3d2T1l4QkxPTzlrUExtNjhtQnlVVGp5Yjdi?=
 =?utf-8?B?SGc3M0JmQUJpWlZlVTI0TmNlSDVtbWx5UVNodGFaQnFnNHBmQk4xVHRFcWdu?=
 =?utf-8?B?UnVLeGF0WFNWK3RNNkdhY0JSUWt0UU4xUDVHTkV3VHJESG1Mb240aithd3N6?=
 =?utf-8?B?cTNzOEJ0anpCNGZkNFB3QWJiK2RhYVNwNFN5NEk5TVU2eXJFSmcrNGVrK2pR?=
 =?utf-8?Q?Qn8nEHOUVoFSFYdoY99hjzQatHGDgBMMDHnaqIEs75pk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FE58F5D28153C4BAB6678A3F1E5DA11@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ef168f-4d08-4268-96d9-08dd70040fb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2025 03:28:10.2459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ta0cTwR0ok3GqFVxPdBUKLuT0mXGLpZ7jSenW3fIPvkm/imGgxvLL40iwWlFFDzJESHKGqTk4gGnLhcp4kB7JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7543

T24gMy8yOC8yNSAwNzoyNSwgR3VzdGF2byBBLiBSLiBTaWx2YSB3cm90ZToNCj4gLVdmbGV4LWFy
cmF5LW1lbWJlci1ub3QtYXQtZW5kIHdhcyBpbnRyb2R1Y2VkIGluIEdDQy0xNCwgYW5kIHdlIGFy
ZQ0KPiBnZXR0aW5nIHJlYWR5IHRvIGVuYWJsZSBpdCwgZ2xvYmFsbHkuDQo+DQo+IE1vdmUgdGhl
IGNvbmZsaWN0aW5nIGRlY2xhcmF0aW9uIHRvIHRoZSBlbmQgb2YgdGhlIHN0cnVjdHVyZS4gTm90
aWNlDQo+IHRoYXQgYHN0cnVjdCBudm1lX2xvb3BfaW9kYCBpcyBhIGZsZXhpYmxlIHN0cnVjdHVy
ZSAtLWEgc3RydWN0dXJlDQo+IHRoYXQgY29udGFpbnMgYSBmbGV4aWJsZS1hcnJheSBtZW1iZXIu
DQoNCkluZGVlZCA6LQ0KDQogwqAxOCBzdHJ1Y3QgbnZtZV9sb29wX2lvZCB7DQogwqAxOcKgwqDC
oMKgwqDCoMKgwqAgc3RydWN0IG52bWVfcmVxdWVzdMKgwqDCoMKgIG52bWVfcmVxOw0KIMKgMjDC
oMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBudm1lX2NvbW1hbmTCoMKgwqDCoCBjbWQ7DQogwqAyMcKg
wqDCoMKgwqDCoMKgwqAgc3RydWN0IG52bWVfY29tcGxldGlvbsKgIGNxZTsNCiDCoDIywqDCoMKg
wqDCoMKgwqDCoCBzdHJ1Y3QgbnZtZXRfcmVxwqDCoMKgwqDCoMKgwqAgcmVxOw0KIMKgMjPCoMKg
wqDCoMKgwqDCoMKgIHN0cnVjdCBudm1lX2xvb3BfcXVldWXCoCAqcXVldWU7DQogwqAyNMKgwqDC
oMKgwqDCoMKgwqAgc3RydWN0IHdvcmtfc3RydWN0wqDCoMKgwqDCoCB3b3JrOw0KIMKgMjXCoMKg
wqDCoMKgwqDCoMKgIHN0cnVjdCBzZ190YWJsZSBzZ190YWJsZTsNCiDCoDI2wqDCoMKgwqDCoMKg
wqDCoCBzdHJ1Y3Qgc2NhdHRlcmxpc3TCoMKgwqDCoMKgIGZpcnN0X3NnbFtdOw0KIMKgMjcgfTsN
Cg0KDQo+IEZpeCB0aGUgZm9sbG93aW5nIHdhcm5pbmc6DQo+DQo+IGRyaXZlcnMvbnZtZS90YXJn
ZXQvbG9vcC5jOjM2OjMzOiB3YXJuaW5nOiBzdHJ1Y3R1cmUgY29udGFpbmluZyBhIGZsZXhpYmxl
IGFycmF5IG1lbWJlciBpcyBub3QgYXQgdGhlIGVuZCBvZiBhbm90aGVyIHN0cnVjdHVyZSBbLVdm
bGV4LWFycmF5LW1lbWJlci1ub3QtYXQtZW5kXQ0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBHdXN0YXZv
IEEuIFIuIFNpbHZhPGd1c3Rhdm9hcnNAa2VybmVsLm9yZz4NCg0KTG9va3MgZ29vZC4NCg0KUmV2
aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoN
Cg==
