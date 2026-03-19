Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010030.outbound.protection.outlook.com [52.101.201.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100C61FF5E3;
	Thu, 19 Mar 2026 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773940554; cv=fail; b=BHSvsV2WlKlCfJYDc1E4EHWKg3cHXw3hAkG7HSZ2HsyreNCnQ+PWEWNKqfHZZ3IyaFiIGlres0tcf0jAQv+35WL/Ur4Gnoo5iKW+sB7sNZkUmZ3rL89G3Ta/NS3sBu2h7r30GRn2xV+s8O967D4eyxrr5zWW0q7DRHvdeX10aU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773940554; c=relaxed/simple;
	bh=9jLSV7da5JnGxZjSD/HJV+sADzauQ9UK9kyfaz57cjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gZkd7fAU7Bmy3qkiaprPl/E83abijDbDnE7q2BSH8C7k3uxop98yuQKr1TA5SwFYiz1hIo1sN1KE+BegHBHukbF/Gy/nWCCLe33LFhXGFHGePexydsRu/xtGx+3KKNB6Va85imwteqUPvV1CecjjOnMpYNP0WpSYlefM7dODrMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ai8AjtJq; arc=fail smtp.client-ip=52.101.201.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ai8AjtJq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROr06CqpJxR+vb2kqsCaoSFpL9FkHDjxr1r1dzABrWE52OGOmnkmps9yCs634+j7HCmClDT6gmC1K0vuCloPswIFDjilkKHtCpDzwOn8BXCWVBgjDDFWIJgPSgLhS+DaiU0PUE+pFCCTg4CB0oZ85MpEDDMSX7VB2oVlKRSCfp3vo7yAthUCpDvOiXNb/zWuTJ0cjS91aqgZAA+R+qYQvioXCl7ZmWZr6IEPcLUnUUGAyCDlO7YnLbnOZBafGjmsXDkBoCdZuonnPb/4kIHvCth4JFPFISgIfccy5mNcpXVEJeYdFrfZqZuy20qWWMFujsIGxWZWRRdHXhYYpaHkPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlozdHLIVYm+7gNK1Ed6Rd3VFnE5rBJJrwKhcUTaLZE=;
 b=pym4X04R845rcA+mplU3uXDwaLWswCLjo/OQQhzAcX8J9YBW1FVmwQRSc/yjgR1nX/gQf7Squgc0CY0x3OsS8ZZ2pUo4BtW63414kAMqj3YpA+OKuXeLwqNzsTfpCaz2SQg+fS/xPL9neUPE6tyu1X+o+56gCIcZ5RxBnqszahKYYn2lBxZzqBl5LBp3XGWjzAtPGr9Kogpk1nw3ZBZTIuEzc7dXGnRZ6mnlZkXK4oYUsf6wSjwfhh7cCJZa5rXtYjQR7AW2v+lz0V6YEv4taTVLEthgjFDOm+uEQVNJ6J56HhkUxH/sgP5LHno6S9SlWR6R+vESJQzlPfoEv330pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlozdHLIVYm+7gNK1Ed6Rd3VFnE5rBJJrwKhcUTaLZE=;
 b=Ai8AjtJq3sogNta72zuDGHL9xXnvfflragfukrIFQ0OLAVI1DsAobAcelDl1u0DRY/tlqxc6wErEF+hAyF7ZFT3ZPUp2fpO5sr94L0f/RRfC0U5SgFrUS2dKDulPwMXq6ZEl9Jd4B29Kz6yTxEGbufnw4NR5hjzJniVRuM7czeQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DM4PR12MB7623.namprd12.prod.outlook.com (2603:10b6:8:108::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.10; Thu, 19 Mar 2026 17:15:47 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::7da:cc3:cf2e:8ebf]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::7da:cc3:cf2e:8ebf%4]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 17:15:47 +0000
