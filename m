Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CD830DEA3;
	Tue, 15 Sep 2026 02:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789438412; cv=fail; b=QLikBDqt9MqulrhvnlpA2Sc6c26Zo2SEsBgofECTTiGhMnSq+BAD50pyu0jsK0hMGlVLxOdh/nlvI0q8p6An9XeTfwMQ2nHC/bZHtFDopUWDr4pYARs4QvlUP+3b9BTSPl/XWGxmgLvh+8urkPytQ4BBaOqSrX3a8Bt5hfCKGGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789438412; c=relaxed/simple;
	bh=ZRJXAdwmdecErpHwqU+yXrfJ2rWXklVXQsJX9kzqMxA=;
	h=Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To:MIME-Version; b=GauVKCzjLN/2MmwoO6xA7pmSiJyJi5CsndpqEuxutfAoXkL7vn8ZVzu3o8BE1gNWWmD9/7V9h8nW3f2vQsXcje+bEQq9cKvitIon7zxLGfr/1NhlLq6rgdcczPup5ftemXp5I+dbSMqRIuq8Wv86FuM6kPZ78151/PlYlCtBSvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OoaANltP; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OoaANltP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YViOoxHn9ZL5AcWD8KzI0VWPNIZDT5lWBUKi41X/IIwTBzo9+f5prkrK/bIbjz/H6No4t2JCpkRAtKeQUhFAGpI3/GdsL3bRB7RXCXQ8jlHIiFEOji2OjkZ7MNPhzUyZ4oHCVw5RqwA511h9msZ2wgBINElwr9/68WoX3taoa1PqvsVAabBaKbytIarvK5u/xuk3Wn558min1FIyb1tBkHnhsTOEjgYRDYr4YW34UzR8qtcUHdlrFOwLD/cYDXgD0ckQ0HehzpbfzgUVlo7mvKdFva1ixeC4THEt01q77ZrTOkqZIRo6corkqCTU3/VU4DESTaVn48QhL2z98rSRPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F17wByKd8svqGXYvVX5yqWhs9EXaFnB6+/zLUYkf4KY=;
 b=JZBFf2WYfqCpifGU4L1fwiArN/Vf29HKY4WYmH720t8kNzGdcez2KdJ0pakgdodPgFdCfCNBZfwmwKMULwGWLEPHa7fic8cEbwT5xP2+VovbMxFvvwKGwUgutAmVJvUTuV0efk6sqQiaRrodMikXgC5h72StvveJz+VUN+fSi/lFFwJRttYgYDIHxILbgmC/fbPhykHPkOUR3Oyvrb6XtD4zm5TnAlDOFkJA9tIZ7qhdntFjbORykPdtkKD758hRnmPiGfv7LIwmcfKZNGEHb6huOw+BlpVImmLExI3/mNl1KXwskSStiVkI2+CuYa8ZiQHodu1P1OXG0uQwB3hbgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F17wByKd8svqGXYvVX5yqWhs9EXaFnB6+/zLUYkf4KY=;
 b=OoaANltPW1fPocGEHz07nsXu6RI/7JhJglEhUdz1cH9MrEWYlIc38/vhgPNhGkv6xrATtj/G9A74X87mBzQRs6N18OX/1G1VuO7aZa18HIVEitRWabVaT1b+7+ATwLSA7CbDm+4BEi1KC9rweJTGxG8+RASBtYgN0PwMIS+m7QmRytHXdPVRbN3Q9ELTnDnSLjGzaIF99SQGDMYziONxOK8yxTAxNQTaZVdYlW+H15FDt4880vq22qd+c7jV5ydXT+D0xJSLosADv3Bk+wxlzXiLD/hZRStC2WeW6lyi0AdOoh3k6BbSqHJ1dOZoV63PRqXkyVU0Hy2D8rSO8I0ISg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DS5PPF5E0E7945E.namprd12.prod.outlook.com (2603:10b6:f:fc00::650) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 02:13:23 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 02:13:16 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 22:13:15 -0400
Message-Id: <DLFIYY1VZWYD.15RG8EIQ4M749@nvidia.com>
Cc: "Lorenzo Stoakes" <ljs@kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "David Hildenbrand" <david@kernel.org>, "Liam
 R. Howlett" <liam@infradead.org>, "Vlastimil Babka" <vbabka@kernel.org>,
 "Mike Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan"
 <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>, "Brendan Jackman"
 <brendan.jackman@linux.dev>, "Johannes Weiner" <hannes@cmpxchg.org>,
 <linux-mm@kvack.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo
 Krummrich" <dakr@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <linux-hardening@vger.kernel.org>
To: "Kees Cook" <kees@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH 1/2] mm: Move default_gfp() into gfp_types.h
X-Mailer: aerc 0.22.0
References: <20260914223212.i.829-kees@kernel.org>
 <20260914223219.901347-1-kees@kernel.org>
