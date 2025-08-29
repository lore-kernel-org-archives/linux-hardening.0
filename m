Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2097.outbound.protection.outlook.com [40.107.220.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEB52737F3;
	Fri, 29 Aug 2025 22:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756506721; cv=fail; b=alAmSWRhP0SE5KXZPaoVjDxZbqgFTYhKghJJ6vT4r0C40K5gt+pUSq4ZD4VGffymVxcKj4thlb9yU4NiLk0fT0g1uiQabm1IwS/IU9v2G72O/UvXiQJ/VmVTIW3FfaJrjBAjHhPBEMvxlGiLh/FcFxeied+LGRs5c+dJ22ibIpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756506721; c=relaxed/simple;
	bh=fc+QuiogFlgokF1HR/L5kJ/ZpyWfRip9yZx1NIMxHBg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BRx7WRHLC5a2+NJ8fMb2vFrwxezHA3sZVkipL2cJrpgaffw+TaaEmVdVXGhmf0N/haOvmf8H7s/YgmnyjyKnTzGdV+84hQ5HafB551fQlxzYpuM0GBP76tYa+yfxHc6lhXZExAsDZeMoIEtmlBuywXsTYNYFvAqv+9cDbEGmWto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=KAcmByWr; arc=fail smtp.client-ip=40.107.220.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="KAcmByWr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rv4mNmEqrpDEgOnVPT58+xahjp5DxOfqi9ppOCJqYiSu91GuGN6kCD7ZnYR8KdAUiH0K3slgY5Dz2bVDii/pvjeFLSJ0teb7xFoo8RroE4uUO+pD3zyUFjBPtx6WmNAdFYZ+aD28VHZrTY8IVgeSkBf/im7tBoIh2XDYcmRCcf1gV8UiZZwYpSdOBUii4lkjHMEUAuuq+TCDbnrqlnUfZZKdR5VD6FxpVWYQZ+xcnyC+w8Ox5QG+VXMwEmwQFsZA4q737oA0x+4KhXBnKWACPJGosDc4exujaO9ObMy3Af98sM1JOK+NqOBOg4aF+gcmSmTH1G1Ue5SOZBI42lYCxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fc+QuiogFlgokF1HR/L5kJ/ZpyWfRip9yZx1NIMxHBg=;
 b=qDLe+FlwHgJdupuArwNB4gFoGTxfO7WqV2DcK00jDhvjcw2cLq+RP9JEABVOQl/CpqlpCP46oKey8ccyNGAXz2Tw14YH160uUo/H0+/pJ5+Szq7dzeiJ3JaH0srR6xGsjn59j8GowmQ9lz75UAG/29H6ly7VLe2Bls5wRx4ioqHwLAwSER65LNmZKisCyV560Gyb9GwjaYX6ZtrMS96X2Ax7PlX/x80MwEv1rabUZTUdGT+1GLkDfe016cSfhhkNoS/N83b3cW7ujRjBYZAteJe96pdoKfJmNkUidEBFPXAUjzqkg/TfYygMoxFUnDlXKZUp6c7uUOZGYoKQxr/3Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fc+QuiogFlgokF1HR/L5kJ/ZpyWfRip9yZx1NIMxHBg=;
 b=KAcmByWrmS5mjPpAn5jUTtCAsRNU+AWeb9csh9JQpkO3qYRbtBN4Cccgyyj42iXCatL4R6tndfz4w/q+ydldJI3ocjd2JV7mGXWq+iJemPg28ySEvy04WWg0eHyJIQKsRGjIJB/XILUir118kkzp/ktfzEoC42Uyx9e2UzbsyPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH7PR01MB7630.prod.exchangelabs.com (2603:10b6:510:1d2::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Fri, 29 Aug 2025 22:31:51 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.9073.021; Fri, 29 Aug 2025
 22:31:51 +0000
Message-ID: <d10e3bc5-5574-4498-9849-732fb373fa83@os.amperecomputing.com>
Date: Fri, 29 Aug 2025 15:31:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 00/18] pkeys-based page table hardening
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
 Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@chromium.org>,
 Joey Gouly <joey.gouly@arm.com>, Kees Cook <kees@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Marc Zyngier <maz@kernel.org>,
 Mark Brown <broonie@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Maxwell Bland <mbland@motorola.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 Quentin Perret <qperret@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org
References: <20250815085512.2182322-1-kevin.brodsky@arm.com>
 <98c9689f-157b-4fbb-b1b4-15e5a68e2d32@os.amperecomputing.com>
 <8e4e5648-9b70-4257-92c5-14c60928e240@arm.com>
 <939ac25a-096f-46b3-90c1-d8cd6a9e445e@os.amperecomputing.com>
 <b9212134-0efa-422d-8cbf-4761e39ce8d6@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <b9212134-0efa-422d-8cbf-4761e39ce8d6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY1P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::15) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH7PR01MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: 789f53c8-6278-4937-efa9-08dde74bd962
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qk84cGNFampZdmEwSjlzNkNWQ0RSc0RCV2lCV0pGTTVLM2FlYjhxZy82WU9z?=
 =?utf-8?B?bU00V3lkTHFDZ0E3azVaVnU1eTE0YVhXNWVISDcvKzZ6VEs2SDY2b0FvN0tH?=
 =?utf-8?B?YzdUckVKWnNDOVJGaWVtM2tMSGFIMkVwYUNjaFJNYjZvaDRyTVpzRU41RGR4?=
 =?utf-8?B?Y01pWmlWejdPMXdjeFkzSUFZTGpsbStBdHFkYlBpWmFnU3M3Z0RjdEJERWFy?=
 =?utf-8?B?OTlZa3BKdEt5S0hQdko0a0hJNjZ0S05UL0ZEYTBSblMwZUFkQ1hVUEk1TXI2?=
 =?utf-8?B?eDRwZ0d0czZnRGI3OSt0b01vbjlBTElkTERkcWJJUkZacXVZWTJ0cUtzOC9k?=
 =?utf-8?B?QXNZS0pqTURGUEpqd002bmk5TGlnQzRUZXJ5OUpjZXlmelFFSDZJakx0Tmxh?=
 =?utf-8?B?NnlPelo0aEFtbURIQ1oxM0RGejc0YzFmRUQ4anUzSGg0Nk5UUEg5QVFmSno5?=
 =?utf-8?B?V1Yyb3JkRXRRdXM4K214RGQ0NURlSTFvYjFTUmNQeU1hYlF2RGp4WHpkVHRU?=
 =?utf-8?B?VHFCVjVoNzBsdFdCYXIzeExML3lvdm4vYi9VQ2gxM3lqRmhoRUJKd1dvYlkv?=
 =?utf-8?B?Qi9zb2szb0hKTnIvQXVyTHhqejhycmdVRWpYcTM4QmFjZUYwYnJxcXowa1FF?=
 =?utf-8?B?cXJJNUtkSC9JcHo5SStjV21RcmdrMDZ0Tk5UTGNTTTRDSTBzVFRya1Q2bE5V?=
 =?utf-8?B?RFdUYzhOU2t3Yi9uWVVBNnorQ1YzWUZLanRRb2NrWk1vclIrNUQwSU5pQ3lO?=
 =?utf-8?B?TFlNbE5WUnNwN0RwTGcrcG9sYnVKdUlzYkN5K3RZQlN0RnB0SVhHamR3dnRQ?=
 =?utf-8?B?M1VUMU5LLzlhUE0ya2FCOTIrQkN5Y3k5MytUaUs4MHc4QVRxREtmc1BQdXRS?=
 =?utf-8?B?SGFLVWRrNEUzZitaM2RJbW84cnRVQmpNb1luUmx4aHhJRW9YRVplNWRaeXZS?=
 =?utf-8?B?QzFSTzE0Vmp4eHVKc1FCODgxTC8rc1FxU0duWWFTdWJNcHhuSmhKZkp0NVY2?=
 =?utf-8?B?MktSWGs5YmtLODRMdW5kUHVOVGQyM2lOb2NuL2ZUL21JVEp1Ri9Pcnl3VHd3?=
 =?utf-8?B?VVlqYXJwd3dXUzRVai9ydUEzTWwwK1VlT1NEdXhQTVVjVEs4V1hyMERBc2lz?=
 =?utf-8?B?VmlTZit6K0R2ZnMxOHczNnNNOVdKd0Q0aUhodzlETDl4M0MzSHlCNDNDNTY1?=
 =?utf-8?B?MFhwcURVRHNCRXA4LzdYbEdsT0xWejlGMUVzYzNlM0ttTUFsNEtLVmlSVnE2?=
 =?utf-8?B?eGVIcFRiS2lqd0FIMTFIcmFEYldKdFpwdFU2UzAvR1FKK3FSaFpXbnJ1ODlj?=
 =?utf-8?B?RkZQbDNVTVczcVpucGNrS0x2MkYxSFRLREhOQUF2R0JqNldqODJMYU1YVjQr?=
 =?utf-8?B?VVJ0NFQxdzhKRXl1L1hUdkpOMUJ4ZnVOMmNkYkUvcFlUYTdsN1lSODFyVlVL?=
 =?utf-8?B?MHJuejBFbzQ4K0JldDAxZi9qQWVvVnZmRWpQc3Z4QkNSTWVrczJuMHhpL2RR?=
 =?utf-8?B?YkF0dlJwWlFUUnhZN0tUdzZlQnNKeEFRMEc3VW9wa280YVNrZ0hPU1N3WUx6?=
 =?utf-8?B?WE1tRTh6S2txdWlLbTBrYVpxVXZUWlFneC9Cc3h5NEZ1cGlwRFg3bEJPR0Fv?=
 =?utf-8?B?M3pNVlF6dHpESTZJdS9YcHRKQTQ3Z25iNURkWXFPSm9XU3I1TTF2L29UMUNY?=
 =?utf-8?B?TWhpblVjaVM0MHdwVWtmUHBRWGFwYS91VFlRRkg0b05HUUlmUGlVU3QxSEI3?=
 =?utf-8?B?NGIyMFpFRWp5elQwNkg3UTI2VUhmendiU0czNW91REthYlpmbmtYaDBMREZj?=
 =?utf-8?B?cS9IY3ltOEpOa1c3K2ZoNXRGS1ZIa3pQaTVwckMzbnNXTk5FeXV1OVNuTEdw?=
 =?utf-8?B?QXVLSlFxNzZ4RGgxR053b0I1dXBKeFl5Ylp0RXJsbmF6QkNaQ29lN2orOU0z?=
 =?utf-8?Q?cWoqH2gSfuo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGk0Zlhia2VDblRKOEYzanBZQkJUTGg5ZHk1L0FZRlZTYU1PYUVtUkd3cE5N?=
 =?utf-8?B?eHRQbWNJQWpsV3NPNEdjVmpaaEhHNm43MEVwRG1iakFTc1BmakwvelRrZjJQ?=
 =?utf-8?B?VW9WS2NacXpPcDJ4L2l3UXpSSE5IZHlvSTBxdWhtb25raUk3cjA3ZnovR2JU?=
 =?utf-8?B?ZTgrdWtsNkxITm5qTExsMzBUUmljQTFtMmJ5NFU1aVBJSE1zWTlrUytzc3ZF?=
 =?utf-8?B?ejRkUXJuUDJBQXZZSUFSUHVlSkNkbEUrZUtTTFgreHZYcWxybEFYRmNkc2Jx?=
 =?utf-8?B?ZVJpRnBSM2UzeTdWUXJqbnRLanhLUmVpWnRCYlJYN2lsMzJnV2J3Uk40UG5P?=
 =?utf-8?B?a3BwM3E1dzRXS2RDMzByenVUeWVteGY4Z2NpMWFSY09EcCtkMjBFeW9Nb0hZ?=
 =?utf-8?B?aUxBYi9WZDhtTmQwT043VG1ZNnJiVFlpdkFPYzNpYkJTS251bi8zWFlESTBQ?=
 =?utf-8?B?a3owTkY4RHpwclJPeGhrWVo0TUlXSW0vS3pnS3UzeXZpMEFYV3Y3RHkrU1Zk?=
 =?utf-8?B?RGZKdzBHeXhqWS9WMi9LVjc3NEpkYWFhVE9aZXEyUmQ2V3lZK1cwYTd5MUVC?=
 =?utf-8?B?Y0ZnR3NvZFB4RTdKcUwvTG9jZFluRFcwM2liM0xJWXFHRld6NkpjZERqSks1?=
 =?utf-8?B?dU9OenVaajUzZWNuOGVMU0dnWktxc2p2YWViQUljVjFPV3lzTU1BTWtVVTJj?=
 =?utf-8?B?T3duUVkwQkp3ZVlFVm5MNGRLZ0RVV2h1Y1FPa3gzejNqT3RlaW1sYVlWZG9Z?=
 =?utf-8?B?UEpxZCtDOVFncVZYRHQ4czRubkhHdU1CMEh4dHpHVWdRWDQ0Ri9yRjBSNFdz?=
 =?utf-8?B?RWdXY3gxMmk1S2hESEJhVkhPdmgxYU9rQmhVakdoSm1EdVdaT29mZVZUVm1M?=
 =?utf-8?B?QWVnWW11cm9FV3VYNDJlbG5kazB5TEg2VndsUC95M0NoS01TMTIvUGw1ZzlY?=
 =?utf-8?B?cDFRUGRQNldLZlJ2YWdCUTVMdjRmSmNIdDNybjN2Ky9NSUlRckxDQUFqcTN1?=
 =?utf-8?B?Y29JTE54TVVyWVpvUUU0MWd0aFJITVV6RStPRWJacjkwRzlDZGxlOGZYRHhJ?=
 =?utf-8?B?VlNmSlFWemRiOEYwRUlLS3lEOGZqK0FITzNNSU9uTjhTYW93QjJtT29MYTdN?=
 =?utf-8?B?cEN5aDlJQUtxRjB4OEJ3RnRjdWtEOXdSbGVyOXBOUzhQZlZBSVM0QUhBejda?=
 =?utf-8?B?TU0xS2xZTDJxR1FnemRscmdhaDBQMi9zajYySWt4dytaTER5aWQxU1BuMkdn?=
 =?utf-8?B?c1grdWMyTnE0Tm4yNEpjWW9VZDQ2SWEvWXFHWlZBUXZRZmpsaEVlTGRIY3Zq?=
 =?utf-8?B?V3Z2RU9Lb0NDNTM1bW9MNVJoalJpTHhNWVNldlBqalR6bzRkZmg1OUNEbmth?=
 =?utf-8?B?aEpSbWRYNXh2TWtwNnBZMmF1SVRxbkxOTDd4YnpHcjU3dndZckc5cnVKZm1P?=
 =?utf-8?B?R3JiazVORFVYcVRQTTRhWEtBOS95bTUvODhNQXpVWnVKU2t5SDVOVC9ZU3lI?=
 =?utf-8?B?NndiN1BCd04vVEcrWjF2aTl0WXl5Q0YyM1FiZndqZTJaS0ZOS1F3eTc1b05l?=
 =?utf-8?B?OUNDZkF0OEw1UTJPbXpBUEU1M1VLZzBRUDRTYXhMUVRCM3RoRDZEaVAvSzhy?=
 =?utf-8?B?WVlLWWlKVzFXZEFLbWFmNUVGK0tyVDB5N2pNVzM4N21vU0pNaHVkeDd6ckM2?=
 =?utf-8?B?RFZOcTNPeWM1S3loVTI2dmNTdm0xaFIrTXUxUHZZejlMMFdXdVhQcit4SlRK?=
 =?utf-8?B?UmVZVFZULzFUejVYcVJ6ZVdEbDlUaFJIRDNLQm9DYnQydzhvVXhVdzhSbng5?=
 =?utf-8?B?a2V2bU5laS9EaXMzMk1zTHVpWGVOeWlCdDZuRUMzVFJ5d25pbXRUbnMvdDdW?=
 =?utf-8?B?eklRWTRBOFFRMEVXTmZWUkk4VWs2SG45ZDVFWGlWZ2JUOHNyNitqTWNKS3lF?=
 =?utf-8?B?eTBHSHpLYnhTN1pyTDJ2bUYxbFFaL2NtYjdLaWwvODdQY3I1RjA0NDVVTDk1?=
 =?utf-8?B?UEc2NDNkd2RuT0FkS1FrV2VqdWYrcDFmU0RWOUpoV013NW5OUWVCaSsvVEs4?=
 =?utf-8?B?VGlXcmxOS2FibERlaFFmU0kzMWFtOW52UXdZSGZoT0J1WnJnMmxjNUM0QnFl?=
 =?utf-8?B?dXVSYnhWWUU2Vk43SzhsK1FqZjZpdDNUN09JcWdNclZ6eFJ3d29MOWlsZVNR?=
 =?utf-8?Q?qo+rj9X9Y1KLrpkujRgiTBk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 789f53c8-6278-4937-efa9-08dde74bd962
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 22:31:51.3996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7aBxSZu8RmNUVoxp+cDu/0Y6xdlj5v/5FPSPaLwBxvmEECADy29CQB0esad2zoKrkaGohVnwN+yV9zWpJl/0CcLhIQYto7TnQL1jqMWc+rM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7630



