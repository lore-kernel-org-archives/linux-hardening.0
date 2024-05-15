Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37D6320B
	for <linux-hardening@vger.kernel.org>; Wed, 15 May 2024 02:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715740901; cv=fail; b=P7cHmCKgPT68N8WkgdMnUoJBARrjqSQYHJnt2pX0pafEbl4Srt9sTvl88Yj0lcgiRgiNSBY+foXHekt9IdKErHEMT5DLvxiDy4kCUStQimtH47goBBpWkpOTqAEZjH3VQwcacTuF5zhHZxt7fRiPt8cBWBj2Pvf9bHGO4NKXu5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715740901; c=relaxed/simple;
	bh=aEdOZb88YwT8/Mmy1p3Qhr9VL5fGBBv6F+skSsDIUKM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=HrOSle7EFxz6hKRT4zpM36ci1zGmV7GuHZWDXBb45CaMpNMukmtiQOuv0yyl4aM6kVa57dHT4xnmKqQFDemSLT3vfDOfBFjMGa24VX5lJ3WgbPbYDbPZLDsdM0LAhiZGRTlS6KD7bcTdq5Nrm+XAllnfheeHCAGcQrvxUogoR44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XOYXZVTY; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XOYXZVTY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715740899; x=1747276899;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aEdOZb88YwT8/Mmy1p3Qhr9VL5fGBBv6F+skSsDIUKM=;
  b=XOYXZVTYZnFecQlg2D3oxT8hm3sEoLchRpvL+5nBvK6zJ++GnuIEo241
   K1fPYvGvRvG7BH+2nvovUN4Df9OJzZPy1YiHURziG3AF3UKsdG/9lUW2r
   hxIPGoT9GO0TZPkrx4Bk0uvjDrnVi7vpsuA3aQkDQYpbO9TCBV1Oe4dRe
   nuIgvU7uDpih5x0mHE8dVMQrQ+vqPHIVEUtwyBRV89Hzoo5pqBwSkhkS6
   v6BQRJo7Itb3+qKZarysnCHa0FDyYPyUlSkNCGOiM+BLRVQUz8UhBRkPT
   J8HjlpuFnTdN/oo4A4cn39SgI75SiA+jzIslKybMjgfnkvq8t3oO4+Auf
   w==;
