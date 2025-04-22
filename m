Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBD9146A60;
	Tue, 22 Apr 2025 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745333631; cv=fail; b=FJvrVnMynVnpWth4megBDplpeioB9Xo3KyPiH0VDNJqhl+MBBwbqr4txgExSHZJGJz4isDVrT+xLlUKHIcXA0S9rPRQDY+R041ggW/AX1qhSU8n8AK7ZqrckmGG0Qj6yAmiFtQ0yfB1HNwTqFlFZMFY64dp6lKBV2SKqBEZc4kI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745333631; c=relaxed/simple;
	bh=ALFIJSgABEoWhIZErToM2Lsi8w3f5cdqeVWtjfmKZoc=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=JJtYOdI3tCrBpmc2hxxRtNXAzfc/shrT+8yWGrg5QfNVVcnlZjVdktSzB4M/KYbVxU9w89mdETeO/DjABKVj6uXuA1Yjrbke6dsCZpsqCksNt+ZvF/ujT0VEEqaw+Z8Ylb4+p6/QfDP5E89SDkSBAOn5JqiGXEJ9UMHM7gJP4fE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZIobQ8pY; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZIobQ8pY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhkQs2R3lzVPAvtm///FO12sRHhl0WZseIUJrPoCiTKQz4LnwM/0PprmlaChyqWCp/GCU4WRhMagzbgKZf40bMs6u14f9G7ArnC1VsKh7wbSFkySRSPYeocVRJRqfl6DCDD4YaJMMIgG9YSiakrGBBNQI0H6RNKopl8x6mQ/K84Yk1hdFbyd+AeS9QpGShheCxwSsY3SXWTsD6h9Y/ffKtdFw1kNJFOAWcrQ1/8glB4kMF50muGarOIDT9szWais9hitr7viubgxObNhMByhOe+XGW9rx9NeXOveezjCynJijkwz3P6IBaoDNxl0eTnGv2qVUNB4hTThu241xGISBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNTeGLZu0ue9DYA7cbpLGB/KOoqOF2UkmvCgFb3f8iU=;
 b=AgToRwLGdsWpVbNLG7TFIHmnG5eA2PdbTGNAJzGqzOevCuEEbceGmpCY2bRPjimziMUblhVx9eZrzmJEkVQzqnVKBp0AmYNe4876G9HQNKIuDUrn1qM0Ej4HfUDg7czRyRNesWSZD5Kw1BWs/Wr4G1S2X5/BrUtS1DXlXlvuzDEjUqI0Lt2G3G2p1Hk4jQZT3oqKoJn5v3skvv4v/2tZRFQVTTEb5iNHcIgDXLLIFnJbdjI0aYF/DjgYhN4B0x71hKbbGrm9T4aX0mG54OPVqqecZ8BEp/Jf4M9oC53fdm1sdSVG9tBrOCBhPY/PmJkk5I3KJeMjIRGWNoJ3gyoAUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNTeGLZu0ue9DYA7cbpLGB/KOoqOF2UkmvCgFb3f8iU=;
 b=ZIobQ8pYNcJ+GdJu/Z5QUezyg0OOgAxLJpN5LfgbbKa3yfNPo7bR3kCgxN1nRYAn2shCVNXLN/gr505DJm+FAXWVBotcwQj0Ywb25/aHvATDx2lB/B6Dyg7pOapIGRnLs6D9k5vBm85ARE+cYrLWmroyBKlgej21vfJ5+WdPBQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CY5PR12MB9056.namprd12.prod.outlook.com (2603:10b6:930:34::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 14:53:47 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8678.021; Tue, 22 Apr 2025
 14:53:47 +0000
Message-ID: <787ce95c-2d7c-b005-6b6b-c379f0a9f603@amd.com>
Date: Tue, 22 Apr 2025 09:53:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, bp@alien8.de,
 hpa@zytor.com
Cc: kees@kernel.org, michael.roth@amd.com, nikunj@amd.com, seanjc@google.com,
 ardb@kernel.org, gustavoars@kernel.org, sgarzare@redhat.com,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev
References: <20250421204453.318557-1-Ashish.Kalra@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] x86/sev: Fix SNP guest kdump hang/softlockup/panic
In-Reply-To: <20250421204453.318557-1-Ashish.Kalra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0053.namprd13.prod.outlook.com
 (2603:10b6:806:22::28) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CY5PR12MB9056:EE_
