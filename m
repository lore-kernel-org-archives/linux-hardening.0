Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5851028CF6D
	for <linux-hardening@vger.kernel.org>; Wed,  8 Oct 2025 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932615; cv=fail; b=nFeVKuMTjIFSitdgUZpwj3GyXa+wJ1NsXIgU+vGT2XkCE6OXKuFf8CR5w1T0Y4k9b+Sf22yhKivh6poEgHNQjLWpCYoJRsv6RrThP597+ocKP8iSTmblDg2BOSIMc9lx/kKZJ9ZR2LZ6qRrrX3SGGQp8X1LPEQy3zOLscbxRy4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932615; c=relaxed/simple;
	bh=BDXZPVRq/hjbqbZR9jjXZdPjnQTGHTmkinzpbvD7xWk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J85MwvT9FGRSP0+pT9XR9eVRPKei+K+8ztrsqjOZNyDsWvL7KNXz4TK9+GWO99l6ESqA45giTBJQvw01AdsgTsHkYkSz/oIw832QcKDTqLCS4QS8hIlNs7O+N44zCifROMrDgl+H+hHq9ukukeNQPIY4jaFx9rJogABSasi5n5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZpfpRJxu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b02tr7ri; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZpfpRJxu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b02tr7ri"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598CNvRH010110;
	Wed, 8 Oct 2025 14:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=BDXZPVRq/hjbqbZR9jjXZdPjnQTGHTmkinzpbvD7xWk=; b=
	ZpfpRJxuuJMqvMshPDKqLCNzFBghPKhpzSJk7pcz4rjDgqndrpXTcpjyHWMN8H5Z
	mEVwbBqazhqqlRKKRfAMMp2HxqxSDYjd2gK0lTVbqj6V780FdL+S+izBqrtdLpbf
	aQzhap0wOEVkTJqN3InCBWPyOCH2w41+xJbr2CfL16B3GjSkXTdgBy2CuO0HQVFf
	4pqcn4p5PE3dOccRD4tmgmjrnNMGhhZM4SXTiRe6M84ROEXMQlngp/2GyuZ61jX6
	G4V2K3GmSRJ8eTkX4bVKAt/qMYW7kvp43PwcyVoOhkoy5yc7qo6NZSzcpr3Z+ygr
	5YFEeM3QLHD05beZC9q5Eg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nmdu0k8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 14:10:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 598CM3MK004808;
	Wed, 8 Oct 2025 14:10:02 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010067.outbound.protection.outlook.com [52.101.201.67])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49nnvk085e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 14:10:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqmpL1ea7pjpAGEFtZ6PpL4GBLJHCb5RtPUG4jPfN4xSOPV1bzXyqhNFmjZGbJ6qftFWku1CnZopd5iqNKLLoFIqq46Hhc47XBw8gnkdzhc35KmCaQSiyxdvNT8NHhrRcmV0IdYfCZKj9TSyeKpbTz0SNfA8TOimltSTCZqZaDZ2GO/nPhKjGc/aRd5urZcOEm/WqCi1Wi+XCYOofjMX2pn7P8xH7eNxuBqsRUgW9zo36sccVCqc6AaGy4iRsaGojPNm60rdlPZsFb+aprpDGIyTZDwgrNeXMlhgUUVTkFAZLD8JfOUtufFuRDqqqlASk7uMLxjPY2cg5M1zAMnv1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDXZPVRq/hjbqbZR9jjXZdPjnQTGHTmkinzpbvD7xWk=;
 b=le/JIQWfHq/OdP+krWfljhcUxgwQwpLjbL/Wpgix9VLmmCMPpwgewPz+P429DVKcwAC/PaCRb05VwdzCPevKKYl3YlbMje7LMnn7HBsTZwz8hFJa87f7NWh+/IcfPAepkB35QfwV3yBIJ5+46gqpZWLx3re0ZfW81Ta31l5GEIWMXdYl1A54lvBQfpguDRu3RozEDJ+cgrog+oPbMbScFDY5O6sDEq/AuVYUFEK6glU9746n7SqSRo/0FVglODzlOT4C75ypfd19oeCqbvfAs8kQx/cWMkbZNdwh0+TeSt88PT3a3zaTp6kMsaMLH7nOGnv0lv+QuDAbvKOcX6zqWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDXZPVRq/hjbqbZR9jjXZdPjnQTGHTmkinzpbvD7xWk=;
 b=b02tr7riNqyj4VePy/HEQT9/sGD2GHOpvDb36TXJuilfHWLbjXUbFALtLOrrB/V2vZ3eHFHOcDcSm0EvE7KqfhmthYkhIrbf0E7MGN+NcnML+4CErizr3cE/tK00wb7cmuBiEQQ+ONHFvtujZcECRURpIYcKPDKapZp/i/K1MC0=