Date: Thu, 19 Mar 2026 13:15:37 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-edac@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] EDAC/mc: Use kzalloc_flex()
Message-ID: <20260319171537.GD1666212@yaz-khff2.amd.com>
References: <20260312050813.9915-1-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312050813.9915-1-rosenp@gmail.com>
X-ClientProxiedBy: CH0PR03CA0420.namprd03.prod.outlook.com
 (2603:10b6:610:11b::25) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DM4PR12MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ee818ba-7650-4acf-17ee-08de85db296e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fOPK8B06RdITSs507yAwUg/db+xt4La4NVbSsko8x1o+BIYpePqrngI2MlAU2TcSj1KT2pS5aFOf190IaCA7h3LogFVflquUbb6N2zGUWNYH0ls8YrhjegZ2AWqlsZwuI9O5aQPBVAs8gJeZiq1LS1tIBifP4eMLQj6bJCLStEaNBh24qORUqQ98fM8Rpulii26uB63zaDY+Xrdd7OCAsih4eVkFpYj7/ApuR4GtmOQdK/WXnW0Da0b2jnOxCFnMsPFtR9bRbT+L0gH0/TI3INN+1yW7cmdv+bRNfjt3HPcuSUHaxF6Na32EVWykNs6FNYi7yNVVBL9w2iG0ypko7kktalVyVmDbzXd9348frlaC7iYwErgYzgFk0qgBg3BtpPX9ULDLNq2BRu672LYxTiBinjRE9TvbZUYbtwisEhP+sztUej6OlLRvHywTqApxn21DXHJukz/3VaVk4onsSOLsUVCLHZjS3YsLM8JbuicFL/UPfhXy+efWo0aCAS8BgLfhuH3yboWZ4LdqBbDrCxSNW5XSaFSKyLX7fD/FqIayfWPbh+kZYAAoREJZgN2ZTksoOjsRLW9WsfnAYa3Jeb0t9fPWhFmodjJl9yUtMjgU5Scu7Ogtmt/a3lwqJa/ZlE8Xa/MdSZrjSeTPgas5xSKsU9CiQRaFjRSObAUJUM2uSaN1J2KoZhpdSHOgNvzAet0mHuOR4P3TcJ3Ep6rYNFaJMnL19DmiFfzCPlFViVo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ls0g58yTDYpqZfUdTAvnRKiYoGeFN7pr6mdRfgHfcA8/5YmSklk9MoXwvPLY?=
 =?us-ascii?Q?KwEDUUb7yoPaiJcCsb9nWnoXGZEdLd3kmq+Xgab9jeqfi5f02ptTzz9hNnx5?=
 =?us-ascii?Q?AorXOPSmyVusIUDrzqxiUeXL5jhAYDCSq7NWGK6iqkMTpt9cAtKLNdQgQuNA?=
 =?us-ascii?Q?BtazJPCxn0FmK9TRuZwhdcvcZujxpwUzgGtYeD6q1LcGHstKxnzzRbE5RHoY?=
 =?us-ascii?Q?K6YWmpyLrH6Q8biqwyZd51dpFWNDwooa6ibkui8NYahJGqC/iUFBP8omGsbr?=
 =?us-ascii?Q?UF9gxzaGlYgfl2IutGriFahunqLb8+ScXxjMvbQpDWQQ2fhUCvUCzqiqq/xN?=
 =?us-ascii?Q?15CeP6v1uwTQpM0/mqcxSaEam2dqI9vD0qLEUmniR77vwpq3jWsS/MkiPOkw?=
 =?us-ascii?Q?e8pioOaolpTE9zc6TGMFHKV34jZvqj6l2uF4TOOskk2vjmmAKRtljTEVO+as?=
 =?us-ascii?Q?9d/ubaosDCpo3rYKHJPHEzq98eRaKjfGVqfEccKuFpc2Uldr1nTUWM3Hg23a?=
 =?us-ascii?Q?/qPPafZw+37bEm/8yDW28GHsw0KkoYGgz1E9N4+JBuumcId/t1/1DwCpJ787?=
 =?us-ascii?Q?Np6o5NabCaO3IC82gEzxMs1+qv21poDAh6jDX+xWHGhqPLW6lc92H/y5Tmey?=
 =?us-ascii?Q?q9GvQAjRg/ClSIUVrcom8dLjAOmhRjUjJ11wCMKABbM82dL02MdpRp/CwG5Q?=
 =?us-ascii?Q?DN+2Z3nBKtjcb8ymFw+OcnklVRBmjn/F7rUOzxfg/EDdvFRicWsd+vFNsNMW?=
 =?us-ascii?Q?UXxTWIP5pGnDJt1yw3x0fIvoxCwcF4D7KXTM94Fz57q2OycykzOdRCEgZLNX?=
 =?us-ascii?Q?V783W3DDoORZk5ovjnXYAphlJjiKUyrFOyxIQQEiSR+SxeDYW4G94rCndaBv?=
 =?us-ascii?Q?MVom7+WsA1WFuEhYz8mwCqECZJiq9oKOXwpOImfIy1gWWzxIg7zdJ7e62TJg?=
 =?us-ascii?Q?YZr9P2jMLR550gnseaAaJTi8h5wrqU8Xg2Y24P5l1GTiN1XFXvMZHCWtcMhv?=
 =?us-ascii?Q?6eMAovm3VJTDEryA+Nty7xgjGn64970GaUOpMrQUOLcDAJ4Q53xXb3oxnFqv?=
 =?us-ascii?Q?fbcEQHfhbZVxonnkVwUgWK8pot4p58uAwk7f0u3NmGdpd4VWhCMgDd4HnQVg?=
 =?us-ascii?Q?REtatikuoezjy562ogJkFANgZFEklCz9uMbmy/sSSbredabXmN2AhKXtLQ2j?=
 =?us-ascii?Q?l85aqgv0rCz+O6V4AxukUXXtWwJGM6nJ76++0yyHikZ55zuBY9WxUDVwVmIr?=
 =?us-ascii?Q?m8nUeveT03NGMytrJ8yXZ2hJWaCvmru9wbjYFncwWBzsJ2nkBhprXZkKgt6+?=
 =?us-ascii?Q?bgiHNTma/jI1z1O+bKw2RvYQSBw6JI2ZbRTF8vRlmGO8sCLos+iU8EWAv+yP?=
 =?us-ascii?Q?alKSM9LK87+3o0Xf/syiIdbZoeqmuGPZ0FbsAn8yYC3cH2aCLs57z9YQ7hmd?=
 =?us-ascii?Q?bBw6QnMNhWWgSMDTG5HTfESZNlGSQUcfw3mWfOrwxPoz9KJPQEyYbw+W4Y+B?=
 =?us-ascii?Q?YQ6n+QADgPE2a3b6UjhqsuUGy/xNfv+wO20lbgj4O9OuVKwNz9mbu45cDinr?=
 =?us-ascii?Q?oTExhL1S10OylbPv1wMh2VhtZy3CijVGLVMkUI6cUb44CqWsVBAN7RuDcV7j?=
 =?us-ascii?Q?1Qyo1BQ9STA57N1I/oYXfYB7pjounYpkYUzDUnUzvUhT3ighnBc0jsdLOCyA?=
 =?us-ascii?Q?SQavZYI+h7x0LxUfUq+LQHrfPHd99Xd8Qbx89l1wPss20uiR6Lum+zlc2cVm?=
 =?us-ascii?Q?dFl+7UgFaQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee818ba-7650-4acf-17ee-08de85db296e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 17:15:47.4991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xSyOjdLqfKe+xrpIUWIeZqueNRHXYV9et2eot3upOndnkBaM12Pcf5gcPrXxYG05n42nOlnM9ygQfelJaOhzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7623

