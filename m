Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9462EBDE6;
	Mon,  8 Sep 2025 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333662; cv=fail; b=NvK08IIfSERSjNkbI35L3UBJCBm9eJpGl8vZmW1hipv4qog54jJEEBUP2gaCSj/unCXPECcALYMMftkaXdkMDX78dqh3ImXVzARIfyvAxluGHL7mqBNjlBsKH+m+jCv91LQSFWp4owCWw/ccYrP7KgM17LZXWi5qtFwpPvcj6xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333662; c=relaxed/simple;
	bh=MBxCnS1PdnEQpZWDmajRp/b0xAC1vKxcJz3MKKhM3oA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BOzBvKSi0azkA5lQyn/WB/euIUdi+JRhgpav2gy8Bo7MVBZ+XDR5OyMauxKtiR0Xgxxc1k1sUTLh/y2GBCDri1xo4tbUzg9HVxlieCCVYDp/PZ5qdbZ0KvsZ3D8N917TbwlKbC/gO5e7ZTKvarKeJQVUlXtmPIq2+reRFYR4nnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AvWnmmqZ; arc=fail smtp.client-ip=40.107.100.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AvWnmmqZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ux3MOjovrjHv3jKdQEMWF+ThWGux9aCVoqmm3JqAlMeWVqHrGSnFRZMlrOFGV5QRU5uwGOL/IH1tx1NFJC34wKjS8p+aXTjBusOxtyWJfbdmxMqZoyb5CyVI8C5blF/LqJKKxvU+u469kvNbh0Vc6QkaagmdXriDM4WPUVP4qjJf1QWq00ZNS2SApt0uwZJrcTCdxrtFi4KmPDOOrWoyDIiqLwYD6k67ewFvPzuoXNKRVSlxeFiIlr7Yhw2xSvyn1PtvJ7AwFfuOFtFN0yVf+CblIisqnyq3dBCHwarlvYlCF/BzRyLHzf1xV3+rS1lVmnGjLHuYCuxWElzZr1F2qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bW3yiB6m967I7ePADYab7nVLEpUeLhOJ18eFpB6Ixw=;
 b=NdnyfO60K1waNQZfpH0Ib0iZ8biJBq56mpDT9jUJ40yGkPU4pJBOhvDaxiyo+EvkhfGP633q7mUrjTpDPafqlUG2NT1sjdRnvE+fpJHy7odJ6k9jK9z1i4h7vYhEJfPjEXNXlfheWlHEACqn4Zen15jKRhZCKDhl+tdndPjDCq4nqm4MvDrnbWRGJ3Y0LTdS79aVJKznYj3PaSPDQeviSGz0gQmfN5d3eNk21IHbpbmXys4OKVpsCHYSPwVfr9DjU0KrTbtkL+Y1o7OQyl0440eBID6DkCtL3xZ67cFy5l1nrLQzQB8rWUFKCFMysn6q6XvoA5Vg+VdYGg+xF08biQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bW3yiB6m967I7ePADYab7nVLEpUeLhOJ18eFpB6Ixw=;
 b=AvWnmmqZ6i4opentFHkrl2ZPJC+6EJA7RIqczHySws7dm/O92DTA53SxpwA0mrH+XVpyUAPKAixLRdMItUr/CwWaFvoUOPUy9zrQ7xFEXe1Ph4l601dTol4ChTVKfCdrBK7xWw5gawIa1ZQ9K8ky1/nb+g7KRip4X0kJ9/pkT+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM6PR12MB4092.namprd12.prod.outlook.com (2603:10b6:5:214::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 12:14:13 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 12:14:13 +0000
Message-ID: <a0817722-50f5-44c6-b07e-a10a48e87239@amd.com>
Date: Mon, 8 Sep 2025 14:13:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/2] dt-bindings: i3c: Add AMD I3C master controller
 support
To: Rob Herring <robh@kernel.org>,
 Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: git@amd.com, alexandre.belloni@bootlin.com, Frank.Li@nxp.com,
 krzk+dt@kernel.org, conor+dt@kernel.org, kees@kernel.org,
 gustavoars@kernel.org, jarkko.nikula@linux.intel.com,
 linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 radhey.shyam.pandey@amd.com, srinivas.goud@amd.com,
 shubhrajyoti.datta@amd.com, manion05gk@gmail.com