X-CSE-ConnectionGUID: C7w4zFkkSQuQEfN+FAC3Hw==
X-CSE-MsgGUID: VjhOpIyMTz6rJs/59iuO2g==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="22434020"
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="22434020"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 19:41:38 -0700
X-CSE-ConnectionGUID: 32puo5q8SICgyyIsdJ+VHQ==
X-CSE-MsgGUID: T0SH/8L0R8qFpuXc0sOqKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="31476034"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 19:41:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 19:41:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 19:41:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 19:41:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWPElXIFE4jqfCrGKDXal3U1AbqnWxfbrT2m7uFDOKqPmdDKRVNYVngsjdnRx1QOM3DdFl2yEVhuIo+lt8pKlre//zGVtLRDrjJ1ysxBfh8AMFGur4x+5devfVt3CxrsKA6YJBk0WlhJ/dWRAs0+mksybS822s2gArBDBvuacRLNRueP/F+7Zxh4q+XXGPKQlNNjbeBOnWSD/Qo58vV6PB4mswkSSdWDkAAbJkdgfgTTLzOadwkLNScEIFM66XwJ2HjVeMtzGa77nNqMY6LFhC0GXGFhWcwwzuuetLi2GE3xDPyrnZT7zB3ojOENVuJStBWF5zk4BcGckzpq5AoWZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMC9WHZ4JpU9purl8APFlvydf4ohy7PFes9scqDU5DY=;
 b=jyAOVeukE6pO9nnHLgGccscqU2SW9KgEw5yJ+7mmKW/hBeyb88M3W6bdGvZ8DOj/Hr9lgiQwt6zAyA7zwnYwlsidVDwmV3Qs6k72NaPt8lxjllaQ9pR687vqp6TuUZWBNHcZyNablBuU6VkYklu0mV75A+Htm+KOe3Dg2gBYA9tov885i6IZD17n3VKDr+Onh23yFbbyT+IcgzTY7uZ5X1Fdyo7TIdq146kFlikghDhxO/Aqre844oROA8F8kADFhbFbZf0E1eVtceLdNv/1tCznZcidb6xjGWqI3iughHdmv2XrhDihhtqs/CcR+vkoU/aVbq0UeYUsUdUXMBxmQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB6938.namprd11.prod.outlook.com (2603:10b6:930:5a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 02:41:34 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 02:41:34 +0000
Date: Wed, 15 May 2024 10:41:19 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Suren Baghdasaryan <surenb@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, "Kent
 Overstreet" <kent.overstreet@linux.dev>, Randy Dunlap
	<rdunlap@infradead.org>, Kees Cook <keescook@chromium.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Alex Gaynor <alex.gaynor@gmail.com>, Alice Ryhl
	<aliceryhl@google.com>, Andreas Hindborg <a.hindborg@samsung.com>, Benno
 Lossin <benno.lossin@proton.me>, =?iso-8859-1?Q?Bj=F6rn?= Roy Baron
	<bjorn3_gh@protonmail.com>, Boqun Feng <boqun.feng@gmail.com>, "Christoph
 Lameter" <cl@linux.com>, Dennis Zhou <dennis@kernel.org>, Gary Guo
	<gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo
	<tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Wedson Almeida Filho
	<wedsonaf@gmail.com>, <linux-hardening@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [mm/slab]  7bd230a266:
 WARNING:at_mm/util.c:#kvmalloc_node_noprof
Message-ID: <202405151008.6ddd1aaf-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KL1PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB6938:EE_
X-MS-Office365-Filtering-Correlation-Id: c80b79be-b351-48d6-5949-08dc748888fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9PlaPE+UWtrjRt5GdanG3DIdq6JGNgriHJ0fBcZ/fVv+qjjd1uu3Im/eUFI/?=
 =?us-ascii?Q?r9zYfosozGZPX+A1NLhJLtZNYC7voehPDu9/3xxFDaxQ7GsqvGz1/qjeU8Pb?=
 =?us-ascii?Q?2bbrj5f6M3u3c3G7260T8ezgK4gDPkMqeXXgCXFO5vW1TfnFb9QOn8OeECGU?=
 =?us-ascii?Q?zCExMU9q34rGxpv5X4nN5pHyJTDmRkcs0OTpcGCLzuqyb3ggqsKSku+rBmUf?=
 =?us-ascii?Q?Od5pB462/2IofT9Qgul9BHCEx9CrDZepQKvn0vaCf1QdFG8CsNqdnvMJdVoQ?=
 =?us-ascii?Q?dGV89Wkt2RS++Bnh1fh05VWuDplta2isu9VFPREC6kNqwVXuvCkqThAVMUbM?=
 =?us-ascii?Q?WwHFcuku9Z18hrvYLLkaDo11CG3Z49T5kvp+fa71JddW+VdYrnJ/ibEYF74b?=
 =?us-ascii?Q?sDVHwwkhuXdd1oeIm1RldJoAAbpIbJ3E/6wOBPe4Sxjk9dpQj1IlLiWmLsHP?=
 =?us-ascii?Q?gwZSY407ddis52PHIh/GcW0qkt7DW2lvdu1bx4Zu/hT58/5w0vB9gV5gmqGu?=
 =?us-ascii?Q?VXzhy9vFRYNrV2cAwSb2v/SdD0Lb5PXwPLk2STRnxS4YKONox5pVoO0W96uW?=
 =?us-ascii?Q?G1WpfRbO0XwHgSFl4CZu/Au+4jCL/ANSB4SVq1+pA2gqTKPc11XE9F0p5B3H?=
 =?us-ascii?Q?KpJkn950ZUo5lYJn4PxKmLCX7Z0QYYsCv38gNekA0Moss6u35P1Bo5i0QDBK?=
 =?us-ascii?Q?3i4uMKnMVeq6xFYFuPQgC2XpxdVrhpcu2OHLGLzGghTOtolHclCfhlbErEO3?=
 =?us-ascii?Q?R5/yPB+OWJsrtHqYMZwdZYyAxVJ5gPN1sQNfcDL3xDr3XZ/9reMs38WpWeHY?=
 =?us-ascii?Q?1cO6f0Z3HpLetAOU6pyNsUaVUCZRkMlBXZ8q4ldo21ak6BTllO9ysS897GZB?=
 =?us-ascii?Q?rqdoi4iM5j+3Y5dXlOHFBrHZkVy3G4yYDzqQJBr8XkDD/ueSAXdG7dRVYEVM?=
 =?us-ascii?Q?lBfynhaMUG6r4iPhEOraClzRjoT7jsJunIBaPn+tk6oYcUFXvz1YZNeZURSi?=
 =?us-ascii?Q?DmFOkjFGDQep+7aSRYfZMIqu5aciL2q+ECfTjNSk4Y9j442Eg1TJa1+e5gdo?=
 =?us-ascii?Q?B9+Q35/2p/N6ow9JFV74enfhKkbV4I7CGeOR01rIcx6/4Jt3IxYbfScKiFaK?=
 =?us-ascii?Q?3fZ2sCIWziye+c5i7SL6TfuBgFFvVkCdjs5gnVXOjWpbOBZ/DgPRu92wIMCv?=
 =?us-ascii?Q?1m/3isBLxJxUGBUAvMWUyvlX3IIqI9CfAQPZ75JpJdE4nAG4iOyp6ozLVfM?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CMVh2Mk9y1BWtaZC5nFW0Ge+RxzX/OEbxTCp81FYGi+0ZOonw3mOAZBDgdWl?=
 =?us-ascii?Q?C+TmV5oFfC0kG6dzktlvz3Zqcf/SK8afFlts2r9cIiz5y+nYU5oxrqjGTS8I?=
 =?us-ascii?Q?h6UOSI4ozqyWizW5VaMgY/t6VOd0GzU+g/HI4g0hWXxPLex0ReF7XRC4qI0W?=
 =?us-ascii?Q?S9EjCqI03e5D7xrNc9SC5gGGl6HRB0sotKhsGFpDRtPrg5sa77weoT0jlbtX?=
 =?us-ascii?Q?6NMn3xKLF6CZFAncI7fmYr55TKczLYvhNpcr8FOVwqEmly54puCnD7h0e8M1?=
 =?us-ascii?Q?2BJumqQWyzp0jbb84D5CDOBRT/hXeerK4HTyLI+IgEbQX8WRbXjDfHi+S0vQ?=
 =?us-ascii?Q?EziRWpEY5Y46dHYuhxpBGFGviR2ly4GdedYdXF4Fv8LwDhhbKUVqDIh3wATb?=
 =?us-ascii?Q?uzrCyJPmhUmfuabunSP+Y8SzgZtBc+vgGbYXCiOPBu4e9NNlvT+pmX2Weu6c?=
 =?us-ascii?Q?kdVTXDuS24+jlI+4AAbL/Z3gHGi0OafyShQKUZhXkeGmkYy87bo6L7jVSiWI?=
 =?us-ascii?Q?TNpsTeIVBSazS9OLK5sZhphmYgMEfj01tLORKbodrhQEwTEDBcAE1QIfGRWE?=
 =?us-ascii?Q?P2N2LHvlbsQB+pcsxXnMj+XF52BbCUSkqdcX/Se9HqFMC0w40FznrxTDi76c?=
 =?us-ascii?Q?B81hfyKDX5LofEFsu/90rqNsoX41B1wf7fyh1CQw54/DMf5GyPK2Dmn3nWLg?=
 =?us-ascii?Q?f94InwIBemN0aaGhyrh7/45O/zLc+cjIOaA+XB3YXz0Srfecg907Qz4qPclt?=
 =?us-ascii?Q?ng7IRCrMp2t6iUq5UNY4ApXRIlXD6IHINzB1EmlEM352gnjkz4exq6l5op7f?=
 =?us-ascii?Q?ADCOh9lMJrCmnlkV76ONzqib1fXiiIRhxey48dOKYTNfIyVDdSSHOiIv3bBu?=
 =?us-ascii?Q?/XEWO1EKHJNRnTzOKVCqoeC8n/5ujzkIRcdaC/2rnCZmp4aj+orap5rPe0JN?=
 =?us-ascii?Q?Vq+TUSd/k4IjC1syCaJRxe/30GgGmT4+nTWwQF1ccFsA5HikG81bnMPvgQxy?=
 =?us-ascii?Q?XY/shgp7JgNT/lhFC9z49oib67xbq67TadqqQQzWKBfFrq9v5osgtgzG6FKV?=
 =?us-ascii?Q?QHT21OfKbFrAklt1u5p0Q6fmHdMFQ/lrZL/pISdt/D8cX376i8YK+sUu0C/x?=
 =?us-ascii?Q?NLuQgZvQ1kGLOXAotUpICXR2a/fqARmVbFVgBJaoAP8Xpw1Gb8RXhw7f76gP?=
 =?us-ascii?Q?yaxCIvIPY4/WzEHTF24FyTe1U8zKr90u35fGkNNQE0LBmAc/IB3BZKDryJAR?=
 =?us-ascii?Q?tNKYXccVPw0ojQoNcjEEYcMJZmyFs0U1zbCw77XvjwFDgPy5M7nDMfezIR2w?=
 =?us-ascii?Q?ru4z+TdUaOCFxaLhDEQmqT7JHy5uALrR2uT4o1C8lx2LdRxT4z4YflGhyEYT?=
 =?us-ascii?Q?0D7SQgaCGRs/cQhyK6VG7/Kbv++3bmSDGp9h+m7uuEu/3ydr7SC1Un8lnfX/?=
 =?us-ascii?Q?HM1LT5M+6V29jbfXUQ0TbMS7Bp9cPAjRNzinGlLcPJsu1Xw8t1wpZlWJs89C?=
 =?us-ascii?Q?ccXv3FaLuK7GI9C+Jny0rpJgdFrarG6pDXvuRIGDrVARxloqvbZTJyq3/F1X?=
 =?us-ascii?Q?OezWPL66TbHzjIbpjf2Y2JqiSUYe3F9fgyeameD2DTEfXOOvew2KGFlYkvTJ?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c80b79be-b351-48d6-5949-08dc748888fd
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 02:41:34.5563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2etQd2A74wyvT37D7UJlNtIumBS6C0qTfq3W1EoPQ4miz1LWGfVZ321WWoxnk35EwIaZLL7sPWDQNXzrEt/zkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6938
X-OriginatorOrg: intel.com



Hello,

as we understand, this commit is not the root-cause of this WARNING. the WARNING
just shows in another way by commit changes.

53ed0af496422959 7bd230a26648ac68ab3731ebbc4
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
          6:6          -83%            :6     dmesg.RIP:kvmalloc_node
           :6           33%           6:6     dmesg.RIP:kvmalloc_node_noprof
          6:6          -83%            :6     dmesg.WARNING:at_mm/util.c:#kvmalloc_node
           :6           33%           6:6     dmesg.WARNING:at_mm/util.c:#kvmalloc_node_noprof


but we failed to bisect "dmesg.WARNING:at_mm/util.c:#kvmalloc_node".

we still made this report FYI what we observed in our tests, not sure if it
could give somebody some hints to find the real problem then judge if a fix
is needed.

below is full report.



kernel test robot noticed "WARNING:at_mm/util.c:#kvmalloc_node_noprof" on:

commit: 7bd230a26648ac68ab3731ebbc449090f0ac6a37 ("mm/slab: enable slab allocation tagging for kmalloc and friends")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 6ba6c795dc73c22ce2c86006f17c4aa802db2a60]

