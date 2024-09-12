Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822AC1DA5E
	for <linux-hardening@vger.kernel.org>; Thu, 12 Sep 2024 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726162447; cv=none; b=LdhXc416cOh1thgy3qWOraWn4fZ01dy0lWXnkbvf5c340iqqiTQzBGxvwKlEoVrGU/m23Bj5LozHg9NwpL7a1SLXsRgbvfU/eizHF/ssa94Qixx/rkc01FERV5MEi6ARq3VrXu1x8FfnhE5pcOfndUr6lcpvkQi6Y9Ux0/Emfyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726162447; c=relaxed/simple;
	bh=LmrJcYMsh67ON2YFPBwL+AAYAu1PHhmRJfDSBadrKac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mY0/5gKKc2SCfbu7gdppVjblJgy3QijJ41iUGtGcOrjk3ikETOnabt6/+gVNl3UtOcKRrLt7Lb2SHAX/noancwwAHIOZrBOVUhjtH+RXr5o1apn0iGMKqSED+6hH77UB7NezYgO8Dvfj9EWeKCR4Fs03VyMfcLsTJvzT70sGqkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqipGGEN; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqipGGEN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726162446; x=1757698446;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LmrJcYMsh67ON2YFPBwL+AAYAu1PHhmRJfDSBadrKac=;
  b=lqipGGENyhHwevLVfciRuFVJPRfkac+6rCPGTlxNlculD4C+OmIPJMMM
   fid9ftRXoYkYNsf+FKRhEfxqWLHmFTV4iFKtE+sCMpAtzbS846NQ2aapf
   ezNJcNTaxFlHeDLklXiwOfdSlFNQtN21mvhlprbNVcBG5AHWErf43UUgq
   Gubb+sKYXTBKHJzBjd07v1bvS2LBUoqWxFSPZltTduLV1mh2VOHDE2ivF
   JSyR49sgPJy63NKJE/yPALfhpa/1EAg+N4/OBvNwtjZbYto5ZZNGfV5YN
   duovWWIJL7xSuLoXWKpdtU9URwi3qonkpIzFZmdu10fe0fpyidZdml7Cu
   g==;
X-CSE-ConnectionGUID: EIVeOL8FQc27HXCQCaBwhg==
X-CSE-MsgGUID: K5YvlUbiRQ69vjXsGra+ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="25193696"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="25193696"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 10:34:03 -0700
X-CSE-ConnectionGUID: Oz58hC1qSDKGz89uKW3V4g==
X-CSE-MsgGUID: +l0L7ttDQ6q9giec/izKgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67763157"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.26])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 10:33:32 -0700
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Kees Cook <kees@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org
Subject: pstore: backend (efi_pstore) writing error (-22)
Date: Thu, 12 Sep 2024 19:33:29 +0200
Message-ID: <10527192.nUPlyArG6x@jkrzyszt-mobl2.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi,

While working on manual reproduction of some "incomplete -- No warnings/
errors" issues reported by Intel GFX CI (https://intel-gfx-ci.01.org/) to 
https://gitlab.freedesktop.org/groups/drm/i915/-/issues, I've managed to 
capture a few machine check exception reports, followed by warnings from 
unsuccessful copy to pstore attempts.  I was using kernel versions from 
https://gitlab.freedesktop.org/drm/tip.git -- a linux-next like repository 
for integration testing of changes to drm subsystem, based on mainline.

Since I haven't found any similar reports on the net, could you please have 
a look and check if that's a known issue, and if not then if it can be fixed, 
or allowed to fail silently in the worst case if not fixable after an MCE hit?

Thanks,
Janusz


