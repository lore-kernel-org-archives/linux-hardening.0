Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78351E494
	for <linux-hardening@vger.kernel.org>; Mon, 24 Jun 2024 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719232275; cv=none; b=e6MskanBTHjDlpv1BcwnlNBAS1OJWXYRzK6upDjZnwmzO4/7qwnfauxz4qELvYKlydH9T5stNbYGUj9XMv5xoaDtwt1P08EMQQBbufG8GoxZwObFhfszicHvHhlo+2SfSyNA8jQr78w4mkkHASDVXhZCOKPNPIIPUQQbIuUYTqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719232275; c=relaxed/simple;
	bh=QfcG4SzOrIp9FdOHo9OvlIbGfspudn+GZvo/O5cIXck=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XbtNPQcM5yVPCIJFjQApFu6ETo0y1mm0YATV7qpjQAK3oSjH6WuRhJLOny0nGQ77q5hxGDO8TAOByDgYLYtgJyEyOpEYYzwmPh4P2uB9i95tkj5A9t5z/pskGkRSnNuXKp4nz535Q3ZdsdmCsq1Mwsj0rvBY9hdzQTl8O5cgXnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W76l23hQTz4wbr;
	Mon, 24 Jun 2024 22:31:10 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, Anjali K <anjalik@linux.ibm.com>
Cc: npiggin@gmail.com, naveen@kernel.org, christophe.leroy@csgroup.eu, kees@kernel.org, gustavoars@kernel.org, linux-hardening@vger.kernel.org, vishalc@linux.ibm.com
In-Reply-To: <20240614173844.746818-1-anjalik@linux.ibm.com>
References: <20240614173844.746818-1-anjalik@linux.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: Whitelist dtl slub object for copying to userspace
Message-Id: <171923223890.136336.18261608186644229436.b4-ty@ellerman.id.au>
Date: Mon, 24 Jun 2024 22:30:38 +1000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 14 Jun 2024 23:08:44 +0530, Anjali K wrote:
> Reading the dispatch trace log from /sys/kernel/debug/powerpc/dtl/cpu-*
> results in a BUG() when the config CONFIG_HARDENED_USERCOPY is enabled as
> shown below.
> 
>     kernel BUG at mm/usercopy.c:102!
>     Oops: Exception in kernel mode, sig: 5 [#1]
>     LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
>     Modules linked in: xfs libcrc32c dm_service_time sd_mod t10_pi sg ibmvfc
>     scsi_transport_fc ibmveth pseries_wdt dm_multipath dm_mirror dm_region_hash dm_log dm_mod fuse
>     CPU: 27 PID: 1815 Comm: python3 Not tainted 6.10.0-rc3 #85
>     Hardware name: IBM,9040-MRX POWER10 (raw) 0x800200 0xf000006 of:IBM,FW1060.00 (NM1060_042) hv:phyp pSeries
>     NIP:  c0000000005d23d4 LR: c0000000005d23d0 CTR: 00000000006ee6f8
>     REGS: c000000120c078c0 TRAP: 0700   Not tainted  (6.10.0-rc3)
>     MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 2828220f  XER: 0000000e
>     CFAR: c0000000001fdc80 IRQMASK: 0
>     [ ... GPRs omitted ... ]
>     NIP [c0000000005d23d4] usercopy_abort+0x78/0xb0
>     LR [c0000000005d23d0] usercopy_abort+0x74/0xb0
>     Call Trace:
>      usercopy_abort+0x74/0xb0 (unreliable)
>      __check_heap_object+0xf8/0x120
>      check_heap_object+0x218/0x240
>      __check_object_size+0x84/0x1a4
>      dtl_file_read+0x17c/0x2c4
>      full_proxy_read+0x8c/0x110
>      vfs_read+0xdc/0x3a0
>      ksys_read+0x84/0x144
>      system_call_exception+0x124/0x330
>      system_call_vectored_common+0x15c/0x2ec
>     --- interrupt: 3000 at 0x7fff81f3ab34
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/pseries: Whitelist dtl slub object for copying to userspace
      https://git.kernel.org/powerpc/c/1a14150e1656f7a332a943154fc486504db4d586

cheers
