Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A731DDA24
	for <linux-hardening@vger.kernel.org>; Tue, 26 Aug 2025 12:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212889; cv=fail; b=Q26OWLB8t6n4Aga/YWHJxBDnEAS3GHB+76f0i9xCFaz/SjbbFp1bmauVfbAWoPeDx/LKWqIjNCnfsRzrj7aoDI8jk6BsqSiqQDgbikyd4idC+PIX98ktWCXNgSMipqU+xlWr4kKXR8eqO7BgbOR2dGurvBm4HBhuuOm5P6w7J+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212889; c=relaxed/simple;
	bh=m1moKjirHVA8FzLePN0RlQGNeohpgHvNJgSjLw8aKCs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WxQ00NwMZ3zrXP4hINybjvu8dyK4/HnChSCly3iFvB5CeY4vYixeSm5fVDKGlLkbk2gvOYx+Xm313YAe/4em6P5cBFfmRh+LEbSneYgrkWyBuk01AHxmk3+CoyCBRGYNOI3nBsSr19Ft7dnAR5isVFstfOp0dYvUmXmy4g/IzWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JJlgQE7u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Toq6RMzN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JJlgQE7u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Toq6RMzN"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QCHvgH009006;
	Tue, 26 Aug 2025 12:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qMqD0eJUE4miVJiXyVTyXZcL5xVk/rWlvZc8ZzChqkA=; b=
	JJlgQE7uudANZ22IlI+acUZZLPMu17DAd+XxdWghDAGMko286aqZNtwVMEp8qQJU
	GgQPcLiKl+6RmGhMhdPNwkvLtXyf4YHF5MXVyckOFCNfdtGtfYt8Y13P10mTjjFZ
	nV6iDrdNs6vxS8f6WjiVnfD9Y+a3wOnUwzNCYud7VK+V3ubx6+5vysWQxDNvL5op
	ynHnqGUUCuDXBTk1hHsjFVKY83v8U+zM5yXX8uzw/Vs2LjC8lQ9P2svaF48EZfFv
	yTcQR853ldt+FD3+QPWKHHHzQGfIjtPyVoKTd/s9qrr/2/M6xc0THJ2mSssDKa3T
	Ceemg8zOtOVgexBMsPAj9w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q58s4b4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 12:54:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57QAr879005115;
	Tue, 26 Aug 2025 12:54:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48qj89r8ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 12:54:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDI0IXRDywwDfEmRVu/vmOz4hpJNEKUgeI+o9o5dhsiko7nG9XZkq3De7Ajj9BAwt3mkPip5KoD3raXpwLmG0ImY1YalPO+Bc56GR3yqIRxy7UWvS2njqNoq+oTtNlbMQITPxDY/mtGPcpAyiqw8thxwKUXu/dm2gcGL/m1zVy3zv0rtmJAg9je3Xmvg7UDWmVGKYhMvao3B1KR7N3dH4/nP0QRpETwl8ChRsvumfPjQv8Wtt3ToeFYZQmLfxtFCile3/n4F+H9CwKB5ds6TFmmVL2HUC8BfvKZuumtHlgKLsQdeh8EVMqaXGokoEB3CbIXf7Z9gCQM+ikgpwu5DkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMqD0eJUE4miVJiXyVTyXZcL5xVk/rWlvZc8ZzChqkA=;
 b=Fv0dZqjcKU/dOKRqpSpHWDCNE5oAcuBYULBLWeEXbl/iLZm88Yhvu/3gmbUo+bns/mK/s3fVUUG1c46skUjY6u31TIflpItskM0+T5YK7EC1mBMkUYSN8YUrEU5yHCRqChHB1uatkLGqaof96/MHNF+9NnFPAc/Wd6Mtg9QRQtB4GiQTwjlIcPVALRugXm9tY/YbExvK+wMdb8Bx82wJrpDESUnkbttMnyz+WDanUjBlYzthmo8k6eP6dzfXqUCwpzvP88LcIcqPsfOAIA8UMP5A6N3EA3PhuAnA5PGPgnsPaIk+B4sjGBw9tlJGWdLDuOQf44mTsRhVUhTd0xho3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMqD0eJUE4miVJiXyVTyXZcL5xVk/rWlvZc8ZzChqkA=;
 b=Toq6RMzN6LGLdN9mUtDDeGqfHVS/2kd05SEy7OJ8KZEW7GKuDy2LEAVtb7ZTBHrPiq7jWN3uO2CX33hP6FjK7TqTM+6r7pweF6oqiA6bVSnacXQKdpPUW5ErF+W58qwNmmjFZ+4LzHxzA6T5GMty/w9iS2NmR+qCRvttBvJ5Pnc=
