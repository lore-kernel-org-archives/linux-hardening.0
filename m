Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010042.outbound.protection.outlook.com [52.101.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3D118CBF2
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 02:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054367; cv=fail; b=LPTq1PW512Kw46qkWVNrE9oH09AAoUR/yoYmCbgv6KY73LCwuA/MBYI2vfzszm3VT2Fpm1D5tu1cD3zy4XTn6TLIO533fC+37ENBKa2VVm5TFJnI8fxQC3Xq552XqGU3PXg1FAE8X7LoZ5+OBCPo/lvNdWNIxVOftHNC6ud3aeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054367; c=relaxed/simple;
	bh=Th7Kkr3O/rrtkLhJw0j3FRmu8+q2wf7ebC0bN1VL8GY=;
	h=Message-ID:To:From:Subject:Content-Type:Date:MIME-Version; b=GGvQhEp121ERZyhLIiNcrbQyBJKjVRTrzmTTfAkAjUfdLFuZUHZxdqkoq6n3kzPgSXQC2i9XBzfJrjx/y716km9Suh8mpUU0PcCeoUzRl3z8pRcJJCV/ct0w9YFTdFX01kc0F5OYJfGyzq3U9vp2yZMcBbtHsjPpHoJeCPA81Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Bj0UKeVa; arc=fail smtp.client-ip=52.101.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Bj0UKeVa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWAB4JRL33pdEpdFLHElKUi1gEMYzTrFneJjUaWeKVLQqI2vsb96/MoOD2qlacGXOBa2cCy3+SAJxJacGtfryEUunI68qXXyZZezlKdyuZvPL8C00ecC3XbfKeJiydH6BiGxfEkLDlKz8jyLq+wL8l9wYhbiPYt0oesutJzRQSbWZatSqc3QiW9gNPy8rnz51wxJVM+cyFC8EfNIqzpcz4OuxIrVyYh6QAnyxRgb1dkbpBcsZUlGNlCGsYviuQMIUa1h93ZCvTUBATywZPLZ+0eFaWM5MCpnXzJ8LZMykV354FU46h7gyvRODtVe7GZel6bcfxlyMSs0M8DTzUZ4LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQeJAW2bkVcSXglbM/IENtr9fmLa0JvChYBbc43ZPKc=;
 b=IQp1YwlkHc1xcpxDjRqbXavFad/iDMlH/PIcTCzvRG/q/b3m+c5U0y1OFDLrgMAxv2WQaXJK7B058LOexNaLDt3cLYlP30gKqyzS3UMwFjR6RBSNydG6OTlvrb0xGP0HRN7JTfwLc7KvHlU6c2eJ9RzWeKon0mC3r21ZaXCsJs3EAahSMYn8vNCYDDS6EqdMLjoldP08F0V8O81tYuHBLU4Wg48A90n+pRTsDAmav3cdlZbMqU171lhOukKsbUyCGtI9mrJkbfzDi0tVrkx8DgE1mlFO3vwD33wbmzVf12dwdRtvgpffje49Vym5o3cwrVqIuqsxMDLaWPv+YtnR4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQeJAW2bkVcSXglbM/IENtr9fmLa0JvChYBbc43ZPKc=;
 b=Bj0UKeVaO3jcjCa5loldFYNI7uegS/M8E/jpf9vdRWhaNmKtBmMasL5Ouq9ZJ97+UMB77oQDp2iFt0YJ07JMErEV07zq6yvyhELk3sRIy1TnyMiN/8NqSQGOoFkFDe1/3/UTAnMv+1o9Rd976/lD1TrsFCPEtMYmmG0WDiN5w3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYAPR01MB5914.jpnprd01.prod.outlook.com
 (2603:1096:404:8053::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 02:12:41 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 02:12:41 +0000
Message-ID: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
To: Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2 00/10] lib/string_choices: Add new helpers
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 4 Mar 2025 02:12:41 +0000
X-ClientProxiedBy: TYCP286CA0185.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::20) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYAPR01MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: 677fa374-4095-48ca-220f-08dd5ac20b1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OcyGv7wE+f6G4l7qJBo1C+MTn+WnbEGFVDOVNMC47XYRkqm3XJ+HtaocgIRm?=
 =?us-ascii?Q?KEG8r0Qp25AhL6bfQc3YCbRd3Yby8d3pIeYk4GZX5+I6J0iW4G4ZuQYaiiwR?=
 =?us-ascii?Q?Z0hCcrBGJ3HGbO0g51jWkRb9Iunpz1R1Q3kMUBVTCakpB0tJM1KZEqeGIgpv?=
 =?us-ascii?Q?0iWpoJsAAb1pmFMr1WE58grG0jWeAfubVvfq7lRwUJsj4eUO345p+0Cjy+Th?=
 =?us-ascii?Q?IuZlDr2LQSK/X7x4NJqZE/r8EF41bB0C/jI53x0Al8A2BiUFMoQ+krFt5apT?=
 =?us-ascii?Q?WJGDb6QlgmfwlUPIn5ALxcsPGb/Ksxl/DQrnc3+F4r2amJHR5cm/V7rJpbiv?=
 =?us-ascii?Q?Ndx8M/UKCDtK91M5a1aZPL7XS75ON7xfAorJH997hs0EsXVr9kdVmX/4oA8m?=
 =?us-ascii?Q?7yqQyrCIY8LePUa2rKvN1rW91DcpCZFDi5hNowZhcW7YwE5Jg+MRuYVSeFzX?=
 =?us-ascii?Q?aE27ro5aBoHOgU2/Fw8o0mAHA80E/T7iPm+R4UYL6IVQtp0C9dmN27wWn9nD?=
 =?us-ascii?Q?cgDBP9zUrAYsplwy/9toWTHXOIjUzNW+T/NTvZJfLqmrfgvtSB/QFr6XvIvh?=
 =?us-ascii?Q?uXAD/mf1WpkUu7gwCylhiaRyXYA35ECxr+8H1Upq/lE8ShxWMMYbflxS/yid?=
 =?us-ascii?Q?M70IhTGlFNDwMP5+PVM+dmvAOiyITw/9RexHL8KvXFeLMjZs3PQ6lgP5ldHY?=
 =?us-ascii?Q?V9efdX972WGmj4vyrLhRDGDhHeLRQL78+sEX9uQ1I2XI6zPhLURJrI0jKIS0?=
 =?us-ascii?Q?MeWIyu09j1aipccti7rm/FYbLPsOpIQhRj4n0WvWVxrLb/vUJU7HoHIZgmm1?=
 =?us-ascii?Q?sROlDtgcSXZJzhby06z0ZFEhLnwGZ0xtTw/8bbQub2QPhmsxj7SshMerk2Nf?=
 =?us-ascii?Q?2gV2tiV+Zk4iobv9Wd+LJQ2BRiIpETf/PIJ068acndwC61aBdNY+OMykj9Sd?=
 =?us-ascii?Q?3wnc/zDotBA7zF2B3HtDDPnJamj0HyFVXvILBV0af8ucxIPS0YIQKYEVSg2a?=
 =?us-ascii?Q?sxqEphbVVMPzBZ1yO0n3qaODV84pWcLOOlTOZkoy4Wp1teRC2EpjDJIlDdLd?=
 =?us-ascii?Q?XoCXx0JYD5gQ5kJS/ZvGjsfOA8ZYJqABohKwN7iKAdllVSy+w54RyzasSUJ6?=
 =?us-ascii?Q?3rLkTpxc/eCabrJElG8GyMap8P1lptCN2dfjgXGct5p4I8mJfpdrKsuYG4kp?=
 =?us-ascii?Q?6mFTV2l5SSwBkg3W7XmJBgvqJI0LYwWUIcuJCtRv9xvWmmeRzHFabTFUYotJ?=
 =?us-ascii?Q?ypfrZl4D04RSXyYMOrKPWzxcVNfcRU4z3zapAqJ672qP666vAf+pAIRTgpoi?=
 =?us-ascii?Q?ehxv3ro2vknY2wohPuRjGLHUp7KpDAnsLfz5l4j897AhjFyQ9u3/Ox0M8S1N?=
 =?us-ascii?Q?lrlQdIFlc3Dde938Lxj7m9GDCeGVmtB6IbDteifANzGpQdLjds33FUsinQh7?=
 =?us-ascii?Q?3fPFNAZ6Vx4YkLti0DkZ8GRjqBJ3vyvP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lH5aGdqS2yGJPF8PYqagKsuSXl7VrUR15VJo406Co0fXYVJg4h+CX8edRTkF?=
 =?us-ascii?Q?YS/oeX/kfiixkRVjOjWkkWhv+vdvdmCr/SJS1i5VPfiHpK/0qTbYZpWRHiJH?=
 =?us-ascii?Q?Ggy+F7BsFRnN/8dsRi6XQNjAtgOGH11nrb/KJ53uTksTwOXTkgxngGBV7tCS?=
 =?us-ascii?Q?J1lNSqjFXqKneXA9xUwCdOBgz+xNg/DI0uvN56x2R/LejaGNkYxybFXULSU9?=
 =?us-ascii?Q?HKdipb1oZRkWv7gkVMt5ywrwtZKu+s82W1v5OJS9dmQay0pH9bLhUn+fG6g9?=
 =?us-ascii?Q?JYyrDihWFU2LphQYw0GfrKgTzyHqfQ42FyupEJE4XIB2sh9OPhSVrP2kkqVS?=
 =?us-ascii?Q?A4FfnshGeoSBQAJxJXfGGJLFrALYZzI4wrmXdxJhGu4rYa4uY8j5C9XJmkyK?=
 =?us-ascii?Q?ghR2Ld9r4a7LP4agtuR3YD7cP1VyOXRqU/cvpKH2AeKMBKtrMDckpNIk8CpS?=
 =?us-ascii?Q?n3GE7ISIOqw3+LFqSHFtSCVNeo2yGElz9BHDDZaLIuNIlAzRwjb0BVmz3J8f?=
 =?us-ascii?Q?yM4QoiZkpeIx300J1kWKktZSZ5vUpO445sfdsCMYeczrSIq/wCOpH29nMnuF?=
 =?us-ascii?Q?unT8vmxvmGF27hVjlaJ/mgTaTyHojdLeOSifkv99K9xmNx3orjjoHmUBwEgb?=
 =?us-ascii?Q?vGPl7mCJPMsmUhx9utRr2GDdcq4W2O54IBBVvwxAScZxe0tiOENRpwWgBYZb?=
 =?us-ascii?Q?oPQixDGr4lFDEft1kMJYwKcF8k5BCe/rVSvjE/jo7UKkTTBGdR8gYWR21cJu?=
 =?us-ascii?Q?ui88pdYV5M3J2T2cfA8nynOp7atCQMjV4uS4nOKsaFZQVcKEb7o9W7aj2G9o?=
 =?us-ascii?Q?b3g5/U4gfmXRtH6rWoMduPJUL5kIOx0GsE7My9fwSbID5WLHj+yPNHw3dYx1?=
 =?us-ascii?Q?YOAEjEjgjdHBgq8FzDALV70s2UJYdwvaFFNDcynzm7O2/nhUQZWdRIgKtjIZ?=
 =?us-ascii?Q?y6874qHt7ehljhWLnD5BTJgHP6N3QUEez4VRwfKr0LO9TIrRGBgV9bH1QoNM?=
 =?us-ascii?Q?kX0sjLxI2U3+3+wpqEQPNs2p+sFibG//0w4zTVEXnTN5stKoeJjJM/ObOKQT?=
 =?us-ascii?Q?lWlJoF2C4DGKrI9eaHjAQTE76swOkyPVJ+tbwMsLF2/sMV9706W43iDumF4f?=
 =?us-ascii?Q?IPmxz8PYkgcl+lX9kLhBfInIv44iJbTo6byUJje+kS4Bjg5sqK5P3rWN0Umf?=
 =?us-ascii?Q?VditLJIyNIH4yGPGhpofT1xd1JOX2lc9WIiRfEH7Yla5tq8EZfE2Jlx9LIqq?=
 =?us-ascii?Q?nSWzX+v5SWTOSfXpGzQaG0fX1cZCBUjbTFJmcEx/hDEPFZIa2fYxcbvYl+kr?=
 =?us-ascii?Q?JAx3qUydZbOKiPtTBgWO8j0x2E4ajrN6FWOQlOy03Rl496AXJunFCUTBpVk9?=
 =?us-ascii?Q?ccSZxUKjtvFRTYnxRLPr3A5ipgwNGwOAJWXvtlsp1tQN6ySpnc4aFTEGzpIh?=
 =?us-ascii?Q?9WretPz25bCH1asomaB1vNuRsVfTHb3IByV7cgLsIID3/2PWaIT2WoWyUwqT?=
 =?us-ascii?Q?aShuk0kFwm3dRMfBz3yvEE48RccbOsLdHa+Ih01ydOnU0RgYwnRvZU1p2PXh?=
 =?us-ascii?Q?Hbj+Xb+HIkNXi2AeDYNmTh9o/2vnWUHwbjezJ0Kv+1qQgG60fJD0cldG6GaC?=
 =?us-ascii?Q?9VXTZnl+1oYUCN6G68BTNSU=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677fa374-4095-48ca-220f-08dd5ac20b1f
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 02:12:41.4731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCJB1PdEn6x8kO60zdjibVSoXsU7/D/2wZ9Vzpqy4pL37HAUWT35l6+gYt1uT0AKVwbgQn4hXCff+2x+PxYXqWKFh7yjnJx3XEO6PSWbmZ2HCd8878IU5rWBlsg6Nfcw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5914


