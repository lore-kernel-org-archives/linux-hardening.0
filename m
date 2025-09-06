Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5167D315D38;
	Sat,  6 Sep 2025 00:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757119608; cv=fail; b=rXc02vIyXYzyH05a32fitfCcGRU/NsjNVjqPXPmQm957LZ5j0E/7VVUDkpdey2oe/l39A8BXR95PhNbH7EO8qbwluvVZA1VCoPA0QuqlZpT/KjbLToYLZCEhq6s6Epv0HicQ8vsSKJr73lHhMWXQmjXl3MUj3LJQS6pKXSed/2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757119608; c=relaxed/simple;
	bh=iHh3RnjMtY+4UiG1vWT0y5s+4dGk9V80d6mATHY3RRQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tFNAYiI5dckERyqLshNCBxJlqK3h9GQfr7af2CLGS7xYe85cgQDGvG/Ati7UP0FFlyaddaCSOBhxiouQ68qlbiX/GioDG+bv9dJG+gOB718MZwOf8y52nA9jRTCuxcq9IoiMEAO1PjJOYC2yCsRXX3b4UyBaE0qUsb2gUN5Qbbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g2Wp7oOJ; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g2Wp7oOJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757119606; x=1788655606;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=iHh3RnjMtY+4UiG1vWT0y5s+4dGk9V80d6mATHY3RRQ=;
  b=g2Wp7oOJTkdj2iBX1iIJ8S4bzXF7xGHH6RHwABBL7RomQRjYe521eeD7
   0QU/D5hpF4+lydUyy5RxYcGVWy+wIoxMvcN9ihilFWhUKE0A3UWGW8T2L
   XhXU6kWpayAzE59fUOM3HD+mOHawlEpDcw3TCz6AoDM/WiC77kzsQ0uaJ
   8nfqp0f7Rip6gscKYtKPBPRj0HR8vQ9o/ZbNjASDYk+o0Zg3oN2fBhJ5B
   aTagYqsVWdiLQ9BzLn3ZELFfxLZqyYTLMKbbb4CsvSQ6Yr4X6/xhd55yD
   38/WUkSqRdWVuKSPsLenG49T6wVM2b3b0o9dW5SJx8OeQoMwTPC0OBasE
   w==;
X-CSE-ConnectionGUID: 5NtioDFjSMinMXhun2CJ1w==
X-CSE-MsgGUID: TpxzDN8xTfms50/zoSSF0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="70851536"
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="70851536"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 17:46:45 -0700
X-CSE-ConnectionGUID: CBM6xNNCQieSB0Dk9qgzTQ==
X-CSE-MsgGUID: 3/haguQaSkGDMnF4j75oKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="171482457"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 17:46:46 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 17:46:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 17:46:44 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.77) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 17:46:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqqpZubwAJAV0vVF5gra1+3ece95H+JsJTCityfnLnrj4aY0LR+9P25xXeTMnx3wTsvk+qzFePJlY6Uww/10MGXpc0upzujodI2a+t8zRHK2+o33QgYufH53ikOgCf4Dr4BmaL98BYj3N5SllOn/z6zzJ8a7ecpXYHn2MvnBnAQVCAb4A2pY0yv5IpUBEOMUNHPcoTnDruQ1AjXiyKNHP1VYKIe+R/8EUtmCdQkAhXwVrjfSIax8beqYlDmf5wjF1Y2xN693L2TPymy715xy5YOyQvoIFqMpt1Pw7TK9mrnWCv17ejmgRsSmwC1oVoe0CLkry0pJJBqGYDEiVjw5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOyB0+4ibAqOI+7EVlaWeh2WHWxKzZRihHrW+kvOtho=;
 b=EqWDSXYrFLWZ//HmZVadGqDEdwFDYvTxn34LO6qBpQ/8lPVwJFj9HEE+lJgrAXWBt0FaiXzFi+ekeSmtasrs74e9luUgMxToFaThgErDsuYdvgWkKyGTStwU90519+LkyQEhhBapj4G8G4mRMFBXRXIqoV1NCT1TMwQ9BBPWOxhcfIQbntYAyDwg70DVDc/B9UsORMOWgvumt/YqnSCEClvFF3TIHOW/7ve6/8w1QrV5Z6bp2rfZv00BDpQ8QTIX+TwLDnqfOsM9LoNW4siDGD8xOTIGAk6j5wXo5lXK5sH+9MFrLkj3dGlAKMf6VXfBJPppQHo8JmBrfyXTW9AAZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
 by IA4PR11MB8962.namprd11.prod.outlook.com (2603:10b6:208:565::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Sat, 6 Sep
 2025 00:46:42 +0000
Received: from PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a]) by PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a%3]) with mapi id 15.20.9094.018; Sat, 6 Sep 2025
 00:46:42 +0000
