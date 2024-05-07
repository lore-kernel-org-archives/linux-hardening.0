Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2513015E7F9;
	Tue,  7 May 2024 12:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086723; cv=fail; b=iTLn1r6pDr1Hp+wyLonv9YvQeI8UX4CnNUw6+6KpHrgEQ2K4xXFdxK3uHoBAUpayITz4+qP2aiO/qQUz8nMovSnWF6U69Kr+bC/1mymEa/3q7kHqL9JYXgdoOYyK2WbQKDmrVDYnsfSEPoXB2kxHJJK8FtKnIk4ZDRC52KDWqpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086723; c=relaxed/simple;
	bh=SZFZgeSjhqcm6JCPVeAOSe/UDnbgzFd8CyuRcW9ObNE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OK+TxRlalFCtpgzrwS1IcpvGszdcFu35J2nUKeTnwTm49BYKYXP2ufPg0czxwvxSUWqo/KuIwL2QoiI7YH46KCx0ykX5pETDJs3xHBjbzdkcrLIIp5tE/RRLH2YfV/Bd44F4LjUEkM076epgWQefZntPlQFVt7pOLuvNmKNMRE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBSC0Cdb; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBSC0Cdb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715086722; x=1746622722;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SZFZgeSjhqcm6JCPVeAOSe/UDnbgzFd8CyuRcW9ObNE=;
  b=HBSC0CdbnR7/RtstpoEdOabpgzSk3QQnz8+S3aVzyY87tjzdpQM61XAP
   visIfjcCIYinEPmLFwqB+ivNMVOukEq1ImbNynsDO81ZajXqKWwP+6nL2
   GBF2v+x8P+xiJ6l1kHwySwa1L6R6JOmfkFJpm6OsVpTChtxcz3OSzpzM5
   g6FTCGrPaV1XMAT1gudETvRyJzEdCX3A+xLzhH/RxpPqWdyv/SA5/zMGM
   srHZ5rv2iTJxr4TqxjMjPmxpMMnoDQ1AQOIa47UIOew0UcHMDuEVzghwB
   YltFB+hyJAocS9mZnoOfTUYPp3dhy1ijD9mJR0Ph3Pkfzf7nGOS9i3wWg
   g==;
X-CSE-ConnectionGUID: chzVJO0MSpOh60ySXOxqmg==
X-CSE-MsgGUID: 77ivA7jVQ/KO4mi/4blNGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10732935"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="10732935"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 05:58:42 -0700
X-CSE-ConnectionGUID: W3Zb7DUvRpyf5iLTqBIZYg==
X-CSE-MsgGUID: t+ctREcdRy+elZbcUXLRDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="33026811"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 05:58:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 05:58:40 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 05:58:40 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 05:58:40 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 05:58:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9daQVf7TpgXDshat7Jn4KZBhnwQy8gLLz5zzNKEVeN9NDnzvZaUrg4IhyK39OWPCaIfJ87bIBXEuVMykhWa1uvyULKroSFWopBtQl8jUGQrHzTJG2BRYNPGNYNRYjVzGLOeLwnl8G/f/gUKfa7nFyF01t4kh3lbN5UI9OWR4zJaBuPcEvn1QWclWrikQwGRjjrNwz5frEAA5OWHXv0D0EZj9YM60ySro9UHPuKQoNAhRQNOnDDm++nLirajisljCeg174Oqtve6qhdJyWi72FW8AlHZRHtvmzqK9FbDIM0XAqQ5g7tQ7bMvOQJzgURMPkzzwa+fRT5VfPX4pgrptg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zg8RWlwxPuZFQVYaBeQnH+3+JG7GFKTxpmgu2+6ZtAY=;
 b=RXHaDzLpeZnqNahwfUtCQGYDH0dyn+FkTwdsRuNTx2tvoRkh8hEr1EG0CW9PTnktrU3FB6nblG6mpdvHyatNQONmpgixel4fUvVbJk5Rr5AUkDJm3tcI/v96P4tg4DrZNjYjKswahtgtBI9deb6juujQTn+D/OVkxe7XKZ9gMbPqCv5i/8Qd1mMFNr1tVahkrn/tbiTixLBCAHixqCBTspljo2ZQjd9g6/KPtZsLgq/zCFhuvUvVgyiwYkxqvcMFyIWDp4ReB2Xkalp2nNgCQhyOACf/ycutUP62rfBaXrBpXsWCisaFhPF7e4NS88kuXXUC/6o6r4m4D2BrTj/EVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CY8PR11MB7747.namprd11.prod.outlook.com (2603:10b6:930:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 12:58:37 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 12:58:37 +0000
Message-ID: <e9edbd4b-b117-4876-8d3a-52dfa1d2a8f6@intel.com>
Date: Tue, 7 May 2024 14:58:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] uapi: stddef.h: Provide UAPI macros for __counted_by_{le,
 be}