References: <20250905113740.3841181-1-manikanta.guntupalli@amd.com>
 <20250905113740.3841181-2-manikanta.guntupalli@amd.com>
 <20250905234037.GA1512025-robh@kernel.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250905234037.GA1512025-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0226.eurprd07.prod.outlook.com
 (2603:10a6:802:58::29) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM6PR12MB4092:EE_
X-MS-Office365-Filtering-Correlation-Id: 1694e40b-7b0e-4ad6-c240-08ddeed13953
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2FHSXAvblloNzl3cFAvakp0TndvRmhlRG1RaUdSeTBLSXNhWGVPRk5kQU8z?=
 =?utf-8?B?am42UDFudXhORXEwZSt4dEJHT0c2MnVPemF2eE9waWlyM1p2ZEUvNURoNk1Z?=
 =?utf-8?B?WTlGVHp6U0wrWjRPckI4NS9uOTVCcHJGR0YzcVZ3UENxamhSUVNtcmdmRlJR?=
 =?utf-8?B?ekNFeEx4WUV6M0duVmRLVnIxVDNKeGpzMTcyVDJnNW5TQVNIbkRjeVQ3LzNY?=
 =?utf-8?B?UElNaXkzSXcvU1NmY01BWnZFNXF4TkZKTW4vVmRwNit4a2ZCMGlCM2lPSEFO?=
 =?utf-8?B?UHJXdFN0b1RpdDRHRmxSWjNHYTJ3TkVYTy95dSthK3B2cDNBdkV2ZFM0eUxJ?=
 =?utf-8?B?cnRrbUVOdElXd1ZwQ2ZrUFVaaEZwNUNvWk13bzlDYlFaRU1ZV0liT0RwS3po?=
 =?utf-8?B?RnRFRjBxbGVaVmhLMmZsZG1EOXpadDgyL3gwRGtYZm54MTlaWWN3RkFpTGlq?=
 =?utf-8?B?RGhwbS84RGd2ZDBOMW1GQmJYc1ZFTDNucHdKN2Y0cjVhM25uQlJua2NkTG04?=
 =?utf-8?B?c1JnbldxV3hCOE44cnJMeUpnWkhrcmlDL203dzdkQ2cxeXVXMGhRRWVNTWxZ?=
 =?utf-8?B?TmEyU3F6NE8rUGRXclVSdjJkcWlvV0Y4aE9ob1N2OGxNNDhOUXppVmlrckVw?=
 =?utf-8?B?bjFwdWFCc2V1NUV5Yk1KN2pMekUzQlN2cFI1dG1XVm1wakRveFZyNHpEUUZo?=
 =?utf-8?B?b3hjbXN6WHRFd1JPTFliS1VJbjEzendNalpsbGYxQUZRVzhYOEJ3dFNPajdM?=
 =?utf-8?B?RCtRdEVVQkRjNUF6aFRJVytmTHJ5R01qc0ZsYWpSR0ZqcVY4ZmZHUWhnenVR?=
 =?utf-8?B?UFNPZHo3RGhPZmMyME01dmpOLzN6dDBVMjJ1S3VFSDNaVnJUS29GcnJjSVNB?=
 =?utf-8?B?WFMwR3JKUHdGV0tNOEllL2RMdDdHbVM0VU1vN1dUWURwWFZHQUc0ZWRSRmNs?=
 =?utf-8?B?bS9Ib2xjR3huN2ZldHI0NnRpV1EzNG9zZHhlOFQvS0V5VHR1OE9JNmwvNW11?=
 =?utf-8?B?M1BTNzlQeEFDMUVxSUxXZitNVkF5d3BkYW1uRG40bGtldUxXNFVQRi95bmNF?=
 =?utf-8?B?aUR1REtkb1l6dkhIOWhKQzNudXdvTG1DWUFpZWNXejFnSlM4SjJtNnNMOHVI?=
 =?utf-8?B?dE1EZFl2TUdoVnFGNmFBdENORktsUW9OOCsrendERUk2b3RqeWljUFVQTnI0?=
 =?utf-8?B?UGNhT250ZzZVZzN2N0QzQlVXV2JPVnpIVmtlQnRJeitiRW15dHNtQ3VGUHli?=
 =?utf-8?B?TGQ4dlIwMHlJdWxZQldYN25NV1Z3MVFBRGJWcUh2azhQSUdmdFlOSVpOUzR5?=
 =?utf-8?B?em9XeE45MXlnWktkUXRYUUJrbnRrdlpJS1FpWVBhRzZOVmVjY0UvNy9aMmVX?=
 =?utf-8?B?OVlBM3N4bWUwMzhqcnp3NWpzZ0gzYmJaSGFtUE9wSitiTE5hMzlqN3VRVWhx?=
 =?utf-8?B?SGVTekovdEV0STREZnUrTHlqTFNuVkpxVit0djJidGdkaXVjMGU0bXpaTkhC?=
 =?utf-8?B?akV5d1NlK2M0WjBXc0IwUTU3bU9ZVnB3cVZuVVlveHBmVWlCMmxkUk1VTHlu?=
 =?utf-8?B?VWF4d3lEQWtWdzJzQm50Qkg1b3M2Y2hsSUhPNFduRUxaQm9SRjNMQUFpZjNu?=
 =?utf-8?B?di9VTHZmdmlrQVpsb1ZBd3ZRVWNrRVJYYUxrSVh3NEhTSUxGMjh5clZJVVZs?=
 =?utf-8?B?WHpwUE9tck1QbVIxZ3QwNEpOOExIR3A4YVorbVRDdVBrVVNXbGlZbExZbHY5?=
 =?utf-8?B?VkNuSURxa3NXUExXWmJ1R2ZEZGVVaC9BemNDbWdRRkxPSlNsd09Fd3F2czNp?=
 =?utf-8?B?bXVPKytxSWc0SXp5MUFZRTF1RS9rYmJ1Z1Y1L1BaYk5NSUZML2NFaHV5VENK?=
 =?utf-8?Q?g0A/tVJcq0jdU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUJiSlBkODRqemNTM0diSmVzaEpkUDVhL0U1OUZvZXcyd0VQS3lxOFVDRmtL?=
 =?utf-8?B?QmZ6WmFSUUlVWTBkbUM2c2JwbGhwSm9NTFhUTnlTbzhVY2NCMUJtNU9wRDh1?=
 =?utf-8?B?cUgvVFVpNnUzZ3RpcEFwTzVWbm9YV09SQzM4WlhYRkhndW51K1IrSXBId08x?=
 =?utf-8?B?Y2twV3lGOEJ2cDBDcDRQbHJ0bHl4UzlYTG1NY05iZ0c1NThPN0lyMjUzWXBr?=
 =?utf-8?B?T2lYM3VWMXhxL2QrSnRIL0ZLb253a0ErYkljbEJ4QlhRSlcvVForMW9kTVRB?=
 =?utf-8?B?RVAyUCtaYUFSWS9kMGVpQWtOMG5wL3E5RXhkTUJaNHNSKzRxNG0vZlYvc2V3?=
 =?utf-8?B?YklJYlZMdUhJZXJLK0Y1SjJUc0lRSmpaWTRNNERKQXpRdC80RmZseHdGckU1?=
 =?utf-8?B?dkY0UUp4N3FBWjVUR1lUK1JvbkF1Nm4wekhSYm1rb0R5MC9UQWRmL3JRakVs?=
 =?utf-8?B?YjRzb005L3lpdjlnai9Dd2NZWEZ0ZVc3M2pMS2hXMUgwZmVraG5oZ2JYeWU3?=
 =?utf-8?B?cU05aGx0eDFSZ1hkZkQ2bXl2S3hyTWphcitFajJTZ2VMQW95WkkxZ1hLcVpv?=
 =?utf-8?B?Wko1UmVpejRnSjhGRjZ4bGFQVUhIVklGZS81MEJ2TzNoZkJHQ1ZYdHY2RGFP?=
 =?utf-8?B?NGhjNEZlMityMFA0NWRGU2tnazhKemZTckQvOFFrRUFkWEl4NFdaZnF2UW44?=
 =?utf-8?B?VHpIWStyRjhyZ0E1bHBCb3BFV25xVWJGc2pYZUN1TFp6cC9qNE5JSE10UGJM?=
 =?utf-8?B?SUZiNm42aFVMdGx3YVBLcVNFYVVVSCtGSVVQYlY1YU53M2wzTEw3dEVMbDVk?=
 =?utf-8?B?UEpIOThaT2l1eS9oNjRZc3JZSDBBbnNzN3JnQUh2Wi92RDM3bktyRU5JWFJM?=
 =?utf-8?B?c1lMUVZsZGptM1NyS0xxa3ExMDVFaVEvcExScEtJWWFoZkM5andkTWZ3dDAw?=
 =?utf-8?B?SXNIVUhtSklrbGgrMldZTVdXKzFuNkJJWjQ3VWxiYlFEcmFXQnJEUHRYVUdK?=
 =?utf-8?B?ZHhQV0tiUjJKR3pTZDVBR3VYUDVTWUV2ZFQxcld6dGFLVW1XY3pYNzJMLzRl?=
 =?utf-8?B?RW9QQjJtSGZOSnZXMUE2WE9JV1J2S0ZsbVc3ZHViTWpRS2YwZDMxaXFvOVJz?=
 =?utf-8?B?VnJ5MEFUdjRTVUhBcUNZV2hScHpCUEgrSFprYkxwRk9xL1lIblBnM1lyeEhx?=
 =?utf-8?B?OFU4RjBLekJwR1RncXFMaTVLUUVHWlVNUS95UmI5MXVSdXljQWROLzliT0lW?=
 =?utf-8?B?S1EwNjJPV085OHdBeWJBMkpYNHZROHNGWFdRb0ZmT21KTk5mY0d0UTJISnp4?=
 =?utf-8?B?Z01VakhRMS9SS0U5RFU2UHY5czgrRzBiUGtmUnQvUVMwMDRsb3dsZXNGR2Fj?=
 =?utf-8?B?T0JzMVc2a2JpWWRvM2FHcUpPRVRzOU5IUDZRczdDc2Zmd0QyWCtKd1U1S1lI?=
 =?utf-8?B?cFVNTi9ITzVtTzhYUmNqSVBqRlFzcjdyYUNNVmlESGdBQjZkeCtaMTJnUjNS?=
 =?utf-8?B?VTBQZHlpczlVTFA4dHh3NWExU0VyTXp5Szk3ZVh2RUJmeVA0RzJwekhHOVNw?=
 =?utf-8?B?d3V3MWtJOVM5aXY1bGNqeE41THMyUXQ2R1VXVSs0TlU0S3RqQjJudjVMeEhq?=
 =?utf-8?B?bE5ZbTAwb3g4aktPRjEwRU41L2JSYWpPRW9GSDl3d2hucW10VWd6YUlyVnoy?=
 =?utf-8?B?Ly8yTjBVK2pldFpSbTIxaElQMkdRN3dTRGxvZjFMV1IrSFlCUVgzVXNQTXpH?=
 =?utf-8?B?SE1rTlhUS2laRWhEb2ZSVHVTaXo3UDdIMDVaMDIvenBFcEVoMmRDK3VqaGx5?=
 =?utf-8?B?bmxqUnRDWEpSSlgrM2F0MlF1VWRsVDlYL0I5SlJDbEdQNTBldkNFREVuQWxY?=
 =?utf-8?B?ZmswSWFST2tFR3JLcjNONXE1a1RYMkh4Z2NzMzJyZmRUQTZsSDZuVklEUzhI?=
 =?utf-8?B?ODRMUkdkSk50MDkvVmc3U0ZUN3ZEd2R3YTMwRTJCYThna3ZOY2NuVlg2cFgz?=
 =?utf-8?B?Wm8vU1dnMXNLbUhNSXFaaW1Ld3RGMDRaVHE2WTBXQlpIbXVGTm1TM3h1WUh6?=
 =?utf-8?B?VjRHK2lSc0hpWUVBeGsxZHlYWGtOLzdmSHIvOGJrVTRGc1lsTThuNXc1QWpI?=
 =?utf-8?Q?kP27P3hyuXEgrl5DrFQb3ztAZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1694e40b-7b0e-4ad6-c240-08ddeed13953
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 12:14:13.6877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPZXMgE7sNX34T8kCxx8gx5y02+acboKVDkxy0w8BpCdAKljef9WUkWjFDaPdq6d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4092

