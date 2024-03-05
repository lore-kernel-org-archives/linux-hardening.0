Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085A3548E2
	for <linux-hardening@vger.kernel.org>; Tue,  5 Mar 2024 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633430; cv=none; b=W8/U0566G5G7oy6/fNXG/i3NTa9f8mjN7w5xC8Rw5//BWf2jF6MXiq1rmLA6Kyj4Iw+XjYlx2g/29koE+1q9EiUkhkWMRefXd9xSNR5KYrqE+WZ/IxMPT1Ln16yzAXBLWhNu0ilcqlMBspSwxX4zmVNWCn5tqYqQPpCfreNwdF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633430; c=relaxed/simple;
	bh=edWPsSNhLUgYV01JFEWzJeLACWZPsISNNEUjPT6beEY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q83uPcbKBf9zOiCuJPJwFWCwXPPUF6yJX6KBBupPnSIi2ZLuukCvNSz+2nac6a1m8oDiJd+OWf6tbYes1qcn+W1XtDLaEncB3vknAXwkelBMMdVVgbBWcOFf8iCn8at0LuT0WcNCX2jQeGXK4UDmi1PZ3xf5L+6ly2Ysw9rKiYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JIv+ryrM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JIv+ryrM"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dca3951ad9so52542935ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 05 Mar 2024 02:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709633428; x=1710238228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qzpdpDEJllHVHW238bpdd9oiZXbWj3sBmoX33gVHYPg=;
        b=JIv+ryrMWLpfE02llpYj2oksvSjElgimSP8Md/V8iFNhz+FSl/umKXrz2EfTyhv1+s
         CR4zZ8/TlvWQgi8+7odm0eABT33Py3CUy5pRH7yVpG6k7cLpb/PZys98StKIOaPWchPd
         +zxNsCyf5r4vmh1D8Tf9G4DNuep/bcy6Pc0FE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709633428; x=1710238228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qzpdpDEJllHVHW238bpdd9oiZXbWj3sBmoX33gVHYPg=;
        b=C+ZBUXGEM6AYyO2GyLIGFMZAZXjOLxYnVP2iLaSc/1+6KgukQciqxwk3NNFUuhz+ob
         ZkoPVXPKG3sS3Err3sQLRo7eW3rt47U/DsgwuUjypmJQ48xWoE84MkMbfYqS39T3uvRY
         0ASqlARVum/uyi1slw/52XNK03NyuhOYNtmkiGj+KpQDXuiW3MbYOXAqB/o5ANqnxxxv
         Jk8tWX5EpWTk2dCcaqF6GGyuKtmgDpQx2dTW9oF/rt9zmd7fpInxKlnhhqJ4Zt9V4e9m
         1EijeKd72ATunv0CDNcSD89JYD3EipYYUh33k+DV7CqdFZ4gzsnyHSgJq8bpbX8FZFAe
         3OXw==
X-Forwarded-Encrypted: i=1; AJvYcCXZo0cHDQqbGCm+6/YeYZ15XOUlcSKR7UeAWKfnHtNSj2WDIHlocJIyAWrHuD2g9Gk2tl4JFPWJ8jXCICW0/pUHLu3Q669mllBbWpFSEPV7
X-Gm-Message-State: AOJu0YzWtowPXvdx1q/7CjYwjAh9jCU7spaIcbl+ieFAifle2IpluyJg
	vpKxR0c2kW3CVQEhGOVwe41+Zk5UtTp955ok6Z6jH17CUoufnjLSzOCTWZl71Q==
X-Google-Smtp-Source: AGHT+IEcqbQWha9zMTphyDxsSYTGyjtkP6BMhcrJEIBec5zMiUY2asWhZg5sbtJjMtzOhdLnrw8tqw==
X-Received: by 2002:a17:902:c951:b0:1dc:673:1932 with SMTP id i17-20020a170902c95100b001dc06731932mr1799892pla.38.1709633428204;
        Tue, 05 Mar 2024 02:10:28 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b001dd2b9ed407sm1124556pll.213.2024.03.05.02.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 02:10:27 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>,
	Matteo Rizzo <matteorizzo@google.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/9] slab: Introduce dedicated bucket allocator