On Wed, Mar 11, 2026 at 10:08:13PM -0700, Rosen Penev wrote:
> Change kzalloc + kcalloc to just kzalloc with a flexible array member.
> 
> Add __counted_by for extra runtime analysis when requested.
> 
> Move counting assignment immediately after allocation as required by
> __counted_by.
> 

[...]

> diff --git a/include/linux/edac.h b/include/linux/edac.h
[...]
> -	unsigned int n_layers;
> -	struct edac_mc_layer *layers;
>  	bool csbased;
>  
>  	/*
> @@ -609,6 +598,18 @@ struct mem_ctl_info {
>  	u8 fake_inject_layer[EDAC_MAX_LAYERS];
>  	bool fake_inject_ue;
>  	u16 fake_inject_count;
> +
[...]
> +	unsigned int n_layers;
> +	struct edac_mc_layer layers[] __counted_by(n_layers);
>  };
>  

So this is not a just an in-place macro conversion, correct?

You're redefining 'struct mem_ctl_info' to have a flexible array member.
I see this was done with the SB and i7 modules.

I'd prefer if this was explicitly stated in the commit message.

  "Convert struct mem_ctl_info to use flex array...and use the new flex
  array helpers to simplify initialization..."

Just an example of some highlights ^^^.

Otherwise, looks good to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
