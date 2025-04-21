Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF1C2D613;
	Mon, 21 Apr 2025 20:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745268312; cv=fail; b=uUYEF9BmLsIjpzxfDOBGG2K+DyTiz7wQ6rLth+neByyTUPZ4X2+IMLGW4HgK2bNfd7pBQ8eRVP8jlIJJn7IkqqfakQf6kM/VaC5PgtHFlOGORwcARzH5smHc2DmLqkfDQXuQcp/d+S+RBCenRMqluvctFkO2qx+rJp+oojh9lAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745268312; c=relaxed/simple;
	bh=kfia1c5JRG3TCYtyOXUfPZBLYDZOzoAxp752euuQ/UU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ox/9Z1+1i9jHuywz9c+kHdpdhUNEHtoh97Pi2yt3FzKkkcT+Xwa8bmmKTP5l5yMBWRhKLTLwJgSfr1ocOKUKoELFC44MiO26FX9iz7s1kcbvmPisVVy7+VNp0OekUPaJr3rl/zU/Ns2XvP+M7pYlk/lSRZtULYTG+lj8Zi37rw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oxQS2wAv; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oxQS2wAv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywpuBYnPbVOc2OEstfZxwkcvAqbYctY98pMfKKKtVwid9G1mb9YT4oq5NFrnEZuBjaTifiWTEBxS4Lbc3TX1zyVzYr4wsADAOj4wGEKwCvvS08R2OKhH5pM+2urm55Pdx9T/0gc04VXELdsoV16r9N5rEdEDZwY1dEEloelGnFTISsw1PACHOl5rAjJ1hx9laPhFfMTvHbUdlQC1sIdZz+1/qzovRAr92316kLs07tJ7aBzJ4SQUBWgRsJWyLC1VJksFDujqQ8E8Had0RFUOxrVv3n4OEItAMuPr6lf8Kp27M8dFEPVLPwqWVkB3tAdsw0PeHs2pgIJ3EG3Wr0TNRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RoYxPOue4KJ7EuG+3LsJriuSqg/ihpaHVqhv7eFUlrk=;
 b=Kvt3oXch3CYjDHoUgiEqJygD6gLt6Bi6HG8t1Rn8L9ocQBmtPp9rzQ0p4GqxIpnT67veLD71SI3+P/aw1Jc3wNZyIhB7QXgkiIGLaBbIl3eKNqMdVWA6mqe5c+IdpiuzyEwKBPhcrjELKEt6/SsLWEvR8ANP8DvXJYpsoXWmhjK/8OopwfdK8IgVw1Vna4zyq4xqmYoB8k6knLa2KRrc+i3mgLVuttP4obUn6SLFwl+X1vu2Ma+DUDJNCa1uJcgEQ1Q5VcEUUPeDx/LGigDs8J73Qeex2Uv9kCMyOlomgRYmMgoveXHJ6F0R1XpJko0+M/7dk/v0W2JTDIkKRKCn5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoYxPOue4KJ7EuG+3LsJriuSqg/ihpaHVqhv7eFUlrk=;
 b=oxQS2wAvkXFvFmYGtxRMWO1rLmcSqa1Dj/h3mKjx1wxoi1FmIeq1SMg58acTP5GybTDx2JqvV7599bak4XtpfHxmwNGsrKTbteA+sezEx2RXh6jkwUZU9tUctMtUIapjbDiueiNQQF59J7nn4CWp1KA0BpN9cbpSa7WnOn4nVEM=
