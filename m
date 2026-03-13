Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23B13DCDAC;
	Fri, 13 Mar 2026 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773433705; cv=none; b=EAIHneaKM0L6ATbcyvuJEiBSjHbHY7hKP5MinzZqfSSFhk7TczjkBRGVXbazGpUMqWN5KRxEELd0oVrAe5riR7u97Xjnsu2ByX6Y7hFCsmHg4+HH5HOY8Qf+NA9B6Zc1+ztiXj92egf1cUWCt+5p88RC6Qn5RA9Wjcz2/sL9l9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773433705; c=relaxed/simple;
	bh=Xip67hYiqw+J8E03xJAyPdnej4toYX0W9T+NUPj/LDw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oCTXkkr02xgI0314KAA4oc9btcJGJbBwy4dpXdphrhBINjpklnsruE+g7r6SfJV7DymF9XNKhf1Jz/5eoQ+WikV742SSL51HO/A+i5Qb7h/BRZSRYSh3DndWWbgQSjS4mjPnpOoNwU9f+BAnAc2OFFXZLUy/aeTPsEpFe+A3UIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id D047F1B7168;
	Fri, 13 Mar 2026 20:28:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id CF1FD6000D;
	Fri, 13 Mar 2026 20:28:14 +0000 (UTC)
Date: Fri, 13 Mar 2026 16:28:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 kees@kernel.org, tony.luck@intel.com, kernel-dev@igalia.com,
 kernel@gpiccoli.net
Subject: Re: [PATCH] pstore/ftrace: Factor KASLR offset in the core kernel
 instruction addresses
Message-ID: <20260313162831.32b52b6a@gandalf.local.home>
In-Reply-To: <20260313201010.1622406-3-gpiccoli@igalia.com>
References: <20260313201010.1622406-3-gpiccoli@igalia.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 918jriqtzdkzt9syhysdud9rrrzzqdaz
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: CF1FD6000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX191DHGRQ3r4T9ak2zMto8xh8HRWWAgOcz8=
X-HE-Tag: 1773433694-770978
X-HE-Meta: U2FsdGVkX1+o/NVrJlVFQ+g9APfWSJp5XPDv9C+rPo4he/tDeDD0md1CDXRIFRoQmyJkirwWdq7u73gy9n9E6KXpWxg7W6qj9W+EDqIXe37UV9v7LX/JS/Gzt+Bj/Mj1n3xxmgOfDmj8uH99tQjzCXmF0h14/mRcFRzDx4B3LTWA/oZgycfRQmIt1Gy6OPx29nATZQsdkfUBQKroaU47+xFf7oAofnnutsDNZKLdGM8f90SCGRhCILq9jbybIkUb7OdxIpOYy5Uc4vP7/6hNNaTiAdQ2tIF24X7/wo/e2+jPmBbyIWWJ5gLSM5wBU7+81KmZEiFDKKJjMA9yadNXlzlC5N6teaXTuhkjKWIvs4l5WX+EOiJSGuox3ySA0Mz+vU/1Qhd7grQPCGkqnUDTzf0I96scvsMGVI6j/Gg5EGWr7Hi1h8NZvg==

On Fri, 13 Mar 2026 17:00:22 -0300
"Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:

> Hi folks, first of all thanks in advance for reviews and comments!
> 
> I was testing a pstore/ftrace patch the other day and noticed
> the lack of the KASLR support. But to my surprise, it was not
> as easy to fix up as I expected heh
> 
> Main reason is the obvious thing with modules: the way to
> go, I think, is to somehow save the module name (or some other
> id?) and the instruction offset inside such module, to then
> resolve that in next boot, when printing. But that would require
> more intrusive changes in the way pstore/ftrace saves the IP
> (which is quite simple now), leading to some potentially
> meaningful perf overhead.
> 
> Hence, I've decided to just mess with core kernel addresses
> so far, lemme know WDYT - should I somehow pursue fixing
> modules addr resolution as well? Or doesn't worth the changes?
> Any ideas on how to approach that? I noticed that currently,
> modules' symbols are sometimes resolved fine, sometimes they're
> bogus but point to the module at least (not some other random
> code), but eventually they are just nonsense addresses.
> 
> Regarding the choice of using the MSB to store if an addr is core
> kernel or module, well this was also a choice taking into account
> simplicity and performance, lemme know please if it's no good and
> any suggestions on how to better do it, I can easily re-implement!
> Thanks again,