X-MS-Office365-Filtering-Correlation-Id: 16b75caa-754c-4ff9-6585-08dd81ad7c4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REJaZzBpTXdTNUdMNE84RFNXcFJrSHZEM1c0ckZqYS90QWY5dnRUTzM4d2Ns?=
 =?utf-8?B?QzRLZk41L2xBdDZEV1lSaElxWGhMbWxGZzZtcCszS1BhdHNXNlV6amJhQm05?=
 =?utf-8?B?YjZtQlFtL2U1WC9xRWNQTW43WWR4Tk9RU3hZeGN6Z096SmoxejZFcy9QWEhQ?=
 =?utf-8?B?ZEJqTXFjcThvQWJBMTMxZFpUZXFsOFhXWnZoa0NnSmVlbVoyby8ydUNnYkhO?=
 =?utf-8?B?QUhKOGhicWRpOUptdUdQaE5pZGxvZ0ZLbE9TTzZoTkJyclFieDl5K2RlTE1O?=
 =?utf-8?B?anYxWXVoTXp2emZLSFl5aVU2QktjMGlRWGV4UTBDSnJkNFhYcGVpUS9YRUx4?=
 =?utf-8?B?QkJSbWozdVVVY0hQcXVDdXlwelppMmZ3TmZlSTdtTWlvY3VPeXdyYmhkeFFm?=
 =?utf-8?B?Y0xkL2ZnY3R1RXNZZklDS2NWMG4yVEcvS2EyRUpqbVNJd1dlVkRPWW9VZ3pO?=
 =?utf-8?B?L1FCZTcxWHh1RFhqWnpocU1jaEYxZm1ReTdxekdNeldNVURmZ29LK1haU2Qw?=
 =?utf-8?B?RXdpNzcxdDhjSlBRL290UmlWMzRGVU8wVUMyU3V4d0dzaitUZHROanRqQkd0?=
 =?utf-8?B?Q2liQ2gxL1FXM0RzbUgrNnBMYzNWMjZNOUlteWJKV1BlWDJYVDgzZWREbEhM?=
 =?utf-8?B?ZzE5WU1rMmlDNGhJSS8vVm1PV1Y4WkM3ZGVkOWFiTi9wRER1ZFdTZVFNTXVJ?=
 =?utf-8?B?Y2U4YkJYNks2MzBQYXVQcFc1b1BWaGozalM5K1FHU3Z3eVZEWHhUMHZpL2d5?=
 =?utf-8?B?MmZuNlIyakVzdWZBdmlQTHZhQ0hwTnltUC9vYWIrRjN1VmNucHZ4d0F1alNv?=
 =?utf-8?B?NTZFN2ZKZzZzQ0RveGg3LzJQKzc1YmxoVEJKbjAxVTJ3WTVNazN5RmxTVThr?=
 =?utf-8?B?T1hEdTNsQ1VzbXdyUHR1cGpPdTdNVDBEWmFkYWFhUHNBR3BnaWo5YUxWbHk3?=
 =?utf-8?B?R2pwQXh6Zk9wTGdkazNUNkdKR0NZT1p5TVkxS1NndEcxZUlXVytqK29DYVZ5?=
 =?utf-8?B?dHZwenBReG50Q0pYQXp0QkkydEx6WnNmNVM3SEJRTzZzSWVwWUMzK2h0K2xl?=
 =?utf-8?B?L2RYOTgrSDZNRHpiS0IzSjllVVlic05HRGJ0cm1RMW02U0Y2WGN3SVdGWnFN?=
 =?utf-8?B?UmlRc2FyenpNUFpOMGpaSE44U1I4NWRseVc1cGEzZWQyczdsbFFEVlhERUZr?=
 =?utf-8?B?d25ydE83clZNV2FEK3hyZHJTbldkL3h4cm1rRlJlQ1ZZbGtCd0s2M2MvUWNU?=
 =?utf-8?B?eTF5b0dSR0UrcjM5bllXeUZHT1hDTzZ5WCtwVW90b3BpQklmWmE1c3MySXBB?=
 =?utf-8?B?NkJtQnkzS2tIY3NoclhoRmw2VWVVbVdDVzhUb3RuQVNwQ3Z1S2N4TmV1NVlO?=
 =?utf-8?B?aGlUNHZhRkU3TCtwc0hQRzVFMnRZMmlZY0UvU2VpVXdxQ3FwNXhyZGJiUVVR?=
 =?utf-8?B?NjgvQ2tTREozakZQQkxISkdjOVRmZkdFQnZUUVdJalhkODNxajgvazRDKzBW?=
 =?utf-8?B?MEdNdkYzUHFxMkYvVGpldmRRZXErT1A0TVV2WWdUVG5Mc0F2ZXIwbzdTa3l0?=
 =?utf-8?B?aWZtbkxxcjZ4S1R5UmVucUx6T0x2a3V0UFFtTU1iWkpiQlZ0OXFFTEhoMHdy?=
 =?utf-8?B?UitSRzF2TGpYbFdkRWYvQi8rWCt0M3B2QVdTeU9BOXAxOWRtOVR1d25kdnA3?=
 =?utf-8?B?ODFSZHZCZFl4M2JZUTljOVlvcENyaUtSdktlaUxRNDg4aVJtd1BTSnB2Wk9N?=
 =?utf-8?B?SjZ5VVVBV1FzaWxRU0hRVzc2bHhuZFhZRDZFYm9hSWtiUjJBVE9Hc0ZKV0JK?=
 =?utf-8?B?ZEhERzBMYTc5djFoaS9sV1ErR2R4T2xyb2w5NCtQZ2k4elNNUVA3cEhDOEFv?=
 =?utf-8?B?Z2JvUGZZZ3RDendXNTlZVHJ3ais2R0U0YnpoQUxSeW9BM201S01tVmZDbFRa?=
 =?utf-8?Q?YXhzO6imsNU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d29MTWtBREtQbkttMWh0Z2hGYWI2NkxSS1orbGp3bjEvUWg2NEowNDZtQVZl?=
 =?utf-8?B?UkhrZHZMT2RDNXozck5FcVorQXRvMVVFREt0b1h0Q0lidnJEK3hKc1pTNlFE?=
 =?utf-8?B?UER6Nm1kZWtqSXBDUkFXa1UrQml2cHVZeVh6bmlMZUI1akV5RThwWDNWU3lN?=
 =?utf-8?B?czBxeGJ3WnlNYkxPSjQwT0ZubVhsVE84TnN4VytDT2dCRUtXUWloQlBnQ2Va?=
 =?utf-8?B?MkwxLzZBTytObktwdzQraHkwNVZ5NFh3MHpaeW41eEoxTU41dWRjRWtrNW12?=
 =?utf-8?B?eDNzekFUWDVsSi8yaFdtd2VOK0haRXAyeG8zWlFtUDh1OXRZTjJDSFFzS3lp?=
 =?utf-8?B?VXNGdkI0aEVxLy9YTEhKSXdOYTBSK2Jsc1FOL0ZzaW1YSW1mSUg3TC9Vd0E5?=
 =?utf-8?B?V0VYRkFTMkczcE9DMnQySzdFVWpIODdHRjFIY2FpcDcyaWR0ZnZZMFAzQU5k?=
 =?utf-8?B?Q1QwMFd2Z1RhMlNKemQwRjNLY2xERVZTRmhFR0I0dEZFVW55TjNaYXJoYW9Q?=
 =?utf-8?B?UDRHVWVzSFlHOUtZZUFJcTV4MVlXUCtNNUVYNGFZTTJucWtkVG5sL2pMeXZU?=
 =?utf-8?B?c012TmpWSHp4UWZwd3A1K1RrbktSdU1xeXUzeE5kdTZzaUxGaWpub1VFaWVj?=
 =?utf-8?B?OFpVNE02ays1NStFQWd6Slg5NG5qQ3RXL1R5dGFWZmxpTytvVkRlYVRiN2Nk?=
 =?utf-8?B?UFVvd3M0WCt0QysvdjhGYzhnUXV5SS95UExXMGxwSnpkUUpDMGlQWWVCSFpT?=
 =?utf-8?B?ZjZMTHMyalRpZWxwc2hKR1BzaE1DaW1vbmljanlUMlpxVEZOR0FPeCtUeVUr?=
 =?utf-8?B?bnM1ZU9DS1EwaDhRUmQ0YlJBd1VFUTBYS0pOWFErRk5FSHVyZmEwNFQyc2Jr?=
 =?utf-8?B?TWVOc2pKVVhJeWRUL05aVTVXcEpXWXZoRzdldzk1ai80Z1FQYStxTk1admtW?=
 =?utf-8?B?aUljdEh4NTNzYTJValpTRHlwcDR3MTR3WUJ3VXlCTkFJU1ZBNTYxWG04NFFS?=
 =?utf-8?B?THI0T2l2MTdoUHppTUgzVi9nN2lPVTRDL2JGbVIzdjZSZmNoZHJSSXlydk82?=
 =?utf-8?B?MkJQeEtXOWZjM3UwSCt5TWJ5M2lsSUpGSTE4SVJQVWFaN0FkUTdBczlEcitZ?=
 =?utf-8?B?cDFKNTU2QWVOb2N4TWtlWkFVelJWd1lpZ00rYW41eloyc2Z3NHdNQ2dXTmpY?=
 =?utf-8?B?QVZaZEdzR2ZueTVPbWVLUjRQd2NKdlg2cXBiRk1NTk5lZFZmTmF4QWdEMmg5?=
 =?utf-8?B?R1NpVWhvT0dKdE1tUXVJY0l0bnRqaEJzODU2eEFmUDlRNDFzVGMzQjRySytW?=
 =?utf-8?B?UmpLejlUN0JUYjY5T1JiYmdXRU1hYy84aW1DWmFjcElob3pxLzlUOGhqK3RR?=
 =?utf-8?B?dDhWdUVMT3dNYzNwY3BVVmwwVCtvenRMUUpHTzk2SCtjeGtRSHhLWFVmZHE2?=
 =?utf-8?B?Qy9Sb2lWak5QdkUwL3J5SGI4dUVjVGdRWWNoTzRMQ1JKTHRHNWNVTlV1MXBi?=
 =?utf-8?B?c2xCZ1hROEFkWFE1eGJ5QU9OTEdVSkdMYXF5TkF2QnpUOC9YL2pUV0xKRjZI?=
 =?utf-8?B?RXZvWStSeXkybHRuNWJSUjgrWkd2bzJtQ1VibnhySHA2VExYUVo1VXdkOXlE?=
 =?utf-8?B?c1ZpUnBlNmNTMytJSHZYM2RrdVZkbktRU3FIa0l0Vy96bk52Ris3WnpJcEpa?=
 =?utf-8?B?M2VRcjJzNm1YdVRrM044UnFlWHRqOTRCV3d2Mk9zQzNXTVJKajBzZG5rejJo?=
 =?utf-8?B?dDZ0RzFYVUxOVVppWDUxMmJhN25IeHhpckI3NnVSeXNHbFJiejVUVU1QWStJ?=
 =?utf-8?B?blB4ZFRydzVneDBwaTFCRzg5dlFkN1ZqaHhHUENRRHNEbGdVcThEYUZuaDRk?=
 =?utf-8?B?RzZpRGdPQXNxYXQ5RDRuQUU5N20zMFZFa2lWVUM3M0VLYkVLbW5PdlYvL0pv?=
 =?utf-8?B?ekZMa0VSZEtIVkU1cUE2QnB2THRBck50eGxBRldqU2V6N2JNdGFyUnFCbkRW?=
 =?utf-8?B?M2VUbCtLMTk0T0pra3p0dVN5K2hXZ2pyYWsyZEVkTlJkV01ZMWJKV0l3MVJV?=
 =?utf-8?B?YzVKWlVJaERBNjlUcUFnTHZQb09jaVhhcWpkRUJybkRyTFhEQVFjTi8wUmRs?=
 =?utf-8?Q?kuqSUifEkkQ4XjgkAsN0bpxgh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b75caa-754c-4ff9-6585-08dd81ad7c4e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 14:53:47.3607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQOVyzGa80iW5SM4g4sHPFY4+fkgiZvotqXf9XiMqXK3p30KV1IDuukraFBvPb5LdQFlkWtA411QlMEN0NJJXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9056