Hi Rob,

On 9/6/25 01:40, Rob Herring wrote:
> On Fri, Sep 05, 2025 at 05:07:39PM +0530, Manikanta Guntupalli wrote:
>> Add device tree binding documentation for the AMD I3C master controller.
>>
>> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
>> ---
>> Changes for V2:
>> Updated commit subject and description.
>> Moved allOf to after required.
>> Removed xlnx,num-targets property.
>>
>> Changes for V3:
>> Updated commit description.
>> Corrected the order of properties and removed resets property.
>> Added compatible to required list.
>> Added interrupts to example.
>>
>> Changes for V4:
>> Added h/w documentation details.
>> ---
>>   .../devicetree/bindings/i3c/xlnx,axi-i3c.yaml | 55 +++++++++++++++++++
>>   1 file changed, 55 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml b/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
>> new file mode 100644
>> index 000000000000..1daeb20205ac
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
>> @@ -0,0 +1,55 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/i3c/xlnx,axi-i3c.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: AMD I3C master
>> +
>> +maintainers:
>> +  - Manikanta Guntupalli <manikanta.guntupalli@amd.com>
>> +
>> +description:
>> +  The AXI-I3C IP is an I3C Controller with an AXI4-Lite interface, compatible
>> +  with the MIPI I3C Specification v1.1.1. The design includes bidirectional I/O
>> +  buffers that implement open collector drivers for the SDA and SCL signals.
>> +  External pull-up resistors are required to properly hold the bus at a Logic-1
>> +  level when the drivers are released.
>> +
>> +  For more details, please see https://docs.amd.com/r/en-US/pg439-axi-i3c
>> +
>> +properties:
>> +  compatible:
>> +    const: xlnx,axi-i3c-1.0
> 
> I'm still wondering where 1.0 comes from? From the link the only
> versions I could see are Vivado tool versions which appear to be year
> based. If the IP is bundled with the tool, then use the tool version
> (oldest version you tested with) if there is no other versioning. A 1.0
> version really just sounds like you made it up.
> 
> Something like bindings/sifive/sifive,blocks-ip-versioning.yaml is what
> I'm looking for.