Hi Kees, Andy

This is v2 patch-set of "add new helpers".
I would like to use string_choices helper to cleanup the code, but it is
missing some of well used string pair in kernel. This patch-set adds it.

Step1
	Add new helpers (This patch-set)
Step2
	Each driver/framework use new helper

You can see "git diff --stat" of Step2 on last of this mail.
One note is that it is including the patch which is using only existing
helper (= not using new helper).
I added sample patch of Step2 in this patch-set as [SAMPLE].

One concern is that it adds "pass/fail", but we can find many similar
strings, like below. I have choiced "pass/fail" and use it on all cases
in my local branch (You can see some of them in [SAMPLE].
I need your opinion

	passed     / failed
	succeed    / failed
	success    / failed
	successful / failed
	succeeded  / failed
	worked     / failed

v1 -> v2
	- add Cc to Andy
	- add [SAMPLE] patches

Kuninori Morimoto (10):
  lib/string_choices: Add str_tx_rx() helper
  lib/string_choices: Add str_enabling_disabling() helper
  lib/string_choices: Add str_in_out() helper
  lib/string_choices: Add str_input_output() helper
  lib/string_choices: Add str_Y_N() helper
  lib/string_choices: Add str_pass_fail() helper
  lib/string_choices: Add str_to_from() helper
  lib/string_choices: Add str_level_edge() helper
  lib/string_choices: Add str_kernel_user() helper
  lib/string_choices: Add str_attach_detach() helper

 include/linux/string_choices.h | 61 ++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

------ diff --stat of Step2 -------
 arch/alpha/kernel/core_cia.c                       |  4 +-
 arch/alpha/kernel/core_tsunami.c                   |  5 +--
 arch/arm/kernel/bios32.c                           |  5 ++-
 arch/arm/mach-omap1/board-ams-delta.c              |  4 +-
 arch/arm/mach-omap2/board-n8x0.c                   |  2 +-
 arch/arm/mach-orion5x/ts78xx-setup.c               |  2 +-
 arch/arm/mach-s3c/pm.c                             |  2 +-
 arch/arm/mm/cache-l2x0.c                           |  7 ++--
 arch/arm/mm/cache-tauros2.c                        |  7 ++--
 arch/arm/mm/fault.c                                |  2 +-
 arch/arm/mm/pmsa-v7.c                              |  2 +-
 arch/arm/plat-orion/gpio.c                         |  6 +--
 arch/arm64/kernel/cpufeature.c                     |  2 +-
 arch/arm64/kernel/reloc_test_core.c                |  3 +-
 arch/arm64/kvm/sys_regs.c                          |  2 +-
 arch/arm64/kvm/sys_regs.h                          |  2 +-
 arch/arm64/kvm/trace_arm.h                         |  6 +--
 arch/arm64/kvm/trace_handle_exit.h                 |  2 +-
 arch/m68k/sun3/mmu_emu.c                           |  2 +-
 arch/microblaze/kernel/exceptions.c                |  4 +-
 arch/mips/jazz/jazzdma.c                           |  2 +-
 arch/mips/kernel/mips-cm.c                         |  5 ++-
 arch/mips/mm/fault.c                               |  5 ++-
 arch/mips/pci/pci-octeon.c                         |  3 +-
 arch/nios2/kernel/traps.c                          |  2 +-
 arch/powerpc/kernel/fadump.c                       |  6 +--
 arch/powerpc/kernel/iommu.c                        |  2 +-
 arch/powerpc/kernel/kvm.c                          |  5 ++-
 arch/powerpc/kernel/prom_init.c                    |  3 +-
 arch/powerpc/mm/fault.c                            |  6 +--
 arch/powerpc/platforms/85xx/ge_imp3a.c             |  3 +-
 arch/powerpc/platforms/86xx/gef_ppc9a.c            |  3 +-
 arch/powerpc/platforms/cell/iommu.c                |  3 +-
 arch/powerpc/platforms/powermac/setup.c            |  3 +-
 arch/powerpc/platforms/powermac/time.c             |  3 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c       |  4 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          |  2 +-
 arch/powerpc/platforms/powernv/pci-sriov.c         |  5 ++-
 arch/powerpc/platforms/powernv/vas.h               |  3 +-
 arch/powerpc/platforms/ps3/device-init.c           |  2 +-
 arch/powerpc/sysdev/mpic.c                         |  3 +-
 arch/powerpc/sysdev/xive/common.c                  |  4 +-
 arch/s390/kernel/dis.c                             |  3 +-
 arch/s390/kernel/dumpstack.c                       |  5 ++-
 arch/s390/kvm/trace-s390.h                         |  2 +-
 arch/um/drivers/virtio_uml.c                       |  3 +-
 arch/um/kernel/um_arch.c                           |  2 +-
 arch/x86/kernel/apic/io_apic.c                     |  6 +--
 arch/x86/kernel/apic/ipi.c                         |  3 +-
 arch/x86/kernel/cet.c                              |  4 +-
 arch/x86/kernel/cpu/mtrr/generic.c                 | 12 +++---
 arch/x86/kvm/trace.h                               | 24 +++++------
 arch/x86/platform/intel-quark/imr.c                |  2 +-
 arch/x86/platform/uv/uv_nmi.c                      |  2 +-
 crypto/aead.c                                      |  3 +-
 crypto/ahash.c                                     |  3 +-
 crypto/async_tx/raid6test.c                        |  3 +-
 crypto/skcipher.c                                  |  3 +-
 drivers/accel/habanalabs/common/firmware_if.c      | 13 +++---
 drivers/accel/habanalabs/gaudi/gaudi.c             | 12 +++---
 drivers/accel/habanalabs/gaudi/gaudi_coresight.c   |  8 ++--
 drivers/accel/habanalabs/gaudi2/gaudi2_coresight.c |  8 ++--
 drivers/accel/habanalabs/goya/goya.c               |  8 ++--
 drivers/accel/habanalabs/goya/goya_coresight.c     |  8 ++--
 drivers/accel/ivpu/ivpu_hw_btrs.c                  |  3 +-
 drivers/acpi/acpi_video.c                          |  6 +--
 drivers/acpi/numa/srat.c                           | 22 ++++-------
 drivers/acpi/pci_irq.c                             |  5 ++-
 drivers/acpi/power.c                               |  5 ++-
 drivers/acpi/proc.c                                |  8 ++--
 drivers/acpi/resource.c                            |  5 ++-
 drivers/acpi/sbs.c                                 |  5 ++-
 drivers/acpi/x86/s2idle.c                          |  6 +--
 drivers/android/binder.c                           |  2 +-
 drivers/ata/pata_arasan_cf.c                       |  2 +-
 drivers/ata/pata_ixp4xx_cf.c                       |  2 +-
 drivers/ata/sata_via.c                             |  2 +-
 drivers/atm/fore200e.c                             |  2 +-
 drivers/atm/nicstar.c                              |  2 +-
 drivers/base/physical_location.c                   |  7 ++--
 drivers/block/amiflop.c                            |  2 +-
 drivers/block/aoe/aoeblk.c                         |  2 +-
 drivers/block/drbd/drbd_actlog.c                   |  6 +--
 drivers/block/drbd/drbd_req.c                      |  2 +-
 drivers/block/mtip32xx/mtip32xx.c                  |  3 +-
 drivers/block/nbd.c                                |  2 +-
 drivers/block/ps3disk.c                            |  5 ++-
 drivers/block/ps3vram.c                            |  2 +-
 drivers/block/rnbd/rnbd-clt.c                      |  2 +-
 drivers/block/xen-blkback/blkback.c                |  3 +-
 drivers/block/xen-blkfront.c                       | 10 ++---
 drivers/bluetooth/bt3c_cs.c                        |  2 +-
 drivers/bluetooth/btmrvl_main.c                    | 10 ++---
 drivers/bluetooth/hci_bcm.c                        |  2 +-
 drivers/bluetooth/hci_ldisc.c                      | 12 +++---
 drivers/bus/intel-ixp4xx-eb.c                      |  3 +-
 drivers/bus/mhi/host/debugfs.c                     |  2 +-
 drivers/bus/uniphier-system-bus.c                  |  3 +-
 drivers/cdrom/cdrom.c                              |  3 +-
 drivers/char/hpet.c                                |  4 +-
 drivers/char/ps3flash.c                            |  3 +-
 drivers/char/sonypi.c                              | 10 ++---
 drivers/char/virtio_console.c                      |  3 +-
 drivers/clk/clk-nomadik.c                          |  6 +--
 drivers/clk/clk-xgene.c                            |  2 +-
 drivers/clk/renesas/renesas-cpg-mssr.c             |  3 +-
 drivers/clk/renesas/rzg2l-cpg.c                    |  4 +-
 drivers/clk/renesas/rzv2h-cpg.c                    |  4 +-
 drivers/counter/stm32-timer-cnt.c                  |  6 ++-
 drivers/cpufreq/amd-pstate-trace.h                 |  3 +-
 drivers/cpufreq/cpufreq.c                          |  2 +-
 drivers/cpuidle/sysfs.c                            |  4 +-
 drivers/crypto/bcm/cipher.c                        |  2 +-
 drivers/crypto/bcm/spu2.c                          |  3 +-
 drivers/crypto/caam/caamalg_qi2.c                  |  2 +-
 drivers/crypto/intel/qat/qat_common/adf_sysfs.c    |  9 +++--
 drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c  |  4 +-
 .../crypto/marvell/octeontx2/otx2_cptpf_ucode.c    |  2 +-
 drivers/crypto/nx/nx-common-powernv.c              |  7 ++--
 drivers/crypto/nx/nx-common-pseries.c              |  9 +++--
 drivers/cxl/core/hdm.c                             |  2 +-
 drivers/cxl/core/port.c                            |  2 +-
 drivers/dax/device.c                               |  3 +-
 drivers/dma-buf/st-dma-fence.c                     |  3 +-
 drivers/dma/amba-pl08x.c                           |  2 +-
 drivers/dma/at_hdmac.c                             |  8 ++--
 drivers/dma/at_xdmac.c                             |  4 +-
 drivers/dma/dw-edma/dw-edma-core.c                 |  4 +-
 drivers/dma/imx-dma.c                              |  2 +-
 drivers/dma/ppc4xx/adma.c                          |  4 +-
 drivers/dma/pxa_dma.c                              |  3 +-
 drivers/dma/sh/rcar-dmac.c                         |  4 +-
 drivers/dma/ste_dma40.c                            |  2 +-
 drivers/dma/sun6i-dma.c                            |  2 +-
 drivers/dma/ti/edma.c                              |  2 +-
 drivers/dma/xilinx/xilinx_dma.c                    |  2 +-
 drivers/edac/amd64_edac.c                          | 46 +++++++++++-----------
 drivers/edac/i5000_edac.c                          |  2 +-
 drivers/edac/i5400_edac.c                          |  2 +-
 drivers/edac/i7300_edac.c                          |  6 +--
 drivers/edac/i82975x_edac.c                        | 10 ++---
 drivers/edac/xgene_edac.c                          | 16 ++++----
 drivers/extcon/extcon-max14577.c                   | 32 +++++++--------
 drivers/extcon/extcon-max77693.c                   | 44 ++++++++++-----------
 drivers/extcon/extcon-max77843.c                   | 40 +++++++++----------
 drivers/extcon/extcon-max8997.c                    | 24 +++++------
 drivers/extcon/extcon-rtk-type-c.c                 |  6 +--
 drivers/firmware/arm_scmi/driver.c                 |  2 +-
 drivers/firmware/arm_scmi/shmem.c                  |  3 +-
 drivers/firmware/arm_scmi/transports/mailbox.c     |  3 +-
 drivers/firmware/arm_scmi/transports/virtio.c      |  3 +-
 drivers/firmware/cirrus/cs_dsp.c                   |  2 +-
 drivers/firmware/efi/cper-x86.c                    |  2 +-
 drivers/firmware/efi/libstub/arm32-stub.c          |  4 +-
 drivers/fpga/altera-fpga2sdram.c                   |  3 +-
 drivers/fpga/altera-hps2fpga.c                     |  3 +-
 drivers/fpga/fpga-bridge.c                         |  3 +-
 drivers/fsi/fsi-core.c                             |  3 +-
 drivers/fsi/fsi-master-ast-cf.c                    |  3 +-
 drivers/fsi/fsi-sbefifo.c                          |  5 ++-
 drivers/gpio/gpio-brcmstb.c                        |  3 +-
 drivers/gpio/gpio-crystalcove.c                    |  7 ++--
 drivers/gpio/gpio-grgpio.c                         |  3 +-
 drivers/gpio/gpio-mvebu.c                          |  6 +--
 drivers/gpio/gpio-nomadik.c                        |  2 +-
 drivers/gpio/gpio-pl061.c                          |  3 +-
 drivers/gpio/gpio-stmpe.c                          |  8 ++--
 drivers/gpio/gpio-virtuser.c                       |  2 +-
 drivers/gpio/gpio-wcove.c                          |  7 ++--
 drivers/gpio/gpio-wm831x.c                         |  4 +-
 drivers/gpio/gpio-xra1403.c                        |  4 +-
 drivers/gpio/gpiolib-sysfs.c                       |  3 +-
 drivers/gpio/gpiolib.c                             | 15 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |  4 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c             |  4 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |  4 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |  4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |  3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |  5 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |  5 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |  5 +--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |  2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  7 ++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  4 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |  4 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  8 ++--
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  2 +-
 .../drm/amd/display/dc/pg/dcn35/dcn35_pg_cntl.c    |  2 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                | 10 ++---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |  2 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c         |  4 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     | 10 ++---
 drivers/i2c/busses/i2c-exynos5.c                   |  2 +-
 drivers/i2c/busses/i2c-hix5hd2.c                   |  2 +-
 drivers/i2c/busses/i2c-rcar.c                      |  3 +-
 drivers/i2c/busses/i2c-sh_mobile.c                 |  3 +-
 drivers/mailbox/ti-msgmgr.c                        |  5 ++-
 drivers/mmc/host/pxamci.c                          |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |  2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |  3 +-
 drivers/net/ethernet/huawei/hinic/hinic_ethtool.c  |  2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |  2 +-
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c    |  3 +-
 drivers/net/ethernet/ti/cpsw_ethtool.c             |  6 +--
 drivers/net/wireless/ath/ath10k/usb.c              | 15 +++----
 drivers/net/wireless/ath/ath6kl/trace.h            |  4 +-
 drivers/net/wireless/ath/ath9k/mci.c               |  3 +-
 drivers/rpmsg/qcom_glink_trace.h                   | 26 ++++++------
 drivers/scsi/qla2xxx/qla_edif.c                    |  3 +-
 drivers/spi/spi-rspi.c                             |  3 +-
 drivers/spi/spi-s3c64xx.c                          |  3 +-
 drivers/spi/spi-sh-msiof.c                         |  4 +-
 drivers/spi/spi-tegra114.c                         |  3 +-
 drivers/spi/spi-tegra20-slink.c                    |  3 +-
 drivers/tty/serial/serial-tegra.c                  |  2 +-
 drivers/tty/serial/sh-sci.c                        |  2 +-
 drivers/usb/atm/usbatm.c                           |  2 +-
 drivers/usb/gadget/udc/bcm63xx_udc.c               |  8 ++--
 drivers/usb/musb/musb_trace.h                      |  2 +-
 drivers/usb/musb/tusb6010_omap.c                   | 14 +++----
 include/trace/events/afs.h                         |  4 +-
 sound/core/ump.c                                   |  7 ++--
 sound/drivers/vx/vx_core.c                         |  2 +-
 sound/pci/rme9652/hdspm.c                          |  3 +-
 sound/soc/codecs/tas2781-i2c.c                     |  4 +-
 sound/soc/codecs/tlv320dac33.c                     |  2 +-
 sound/soc/fsl/fsl_asrc_dma.c                       |  2 +-
 sound/soc/pxa/pxa-ssp.c                            |  3 +-
 sound/soc/renesas/fsi.c                            |  2 +-
 sound/soc/renesas/rcar/dma.c                       |  2 +-
 sound/soc/renesas/rcar/rsnd.h                      |  3 +-
 sound/soc/renesas/rcar/src.c                       |  3 +-
 sound/soc/renesas/rcar/ssiu.c                      |  6 +--
 sound/soc/rockchip/rockchip_i2s_tdm.c              |  2 +-
 sound/soc/soc-core.c                               |  2 +-
 sound/soc/soc-dapm.c                               |  2 +-
 sound/usb/proc.c                                   |  2 +-
 244 files changed, 604 insertions(+), 602 deletions(-)


-- 
2.43.0

