Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793166743;
	b=0jDlrpfIs2AGEs1pZgvqHayqiiI7q770Cx6JJjQ7wVgZv10gWOIwBAXLhqH+RCpqaS7/
	 /qUREMZLwG4DqLs4UtTmawQ/DE0T5Fl2XOkke3sCDlxAT0EP1KtOZJbjT18hZHZSj1lRB
	 P4qONjmKMTW/QYGbj6w3uXuvyh4AClkE7PhYz0LTvhyD2BA/nLmKmh63yXeexilhWLDIQ
	 kMKJZYCRnVsDWUdgKArRxfedRNRUudV1qK+4DNuaTaglS65WYozLyasu4fMpJl8NrSwgh
	 pnTv6z3IKH9phF6vo6teDtC/PVvc0qaogg5IiSdVV+PxBYj0aiEPbkEyZFmvfXYriJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793166743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=o0+YQ8IhrloxYZmXJNyf64tQivuQ6Pn/Dp36CBxwNv4=;
	b=ODOGQX42Mh/BYVX/0LzQUcmdHepfeHOOi740M/XDh7rtEoKcDwkBO75rkCX0uzKf/6vg
	 rfoTPYntXIRdX2GV0bUfgOFW7eP8qDfDCBgGdO8l/7eD4ThLWOhKHlRlfLgk3Hl9h1TL1
	 xh+QkpiotbUOHGy+tIwX5JE/q3FooKhbyGQ+9BAnPF2kXbmKkxxyav91Ge6Fstlyo4hrf
	 7HUC7hULz4xOj9BFZROiL0DkKRh+acXZlaCNBBzjaBAwL16Kd7zuJ9542go2LFjJPfJIt
	 3LB43o2/bSr1EH6w+PpaRGHLcj5Q0p68wy8Gk5FGZa9nA/XG7sfdBSDXndZF2qSrRNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=u1CUAc5U;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB45606A322
	for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 05:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DB45606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=u1CUAc5U
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a06454116eso332153b3a.1
        for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 22:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793166742; x=1793771542; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=o0+YQ8IhrloxYZmXJNyf64tQivuQ6Pn/Dp36CBxwNv4=;
        b=u1CUAc5UGEIg8w651QAnSj1ilJ1Hp07nRBlYJYLip7lca9dtV+G4XIVLxIkkYk+9He
         Gi0KpLWies9ZXilvLmEHfJEIcvI8kzJ1Wyu473aUFgZ+EPn9NADS0gpTZFOInL5tm9Nq
         7qBSbt2D7PxHKFRNJ0ExDlyKLPKzHEsOpZICg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793166742; x=1793771542;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o0+YQ8IhrloxYZmXJNyf64tQivuQ6Pn/Dp36CBxwNv4=;
        b=FVBfob0Go+F4n4fiqK4xzzPXeOYis01ZQhYe/y2ri992Z2379cPQUJUYLd1t84xNJT
         jqixGJZK5XuIQ3pUDKf+aHJKYSZi/W/TyTJIOQu0l4QA0jHyiJdC9vXjaN7cd5sGUFiM
         q1Dn5vEMXubhBuEp1CBHY8P2xrBCWtfxmBNpuNYmNFCz5iSSqKsjNuZ7S2HYciXMSOfN
         h/evzQ/NPZVQO2AWg7vJb3RL8t6CVToVoTJd5jX3sYfeSZh78VAViWb8I0DD4EE7MKX4
         VWCad8C+5xu/QIs4ipNWiEfl5KcMaZwj/zAy9JVXNyPmlDTNKqLk+76kkglWxGvrpL5l
         9Sow==
X-Forwarded-Encrypted: i=1; AKwUvBw6fD8tTyYwnUQGlIgn/HOWvwJCystH9BR1AMVXkyl/ixPDl8k4VG8XlfVIBQkoZlujZ0A1tG9c0WtLL4p8VEQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJr0A3ndFkpLkMrjlmz5V1MccE7tFVjTN1cY36A72VSKCyMqTu6
	x/ohxekcTiIrqz0grDBEGHDEHP5lhy6lFaLAabPPqIKQUOR1V5deDyDw26+1UChzJwE=
