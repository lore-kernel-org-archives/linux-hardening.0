Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA8E26A08A;
	Fri, 13 Mar 2026 20:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773435465; cv=none; b=te0HdrpU9G6bWrgi+hBokve9zr4hvuMVY29jyjihH+VXiNwBJFJVUSe79t2i/2cu1YzoYixBaMsdcs3leTBYfvFQuR/0TIFdLlF8AjzFuUHO9x/Xvp/ZqIdHxjsVSCnuePxEY4h5mKMMuqNWJf2Ij61SQ8riYCM4Y4UuWxbuRhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773435465; c=relaxed/simple;
	bh=fC1MoHepr5S6X7yXPc4Va0+ggZDH2LC/G+a87cW3xIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ah+DL4oJyoY6Bp64tFN2/EqIkPak89CRq4v0pzpyNoCH/xkbjpF0hsdx6VG3GXZQ8coJYVA/RnyXhAOXICBI4XETBRZRouK8lTeI7cWfN/URJrQInXs8OFfqJwrei9JnO5TjLgPyrrbrAcLPYqmNlxXm65P0H8GrxuBGZI1vOKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=RrXV4IHX; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="RrXV4IHX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=V/+QBdBffKqq69EsmZIR9yCSWQkL1wYMOKT7x6oHCSg=; b=RrXV4IHXOTxHhsVc3s1gAspl31
	S8We4ZglUPLjvdzP1cJRw4V9GrdPc3gJpF2zYYtxwfU183F+arQlTfuctZHIozX4HKwxQ3yFc4I/u
	M9Jo6mOmibJqOYIqoyf9qpvkl2SM1qmAwo3NSrL88D4oyLN1kEjfEX3064R1halSmu+WivjvKbn2v
	Pyv2MwBmOri9S1GKduBM/5FSlER6g17iphEPXrl73uo0NSbRsJHjFFFP8TunbES3UqQDFXppVhJP7
	NtnjjjV5ElIY4dJzn/tVreBSpU/U+NW0pwyf+mLiz3+VhaJGUO3lGCUXz6bGe6fQ9cRqywTOTjcek
	0c6TWsBA==;
Received: from [179.93.15.111] (helo=[192.168.1.54])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1w19Zi-00FR78-QR; Fri, 13 Mar 2026 21:57:39 +0100
Message-ID: <b88aa1bd-5b7c-a31b-fea6-3886099e2fec@igalia.com>
Date: Fri, 13 Mar 2026 17:57:35 -0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] pstore/ftrace: Factor KASLR offset in the core kernel
 instruction addresses
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 kees@kernel.org, tony.luck@intel.com, kernel-dev@igalia.com,
 kernel@gpiccoli.net
References: <20260313201010.1622406-3-gpiccoli@igalia.com>
 <20260313162831.32b52b6a@gandalf.local.home>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20260313162831.32b52b6a@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/03/2026 17:28, Steven Rostedt wrote:
> [...]
> 
> You can look at what ftrace does with the persistent ring buffer. It adds
> the offset data to a "scratch pad" that is saved in the persistent memory.
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace/trace.c#n5352
> 
> If you know your memory isn't reset over reboots, you can create a
> "persistent ring buffer" via the kernel command line:
> 
>   reserve_mem=20M:2M:trace trace_instance=boot_map@trace
> 
> Read more about it here: https://docs.kernel.org/trace/debugging.html
> 
> Then on reboot, the persistent ring buffer lives here:
> 
>   /sys/kernel/tracing/instances/boot_map/
> 
> You can enable tracing just like any other instance:
> 
>   # echo 1 > /sys/kernel/tracing/instances/boot_map/tracing_on
>   # echo function_graph > /sys/kernel/tracing/instances/boot_map/current_tracer
>   # cat /sys/kernel/tracing/instances/boot_map/trace
> 
> Then reboot, if the memory wasn't corrupted or reset, the instance will
> have everything from the last boot, right to where it rebooted the machine.
> 
> There's a file that shows the indexes of the kernel from the previous boot:
> 
>   # cat /sys/kernel/tracing/instances/boot_map/last_boot_info 
> ffffffffa6000000	[kernel]
> ffffffffc0400000	drm
[...]

Hi Steve, this is very interesting! Thanks for pointing that
infrastructure. And I'm glad it confirms my impression that the full fix
of that isn't trivial heh

So, are you suggesting to use the ftrace infrastructure in the
pstore/ftrace? Well, seeing how mature the ftrace infra is with regards
the persistent ring buffer, I'd say pstore/ftrace+ramoops gets useless
now heh

The usage then for pstore/ftrace would be more with other backends,
really low memory cases like ERST or UEFI, for example, in embedded
maybe. And in this case, saving the full modules name table + offsets
could incur some precious memory consumption and/or performance impact.
Or maybe I'm talking nonsense and this would be quite OK ... guess worth
taking a look.

I'll wait a bit more to see what pstore maintainers think about that, if
is worth to have the very simple KASLR fix or a bit more engineered
solution that factors modules as well.

Thanks again,


Guilherme