Date: Tue,  5 Mar 2024 02:10:16 -0800
Message-Id: <20240305100933.it.923-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3660; i=keescook@chromium.org;
 h=from:subject:message-id; bh=edWPsSNhLUgYV01JFEWzJeLACWZPsISNNEUjPT6beEY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl5u+QN2e7WFyXuymiV+m02giXTmHe/hI5tR0+A
 6PRup3N4OaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZebvkAAKCRCJcvTf3G3A
 Jo14EACeZ3xWd6gW/b5hjqMeZ55W6EyPP6VoUB67J6zJ2PdYd8Gzy9EWRFtQVTdR5Z19nH0w9fD
 mBFL1sDyKQktxuNO36ylzQLo4OCN/I4vYgwsPblfZ5B/MW/inL/WaDQoXo598aporgDtOgmRFLO
 MB4M3LTyYa68aJgD94dQNbcMzn2501HtvR6SBWqNiYm9h2B74D40BNNbMPClXGSuVfmfbg/aCd2
 t2DwUY0YSDIRDK/fvmUc+XAuC2MrktCSvSptBgZKkP5c7iTk+Se1z3Enn4l9UUqvTH5utSiuLDw
 +Bht0qxCTk5l2+LbakA1p2FFCzUnGg2lfIsCwyPr98FhaOw38eFoOluQnPv9Up7pcxW/JUAUYO8
 X5sTPv2Wx5R3ZbGABQ9vf2Ms2iva5WmflzdKvmPm3cOqvzJWn4HRWNfMZGbCrke4ZGvYcfMC7vC
 6v/FsPuSCrN5jYwU5O5IDmBbai5BLiBaydRhA5PO4OF63vKkiGuJNnAjti/vV8XsHU1d7RalfLv
 AwanRdWj9ObRQ8NhB53I5EzVgzPQiirraBFtktNTU10znDXg3hmlG6mi+EVQSY2UtJ8c/+0Yass
 SSWa9u6GFsB4FA/mnLKybDeRqPOvRyOuA13CZJE6xWPhGmpBhq27s70SA9E5mentgD4dh15OReO
 t8rAp2K KqXW0Zxw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

Repeating the commit logs for patch 4 here:

    Dedicated caches are available For fixed size allocations via
    kmem_cache_alloc(), but for dynamically sized allocations there is only
    the global kmalloc API's set of buckets available. This means it isn't
    possible to separate specific sets of dynamically sized allocations into
    a separate collection of caches.

    This leads to a use-after-free exploitation weakness in the Linux
    kernel since many heap memory spraying/grooming attacks depend on using
    userspace-controllable dynamically sized allocations to collide with
    fixed size allocations that end up in same cache.

    While CONFIG_RANDOM_KMALLOC_CACHES provides a probabilistic defense
    against these kinds of "type confusion" attacks, including for fixed
    same-size heap objects, we can create a complementary deterministic
    defense for dynamically sized allocations.

    In order to isolate user-controllable sized allocations from system
    allocations, introduce kmem_buckets_create(), which behaves like
    kmem_cache_create(). (The next patch will introduce kmem_buckets_alloc(),
    which behaves like kmem_cache_alloc().)

    Allows for confining allocations to a dedicated set of sized caches
    (which have the same layout as the kmalloc caches).

    This can also be used in the future once codetag allocation annotations
    exist to implement per-caller allocation cache isolation[0] even for
    dynamic allocations.

    Link: https://lore.kernel.org/lkml/202402211449.401382D2AF@keescook [0]

After the implemetation are 2 example patches of how this could be used
for some repeat "offenders" that get used in exploits. There are more to
be isolated beyond just these. Repeating the commit log for patch 8 here:

    The msg subsystem is a common target for exploiting[1][2][3][4][5][6]
    use-after-free type confusion flaws in the kernel for both read and
    write primitives. Avoid having a user-controlled size cache share the
    global kmalloc allocator by using a separate set of kmalloc buckets.

    Link: https://blog.hacktivesecurity.com/index.php/2022/06/13/linux-kernel-exploit-development-1day-case-study/ [1]
    Link: https://hardenedvault.net/blog/2022-11-13-msg_msg-recon-mitigation-ved/ [2]
    Link: https://www.willsroot.io/2021/08/corctf-2021-fire-of-salvation-writeup.html [3]
    Link: https://a13xp0p0v.github.io/2021/02/09/CVE-2021-26708.html [4]
    Link: https://google.github.io/security-research/pocs/linux/cve-2021-22555/writeup.html [5]
    Link: https://zplin.me/papers/ELOISE.pdf [6]

-Kees

 v2: significant rewrite, generalized the buckets type, added kvmalloc style
 v1: https://lore.kernel.org/lkml/20240304184252.work.496-kees@kernel.org/

Kees Cook (9):
  slab: Introduce kmem_buckets typedef
  slub: Plumb kmem_buckets into __do_kmalloc_node()
  util: Introduce __kvmalloc_node() that can take kmem_buckets argument
  slab: Introduce kmem_buckets_create()
  slab: Introduce kmem_buckets_alloc()
  slub: Introduce kmem_buckets_alloc_track_caller()
  slab: Introduce kmem_buckets_valloc()
  ipc, msg: Use dedicated slab buckets for alloc_msg()
  mm/util: Use dedicated slab buckets for memdup_user()

 include/linux/slab.h | 50 +++++++++++++++++++++-------
 ipc/msgutil.c        | 13 +++++++-
 lib/fortify_kunit.c  |  2 +-
 mm/slab.h            |  6 ++--
 mm/slab_common.c     | 77 ++++++++++++++++++++++++++++++++++++++++++--
 mm/slub.c            | 14 ++++----
 mm/util.c            | 23 +++++++++----
 7 files changed, 154 insertions(+), 31 deletions(-)

-- 
2.34.1