Received: from SN7PR04CA0169.namprd04.prod.outlook.com (2603:10b6:806:125::24)
 by PH7PR12MB6693.namprd12.prod.outlook.com (2603:10b6:510:1b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 21 Apr
 2025 20:45:04 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:125:cafe::e5) by SN7PR04CA0169.outlook.office365.com
 (2603:10b6:806:125::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.33 via Frontend Transport; Mon,
 21 Apr 2025 20:45:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 21 Apr 2025 20:45:04 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Apr
 2025 15:45:03 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <bp@alien8.de>, <thomas.lendacky@amd.com>, <hpa@zytor.com>
CC: <kees@kernel.org>, <michael.roth@amd.com>, <nikunj@amd.com>,
	<seanjc@google.com>, <ardb@kernel.org>, <gustavoars@kernel.org>,
	<sgarzare@redhat.com>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>
Subject: [PATCH] x86/sev: Fix SNP guest kdump hang/softlockup/panic
Date: Mon, 21 Apr 2025 20:44:53 +0000
Message-ID: <20250421204453.318557-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|PH7PR12MB6693:EE_
X-MS-Office365-Filtering-Correlation-Id: dde17484-9306-430b-f976-08dd81156509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?djrII6G7bm82YOpQe97PqQJQ8jVtzZ1qkIc5A+E2dU8gp/jD0U3YLId/3aMV?=
 =?us-ascii?Q?QhW0AMRWosd3o6vSZuFzKi35Rs7cNCTy2lbJlG4iv9wIPY31MV5NK4xzJvns?=
 =?us-ascii?Q?M3yiLcMb5uD7MbnfakpPxq9ppDpiT4vwXcAGe2WPp0p/WwEGbMPed4i59ak/?=
 =?us-ascii?Q?13xIzrIOv+GXzhCqPDwTkjjaSsqP4+X3fycnMk85MCBNqiXR2qPZqzbqHqiy?=
 =?us-ascii?Q?YvaT3/dI9QyNTe4oV/5mktJtVXNn/VtuQi0Tiyr5xU9OIR+KcPFMFQS0cfa2?=
 =?us-ascii?Q?I+5njwGKy6/J42Qm7woGobJTU8EaJTH+RcNdUuscAY64E44x0GVZOsAMF/j/?=
 =?us-ascii?Q?qP1K7FGquJ3c5lvSFBOJl3mqttQnV8EqWP4jXmGOA7sUDXI71uyGEezS7h2r?=
 =?us-ascii?Q?EfUVimwAR2dh1v+nrCrK8/Jm1Vy4DnIIYX3pQSBf56aG1l2abtMAKiTGQUwq?=
 =?us-ascii?Q?f77sTnmV7ICjMgV3flOYMWgMEjwr2/ex5hkrGMJCvb+14cv++d+WfpJlZ5wf?=
 =?us-ascii?Q?GCIGOfpmjB9Z2rvZ/ETzEvOqoukQU/XWaYcKH2h+2M+N0ezG7zTPUj8pyM//?=
 =?us-ascii?Q?YERIYLkd4wCMCE4Y8FEKGIxFCd5UnkiI7joqacI5DyamlGocLJinBLSCb6/1?=
 =?us-ascii?Q?/Tt1HKTeoStfLk3/dFcvGgnhgHNgvAcGSyo2xzawB7CK83kIZjfgPql5oqJC?=
 =?us-ascii?Q?NndsYCrHkOSrbSrg9/YZYj02cn24g6ja3ACz+rXWtBERfoR+HVpOo3lQbMyv?=
 =?us-ascii?Q?qZSBdNGpFbXQWxFDqEbvSqX1/i3+0K/ZgXHe8CgNooXjvv3iw2KsrH/VUV66?=
 =?us-ascii?Q?oFL/iZpYZ1w10M+3tZ4nxoDQuufXLkMKbeI4qLgG371M0ICfk7OP/2KPspmv?=
 =?us-ascii?Q?di8ZZtLZT0i0yq8Hixwu+TaXQyb+6ugSa5Q3XVJr3uDurVOWe7oy5aXLBGIS?=
 =?us-ascii?Q?v7IpKHYMAs+rpQPnpi6VJkjnYm2Tld9C7JhbjYiRr/6yRbnA0lP9zA88XeLe?=
 =?us-ascii?Q?0iu6aUPLdHMe5OMI1oOZeTNbKDdagftui36wNyIMpj1gAbD+J7foEsYj1w0k?=
 =?us-ascii?Q?Edf4WN4m/Uvp8Qry14HcZ4WvgmhiSMwsGcGtnKwOC0o16npspXZZSQ1FAw0H?=
 =?us-ascii?Q?iMW/mnBayMePN2EONfjsjHibNbxrBkNpW/3NVDwByNKkPs5/ClLoS2GOaKJ+?=
 =?us-ascii?Q?eIDeL1TER99F16MJ5Q1EFciFFvUG6Nrpy4lVpoN/930ziW21WYrEKzJ9KyB5?=
 =?us-ascii?Q?8dbXDxwRlo0AEK2T+3uPt/HVKS68GshQuW4fwBNTpanreiGYVO6Q/pueqbZS?=
 =?us-ascii?Q?5ctu1PSS1bVQoC+mIaok7b08jZ9tiEnvfW/5SeMUnkMozcZzy+wyoYyo6Mu4?=
 =?us-ascii?Q?aBIp79Se1bn49SfRiLks3E+3e/gij7lfaL5ZcdSA6gXvBQDY+69YhgZauVLC?=
 =?us-ascii?Q?LfTo9cDmEHzLhSxUAP5TZ4NQ7Velvj7q/hJcuXEOcOcq50ZZqzX4HeJYM4zi?=
 =?us-ascii?Q?yYnp+1QLYxIY4uAk+0LqXcC2nFx2AEc+FRMa?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 20:45:04.5304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dde17484-9306-430b-f976-08dd81156509
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6693

From: Ashish Kalra <ashish.kalra@amd.com>

[  117.111097] watchdog: BUG: soft lockup - CPU#0 stuck for 27s! [cp:318]
[  117.111115] Modules linked in:
[  117.111120] irq event stamp: 3066414
[  117.111122] hardirqs last  enabled at (3066413): [<ffffffffa04878d9>] irqentry_exit+0x39/0x90
[  117.111142] hardirqs last disabled at (3066414): [<ffffffffa0485c15>] sysvec_apic_timer_interrupt+0x15/0xb0
[  117.111146] softirqs last  enabled at (3066364): [<ffffffff9f245852>] __irq_exit_rcu+0xb2/0xe0
[  117.111157] softirqs last disabled at (3066355): [<ffffffff9f245852>] __irq_exit_rcu+0xb2/0xe0
[  117.111165] CPU: 0 UID: 0 PID: 318 Comm: cp Not tainted 6.14.0-next-20250328-snp-host-f2a41ff576cc-dirty #414 VOLUNTARY
[  117.111171] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
[  117.111176] RIP: 0010:rep_movs_alternative+0x5b/0x70
[  117.111182] Code: 8b 06 48 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 db 83 f9 08 73 e8 eb c5 eb 05 e9 2f 21 02 00 48 89 c8 48 c1 e9 03 83 e0 07 <f3> 48 a5 89 c1 85 c9 75 ab e9 17 21 02 00 48 8d 0c c8 eb a0 90 90
[  117.111184] RSP: 0018:ffffc061c16c7b50 EFLAGS: 00040246
[  117.111187] RAX: 0000000000000000 RBX: 0000000000001000 RCX: 0000000000000200
[  117.111188] RDX: 0000000000018000 RSI: ffffc061c3f53000 RDI: 00007f27a86a5000
[  117.111189] RBP: ffffc061c16c7be8 R08: 00007f27a86a6000 R09: 00000000ffffffff
[  117.111190] R10: 0000000000000001 R11: 0000000000000001 R12: ffffc061c16c7d30
[  117.111191] R13: ffffc061c3f53000 R14: 0000000000000000 R15: ffffc061c3f53000
[  117.111193] FS:  00007f27a86ae800(0000) GS:ffff9d420cf0d000(0000) knlGS:0000000000000000
[  117.111195] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  117.111196] CR2: 00007fd1278a3000 CR3: 0008000053e58000 CR4: 00000000003506f0
[  117.111200] Call Trace:
[  117.111204]  <TASK>
[  117.111206]  ? _copy_to_iter+0xc1/0x720
[  117.111216]  ? srso_return_thunk+0x5/0x5f
[  117.111220]  ? _raw_spin_unlock+0x27/0x40
[  117.111234]  ? srso_return_thunk+0x5/0x5f
[  117.111236]  ? find_vmap_area+0xd6/0xf0
[  117.111251]  ? srso_return_thunk+0x5/0x5f
[  117.111253]  ? __check_object_size+0x18d/0x2e0
[  117.111268]  __copy_oldmem_page.part.0+0x64/0xa0
[  117.111281]  copy_oldmem_page_encrypted+0x1d/0x30
[  117.111285]  read_from_oldmem.part.0+0xf4/0x200
[  117.111306]  read_vmcore+0x206/0x3c0
[  117.111309]  ? srso_return_thunk+0x5/0x5f
[  117.111325]  proc_reg_read_iter+0x59/0x90
[  117.111334]  vfs_read+0x26e/0x350
[  117.111362]  ksys_read+0x73/0xf0
[  117.111373]  __x64_sys_read+0x1d/0x30
[  117.111377]  x64_sys_call+0x1b90/0x2150
[  117.111386]  do_syscall_64+0x8b/0x140
[  117.111454] RIP: 0033:0x7f27a7510031
[  117.111462] Code: fe ff ff 48 8d 3d cf 9b 0a 00 48 83 ec 08 e8 56 4b 02 00 66 0f 1f 44 00 00 48 8d 05 b1 09 2e 00 8b 00 85 c0 75 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 57 f3 c3 0f 1f 44 00 00 41 54 55 49 89 d4 53
[  117.111464] RSP: 002b:00007fff8f2d31c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[  117.111466] RAX: ffffffffffffffda RBX: 0000000000001000 RCX: 00007f27a7510031
[  117.111467] RDX: 0000000000020000 RSI: 00007f27a868d000 RDI: 0000000000000003
[  117.111468] RBP: 0000000000000000 R08: 0000000000006000 R09: 0000000000000000
[  117.111469] R10: 0000000000001000 R11: 0000000000000246 R12: 0000000000000000
[  117.111470] R13: 0000000000000000 R14: 00007f27a86ad000 R15: 0000000000000000
[  117.111499]  </TASK>
[  117.111502] Kernel panic - not syncing: softlockup: hung tasks
[  117.164421] CPU: 0 UID: 0 PID: 318 Comm: cp Tainted: G             L      6.14.0-next-20250328-snp-host-f2a41ff576cc-dirty #414 VOLUNTARY
[  117.166326] Tainted: [L]=SOFTLOCKUP
[  117.166878] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
[  117.168116] Call Trace:
[  117.168514]  <IRQ>
[  117.168862]  dump_stack_lvl+0x2b/0xf0
[  117.169530]  dump_stack+0x14/0x20
[  117.170068]  panic+0x3a8/0x410
[  117.170592]  watchdog_timer_fn+0x293/0x300
[  117.171229]  ? __pfx_watchdog_timer_fn+0x10/0x10
[  117.171961]  __hrtimer_run_queues+0x1c7/0x3d0
[  117.172603]  hrtimer_interrupt+0x126/0x290
[  117.173261]  __sysvec_apic_timer_interrupt+0x72/0x1c0
[  117.174118]  sysvec_apic_timer_interrupt+0x80/0xb0