in testcase: igt
version: igt-x86_64-86712f2ef-1_20240511
with following parameters:

	group: gem_exec_reloc



compiler: gcc-13
test machine: 20 threads 1 sockets (Commet Lake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202405151008.6ddd1aaf-oliver.sang@intel.com


[  940.101700][ T5353] ------------[ cut here ]------------
[ 940.107107][ T5353] WARNING: CPU: 1 PID: 5353 at mm/util.c:649 kvmalloc_node_noprof (mm/util.c:649 (discriminator 1)) 
[  940.116178][ T5353] Modules linked in: netconsole btrfs blake2b_generic xor zstd_compress intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common raid6_pq libcrc32c x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft ipmi_devintf crc64 sg ipmi_msghandler kvm crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel i915 sha512_ssse3 sdhci_pci drm_buddy cqhci ahci rapl intel_gtt drm_display_helper sdhci libahci mei_me ttm intel_cstate i2c_designware_platform ppdev intel_uncore intel_wmi_thunderbolt wmi_bmof libata mei i2c_designware_core idma64 drm_kms_helper mmc_core i2c_i801 i2c_smbus intel_pch_thermal parport_pc video parport pinctrl_cannonlake wmi acpi_pad acpi_tad serio_raw binfmt_misc drm fuse loop dm_mod ip_tables
[  940.188041][ T5353] CPU: 1 PID: 5353 Comm: gem_exec_reloc Not tainted 6.9.0-rc4-00085-g7bd230a26648 #1
[ 940.197459][ T5353] RIP: 0010:kvmalloc_node_noprof (mm/util.c:649 (discriminator 1)) 
[ 940.203412][ T5353] Code: 04 a3 0d 00 48 83 c4 18 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc 49 be 00 00 00 00 00 20 00 00 eb 9f 80 e7 20 75 de <0f> 0b eb da 48 c7 c7 10 ec af 84 e8 0e a6 18 00 e9 3f ff ff ff 48
All code
========
   0:	04 a3                	add    $0xa3,%al
   2:	0d 00 48 83 c4       	or     $0xc4834800,%eax
   7:	18 48 83             	sbb    %cl,-0x7d(%rax)
   a:	c4                   	(bad)  
   b:	08 5b 5d             	or     %bl,0x5d(%rbx)
   e:	41 5c                	pop    %r12
  10:	41 5d                	pop    %r13
  12:	41 5e                	pop    %r14
  14:	c3                   	retq   
  15:	cc                   	int3   
  16:	cc                   	int3   
  17:	cc                   	int3   
  18:	cc                   	int3   
  19:	49 be 00 00 00 00 00 	movabs $0x200000000000,%r14
  20:	20 00 00 
  23:	eb 9f                	jmp    0xffffffffffffffc4
  25:	80 e7 20             	and    $0x20,%bh
  28:	75 de                	jne    0x8
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	eb da                	jmp    0x8
  2e:	48 c7 c7 10 ec af 84 	mov    $0xffffffff84afec10,%rdi
  35:	e8 0e a6 18 00       	callq  0x18a648
  3a:	e9 3f ff ff ff       	jmpq   0xffffffffffffff7e
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	eb da                	jmp    0xffffffffffffffde
   4:	48 c7 c7 10 ec af 84 	mov    $0xffffffff84afec10,%rdi
   b:	e8 0e a6 18 00       	callq  0x18a61e
  10:	e9 3f ff ff ff       	jmpq   0xffffffffffffff54
  15:	48                   	rex.W
[  940.222971][ T5353] RSP: 0018:ffffc90000b576f8 EFLAGS: 00010246
[  940.228978][ T5353] RAX: 0000000000000000 RBX: 00000000000000c0 RCX: 0000000000000013
[  940.236885][ T5353] RDX: 000000000007ffff RSI: 0000000080000000 RDI: 0000000000000000
[  940.244792][ T5353] RBP: 0000000080000000 R08: 0000000000000001 R09: 0000000000000000
[  940.252700][ T5353] R10: ffffc90000b576f8 R11: 0000000000000000 R12: 00000000ffffffff
[  940.260626][ T5353] R13: 0000000000000000 R14: 0000000004000000 R15: ffffc90000b579a8
[  940.268566][ T5353] FS:  00007f2043c5e8c0(0000) GS:ffff8883ee080000(0000) knlGS:0000000000000000
[  940.277455][ T5353] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  940.283988][ T5353] CR2: 00007f2043b5d000 CR3: 000000022f74a002 CR4: 00000000003706f0
[  940.291922][ T5353] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  940.299872][ T5353] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  940.307791][ T5353] Call Trace:
[  940.311021][ T5353]  <TASK>
[ 940.313926][ T5353] ? __warn (kernel/panic.c:694) 
[ 940.317930][ T5353] ? kvmalloc_node_noprof (mm/util.c:649 (discriminator 1)) 
[ 940.323187][ T5353] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 940.327596][ T5353] ? handle_bug (arch/x86/kernel/traps.c:239 (discriminator 1)) 
[ 940.331835][ T5353] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
[ 940.336419][ T5353] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 940.341348][ T5353] ? kvmalloc_node_noprof (mm/util.c:649 (discriminator 1)) 
[ 940.346602][ T5353] ? kvmalloc_node_noprof (mm/util.c:640) 
[ 940.351795][ T5353] eb_copy_relocations (drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:1685) i915
[ 940.357636][ T5353] eb_relocate_parse_slow (drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:1815) i915
[ 940.363616][ T5353] i915_gem_do_execbuffer (drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:1960 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:3466) i915
[ 940.369790][ T5353] ? unwind_get_return_address (arch/x86/kernel/unwind_orc.c:369 (discriminator 1)) 
[ 940.375305][ T5353] ? arch_stack_walk (arch/x86/kernel/stacktrace.c:26) 
[ 940.380084][ T5353] ? __pfx_i915_gem_do_execbuffer (drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:3359) i915
[ 940.386673][ T5353] ? kasan_save_track (arch/x86/include/asm/current.h:49 (discriminator 1) mm/kasan/common.c:60 (discriminator 1) mm/kasan/common.c:69 (discriminator 1)) 
[ 940.391449][ T5353] ? __kasan_kmalloc (mm/kasan/common.c:370 mm/kasan/common.c:387) 
[ 940.396121][ T5353] ? __pfx___might_resched (kernel/sched/core.c:10152) 
[ 940.401339][ T5353] ? check_heap_object (arch/x86/include/asm/bitops.h:206 (discriminator 1) arch/x86/include/asm/bitops.h:238 (discriminator 1) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 1) include/linux/page-flags.h:527 (discriminator 1) mm/usercopy.c:194 (discriminator 1)) 
[ 940.406359][ T5353] i915_gem_execbuffer2_ioctl (drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:3612) i915
[ 940.412769][ T5353] ? __pfx_i915_gem_execbuffer2_ioctl (drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:3572) i915
[ 940.419658][ T5353] drm_ioctl_kernel (drivers/gpu/drm/drm_ioctl.c:744) drm
[ 940.425039][ T5353] ? __pfx_drm_ioctl_kernel (drivers/gpu/drm/drm_ioctl.c:729) drm
[ 940.430914][ T5353] drm_ioctl (drivers/gpu/drm/drm_ioctl.c:842) drm
[ 940.435660][ T5353] ? __pfx_i915_gem_execbuffer2_ioctl (drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:3572) i915
[ 940.442610][ T5353] ? __pfx_drm_ioctl (drivers/gpu/drm/drm_ioctl.c:763) drm
[ 940.447822][ T5353] ? __fget_light (include/linux/atomic/atomic-arch-fallback.h:479 (discriminator 2) include/linux/atomic/atomic-instrumented.h:50 (discriminator 2) fs/file.c:1145 (discriminator 2)) 
[ 940.452318][ T5353] __x64_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:904 fs/ioctl.c:890 fs/ioctl.c:890) 
[ 940.457008][ T5353] do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1)) 
[ 940.461440][ T5353] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[  940.467236][ T5353] RIP: 0033:0x7f2046007c5b
[ 940.471588][ T5353] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
All code
========
   0:	00 48 89             	add    %cl,-0x77(%rax)
   3:	44 24 18             	rex.R and $0x18,%al
   6:	31 c0                	xor    %eax,%eax
   8:	48 8d 44 24 60       	lea    0x60(%rsp),%rax
   d:	c7 04 24 10 00 00 00 	movl   $0x10,(%rsp)
  14:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  19:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
  1e:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  23:	b8 10 00 00 00       	mov    $0x10,%eax
  28:	0f 05                	syscall 
  2a:*	89 c2                	mov    %eax,%edx		<-- trapping instruction
  2c:	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax
  31:	77 1c                	ja     0x4f
  33:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
  38:	64                   	fs
  39:	48                   	rex.W
  3a:	2b                   	.byte 0x2b
  3b:	04 25                	add    $0x25,%al
  3d:	28 00                	sub    %al,(%rax)
	...

Code starting with the faulting instruction
===========================================
   0:	89 c2                	mov    %eax,%edx
   2:	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax
   7:	77 1c                	ja     0x25
   9:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
   e:	64                   	fs
   f:	48                   	rex.W
  10:	2b                   	.byte 0x2b
  11:	04 25                	add    $0x25,%al
  13:	28 00                	sub    %al,(%rax)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240515/202405151008.6ddd1aaf-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