Received: from CY8PR10MB6538.namprd10.prod.outlook.com (2603:10b6:930:5a::17)
 by PH7PR10MB7729.namprd10.prod.outlook.com (2603:10b6:510:30d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Wed, 8 Oct
 2025 14:09:54 +0000
Received: from CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::83c0:6ad9:b202:784e]) by CY8PR10MB6538.namprd10.prod.outlook.com
 ([fe80::83c0:6ad9:b202:784e%3]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 14:09:51 +0000
From: Qing Zhao <qing.zhao@oracle.com>
To: Kees Cook <kees@kernel.org>, "claziss@gmail.com" <claziss@gmail.com>
CC: Claudiu Zissulescu <claziss@gmail.com>,
        "gcc-patches@gcc.gnu.org"
	<gcc-patches@gcc.gnu.org>,
        "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] arc: Add const attribute support for mathematical ARC
 builtins
Thread-Topic: [PATCH] arc: Add const attribute support for mathematical ARC
 builtins
Thread-Index: AQHcFkEKxM1jfW7R8kqet3uNWNqdeLS3bskAgABsFYCAALMAgA==
Date: Wed, 8 Oct 2025 14:09:51 +0000
Message-ID: <E828A2FA-A5DA-472E-9C22-C04AF91D13A0@oracle.com>
References: <20250826042212.work.202-kees@kernel.org>
 <1B081822-82F3-43A1-B3C3-B0B377F50CE6@oracle.com>
 <202510072026.568651EE@keescook>
In-Reply-To: <202510072026.568651EE@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6538:EE_|PH7PR10MB7729:EE_
x-ms-office365-filtering-correlation-id: 1fabe50f-bd9e-4887-013a-08de06745942
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?T29UWE5hZmYrSGZ1OWM4blNpYjR1Rlg4eE8vbW9vQnV5QmhTVENzNXN0amNP?=
 =?utf-8?B?NWt2M05HVmFEVE42bTNlb1B5R0NuMElmUWNRZmE5RUFIRHUwV0ZBakpIeDRq?=
 =?utf-8?B?bWk5Q2JtNVdqbnlRODlCbTFWaUVubVVuM3FaR1JpeU13T1dDWTE3QnBCek5T?=
 =?utf-8?B?Q0lDVGJpTFVXck5pZUN1ZGpoaS9JcDlzYWE3Z25HbjRWMm0zUmFyYVdTUHI0?=
 =?utf-8?B?YTNwR1BkKzRvKzF5YTJTN0RUUk56MXBreXYxMjdmVDZSNDlRajd4WEF4WUhs?=
 =?utf-8?B?cndBK3pqZWVobXBIWndCMkxUUUtmcFFwTEJadExFVE1McnhUZVpPVXgyYURV?=
 =?utf-8?B?SUdJekRnVEJUUUsxcE1ubFJ4QWV4ZmRqVE9qaGZkY2xCNHYxSEpwQWp3NUQx?=
 =?utf-8?B?dGNCM3RkY21uZysxdkh1akI0TlBPS0lRbzdYODFlNTQ3UTV3enk2cWcrVjNJ?=
 =?utf-8?B?SFFKeThLVkwwZzRuYlVEOHBqOHFwOGkxUXpwdHIxUHhoUXBDWmI5Nm8wQUd5?=
 =?utf-8?B?K1QwSittRklDT1N4b3ErN3BkeVFWYXgrMURKUlhrTkhOTnl4RDc0c2M3TzBs?=
 =?utf-8?B?WDl0SjdCM2ZqRmVlSC9UU1dDMGwxQ3NJanpZenNMaU15eGNDZ3h4WlpML1JF?=
 =?utf-8?B?MXdyaHV2ckVNemVrM3VzQ0NGSXptSFFveG5raXVLU0dsRi9iT1EzL244UElP?=
 =?utf-8?B?K3pqb1Z2NEZ3aGErOUUza2ZhUzI0TGl3bGxLZlc2dHVKMUtpOHd2RE1NaFVw?=
 =?utf-8?B?OEVyS2JnYXBIZ3R1SnJNK1MxVVBuYnZJRlhjaVQ5bWZ5SGorZmR1SzFxd1o1?=
 =?utf-8?B?Q2xzK0pQZENJcklCYjY3ZFN3Zjd4UGdDWnVmbm8rQmRONnR0RjdvekFodTRY?=
 =?utf-8?B?eFptaVVWOTlsQnNSZ0daVENPNXNIQkRsdnhqQ256NVRoRDV6Y24zQm9Gb29h?=
 =?utf-8?B?R2Q0Z3FGZVVLU0NrNmJ0Yk5RVWlxYVZ5alFuK29kTGpVd3JzQXd2bU1DSEE0?=
 =?utf-8?B?aUdZYWhrTE5wY1BLVnFUTDhROVl3RjdLWjdVb2k3K3NTZytGUmtZN3lyMnNt?=
 =?utf-8?B?NnFtV1ZsVW9yNVJmTXlGVmtwYllVT0U3bi9PdEg1QTI4SnlxOVdFVkczYU04?=
 =?utf-8?B?OWsyUVJha1ZDc21jWDFqSG14Vm9ZTWh3K0xsQTRXdTdlUDhBckhvTGZ6K1dx?=
 =?utf-8?B?aXZoS0wxVmsrMEdMUU51TjByYmpmMzFNbjJtV3RMTGI1eGc5aU5wRUpjU3Ar?=
 =?utf-8?B?QUhTUzRaRGpteENGcFM5MVY0eGtUOVlNaitwK1ArQWg5eGlTNTVlUFRNbHl1?=
 =?utf-8?B?ZlhHMEpPSlk4bFNmUExtYjBCc2J5Y3lyenQ1dFBiMmpOWUgvaXppbWk5NFhp?=
 =?utf-8?B?aE9LWmJzM2ROVXlidXp6YnZhUksvOXBHYXJDcFY4SFN4RmMrVlM3WjlXL2Fv?=
 =?utf-8?B?NHZzNkI5eHBLUE1remNZR2NvRzVKOTJ6MHVMcHJ4TkgrUjRySnllRlhKREVR?=
 =?utf-8?B?VUxRbUFYVFZKTmdHY05uRUx6SDR0NGwzaW5zMjdKanpQVVcySEYrKzM1RktP?=
 =?utf-8?B?K1dnYVAvR0RtbUU4TjEwSWhEMzhSekRSSytOcnA3S0xxSm4vZmIrUGRpVmdM?=
 =?utf-8?B?by8vc0dHcDdScndxM0J2NVNhUjRXS21TNVlzV3NuT0RQRVoxNFJnK0NtSlZn?=
 =?utf-8?B?M0h6Rk55azJXMGltNXdxenM4ZU9obDZESEVsVCtHL3QwR0dNampQTjhEYnhk?=
 =?utf-8?B?ZVhYR09idEsrK21IV1ZIcFQwcTArRWlrVmRiYzU1M2tXL3QrSHh4ZkFFSVQ3?=
 =?utf-8?B?ekswM2N6OVZKekJ0V3VhVUJ1c09aNzlPeExWU2xSZW9uM0FXMFRrUUFJOGhO?=
 =?utf-8?B?bjhMQnNUUjNlMU1mT0EwVXkyb3RKbUh2c0hDdzE3MU5WcC92U1VJdm5oQUxY?=
 =?utf-8?B?MVFyK1RDY21PalNPTlI2Um8yNFg1RGdHeUxDeFQyQlZpbmxNcXM0OHRpRk5W?=
 =?utf-8?B?YzBmYTBaMy8xcDB0OHhaYktuajNlQ3hScmdSdWIwWHFtdk52blhxWHFWc3BZ?=
 =?utf-8?Q?cK67U2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6538.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cUhKWHFrN0hSUWNuaFYzckEwRC9sb2wzeUxxNnczWFJiZDVMeVFXc09WUnBz?=
 =?utf-8?B?TWVzSWxheUZpbXdqU3FpeXdJUkN5cG9DRUt1WEl3SkF3MHJsanNFTFhMZGEy?=
 =?utf-8?B?cU1CYlo5TStPelovRmlBZGFwekFXbkcxQWZRSlRWUWVzNzBTbStSWkRyd1Yv?=
 =?utf-8?B?SjFZdDE0VCtka1BMTk8vRFZodjcrdlpGK0p0UzN0a2psNFJKaTBnYkJYZjFr?=
 =?utf-8?B?cStVL1YveHFCTkJ1RTdZUVY1UkNmQzFqRnh6aWNuSnFFMWRkYndzTHhPWXYx?=
 =?utf-8?B?UG9FWGl0NXFnMXhSSzdQWmFIVmZJSWVOcmd4dHc0VVpjSitwNEU3WkJGNlRw?=
 =?utf-8?B?ckNCVXd5RnEzZFZXdG0vbUxXQmZ5SlNpOGtWWWc3U1FXalUwT1RWVTd1Rmg2?=
 =?utf-8?B?aWhGcHpCd3hCRXhtVlhUeDV2YUlVSmZrYk9RYy9BRFp1dW1lSDdZYnN6MWNX?=
 =?utf-8?B?T2I1RHpJQ3N5OExkWE85V1BBaWtUMzA5NjlhNEFpQlcyeEppK1ZXaXlibklT?=
 =?utf-8?B?L1AvYkNoSlNvbXdISDVsZ1JkTWlKTXhLamcxY2RLMTVCOXpRNU9KbUNhM2Zq?=
 =?utf-8?B?aWxXTGxaekYrUnFFTEExaE9DS0FQWGRzMXYveng2RCtnN29UeU1XVm5TTkNT?=
 =?utf-8?B?d2ZCK0IybWkyOFFzZjFrQVFsWmd5bUp6STN6MDhWZmZBbFhTQ2VLWkxxWEor?=
 =?utf-8?B?a0RxN0tORFoxa213VGUwN0s1SWZ4N2hvZUtKU1FQMDVUMWZHcTVhWVN4dkZm?=
 =?utf-8?B?OVhpWHJVclljSWdFS01ZVnJnbUNuQVFUd1BsK1gyM2ZHcDA4S1FNWk5LVDVV?=
 =?utf-8?B?TmJyNW1OQXBWSHpTZU1CR01aOU5Rc3NkSUVZM2lJdzU0V0hIcVJwdUd0QjZp?=
 =?utf-8?B?MnpEN3drVjNPOE1KM1N2dk1wcDEwdXlHNk9jS09zSFZhbHBJWWZHQ2Uxc0dP?=
 =?utf-8?B?UmpOVnIzVlREZFRYcERja2diSmZUNWhKS2E3VUpqbDZCNS9LZlVacmdRTnNi?=
 =?utf-8?B?bWUzSC9HTnVyekJFRlBXTUxyV1VGMmhMNExxMm44bFVGelBveUZINVlpVnBn?=
 =?utf-8?B?OVpQeElQZ3BGMTBqTzNHUlYwOGVtdlVoM2E4UlRMYm1USk0yV1RnMGYxRjIv?=
 =?utf-8?B?Rm9CczNTbkR3VWdzTU9Fb293ODJWSEp3cHYxdzRZV2VmK09jUHZmMFNkeVJi?=
 =?utf-8?B?cmIweDVhUmV6M0c3TzFEVk1yM1VkSjd0SHBWcXF5bndKK3FjUnltVmYxaktN?=
 =?utf-8?B?R2NycTl2TDhocUpicFIrTTBWcUdsb3JzSGoxOTlQTzZUMHFON0ZDdG5TUEFE?=
 =?utf-8?B?bUczc2IzSjUrKzlCcVZFYVI1bTFlRmgzWVoyNkdpZkhHS1lQR1RZKzdvMVBU?=
 =?utf-8?B?QXFjRnNvc1Q0ZVlZdlVjb05PTXR5T29JN0pRdFdvN2FUSVdkQlYvT1IxK09B?=
 =?utf-8?B?akxEdTNtT3VQcEs3cUptTUcwWVlFM3RzWVBNOXJ1V1YrT2JlZlF1aHpLdjlq?=
 =?utf-8?B?T3JLOXgwSFdnNVBHczhiYmIyNlF0b2VxellCdlpMTVhwb3FNbW5ZNTU5N3F3?=
 =?utf-8?B?ckJPdEpuVUtYcU9sVzBVMWhXdUh2TU02aDE3OXVkT2xSQ3lEMTNsc0dBRUxx?=
 =?utf-8?B?MFBXaWVsY1ZVNXUwTVpyeWtVd0Nsa29JTEcrOWRHVWxmai9RUlVuY0hvYzg4?=
 =?utf-8?B?cHJLS0RucExFTTJQVG56M0R5TWlHNkkvclRaVkFLeG9YSjMrMDQyTUdnaGxC?=
 =?utf-8?B?R1ZzSG80NFk2UVMrcjVIbkVScDlpQXAwNmM2QXdVR0JpbmRqMm8yU2RGRm8z?=
 =?utf-8?B?ei9lMFdzUnVjS2w4K3M4TmZYOStVZGU2SWJ2R3JoM1pxU1pxNTNieUkxcDNa?=
 =?utf-8?B?Z213MS9PZWpIOHk1Z29IcHdsODFDM3BDRHdYNEpRWXo0OEZxYjRtSy9NcVZ1?=
 =?utf-8?B?aDdGQ1FDRTJiS0lTVVR2Sk1xVnBqNnJiNXJrNGMrbm5UbmhJRFJmZ3pmWWFu?=
 =?utf-8?B?d1Y1N0Jaa0dDN3ZOU1FBUzJieEFUcUlxdHU2VVl6TlJGQTYwaGJQMzd6RDA3?=
 =?utf-8?B?WjJCclFRSVRoZkhSd1pHWmxwT09RdTd1VEpEQnMxLzVuY09icFJ0UTFmdHZS?=
 =?utf-8?B?NnFkN2FqQno2eDQrUCtPZkZkUzBSYVlkUUFUVGd3eU53cGlCV0h1VFVGNzJT?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E02AD3DEDCCF58448DE5432B60546E88@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dNFkuav1zMr9FxNwXQyaazsjpTl2llh13JcQRdEBo0+yT25i/I7hb3+28bSKRJr0jQPoNna8DSB5l1rLgzWXARfi8mttkyVttf5Sq4ZeZ7RWk6jF56XYrRq5Q24D5hVC7XzGPa8Uj96AxatoPSh/UiVziYl2/nFtbWCxC9ZtD8oefo+oCs4QvFiu1ir8EEn/KWl7wAyspV2cR4rdIdxhTRyD35+N9d9R2ZcL2VkaLU+yLoz8VCPoFAImqk614E54LcSmmUMpxLOPswrg4+PZyiQZx6vCJroByaF3R56jdP1gq7tlqXzImQV/fm9KYzg3iIye+5p+6l2QLj0x9DkRvnoQrKQFMbmVIlil9FGwat+sAgMHnNZ/5mLz3YFiRfKCY9wgjhoRWry86Ic8QJY53uxW4w7CjjBuxsEIMvmihe/eQXdS7DqjNkspQQ41zj9n++pNPPsgJ/TawYrJM7sxPfPi1oUwon/UltgE+hXQyzllVtDX4D4EIta5CabmGJYiowpZULDziir9loYCYQH0wO4D1iT1/qH6jK4fyA9HD9SuxomH/fFYKN+uSYzqmsTMkTxn0cc0pY/A8JswI8pd9BqwvEhj3oPiCu01akB4ybk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6538.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fabe50f-bd9e-4887-013a-08de06745942
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 14:09:51.6153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mQcFImkTErtA64Bb0PADXOihzvqTlYc5VK2rW0bD4kvNlC0tlU6MH6OmY/B8AKeXLOridfv+06PmsBtWGrvmWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7729
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2509150000
 definitions=main-2510080099
X-Proofpoint-ORIG-GUID: 7voDDUjEhcTKU1U8zoAhfHGacpI7ExLz
X-Proofpoint-GUID: 7voDDUjEhcTKU1U8zoAhfHGacpI7ExLz
X-Authority-Analysis: v=2.4 cv=X8Bf6WTe c=1 sm=1 tr=0 ts=68e670bc b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=hgxqfC5c4xlaG4SVpWcA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12091
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDA1NiBTYWx0ZWRfXwd8iIkDZCRup
 XsTnx49Go0uLmA4J3JcBAozo4dEyh7PKkYHtHonjTUPhoUm6iSUkujxYZifLwjRmrKTVTHdP0/C
 SNN4dI9Ds5A5JgMuVMuBJKm50GYknPcyxAdl7vWsM2LNylKgIorrtZEwi+29pq13+QQZEQ/bXGg
 FP2CBDiV7sfCeZ2DpdyYWDGl9D/bJf2FK7M4htRvVGaFSsgS8h+xoD0LWr/lRv16PGObppALqCV
 O4dkSjz5/OXogy18lFtPyYsbdKkmx0SuMVG+7gGl8hF6X5cHODlDp9HsTZRQvcrwhu8o24Xtdbp
 +GFbmlG8EzrKjusLz+52f0k8UC0P64vrBLCmF76ZKaxHgXQiBClkjjGcbwSV3mAKgw/jzUpAA1t
 F/spmJ0rYFEg6NWbvHlIeXYZl0TucUjy6xPDNfZ1VrJ4Yu7V0PM=

DQoNCj4gT24gT2N0IDcsIDIwMjUsIGF0IDIzOjI5LCBLZWVzIENvb2sgPGtlZXNAa2VybmVsLm9y
Zz4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIE9jdCAwNywgMjAyNSBhdCAwOTowMjoyMVBNICswMDAw
LCBRaW5nIFpoYW8gd3JvdGU6DQo+PiBIaSwgS2VlcywNCj4+IA0KPj4gSSB0b29rIGEgbG9vayBh
dCB0aGUgcGF0Y2ggdG9kYXkuIA0KPj4gT3ZlcmFsbCwgSSB0aGluayB0aGUgcGF0Y2ggaXMgZ29v
ZCBhbmQgc2hvdWxkIHdvcmsgd2VsbC4NCj4gDQo+IFRoYW5rcyENCj4gDQo+PiBNeSBtYWpvciBx
dWVzdGlvbnMgYXJlOg0KPj4gDQo+PiAxLiBBcmUgdGhlIGZpdmUgZnVuY3Rpb25zIGluIHRoZSBj
dXJyZW50IGxpc3QgdGhlIG9ubHkgZnVuY3Rpb25zIGluIF9fYnVpbHRpbl9hcmNfKioqIHRoYXQg
DQo+PiBoYXZlIGNvbnN0IGF0dHJpYnV0ZT8gIA0KPiANCj4gVGhleSBhcmUgdGhlIG9ubHkgb25l
cyBJIGNhbiBzYWZlbHkgYXNzZXJ0IGFyZSBjb25zdCBhdHRyaWJ1dGUgd2l0aG91dA0KPiBkb2lu
ZyBhZGRpdGlvbmFsIHdvcmsuIEknbSBzdXJlIHRoZXJlIGFyZSBtb3JlLCBidXQgSSBkaWRuJ3Qg
ZmVlbA0KPiBjb21mb3J0YWJsZSBtYXJraW5nIG90aGVycy4NCj4gDQo+PiAyLiBJbiBhZGRpdGlv
biB0byDigJxjb25zdOKAnSBhdHRyaWJ1dGUsIGFyZSB0aGVyZSBhbnkgb3RoZXIgaW1wb3J0YW50
IGF0dHJpYnV0ZXMgc2hvdWxkIGJlIGFkZGVkIGZvcg0KPj4gdGhlIGFyYyBidWlsdGlucyB0byBl
bmFibGUgbW9yZSBvcHRpbWl6YXRpb25zPw0KPiANCj4gQWdhaW4sIEknbSBub3Qgc3VyZS4gQnV0
IG15IGdvYWwgaGVyZSBpcyB0byBtYWtlIGl0IHBvc3NpYmxlIHRvIGFkZA0KPiB0aGVzZSBnb2lu
ZyBmb3J3YXJkIGlmIHBlb3BsZSBmaW5kIHN0dWZmIHRvIGFkZC4gQmVmb3JlIHRoaXMgcGF0Y2gg
aXQNCj4gd2Fzbid0IHBvc3NpYmxlIGF0IGFsbCAtLSB0aGUgaW5mcmFzdHJ1Y3R1cmUgdG8gZG8g
c28gd2FzIG1pc3NpbmcsIHNvDQo+IHRoYXQncyB3aGF0IEkgd2FudGVkIHRvIGFkZDogdGhlIGlu
ZnJhc3RydWN0dXJlIGFuZCB0aGUgZmlyc3QgdXNlci4gOikNCg0KWWVhaCwgdW5kZXJzdG9vZC4g
QW5kIHNvdW5kcyByZWFzb25hYmxlIHRvIG1lLg0KDQpEb2VzIENsYXVkaXUgaGF2ZSBtb3JlIGNv
bmNlcm4gYW5kIGNvbW1lbnRzIG9uIHRoaXMgcGF0Y2g/DQoNCnRoYW5rcy4NCg0KUWluZw0KDQoN
Cj4gDQo+IC0tIA0KPiBLZWVzIENvb2sNCg0K