On 8/27/25 9:09 AM, Kevin Brodsky wrote:
> On 26/08/2025 21:18, Yang Shi wrote:
>>>>> from a contiguous cache of pages could help minimise the overhead, as
>>>>> proposed for x86 in [1].
>>>> I'm a little bit confused about how this can work. The contiguous
>>>> cache of pages should be some large page, for example, 2M. But the
>>>> page table pages allocated from the cache may have different
>>>> permissions if I understand correctly. The default permission is RO,
>>>> but some of them may become R/W at sometime, for example, when calling
>>>> set_pte_at(). You still need to split the linear mapping, right?
>>> When such a helper is called, *all* PTPs become writeable - there is no
>>> per-PTP permission switching.
>> OK, so all PTPs in the same contiguous cache will become writeable
>> even though the helper (i.e. set_pte_at()) is just called on one of
>> the PTPs.  But doesn't it compromise the page table hardening somehow?
>> The PTPs from the same cache may belong to different processes.
> First just a note that this is true regardless of how the PTPs are
> allocated (i.e. this is already the case in this version of the series).
>
> Either way, yes you are right, this approach does not introduce any
> isolation *between* page tables - pgtable helpers are able to write to
> all page tables. In principle it should be possible to use a different
> pkey for kernel and user page tables, but that would make the kpkeys
> level switching in helpers quite a bit more complicated. Isolating
> further is impractical as we have so few pkeys (just 8 on arm64).
>
> That said, what kpkeys really tries to protect against is the direct
> corruption of critical data by arbitrary (unprivileged) code. If the
> attacker is able to manipulate calls to set_pte() and the likes, kpkeys
> cannot provide much protection - even if we restricted the writes to a
> specific set of page tables, the attacker would still be able to insert
> a translation to any arbitrary physical page.

I see. Thanks for elaborating this.

Yang

>
> - Kevin