Date: Sat, 6 Sep 2025 08:46:29 +0800
From: Philip Li <philip.li@intel.com>
To: Yury Norov <yury.norov@gmail.com>
CC: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Burak Emir
	<bqe@google.com>, Kees Cook <kees@kernel.org>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	"=?iso-8859-1?Q?Bj=F6rn?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin
	<benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, "Gustavo A . R
 . Silva" <gustavoars@kernel.org>, Carlos LLama <cmllamas@google.com>, Pekka
 Ristola <pekkarr@protonmail.com>, <rust-for-linux@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v15 0/5] rust: adds Bitmap API, ID pool and bindings
Message-ID: <aLuEZQhnp7Z04EOg@rli9-mobl>
References: <20250904165015.3791895-1-bqe@google.com>
 <aLnURXW_ZiX2iJd_@yury>
 <CANiq72==48=69hYiDo1321pCzgn_n1_jg=ez5UYXX91c+g5JVQ@mail.gmail.com>
 <aLrjNze2_L_vAnWX@yury>
 <aLtautgAVKdqNv2R@yury>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLtautgAVKdqNv2R@yury>
X-ClientProxiedBy: SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19)
 To PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5674:EE_|IA4PR11MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 139a2c74-2e50-4f8f-458f-08ddecded8a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c01YbFAvV3NLOEwvcW5ZaW1PeW9EMHlMYUtGNmRBVWI3dC9lbEROOC9pdHRQ?=
 =?utf-8?B?U1VCZnhTZXlGUEk5aktWWDlyVm8vRzNmbTVhUW9HRGNGQkRUU3dObnBwRkZQ?=
 =?utf-8?B?ZCtzNlltQkNUNThKcks0R0wwckdkeWN3M3F2QWJtMk11VGxTb0pYWUoxOVc5?=
 =?utf-8?B?VHpZdXo2U0E5SHhzcStabC9hZkpKQk1zcWVPUmRhTkIvd0FKZ0FveHBYOVMy?=
 =?utf-8?B?ZUowaDF0SnhJVVlxUitqRjkrZXV1NzhSazVySUFNQ29ONy90ZE5jM3Vteldn?=
 =?utf-8?B?c3U2cmtiSjN0Qmw1UjFtanFRZ3I5bHRHcnBkbjdON0hJSkw0aHh5UEh5WG1P?=
 =?utf-8?B?Sjh2YTdlVkpENlo0QzlZYmFzd1cydUwwdU5UbWtSQkN5WXJPTHp1QkxpYk1T?=
 =?utf-8?B?WW52UENteGNiTkkwS29hNm80M0R5aVV0VkNCaWNieUF5VGFyM0pLblhhOHBt?=
 =?utf-8?B?RzdqZ2haVEViNFNUblN4VzhSZzFlb3FQbnNDak9GZTlvQ29EZmxEaHkvUjZ3?=
 =?utf-8?B?QUd6bDRPTFRqTjNFMWdQSmp4c3BhNEgrbjBNV1dyN0JUZktWa0Y5ZEhjWERV?=
 =?utf-8?B?WndGR3VZeXk0ZlFkMURFSUNiZDR3SkhvUFlMRWhHajJsakxGT0lYWjJONnJR?=
 =?utf-8?B?bjlab0xZMkRud3JWVU4rUDNHdzFEOXB5cEgxWnRVeUdDeFNmVkdpbFpveHd3?=
 =?utf-8?B?OWl5bnpqQTZ5VEZnK0VBZktxT09iK2xmOFhrRE5Hb3RJTUJmek1HZkc2eWpa?=
 =?utf-8?B?YkZidmw2Vm1VREZETVMwYjVPVVYwOVd2ZXFkaFhpWEVNU2k4dHgyRmFhSmp4?=
 =?utf-8?B?NWxaUzdoZ1RCRms3cEp4SmIwNWI2Vlh2aDR4d25nRHpZczBZYU8rSFp0L08z?=
 =?utf-8?B?aWoyT1M1TU0rSW9wNk9tVTg4dmpLZCtEaXR4elZjM1MxQys4VmoxUmRtbkRL?=
 =?utf-8?B?ZnNmWEZMR2ZDNDlOd1k0Qlg2eVhYaWczVjA0bE45NkpGdXYzMWo2dkR6WFVI?=
 =?utf-8?B?ZExBZ0d6di9jR2Y5UWFXUEtOTFRBNnh2SHhYclVVUzZPOGFuam93T2FTcnk3?=
 =?utf-8?B?YTJkT0NSaU1RN3dRb3Y3Nkw2WklLbnMyaE45c0VJOGJOYTV6eDhISXdOY3Jq?=
 =?utf-8?B?eHArMStuM3FVT20wRmlCclZNVVlCY2RxU0lPdTFOK0k2aDVqWENBVTEwZ3VU?=
 =?utf-8?B?SkgvQ1dCRExEcEt3dTRlMXhlTThCR00rMFpnRUU2eWplSUdVVGk5SXRZTnl2?=
 =?utf-8?B?MFZwZTdFR1J4RzFhN2dMVnk1T1BUb2ZIVlFDakw3WGZJZG5na3d0Z2wrdEhS?=
 =?utf-8?B?MTZpOURtQ1p0bENKQlR2R0lsd0FYTFVadkRwaG92cmFlQVhHcmdPdGRXOHRs?=
 =?utf-8?B?S3FsOXkzZWowakhTSjZ1RUVUY2hFTVVqdTFwYXk5V2h1cnRMMmhiN2FvUlZx?=
 =?utf-8?B?Skh2Y0h3aG5PYzAwMHRjUHZFc0VZWElZZlI5bzQ1WXlETGQ2UmNSalNmdWN4?=
 =?utf-8?B?ck4vTTBvNXhGM1IzNkNEOTlseVNjd0twdTc0R1BzL3N3MTJrRzU2cE9jR0lY?=
 =?utf-8?B?Z3Zjd2QzaGlPKzBha01NWXZSdzVkSCtpZHNGemxXdCtkd3ZUNWFoQi9tVnNz?=
 =?utf-8?B?NEQ0WW5LR2xqNXFidzY5TkFCVTFRVWJZUEFnemJIK2lyUGQ0ZU5kTlh4OEJQ?=
 =?utf-8?B?NUt4bElZM2wyWkhuMU1INCtoTHJ1RURLdkFSRUtuelhPMUVLaW82UE5KKzVr?=
 =?utf-8?B?Y29FTDZVNm1kZ2FxTmU3TXRiM0JScU1QTkxLbTM1cWc5VEdKVXlEMWFTbi9O?=
 =?utf-8?B?dWNFbEREZ1RBOHVWUzh2ZTFWdndrVFdTTC9TeUFqV1pXVlZuUi9LUkdxQ3Ns?=
 =?utf-8?B?VTh4S2s2Tm5oV3hCL0lMeXJQbFdpV2doL0dOcUxlZ0t3V3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5674.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDB0Zzh1a1ovRXRuVjhLRzZaL0EzUFRiTExkQkNMVE1FL3lTY25XZjcvNXhh?=
 =?utf-8?B?c1l1RDlTbVhqSktsYTJxUEQzV1paTitPNG9HTGNnejFodndjcUxKd2ZZWFVa?=
 =?utf-8?B?M1FZc3dpZVR3VEg4WTJ3ZGVRSDRFaVNOZUhuZWRMcnhrbFRYdzZQQUhDVXB6?=
 =?utf-8?B?WFkxYUNIdGRPSUJrYWxsc3h0eWQzYUlvdGc3ejZLOWRqWUtQVTZRNnJoT2ds?=
 =?utf-8?B?YzllaEFVcWRrQ0ZXK2Z4ekU4MVRtOVZVdUNuNzFlc1RLS1pSWlgvcHNzcU5Q?=
 =?utf-8?B?cStHVG0xSzhLdnBMdzQ5SkJtUXBzSnJnVDJFaExYMXY1TnVUYkMxTlYzVjhS?=
 =?utf-8?B?WkRmNXpnQld0K0FUQ0poa3Vjb3FuTTZnSk13cnlVSndCcHRVRS9IUjVMWjQ2?=
 =?utf-8?B?YU9PSGozZU52SHhtazZlb1ZkREpMTjZqQWdYWDdGWTJVWFd5ZEdhSHk0TE1E?=
 =?utf-8?B?TG1YZE1zbWFIZmIvNDlHMGp2YlNGcllXMUNSczBQT0FqaWsvSWhDam5ad1VZ?=
 =?utf-8?B?N1VtV0tiSmFHd1RSTnhpRlhRRGgyOXVLb1ZwNjVIRnZwcGxWRWxTRDh5K0tU?=
 =?utf-8?B?UjRJMkppMzdzODlqdTAySFFsejJ0UTZsSmwyM201bnBZcXpEa095Q3JXMU5h?=
 =?utf-8?B?am9TQlVZekVrYXhGSnhHNUZXeDJkRXpKT0V5bDVZZjhad3lYdWVCY0Q2Wkkx?=
 =?utf-8?B?S0Q0YjUvQ2w5dGZaSUU1cGQ3L3QzaFJwbGNKRGJUcVQvOGpmMm1ISmFjZEFP?=
 =?utf-8?B?Y2d3MXYwRmtXNDVIR2x3ZU1iNHQxMnIyRVJncWZUeDJreGJEVXpSeFlGb0Vp?=
 =?utf-8?B?VllBYlFiUXdVZjYwbmk1TW40cXNtMm1NdjRrY09veWFGcUZnWWxvMkVhY1lt?=
 =?utf-8?B?d0lBc0Q0SXRJN281UlM0NVAxZFo3ODFTcDlnTE1rNUtPdlIwZlZ3TFpzc21v?=
 =?utf-8?B?Y2Z2Z3dhQS9MenFMdm9PK25zSU1KV1plemxLc2VYMUMvRXRXTE9nYjdVbUZV?=
 =?utf-8?B?L3lkQXZjZUdDRWtVSjdQK1piSnhCQm9ZdXQ1K21LVTd2c21jcDZBc29WeFhZ?=
 =?utf-8?B?S2lvNHVBRjRRVUhCSWtEVnJza0wzeHVLbWRvVzZSVmtPZ1hWYUg4TzhoWDdq?=
 =?utf-8?B?VndCU00xU1Z4YWU1TEpGbUtnaEpmMVppTWxvdVNsdzZHdjF4MFVHWGNtZXVu?=
 =?utf-8?B?T1dPK2F5TnhZaFJ0UkxFK2lpd0tjN0JzSnFKdXVadkRlSWs5WEZmYlR6WFJJ?=
 =?utf-8?B?TWsyTG40NVZ4dVN6elRJK0IxckphRVhGV2QySHNleFd0bXM0dCt4YUdnamlp?=
 =?utf-8?B?eU9rN3dOdEY1L0pzTHpvTWNzUDZYQmgwekpaallnV2hxWUFlMktPS25hNE5D?=
 =?utf-8?B?cWx1QzJYTitCbTdwcEc4ZGtHUGFHSml0TlN2STJMYk5VYmxrbFV2RzlwT0lZ?=
 =?utf-8?B?Y08venQ3cnBTZ2dmamhSLzV5alhQYjJGeVcyRkFqR0N1ZDRZT2Y3Z3RRV2dV?=
 =?utf-8?B?TWd1WVIzWnBTV1llUnBITXNSdW5qVkNDV2VUU0NzeFlJYVNuTVZOMVhDN3d5?=
 =?utf-8?B?K3c2cXE5STVBTWlHSCtXV3JkNWlLdXJ3aHNsMUdhYjJmYkozZmNiNC81Yy9O?=
 =?utf-8?B?TXhQQW1RRFNKRkptM3pHeVFNZzVHWUttbVBJelNaK29kZm0rK1hwUzJhck04?=
 =?utf-8?B?cmZBYUZUekhQbmJ3THNJeHdWUXlWNENPcFo5VXdDZzl0TVhTVUdxT2ljdmJn?=
 =?utf-8?B?eGU1Y2FjQ3ZyUk1lemZaK3B2bDJtOVJYR2Z1UUtRM2FLaGlNVDM5WW5QYXFp?=
 =?utf-8?B?UmxPZVBtT2Q5T1dGY2UxcUVVb3FFOXk3TnZwS3IxZ3hlWHRuNXE1cFlkamZ6?=
 =?utf-8?B?dTBuSU42MXF3UlIybng5S1M3azJWRVl2bjJ4Q3VVZVlnQng1amVINm9ncFd0?=
 =?utf-8?B?OEtDK1dsNEMyOFV2Y24yenh4VWpUOEN5aWU2UHM2YmdRVGkvSldCWlRRQmNq?=
 =?utf-8?B?ODRJYjFCU1I4cm05U21yUWtPMysyOUlTalF5ZFlPMGY5UWVjbDBkV3V5K3N2?=
 =?utf-8?B?NDVOYmNWa1hEZURqa2xQbVgwcmhjTFJkdGpubmZ1UlJFSk9wNyt6SG0vMVNr?=
 =?utf-8?Q?wxeIR5MnogNsYCS7PIV9TsNye?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 139a2c74-2e50-4f8f-458f-08ddecded8a8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2025 00:46:42.2386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BAyTaf34ChaL2hBlg9fquSemJAn3XHcvWsQaa/8ZiNYcIgxZWGYKXcDWQ38ZFOBm82bNNlUgI03tI0jmGoZysA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8962
X-OriginatorOrg: intel.com

On Fri, Sep 05, 2025 at 05:48:42PM -0400, Yury Norov wrote:
> (Actually adding Philip in the list.)
> 
> On Fri, Sep 05, 2025 at 09:18:50AM -0400, Yury ooNorov wrote:
> > + Philip Li <philip.li@intel.com>
> > 
> > On Fri, Sep 05, 2025 at 11:29:22AM +0200, Miguel Ojeda wrote:
> > > On Thu, Sep 4, 2025 at 8:02 PM Yury Norov <yury.norov@gmail.com> wrote:
> > > >
> > > > Added in bitmap-for-next for testing. Thanks!
> > > 
> > > linux-next breaks with CONFIG_RUST_BITMAP_HARDENED=y:

...
 
> > Thanks for the testing, Miguel! I've folded-in your fix and added
> > your co-developed-by tag. Please let me know if it doesn't work for
> > you.
> > 
> > Philip, is it possible to add CONFIG_RUST_BITMAP_HARDENED=y/n in your
> > testing too?

Hi Yury, got it, I will add this coverage in the bot.

> > 
> > Thanks,
> > Yury