This is what I have found in public space talking about it.

https://www.amd.com/en/products/adaptive-socs-and-fpgas/intellectual-property/vivado-ip-versioning.html

https://docs.amd.com/r/en-US/ug1118-vivado-creating-packaging-custom-ip/Versioning-and-Revision-Control

https://docs.amd.com/r/en-US/ug896-vivado-ip/Upgrading-IP

In past structure was slightly different.
There was also alphabet suffix.
You can see it for example here
Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml


This is for example change log based on Vivado version to give you an idea how 
it is tracked and described.

Thanks,
Michal


2025.1:
  * Version 1.0 (Rev. 4)
  * New Feature: Dynamic addressing feature updated to handle dynamic address 
register update within the IP.
  * New Feature: Updated IP Catalog taxonomy structure. This change has no 
impact to the IP.
  * Revision change in one or more subcores

2024.2.2:
  * Version 1.0 (Rev. 3)
  * No changes

2024.2.1:
  * Version 1.0 (Rev. 3)
  * Revision change in one or more subcores

2024.2:
  * Version 1.0 (Rev. 2)
  * New Feature: Support for Target added
  * Revision change in one or more subcores

2024.1.2:
  * Version 1.0 (Rev. 1)
  * No changes

2024.1.1:
  * Version 1.0 (Rev. 1)
  * Revision change in one or more subcores

2024.1:
  * Version 1.0
  * General: Initial release