On 4/21/25 15:44, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 

No need to add to what Boris already said on the commit message and
comments, so just looking at the code.

> +
> +		/*
> +		 * Issue AP destroy on all APs (to ensure they are kicked out
> +		 * of guest mode) to allow using RMPADJUST to remove the VMSA
> +		 * tag on VMSA pages especially for guests that allow HLT to
> +		 * not be intercepted.
> +		 */
> +
> +		local_irq_save(flags);
> +
> +		ghcb = __sev_get_ghcb(&state);
> +
> +		vc_ghcb_invalidate(ghcb);
> +		ghcb_set_rax(ghcb, vmsa->sev_features);
> +
> +		/* Issue VMGEXIT AP Destroy NAE event */
> +
> +		ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_CREATION);
> +		ghcb_set_sw_exit_info_1(ghcb,
> +					((u64)apic_id << 32)	|
> +					((u64)snp_vmpl << 16)	|
> +					SVM_VMGEXIT_AP_DESTROY);
> +		ghcb_set_sw_exit_info_2(ghcb, __pa(vmsa));
> +
> +		sev_es_wr_ghcb_msr(__pa(ghcb));
> +		VMGEXIT();
> +
> +		if (!ghcb_sw_exit_info_1_is_valid(ghcb) ||
> +		    lower_32_bits(ghcb->save.sw_exit_info_1)) {
> +			pr_err("SNP AP Destroy error\n");
> +			local_irq_restore(flags);
> +			return;
> +		}
> +
> +		__sev_put_ghcb(&state);
> +
> +		local_irq_restore(flags);

It looks like this whole block above is very similar to the block in
wakeup_cpu_via_vmgexit(). It makes sense to create a single function
that takes either SVM_VMGEXIT_AP_CREATE or SVM_VMGEXIT_AP_DESTROY as an
argument and processes appropriately.

> +
> +		snp_cleanup_vmsa(vmsa, apic_id);
> +	}
> +}
> +
>  void snp_kexec_finish(void)
>  {
>  	struct sev_es_runtime_data *data;
> @@ -987,6 +1088,8 @@ void snp_kexec_finish(void)
>  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
>  		return;
>  
> +	sev_snp_shutdown_all_aps();
> +
>  	unshare_all_memory();
>  
>  	/*
> @@ -1254,6 +1357,8 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
>  	/* Record the current VMSA page */
>  	per_cpu(sev_vmsa, cpu) = vmsa;
>  
> +	per_cpu(sev_vcpu_apic_id, cpu) = apic_id;

Is this really needed? Can't you use the cpuid_to_apicid array or create
a function in the topology.c file to return the APIC ID?

Thanks,
Tom

> +
>  	return ret;
>  }
>  