Kdump while doing vmcore generation will be walking through all the
guest pages and copying them to userspace, while walking through
these guest pages it dumps/reads the guest VMSA pages which are
marked in-use/busy (if the vCPU associated with that VMSA is
running then that VMSA page is marked in-use/busy in the RMP table)
and touching these in-use pages causes unrecoverable #NPF/RMP faults
which causes the guest to hang/softlockup/panic.

If kdump kernel is running on BSP, then BSP's VMSA itself cannot
cause any issues, but other APs may be halted in guest, hence
they are still in VMRUN state and their VMSAs are busy/in-use
and touching those VMSAs will cause the #NPF.

The issue is that either the AP running the kdump kernel has a
conflict with it's VMSA page and additionally other APs halted
in guest mode have a conflict with their VMSA pages.

Note that even if kdump kernel is running with one vCPU, other APs
can still be halted in guest mode and they are in VMRUN state and
their VMSAs are busy and will cause #NPF when they are being
dumped during kdump.

Therefore, issue AP_DESTROY GHCB calls on all APs (to ensure they
are kicked out of guest mode) and then the VMSA bit is cleared on
their VMSA page. Additionally if the vCPU running kdump is an AP,
then it's VMSA bit can't be cleared (and that AP can't be shutdown
or destroyed as it is running kdump) so it's VMSA page is made offline
to ensure that makedumpfile excludes that page while dumping guest
memory. If the vCPU running kdump is a BSP then nothing else needs
to be done as far as BSP's VMSA is concerned.

