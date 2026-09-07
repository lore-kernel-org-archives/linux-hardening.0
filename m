Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D009246D087
	for <linux-hardening@vger.kernel.org>; Mon,  7 Sep 2026 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778475; cv=none; b=HzjDV5xbFxEwEluXDUqK70lVPtBiuuRx61lgT2dFvcmOxVJUdZjVbmoT+2S07tBqSwZVpznOvQSjjknYJ1LmOpfSMYh1IA4nMgeYMFS0xjXDwzRzRGLQp/5UUIpK7ePy8OAE9/CWPsOWCbRoWDEe2I1hYMjI48o3mgMZLiovZqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778475; c=relaxed/simple;
	bh=OgQ0Puf/oZmB6zoNdwg1bQoPRzyNKxQ+SWrSGns6mSw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=GergWSTr7Zd1q8zSWiroe8C1iD3E4Lhy4FwgSCXRzQTIHECusKOCPyHfL8CFV2TLCy2wTP9xtScCdNiPD2FevRLQC0LrHzZ8N9UEqy+p9oelWQ+FEhvrEVRdKp8d28Vxu6+yYd41T//Mo09sedlKSWdrQBsygnaOC2NKVd0EydI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHbFXHXN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHbFXHXN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B031F00A3A;
	Mon,  7 Sep 2026 10:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788778473;
	bh=V3C3uRSlXJAvrU8CA+JkknXP4ShUi36cTXYIJp4O8Nc=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=ZHbFXHXNQiOKEVicWGF68AIi3xG2x4I+cHsg8VqPlCzvv+nZFOAz8sbazJ8oBLnFB
	 ML9MVBegMDsk51RXbXu3JMCcuJZb/ohTBVMqsW0habWrf9MSzwxJjEk/IISSR3SM5+
	 wERS3KXe9I+Qam1+E7DPID9Er5aiyYuvlBxrpSI+Zcn1xmDosCkHdzrLvOXN6De63G
	 qPtKHZuyqCKKa8ls2pYhHzjwY+lSjpLLKfwushmouce8WscmOiCFbQECE/0utjH1dc
	 kk45mPSMKCcteX8yeA4ZmqvmVj241Gezp5GV3cX2trb7b17udLgCy++itmSvBAvbLI
	 BI9MJeJODNKhw==
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH RFC v9 11/25] mm: kpkeys: Introduce
 kpkeys_hardened_pgtables feature
From: Mike Rapoport <rppt@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-hardening@vger.kernel.org, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, Jann Horn <jannh@google.com>, 
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>, 
 Kees Cook <kees@kernel.org>, Linu Cherian <linu.cherian@arm.com>, 
 Linus Walleij <linusw@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Mark Brown <broonie@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
 Maxwell Bland <mbland@motorola.com>, 
 "Mike Rapoport (IBM)" <rppt@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Pierre Langlois <pierre.langlois@arm.com>, 
 =?utf-8?q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Quentin Perret <qperret@google.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-mm@kvack.org, x86@kernel.org, Ira Weiny <iweiny@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Thomas Gleixner <tglx@kernel.org>
In-Reply-To: <20260818-kpkeys-v9-11-743ad31b2c8f@arm.com>
References: <20260818-kpkeys-v9-0-743ad31b2c8f@arm.com>
 <20260818-kpkeys-v9-11-743ad31b2c8f@arm.com>
Date: Mon, 07 Sep 2026 13:54:14 +0300
Message-Id: <178877845406.3691569.11239630051799000768.b4-review@b4>
X-Mailer: b4 0.17-dev

Hi Kevin,

> kpkeys_hardened_pgtables is a hardening feature based on kpkeys. It
> aims to prevent the corruption of page tables by: 1. mapping all
> page table pages, both kernel and user, with a privileged pkey
> (KPKEYS_PKEY_PGTABLES), and 2. granting write access to that pkey
> only when running at in a privileged kpkeys context
> (KPKEYS_CTX_PGTABLES). This patch introduces basic infrastructure;
> the implementation of both aspects will follow.
> 
> The feature is exposed as CONFIG_KPKEYS_HARDENED_PGTABLES; it
> requires explicit architecture opt-in by selecting
> ARCH_HAS_KPKEYS_HARDENED_PGTABLES, since much of the page table
> handling is arch-specific.
> 
> Because this feature relies on kpkeys being supported and modifies
> attributes of the linear map, it must be inactive on boot.
> kpkeys_hardened_pgtables_init() enables it by toggling a static key;
> this function must be called by supported architectures in
> mem_init(), before any call to pagetable_alloc() is made.

Presuming other architecures will use kpkeys framework it's better to
call kpkeys_hardened_pgtables_init() from mm_core_init() rather than
stick into each arch's mem_init().

-- 
Sincerely yours,
Mike.