Received: from DS7PR10MB5998.namprd10.prod.outlook.com (2603:10b6:8:9e::20) by
 IA4PR10MB8278.namprd10.prod.outlook.com (2603:10b6:208:561::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Tue, 26 Aug 2025 12:54:34 +0000
Received: from DS7PR10MB5998.namprd10.prod.outlook.com
 ([fe80::af84:77bf:20c6:ebed]) by DS7PR10MB5998.namprd10.prod.outlook.com
 ([fe80::af84:77bf:20c6:ebed%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 12:54:34 +0000
Message-ID: <acc8a12f-e9c3-4c1d-9e7f-9dd9be473292@oracle.com>
Date: Tue, 26 Aug 2025 15:54:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Fix sanitizer attribute infrastructure to use standard
 TREE_LIST format [PR113264]
To: Kees Cook <kees@kernel.org>
Cc: Andrew Pinski <andrew.pinski@oss.qualcomm.com>,
        Qing Zhao <qing.zhao@oracle.com>, gcc-patches@gcc.gnu.org,
        linux-hardening@vger.kernel.org
References: <20250826061735.it.634-kees@kernel.org>
From: Claudiu Zissulescu-Ianculescu <claudiu.zissulescu-ianculescu@oracle.com>
Content-Language: en-US
In-Reply-To: <20250826061735.it.634-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::20) To CY5PR10MB6011.namprd10.prod.outlook.com
 (2603:10b6:930:28::16)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5998:EE_|IA4PR10MB8278:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd19af2-0526-49e1-5572-08dde49fad3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmx3bDJZRXhUTnIwS0M3eUdVRG43ZUFxVmhnamQvaG01R0tYRE8vNzBUZUN0?=
 =?utf-8?B?cGJsNkFjRHdITXduWlgxNDRJV3M3aG12VHdVd3RiaDZWNnNHVE5OeldoL2ZO?=
 =?utf-8?B?dWx2R3RxZTZNS1NReHZCM1N6SHE2QTN1R0t3RVFwWHpKZllocTlrOUNGend2?=
 =?utf-8?B?a1JxWjhtRGthcitDVlM0M3VlYXg5SGNaQ0RmOWNRNTlaOXhUNkV4MEY3R2ZJ?=
 =?utf-8?B?UDAyeHRQQzZDTmtwbVNickkyRlowWmM1YUxOanVnb1RtakZ5VlBSUzJnVEM3?=
 =?utf-8?B?azNsU1kzOExaSmxRTHdUNVFGVDdjeVhaamVXMUM0dlpYMEtUb1hnOFRJdGxz?=
 =?utf-8?B?ZmgxRmpnSzl2ZER2bENMMWhEY29IZDhVQ1JWL1E1ZmlKSndZMzIzTnJpU2lX?=
 =?utf-8?B?NWpMUkhxMnpWNkpScVUvZVRXV3ZHT2JEUE1Dd1NiVWErY1ZJMjFqc254S3lD?=
 =?utf-8?B?TGRraUZjRkdiWGxZb0VkS1hnQ0twUUxmbUhEVWQ5bEFSTnF0NGFvZkorZm5p?=
 =?utf-8?B?aEUzYloyWUR3NHBHUWN1STA2SkcrREpoT0pOTjArbnNPUzlrZGIwQXBoaDdN?=
 =?utf-8?B?VGdvazVncURhV2JrbTRFNHhESW9FSFViY1VVZFczYk51dkh4VTArWmllQXdw?=
 =?utf-8?B?dmkyeVpYZks1UE4rOU9rVURWby9IV0JtR0N2SkZGM29LV2c1S0w0OXRjeUFy?=
 =?utf-8?B?NzdjLzZqR0pYT3duejlsSjZtTnk2ZUJPNEdRNnlOVzkrY0tYWnM5bU5LM0FZ?=
 =?utf-8?B?NWR4MDAyNFVSOXlMc0c0bk9pQWhnR3lMVkEvaTFnTU1PbVgreis0MEZZdkdS?=
 =?utf-8?B?WWNwa2dFem1QektBT2xickRKRUZ4elhTamtvak1kSkd2RXNIaCtSKzdlRHFZ?=
 =?utf-8?B?NGhtbGltcEhnbzQ5MEVMOWppQThRQ2oxSGdjbW9rRFpVR3Q5VW9NOTQzVklU?=
 =?utf-8?B?YXZ1QkJobzNUcExROUN6c0dLY083K3FrOFlWZmltbldpci9wTHpYdXpPRzJO?=
 =?utf-8?B?VlFwU2s2VGV4RjNFbW9qUXJoSS9VZ09ORnZuQzdkVWhTbmMzQzVqRXN4Wnc2?=
 =?utf-8?B?VUllcTlJZ2xldUVLTTYzMUI0eDF1SXlvM1lzSmJibmIrdUoxVkkzZTNSRW5Z?=
 =?utf-8?B?ZERNTnNsT1VvYVU3R2VhS05aRXhMam5MTitOa3AydVlxQTBYZGRtN2NEL0F4?=
 =?utf-8?B?U1ZmYlBoSEVTd01qc3hUMW9ZbTFiYXR3MDcwc0x2VHgxRHVMbXlzWVF0VGtZ?=
 =?utf-8?B?aVlZOGdsQlNnK2I0NzRTZUhWMTVRSnRrRFI5VDNRc05GTXZhSkd5LzREZUQw?=
 =?utf-8?B?QVg2ZCtuNXBBS2hyalZIK3VjYVJ1MHQyMEpINlVIWnNtOHBESFl4ditiZ1Na?=
 =?utf-8?B?VkhEVnpGTFhmb1RpTU14cUIzTEJQT1ExcjNBeWFQRldJYTYrNFE2YkZpWmJ3?=
 =?utf-8?B?eDlEa3hVWE9xU0ZnL1lyNklSeXp5SXlPVERSQTkxZ3A4WUVOOXh4L0lRcEw0?=
 =?utf-8?B?MnhBSWFkNVJFN2hYVkxIbEZLRHE0MlJxTElhVklnTUw5UXlrTk50MnN0MGtP?=
 =?utf-8?B?NFlDTUN4eW1LY1NiTE1XaUh2bUVqQm9CcWtHcUdGUktkclQ0RVZPa2VzWFND?=
 =?utf-8?B?eU1nVHJzenl6emozblRxMVhFZ0I5SDV0b0V2RVJMcEYrTURYalFXUStwYzRF?=
 =?utf-8?B?cEplUWdESXhvOWpOQ21QVDJGSFlQTFhISXR4djB2STFMaHl5ZUFSR1B6MFhU?=
 =?utf-8?B?cjlUd3M1clZXME8yQ1JEdWVIT1ljckV2MUVXTDQ0QkE0UGJLNHJrTjVDckRo?=
 =?utf-8?B?dDdCV1hVWjU2WnVEYkF3MWdHOUhYRXByMktPcndwcWgrZGFwT3Jic2hzOWx2?=
 =?utf-8?Q?T5yj1MW4BZ4Hu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5998.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTdLYnJMZWxXSGNGQy9MWXRzUzZZUWc5WDJkQkRqbjg2aHcrTFU3OVJha0Yw?=
 =?utf-8?B?SlJFVjN5SFJWd1Q2MVZjVlpRREk4Zy9CdVV1LzdMcjhDWHM1QUg0ZFIxZlUr?=
 =?utf-8?B?ajRrUmtjYkJadGF0OWZSa3NJV0lVUEhnV1VPUGFnOTBsS09ZUU9xTVE2NnVL?=
 =?utf-8?B?TTBLdTd6REw2SGNnekw0akZucnFzdnZ5aCs3WHVsQlhlcGNsZldoazBzak9D?=
 =?utf-8?B?ZnIyVlkveDd1bmJwUGh0K1NuSDlKTE1GNEFwM0FYZCsyRmdUNW9vNWVmandt?=
 =?utf-8?B?SUN5enRWRFpwYW9xNkkvNEVMQkE2RjRyQUZ1M1JBc1V4L2lHbnl5YVUvNEFz?=
 =?utf-8?B?N2R2cnNQc21ZVmU4dmRHM2xNRkJvQkZ1SDRpL1EveThIZURvSzc1c1VhQnZa?=
 =?utf-8?B?amhndjIxOU1UN3I3ZExLdlZScVV1azJPTDRkZ0I2c1RYa29TdzJ0V3pJUTJX?=
 =?utf-8?B?b0dlQ1p3ZTdxV0x2VUJqd0daRFd0UHY5Sithd3U2ZEtESDIvbmhwbHFzRFFX?=
 =?utf-8?B?aFM4VWk0cVB2OHdJa044UGw4SE0waTkxbWxrQVBNOXhlZ3VQSjJiVzkvZzVV?=
 =?utf-8?B?enoxSTgrLzlrNEVsenVhV0NLMG9kdnltUTI3OXRYSHB3SmNuY1lyUWI0Y090?=
 =?utf-8?B?aXh1UVNWME1pc1M5akVpOG8xSk5aWmVWNEY4UHVla2tONGd0aE5MWE1QOUJO?=
 =?utf-8?B?ckRQNkl4YjhKdEFtSFJwRkFSMmZ4WUFVMXFSNnpaTWtJZm9iV3E5Zlk0V0NF?=
 =?utf-8?B?Qjlsc2JUSHZKRVIvd2FlcjU0bXg4djNjZExTekZaazU4SU5hZUZHaEI0ZHRL?=
 =?utf-8?B?ZWVLVjhzb3hpL3IxaHRGUzRuYldYbHpnSFc3bTluU2l4YXRMWVBBNTRBT0Q1?=
 =?utf-8?B?ZkY5K3o2eHZObThlZVROeWhKU0FnRTdMZW1SRCt2cStUb0JPSmIreCt5RTZp?=
 =?utf-8?B?VGwvbi9WejN6WmwzekpNWjNhTGxvTit2YTdkZWVDLzg3Z3kwUVZ0QnE3VUdw?=
 =?utf-8?B?dzZ1WWRvWUkwZ1BHTUIvdFhxTTF5VWtRZEpCVGIyT2JjbU9YK2Q4cFgzdFN3?=
 =?utf-8?B?MGszYXJFMmZXOHRLSjFSVG9paFVZTnZtenNQREN2V2s3TDBVa2RLaEtqOXk1?=
 =?utf-8?B?NEJva1VoNENVZUg4ZVllSWwvTFVRR1ZkeERsWFBNTnc1eFJYTHpKWllzTlRH?=
 =?utf-8?B?c0VaNnNtbDMxNUo0TVVzNmNWdWdPcWNQb2VmRGQ4WUw1WUN0UXAyUjJnN21V?=
 =?utf-8?B?b3p6dmlyYVNoREx5a0hhZUV0Qm1vbUN3LzJ5UlMwYTJockh6MzR3N0V5SFBT?=
 =?utf-8?B?cHErYTVZaEhUVXdxSHNjR1lqbXNnS1VTYmkxUXpOWElySXJqWC9XN2hSVHVq?=
 =?utf-8?B?MXQ0cW9uQnRGUDJrTDFQbml5bGxEbUNZUlBPd0t2T1pHRUl1Y2YwUTAvNjEz?=
 =?utf-8?B?L1BwWm5NMitDSS9hT0RJN01ZdDVPYVFWSDlueXA4YWo2Wmx2K1BzL3A5NllN?=
 =?utf-8?B?RlcybjYwTXRNakRSUUZESjZvYkRyZ3p1d29zMkFYc29nRzZwVUZVUUZMaHVo?=
 =?utf-8?B?dXp3Q0FiSmQ2QmpTNnRtOFcwdHczMzlxZStvNlZVZHphRzMxQi9WejhzRXBw?=
 =?utf-8?B?TUpmREZQczczTXJ3aXphU1Z1Z3JJeDNWaU90T2E1S09oL2JMaXMwQlNaUlVh?=
 =?utf-8?B?QjBDSFhMVjR2eUE3UDdWSTBwbGJCbEtaWjlFWks4R3RpcmNMZWdvb240dVdG?=
 =?utf-8?B?dHduNHFXVUtHNm9Rd2lqV2l2a3pCSEQwN040akUvKzF3UUI1eEFnMHBVVmpR?=
 =?utf-8?B?ZGN0SUZiRFk1SDRMV3VLN0MweDZjbDFmQkpxZDhHTWo2QlhJbzNwUEpwd1Ay?=
 =?utf-8?B?dUkyZklWN2ZySlZlU1lEdnZUUWZwZ2dpclNNc2JJU0NTNm1wUVlBVzh4cGc4?=
 =?utf-8?B?by80cjZLV0V6dnh6SHZ2Q0JRaFc1NmtBUWQ2Z0ZOMnhxQVRzenI3UUx6WXJo?=
 =?utf-8?B?MkpVVmVZaHN3Wjk5cC9NelhKYktwdHBIZVU1aTlKbFZHSVFvbE1jY2tEMyt2?=
 =?utf-8?B?VVVOeVBNZEwxWWV0R3RibUpLQXJQdk1zTkhDditFSGNJa0hobkMrNzQ2Zlg1?=
 =?utf-8?B?YkJBMVlzOXh1SGxTVXR0TXJXbDkxT3h0S21NNXlxT0hjYWFscTRUOHQzVlM2?=
 =?utf-8?Q?PSM1xWobvetayk740QeFCDFB4u/7ryljYIGxef3GiNMt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A9TWCi8eUrbYJKSZD/VLBeJpi1fceACzS2+11f/4Lgu/2X5CTlGwC6LbQeOnW3MbQIZCgbHO2dvwONNFaXxVJ3RWPCzuXoQZSS2QfkFKvUox3+xOV5+yUwPCi+xL8ejH1YVWLalSCBhl5D24PAC02uR7uPr2C+xtMf3Sg8b/5GzgcKAl87q5BbhDvcKH8EYSjO6e1d1zAAhlUX3FxqaUcB+bcNmeRpRNsnL07d7YPnMHSjAeIsgHY/bToAitxFQPPMucIT+Tc0Gw2OpoJj0sc3BNCgI7Xac3IRrnMv9bMW8vosc5UshX4ZpiCCrsnKwRtQSjsQC7Xo5oLj0x4NQ6BBZ4JucwSBW9R57wgQUCqZDgxXzCjcVx7hmHfaWWvjXXB7pgxrdLgxX6vkgyI6sziM8FVfghSQnHZFGP2NYmAeTz+PZI9LUfkWA01dyQjyt66PDPlssYBsGUWKiyQqT3zWbK9OQGS1byj/p+sf5oWo6wNnJEllxa/P6CpeNPY5uAo18N17mwYmF28c0V/Q1c0/+LRckJ30qJySb19Z6xzTjPjTz6cn3DNAU7Ob8VL1TobFNCmfdmYu/1CHV38G2RIufuUBdgQpplEIHtpM8UXxs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd19af2-0526-49e1-5572-08dde49fad3d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 12:54:34.3473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zm2ogm3b9vpRSMjf4/Z4zOn1XaOIlNkxFPIL0etU9qZBdoJPUQCmLAp/v86tX5KjOE70qVomfIP8kA2LjOkKGahhl+Vj6uLD/okY2sGW2VP2U9mKPHa1k6LxyBwOrjmdAnf7LXEbI4ZuSp88ZASyAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8278
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508260113
X-Authority-Analysis: v=2.4 cv=J6mq7BnS c=1 sm=1 tr=0 ts=68adae8d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=EUspDBNiAAAA:8 a=M4jUTuQAz8YieTAUPbwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12068
X-Proofpoint-GUID: Aszq4CjxejsJP6qrHvfExUy0flheY7Ul
X-Proofpoint-ORIG-GUID: Aszq4CjxejsJP6qrHvfExUy0flheY7Ul
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyNyBTYWx0ZWRfX1LhyePwyowhW
 K723S1yQ4tDNkFcUCDI9Dj6COljrfA1sv0udR/zU/ZSWGjIBkHHvMsnR8cFy68jYDz7flgwWPlt
 8/2Q+WhATnztBUJ2Y7PNQcTGA+oAMJC1etwD18dDNI98Mr6v9odvJ25Z/I/qdBWJFoGVV+/F9wf
 ty4K/FBfrKgI3BaMu8K3uH4WykBnU1y3ANux6TIghaxC00xBV8av+qdaQG7/gGBu+25YpAluGfE
 l+vVWjDfInmTloBKQSUhdGZAJSWebLQUV6vTBXtQhvhb5p+Vhmf/mygqjtHH6EusjeCfjPtp+Lb
 p2s64TInZVrZOpToNTBn1fkhdhgzkxK1A1a5ihoirRjML/OsIXqAoEktRuEodgqVrVfsblCoO3v
 T82H5f7v+uf2Kc5rX2vy3vgflYc1bg==

Hi Kees,

I think the tests are missing.

Best wishes,
Claudiu

On 8/26/25 9:17 AM, Kees Cook wrote:
> The __attribute__((__copy__)) functionality was crashing when copying
> sanitizer-related attributes because these attributes violated the standard
> GCC attribute infrastructure by storing INTEGER_CST values directly instead
> of wrapping them in TREE_LIST like all other attributes.
> 
> Wrap sanitizer attributes INTEGER_CST values in TREE_LIST structures
> to follow the same pattern as other attributes. This eliminates the
> copy_list() crashes when copying sanitizer attributes:
> 
> test.c:4:1: internal compiler error: tree check: expected tree that contains ‘common’ structure, have ‘integer_cst’ in copy_list, at tree.cc:1427
>     4 | __attribute__((__copy__(__tanh)));
>       | ^~~~~~~~~~~~~
> 0x859d06 tree_contains_struct_check_failed(tree_node const*, tree_node_structure_enum, char const*, int, char const*)
>         ../../gcc/gcc/tree.cc:9126
> 0x860f78 contains_struct_check(tree_node*, tree_node_structure_enum, char const*, int, char const*)
>         ../../gcc/gcc/tree.h:3748
> 0x860f78 copy_list(tree_node*)
>         ../../gcc/gcc/tree.cc:1427
> 0xa755a5 handle_copy_attribute
>         ../../gcc/gcc/c-family/c-attribs.cc:3077
> 
> gcc/c-family/ChangeLog:
> 
> 	PR c/113264
> 	* c-attribs.cc (add_no_sanitize_value): Store INTEGER_CST values
> 	wrapped in TREE_LIST following standard attribute conventions.
> 	(handle_no_sanitize_attribute): Handle both original string
> 	arguments and copied INTEGER_CST values from TREE_LIST format.
> 
> gcc/ChangeLog:
> 
> 	PR c/113264
> 	* asan.h (sanitize_flags_p): Extract sanitizer flags from
> 	TREE_LIST wrapper instead of directly from INTEGER_CST.
> 
> gcc/d/ChangeLog:
> 
> 	PR c/113264
> 	* d-attribs.cc (d_handle_no_sanitize_attribute): Store INTEGER_CST
> 	values wrapped in TREE_LIST following standard conventions.
> 
> gcc/testsuite/ChangeLog:
> 
> 	PR c/113264
> 	* gcc.dg/pr113264.c: New test.
> 	* gcc.dg/pr113264-asan-no-instrumentation.c: New test validating
> 	that copied sanitizer attributes prevent ASAN instrumentation.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  v2: Rebased on to latest upstream, which has sanitize_code_type now.
> Cc: Indu Bhagat <indu.bhagat@oracle.com>
> Cc: Claudiu Zissulescu <claudiu.zissulescu-ianculescu@oracle.com>
> Cc: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
> ---
>  gcc/asan.h                |  8 ++++++-
>  gcc/c-family/c-attribs.cc | 49 +++++++++++++++++++++++++++------------
>  gcc/d/d-attribs.cc        | 17 ++++++++++----
>  3 files changed, 54 insertions(+), 20 deletions(-)
> 
> diff --git a/gcc/asan.h b/gcc/asan.h
> index a24562f67a29..f5dc3d7ceb8d 100644
> --- a/gcc/asan.h
> +++ b/gcc/asan.h
> @@ -253,7 +253,13 @@ sanitize_flags_p (sanitize_code_type flag,
>      {
>        tree value = lookup_attribute ("no_sanitize", DECL_ATTRIBUTES (fn));
>        if (value)
> -	result_flags &= ~tree_to_uhwi (TREE_VALUE (value));
> +	{
> +	  /* Extract the INTEGER_CST from the TREE_LIST wrapper.  */
> +	  tree attr_args = TREE_VALUE (value);
> +	  gcc_assert (attr_args && TREE_CODE (attr_args) == TREE_LIST);
> +	  sanitize_code_type no_sanitize_flags = tree_to_sanitize_code_type (TREE_VALUE (attr_args));
> +	  result_flags &= ~no_sanitize_flags;
> +	}
>      }
>  
>    return result_flags;
> diff --git a/gcc/c-family/c-attribs.cc b/gcc/c-family/c-attribs.cc
> index 1e3a94ed9493..e629601579ef 100644
> --- a/gcc/c-family/c-attribs.cc
> +++ b/gcc/c-family/c-attribs.cc
> @@ -1425,20 +1425,27 @@ add_no_sanitize_value (tree node, sanitize_code_type flags)
>    tree attr = lookup_attribute ("no_sanitize", DECL_ATTRIBUTES (node));
>    if (attr)
>      {
> -      sanitize_code_type old_value =
> -	tree_to_sanitize_code_type (TREE_VALUE (attr));
> +      /* Extract the INTEGER_CST from the TREE_LIST wrapper.  */
> +      tree attr_args = TREE_VALUE (attr);
> +      gcc_assert (attr_args && TREE_CODE (attr_args) == TREE_LIST);
> +      sanitize_code_type old_value = tree_to_sanitize_code_type (TREE_VALUE (attr_args));
> +
>        flags |= old_value;
>  
>        if (flags == old_value)
>  	return;
>  
> -      TREE_VALUE (attr) = build_int_cst (uint64_type_node, flags);
> +      tree new_value = build_tree_list (NULL_TREE,
> +					build_int_cst (uint64_type_node, flags));
> +      TREE_VALUE (attr) = new_value;
>      }
>    else
> -    DECL_ATTRIBUTES (node)
> -      = tree_cons (get_identifier ("no_sanitize"),
> -		   build_int_cst (uint64_type_node, flags),
> -		   DECL_ATTRIBUTES (node));
> +    {
> +      tree attr_value = build_tree_list (NULL_TREE,
> +					 build_int_cst (uint64_type_node, flags));
> +      DECL_ATTRIBUTES (node) = tree_cons (get_identifier ("no_sanitize"), attr_value,
> +					  DECL_ATTRIBUTES (node));
> +    }
>  }
>  
>  /* Handle a "no_sanitize" attribute; arguments as in
> @@ -1456,17 +1463,29 @@ handle_no_sanitize_attribute (tree *node, tree name, tree args, int,
>        return NULL_TREE;
>      }
>  
> -  for (; args; args = TREE_CHAIN (args))
> +  /* Handle both original string arguments and copied attributes that
> +     have already been processed into INTEGER_CST wrapped in TREE_LIST.  */
> +  if (args && TREE_CODE (args) == TREE_LIST
> +      && TREE_VALUE (args) && TREE_CODE (TREE_VALUE (args)) == INTEGER_CST)
>      {
> -      tree id = TREE_VALUE (args);
> -      if (TREE_CODE (id) != STRING_CST)
> +      /* This is a copied attribute with the flags already processed.  */
> +      flags = tree_to_sanitize_code_type (TREE_VALUE (args));
> +    }
> +  else
> +    {
> +      /* Process original string arguments.  */
> +      for (; args; args = TREE_CHAIN (args))
>  	{
> -	  error ("%qE argument not a string", name);
> -	  return NULL_TREE;
> -	}
> +	  tree id = TREE_VALUE (args);
> +	  if (TREE_CODE (id) != STRING_CST)
> +	    {
> +	      error ("%qE argument not a string", name);
> +	      return NULL_TREE;
> +	    }
>  
> -      char *string = ASTRDUP (TREE_STRING_POINTER (id));
> -      flags |= parse_no_sanitize_attribute (string);
> +	  char *string = ASTRDUP (TREE_STRING_POINTER (id));
> +	  flags |= parse_no_sanitize_attribute (string);
> +	}
>      }
>  
>    add_no_sanitize_value (*node, flags);
> diff --git a/gcc/d/d-attribs.cc b/gcc/d/d-attribs.cc
> index 53aea5e2e904..342702b05acb 100644
> --- a/gcc/d/d-attribs.cc
> +++ b/gcc/d/d-attribs.cc
> @@ -1424,17 +1424,26 @@ d_handle_no_sanitize_attribute (tree *node, tree name, tree args, int,
>       merge existing flags if no_sanitize was previously handled.  */
>    if (tree attr = lookup_attribute ("no_sanitize", DECL_ATTRIBUTES (*node)))
>      {
> -      sanitize_code_type old_value =
> -	tree_to_sanitize_code_type (TREE_VALUE (attr));
> +      /* Extract the INTEGER_CST from the TREE_LIST wrapper.  */
> +      tree attr_args = TREE_VALUE (attr);
> +      gcc_assert (attr_args && TREE_CODE (attr_args) == TREE_LIST);
> +      sanitize_code_type old_value = tree_to_sanitize_code_type (TREE_VALUE (attr_args));
> +
>        flags |= old_value;
>  
>        if (flags != old_value)
> -	TREE_VALUE (attr) = build_int_cst (d_ulong_type, flags);
> +	{
> +	  tree new_value = build_tree_list (NULL_TREE,
> +					     build_int_cst (d_ulong_type, flags));
> +	  TREE_VALUE (attr) = new_value;
> +	}
>      }
>    else
>      {
> +      tree attr_value = build_tree_list (NULL_TREE,
> +					  build_int_cst (d_ulong_type, flags));
>        DECL_ATTRIBUTES (*node) = tree_cons (get_identifier ("no_sanitize"),
> -					   build_int_cst (d_ulong_type, flags),
> +					   attr_value,
>  					   DECL_ATTRIBUTES (*node));
>      }
>  