You can look at what ftrace does with the persistent ring buffer. It adds
the offset data to a "scratch pad" that is saved in the persistent memory.

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace/trace.c#n5352

If you know your memory isn't reset over reboots, you can create a
"persistent ring buffer" via the kernel command line:

  reserve_mem=20M:2M:trace trace_instance=boot_map@trace

Read more about it here: https://docs.kernel.org/trace/debugging.html

Then on reboot, the persistent ring buffer lives here:

  /sys/kernel/tracing/instances/boot_map/

You can enable tracing just like any other instance:

  # echo 1 > /sys/kernel/tracing/instances/boot_map/tracing_on
  # echo function_graph > /sys/kernel/tracing/instances/boot_map/current_tracer
  # cat /sys/kernel/tracing/instances/boot_map/trace

Then reboot, if the memory wasn't corrupted or reset, the instance will
have everything from the last boot, right to where it rebooted the machine.

There's a file that shows the indexes of the kernel from the previous boot:

  # cat /sys/kernel/tracing/instances/boot_map/last_boot_info 
ffffffffa6000000	[kernel]
ffffffffc0400000	drm
ffffffffc0444000	wmi
ffffffffc0446000	soundcore
ffffffffc0447000	tpm_infineon
ffffffffc0449000	lpc_ich
ffffffffc044a000	serio_raw
ffffffffc044b000	i2c_smbus
ffffffffc044c000	i2c_i801
ffffffffc044f000	snd_seq_device
ffffffffc0450000	e1000e
ffffffffc047a000	intel_cstate
ffffffffc047b000	video
ffffffffc047f000	drm_kms_helper
ffffffffc0493000	snd
ffffffffc04a0000	intel_uncore
ffffffffc04ad000	mei
ffffffffc04bf000	snd_timer
ffffffffc04c4000	snd_pcm
ffffffffc04d7000	snd_seq
ffffffffc04e2000	drm_display_helper
ffffffffc04f6000	iTCO_vendor_support
ffffffffc04f7000	mei_wdt
ffffffffc04f8000	iTCO_wdt
ffffffffc04f9000	mei_me
ffffffffc04fe000	wmi_bmof
ffffffffc04ff000	ttm
ffffffffc050a000	rapl
ffffffffc050b000	drm_buddy
ffffffffc050e000	snd_hda_core
ffffffffc0518000	ghash_clmulni_intel
ffffffffc0519000	i2c_algo_bit
ffffffffc051b000	snd_hwdep
ffffffffc051d000	irqbypass
ffffffffc051e000	drm_client_lib
ffffffffc051f000	snd_hda_codec
ffffffffc0531000	snd_intel_dspcfg
ffffffffc0532000	kvm
ffffffffc05ab000	snd_hda_intel
ffffffffc05af000	kvm_intel
ffffffffc05d5000	intel_powerclamp
ffffffffc05d6000	coretemp
ffffffffc05d7000	snd_hda_codec_generic
ffffffffc05e4000	snd_hda_scodec_component
ffffffffc05e5000	snd_hda_codec_realtek_lib
ffffffffc05ea000	snd_hda_codec_alc269
ffffffffc05f2000	snd_hda_codec_hdmi
ffffffffc05f7000	x86_pkg_temp_thermal
ffffffffc05f8000	intel_rapl_common
ffffffffc05fc000	intel_rapl_msr
ffffffffc05fd000	snd_hda_codec_intelhdmi
ffffffffc05ff000	llc
ffffffffc0a00000	i915
ffffffffc0c10000	rfkill
ffffffffc0c13000	vmw_vmci
ffffffffc0c1d000	vsock
ffffffffc0c23000	stp
ffffffffc0c24000	bridge

That has where the _text address was for the main kernel, and also where
every module was loaded.

If you enable tracing, that file will just show:

  # echo 1 > /sys/kernel/tracing/boot_map/events/sched/sched_switch/enable
  # cat /sys/kernel/tracing/instances/boot_map/last_boot_info 
# Current

As it will not show the current mappings. Only the mappings of a previous
boot.

-- Steve