This fix is for kdump when using makedumpfile command/utility to
generate vmcore.

For kexec, additional fix is required to mark the VMSA page of
currently running vCPU as reserved during kexec boot and that fix
will be depending on KHO/kstate patch-series which add the ability
to preserve memory pages across kexec.

Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/coco/sev/core.c | 105 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index dcfaa698d6cf..2c27d4b3985c 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -110,9 +110,12 @@ struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
 
 DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
 DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
+DEFINE_PER_CPU(int, sev_vcpu_apic_id);
 DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
 DEFINE_PER_CPU(u64, svsm_caa_pa);
 
+static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa, int apic_id);
+
 static __always_inline bool on_vc_stack(struct pt_regs *regs)
 {
 	unsigned long sp = regs->sp;
@@ -973,6 +976,104 @@ void snp_kexec_begin(void)
 		pr_warn("Failed to stop shared<->private conversions\n");
 }
 
+/*
+ * kexec/kdump should be shutting down all APs except the one handling
+ * kexec/kdump and clearing the VMSA tag on those AP's VMSA pages as they
+ * are not being used as a VMSA page anymore, so that a random page in
+ * the kexec'ed guest which remains a VMSA page cannot cause unrecoverable
+ * RMP faults, kdump will anyway reboot afterwards while kexec will set new
+ * VMSA pages for all the APs to come up. Kdump while doing vmcore generation
+ * and page walking can cause unrecoverable #NPF/RMP faults when walking guest
+ * memory for dumping when it touches the VMSA page of the currently running
+ * vCPU while kexec can randomly use this pages when it is re-allocated after
+ * kexec via the page-allocator.
+ */
+static void sev_snp_shutdown_all_aps(void)
+{
+	struct sev_es_save_area *vmsa;
+	struct ghcb_state state;
+	unsigned long flags;
+	struct ghcb *ghcb;
+	int apic_id, cpu;
+
+	/*
+	 * APs are already in HLT loop when kexec_finish() is invoked.
+	 */
+	for_each_present_cpu(cpu) {
+		vmsa = per_cpu(sev_vmsa, cpu);
+
+		/*
+		 * BSP does not have guest allocated VMSA, so that in-use/busy
+		 * VMSA cannot hit a guest page and there is no need to clear
+		 * the VMSA tag for this page.
+		 */
+		if (!vmsa)
+			continue;
+
+		/*
+		 * Cannot clear the VMSA tag for the currently running vCPU.
+		 */
+		if (get_cpu() == cpu) {
+			unsigned long pa;
+			struct page *p;
+
+			pa = __pa(vmsa);
+			p = pfn_to_online_page(pa >> PAGE_SHIFT);
+			/*
+			 * Mark the VMSA page of the running vCPU as Offline
+			 * so that is excluded and not touched by makedumpfile
+			 * while generating vmcore during kdump boot.
+			 */
+			if (p)
+				__SetPageOffline(p);
+			put_cpu();
+			continue;
+		}
+		put_cpu();
+
+		apic_id = per_cpu(sev_vcpu_apic_id, cpu);
+
+		/*
+		 * Issue AP destroy on all APs (to ensure they are kicked out
+		 * of guest mode) to allow using RMPADJUST to remove the VMSA
+		 * tag on VMSA pages especially for guests that allow HLT to
+		 * not be intercepted.
+		 */
+
+		local_irq_save(flags);
+
+		ghcb = __sev_get_ghcb(&state);
+
+		vc_ghcb_invalidate(ghcb);
+		ghcb_set_rax(ghcb, vmsa->sev_features);
+
+		/* Issue VMGEXIT AP Destroy NAE event */
+
+		ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_CREATION);
+		ghcb_set_sw_exit_info_1(ghcb,
+					((u64)apic_id << 32)	|
+					((u64)snp_vmpl << 16)	|
+					SVM_VMGEXIT_AP_DESTROY);
+		ghcb_set_sw_exit_info_2(ghcb, __pa(vmsa));
+
+		sev_es_wr_ghcb_msr(__pa(ghcb));
+		VMGEXIT();
+
+		if (!ghcb_sw_exit_info_1_is_valid(ghcb) ||
+		    lower_32_bits(ghcb->save.sw_exit_info_1)) {
+			pr_err("SNP AP Destroy error\n");
+			local_irq_restore(flags);
+			return;
+		}
+
+		__sev_put_ghcb(&state);
+
+		local_irq_restore(flags);
+
+		snp_cleanup_vmsa(vmsa, apic_id);
+	}
+}
+
 void snp_kexec_finish(void)
 {
 	struct sev_es_runtime_data *data;
@@ -987,6 +1088,8 @@ void snp_kexec_finish(void)
 	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
 		return;
 
+	sev_snp_shutdown_all_aps();
+
 	unshare_all_memory();
 
 	/*
@@ -1254,6 +1357,8 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
 	/* Record the current VMSA page */
 	per_cpu(sev_vmsa, cpu) = vmsa;
 
+	per_cpu(sev_vcpu_apic_id, cpu) = apic_id;
+
 	return ret;
 }
 
-- 
2.34.1

