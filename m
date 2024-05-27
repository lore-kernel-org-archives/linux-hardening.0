Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3A62F2B;
	Mon, 27 May 2024 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716834635; cv=none; b=qlr5e9HDyzcvS/eM7JzsxjCBUVDlXeHiTACKGIWjIx1u3xTLSfesBErMYMjHQOBiIHQekyRb+T6PEBegWUoNN7UqAtodAPVESte0Dqy8IhVI+LuI1lGv1uEr9wggqt3b+pQKXgZAwTneYboeS9fsHyMvFNUFMDXDODLdZYPAkPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716834635; c=relaxed/simple;
	bh=n/jl1VbefEAzErcYJnlG5XeybHW4Thlh68dDG1URZB8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iHy0qAADE9l7j8DvXke9JQ8JdCJVSz0DcloZr5jTM/dMGd9CvnWJdKQ/h840qPGwGyQclLasfqVunO+MY20+WFsuDNhhEayKezG2wwANG1nsFRPTzrhwXGiQPNR5aCGpLMy5RxiD4SbIE6y6oG9vWFH1fzJ1wLy0AENpv+a85Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=nc2E7Seu; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="nc2E7Seu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=YBhOVRVhoG/DBAMiwo0abrKGeUor4OrL/u8Uamp8cks=; b=nc2E7SeuoOoueUM9+W0h5BZf5w
	gh0V5hF5AkRg2DOT15K+WECvOVuuZzCxNpWDhh77dMYLKpTislDxXHoHW2rwWbqcaAuXK1zyuj/34
	xo8CDjNlf2MVr9SzaNeB6/FUIeuYQgRmW1vpVXI0KrKAEP2o6PTk6Fn57RT+oHldPdcapr+BX1gGD
	gVrNNsggvp4OXrnj6d3r48mQ9kZ3Rh/HgH4pbSFHBzrFevkcoTpmh8n0wRsk6Rw8S90mU3c3B7Pj0
	UvX5rPu4DipootuyETFyywRnAzVnG/pSeP77yXh2mvE4KDI/nLnuaxQZgpfkkSKgVfcCM2El8ei8+
	pj7maqQQ==;
Received: from 179-125-79-246-dinamico.pombonet.net.br ([179.125.79.246] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sBf6x-00D4XF-Oh; Mon, 27 May 2024 20:30:20 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH] codetag: avoid race at alloc_slab_obj_exts
Date: Mon, 27 May 2024 15:30:06 -0300
Message-Id: <20240527183007.1595037-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_MEM_ALLOC_PROFILING_DEBUG is enabled, the following warning may
be noticed:

[   48.299584] ------------[ cut here ]------------
[   48.300092] alloc_tag was not set
[   48.300528] WARNING: CPU: 2 PID: 1361 at include/linux/alloc_tag.h:130 alloc_tagging_slab_free_hook+0x84/0xc7
[   48.301305] Modules linked in:
[   48.301553] CPU: 2 PID: 1361 Comm: systemd-udevd Not tainted 6.10.0-rc1-00003-gac8755535862 #176
[   48.302196] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   48.302752] RIP: 0010:alloc_tagging_slab_free_hook+0x84/0xc7
[   48.303169] Code: 8d 1c c4 48 85 db 74 4d 48 83 3b 00 75 1e 80 3d 65 02 86 04 00 75 15 48 c7 c7 11 48 1d 85 c6 05 55 02 86 04 01 e8 64 44 a5 ff <0f> 0b 48 8b 03 48 85 c0 74 21 48 83 f8 01 74 14 48 8b 50 20 48 f7
[   48.304411] RSP: 0018:ffff8880111b7d40 EFLAGS: 00010282
[   48.304916] RAX: 0000000000000000 RBX: ffff88800fcc9008 RCX: 0000000000000000
[   48.305455] RDX: 0000000080000000 RSI: ffff888014060000 RDI: ffffed1002236f97
[   48.305979] RBP: 0000000000001100 R08: fffffbfff0aa73a1 R09: 0000000000000000
[   48.306473] R10: ffffffff814515e5 R11: 0000000000000003 R12: ffff88800fcc9000
[   48.306943] R13: ffff88800b2e5cc0 R14: ffff8880111b7d90 R15: 0000000000000000
[   48.307529] FS:  00007faf5d1908c0(0000) GS:ffff88806cf00000(0000) knlGS:0000000000000000
[   48.308223] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   48.308710] CR2: 000058fb220c9118 CR3: 00000000110cc000 CR4: 0000000000750ef0
[   48.309274] PKRU: 55555554
[   48.309804] Call Trace:
[   48.310029]  <TASK>
[   48.310290]  ? show_regs+0x84/0x8d
[   48.310722]  ? alloc_tagging_slab_free_hook+0x84/0xc7
[   48.311298]  ? __warn+0x13b/0x2ff
[   48.311580]  ? alloc_tagging_slab_free_hook+0x84/0xc7
[   48.311987]  ? report_bug+0x2ce/0x3ab
[   48.312292]  ? handle_bug+0x8c/0x107
[   48.312563]  ? exc_invalid_op+0x34/0x6f
[   48.312842]  ? asm_exc_invalid_op+0x1a/0x20
[   48.313173]  ? this_cpu_in_panic+0x1c/0x72
[   48.313503]  ? alloc_tagging_slab_free_hook+0x84/0xc7
[   48.313880]  ? putname+0x143/0x14e
[   48.314152]  kmem_cache_free+0xe9/0x214
[   48.314454]  putname+0x143/0x14e
[   48.314712]  do_unlinkat+0x413/0x45e
[   48.315001]  ? __pfx_do_unlinkat+0x10/0x10
[   48.315388]  ? __check_object_size+0x4d7/0x525
[   48.315744]  ? __sanitizer_cov_trace_pc+0x20/0x4a
[   48.316167]  ? __sanitizer_cov_trace_pc+0x20/0x4a
[   48.316757]  ? getname_flags+0x4ed/0x500
[   48.317261]  __x64_sys_unlink+0x42/0x4a
[   48.317741]  do_syscall_64+0xe2/0x149
[   48.318171]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   48.318602] RIP: 0033:0x7faf5d8850ab
[   48.318891] Code: fd ff ff e8 27 dd 01 00 0f 1f 80 00 00 00 00 f3 0f 1e fa b8 5f 00 00 00 0f 05 c3 0f 1f 40 00 f3 0f 1e fa b8 57 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 41 2d 0e 00 f7 d8
[   48.320649] RSP: 002b:00007ffc44982b38 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
[   48.321182] RAX: ffffffffffffffda RBX: 00005ba344a44680 RCX: 00007faf5d8850ab
[   48.321667] RDX: 0000000000000000 RSI: 00005ba344a44430 RDI: 00007ffc44982b40
[   48.322139] RBP: 00007ffc44982c00 R08: 0000000000000000 R09: 0000000000000007
[   48.322598] R10: 00005ba344a44430 R11: 0000000000000246 R12: 0000000000000000
[   48.323071] R13: 00007ffc44982b40 R14: 0000000000000000 R15: 0000000000000000
[   48.323596]  </TASK>

This is due to a race when two objects are allocated from the same slab,
which did not have an obj_exts allocated for.

In such a case, the two threads will notice the NULL obj_exts and after one
assigns slab->obj_exts, the second one will happily do the exchange if it
reads this new assigned value.

In order to avoid that, verify that the read obj_exts does not point to an
allocated obj_exts before doing the exchange.

Fixes: 09c46563ff6d ("codetag: debug: introduce OBJEXTS_ALLOC_FAIL to mark failed slab_ext allocations")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Suren Baghdasaryan <surenb@google.com>
---
 mm/slub.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 0809760cf789..1373ac365a46 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1952,7 +1952,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 #ifdef CONFIG_MEMCG
 	new_exts |= MEMCG_DATA_OBJEXTS;
 #endif
-	old_exts = slab->obj_exts;
+	old_exts = READ_ONCE(slab->obj_exts);
 	handle_failed_objexts_alloc(old_exts, vec, objects);
 	if (new_slab) {
 		/*
@@ -1961,7 +1961,8 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 		 * be simply assigned.
 		 */
 		slab->obj_exts = new_exts;
-	} else if (cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts) {
+	} else if ((old_exts & ~OBJEXTS_FLAGS_MASK) ||
+		   cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts) {
 		/*
 		 * If the slab is already in use, somebody can allocate and
 		 * assign slabobj_exts in parallel. In this case the existing
-- 
2.34.1