X-Gm-Gg: AYBFou31rZnlJWMyVLDHrmrYc4mbEDSZzIsUI2FXWf0Jq+1lA/hssq3JcTH8rgFSdFL
	5MnY8chT/eWdJPbPpApOVTqc2UjaHk3K27vAjNh6VRTXt90ePvWI2rJZIC6bJyGMeEcX+nNShNH
	f9Aj30S5PbWLPqsHjxOvVNuyU20xUwG78fmNc1dH4DvG1NSSeMsSkWqN60dJHop7DVHHnxpDfYl
	/9AouiKIDJKlYm0j7JQMULuaqf7M9ALuRbX1BxpUatnD0NIWkEW26TXof+TrkmDVlcQnqYkSOux
	i+siUbWNc6ej6CLFEJJeajoZQHVkfLU4F5KA9vvUAexYuTvEMC89UX8OFPzQMkeTXERQSA/L2wN
	10bdhrJEB2JxpfNxd0gF67xTcxiZIVO2ht1Ng2GL9MNybyb6kQwddLqaSUgjgDzc/atilW/TPuF
	lWsTwZr27oVKGpOfEqAceTFuIBUfvgMMGHHV6lhj8nJlzdNcfJcJgdH+ZAmrlvpUIVcKX8WFJmJ
	nhW5rY62sylAvtc31CXpCAEfqOj8iKKH516MyyLCO6TloweuB9a2vgJ0d9FlTfmt5EkgobQGUei
	iiK1QqndC5LjeoDv2xDFF5FdOIfQfvbY1JmlauqX7+/CSvYXbbMOUKR9DROeyvZmiGuhXRP05Sw
	MDUreXVufvXFPf9SFHEdZqpUxcjQb69qRYzEAfIi1r+DMQze2wYh1hxbZFSv0uL56NiHUQOCb
X-Received: by 2002:a05:6a00:4b4f:b0:88d:20ff:15c9 with SMTP id d2e1a72fcca58-8a6e7acb277mr1168038b3a.17.1793166741947;
        Tue, 27 Oct 2026 22:52:21 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a6cfc785sm695363b3a.38.2026.10.27.22.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 22:52:21 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:52:18 +0800
From: Chris Down <chris@chrisdown.name>
To: Jeff Xu <jeffxu@google.com>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@kernel.org>, Kees Cook <kees@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>, Andrey Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 1/3] mseal sysmap: Add mseal_system_mappings= boot
 parameter
Message-ID: <auGNkhSHpBRd2U_5@chrisdown.name>
References: <cover.1793094611.git.chris@chrisdown.name>
 <5bd3c89d733ad22224f296dfa8900769de937de0.1793094611.git.chris@chrisdown.name>
 <auCxjbvY3qPv1sV6@gremlin>
 <auDTMb6WMFUpxeZy@chrisdown.name>
 <auDTptDQsB4xBcz7@gremlin>
 <18e2972cb8520c2e.3137322e32382e342e3434.279dd1.0000sendgmr@google.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <18e2972cb8520c2e.3137322e32382e342e3434.279dd1.0000sendgmr@google.com>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

Hi Jeff,

Thanks for the review!

Jeff Xu writes:
>Could we please keep the test coverage for the unsealed [vdso] case and
>avoid unconditionally skipping whenever [vdso] is unsealed?
>
>There are two regressions I'd love for us to still be able to catch:
>
>1. Kernel or config regressions when sealing is expected to be on:

Yeah agreed. With the cleanup it matters even more I think because when sealing 
is set in one place the most likely regression is probably one that unseals 
everything at once.

>2. Regressions in the new `no_mseal_sys_mappings` boot parameter itself:

In v2 I can check /proc/cmdline for no_mseal_sys_mappings to do that.

Lorenzo, I think that also may inform your question about whether checking for 
the disabled case is redundant, right?

>   When booted with `no_mseal_sys_mappings` (or when unsealed), running
>   the assertions in Patch 3 (verifying system mappings have no `sl` flag
>   and that `munmap()` / `mremap()` -- and ideally `mprotect(PROT_READ |
>   PROT_WRITE)` -- on [vdso] succeed) directly verifies that the boot
>   parameter works and doesn't regress.

Sounds good.

>  or keep strict failure as an option (e.g. `./sysmap_is_sealed` fails if
>  unsealed without the boot param, while `run_vmtests.sh` passes a flag
>  like `--allow-disabled` when `CONFIG_MSEAL_SYSTEM_MAPPINGS` may not be
>  enabled), so CI environments that expect sealing still catch a broken
>  seal.

I like this and I think we can do it without adding some of the complexity that 
Lorenzo was not so happy about:

- Have check_sealed skip as usual when [vdso] isn't sealed and param is not set
- A new test, say expect_sealed, fails in the same case
- run_vmtests runs with -T expect_sealed when CONFIG_MSEAL_SYSTEM_MAPPINGS=y

That should be pretty minimal. Lorenzo, Jeff, how does that sound?
