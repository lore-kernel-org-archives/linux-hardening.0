Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010044.outbound.protection.outlook.com [52.101.193.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2943CE4A7;
	Wed, 25 Mar 2026 11:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774438507; cv=fail; b=BnCbLeM57cB/yTuhfZZM+0JIDveTmEq21gZboE49e8E6kiovyLji8xH1mewtGcfGQveXzBXMwAZM9xqeNv91UTzuVZAmB6vgI4mqhixBNX3p7iJz6p9ewbMmiS5ln89FjyAS7qcPEfl/xS/to4FbEdp6PNuebkPUWo/aBm8IoOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774438507; c=relaxed/simple;
	bh=zMK2E3TnMuv8Ts4tyoK3rt41Iyi9AE2MBOHtWGgvimg=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To:MIME-Version; b=B3zOZKpsLkSfJI4gqjklGonW1tVIpOktlObk9nCrcYffFm5D8CHijYFWL5HgoG9tGG+Rd0SRrRpRTy+Gq+eptAipPK2d9wt/lreAbCwnVMu0yvENvd+rFmyvjVSSDbZjpQfXRDiHCSUW/zHuMuahLILrZiY/N3G2uq9GP735xX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lKzvn4Mh; arc=fail smtp.client-ip=52.101.193.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lKzvn4Mh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NhVgBMWr2klm33ZNNwCTzFcXrBWLthOYidY0i7BGEuYnQ5fxEVGSVddmai/YIVR/aKM7rnNrrrFrY1CKKyBw10nvY8+4yudpTeiSQpq0QM7wUniEnXYQKae3RfIi+GAl6DM03lqp3SJnnBZzr4ZyePqfjjtimkWFh07+lJoOyUbsQNPiB3GBJPf44KGHfMxaus+hnFM8zJ8p7CopOBWDB9iKtuZv5ps4vz13idZPcWFgkYVUIuG2V4RnDFlnpOkOXjRSUiZkLVkQp2+P14hSHqSQ5bizF9p66H1ShiTQ7ocOI3nu1vStPEcaEBMkaHSkDrTtkOUKw0oFwbP8SrgP1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHEO/dqgILd7plU+6BktrXNUst79Tq8LeFxHzvV++YI=;
 b=rsyNAqX8BCb8WAl1XAmm0PxUZqdSePoFZXnrITx48przGDoOouqIH7UtH69FgxdkvtMkPR3Y6329IlJ6wHHrlCUCZHUtWJQrMMRZvMMTFJ/Bdu8stD+aB1qAzWuqxRdPpkb5pWH/xxNQzqNr/0pxb1/7kc+CJtJAJ27dEpoCBA4VI9+rGoja5jiaofQ55oQOuRm77QGLO0nmXf0Qa+DY4GGS7stJD4LdMazt1lYWvJ3/dpLsR1aslL32EHLNLWKu7RsqIUM1jBwV/LiP6iLXvrb8INUp5okMd1TGryy+SbQFoiBj3V5zko2vFKP7t0nZlBL2rgx6pfkQaXjGyYu1IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHEO/dqgILd7plU+6BktrXNUst79Tq8LeFxHzvV++YI=;
 b=lKzvn4MhnX4C10HHB/1wcdrWD/S5bK/ImESQkJeUCZUXqIFrIC4QjPtOUHpY+XpWZK6HMrx5XnnO86PfU0aQIdzu2n4jfi/ULYPWXYnt71DXRKVzzwCWwuqVPFWW8Q04c/bT78yJ0idB3Gh8KbYjd4xi/QUHJ1yIkPb/5YZPo8X3zxVHEEx/C8YLDpXmybBN2nqgN2JCP/m4OHMIm/EkLUaX9dcf1c72w56aP3APWZAc7Qa13vnpUAV1m/LFdI7AyLTnOb2C1O/yZh/g/qrR2BD/fLHydmkBbJCMxdMVSLselumJAZT4FjaQRHfWAcnKFWyL3OjQhx57QEn+Gl0fbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB7917.namprd12.prod.outlook.com (2603:10b6:a03:4c7::12)
 by DS0PR12MB7608.namprd12.prod.outlook.com (2603:10b6:8:13b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 11:35:00 +0000
Received: from SJ2PR12MB7917.namprd12.prod.outlook.com
 ([fe80::6e3c:d0e2:fc8b:4e34]) by SJ2PR12MB7917.namprd12.prod.outlook.com
 ([fe80::6e3c:d0e2:fc8b:4e34%2]) with mapi id 15.20.9745.012; Wed, 25 Mar 2026
 11:34:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Mar 2026 19:34:50 +0800
Message-Id: <DHBTY4W21Z9S.1LCIGKKJ0WX3T@nvidia.com>
Cc: <rafael@kernel.org>, "Jonathan Cameron" <jonathan.cameron@huawei.com>,
 "Shiju Jose" <shiju.jose@huawei.com>, "Tony Luck" <tony.luck@intel.com>,
 "Borislav Petkov" <bp@alien8.de>, "Hanjun Guo" <guohanjun@huawei.com>,
 "Mauro Carvalho Chehab" <mchehab@kernel.org>, "Shuai Xue"
 <xueshuai@linux.alibaba.com>, "Len Brown" <lenb@kernel.org>, "Kees Cook"
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, "Will
 Deacon" <will@kernel.org>, "Huang Yiwei" <quic_hyiwei@quicinc.com>, "Dave
 Jiang" <dave.jiang@intel.com>, "Nathan Chancellor" <nathan@kernel.org>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
 <linux-hardening@vger.kernel.org>
From: "Kai-Heng Feng" <kaihengf@nvidia.com>
To: "Bjorn Helgaas" <helgaas@kernel.org>
Subject: Re: [PATCH v2 3/3] acpi/apei: Add NVIDIA GHES vendor CPER record
 handler
X-Mailer: aerc 0.21.0
References: <acJYJlm2JZn_W7yO@M5403NF6WD>
 <20260324161533.GA1131495@bhelgaas>
In-Reply-To: <20260324161533.GA1131495@bhelgaas>
X-ClientProxiedBy: KL1PR01CA0159.apcprd01.prod.exchangelabs.com
 (2603:1096:820:149::12) To SJ2PR12MB7917.namprd12.prod.outlook.com
 (2603:10b6:a03:4c7::12)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB7917:EE_|DS0PR12MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a0c292-c9f0-45cd-d4c9-08de8a628c32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IwjNnltKCXNQMXna6WKqVg8WnmU1Qw2ANZh7/p4VbtbG/09c6HKT3OGPBFCRMdJ/38dw0xqVHIiJE7pF63LGY4zqusCb193LQJr9acea/iNhf/Rn5Pm5qfeFf540UN7QEjMXNV8v5kAwC0nYJMrfTz5gwydV5e+y6VGaecspkPw7p4SsYwD9cyfNWwumDU/WU0HYvjiwb7ryE5weeggUiCOP20MVSCd/RLW9ZV7cTRKfPhOP0OblJb0bsuD+IuKSNn8gffoSTVGl8eK7tFu4mU07/efsZ+3HWowyt+jJ4iATZj3MtdS0pdBna4H27u/bVxedmPGabfKDcov01l+JwkJUBnTrI5cgPv5dnOtuDY7oh034kyOtEfW2knP+JSgtuDCXKu2ESNGcVHC0i5ydShD7DayA0tSfpwQm9hMy+ei5gLMNgm/5E9EvXgTJEwpXY/6Y9ftGPXaJ6NpVSgfVk243DAKDj8tx87YrXXPVLJwyNz33HIJY4eBTmjGQ4QlRXIq/1Jx2oyKh+uEFpNTb6pL4kNlugwC6wX3igOYtv8W6QKpZ/nA54ZCaxrqx/B7h7vttQgCHg3mv/5GnpYV4K3Rgj1AFMniHi9nZrBE24zpV6rNirqMHu+2MJctNQ4KEYuXePX61E/p5nrTJVYHoUdlnNlNwAJvtePrHp+CazrMZpmxzKHqvUpZcFOPWX7UNJ/nqxUelEjXTcmxw/awdYN8/k6QzLsoruhCL8bF0M+Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB7917.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUdQSTVkamxZc2k3dUMxVS9Ndit3dG9tejc4RDJsU2xrb1FCTVFMcHJIQXll?=
 =?utf-8?B?RDl1cVcrbDhzdWNoMDRsZUhOWnk3Q2FWcFJuZzQ2NXZVVjBzMHFYcW9WR0Zt?=
 =?utf-8?B?d29ZNHo1RFRrTldPZXNFSmIrc3Y4bGxubWNTTmJtcUp0N2ZiYm1OUDlpZzZi?=
 =?utf-8?B?VW5BeTBid2R4VW5iWWZxTlROdkxyS1FaY20wTFdwR0JFbkltT0xDTFNJenZu?=
 =?utf-8?B?WS9tcGNHdldjcTVZaFBqZHV0K0pEVjJFYmVaemZLT1ZCd3N2OTduMDJWZExO?=
 =?utf-8?B?d2d1bkgxMytUNXZQdkVHcE5yVHdZZklWNU44OTQxYWY2NWU3aWg3VlBpRHFU?=
 =?utf-8?B?N3dldkcrQWtRRVltZXlNWTdaUytNcXlreGdudTR2YmVYQTdubllEc1BOWjEx?=
 =?utf-8?B?OXIzb1lsUzRMcEN2eXd5eERMUDN5OHdmS0ZYRHB2YitPMkZka3BlTzNCWElG?=
 =?utf-8?B?SjFYazBSVWF2eGpMRzQ3MzFmSDJhdzBvNURxcEk4TW9ONFI0NnhPRnRSb1NN?=
 =?utf-8?B?M003U2hQVlorNW1rQXdHTzI5VlRKQTQxTzlZZ2RIdU9kbDZGSG1qSnFPa2xD?=
 =?utf-8?B?aW5DRDE0UXhwV0hIWlhVTTNtK28vVkMyVnhHejAwSjgvZ2d5d05RcW16ZExr?=
 =?utf-8?B?MGJPWFV1ZDNmek5yV2hCcXNJTGtPYXRaWFgwTGxwQXNXWit5MWk1Z2hlQkZI?=
 =?utf-8?B?YUYxaHRIRkw0SWdCdERodE9tb3Rhd0h4Y2hHd2VhODVzOG5QTFRjaGtPUWtD?=
 =?utf-8?B?amQrRnMzL1dEQWNHRWNFUGRZRGRtaWt5a0R4WHZ6YnNRdE5vbThiTjVObmlE?=
 =?utf-8?B?TlJNejIvOElUSkJtS04wSHJFU2MxV1J0bzV0M3JHRHREU0Q2TDZ2cHNmZDBh?=
 =?utf-8?B?K1A3biswUEtRTk9aUmN5RnhIQ0R1RTRFRXJ1RjQ0bWh2STZ4cVhiRkc5a3c3?=
 =?utf-8?B?MGwvdmJ2blpIcEhzbDhoc2NtYlNWSU44cjdpblBwdnFFT3pIUWtVS2JvYzg5?=
 =?utf-8?B?TXlLN0d6alhkUDhKdmN3U2VCN3dUZm80aVZhUjVYVnYzaWJBVnJSRDQ0WW13?=
 =?utf-8?B?clRRcm1wd0M0YjVWWGQ4WUNKSDNpV3JzaVZDN2dQU2lwcmVjcGFFL0FidjJN?=
 =?utf-8?B?dVJuZ0tnOTkwaE1HTDVocjV1NHlTbWdNSlkrTFI0VWZSSVlIZVFCRDJjWVN2?=
 =?utf-8?B?bVVvb2FjbHFaeVo3VHFkUS9TbjVqaHhOSmgxclA0SVRUdWxnOHFLR20xUFlR?=
 =?utf-8?B?TldKT0pVaHRFOGt3Qy8wbVBhR3J2OEFWQTN3d2M2N2JkTit2Qm5seGJwRzZK?=
 =?utf-8?B?NmRjR3NrSDhXMkErTzd4aURBM0l3ZCtZYWZmRFhKNjFxWGh6TFMwQk4wOUN3?=
 =?utf-8?B?TEV3bHp5alAzQ3htMnpzS3crVzZFbko4TlhsTiswdWxJUEVXQUgvT1RJcUxJ?=
 =?utf-8?B?Mnhwb0xHWGxhaTc0dzc3R1BnWjh4VVdKbkVzYXo5dlNxa2NPTzBKR1U0Z3Rz?=
 =?utf-8?B?ZTdHMytXb2RUTkhGc3oxSTJwczNVZlNkdWFPQ04yUFFqYlFuMWpzS1hmN29a?=
 =?utf-8?B?WjdEZTdGSVg5OEh4ellxbm5sbzl3L29jZThoNUR3cjNpcVFKMlFQK0NHWmxu?=
 =?utf-8?B?Y0dDQ09yc1lyQTdDamFXMjhoRXczYk5qWVZacVdkSENSNWNpdEpZRytsVk1X?=
 =?utf-8?B?WHd0RnROdElQalEyQ2J2ZE5jRldYM245QVJ4d2tPcDBTcGxtS0U1RkpTa3Bz?=
 =?utf-8?B?RHBGV2FjdUdTWk1GOXJCNFdVOEFwZjZuaHZtSytMWElsMDdqQ1hXbndxM0ts?=
 =?utf-8?B?d3F0RnVCUEROY2lZSTNGQ1ZZRURnMGF1K04xaFJldjFWc2cvY0pEcFFrZUJm?=
 =?utf-8?B?VTFUallpS1VxV2hub1lqa1UzYmVwaldKK2ZpQldxU2JXMTNYKytFbDhidndx?=
 =?utf-8?B?aGJmSkxFU0QwNHU1WGtIS0tTZ1ZtRFFKcmNXTjRsNjZhcUpLNUNPSUxwZXlT?=
 =?utf-8?B?VVdPY0tzcmZ0ZmZIZnJJdlNibmJ1YU1RaEpTNTBGT0VHYmdPOTl0c3pmTVg3?=
 =?utf-8?B?Z216U3ZKVDR2ZzVpbFFaVnUzdmhQUTU5aUlrQlplQ3U0d2Z4MTBkYmRYOVFZ?=
 =?utf-8?B?NmltTnh2b2lrZXIvVEVYVHRQRDErV1A1OFRZZW1VN3VrSDNqM0JIS1F1aU9o?=
 =?utf-8?B?S2NGNzAzS1I5MFpXV0IraVlFRkpkb0ZmbTZYMVZDdi96T2Uwa05iVnBNd1Zl?=
 =?utf-8?B?K2ZvUnRVUm94UElGSHhhVWZNaXRTZG1LSlNRb1JpVGtxcGxFcTNMT0pEbEVx?=
 =?utf-8?B?NHBjbWxzU2NRSUN6d3JOaG5qb3Z6MXdZUXJJMkJlc2tObXZoQVRJZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a0c292-c9f0-45cd-d4c9-08de8a628c32
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB7917.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 11:34:59.8252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPM6q3zv7WRtVwNESn/TtWkA8zaZ0DL9Vxm0U+Se4jIQwbcBeh8wnbg2yTHJP4+GRp5ZsviU2kmH56vVoXDhHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7608

On Wed Mar 25, 2026 at 12:15 AM CST, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, Mar 24, 2026 at 05:33:06PM +0800, Kai-Heng Feng wrote:
>> On 2026-03-20 09:52, Bjorn Helgaas wrote:
>> > On Thu, Mar 19, 2026 at 07:13:09PM +0800, Kai-Heng Feng wrote:
>> > > Add support for decoding NVIDIA-specific CPER sections delivered via
>> > > the APEI GHES vendor record notifier chain. NVIDIA hardware generate=
s
>> > > vendor-specific CPER sections containing error signatures and diagno=
stic
>> > > register dumps. This implementation registers a notifier_block with =
the
>> > > GHES vendor record notifier and decodes these sections, printing err=
or
>> > > details via dev_info().
>> > >
>> > > The driver binds to ACPI device NVDA2012, present on NVIDIA server
>> > > platforms. The NVIDIA CPER section contains a fixed header with erro=
r
>> > > metadata (signature, error type, severity, socket) followed by
>> > > variable-length register address-value pairs for hardware diagnostic=
s.
>> > >
>> > > This work is based on libcper [0].
>> > >
>> > > Example output:
>> > > nvidia-ghes NVDA2012:00: NVIDIA CPER section, error_data_length: 544
>> > > nvidia-ghes NVDA2012:00: signature: CMET-INFO
>> > > nvidia-ghes NVDA2012:00: error_type: 0
>> > > nvidia-ghes NVDA2012:00: error_instance: 0
>> > > nvidia-ghes NVDA2012:00: severity: 3
>> > > nvidia-ghes NVDA2012:00: socket: 0
>> > > nvidia-ghes NVDA2012:00: number_regs: 32
>> > > nvidia-ghes NVDA2012:00: instance_base: 0x0000000000000000
>> > > nvidia-ghes NVDA2012:00: register[0]: address=3D0x8000000100000000 v=
alue=3D0x0000000100000000
>> >
>> > Is there a convenient way to connect NVDA2012:00 with the actual
>> > device?  I assume this is typically a PCIe device?  How would we
>> > relate this with PCIe errors?
>>
>> The CPER report is from ARM RAS firmware and not neccessarily be
>> related to a PCIe device.
>
> Right, I know CPER is more general than just PCI/PCIe.
>
> But in this case, I think NVDA2012 probably *is* a PCIe device.  How
> would we figure out which one?  If we have to manually do an acpidump,
> figure out which NVDA2012 is :00, and look for an _ADR or something,
> that doesn't really seem convenient for multi-NVDA2012 situations.

It's actually just an ACPI device:
Device (CPER)
{
  Name (_HID, "NVDA2012")  // _HID: Hardware ID
  Name (_UID, 0x00)  // _UID: Unique ID
  Method (_DSM, 4, Serialized) // _DSM: Device-Specific Method
}

And that's it.