To: Erick Archer <erick.archer@outlook.com>
CC: Kees Cook <keescook@chromium.org>, Alexey Dobriyan <adobriyan@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, Justin Stitt <justinstitt@google.com>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <AS8PR02MB7237CD9ECBF7907AD8B1CC938B1C2@AS8PR02MB7237.eurprd02.prod.outlook.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <AS8PR02MB7237CD9ECBF7907AD8B1CC938B1C2@AS8PR02MB7237.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0029.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::29) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CY8PR11MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c43a6e-9bb8-472d-d6e9-08dc6e95691b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1VYbTJlbFNtYlJoZG9GbW5TVEpCWXlBbU1zTHJBYWVDdXlZbnNLczFwb0VQ?=
 =?utf-8?B?aFE0U0tjT0NOeGRwbzFZb2pJeFVhdFAvSmFFZ3JWWTJDMWIzTFNuTWNwMUxr?=
 =?utf-8?B?Y3dNUGtMWVJpV2NIV2MyalI1WlFjVm9nL1Z4VThGVGdhTVdjVEpwKzBCYWIr?=
 =?utf-8?B?V0FOM1NSTktEODNtcFJvSzJGRU9oNy9SaldNUG1YZlBxL015Z1dtbHJDeXpF?=
 =?utf-8?B?UnF5eGZqR3VmYTgrYzZMWW9HR3Nob1YwSHI2enc4Sm5qcnBEK3lqTUhXTHFB?=
 =?utf-8?B?a2NvMzVKb1lMemVlOHhrZWE1VVJnMTFzWjVINjFrcnZvOFB6QU9WbGllOVV4?=
 =?utf-8?B?aDF1MGNnSmVCNFo1V0ZmVUFUd1daR0piUUV6dENzM0RRcHc2cWZlaExhQVBl?=
 =?utf-8?B?RUVZcmZBa3dkcHZtN2RvTE9QZVk4SUxJK3k3eGVrbmFELzdYeU1JN0NNYXBN?=
 =?utf-8?B?MlhGVEtMYVlSdk9raGIwcWhJSkV2SXhuNWx6Nm4zaVFvem9PdjlMWUpWZ1Rv?=
 =?utf-8?B?V3E0SHpwbHJ6eHB1NFhBWnI4Y0Q4RXlJU1FqS0xudEFmN0xMeGl3b21KWWV2?=
 =?utf-8?B?QUo1N1NzNjIxc01ncGV5REpzbkhRT3lZVWl4bWEwcWNOZy9QcUc0K0NkTHY2?=
 =?utf-8?B?YlV4dHcvSFdlQlA3V2g4YmRFb0tFQythWmpJaUFicVl5bDlmRkdZU3hENGJo?=
 =?utf-8?B?MXhQS3F1ZG5qYW5wd0RFWUJ2ZFoyTm93QjhVRloyVUd3M1NRQzBDZno0RkY1?=
 =?utf-8?B?MEc4ZG0rTzRKNFJZaGtYcWhqNTJST24xNnpVWEVhVHI0MEQ1dHdDWmNrazQ3?=
 =?utf-8?B?S203QVdONk8xdWJqSHJyZFZOM3N5QjY1ekxGR2ZUVlQzOXorUytyY1ZxM0Y1?=
 =?utf-8?B?MTNVZkkzYzk1ZEZqTFl2dlVpMTNGdWJGK0l2cHplZU5kU2xRZ3A0UWxlV2sz?=
 =?utf-8?B?S1hDUHZsY1VtZ2NnbjVmSHNzbW5LdnpHRmwwMHkrK001WmtYQUZoYXhnNEdP?=
 =?utf-8?B?MDk3ZVU2TWc2c282d3lXL1Yvc0t5am5RZkw4T01GQmVac2xDZ2gzcWM0S2FJ?=
 =?utf-8?B?SkI0QWxEQUJlbUtkcHN3UWRoZlY1SDQrR2JtT1ovbHNZZXZ6WkVRTy9UU24w?=
 =?utf-8?B?a2pzZFRCakF6bEJ4WVRVMmh0clRPK0JrTmNpd093anRzZHpKdjdYZ1JZSnVE?=
 =?utf-8?B?N01TSmFPZU5yU1p2QmJQVjR5Tk1iRnh1YUJxRE5hSHMzMEZjeUhQT1JvaFd1?=
 =?utf-8?B?T0hyYUk5QWF0RCtUN0pzdlFTbFZ5WWF4SVp1Ykh5dHZBSkV1RkdhMVE0OW1L?=
 =?utf-8?B?UTdzV1k4KzBNd1NnbldqNU84RmhXK0V2ZmxGYUNsNFU0VXJPTmtkUVFlejVB?=
 =?utf-8?B?MnNwaUJMb1E1RkNCd282Kyt0eXorL0h0ZDB5eXJXM3BBekE2elV2REZ3c3ZP?=
 =?utf-8?B?Yjdsa2tMUVFlT1RENTUvR25pUk4wbU9NTlc2VTYweGdRRU1xZlB3eE9iMEZa?=
 =?utf-8?B?V2k2bmVqZk9lbEdXOGRjak5tWFBhdU1BZXczS1ZFNTlIcFVVNWlIdGxSSnU1?=
 =?utf-8?B?R0xCUDM2M0JTZmN4SkxJMnJYQmNrc09LYmxuSTExQUY5RVNYODdWTzRFVEtM?=
 =?utf-8?B?RFpXTlRES0lvaTVjR3EyZFZTSmhyRTJTaHZYVHdBMFNpdVJpbkxmdlhFOEVr?=
 =?utf-8?B?NEszTVFoMytZU0RibEVZQVhCWVJRS1RMTHZ5MUc3Rmw4UkMyZ3RBb2lRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0s2VUlpdTBOY2xJaDRDZVZ4UkFESXFYcWNicnBQcDRvcjd4QkRYa2JNYmNp?=
 =?utf-8?B?bEF1ck0zNGdPR2ROeGljK1AvTklyeE5WVTVCZU9GelErbG1rNklCcElBU0NJ?=
 =?utf-8?B?bmlKNWpPQVFwUzJFV003V2lUd3g3RkgyVm5UUTFFeDlhMm1kYWRUZVY1cDhz?=
 =?utf-8?B?RkdKODJhVVpQSUoxOUhJSnpIN0JqR3JERUx5QWpZc2Q0TjhQbnZIQ3lSNk8v?=
 =?utf-8?B?RUd1bmc3ZkZJYTg2ajczQUhRT3Q1NGVJRU5qcE1ZZ0VHTmxmU0hjWUg5dVNM?=
 =?utf-8?B?b0ZpTk9UellzRjVram9oZVBmcjB5aG5aUFIxSGZ3MGtpMGw4NEh4MWdqbW1Z?=
 =?utf-8?B?WTFqK2ZjZm5XOHdXQjBLSUw3TzdUTUwxdHpkcXBaWWZ6R3lRM21yMTRzcURO?=
 =?utf-8?B?Z2VSSEt4dlluenpFYjlrTmJtbldJQmtGK3YxcVhJNWo0NVFoOUJkb1QvNE1I?=
 =?utf-8?B?OUc4ZzdtdEJuaTBrMEZ2aVhtRVJHNkZhcmxNSjdZNW0xa1p1YWhhSUFkZGVG?=
 =?utf-8?B?a0xGK3JObS9SM2lkQTV2VURnTVhiTy9oMk0yWDl6emJmQmpKZ3UyOFdGY0xC?=
 =?utf-8?B?dlMwdFcxT21uVWErZGF1QVNDak5xU3hiQllpdWNjKzJUWFlQNStqbjVOSmdE?=
 =?utf-8?B?RHdiTkFabk5ONm8ySnUzWVRQZVU2aVRwY1czUVNhSmxBa0NENGxvQWlrUzBW?=
 =?utf-8?B?OGtmb2tONXh2ZnM2VlBWR2VyN0ZIZC9QeHIzSUZhYnMvdE5UUTZSNkdyeVFw?=
 =?utf-8?B?YTBvTUFtQlFabk93V2JrNUlzZHhBczZ5VlZ4dUZkbW5mT2Iva2QwTnpXUFVY?=
 =?utf-8?B?QzFFZ0hiSUJKZ0tnUFdTRkhSYld5YnEwL0tWek1aOStqQWNEK0ZBc2ZqUFJP?=
 =?utf-8?B?MEFDY1Q5RHpFVm5JbThYOER1dndUQkVlUGtRUHFhVERFQU1xTUxNTE4wa3lJ?=
 =?utf-8?B?T0l5L3BhZmRmakg0aGdzM09Gb2d1aEFYdys4NmZCaFZpQ3Uza21tb25IOGtU?=
 =?utf-8?B?ZnRvQXdScElDblAvbE9hSi9LdXIvVFhuRE9STUVWRkVQVlpQWTNwYVpSeWlw?=
 =?utf-8?B?cGJFOHBTOGY1Q01HRW9UekFuRmIrQmZYLzFLVlVQeFFkOU5lZGxnZ2ZpeG9n?=
 =?utf-8?B?Z3RpU2N5ZXRIUkhYRWx1WEx3SGF1dEVhcmRqR2xnM25JQ0NoWW0vS3o2M3Yz?=
 =?utf-8?B?NnZZazVuaHVjaTVuTGN1NzVZeUpxazF6RjB3S3ZEandrMzdvUUJ3YUR2dXJw?=
 =?utf-8?B?bXIvS05TcnNHeHdGbW1tdlhtbFlNU2NKZWhwVjBLdTB5c1NYSit6ZFFQN0Fu?=
 =?utf-8?B?WDRNN241TG9ydUJCaytaOERqcUtWQUhLNlVVcDVXeThMQU1Ea3BXVTQySExC?=
 =?utf-8?B?N3A4c1VUc1JMNEVwZnZyeEZtNDRRQ21TQm1WcnpHUktTb3VaVFI1bHpCb2Zk?=
 =?utf-8?B?UFprNU1vRHlLb2pjNTk1OXh3Ymk5dDVqS2tLNWFOVitlM3RVTEZlRVZSZXNJ?=
 =?utf-8?B?Vjh3aWFvcnRjUUFxQVltZzdsbXJEMnVsVGJ2a0N4OWJTQjNJTVZZZHdlem84?=
 =?utf-8?B?aWdNM0VmTTIzSHdWa0xRTWwydnlwczRLczVVZFRyUm8wOTZSL0FwSHg4Z25P?=
 =?utf-8?B?WllHUWZ4M2VKOTVKNXlveVpUZzYvek1DbVJMb0wzNmF5WU9mNWd2ZzZHYXVZ?=
 =?utf-8?B?RW01cHc4b0NNK0dyWlordzFtSWduamNGRjdYSTdFMzdvNU9takVNU1FjeWtq?=
 =?utf-8?B?ZXRWeDQ2aWZ0cktmWDdRMUd2VWk0bENTWkw3bnB5Y1p6aUJCK0hSdUY4dEZa?=
 =?utf-8?B?TXl1eVdMYnAxSzZJTjRRNjRsT0ducXZVUmRQN3Y0ank5UUVqa1Z0NnE5OGRn?=
 =?utf-8?B?N0RVcWFSUmVMUHBNeWZtMC9VcG5qdzNXNEU4Q0FIeTg4bk53VmdNMStBQUZP?=
 =?utf-8?B?ZVJHSkdOR0F6ekdmblZXc1g3UHk2Z2xNOENpTUY5L1k0eWV6TWtVWllRcEZu?=
 =?utf-8?B?WG1DcjdOWlhuSk9kVzN6QTQ1U1k4Wm1veEk0Vmt4RlZHVjFuYjNibDFrc2dh?=
 =?utf-8?B?bkV4bTFSeFl5ditKcGdWUURXL25BM0dYY0FMdXh0MFNUaG95NHFSdW5OSmFP?=
 =?utf-8?B?YkRXdzE3bS9FYXlPYzJnWnhrYzVzVHkxR0NQSFBwdHROWm5yV3FSN3p1Y1Fh?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c43a6e-9bb8-472d-d6e9-08dc6e95691b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 12:58:37.5413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRu5m9mHFODa4p46SxJ3S7MY5stMsbIyaMccW9gTm5Z8ZP5FuROdrQxSZXjUxDM0wyhTaTdyQlcWgN/LgWJzvJ3WE5ZG+sd85+nKg1fT+Gs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7747
X-OriginatorOrg: intel.com

From: Erick Archer <erick.archer@outlook.com>
Date: Mon,  6 May 2024 19:42:08 +0200

> Provide UAPI macros for UAPI structs that will gain annotations for
> __counted_by_{le, be} attributes.

Pls add me to Cc next time.

Why is this change needed? __counted_by_{le, be}() aren't used anywhere
in the uAPI headers.

> 
> Signed-off-by: Erick Archer <erick.archer@outlook.com>
> ---
>  include/uapi/linux/stddef.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
> index 2ec6f35cda32..58154117d9b0 100644
> --- a/include/uapi/linux/stddef.h
> +++ b/include/uapi/linux/stddef.h
> @@ -55,4 +55,12 @@
>  #define __counted_by(m)
>  #endif
>  
> +#ifndef __counted_by_le
> +#define __counted_by_le(m)
> +#endif
> +
> +#ifndef __counted_by_be
> +#define __counted_by_be(m)
> +#endif
> +
>  #endif /* _UAPI_LINUX_STDDEF_H */

Thanks,
Olek
