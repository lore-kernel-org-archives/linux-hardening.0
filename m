Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793086522;
	b=gQSBCR9gFp7eYHQ31GRPrtCYSApAjxiyi/viZx0pYn2jngRyn+SjJQllYDQ6WgwL2tGF
	 gBiEhSj5ij6404IpWjS1eldP/AWn68l6S23VNabqm4HifgK3VwpxXX/vLJrC/6fal28S6
	 Lb5a8/OS5fAlbX9lFydKauBlCbijkWuK4csax+LRkFQQvsr5HEueelWPLRho/pGqkVoVh
	 Blc7l0bJoiPajzyfxbkWOIzhbWmTEDSwgZaD2ML4obmyaHwEE11xQKmcrXjrtk8WjUYjz
	 SrvqjF7Yw3osmBVo7jLFsdKuWpQ89cU1D+39GsrCCQjuGSZW+DOiSX2eCi3djcj3KuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793086522;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:User-Agent;
	bh=/YRCUcykH2kxr7zY9j/CVMJiW+kRaXQLZ0+Ryrw32iA=;
	b=EkiwfT7ntuopZ3QTdxB3oJ8rsrXoofrpdCxeErtFOpVlKP75Mo9SAfE9sTOTjyPlZwJ0
	 Zkc81oGHQH0oYxhpy4QUmoSx5nzWObBXLvYgtOiA3MtKhuZYYZLZg2lbG2I+pk7sKDrgH
	 YmF0/fkTHJNJvdlqID3fePwlgn3qq88apRvZUMLaR3QaU5TG/2TQm/REKukUYTa0dmiQh
	 FNdEH8Iz+vnF3zgEEehB89ZEjzw364cM6TVd6fesBkePfmW5RMY13/gwLYrLaAQnPYxsz
	 xmvhUFMqSA9My6LAsGkWf04YLsnEkuM83AND0IaLQ4yVcqre7SJu85k4iVP2Lfoj/tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=hQ3BW7iQ;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620BA606A31D
	for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 07:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 620BA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=hQ3BW7iQ
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so437466a91.1
        for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 00:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793086522; x=1793691322; darn=vger.kernel.org;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/YRCUcykH2kxr7zY9j/CVMJiW+kRaXQLZ0+Ryrw32iA=;
        b=hQ3BW7iQd8mkpM/jEaec+NBMaV9Y2YMCx3EheNjm/wh8GyjBvzqdrVm8bptMkqM0hK
         TbcBTOs3MebfJiZKcAl0McGiO9X9V6Yc/VbbRKdezCknmyhmNjr6vC2hBDtXPamucFiX
         F3OpNsnTmpuCB80jW+jiIcVYhEwOGo9BUr4uU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793086522; x=1793691322;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/YRCUcykH2kxr7zY9j/CVMJiW+kRaXQLZ0+Ryrw32iA=;
        b=dHtxk8eBmdSi+MpltavrYEaRb6WmOCLw3ztSWZ5qsl7O4+gLpK7pMUxWYotjly9Aie
         CrapOJyEmPlAYvXXbmPqZRxNoo1JAbfUNNcpVI+qlXIYQX4q+DKuo0kwu38iXvNSP7Lg
         DBbyair104mtGD06A5tNFtNQG06U7RCYWd6Zzgbsu19BenAQMsuLJMsvSYAi016DqePt
         AUgDrdby9JINtKZTHv7rig7QexPPqwxoXJOv7ydDcPKIqPPJlqYIpMxdJSJApO3U0gGe
         jrMUOv3fRXp5pPWbpTc+L8IZ0oTzRn9E2BXA6/Kn/wjTWMzP7KVB7YoI0fof3shm5H0M
         XtIA==
X-Forwarded-Encrypted: i=1; AKwUvBxuDT/EkHEUQXO1qvhX8k4lbmLMsxKIkQ83+Ntd7kGwBHqWFKPZGO4ii4LMrIo3C1tapKWPiQ0UBWW0guXizpQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKejK94Pr4/D1n082JAmoj+s92TH1Uq9ciK4hVAd3pVjuT4ATgJ
	5mLtn3lthv+qO/lF7tztIsK7WE+/kF7S+EdQJ/4qTDWnUFtobaNKB6MYlVYhoiFtYPA=