[11903.741247] mce: CPUs not responding to MCE broadcast (may include false positives): 0,2-3,5,9-11,13-15
[11903.741254] Kernel panic - not syncing: Timeout: Not all CPUs entered broadcast exception handler
[11904.768716] Shutting down cpus with NMI
[11904.778998] Kernel Offset: disabled
[11904.793081] ------------[ cut here ]------------
[11904.793082] WARNING: CPU: 4 PID: 0 at arch/x86/kernel/fpu/core.c:60 kernel_fpu_begin_mask+0xe5/0x110
[11904.793089] Modules linked in: dm_crypt snd_hda_codec_hdmi i915 x86_pkg_temp_thermal coretemp kvm_intel kvm snd_intel_dspcfg snd_hda_codec mei_gsc_proxy prime_numbers snd_hwdep i2c_algo_bit crct10dif_pclmul wmi_bmof e1000e ttm video snd_hda_core i2c_i801 crc32_pclmul drm_display_helper ptp mei_me ghash_clmulni_intel i2c_mux snd_pcm thunderbolt pps_core mei i2c_smbus drm_buddy wmi fuse [last unloaded: snd_hda_intel]
[11904.793103] CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Not tainted 6.11.0-rc6-VLK-63048-gd39ebf112371 #1
[11904.793105] Hardware name: Intel Corporation Arrow Lake Client Platform/ARL-H Lp5x T4 RVP, BIOS MTLPFWI1.R00.4213.D81.2405221214 05/22/2024
[11904.793106] RIP: 0010:kernel_fpu_begin_mask+0xe5/0x110
[11904.793108] Code: 44 48 83 c4 10 5b c3 cc cc cc cc 48 8b 07 f6 c4 40 75 af f0 80 4f 01 40 48 81 c7 40 25 00 00 e8 81 fe ff ff eb 9c db e3 eb c7 <0f> 0b 0f 0b 65 0f b6 05 17 a9 fd 7e 84 c0 0f 84 6c ff ff ff 0f 0b
[11904.793109] RSP: 0018:fffffe00000ff9b8 EFLAGS: 00010006
[11904.793110] RAX: 0000000080110004 RBX: 0000000000000003 RCX: 0000000000000000
[11904.793111] RDX: 0000000000000002 RSI: ffff88800263cfe0 RDI: 0000000000000001
[11904.793112] RBP: fffffe00000ffa38 R08: ffffffff8263a000 R09: ffff888000000000
[11904.793112] R10: ffff888100275000 R11: 0000000000000000 R12: fffffe00000ffa40
[11904.793112] R13: fffffe00000ffa48 R14: fffffe00000ffaf0 R15: ffff8881028ba800
[11904.793113] FS:  0000000000000000(0000) GS:ffff888470100000(0000) knlGS:0000000000000000
[11904.793114] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11904.793114] CR2: 000056396e185318 CR3: 0000000109330003 CR4: 0000000000f70ef0
[11904.793115] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[11904.793115] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[11904.793116] PKRU: 55555554
[11904.793116] Call Trace:
[11904.793117]  <#MC>
[11904.793118]  ? __warn.cold+0xb1/0x145
[11904.793121]  ? kernel_fpu_begin_mask+0xe5/0x110
[11904.793122]  ? report_bug+0xea/0x170
[11904.793124]  ? handle_bug+0x3a/0x70
[11904.793126]  ? exc_invalid_op+0x17/0x70
[11904.793127]  ? asm_exc_invalid_op+0x1a/0x20
[11904.793129]  ? kernel_fpu_begin_mask+0xe5/0x110
[11904.793130]  ? kernel_fpu_begin_mask+0x23/0x110
[11904.793131]  arch_efi_call_virt_setup+0x13/0x80
[11904.793134]  virt_efi_query_variable_info_nb+0x58/0xd0
[11904.793137]  efi_query_variable_store+0x186/0x1d0
[11904.793138]  ? rcu_is_watching+0x11/0x50
[11904.793140]  ? lock_acquire+0x280/0x2f0
[11904.793141]  ? down_trylock+0x24/0x30
[11904.793142]  ? rcu_is_watching+0x11/0x50
[11904.793143]  efivar_set_variable_locked+0x9d/0xf0
[11904.793146]  efi_pstore_write+0x114/0x160
[11904.793149]  ? pstore_dump+0xe5/0x350
[11904.793152]  pstore_dump+0xe5/0x350
[11904.793154]  kmsg_dump_desc+0x97/0x190
[11904.793156]  panic+0x178/0x2b1
[11904.793158]  mce_panic+0x129/0x210
[11904.793160]  mce_timed_out+0x60/0xa0
[11904.793161]  mce_start+0x96/0x130
[11904.793162]  do_machine_check+0x995/0xad0
[11904.793164]  ? intel_idle+0x59/0xa0
[11904.793165]  exc_machine_check+0x66/0x90
[11904.793167]  asm_exc_machine_check+0x1e/0x40
[11904.793168] RIP: 0010:intel_idle+0x59/0xa0
[11904.793168] Code: 3e 0f ae f0 31 d2 48 89 f0 48 89 d1 0f 01 c8 48 8b 06 a8 08 75 14 eb 07 0f 00 2d ce 5d 30 00 b9 01 00 00 00 4c 89 c0 0f 01 c9 <f0> 80 66 02 df f0 83 44 24 fc 00 48 8b 06 a8 08 74 0b 65 81 25 b2
[11904.793169] RSP: 0018:ffffc900001dfe78 EFLAGS: 00000046
[11904.793170] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000001
[11904.793170] RDX: 0000000000000000 RSI: ffff888100f28040 RDI: 0000000000000001
[11904.793170] RBP: ffffe8ffffb3c140 R08: 0000000000000000 R09: 0000000000000000
[11904.793171] R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff827c1740
[11904.793171] R13: ffffffff827c17c0 R14: 0000000000000001 R15: 000000000002e74c
[11904.793172]  </#MC>
[11904.793173]  <TASK>
[11904.793173]  cpuidle_enter_state+0xbd/0x540
[11904.793174]  cpuidle_enter+0x28/0x40
[11904.793178]  do_idle+0x1b9/0x210
[11904.793180]  cpu_startup_entry+0x24/0x30
[11904.793181]  start_secondary+0x11a/0x140
[11904.793183]  common_startup_64+0x13e/0x148
[11904.793186]  </TASK>
[11904.793186] irq event stamp: 710980000
[11904.793187] hardirqs last  enabled at (710979999): [<ffffffff81a40cf8>] cpuidle_enter+0x28/0x40
[11904.793188] hardirqs last disabled at (710980000): [<ffffffff81d7135b>] exc_machine_check+0x5b/0x90
[11904.793190] softirqs last  enabled at (710979990): [<ffffffff810a0153>] irq_exit_rcu+0x83/0xe0
[11904.793191] softirqs last disabled at (710979983): [<ffffffff810a0153>] irq_exit_rcu+0x83/0xe0
[11904.793192] ---[ end trace 0000000000000000 ]---
[11904.793193] ------------[ cut here ]------------
[11904.793193] WARNING: CPU: 4 PID: 0 at arch/x86/kernel/fpu/core.c:425 kernel_fpu_begin_mask+0xe7/0x110
[11904.793194] Modules linked in: dm_crypt snd_hda_codec_hdmi i915 x86_pkg_temp_thermal coretemp kvm_intel kvm snd_intel_dspcfg snd_hda_codec mei_gsc_proxy prime_numbers snd_hwdep i2c_algo_bit crct10dif_pclmul wmi_bmof e1000e ttm video snd_hda_core i2c_i801 crc32_pclmul drm_display_helper ptp mei_me ghash_clmulni_intel i2c_mux snd_pcm thunderbolt pps_core mei i2c_smbus drm_buddy wmi fuse [last unloaded: snd_hda_intel]
[11904.793200] CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Tainted: G        W          6.11.0-rc6-VLK-63048-gd39ebf112371 #1
[11904.793201] Tainted: [W]=WARN
[11904.793202] Hardware name: Intel Corporation Arrow Lake Client Platform/ARL-H Lp5x T4 RVP, BIOS MTLPFWI1.R00.4213.D81.2405221214 05/22/2024
[11904.793202] RIP: 0010:kernel_fpu_begin_mask+0xe7/0x110
[11904.793203] Code: 83 c4 10 5b c3 cc cc cc cc 48 8b 07 f6 c4 40 75 af f0 80 4f 01 40 48 81 c7 40 25 00 00 e8 81 fe ff ff eb 9c db e3 eb c7 0f 0b <0f> 0b 65 0f b6 05 17 a9 fd 7e 84 c0 0f 84 6c ff ff ff 0f 0b e9 65
[11904.793203] RSP: 0018:fffffe00000ff9b8 EFLAGS: 00010006
[11904.793204] RAX: 0000000080110004 RBX: 0000000000000003 RCX: 0000000000000000
[11904.793204] RDX: 0000000000000002 RSI: ffff88800263cfe0 RDI: 0000000000000001
[11904.793205] RBP: fffffe00000ffa38 R08: ffffffff8263a000 R09: ffff888000000000
[11904.793205] R10: ffff888100275000 R11: 0000000000000000 R12: fffffe00000ffa40
[11904.793205] R13: fffffe00000ffa48 R14: fffffe00000ffaf0 R15: ffff8881028ba800
[11904.793206] FS:  0000000000000000(0000) GS:ffff888470100000(0000) knlGS:0000000000000000
[11904.793206] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11904.793207] CR2: 000056396e185318 CR3: 0000000109330003 CR4: 0000000000f70ef0
[11904.793207] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[11904.793207] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[11904.793208] PKRU: 55555554
[11904.793208] Call Trace:
[11904.793208]  <#MC>
[11904.793209]  ? __warn.cold+0xb1/0x145
[11904.793210]  ? kernel_fpu_begin_mask+0xe7/0x110
[11904.793210]  ? report_bug+0xea/0x170
[11904.793212]  ? handle_bug+0x3a/0x70
[11904.793213]  ? exc_invalid_op+0x17/0x70
[11904.793213]  ? asm_exc_invalid_op+0x1a/0x20
[11904.793215]  ? kernel_fpu_begin_mask+0xe7/0x110
[11904.793216]  ? kernel_fpu_begin_mask+0x23/0x110
[11904.793217]  arch_efi_call_virt_setup+0x13/0x80
[11904.793218]  virt_efi_query_variable_info_nb+0x58/0xd0
[11904.793219]  efi_query_variable_store+0x186/0x1d0
[11904.793220]  ? rcu_is_watching+0x11/0x50
[11904.793221]  ? lock_acquire+0x280/0x2f0
[11904.793221]  ? down_trylock+0x24/0x30
[11904.793222]  ? rcu_is_watching+0x11/0x50
[11904.793223]  efivar_set_variable_locked+0x9d/0xf0
[11904.793225]  efi_pstore_write+0x114/0x160
[11904.793226]  ? pstore_dump+0xe5/0x350
[11904.793227]  pstore_dump+0xe5/0x350
[11904.793229]  kmsg_dump_desc+0x97/0x190
[11904.793230]  panic+0x178/0x2b1
[11904.793232]  mce_panic+0x129/0x210
[11904.793233]  mce_timed_out+0x60/0xa0
[11904.793234]  mce_start+0x96/0x130
[11904.793235]  do_machine_check+0x995/0xad0
[11904.793237]  ? intel_idle+0x59/0xa0
[11904.793238]  exc_machine_check+0x66/0x90
[11904.793240]  asm_exc_machine_check+0x1e/0x40
[11904.793240] RIP: 0010:intel_idle+0x59/0xa0
[11904.793241] Code: 3e 0f ae f0 31 d2 48 89 f0 48 89 d1 0f 01 c8 48 8b 06 a8 08 75 14 eb 07 0f 00 2d ce 5d 30 00 b9 01 00 00 00 4c 89 c0 0f 01 c9 <f0> 80 66 02 df f0 83 44 24 fc 00 48 8b 06 a8 08 74 0b 65 81 25 b2
[11904.793241] RSP: 0018:ffffc900001dfe78 EFLAGS: 00000046
[11904.793242] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000001
[11904.793242] RDX: 0000000000000000 RSI: ffff888100f28040 RDI: 0000000000000001
[11904.793243] RBP: ffffe8ffffb3c140 R08: 0000000000000000 R09: 0000000000000000
[11904.793243] R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff827c1740
[11904.793243] R13: ffffffff827c17c0 R14: 0000000000000001 R15: 000000000002e74c
[11904.793245]  </#MC>
[11904.793245]  <TASK>
[11904.793245]  cpuidle_enter_state+0xbd/0x540
[11904.793246]  cpuidle_enter+0x28/0x40
[11904.793247]  do_idle+0x1b9/0x210
[11904.793248]  cpu_startup_entry+0x24/0x30
[11904.793249]  start_secondary+0x11a/0x140
[11904.793250]  common_startup_64+0x13e/0x148
[11904.793252]  </TASK>
[11904.793253] irq event stamp: 710980000
[11904.793253] hardirqs last  enabled at (710979999): [<ffffffff81a40cf8>] cpuidle_enter+0x28/0x40
[11904.793254] hardirqs last disabled at (710980000): [<ffffffff81d7135b>] exc_machine_check+0x5b/0x90
[11904.793255] softirqs last  enabled at (710979990): [<ffffffff810a0153>] irq_exit_rcu+0x83/0xe0
[11904.793256] softirqs last disabled at (710979983): [<ffffffff810a0153>] irq_exit_rcu+0x83/0xe0
[11904.793256] ---[ end trace 0000000000000000 ]---
[11905.755531] pstore: backend (efi_pstore) writing error (-22)