In-Reply-To: <20260914223219.901347-1-kees@kernel.org>
X-ClientProxiedBy: YQBPR0101CA0265.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::9) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DS5PPF5E0E7945E:EE_
X-MS-Office365-Filtering-Correlation-Id: c0021f77-47b4-4720-27b5-08df12cee783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|23010399003|376014|1800799024|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tuIm/3rRzQ9A9LEoQM/oUPlzk1hfmTRDI1veQ9Yu7EESWGWwRhKDLdXHd2rRz2EFAOuIsT9VBOoGfQzrao5oMuOwQ/CQ7LLAtUS4ZRZd5tco1isZveW8dMxW312D+s+OJ09K5OKXTcboMgXMFIZf0XqVLl3f4O6EpjrajpYKIT425g4uPJeu9st92K87QBhzlrpg2+n4gbq1c1MfAYTljWTrnBQ1uvpsYH9ZORlX6UJvuMySHwGyo7R21eejl5tpWlXCxONbL9SB6y7uOG9quLAaDzIqxlLJ5dGj3/tVEZIXcO6o1nJ58wAFW/FRpEapwd+7sQUEhSZzakhQyMnMrob2i0g4l926I/e5r/lNk2lDNH/TDoRDNDXK1x/MpfhKahSC+McFmLIAYnoBu/PM2+GlnLFinuZ2drqozZnYkeslqhpyRvt5+rMhEcXN9ocQzDGIvlZm7tug2J0qUxIloqSdaZiEPPLlbIdi6MgOcp6347wfxrEHrybyhY4WhX57ZKSS6B077aoshzhv7E8VMuHY2RS76dRwWxASN5CG1FxaCm8lHUmQJvKIqIfwdhebWx2AlAwTz6ipHfTlWbJd/bwDao7CXB7h40tM8cOJWF+47ElUZe0ZpWoByxr8XPo1NSKaw+lnZT3RhAvtFqDKW30MDlsgzmHshA1VLyrh+qE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXJkcEM1c3kyS0hzOFRlT1VsejhZN1VhTjd3ckhYYzZ6OElMbXU5dlV6OENW?=
 =?utf-8?B?eEZiZWdMQVgvSFRlTzQxLy9aYkUvZ1pOZkF0bWU0Ui8raGZGSW9lKzBIRklJ?=
 =?utf-8?B?MnYvSmdDVDNPQ25PSFNNZzFNL2xRclZKcy82ek5IMnBEb3FBVXhnMDhMVzZu?=
 =?utf-8?B?S2NZMldDR2JURzN3dkM0MUl5U1lHMU9HMjBJWXFrU0ZzR2tJSDFFNlZSSXlP?=
 =?utf-8?B?UkZESFVmUmcrdEVSU1V0RjAyYWNMS3UwU3lVeVh1MU1ldDlNOGNnWFBPUU5q?=
 =?utf-8?B?SDA5WjRpdFdRcFZSUnp3dXh4dUFMSUoyYXJtaktSNVRpSVVYYUhYQlN4Q1Qx?=
 =?utf-8?B?bDZjYUptWFJGeVdKR3g1dW0zQ0JjWWhKUGx1U21aT0V4MG5jdjh5WDhMUmpU?=
 =?utf-8?B?NDFERzdvbXdETlI0T2tPSm91UHZrUHJ1WEJEc0NBNXN4YWk5ZS91dVowL1FZ?=
 =?utf-8?B?QjZ3UnNGekNBRlR4MHFXSWdLS0loQUdicXh2emVzangwQVFCTzcrQ3F1ZlZY?=
 =?utf-8?B?WHVxQlBZZGpxSG9nM3lxbm5uSWtkdDNMOTFDdjJONXVnVEFNZG9jQ2ZIdjZh?=
 =?utf-8?B?SGlzY2p2ZG5GUkZyY3B5cGpzZURGQkpXRGh6L2swQzVTS0VRUUF1dE1tbEZx?=
 =?utf-8?B?NEcvOUlGMnNnS0U5YXNLVUxDV0lDbmpHYzNmSVhlOGtCMFh3OE9yQTl1ZW9K?=
 =?utf-8?B?KytrcFJKdVBlUUlqWDhYRnJvQjR2MlVGYnB6bWZia0lHbU9Zc25aNGQyVFNo?=
 =?utf-8?B?ZXRMNWlRR1RDSUZKbkVvUDM5UlhCRExKVnZnN3NVdkVSckZvalVDZ0NjZzdS?=
 =?utf-8?B?TnNncllTVXRwZHQzQyt4S0RwZGR4QkovQnJ2K1k4NHlqQ0VnWkYvakNHUnpr?=
 =?utf-8?B?Y0ZnSVdITWZCaGhNTEQ1TGRmUXBBeFlYUkV2VFFKR0lKNTRGTjFTU01PY2M5?=
 =?utf-8?B?Y2ljRDNaMVNpTmhTOHFRT2NTTEtWam80SGxSUFNuQ0dEN0Exb2dEZ1lVTVVi?=
 =?utf-8?B?bnkyeDE4YUVXZTlpWStWNnhjTitHbWtOb1huUDhJTzVFekp5QSswMGk0REE2?=
 =?utf-8?B?VGNBelJwelBXV1hyRy9uVjR0L0ppV0ZsS2dwUjZkZkNNY25JT0ZHTWJROUYr?=
 =?utf-8?B?UkhyaE9mVzJVZ0xUUGhqaXd2TmUvNGNOSjFWWFlNOVVxZnV6NmY2Y2VFMHg2?=
 =?utf-8?B?bjFyTWthSzc1a2hIcWxKV0ZQK01VSzY1bU9XTm54SXRTRENoaDJxZzFURURV?=
 =?utf-8?B?bVlMOGRReUluWlFkM252dDNKUTdqRGZzRit1Q3lDTHc2RzJ6b2Z4Y2N6Z1c0?=
 =?utf-8?B?c0VTK0RjcGxmb2pmbXY4T3dHRUlXUTdLNHdOR0JJUGIvQ3FrMWhZQStCSU1J?=
 =?utf-8?B?Ynk3c0RaWjl2MXkxK2VCTFZqOW5ZSU1QVzE3d1hpVGRPVGVJNmZtK2M5RXFi?=
 =?utf-8?B?V3RmeVJrbDBwTWpsMlhMdkZ5d0phNUp1TkdGM3pVK3dIeGp1a1dlaGJuZWEr?=
 =?utf-8?B?dlExR0czUUxWSk9CWWNHUkR2YkRVRzFEYlBJZXZZbzFaakN1RzA0UEFmSE85?=
 =?utf-8?B?aVRWKzZoU200YmwyZVBlVTQybUI4aS9vTjZrYlJ0YndiMzNlVXFWWjZCYXJH?=
 =?utf-8?B?UnNKVUhnZVk2bTdrdUJQRkR6WkxzdjJ2Um11aDNpVGRqS0svUjR6bXZ5cnJO?=
 =?utf-8?B?aE1TeGdlbHpuNE5kS3p4RkxDTlllVWpCOEhWQmpQNi80S1lUdlRYMnBPUk5T?=
 =?utf-8?B?MUptZnBxd2R6VVVEcXVEMFdQUm9SRVNQNlg3RWVBVjJNTnEvMUJnNHJPbzJs?=
 =?utf-8?B?RTRFWEJhUDdVcS9rRHp1dEhTRFJMdDdxVUpibDY2Q1hFejUweXFvVEVzU1hL?=
 =?utf-8?B?LzBTZXF2Q3NVd1I4ditFNUtZZUlpeXZxRzJKRTNxWXlBaUZNcWQxdjBWWjlw?=
 =?utf-8?B?RDdVa25KSXlpRDY1VVFVN1lDck8zNFVSVkZnZGdpazlnb3RUejdxV1JuSWJE?=
 =?utf-8?B?MkJXY2Y1LzhRbXJzVUM5K2xGeW9kNTc3UjB6Z0E4bEtjQ0ZmdHdVNEN5MTl1?=
 =?utf-8?B?TU04L0xUSGRWc0MyanlibVROSzdhWmExNTR4UFhWbWxtQVEzZWhYQzlSSFFL?=
 =?utf-8?B?SXZXWTdsb1pkTWNuR1RFZlFBTDB0Z0ZoM0Y5ZzVVNHNzOTVZWU04VjFOSE1P?=
 =?utf-8?B?QTk0SHZXVHd6ZVdNZlRIY2FHZDk5Zkp4bWJZUUZHTXBoS0d3WGg0eWh5UENU?=
 =?utf-8?B?QkNlcHFNRks5cUg4Q2E2QytEd2hvSVdxNVB5aFVIeVJtdzdZQTZBZjYzSWhQ?=
 =?utf-8?Q?25RBBiSSyu6mEOg6BT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0021f77-47b4-4720-27b5-08df12cee783
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 02:13:16.8193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcLrU2mSk67mgmYXzDjqbBXLEesz8eJAInseNSsZZgNiSobCZDrSnkw/FqboiFB6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5E0E7945E

On Mon Sep 14, 2026 at 6:32 PM EDT, Kees Cook wrote:
> Using default_gfp() only depends on the GFP_KERNEL value. Move
> default_gfp() into gfp_types.h so that future use in devres.h doesn't
> require pulling in all of gfp.h.
>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: "Liam R. Howlett" <liam@infradead.org>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Brendan Jackman <brendan.jackman@linux.dev>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: <linux-mm@kvack.org>
> ---
>  include/linux/gfp.h       | 4 ----
>  include/linux/gfp_types.h | 4 ++++
>  2 files changed, 4 insertions(+), 4 deletions(-)
>

Makes sense.

Reviewed-by: Zi Yan <ziy@nvidia.com>


--=20
Best Regards,
Yan, Zi