X-Gm-Gg: AYBFou13PoXvNAujf3H7aQ3d67fcFsBZTA/6RTYb+jtGuTaOprAReDBM80qTDNuBdrU
	TYfB7qxfGhlpSNaKeXk8MUFbzihXl+gOdFkcSNYA9Iq6MWqzEZAdEr4dA/vttzQeJdvFzdsjLMD
	dAGbG+QjbLsHmIZbjFxwWKjm7bQJV5kl9gQK21v0V/1HzRrcleboUWDQJih1VrkAPPtkDWw4liQ
	TQTnX/z1wpiS2AvSvHMtbNZJfTdhiNPZYYyObBq6P929eq/2q8ngEsZtuU8pnURMJW1708mUghI
	r39PidhB3JNGIBPQfIfT8XSSTWA2Br4frP9wK8LUjHUHZOZSKROuk32VgeREGFTBJuzVeYsxeHK
	z9Dywek/ANjaDTU9eau/PDE4BUMXndgGBMxd5kHeTAUcwaII/5jwk35etyHS+PWheY8vhDz/leX
	giLvPqQtbTaBGJBhEgH37PclBRAzUriaklrXuxRJyLo6oNiRzpQpSK5Spw4CwccsKAdrKLiJfVp
	4Xxza8bjfTqxDFBIyFlIT7FZW4Q5zJYzR1aLxr3LVCe7fqiW77eAs0qwXjM/UNxmW+/EvdKOb/x
	k1n+xbJ9HrHEbnDNo+4kWgsaR4qQGwwtd0/Q6hmXJvDV73C+vPXKcy5+AVtVc979nD17DuKekR+
	dXDG/JjuhaLlwkB+mbcSrFX3hjgJ+s5BIeqBgbdctPMqj2w==
X-Received: by 2002:a17:90b:35c4:b0:3ad:7f4d:2839 with SMTP id 98e67ed59e1d1-3ae402840cbmr752308a91.14.1793086521251;
        Tue, 27 Oct 2026 00:35:21 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae404429a8sm2527473a91.8.2026.10.27.00.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 00:35:20 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:35:16 +0800
From: Chris Down <chris@chrisdown.name>
To: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>,
	GONG Ruiqi <gongruiqi@huaweicloud.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH 0/8] mm/slab: Support selecting slab hardening features at
 boot
Message-ID: <cover.1793086056.git.chris@chrisdown.name>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

Slab hardening settings are currently all build time choices. This means
that, unfortunately, hosts with different requirements end up needing
separate kernel images. Let's allow those hosts to use one image and
select each policy at boot instead.

This series adds four new boot parameters that default to their values
from CONFIG_*:

  slab_freelist_hardened=
  slab_freelist_random=
  slab_buckets=
  kmalloc_partition=

These mostly act at cache initialisation time. For free list hardening we
use a static key settled before the first free pointer is written.

Chris Down (8):
  mm/slub: Support disabling freelist hardening at boot
  slub_kunit: Add a test for slab_freelist_hardened=
  mm/slub: Support disabling freelist randomisation at boot
  slub_kunit: Add a test for slab_freelist_random=
  mm/slab: Support disabling SLAB_BUCKETS at boot
  slub_kunit: Add a test for the slab_buckets boot parameter
  mm/slab: Support disabling KMALLOC_PARTITION_CACHES at boot
  slub_kunit: Add a test for the kmalloc_partition boot parameter

 .../admin-guide/kernel-parameters.txt         |  29 +++
 lib/tests/slub_kunit.c                        | 186 ++++++++++++++++++
 mm/Kconfig                                    |  15 ++
 mm/slab.h                                     |  24 +++
 mm/slab_common.c                              |  48 ++++-
 mm/slub.c                                     |  68 ++++++-
 scripts/gdb/linux/slab.py                     |   8 +-
 7 files changed, 361 insertions(+), 17 deletions(-)


base-commit: d15d7703166daf7bd62c844a3cb1b3a6279adb4c
-- 
2.54.0

